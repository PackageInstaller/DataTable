return {
	Play924041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 924041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play924041002(arg_1_1)
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

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 2
			local var_4_37 = 0.775

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(924041001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 31
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play924041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 924041002
		arg_9_1.duration_ = 7

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play924041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "ST01"

			if arg_9_1.bgs_[var_12_0] == nil then
				local var_12_1 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_12_0)
				var_12_1.name = var_12_0
				var_12_1.transform.parent = arg_9_1.stage_.transform
				var_12_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_[var_12_0] = var_12_1
			end

			local var_12_2 = 0

			if var_12_2 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				local var_12_3 = manager.ui.mainCamera.transform.localPosition
				local var_12_4 = Vector3.New(0, 0, 10) + Vector3.New(var_12_3.x, var_12_3.y, 0)
				local var_12_5 = arg_9_1.bgs_.ST01

				var_12_5.transform.localPosition = var_12_4
				var_12_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_6 = var_12_5:GetComponent("SpriteRenderer")

				if var_12_6 and var_12_6.sprite then
					local var_12_7 = (var_12_5.transform.localPosition - var_12_3).z
					local var_12_8 = manager.ui.mainCameraCom_
					local var_12_9 = 2 * var_12_7 * Mathf.Tan(var_12_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_12_10 = var_12_9 * var_12_8.aspect
					local var_12_11 = var_12_6.sprite.bounds.size.x
					local var_12_12 = var_12_6.sprite.bounds.size.y
					local var_12_13 = var_12_10 / var_12_11
					local var_12_14 = var_12_9 / var_12_12
					local var_12_15 = var_12_14 < var_12_13 and var_12_13 or var_12_14

					var_12_5.transform.localScale = Vector3.New(var_12_15, var_12_15, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "ST01" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_16 = 2

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			local var_12_17 = 0.3

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_19 = 2

			if var_12_18 <= arg_9_1.time_ and arg_9_1.time_ < var_12_18 + var_12_19 then
				local var_12_20 = (arg_9_1.time_ - var_12_18) / var_12_19
				local var_12_21 = Color.New(0, 0, 0)

				var_12_21.a = Mathf.Lerp(1, 0, var_12_20)
				arg_9_1.mask_.color = var_12_21
			end

			if arg_9_1.time_ >= var_12_18 + var_12_19 and arg_9_1.time_ < var_12_18 + var_12_19 + arg_12_0 then
				local var_12_22 = Color.New(0, 0, 0)
				local var_12_23 = 0

				arg_9_1.mask_.enabled = false
				var_12_22.a = var_12_23
				arg_9_1.mask_.color = var_12_22
			end

			local var_12_24 = 0.125
			local var_12_25 = 1

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 then
				local var_12_26 = "play"
				local var_12_27 = "effect"

				arg_9_1:AudioAction(var_12_26, var_12_27, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_28 = 2
			local var_12_29 = 0.9

			if var_12_28 < arg_9_1.time_ and arg_9_1.time_ <= var_12_28 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_30 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_30:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_31 = arg_9_1:GetWordFromCfg(924041002)
				local var_12_32 = arg_9_1:FormatText(var_12_31.content)

				arg_9_1.text_.text = var_12_32

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_33 = 36
				local var_12_34 = utf8.len(var_12_32)
				local var_12_35 = var_12_33 <= 0 and var_12_29 or var_12_29 * (var_12_34 / var_12_33)

				if var_12_35 > 0 and var_12_29 < var_12_35 then
					arg_9_1.talkMaxDuration = var_12_35
					var_12_28 = var_12_28 + 0.3

					if var_12_35 + var_12_28 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_35 + var_12_28
					end
				end

				arg_9_1.text_.text = var_12_32
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_36 = var_12_28 + 0.3
			local var_12_37 = math.max(var_12_29, arg_9_1.talkMaxDuration)

			if var_12_36 <= arg_9_1.time_ and arg_9_1.time_ < var_12_36 + var_12_37 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_36) / var_12_37

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_36 + var_12_37 and arg_9_1.time_ < var_12_36 + var_12_37 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play924041003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 924041003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play924041004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.225

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[7].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:GetWordFromCfg(924041003)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 9
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_8 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_8 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_8

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_8 and arg_15_1.time_ < var_18_0 + var_18_8 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play924041004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 924041004
		arg_19_1.duration_ = 3.23

		local var_19_0 = {
			zh = 3.233,
			ja = 3.2
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play924041005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "1020ui_story"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Char/" .. "1020ui_story")

				if not isNil(var_22_1) then
					local var_22_2 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_19_1.stage_.transform)

					var_22_2.name = var_22_0
					var_22_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_19_1.actors_[var_22_0] = var_22_2

					local var_22_3 = var_22_2:GetComponentInChildren(typeof(CharacterEffect))

					var_22_3.enabled = true

					local var_22_4 = GameObjectTools.GetOrAddComponent(var_22_2, typeof(DynamicBoneHelper))

					if var_22_4 then
						var_22_4:EnableDynamicBone(false)
					end

					arg_19_1:ShowWeapon(var_22_3.transform, false)

					arg_19_1.var_[var_22_0 .. "Animator"] = var_22_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_19_1.var_[var_22_0 .. "Animator"].applyRootMotion = true
					arg_19_1.var_[var_22_0 .. "LipSync"] = var_22_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_22_5 = arg_19_1.actors_["1020ui_story"].transform
			local var_22_6 = 0

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.var_.moveOldPos1020ui_story = var_22_5.localPosition
			end

			local var_22_7 = 0.001

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_7 then
				local var_22_8 = (arg_19_1.time_ - var_22_6) / var_22_7
				local var_22_9 = Vector3.New(0, -0.85, -6.25)

				var_22_5.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1020ui_story, var_22_9, var_22_8)

				local var_22_10 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_10.x, var_22_10.y, var_22_10.z)

				local var_22_11 = var_22_5.localEulerAngles

				var_22_11.z = 0
				var_22_11.x = 0
				var_22_5.localEulerAngles = var_22_11
			end

			if arg_19_1.time_ >= var_22_6 + var_22_7 and arg_19_1.time_ < var_22_6 + var_22_7 + arg_22_0 then
				var_22_5.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_22_12 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_12.x, var_22_12.y, var_22_12.z)

				local var_22_13 = var_22_5.localEulerAngles

				var_22_13.z = 0
				var_22_13.x = 0
				var_22_5.localEulerAngles = var_22_13
			end

			local var_22_14 = arg_19_1.actors_["1020ui_story"]
			local var_22_15 = 0

			if var_22_15 < arg_19_1.time_ and arg_19_1.time_ <= var_22_15 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1020ui_story == nil then
				arg_19_1.var_.characterEffect1020ui_story = var_22_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_16 = 0.200000002980232

			if var_22_15 <= arg_19_1.time_ and arg_19_1.time_ < var_22_15 + var_22_16 and not isNil(var_22_14) then
				local var_22_17 = (arg_19_1.time_ - var_22_15) / var_22_16

				if arg_19_1.var_.characterEffect1020ui_story and not isNil(var_22_14) then
					arg_19_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_15 + var_22_16 and arg_19_1.time_ < var_22_15 + var_22_16 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1020ui_story then
				arg_19_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_22_18 = 0

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 then
				arg_19_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_22_19 = 0

			if var_22_19 < arg_19_1.time_ and arg_19_1.time_ <= var_22_19 + arg_22_0 then
				arg_19_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_22_20 = 0
			local var_22_21 = 0.25

			if var_22_20 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_22 = arg_19_1:FormatText(StoryNameCfg[613].name)

				arg_19_1.leftNameTxt_.text = var_22_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_23 = arg_19_1:GetWordFromCfg(924041004)
				local var_22_24 = arg_19_1:FormatText(var_22_23.content)

				arg_19_1.text_.text = var_22_24

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_25 = 10
				local var_22_26 = utf8.len(var_22_24)
				local var_22_27 = var_22_25 <= 0 and var_22_21 or var_22_21 * (var_22_26 / var_22_25)

				if var_22_27 > 0 and var_22_21 < var_22_27 then
					arg_19_1.talkMaxDuration = var_22_27

					if var_22_27 + var_22_20 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_27 + var_22_20
					end
				end

				arg_19_1.text_.text = var_22_24
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb") ~= 0 then
					local var_22_28 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb") / 1000

					if var_22_28 + var_22_20 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_28 + var_22_20
					end

					if var_22_23.prefab_name ~= "" and arg_19_1.actors_[var_22_23.prefab_name] ~= nil then
						local var_22_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_23.prefab_name].transform, "story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb")

						arg_19_1:RecordAudio("924041004", var_22_29)
						arg_19_1:RecordAudio("924041004", var_22_29)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_30 = math.max(var_22_21, arg_19_1.talkMaxDuration)

			if var_22_20 <= arg_19_1.time_ and arg_19_1.time_ < var_22_20 + var_22_30 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_20) / var_22_30

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_20 + var_22_30 and arg_19_1.time_ < var_22_20 + var_22_30 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play924041005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 924041005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play924041006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1020ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1020ui_story == nil then
				arg_23_1.var_.characterEffect1020ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1020ui_story and not isNil(var_26_0) then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1020ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1020ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1020ui_story.fillRatio = var_26_5
			end

			local var_26_6 = 0
			local var_26_7 = 0.15

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_8 = arg_23_1:FormatText(StoryNameCfg[7].name)

				arg_23_1.leftNameTxt_.text = var_26_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_9 = arg_23_1:GetWordFromCfg(924041005)
				local var_26_10 = arg_23_1:FormatText(var_26_9.content)

				arg_23_1.text_.text = var_26_10

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_11 = 6
				local var_26_12 = utf8.len(var_26_10)
				local var_26_13 = var_26_11 <= 0 and var_26_7 or var_26_7 * (var_26_12 / var_26_11)

				if var_26_13 > 0 and var_26_7 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_10
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_14 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_14 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_6) / var_26_14

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_6 + var_26_14 and arg_23_1.time_ < var_26_6 + var_26_14 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play924041006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 924041006
		arg_27_1.duration_ = 8.7

		local var_27_0 = {
			zh = 5.5,
			ja = 8.7
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play924041007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1020ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1020ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(0, -0.85, -6.25)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1020ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["1020ui_story"]
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect1020ui_story == nil then
				arg_27_1.var_.characterEffect1020ui_story = var_30_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_11 = 0.200000002980232

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 and not isNil(var_30_9) then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11

				if arg_27_1.var_.characterEffect1020ui_story and not isNil(var_30_9) then
					arg_27_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 and not isNil(var_30_9) and arg_27_1.var_.characterEffect1020ui_story then
				arg_27_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_30_13 = 0

			if var_30_13 < arg_27_1.time_ and arg_27_1.time_ <= var_30_13 + arg_30_0 then
				arg_27_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action483")
			end

			local var_30_14 = 0
			local var_30_15 = 0.65

			if var_30_14 < arg_27_1.time_ and arg_27_1.time_ <= var_30_14 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_16 = arg_27_1:FormatText(StoryNameCfg[613].name)

				arg_27_1.leftNameTxt_.text = var_30_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_17 = arg_27_1:GetWordFromCfg(924041006)
				local var_30_18 = arg_27_1:FormatText(var_30_17.content)

				arg_27_1.text_.text = var_30_18

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_19 = 26
				local var_30_20 = utf8.len(var_30_18)
				local var_30_21 = var_30_19 <= 0 and var_30_15 or var_30_15 * (var_30_20 / var_30_19)

				if var_30_21 > 0 and var_30_15 < var_30_21 then
					arg_27_1.talkMaxDuration = var_30_21

					if var_30_21 + var_30_14 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_21 + var_30_14
					end
				end

				arg_27_1.text_.text = var_30_18
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb") ~= 0 then
					local var_30_22 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb") / 1000

					if var_30_22 + var_30_14 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_22 + var_30_14
					end

					if var_30_17.prefab_name ~= "" and arg_27_1.actors_[var_30_17.prefab_name] ~= nil then
						local var_30_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_17.prefab_name].transform, "story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb")

						arg_27_1:RecordAudio("924041006", var_30_23)
						arg_27_1:RecordAudio("924041006", var_30_23)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_24 = math.max(var_30_15, arg_27_1.talkMaxDuration)

			if var_30_14 <= arg_27_1.time_ and arg_27_1.time_ < var_30_14 + var_30_24 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_14) / var_30_24

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_14 + var_30_24 and arg_27_1.time_ < var_30_14 + var_30_24 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play924041007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 924041007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play924041008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1020ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1020ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0, 100, 0)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1020ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0, 100, 0)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["1020ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1020ui_story == nil then
				arg_31_1.var_.characterEffect1020ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.200000002980232

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 and not isNil(var_34_9) then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect1020ui_story and not isNil(var_34_9) then
					local var_34_13 = Mathf.Lerp(0, 0.5, var_34_12)

					arg_31_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1020ui_story.fillRatio = var_34_13
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect1020ui_story then
				local var_34_14 = 0.5

				arg_31_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1020ui_story.fillRatio = var_34_14
			end

			local var_34_15 = 0
			local var_34_16 = 0.45

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_17 = arg_31_1:GetWordFromCfg(924041007)
				local var_34_18 = arg_31_1:FormatText(var_34_17.content)

				arg_31_1.text_.text = var_34_18

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_19 = 18
				local var_34_20 = utf8.len(var_34_18)
				local var_34_21 = var_34_19 <= 0 and var_34_16 or var_34_16 * (var_34_20 / var_34_19)

				if var_34_21 > 0 and var_34_16 < var_34_21 then
					arg_31_1.talkMaxDuration = var_34_21

					if var_34_21 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_21 + var_34_15
					end
				end

				arg_31_1.text_.text = var_34_18
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_22 = math.max(var_34_16, arg_31_1.talkMaxDuration)

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_22 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_15) / var_34_22

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_15 + var_34_22 and arg_31_1.time_ < var_34_15 + var_34_22 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play924041008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 924041008
		arg_35_1.duration_ = 3.63

		local var_35_0 = {
			zh = 3.266,
			ja = 3.633
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play924041009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1020ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1020ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0, -0.85, -6.25)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1020ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["1020ui_story"]
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1020ui_story == nil then
				arg_35_1.var_.characterEffect1020ui_story = var_38_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_11 = 0.200000002980232

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 and not isNil(var_38_9) then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11

				if arg_35_1.var_.characterEffect1020ui_story and not isNil(var_38_9) then
					arg_35_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect1020ui_story then
				arg_35_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_38_13 = 0

			if var_38_13 < arg_35_1.time_ and arg_35_1.time_ <= var_38_13 + arg_38_0 then
				arg_35_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_38_14 = 0
			local var_38_15 = 0.275

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_16 = arg_35_1:FormatText(StoryNameCfg[613].name)

				arg_35_1.leftNameTxt_.text = var_38_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_17 = arg_35_1:GetWordFromCfg(924041008)
				local var_38_18 = arg_35_1:FormatText(var_38_17.content)

				arg_35_1.text_.text = var_38_18

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_19 = 11
				local var_38_20 = utf8.len(var_38_18)
				local var_38_21 = var_38_19 <= 0 and var_38_15 or var_38_15 * (var_38_20 / var_38_19)

				if var_38_21 > 0 and var_38_15 < var_38_21 then
					arg_35_1.talkMaxDuration = var_38_21

					if var_38_21 + var_38_14 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_21 + var_38_14
					end
				end

				arg_35_1.text_.text = var_38_18
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb") ~= 0 then
					local var_38_22 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb") / 1000

					if var_38_22 + var_38_14 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_22 + var_38_14
					end

					if var_38_17.prefab_name ~= "" and arg_35_1.actors_[var_38_17.prefab_name] ~= nil then
						local var_38_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_17.prefab_name].transform, "story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb")

						arg_35_1:RecordAudio("924041008", var_38_23)
						arg_35_1:RecordAudio("924041008", var_38_23)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_24 = math.max(var_38_15, arg_35_1.talkMaxDuration)

			if var_38_14 <= arg_35_1.time_ and arg_35_1.time_ < var_38_14 + var_38_24 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_14) / var_38_24

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_14 + var_38_24 and arg_35_1.time_ < var_38_14 + var_38_24 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play924041009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 924041009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play924041010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1020ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1020ui_story == nil then
				arg_39_1.var_.characterEffect1020ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1020ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1020ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1020ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1020ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 0.175

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_8 = arg_39_1:FormatText(StoryNameCfg[7].name)

				arg_39_1.leftNameTxt_.text = var_42_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_9 = arg_39_1:GetWordFromCfg(924041009)
				local var_42_10 = arg_39_1:FormatText(var_42_9.content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 7
				local var_42_12 = utf8.len(var_42_10)
				local var_42_13 = var_42_11 <= 0 and var_42_7 or var_42_7 * (var_42_12 / var_42_11)

				if var_42_13 > 0 and var_42_7 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_14 and arg_39_1.time_ < var_42_6 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play924041010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 924041010
		arg_43_1.duration_ = 4.1

		local var_43_0 = {
			zh = 2.566,
			ja = 4.1
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play924041011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1020ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1020ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, -0.85, -6.25)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1020ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1020ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1020ui_story == nil then
				arg_43_1.var_.characterEffect1020ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect1020ui_story and not isNil(var_46_9) then
					arg_43_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1020ui_story then
				arg_43_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_46_13 = 0

			if var_46_13 < arg_43_1.time_ and arg_43_1.time_ <= var_46_13 + arg_46_0 then
				arg_43_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_46_14 = 0
			local var_46_15 = 0.275

			if var_46_14 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_16 = arg_43_1:FormatText(StoryNameCfg[613].name)

				arg_43_1.leftNameTxt_.text = var_46_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_17 = arg_43_1:GetWordFromCfg(924041010)
				local var_46_18 = arg_43_1:FormatText(var_46_17.content)

				arg_43_1.text_.text = var_46_18

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_19 = 11
				local var_46_20 = utf8.len(var_46_18)
				local var_46_21 = var_46_19 <= 0 and var_46_15 or var_46_15 * (var_46_20 / var_46_19)

				if var_46_21 > 0 and var_46_15 < var_46_21 then
					arg_43_1.talkMaxDuration = var_46_21

					if var_46_21 + var_46_14 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_21 + var_46_14
					end
				end

				arg_43_1.text_.text = var_46_18
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb") ~= 0 then
					local var_46_22 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb") / 1000

					if var_46_22 + var_46_14 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_14
					end

					if var_46_17.prefab_name ~= "" and arg_43_1.actors_[var_46_17.prefab_name] ~= nil then
						local var_46_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_17.prefab_name].transform, "story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb")

						arg_43_1:RecordAudio("924041010", var_46_23)
						arg_43_1:RecordAudio("924041010", var_46_23)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_24 = math.max(var_46_15, arg_43_1.talkMaxDuration)

			if var_46_14 <= arg_43_1.time_ and arg_43_1.time_ < var_46_14 + var_46_24 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_14) / var_46_24

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_14 + var_46_24 and arg_43_1.time_ < var_46_14 + var_46_24 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play924041011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 924041011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play924041012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1020ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1020ui_story == nil then
				arg_47_1.var_.characterEffect1020ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect1020ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1020ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1020ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1020ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0
			local var_50_7 = 0.525

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_8 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_9 = arg_47_1:GetWordFromCfg(924041011)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 21
				local var_50_12 = utf8.len(var_50_10)
				local var_50_13 = var_50_11 <= 0 and var_50_7 or var_50_7 * (var_50_12 / var_50_11)

				if var_50_13 > 0 and var_50_7 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_14 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_14 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_14

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_14 and arg_47_1.time_ < var_50_6 + var_50_14 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play924041012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 924041012
		arg_51_1.duration_ = 14.2

		local var_51_0 = {
			zh = 10.1,
			ja = 14.2
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play924041013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1020ui_story"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos1020ui_story = var_54_0.localPosition
			end

			local var_54_2 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2
				local var_54_4 = Vector3.New(0, -0.85, -6.25)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1020ui_story, var_54_4, var_54_3)

				local var_54_5 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_5.x, var_54_5.y, var_54_5.z)

				local var_54_6 = var_54_0.localEulerAngles

				var_54_6.z = 0
				var_54_6.x = 0
				var_54_0.localEulerAngles = var_54_6
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_54_7 = manager.ui.mainCamera.transform.position - var_54_0.position

				var_54_0.forward = Vector3.New(var_54_7.x, var_54_7.y, var_54_7.z)

				local var_54_8 = var_54_0.localEulerAngles

				var_54_8.z = 0
				var_54_8.x = 0
				var_54_0.localEulerAngles = var_54_8
			end

			local var_54_9 = arg_51_1.actors_["1020ui_story"]
			local var_54_10 = 0

			if var_54_10 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1020ui_story == nil then
				arg_51_1.var_.characterEffect1020ui_story = var_54_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_11 and not isNil(var_54_9) then
				local var_54_12 = (arg_51_1.time_ - var_54_10) / var_54_11

				if arg_51_1.var_.characterEffect1020ui_story and not isNil(var_54_9) then
					arg_51_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_10 + var_54_11 and arg_51_1.time_ < var_54_10 + var_54_11 + arg_54_0 and not isNil(var_54_9) and arg_51_1.var_.characterEffect1020ui_story then
				arg_51_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_54_13 = 0

			if var_54_13 < arg_51_1.time_ and arg_51_1.time_ <= var_54_13 + arg_54_0 then
				arg_51_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_54_14 = 0
			local var_54_15 = 1.125

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_16 = arg_51_1:FormatText(StoryNameCfg[613].name)

				arg_51_1.leftNameTxt_.text = var_54_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_17 = arg_51_1:GetWordFromCfg(924041012)
				local var_54_18 = arg_51_1:FormatText(var_54_17.content)

				arg_51_1.text_.text = var_54_18

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_19 = 45
				local var_54_20 = utf8.len(var_54_18)
				local var_54_21 = var_54_19 <= 0 and var_54_15 or var_54_15 * (var_54_20 / var_54_19)

				if var_54_21 > 0 and var_54_15 < var_54_21 then
					arg_51_1.talkMaxDuration = var_54_21

					if var_54_21 + var_54_14 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_21 + var_54_14
					end
				end

				arg_51_1.text_.text = var_54_18
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb") ~= 0 then
					local var_54_22 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb") / 1000

					if var_54_22 + var_54_14 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_22 + var_54_14
					end

					if var_54_17.prefab_name ~= "" and arg_51_1.actors_[var_54_17.prefab_name] ~= nil then
						local var_54_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_17.prefab_name].transform, "story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb")

						arg_51_1:RecordAudio("924041012", var_54_23)
						arg_51_1:RecordAudio("924041012", var_54_23)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_24 = math.max(var_54_15, arg_51_1.talkMaxDuration)

			if var_54_14 <= arg_51_1.time_ and arg_51_1.time_ < var_54_14 + var_54_24 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_14) / var_54_24

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_14 + var_54_24 and arg_51_1.time_ < var_54_14 + var_54_24 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play924041013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 924041013
		arg_55_1.duration_ = 1

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"

			SetActive(arg_55_1.choicesGo_, true)

			for iter_56_0, iter_56_1 in ipairs(arg_55_1.choices_) do
				local var_56_0 = iter_56_0 <= 1

				SetActive(iter_56_1.go, var_56_0)
			end

			arg_55_1.choices_[1].txt.text = arg_55_1:FormatText(StoryChoiceCfg[1210].name)
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play924041014(arg_55_1)
			end

			arg_55_1:RecordChoiceLog(924041013, 1210)
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1020ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1020ui_story == nil then
				arg_55_1.var_.characterEffect1020ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1020ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1020ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1020ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1020ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			local var_58_7 = 0.6

			if arg_55_1.time_ >= var_58_6 + var_58_7 and arg_55_1.time_ < var_58_6 + var_58_7 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play924041014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 924041014
		arg_59_1.duration_ = 7.53

		local var_59_0 = {
			zh = 5.8,
			ja = 7.533
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
				arg_59_0:Play924041015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1020ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1020ui_story == nil then
				arg_59_1.var_.characterEffect1020ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1020ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1020ui_story then
				arg_59_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_62_4 = 0

			if var_62_4 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action463")
			end

			local var_62_5 = 0

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_62_6 = 0
			local var_62_7 = 0.625

			if var_62_6 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_8 = arg_59_1:FormatText(StoryNameCfg[613].name)

				arg_59_1.leftNameTxt_.text = var_62_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_9 = arg_59_1:GetWordFromCfg(924041014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 25
				local var_62_12 = utf8.len(var_62_10)
				local var_62_13 = var_62_11 <= 0 and var_62_7 or var_62_7 * (var_62_12 / var_62_11)

				if var_62_13 > 0 and var_62_7 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb") / 1000

					if var_62_14 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_6
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb")

						arg_59_1:RecordAudio("924041014", var_62_15)
						arg_59_1:RecordAudio("924041014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_16 and arg_59_1.time_ < var_62_6 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play924041015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 924041015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play924041016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1020ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1020ui_story == nil then
				arg_63_1.var_.characterEffect1020ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1020ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1020ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1020ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1020ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.35

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_9 = arg_63_1:GetWordFromCfg(924041015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 14
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play924041016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 924041016
		arg_67_1.duration_ = 6.1

		local var_67_0 = {
			zh = 3.166,
			ja = 6.1
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play924041017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1020ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1020ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, -0.85, -6.25)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1020ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1020ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1020ui_story == nil then
				arg_67_1.var_.characterEffect1020ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect1020ui_story and not isNil(var_70_9) then
					arg_67_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1020ui_story then
				arg_67_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_70_13 = 0

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_70_14 = 0

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_70_15 = 0
			local var_70_16 = 0.375

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_17 = arg_67_1:FormatText(StoryNameCfg[613].name)

				arg_67_1.leftNameTxt_.text = var_70_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_18 = arg_67_1:GetWordFromCfg(924041016)
				local var_70_19 = arg_67_1:FormatText(var_70_18.content)

				arg_67_1.text_.text = var_70_19

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_20 = 15
				local var_70_21 = utf8.len(var_70_19)
				local var_70_22 = var_70_20 <= 0 and var_70_16 or var_70_16 * (var_70_21 / var_70_20)

				if var_70_22 > 0 and var_70_16 < var_70_22 then
					arg_67_1.talkMaxDuration = var_70_22

					if var_70_22 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_22 + var_70_15
					end
				end

				arg_67_1.text_.text = var_70_19
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb") ~= 0 then
					local var_70_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb") / 1000

					if var_70_23 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_15
					end

					if var_70_18.prefab_name ~= "" and arg_67_1.actors_[var_70_18.prefab_name] ~= nil then
						local var_70_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_18.prefab_name].transform, "story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb")

						arg_67_1:RecordAudio("924041016", var_70_24)
						arg_67_1:RecordAudio("924041016", var_70_24)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_25 = math.max(var_70_16, arg_67_1.talkMaxDuration)

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_25 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_15) / var_70_25

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_15 + var_70_25 and arg_67_1.time_ < var_70_15 + var_70_25 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play924041017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 924041017
		arg_71_1.duration_ = 11.73

		local var_71_0 = {
			zh = 7.5,
			ja = 11.733
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
				arg_71_0:Play924041018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.85

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[613].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(924041017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 34
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb")

						arg_71_1:RecordAudio("924041017", var_74_9)
						arg_71_1:RecordAudio("924041017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play924041018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 924041018
		arg_75_1.duration_ = 6.1

		local var_75_0 = {
			zh = 3.8,
			ja = 6.1
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play924041019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1020ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1020ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, -0.85, -6.25)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1020ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = 0

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_78_11 = 0
			local var_78_12 = 0.3

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_13 = arg_75_1:FormatText(StoryNameCfg[613].name)

				arg_75_1.leftNameTxt_.text = var_78_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_14 = arg_75_1:GetWordFromCfg(924041018)
				local var_78_15 = arg_75_1:FormatText(var_78_14.content)

				arg_75_1.text_.text = var_78_15

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_16 = 12
				local var_78_17 = utf8.len(var_78_15)
				local var_78_18 = var_78_16 <= 0 and var_78_12 or var_78_12 * (var_78_17 / var_78_16)

				if var_78_18 > 0 and var_78_12 < var_78_18 then
					arg_75_1.talkMaxDuration = var_78_18

					if var_78_18 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_18 + var_78_11
					end
				end

				arg_75_1.text_.text = var_78_15
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb") ~= 0 then
					local var_78_19 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb") / 1000

					if var_78_19 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_11
					end

					if var_78_14.prefab_name ~= "" and arg_75_1.actors_[var_78_14.prefab_name] ~= nil then
						local var_78_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_14.prefab_name].transform, "story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb")

						arg_75_1:RecordAudio("924041018", var_78_20)
						arg_75_1:RecordAudio("924041018", var_78_20)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_21 = math.max(var_78_12, arg_75_1.talkMaxDuration)

			if var_78_11 <= arg_75_1.time_ and arg_75_1.time_ < var_78_11 + var_78_21 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_11) / var_78_21

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_11 + var_78_21 and arg_75_1.time_ < var_78_11 + var_78_21 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 924041019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play924041020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1020ui_story"].transform
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1020ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, 100, 0)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1020ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, 100, 0)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1020ui_story"]
			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1020ui_story == nil then
				arg_79_1.var_.characterEffect1020ui_story = var_82_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_11 = 0.200000002980232

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 and not isNil(var_82_9) then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11

				if arg_79_1.var_.characterEffect1020ui_story and not isNil(var_82_9) then
					local var_82_13 = Mathf.Lerp(0, 0.5, var_82_12)

					arg_79_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1020ui_story.fillRatio = var_82_13
				end
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 and not isNil(var_82_9) and arg_79_1.var_.characterEffect1020ui_story then
				local var_82_14 = 0.5

				arg_79_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1020ui_story.fillRatio = var_82_14
			end

			local var_82_15 = 0
			local var_82_16 = 0.725

			if var_82_15 < arg_79_1.time_ and arg_79_1.time_ <= var_82_15 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_17 = arg_79_1:GetWordFromCfg(924041019)
				local var_82_18 = arg_79_1:FormatText(var_82_17.content)

				arg_79_1.text_.text = var_82_18

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_19 = 29
				local var_82_20 = utf8.len(var_82_18)
				local var_82_21 = var_82_19 <= 0 and var_82_16 or var_82_16 * (var_82_20 / var_82_19)

				if var_82_21 > 0 and var_82_16 < var_82_21 then
					arg_79_1.talkMaxDuration = var_82_21

					if var_82_21 + var_82_15 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_21 + var_82_15
					end
				end

				arg_79_1.text_.text = var_82_18
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_22 = math.max(var_82_16, arg_79_1.talkMaxDuration)

			if var_82_15 <= arg_79_1.time_ and arg_79_1.time_ < var_82_15 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_15) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_15 + var_82_22 and arg_79_1.time_ < var_82_15 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 924041020
		arg_83_1.duration_ = 1

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"

			SetActive(arg_83_1.choicesGo_, true)

			for iter_84_0, iter_84_1 in ipairs(arg_83_1.choices_) do
				local var_84_0 = iter_84_0 <= 1

				SetActive(iter_84_1.go, var_84_0)
			end

			arg_83_1.choices_[1].txt.text = arg_83_1:FormatText(StoryChoiceCfg[1211].name)
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play924041021(arg_83_1)
			end

			arg_83_1:RecordChoiceLog(924041020, 1211)
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			return
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play924041021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 924041021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play924041022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.025

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

				local var_90_2 = arg_87_1:GetWordFromCfg(924041021)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 41
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
	Play924041022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 924041022
		arg_91_1.duration_ = 5.3

		local var_91_0 = {
			zh = 5,
			ja = 5.3
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
				arg_91_0:Play924041023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1020ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1020ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, -0.85, -6.25)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1020ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["1020ui_story"]
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1020ui_story == nil then
				arg_91_1.var_.characterEffect1020ui_story = var_94_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 and not isNil(var_94_9) then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11

				if arg_91_1.var_.characterEffect1020ui_story and not isNil(var_94_9) then
					arg_91_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 and not isNil(var_94_9) and arg_91_1.var_.characterEffect1020ui_story then
				arg_91_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_94_13 = 0

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_94_15 = 0
			local var_94_16 = 0.45

			if var_94_15 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_17 = arg_91_1:FormatText(StoryNameCfg[613].name)

				arg_91_1.leftNameTxt_.text = var_94_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_18 = arg_91_1:GetWordFromCfg(924041022)
				local var_94_19 = arg_91_1:FormatText(var_94_18.content)

				arg_91_1.text_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_20 = 18
				local var_94_21 = utf8.len(var_94_19)
				local var_94_22 = var_94_20 <= 0 and var_94_16 or var_94_16 * (var_94_21 / var_94_20)

				if var_94_22 > 0 and var_94_16 < var_94_22 then
					arg_91_1.talkMaxDuration = var_94_22

					if var_94_22 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_22 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_19
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb") ~= 0 then
					local var_94_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb") / 1000

					if var_94_23 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_23 + var_94_15
					end

					if var_94_18.prefab_name ~= "" and arg_91_1.actors_[var_94_18.prefab_name] ~= nil then
						local var_94_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_18.prefab_name].transform, "story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb")

						arg_91_1:RecordAudio("924041022", var_94_24)
						arg_91_1:RecordAudio("924041022", var_94_24)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_25 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_25 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_25

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_25 and arg_91_1.time_ < var_94_15 + var_94_25 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 924041023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play924041024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1020ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1020ui_story == nil then
				arg_95_1.var_.characterEffect1020ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1020ui_story and not isNil(var_98_0) then
					local var_98_4 = Mathf.Lerp(0, 0.5, var_98_3)

					arg_95_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1020ui_story.fillRatio = var_98_4
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1020ui_story then
				local var_98_5 = 0.5

				arg_95_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1020ui_story.fillRatio = var_98_5
			end

			local var_98_6 = 0
			local var_98_7 = 0.475

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_9 = arg_95_1:GetWordFromCfg(924041023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 19
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_14 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_14 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_14

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_14 and arg_95_1.time_ < var_98_6 + var_98_14 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play924041024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 924041024
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play924041025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1020ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1020ui_story == nil then
				arg_99_1.var_.characterEffect1020ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1020ui_story and not isNil(var_102_0) then
					arg_99_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1020ui_story then
				arg_99_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_102_4 = 0

			if var_102_4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			local var_102_5 = 0

			if var_102_5 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_102_6 = 0
			local var_102_7 = 0.075

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_8 = arg_99_1:FormatText(StoryNameCfg[613].name)

				arg_99_1.leftNameTxt_.text = var_102_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_9 = arg_99_1:GetWordFromCfg(924041024)
				local var_102_10 = arg_99_1:FormatText(var_102_9.content)

				arg_99_1.text_.text = var_102_10

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 3
				local var_102_12 = utf8.len(var_102_10)
				local var_102_13 = var_102_11 <= 0 and var_102_7 or var_102_7 * (var_102_12 / var_102_11)

				if var_102_13 > 0 and var_102_7 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_10
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb") ~= 0 then
					local var_102_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb") / 1000

					if var_102_14 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_6
					end

					if var_102_9.prefab_name ~= "" and arg_99_1.actors_[var_102_9.prefab_name] ~= nil then
						local var_102_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_9.prefab_name].transform, "story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb")

						arg_99_1:RecordAudio("924041024", var_102_15)
						arg_99_1:RecordAudio("924041024", var_102_15)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_16 and arg_99_1.time_ < var_102_6 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play924041025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 924041025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play924041026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1020ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1020ui_story == nil then
				arg_103_1.var_.characterEffect1020ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1020ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1020ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1020ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1020ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0
			local var_106_7 = 0.175

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_8 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_9 = arg_103_1:GetWordFromCfg(924041025)
				local var_106_10 = arg_103_1:FormatText(var_106_9.content)

				arg_103_1.text_.text = var_106_10

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_11 = 7
				local var_106_12 = utf8.len(var_106_10)
				local var_106_13 = var_106_11 <= 0 and var_106_7 or var_106_7 * (var_106_12 / var_106_11)

				if var_106_13 > 0 and var_106_7 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_10
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_14 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_14 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_14

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_14 and arg_103_1.time_ < var_106_6 + var_106_14 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play924041026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 924041026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play924041027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.475

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(924041026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 19
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_8 and arg_107_1.time_ < var_110_0 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play924041027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 924041027
		arg_111_1.duration_ = 6.13

		local var_111_0 = {
			zh = 3.8,
			ja = 6.133
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
				arg_111_0:Play924041028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1020ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1020ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0, -0.85, -6.25)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1020ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["1020ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect1020ui_story == nil then
				arg_111_1.var_.characterEffect1020ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 and not isNil(var_114_9) then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect1020ui_story and not isNil(var_114_9) then
					arg_111_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and not isNil(var_114_9) and arg_111_1.var_.characterEffect1020ui_story then
				arg_111_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_114_13 = 0

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_114_15 = 0
			local var_114_16 = 0.275

			if var_114_15 < arg_111_1.time_ and arg_111_1.time_ <= var_114_15 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_17 = arg_111_1:FormatText(StoryNameCfg[613].name)

				arg_111_1.leftNameTxt_.text = var_114_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_18 = arg_111_1:GetWordFromCfg(924041027)
				local var_114_19 = arg_111_1:FormatText(var_114_18.content)

				arg_111_1.text_.text = var_114_19

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_20 = 11
				local var_114_21 = utf8.len(var_114_19)
				local var_114_22 = var_114_20 <= 0 and var_114_16 or var_114_16 * (var_114_21 / var_114_20)

				if var_114_22 > 0 and var_114_16 < var_114_22 then
					arg_111_1.talkMaxDuration = var_114_22

					if var_114_22 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_22 + var_114_15
					end
				end

				arg_111_1.text_.text = var_114_19
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb") ~= 0 then
					local var_114_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb") / 1000

					if var_114_23 + var_114_15 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_23 + var_114_15
					end

					if var_114_18.prefab_name ~= "" and arg_111_1.actors_[var_114_18.prefab_name] ~= nil then
						local var_114_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_18.prefab_name].transform, "story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb")

						arg_111_1:RecordAudio("924041027", var_114_24)
						arg_111_1:RecordAudio("924041027", var_114_24)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_25 = math.max(var_114_16, arg_111_1.talkMaxDuration)

			if var_114_15 <= arg_111_1.time_ and arg_111_1.time_ < var_114_15 + var_114_25 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_15) / var_114_25

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_15 + var_114_25 and arg_111_1.time_ < var_114_15 + var_114_25 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 924041028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play924041029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1020ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos1020ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0, 100, 0)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1020ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, 100, 0)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["1020ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1020ui_story == nil then
				arg_115_1.var_.characterEffect1020ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect1020ui_story and not isNil(var_118_9) then
					local var_118_13 = Mathf.Lerp(0, 0.5, var_118_12)

					arg_115_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1020ui_story.fillRatio = var_118_13
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect1020ui_story then
				local var_118_14 = 0.5

				arg_115_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1020ui_story.fillRatio = var_118_14
			end

			local var_118_15 = 0
			local var_118_16 = 0.775

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_17 = arg_115_1:GetWordFromCfg(924041028)
				local var_118_18 = arg_115_1:FormatText(var_118_17.content)

				arg_115_1.text_.text = var_118_18

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 31
				local var_118_20 = utf8.len(var_118_18)
				local var_118_21 = var_118_19 <= 0 and var_118_16 or var_118_16 * (var_118_20 / var_118_19)

				if var_118_21 > 0 and var_118_16 < var_118_21 then
					arg_115_1.talkMaxDuration = var_118_21

					if var_118_21 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_21 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_18
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_22 and arg_115_1.time_ < var_118_15 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 924041029
		arg_119_1.duration_ = 3.33

		local var_119_0 = {
			zh = 2.9,
			ja = 3.333
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
				arg_119_0:Play924041030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1020ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos1020ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0, -0.85, -6.25)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1020ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["1020ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1020ui_story == nil then
				arg_119_1.var_.characterEffect1020ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect1020ui_story and not isNil(var_122_9) then
					arg_119_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1020ui_story then
				arg_119_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_2")
			end

			local var_122_14 = 0

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 then
				arg_119_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_122_15 = 0
			local var_122_16 = 0.225

			if var_122_15 < arg_119_1.time_ and arg_119_1.time_ <= var_122_15 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_17 = arg_119_1:FormatText(StoryNameCfg[613].name)

				arg_119_1.leftNameTxt_.text = var_122_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_18 = arg_119_1:GetWordFromCfg(924041029)
				local var_122_19 = arg_119_1:FormatText(var_122_18.content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_20 = 9
				local var_122_21 = utf8.len(var_122_19)
				local var_122_22 = var_122_20 <= 0 and var_122_16 or var_122_16 * (var_122_21 / var_122_20)

				if var_122_22 > 0 and var_122_16 < var_122_22 then
					arg_119_1.talkMaxDuration = var_122_22

					if var_122_22 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_15
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb") ~= 0 then
					local var_122_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb") / 1000

					if var_122_23 + var_122_15 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_23 + var_122_15
					end

					if var_122_18.prefab_name ~= "" and arg_119_1.actors_[var_122_18.prefab_name] ~= nil then
						local var_122_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_18.prefab_name].transform, "story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb")

						arg_119_1:RecordAudio("924041029", var_122_24)
						arg_119_1:RecordAudio("924041029", var_122_24)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_25 = math.max(var_122_16, arg_119_1.talkMaxDuration)

			if var_122_15 <= arg_119_1.time_ and arg_119_1.time_ < var_122_15 + var_122_25 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_15) / var_122_25

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_15 + var_122_25 and arg_119_1.time_ < var_122_15 + var_122_25 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play924041030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 924041030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play924041031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1020ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1020ui_story == nil then
				arg_123_1.var_.characterEffect1020ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1020ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1020ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1020ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1020ui_story.fillRatio = var_126_5
			end

			local var_126_6 = 0
			local var_126_7 = 0.6

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_8 = arg_123_1:FormatText(StoryNameCfg[7].name)

				arg_123_1.leftNameTxt_.text = var_126_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_9 = arg_123_1:GetWordFromCfg(924041030)
				local var_126_10 = arg_123_1:FormatText(var_126_9.content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 24
				local var_126_12 = utf8.len(var_126_10)
				local var_126_13 = var_126_11 <= 0 and var_126_7 or var_126_7 * (var_126_12 / var_126_11)

				if var_126_13 > 0 and var_126_7 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play924041031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 924041031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play924041032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.6

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(924041031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 24
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_8 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_8 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_8

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_8 and arg_127_1.time_ < var_130_0 + var_130_8 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play924041032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 924041032
		arg_131_1.duration_ = 2

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play924041033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1020ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1020ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -0.85, -6.25)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1020ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1020ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1020ui_story == nil then
				arg_131_1.var_.characterEffect1020ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1020ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1020ui_story then
				arg_131_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_134_15 = 0
			local var_134_16 = 0.125

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[613].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(924041032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 5
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb")

						arg_131_1:RecordAudio("924041032", var_134_24)
						arg_131_1:RecordAudio("924041032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play924041033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 924041033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play924041034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1020ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1020ui_story == nil then
				arg_135_1.var_.characterEffect1020ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1020ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1020ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1020ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1020ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0
			local var_138_7 = 0.2

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_8 = arg_135_1:FormatText(StoryNameCfg[7].name)

				arg_135_1.leftNameTxt_.text = var_138_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_9 = arg_135_1:GetWordFromCfg(924041033)
				local var_138_10 = arg_135_1:FormatText(var_138_9.content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 8
				local var_138_12 = utf8.len(var_138_10)
				local var_138_13 = var_138_11 <= 0 and var_138_7 or var_138_7 * (var_138_12 / var_138_11)

				if var_138_13 > 0 and var_138_7 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_10
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_14 and arg_135_1.time_ < var_138_6 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play924041034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 924041034
		arg_139_1.duration_ = 12.87

		local var_139_0 = {
			zh = 9.133,
			ja = 12.866
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
				arg_139_0:Play924041035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1020ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1020ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -0.85, -6.25)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1020ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1020ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1020ui_story == nil then
				arg_139_1.var_.characterEffect1020ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1020ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1020ui_story then
				arg_139_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action484")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_142_15 = 0
			local var_142_16 = 0.775

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[613].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(924041034)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 31
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

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb")

						arg_139_1:RecordAudio("924041034", var_142_24)
						arg_139_1:RecordAudio("924041034", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb")
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
				actorName = "1020ui_story",
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
	Play924041035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 924041035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play924041036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1020ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1020ui_story == nil then
				arg_143_1.var_.characterEffect1020ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1020ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1020ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1020ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1020ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.475

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_9 = arg_143_1:GetWordFromCfg(924041035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 19
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play924041036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 924041036
		arg_147_1.duration_ = 4.7

		local var_147_0 = {
			zh = 2.5,
			ja = 4.7
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play924041037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1020ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos1020ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0, -0.85, -6.25)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1020ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["1020ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1020ui_story == nil then
				arg_147_1.var_.characterEffect1020ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect1020ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect1020ui_story then
				arg_147_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action446")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_150_15 = 0
			local var_150_16 = 0.275

			if var_150_15 < arg_147_1.time_ and arg_147_1.time_ <= var_150_15 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_17 = arg_147_1:FormatText(StoryNameCfg[613].name)

				arg_147_1.leftNameTxt_.text = var_150_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_18 = arg_147_1:GetWordFromCfg(924041036)
				local var_150_19 = arg_147_1:FormatText(var_150_18.content)

				arg_147_1.text_.text = var_150_19

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_20 = 11
				local var_150_21 = utf8.len(var_150_19)
				local var_150_22 = var_150_20 <= 0 and var_150_16 or var_150_16 * (var_150_21 / var_150_20)

				if var_150_22 > 0 and var_150_16 < var_150_22 then
					arg_147_1.talkMaxDuration = var_150_22

					if var_150_22 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_22 + var_150_15
					end
				end

				arg_147_1.text_.text = var_150_19
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb") ~= 0 then
					local var_150_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb") / 1000

					if var_150_23 + var_150_15 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_15
					end

					if var_150_18.prefab_name ~= "" and arg_147_1.actors_[var_150_18.prefab_name] ~= nil then
						local var_150_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_18.prefab_name].transform, "story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb")

						arg_147_1:RecordAudio("924041036", var_150_24)
						arg_147_1:RecordAudio("924041036", var_150_24)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_25 = math.max(var_150_16, arg_147_1.talkMaxDuration)

			if var_150_15 <= arg_147_1.time_ and arg_147_1.time_ < var_150_15 + var_150_25 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_15) / var_150_25

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_15 + var_150_25 and arg_147_1.time_ < var_150_15 + var_150_25 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play924041037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 924041037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play924041038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["1020ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1020ui_story == nil then
				arg_151_1.var_.characterEffect1020ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect1020ui_story and not isNil(var_154_0) then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1020ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect1020ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1020ui_story.fillRatio = var_154_5
			end

			local var_154_6 = 0
			local var_154_7 = 0.475

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_8 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_9 = arg_151_1:GetWordFromCfg(924041037)
				local var_154_10 = arg_151_1:FormatText(var_154_9.content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_11 = 19
				local var_154_12 = utf8.len(var_154_10)
				local var_154_13 = var_154_11 <= 0 and var_154_7 or var_154_7 * (var_154_12 / var_154_11)

				if var_154_13 > 0 and var_154_7 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_14 and arg_151_1.time_ < var_154_6 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play924041038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 924041038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play924041039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1020ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1020ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0, 100, 0)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1020ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, 100, 0)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = 0
			local var_158_10 = 0.875

			if var_158_9 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_11 = arg_155_1:GetWordFromCfg(924041038)
				local var_158_12 = arg_155_1:FormatText(var_158_11.content)

				arg_155_1.text_.text = var_158_12

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 35
				local var_158_14 = utf8.len(var_158_12)
				local var_158_15 = var_158_13 <= 0 and var_158_10 or var_158_10 * (var_158_14 / var_158_13)

				if var_158_15 > 0 and var_158_10 < var_158_15 then
					arg_155_1.talkMaxDuration = var_158_15

					if var_158_15 + var_158_9 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_15 + var_158_9
					end
				end

				arg_155_1.text_.text = var_158_12
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_10, arg_155_1.talkMaxDuration)

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_9) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_9 + var_158_16 and arg_155_1.time_ < var_158_9 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play924041039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 924041039
		arg_159_1.duration_ = 2

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play924041040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1020ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1020ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -0.85, -6.25)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1020ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1020ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1020ui_story == nil then
				arg_159_1.var_.characterEffect1020ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1020ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1020ui_story then
				arg_159_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_162_14 = 0
			local var_162_15 = 0.05

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_16 = arg_159_1:FormatText(StoryNameCfg[613].name)

				arg_159_1.leftNameTxt_.text = var_162_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_17 = arg_159_1:GetWordFromCfg(924041039)
				local var_162_18 = arg_159_1:FormatText(var_162_17.content)

				arg_159_1.text_.text = var_162_18

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_19 = 2
				local var_162_20 = utf8.len(var_162_18)
				local var_162_21 = var_162_19 <= 0 and var_162_15 or var_162_15 * (var_162_20 / var_162_19)

				if var_162_21 > 0 and var_162_15 < var_162_21 then
					arg_159_1.talkMaxDuration = var_162_21

					if var_162_21 + var_162_14 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_21 + var_162_14
					end
				end

				arg_159_1.text_.text = var_162_18
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb") ~= 0 then
					local var_162_22 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb") / 1000

					if var_162_22 + var_162_14 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_14
					end

					if var_162_17.prefab_name ~= "" and arg_159_1.actors_[var_162_17.prefab_name] ~= nil then
						local var_162_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_17.prefab_name].transform, "story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb")

						arg_159_1:RecordAudio("924041039", var_162_23)
						arg_159_1:RecordAudio("924041039", var_162_23)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_24 = math.max(var_162_15, arg_159_1.talkMaxDuration)

			if var_162_14 <= arg_159_1.time_ and arg_159_1.time_ < var_162_14 + var_162_24 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_14) / var_162_24

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_14 + var_162_24 and arg_159_1.time_ < var_162_14 + var_162_24 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play924041040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 924041040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play924041041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1020ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1020ui_story == nil then
				arg_163_1.var_.characterEffect1020ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1020ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1020ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1020ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1020ui_story.fillRatio = var_166_5
			end

			local var_166_6 = arg_163_1.actors_["1020ui_story"].transform
			local var_166_7 = 0

			if var_166_7 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 then
				arg_163_1.var_.moveOldPos1020ui_story = var_166_6.localPosition
			end

			local var_166_8 = 0.001

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_8 then
				local var_166_9 = (arg_163_1.time_ - var_166_7) / var_166_8
				local var_166_10 = Vector3.New(0, 100, 0)

				var_166_6.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1020ui_story, var_166_10, var_166_9)

				local var_166_11 = manager.ui.mainCamera.transform.position - var_166_6.position

				var_166_6.forward = Vector3.New(var_166_11.x, var_166_11.y, var_166_11.z)

				local var_166_12 = var_166_6.localEulerAngles

				var_166_12.z = 0
				var_166_12.x = 0
				var_166_6.localEulerAngles = var_166_12
			end

			if arg_163_1.time_ >= var_166_7 + var_166_8 and arg_163_1.time_ < var_166_7 + var_166_8 + arg_166_0 then
				var_166_6.localPosition = Vector3.New(0, 100, 0)

				local var_166_13 = manager.ui.mainCamera.transform.position - var_166_6.position

				var_166_6.forward = Vector3.New(var_166_13.x, var_166_13.y, var_166_13.z)

				local var_166_14 = var_166_6.localEulerAngles

				var_166_14.z = 0
				var_166_14.x = 0
				var_166_6.localEulerAngles = var_166_14
			end

			local var_166_15 = 0
			local var_166_16 = 0.85

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_17 = arg_163_1:GetWordFromCfg(924041040)
				local var_166_18 = arg_163_1:FormatText(var_166_17.content)

				arg_163_1.text_.text = var_166_18

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_19 = 34
				local var_166_20 = utf8.len(var_166_18)
				local var_166_21 = var_166_19 <= 0 and var_166_16 or var_166_16 * (var_166_20 / var_166_19)

				if var_166_21 > 0 and var_166_16 < var_166_21 then
					arg_163_1.talkMaxDuration = var_166_21

					if var_166_21 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_21 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_18
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_22 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_22 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_22

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_22 and arg_163_1.time_ < var_166_15 + var_166_22 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play924041041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 924041041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play924041042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 1.35

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_2 = arg_167_1:GetWordFromCfg(924041041)
				local var_170_3 = arg_167_1:FormatText(var_170_2.content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 54
				local var_170_5 = utf8.len(var_170_3)
				local var_170_6 = var_170_4 <= 0 and var_170_1 or var_170_1 * (var_170_5 / var_170_4)

				if var_170_6 > 0 and var_170_1 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_7 and arg_167_1.time_ < var_170_0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play924041042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 924041042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play924041043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.85

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(924041042)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 34
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play924041043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 924041043
		arg_175_1.duration_ = 1

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"

			SetActive(arg_175_1.choicesGo_, true)

			for iter_176_0, iter_176_1 in ipairs(arg_175_1.choices_) do
				local var_176_0 = iter_176_0 <= 2

				SetActive(iter_176_1.go, var_176_0)
			end

			arg_175_1.choices_[1].txt.text = arg_175_1:FormatText(StoryChoiceCfg[1212].name)
			arg_175_1.choices_[2].txt.text = arg_175_1:FormatText(StoryChoiceCfg[1213].name)
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play924041044(arg_175_1)
			end

			if arg_177_0 == 2 then
				arg_175_0:Play924041044(arg_175_1)
			end

			arg_175_1:RecordChoiceLog(924041043, 1212, 1213)
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			local var_178_1 = 0.6

			if arg_175_1.time_ >= var_178_0 + var_178_1 and arg_175_1.time_ < var_178_0 + var_178_1 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play924041044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 924041044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play924041045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.125
			local var_182_1 = 1

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				local var_182_2 = "play"
				local var_182_3 = "effect"

				arg_179_1:AudioAction(var_182_2, var_182_3, "se_story_141", "se_story_141_foley_handle", "")
			end

			local var_182_4 = 0
			local var_182_5 = 1.15

			if var_182_4 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(924041044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_8 = 46
				local var_182_9 = utf8.len(var_182_7)
				local var_182_10 = var_182_8 <= 0 and var_182_5 or var_182_5 * (var_182_9 / var_182_8)

				if var_182_10 > 0 and var_182_5 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_11 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_11 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_11

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_11 and arg_179_1.time_ < var_182_4 + var_182_11 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play924041045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 924041045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play924041046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.2

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(924041045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 8
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
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play924041046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 924041046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play924041047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 1.125

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(924041046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 45
				local var_190_5 = utf8.len(var_190_3)
				local var_190_6 = var_190_4 <= 0 and var_190_1 or var_190_1 * (var_190_5 / var_190_4)

				if var_190_6 > 0 and var_190_1 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_7 and arg_187_1.time_ < var_190_0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play924041047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 924041047
		arg_191_1.duration_ = 2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play924041048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["1020ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos1020ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0, -0.85, -6.25)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1020ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["1020ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1020ui_story == nil then
				arg_191_1.var_.characterEffect1020ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect1020ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect1020ui_story then
				arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_194_15 = 0
			local var_194_16 = 0.1

			if var_194_15 < arg_191_1.time_ and arg_191_1.time_ <= var_194_15 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_17 = arg_191_1:FormatText(StoryNameCfg[613].name)

				arg_191_1.leftNameTxt_.text = var_194_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_18 = arg_191_1:GetWordFromCfg(924041047)
				local var_194_19 = arg_191_1:FormatText(var_194_18.content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_20 = 4
				local var_194_21 = utf8.len(var_194_19)
				local var_194_22 = var_194_20 <= 0 and var_194_16 or var_194_16 * (var_194_21 / var_194_20)

				if var_194_22 > 0 and var_194_16 < var_194_22 then
					arg_191_1.talkMaxDuration = var_194_22

					if var_194_22 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_22 + var_194_15
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb") ~= 0 then
					local var_194_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb") / 1000

					if var_194_23 + var_194_15 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_23 + var_194_15
					end

					if var_194_18.prefab_name ~= "" and arg_191_1.actors_[var_194_18.prefab_name] ~= nil then
						local var_194_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_18.prefab_name].transform, "story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb")

						arg_191_1:RecordAudio("924041047", var_194_24)
						arg_191_1:RecordAudio("924041047", var_194_24)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_25 = math.max(var_194_16, arg_191_1.talkMaxDuration)

			if var_194_15 <= arg_191_1.time_ and arg_191_1.time_ < var_194_15 + var_194_25 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_15) / var_194_25

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_15 + var_194_25 and arg_191_1.time_ < var_194_15 + var_194_25 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play924041048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 924041048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play924041049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1020ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1020ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, 100, 0)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1020ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, 100, 0)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["1020ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1020ui_story == nil then
				arg_195_1.var_.characterEffect1020ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect1020ui_story and not isNil(var_198_9) then
					local var_198_13 = Mathf.Lerp(0, 0.5, var_198_12)

					arg_195_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1020ui_story.fillRatio = var_198_13
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1020ui_story then
				local var_198_14 = 0.5

				arg_195_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1020ui_story.fillRatio = var_198_14
			end

			local var_198_15 = 0.034000001847744
			local var_198_16 = 1

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				local var_198_17 = "play"
				local var_198_18 = "effect"

				arg_195_1:AudioAction(var_198_17, var_198_18, "se_story_141", "se_story_141_win", "")
			end

			local var_198_19 = 0
			local var_198_20 = 0.875

			if var_198_19 < arg_195_1.time_ and arg_195_1.time_ <= var_198_19 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_21 = arg_195_1:GetWordFromCfg(924041048)
				local var_198_22 = arg_195_1:FormatText(var_198_21.content)

				arg_195_1.text_.text = var_198_22

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_23 = 35
				local var_198_24 = utf8.len(var_198_22)
				local var_198_25 = var_198_23 <= 0 and var_198_20 or var_198_20 * (var_198_24 / var_198_23)

				if var_198_25 > 0 and var_198_20 < var_198_25 then
					arg_195_1.talkMaxDuration = var_198_25

					if var_198_25 + var_198_19 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_25 + var_198_19
					end
				end

				arg_195_1.text_.text = var_198_22
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_26 = math.max(var_198_20, arg_195_1.talkMaxDuration)

			if var_198_19 <= arg_195_1.time_ and arg_195_1.time_ < var_198_19 + var_198_26 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_19) / var_198_26

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_19 + var_198_26 and arg_195_1.time_ < var_198_19 + var_198_26 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 924041049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play924041050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.475

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(924041049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 19
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
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_8 and arg_199_1.time_ < var_202_0 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play924041050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 924041050
		arg_203_1.duration_ = 3.33

		local var_203_0 = {
			zh = 3.2,
			ja = 3.333
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
				arg_203_0:Play924041051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1020ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1020ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, -0.85, -6.25)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1020ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1020ui_story"]
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1020ui_story == nil then
				arg_203_1.var_.characterEffect1020ui_story = var_206_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 and not isNil(var_206_9) then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11

				if arg_203_1.var_.characterEffect1020ui_story and not isNil(var_206_9) then
					arg_203_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 and not isNil(var_206_9) and arg_203_1.var_.characterEffect1020ui_story then
				arg_203_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_206_13 = 0

			if var_206_13 < arg_203_1.time_ and arg_203_1.time_ <= var_206_13 + arg_206_0 then
				arg_203_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action4311")
			end

			local var_206_14 = 0

			if var_206_14 < arg_203_1.time_ and arg_203_1.time_ <= var_206_14 + arg_206_0 then
				arg_203_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_206_15 = 0
			local var_206_16 = 0.3

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_17 = arg_203_1:FormatText(StoryNameCfg[613].name)

				arg_203_1.leftNameTxt_.text = var_206_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_18 = arg_203_1:GetWordFromCfg(924041050)
				local var_206_19 = arg_203_1:FormatText(var_206_18.content)

				arg_203_1.text_.text = var_206_19

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_20 = 12
				local var_206_21 = utf8.len(var_206_19)
				local var_206_22 = var_206_20 <= 0 and var_206_16 or var_206_16 * (var_206_21 / var_206_20)

				if var_206_22 > 0 and var_206_16 < var_206_22 then
					arg_203_1.talkMaxDuration = var_206_22

					if var_206_22 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_22 + var_206_15
					end
				end

				arg_203_1.text_.text = var_206_19
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb") ~= 0 then
					local var_206_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb") / 1000

					if var_206_23 + var_206_15 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_23 + var_206_15
					end

					if var_206_18.prefab_name ~= "" and arg_203_1.actors_[var_206_18.prefab_name] ~= nil then
						local var_206_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_18.prefab_name].transform, "story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb")

						arg_203_1:RecordAudio("924041050", var_206_24)
						arg_203_1:RecordAudio("924041050", var_206_24)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_25 = math.max(var_206_16, arg_203_1.talkMaxDuration)

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_25 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_15) / var_206_25

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_15 + var_206_25 and arg_203_1.time_ < var_206_15 + var_206_25 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 924041051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play924041052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1020ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1020ui_story == nil then
				arg_207_1.var_.characterEffect1020ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect1020ui_story and not isNil(var_210_0) then
					local var_210_4 = Mathf.Lerp(0, 0.5, var_210_3)

					arg_207_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1020ui_story.fillRatio = var_210_4
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1020ui_story then
				local var_210_5 = 0.5

				arg_207_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1020ui_story.fillRatio = var_210_5
			end

			local var_210_6 = 0
			local var_210_7 = 0.475

			if var_210_6 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_8 = arg_207_1:FormatText(StoryNameCfg[7].name)

				arg_207_1.leftNameTxt_.text = var_210_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_9 = arg_207_1:GetWordFromCfg(924041051)
				local var_210_10 = arg_207_1:FormatText(var_210_9.content)

				arg_207_1.text_.text = var_210_10

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 19
				local var_210_12 = utf8.len(var_210_10)
				local var_210_13 = var_210_11 <= 0 and var_210_7 or var_210_7 * (var_210_12 / var_210_11)

				if var_210_13 > 0 and var_210_7 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_10
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play924041052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 924041052
		arg_211_1.duration_ = 7.8

		local var_211_0 = {
			zh = 6.1,
			ja = 7.8
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
				arg_211_0:Play924041053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1020ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1020ui_story == nil then
				arg_211_1.var_.characterEffect1020ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1020ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1020ui_story then
				arg_211_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_214_4 = 0

			if var_214_4 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_214_5 = 0
			local var_214_6 = 0.675

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_7 = arg_211_1:FormatText(StoryNameCfg[613].name)

				arg_211_1.leftNameTxt_.text = var_214_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:GetWordFromCfg(924041052)
				local var_214_9 = arg_211_1:FormatText(var_214_8.content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 27
				local var_214_11 = utf8.len(var_214_9)
				local var_214_12 = var_214_10 <= 0 and var_214_6 or var_214_6 * (var_214_11 / var_214_10)

				if var_214_12 > 0 and var_214_6 < var_214_12 then
					arg_211_1.talkMaxDuration = var_214_12

					if var_214_12 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb") ~= 0 then
					local var_214_13 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb") / 1000

					if var_214_13 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_5
					end

					if var_214_8.prefab_name ~= "" and arg_211_1.actors_[var_214_8.prefab_name] ~= nil then
						local var_214_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_8.prefab_name].transform, "story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb")

						arg_211_1:RecordAudio("924041052", var_214_14)
						arg_211_1:RecordAudio("924041052", var_214_14)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_15 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_15 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_15

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_15 and arg_211_1.time_ < var_214_5 + var_214_15 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play924041053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 924041053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play924041054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1020ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1020ui_story == nil then
				arg_215_1.var_.characterEffect1020ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1020ui_story and not isNil(var_218_0) then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1020ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1020ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1020ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 0.5

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[7].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_9 = arg_215_1:GetWordFromCfg(924041053)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 20
				local var_218_12 = utf8.len(var_218_10)
				local var_218_13 = var_218_11 <= 0 and var_218_7 or var_218_7 * (var_218_12 / var_218_11)

				if var_218_13 > 0 and var_218_7 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_10
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play924041054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 924041054
		arg_219_1.duration_ = 5.9

		local var_219_0 = {
			zh = 5.9,
			ja = 4.666
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
				arg_219_0:Play924041055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1020ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1020ui_story == nil then
				arg_219_1.var_.characterEffect1020ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1020ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1020ui_story then
				arg_219_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_222_4 = 0

			if var_222_4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_222_5 = 0
			local var_222_6 = 0.525

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_7 = arg_219_1:FormatText(StoryNameCfg[613].name)

				arg_219_1.leftNameTxt_.text = var_222_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(924041054)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_10 = 21
				local var_222_11 = utf8.len(var_222_9)
				local var_222_12 = var_222_10 <= 0 and var_222_6 or var_222_6 * (var_222_11 / var_222_10)

				if var_222_12 > 0 and var_222_6 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12

					if var_222_12 + var_222_5 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_5
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb") ~= 0 then
					local var_222_13 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb") / 1000

					if var_222_13 + var_222_5 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_5
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb")

						arg_219_1:RecordAudio("924041054", var_222_14)
						arg_219_1:RecordAudio("924041054", var_222_14)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_15 = math.max(var_222_6, arg_219_1.talkMaxDuration)

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_15 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_5) / var_222_15

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_5 + var_222_15 and arg_219_1.time_ < var_222_5 + var_222_15 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play924041055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 924041055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play924041056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1020ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos1020ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0, 100, 0)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1020ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, 100, 0)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["1020ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1020ui_story == nil then
				arg_223_1.var_.characterEffect1020ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect1020ui_story and not isNil(var_226_9) then
					local var_226_13 = Mathf.Lerp(0, 0.5, var_226_12)

					arg_223_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1020ui_story.fillRatio = var_226_13
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect1020ui_story then
				local var_226_14 = 0.5

				arg_223_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1020ui_story.fillRatio = var_226_14
			end

			local var_226_15 = 0
			local var_226_16 = 0.975

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_17 = arg_223_1:GetWordFromCfg(924041055)
				local var_226_18 = arg_223_1:FormatText(var_226_17.content)

				arg_223_1.text_.text = var_226_18

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_19 = 39
				local var_226_20 = utf8.len(var_226_18)
				local var_226_21 = var_226_19 <= 0 and var_226_16 or var_226_16 * (var_226_20 / var_226_19)

				if var_226_21 > 0 and var_226_16 < var_226_21 then
					arg_223_1.talkMaxDuration = var_226_21

					if var_226_21 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_21 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_18
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_22 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_22 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_22

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_22 and arg_223_1.time_ < var_226_15 + var_226_22 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play924041056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 924041056
		arg_227_1.duration_ = 3.83

		local var_227_0 = {
			zh = 1.9,
			ja = 3.833
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play924041057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.225

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[613].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:GetWordFromCfg(924041056)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 9
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb")

						arg_227_1:RecordAudio("924041056", var_230_9)
						arg_227_1:RecordAudio("924041056", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play924041057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 924041057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play924041058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1020ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1020ui_story == nil then
				arg_231_1.var_.characterEffect1020ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1020ui_story and not isNil(var_234_0) then
					local var_234_4 = Mathf.Lerp(0, 0.5, var_234_3)

					arg_231_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1020ui_story.fillRatio = var_234_4
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1020ui_story then
				local var_234_5 = 0.5

				arg_231_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1020ui_story.fillRatio = var_234_5
			end

			local var_234_6 = 0
			local var_234_7 = 0.05

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_8 = arg_231_1:FormatText(StoryNameCfg[7].name)

				arg_231_1.leftNameTxt_.text = var_234_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_9 = arg_231_1:GetWordFromCfg(924041057)
				local var_234_10 = arg_231_1:FormatText(var_234_9.content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 2
				local var_234_12 = utf8.len(var_234_10)
				local var_234_13 = var_234_11 <= 0 and var_234_7 or var_234_7 * (var_234_12 / var_234_11)

				if var_234_13 > 0 and var_234_7 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_10
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_14 and arg_231_1.time_ < var_234_6 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play924041058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 924041058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play924041059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1020ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1020ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0, 100, 0)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1020ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, 100, 0)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = 0
			local var_238_10 = 0.65

			if var_238_9 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_11 = arg_235_1:GetWordFromCfg(924041058)
				local var_238_12 = arg_235_1:FormatText(var_238_11.content)

				arg_235_1.text_.text = var_238_12

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 26
				local var_238_14 = utf8.len(var_238_12)
				local var_238_15 = var_238_13 <= 0 and var_238_10 or var_238_10 * (var_238_14 / var_238_13)

				if var_238_15 > 0 and var_238_10 < var_238_15 then
					arg_235_1.talkMaxDuration = var_238_15

					if var_238_15 + var_238_9 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_9
					end
				end

				arg_235_1.text_.text = var_238_12
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_10, arg_235_1.talkMaxDuration)

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_9) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_9 + var_238_16 and arg_235_1.time_ < var_238_9 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 924041059
		arg_239_1.duration_ = 3.13

		local var_239_0 = {
			zh = 1.999999999999,
			ja = 3.133
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
				arg_239_0:Play924041060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1020ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1020ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0, -0.85, -6.25)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1020ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -0.85, -6.25)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1020ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1020ui_story == nil then
				arg_239_1.var_.characterEffect1020ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1020ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1020ui_story then
				arg_239_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_242_14 = 0

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_242_15 = 0
			local var_242_16 = 0.25

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[613].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(924041059)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 10
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb")

						arg_239_1:RecordAudio("924041059", var_242_24)
						arg_239_1:RecordAudio("924041059", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play924041060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 924041060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play924041061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1020ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1020ui_story == nil then
				arg_243_1.var_.characterEffect1020ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1020ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1020ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1020ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1020ui_story.fillRatio = var_246_5
			end

			local var_246_6 = 0
			local var_246_7 = 0.275

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_8 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_9 = arg_243_1:GetWordFromCfg(924041060)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 11
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_7 or var_246_7 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_7 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_14 and arg_243_1.time_ < var_246_6 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play924041061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 924041061
		arg_247_1.duration_ = 8.5

		local var_247_0 = {
			zh = 6.533,
			ja = 8.5
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
				arg_247_0:Play924041062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1020ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1020ui_story == nil then
				arg_247_1.var_.characterEffect1020ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1020ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1020ui_story then
				arg_247_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_250_4 = 0

			if var_250_4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_250_6 = 0
			local var_250_7 = 0.65

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_8 = arg_247_1:FormatText(StoryNameCfg[613].name)

				arg_247_1.leftNameTxt_.text = var_250_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_9 = arg_247_1:GetWordFromCfg(924041061)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 26
				local var_250_12 = utf8.len(var_250_10)
				local var_250_13 = var_250_11 <= 0 and var_250_7 or var_250_7 * (var_250_12 / var_250_11)

				if var_250_13 > 0 and var_250_7 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb") / 1000

					if var_250_14 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_6
					end

					if var_250_9.prefab_name ~= "" and arg_247_1.actors_[var_250_9.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_9.prefab_name].transform, "story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb")

						arg_247_1:RecordAudio("924041061", var_250_15)
						arg_247_1:RecordAudio("924041061", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_16 and arg_247_1.time_ < var_250_6 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play924041062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 924041062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play924041063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1020ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1020ui_story == nil then
				arg_251_1.var_.characterEffect1020ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1020ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1020ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1020ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1020ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.6

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(924041062)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 24
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play924041063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 924041063
		arg_255_1.duration_ = 9.3

		local var_255_0 = {
			zh = 5.8,
			ja = 9.3
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play924041064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1020ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1020ui_story == nil then
				arg_255_1.var_.characterEffect1020ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1020ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1020ui_story then
				arg_255_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_258_4 = 0

			if var_258_4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action426")
			end

			local var_258_5 = 0

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_258_6 = 0
			local var_258_7 = 0.525

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_8 = arg_255_1:FormatText(StoryNameCfg[613].name)

				arg_255_1.leftNameTxt_.text = var_258_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_9 = arg_255_1:GetWordFromCfg(924041063)
				local var_258_10 = arg_255_1:FormatText(var_258_9.content)

				arg_255_1.text_.text = var_258_10

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 21
				local var_258_12 = utf8.len(var_258_10)
				local var_258_13 = var_258_11 <= 0 and var_258_7 or var_258_7 * (var_258_12 / var_258_11)

				if var_258_13 > 0 and var_258_7 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_10
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb") / 1000

					if var_258_14 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_6
					end

					if var_258_9.prefab_name ~= "" and arg_255_1.actors_[var_258_9.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_9.prefab_name].transform, "story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb")

						arg_255_1:RecordAudio("924041063", var_258_15)
						arg_255_1:RecordAudio("924041063", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_16 and arg_255_1.time_ < var_258_6 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play924041064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 924041064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play924041065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1020ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1020ui_story == nil then
				arg_259_1.var_.characterEffect1020ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1020ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1020ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1020ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1020ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.325

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_9 = arg_259_1:GetWordFromCfg(924041064)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 13
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play924041065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 924041065
		arg_263_1.duration_ = 8.98

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play924041066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 2

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				local var_266_1 = manager.ui.mainCamera.transform.localPosition
				local var_266_2 = Vector3.New(0, 0, 10) + Vector3.New(var_266_1.x, var_266_1.y, 0)
				local var_266_3 = arg_263_1.bgs_.STblack

				var_266_3.transform.localPosition = var_266_2
				var_266_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_4 = var_266_3:GetComponent("SpriteRenderer")

				if var_266_4 and var_266_4.sprite then
					local var_266_5 = (var_266_3.transform.localPosition - var_266_1).z
					local var_266_6 = manager.ui.mainCameraCom_
					local var_266_7 = 2 * var_266_5 * Mathf.Tan(var_266_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_266_8 = var_266_7 * var_266_6.aspect
					local var_266_9 = var_266_4.sprite.bounds.size.x
					local var_266_10 = var_266_4.sprite.bounds.size.y
					local var_266_11 = var_266_8 / var_266_9
					local var_266_12 = var_266_7 / var_266_10
					local var_266_13 = var_266_12 < var_266_11 and var_266_11 or var_266_12

					var_266_3.transform.localScale = Vector3.New(var_266_13, var_266_13, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "STblack" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_14 = 3.98343144403771

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			local var_266_15 = 0.3

			if arg_263_1.time_ >= var_266_14 + var_266_15 and arg_263_1.time_ < var_266_14 + var_266_15 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_16 = 0

			if var_266_16 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_17 = 2

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_17 then
				local var_266_18 = (arg_263_1.time_ - var_266_16) / var_266_17
				local var_266_19 = Color.New(0, 0, 0)

				var_266_19.a = Mathf.Lerp(0, 1, var_266_18)
				arg_263_1.mask_.color = var_266_19
			end

			if arg_263_1.time_ >= var_266_16 + var_266_17 and arg_263_1.time_ < var_266_16 + var_266_17 + arg_266_0 then
				local var_266_20 = Color.New(0, 0, 0)

				var_266_20.a = 1
				arg_263_1.mask_.color = var_266_20
			end

			local var_266_21 = 2

			if var_266_21 < arg_263_1.time_ and arg_263_1.time_ <= var_266_21 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_22 = 2

			if var_266_21 <= arg_263_1.time_ and arg_263_1.time_ < var_266_21 + var_266_22 then
				local var_266_23 = (arg_263_1.time_ - var_266_21) / var_266_22
				local var_266_24 = Color.New(0, 0, 0)

				var_266_24.a = Mathf.Lerp(1, 0, var_266_23)
				arg_263_1.mask_.color = var_266_24
			end

			if arg_263_1.time_ >= var_266_21 + var_266_22 and arg_263_1.time_ < var_266_21 + var_266_22 + arg_266_0 then
				local var_266_25 = Color.New(0, 0, 0)
				local var_266_26 = 0

				arg_263_1.mask_.enabled = false
				var_266_25.a = var_266_26
				arg_263_1.mask_.color = var_266_25
			end

			local var_266_27 = arg_263_1.actors_["1020ui_story"].transform
			local var_266_28 = 1.96599999815226

			if var_266_28 < arg_263_1.time_ and arg_263_1.time_ <= var_266_28 + arg_266_0 then
				arg_263_1.var_.moveOldPos1020ui_story = var_266_27.localPosition
			end

			local var_266_29 = 0.001

			if var_266_28 <= arg_263_1.time_ and arg_263_1.time_ < var_266_28 + var_266_29 then
				local var_266_30 = (arg_263_1.time_ - var_266_28) / var_266_29
				local var_266_31 = Vector3.New(0, 100, 0)

				var_266_27.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1020ui_story, var_266_31, var_266_30)

				local var_266_32 = manager.ui.mainCamera.transform.position - var_266_27.position

				var_266_27.forward = Vector3.New(var_266_32.x, var_266_32.y, var_266_32.z)

				local var_266_33 = var_266_27.localEulerAngles

				var_266_33.z = 0
				var_266_33.x = 0
				var_266_27.localEulerAngles = var_266_33
			end

			if arg_263_1.time_ >= var_266_28 + var_266_29 and arg_263_1.time_ < var_266_28 + var_266_29 + arg_266_0 then
				var_266_27.localPosition = Vector3.New(0, 100, 0)

				local var_266_34 = manager.ui.mainCamera.transform.position - var_266_27.position

				var_266_27.forward = Vector3.New(var_266_34.x, var_266_34.y, var_266_34.z)

				local var_266_35 = var_266_27.localEulerAngles

				var_266_35.z = 0
				var_266_35.x = 0
				var_266_27.localEulerAngles = var_266_35
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_36 = 3.98343144403771
			local var_266_37 = 1.35

			if var_266_36 < arg_263_1.time_ and arg_263_1.time_ <= var_266_36 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_38 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_38:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_39 = arg_263_1:GetWordFromCfg(924041065)
				local var_266_40 = arg_263_1:FormatText(var_266_39.content)

				arg_263_1.text_.text = var_266_40

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_41 = 54
				local var_266_42 = utf8.len(var_266_40)
				local var_266_43 = var_266_41 <= 0 and var_266_37 or var_266_37 * (var_266_42 / var_266_41)

				if var_266_43 > 0 and var_266_37 < var_266_43 then
					arg_263_1.talkMaxDuration = var_266_43
					var_266_36 = var_266_36 + 0.3

					if var_266_43 + var_266_36 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_43 + var_266_36
					end
				end

				arg_263_1.text_.text = var_266_40
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_44 = var_266_36 + 0.3
			local var_266_45 = math.max(var_266_37, arg_263_1.talkMaxDuration)

			if var_266_44 <= arg_263_1.time_ and arg_263_1.time_ < var_266_44 + var_266_45 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_44) / var_266_45

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_44 + var_266_45 and arg_263_1.time_ < var_266_44 + var_266_45 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play924041066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 924041066
		arg_269_1.duration_ = 5.18

		local var_269_0 = {
			zh = 4.741,
			ja = 5.175
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play924041067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = "X204_g"

			if arg_269_1.bgs_[var_272_0] == nil then
				local var_272_1 = Object.Instantiate(arg_269_1.paintGo_)

				var_272_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_272_0)
				var_272_1.name = var_272_0
				var_272_1.transform.parent = arg_269_1.stage_.transform
				var_272_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.bgs_[var_272_0] = var_272_1
			end

			local var_272_2 = 0

			if var_272_2 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				local var_272_3 = manager.ui.mainCamera.transform.localPosition
				local var_272_4 = Vector3.New(0, 0, 10) + Vector3.New(var_272_3.x, var_272_3.y, 0)
				local var_272_5 = arg_269_1.bgs_.X204_g

				var_272_5.transform.localPosition = var_272_4
				var_272_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_6 = var_272_5:GetComponent("SpriteRenderer")

				if var_272_6 and var_272_6.sprite then
					local var_272_7 = (var_272_5.transform.localPosition - var_272_3).z
					local var_272_8 = manager.ui.mainCameraCom_
					local var_272_9 = 2 * var_272_7 * Mathf.Tan(var_272_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_272_10 = var_272_9 * var_272_8.aspect
					local var_272_11 = var_272_6.sprite.bounds.size.x
					local var_272_12 = var_272_6.sprite.bounds.size.y
					local var_272_13 = var_272_10 / var_272_11
					local var_272_14 = var_272_9 / var_272_12
					local var_272_15 = var_272_14 < var_272_13 and var_272_13 or var_272_14

					var_272_5.transform.localScale = Vector3.New(var_272_15, var_272_15, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "X204_g" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_272_16 = 2

			if var_272_16 < arg_269_1.time_ and arg_269_1.time_ <= var_272_16 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			local var_272_17 = 0.3

			if arg_269_1.time_ >= var_272_16 + var_272_17 and arg_269_1.time_ < var_272_16 + var_272_17 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end

			local var_272_18 = 0

			if var_272_18 < arg_269_1.time_ and arg_269_1.time_ <= var_272_18 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_19 = 2

			if var_272_18 <= arg_269_1.time_ and arg_269_1.time_ < var_272_18 + var_272_19 then
				local var_272_20 = (arg_269_1.time_ - var_272_18) / var_272_19
				local var_272_21 = Color.New(0, 0, 0)

				var_272_21.a = Mathf.Lerp(1, 0, var_272_20)
				arg_269_1.mask_.color = var_272_21
			end

			if arg_269_1.time_ >= var_272_18 + var_272_19 and arg_269_1.time_ < var_272_18 + var_272_19 + arg_272_0 then
				local var_272_22 = Color.New(0, 0, 0)
				local var_272_23 = 0

				arg_269_1.mask_.enabled = false
				var_272_22.a = var_272_23
				arg_269_1.mask_.color = var_272_22
			end

			local var_272_24 = "102003ui_story"

			if arg_269_1.actors_[var_272_24] == nil then
				local var_272_25 = Asset.Load("Char/" .. "102003ui_story")

				if not isNil(var_272_25) then
					local var_272_26 = Object.Instantiate(Asset.Load("Char/" .. "102003ui_story"), arg_269_1.stage_.transform)

					var_272_26.name = var_272_24
					var_272_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_269_1.actors_[var_272_24] = var_272_26

					local var_272_27 = var_272_26:GetComponentInChildren(typeof(CharacterEffect))

					var_272_27.enabled = true

					local var_272_28 = GameObjectTools.GetOrAddComponent(var_272_26, typeof(DynamicBoneHelper))

					if var_272_28 then
						var_272_28:EnableDynamicBone(false)
					end

					arg_269_1:ShowWeapon(var_272_27.transform, false)

					arg_269_1.var_[var_272_24 .. "Animator"] = var_272_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_269_1.var_[var_272_24 .. "Animator"].applyRootMotion = true
					arg_269_1.var_[var_272_24 .. "LipSync"] = var_272_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_272_29 = arg_269_1.actors_["102003ui_story"].transform
			local var_272_30 = 1.8

			if var_272_30 < arg_269_1.time_ and arg_269_1.time_ <= var_272_30 + arg_272_0 then
				arg_269_1.var_.moveOldPos102003ui_story = var_272_29.localPosition
			end

			local var_272_31 = 0.001

			if var_272_30 <= arg_269_1.time_ and arg_269_1.time_ < var_272_30 + var_272_31 then
				local var_272_32 = (arg_269_1.time_ - var_272_30) / var_272_31
				local var_272_33 = Vector3.New(0, -0.85, -6.21)

				var_272_29.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos102003ui_story, var_272_33, var_272_32)

				local var_272_34 = manager.ui.mainCamera.transform.position - var_272_29.position

				var_272_29.forward = Vector3.New(var_272_34.x, var_272_34.y, var_272_34.z)

				local var_272_35 = var_272_29.localEulerAngles

				var_272_35.z = 0
				var_272_35.x = 0
				var_272_29.localEulerAngles = var_272_35
			end

			if arg_269_1.time_ >= var_272_30 + var_272_31 and arg_269_1.time_ < var_272_30 + var_272_31 + arg_272_0 then
				var_272_29.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_272_36 = manager.ui.mainCamera.transform.position - var_272_29.position

				var_272_29.forward = Vector3.New(var_272_36.x, var_272_36.y, var_272_36.z)

				local var_272_37 = var_272_29.localEulerAngles

				var_272_37.z = 0
				var_272_37.x = 0
				var_272_29.localEulerAngles = var_272_37
			end

			local var_272_38 = arg_269_1.actors_["102003ui_story"]
			local var_272_39 = 1.8

			if var_272_39 < arg_269_1.time_ and arg_269_1.time_ <= var_272_39 + arg_272_0 and not isNil(var_272_38) and arg_269_1.var_.characterEffect102003ui_story == nil then
				arg_269_1.var_.characterEffect102003ui_story = var_272_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_40 = 0.200000002980232

			if var_272_39 <= arg_269_1.time_ and arg_269_1.time_ < var_272_39 + var_272_40 and not isNil(var_272_38) then
				local var_272_41 = (arg_269_1.time_ - var_272_39) / var_272_40

				if arg_269_1.var_.characterEffect102003ui_story and not isNil(var_272_38) then
					arg_269_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_39 + var_272_40 and arg_269_1.time_ < var_272_39 + var_272_40 + arg_272_0 and not isNil(var_272_38) and arg_269_1.var_.characterEffect102003ui_story then
				arg_269_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_272_42 = 1.8

			if var_272_42 < arg_269_1.time_ and arg_269_1.time_ <= var_272_42 + arg_272_0 then
				arg_269_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			local var_272_43 = 1.8

			if var_272_43 < arg_269_1.time_ and arg_269_1.time_ <= var_272_43 + arg_272_0 then
				arg_269_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_272_44 = 0.166666666666667
			local var_272_45 = 1

			if var_272_44 < arg_269_1.time_ and arg_269_1.time_ <= var_272_44 + arg_272_0 then
				local var_272_46 = "play"
				local var_272_47 = "effect"

				arg_269_1:AudioAction(var_272_46, var_272_47, "se_story_141", "se_story_141_amb_room", "")
			end

			local var_272_48 = 0
			local var_272_49 = 1

			if var_272_48 < arg_269_1.time_ and arg_269_1.time_ <= var_272_48 + arg_272_0 then
				local var_272_50 = "stop"
				local var_272_51 = "effect"

				arg_269_1:AudioAction(var_272_50, var_272_51, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_269_1.frameCnt_ <= 1 then
				arg_269_1.dialog_:SetActive(false)
			end

			local var_272_52 = 1.975
			local var_272_53 = 0.325

			if var_272_52 < arg_269_1.time_ and arg_269_1.time_ <= var_272_52 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				arg_269_1.dialog_:SetActive(true)

				arg_269_1.dialogCg_.alpha = 0

				local var_272_54 = LeanTween.value(arg_269_1.dialog_, 0, 1, 0.3)

				var_272_54:setOnUpdate(LuaHelper.FloatAction(function(arg_273_0)
					arg_269_1.dialogCg_.alpha = arg_273_0
				end))
				var_272_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_269_1.dialog_)
					var_272_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_269_1.duration_ = arg_269_1.duration_ + 0.3

				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_55 = arg_269_1:FormatText(StoryNameCfg[613].name)

				arg_269_1.leftNameTxt_.text = var_272_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_56 = arg_269_1:GetWordFromCfg(924041066)
				local var_272_57 = arg_269_1:FormatText(var_272_56.content)

				arg_269_1.text_.text = var_272_57

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_58 = 13
				local var_272_59 = utf8.len(var_272_57)
				local var_272_60 = var_272_58 <= 0 and var_272_53 or var_272_53 * (var_272_59 / var_272_58)

				if var_272_60 > 0 and var_272_53 < var_272_60 then
					arg_269_1.talkMaxDuration = var_272_60
					var_272_52 = var_272_52 + 0.3

					if var_272_60 + var_272_52 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_60 + var_272_52
					end
				end

				arg_269_1.text_.text = var_272_57
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb") ~= 0 then
					local var_272_61 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb") / 1000

					if var_272_61 + var_272_52 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_61 + var_272_52
					end

					if var_272_56.prefab_name ~= "" and arg_269_1.actors_[var_272_56.prefab_name] ~= nil then
						local var_272_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_56.prefab_name].transform, "story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb")

						arg_269_1:RecordAudio("924041066", var_272_62)
						arg_269_1:RecordAudio("924041066", var_272_62)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_63 = var_272_52 + 0.3
			local var_272_64 = math.max(var_272_53, arg_269_1.talkMaxDuration)

			if var_272_63 <= arg_269_1.time_ and arg_269_1.time_ < var_272_63 + var_272_64 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_63) / var_272_64

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_63 + var_272_64 and arg_269_1.time_ < var_272_63 + var_272_64 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play924041067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 924041067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play924041068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["102003ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect102003ui_story == nil then
				arg_275_1.var_.characterEffect102003ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect102003ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_275_1.var_.characterEffect102003ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect102003ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_275_1.var_.characterEffect102003ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.4

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_8 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_9 = arg_275_1:GetWordFromCfg(924041067)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 16
				local var_278_12 = utf8.len(var_278_10)
				local var_278_13 = var_278_11 <= 0 and var_278_7 or var_278_7 * (var_278_12 / var_278_11)

				if var_278_13 > 0 and var_278_7 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play924041068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 924041068
		arg_279_1.duration_ = 7.6

		local var_279_0 = {
			zh = 5.033,
			ja = 7.6
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play924041069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["102003ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect102003ui_story == nil then
				arg_279_1.var_.characterEffect102003ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect102003ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect102003ui_story then
				arg_279_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_282_4 = 0

			if var_282_4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action436")
			end

			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_282_6 = 0
			local var_282_7 = 0.55

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_8 = arg_279_1:FormatText(StoryNameCfg[613].name)

				arg_279_1.leftNameTxt_.text = var_282_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_9 = arg_279_1:GetWordFromCfg(924041068)
				local var_282_10 = arg_279_1:FormatText(var_282_9.content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 22
				local var_282_12 = utf8.len(var_282_10)
				local var_282_13 = var_282_11 <= 0 and var_282_7 or var_282_7 * (var_282_12 / var_282_11)

				if var_282_13 > 0 and var_282_7 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb") ~= 0 then
					local var_282_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb") / 1000

					if var_282_14 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_14 + var_282_6
					end

					if var_282_9.prefab_name ~= "" and arg_279_1.actors_[var_282_9.prefab_name] ~= nil then
						local var_282_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_9.prefab_name].transform, "story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb")

						arg_279_1:RecordAudio("924041068", var_282_15)
						arg_279_1:RecordAudio("924041068", var_282_15)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_16 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_16 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_16

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_16 and arg_279_1.time_ < var_282_6 + var_282_16 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play924041069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 924041069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play924041070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["102003ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect102003ui_story == nil then
				arg_283_1.var_.characterEffect102003ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect102003ui_story and not isNil(var_286_0) then
					local var_286_4 = Mathf.Lerp(0, 0.5, var_286_3)

					arg_283_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_283_1.var_.characterEffect102003ui_story.fillRatio = var_286_4
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect102003ui_story then
				local var_286_5 = 0.5

				arg_283_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_283_1.var_.characterEffect102003ui_story.fillRatio = var_286_5
			end

			local var_286_6 = 0
			local var_286_7 = 0.475

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[7].name)

				arg_283_1.leftNameTxt_.text = var_286_8

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

				local var_286_9 = arg_283_1:GetWordFromCfg(924041069)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 19
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play924041070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 924041070
		arg_287_1.duration_ = 3.5

		local var_287_0 = {
			zh = 3.366,
			ja = 3.5
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play924041071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["102003ui_story"]
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect102003ui_story == nil then
				arg_287_1.var_.characterEffect102003ui_story = var_290_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 and not isNil(var_290_0) then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2

				if arg_287_1.var_.characterEffect102003ui_story and not isNil(var_290_0) then
					arg_287_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 and not isNil(var_290_0) and arg_287_1.var_.characterEffect102003ui_story then
				arg_287_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_290_4 = 0

			if var_290_4 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action468")
			end

			local var_290_5 = 0

			if var_290_5 < arg_287_1.time_ and arg_287_1.time_ <= var_290_5 + arg_290_0 then
				arg_287_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_290_6 = 0
			local var_290_7 = 0.375

			if var_290_6 < arg_287_1.time_ and arg_287_1.time_ <= var_290_6 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_8 = arg_287_1:FormatText(StoryNameCfg[613].name)

				arg_287_1.leftNameTxt_.text = var_290_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_9 = arg_287_1:GetWordFromCfg(924041070)
				local var_290_10 = arg_287_1:FormatText(var_290_9.content)

				arg_287_1.text_.text = var_290_10

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_11 = 15
				local var_290_12 = utf8.len(var_290_10)
				local var_290_13 = var_290_11 <= 0 and var_290_7 or var_290_7 * (var_290_12 / var_290_11)

				if var_290_13 > 0 and var_290_7 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13

					if var_290_13 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_6
					end
				end

				arg_287_1.text_.text = var_290_10
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb") ~= 0 then
					local var_290_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb") / 1000

					if var_290_14 + var_290_6 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_14 + var_290_6
					end

					if var_290_9.prefab_name ~= "" and arg_287_1.actors_[var_290_9.prefab_name] ~= nil then
						local var_290_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_9.prefab_name].transform, "story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb")

						arg_287_1:RecordAudio("924041070", var_290_15)
						arg_287_1:RecordAudio("924041070", var_290_15)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_16 = math.max(var_290_7, arg_287_1.talkMaxDuration)

			if var_290_6 <= arg_287_1.time_ and arg_287_1.time_ < var_290_6 + var_290_16 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_6) / var_290_16

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_6 + var_290_16 and arg_287_1.time_ < var_290_6 + var_290_16 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play924041071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 924041071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play924041072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["102003ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect102003ui_story == nil then
				arg_291_1.var_.characterEffect102003ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect102003ui_story and not isNil(var_294_0) then
					local var_294_4 = Mathf.Lerp(0, 0.5, var_294_3)

					arg_291_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_291_1.var_.characterEffect102003ui_story.fillRatio = var_294_4
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect102003ui_story then
				local var_294_5 = 0.5

				arg_291_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_291_1.var_.characterEffect102003ui_story.fillRatio = var_294_5
			end

			local var_294_6 = 0
			local var_294_7 = 0.25

			if var_294_6 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_8 = arg_291_1:FormatText(StoryNameCfg[7].name)

				arg_291_1.leftNameTxt_.text = var_294_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_9 = arg_291_1:GetWordFromCfg(924041071)
				local var_294_10 = arg_291_1:FormatText(var_294_9.content)

				arg_291_1.text_.text = var_294_10

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 10
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
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_14 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_14 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_14

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_14 and arg_291_1.time_ < var_294_6 + var_294_14 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play924041072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 924041072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play924041073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["102003ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos102003ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(0, 100, 0)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos102003ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(0, 100, 0)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = 0
			local var_298_10 = 0.775

			if var_298_9 < arg_295_1.time_ and arg_295_1.time_ <= var_298_9 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_11 = arg_295_1:GetWordFromCfg(924041072)
				local var_298_12 = arg_295_1:FormatText(var_298_11.content)

				arg_295_1.text_.text = var_298_12

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_13 = 65
				local var_298_14 = utf8.len(var_298_12)
				local var_298_15 = var_298_13 <= 0 and var_298_10 or var_298_10 * (var_298_14 / var_298_13)

				if var_298_15 > 0 and var_298_10 < var_298_15 then
					arg_295_1.talkMaxDuration = var_298_15

					if var_298_15 + var_298_9 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_15 + var_298_9
					end
				end

				arg_295_1.text_.text = var_298_12
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_16 = math.max(var_298_10, arg_295_1.talkMaxDuration)

			if var_298_9 <= arg_295_1.time_ and arg_295_1.time_ < var_298_9 + var_298_16 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_9) / var_298_16

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_9 + var_298_16 and arg_295_1.time_ < var_298_9 + var_298_16 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play924041073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 924041073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play924041074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 1.05

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_2 = arg_299_1:GetWordFromCfg(924041073)
				local var_302_3 = arg_299_1:FormatText(var_302_2.content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 42
				local var_302_5 = utf8.len(var_302_3)
				local var_302_6 = var_302_4 <= 0 and var_302_1 or var_302_1 * (var_302_5 / var_302_4)

				if var_302_6 > 0 and var_302_1 < var_302_6 then
					arg_299_1.talkMaxDuration = var_302_6

					if var_302_6 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_6 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_7 and arg_299_1.time_ < var_302_0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play924041074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 924041074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play924041075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 1.025

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_2 = arg_303_1:GetWordFromCfg(924041074)
				local var_306_3 = arg_303_1:FormatText(var_306_2.content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 41
				local var_306_5 = utf8.len(var_306_3)
				local var_306_6 = var_306_4 <= 0 and var_306_1 or var_306_1 * (var_306_5 / var_306_4)

				if var_306_6 > 0 and var_306_1 < var_306_6 then
					arg_303_1.talkMaxDuration = var_306_6

					if var_306_6 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_6 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_7 and arg_303_1.time_ < var_306_0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play924041075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 924041075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play924041076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.675

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[7].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:GetWordFromCfg(924041075)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 27
				local var_310_6 = utf8.len(var_310_4)
				local var_310_7 = var_310_5 <= 0 and var_310_1 or var_310_1 * (var_310_6 / var_310_5)

				if var_310_7 > 0 and var_310_1 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_8 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_8 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_8

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_8 and arg_307_1.time_ < var_310_0 + var_310_8 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play924041076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 924041076
		arg_311_1.duration_ = 4.23

		local var_311_0 = {
			zh = 3.666,
			ja = 4.233
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play924041077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["102003ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos102003ui_story = var_314_0.localPosition
			end

			local var_314_2 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2
				local var_314_4 = Vector3.New(0, -0.85, -6.21)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos102003ui_story, var_314_4, var_314_3)

				local var_314_5 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_5.x, var_314_5.y, var_314_5.z)

				local var_314_6 = var_314_0.localEulerAngles

				var_314_6.z = 0
				var_314_6.x = 0
				var_314_0.localEulerAngles = var_314_6
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_314_7 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_7.x, var_314_7.y, var_314_7.z)

				local var_314_8 = var_314_0.localEulerAngles

				var_314_8.z = 0
				var_314_8.x = 0
				var_314_0.localEulerAngles = var_314_8
			end

			local var_314_9 = arg_311_1.actors_["102003ui_story"]
			local var_314_10 = 0

			if var_314_10 < arg_311_1.time_ and arg_311_1.time_ <= var_314_10 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect102003ui_story == nil then
				arg_311_1.var_.characterEffect102003ui_story = var_314_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_11 = 0.200000002980232

			if var_314_10 <= arg_311_1.time_ and arg_311_1.time_ < var_314_10 + var_314_11 and not isNil(var_314_9) then
				local var_314_12 = (arg_311_1.time_ - var_314_10) / var_314_11

				if arg_311_1.var_.characterEffect102003ui_story and not isNil(var_314_9) then
					arg_311_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_10 + var_314_11 and arg_311_1.time_ < var_314_10 + var_314_11 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect102003ui_story then
				arg_311_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_314_13 = 0

			if var_314_13 < arg_311_1.time_ and arg_311_1.time_ <= var_314_13 + arg_314_0 then
				arg_311_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action12_1")
			end

			local var_314_14 = 0

			if var_314_14 < arg_311_1.time_ and arg_311_1.time_ <= var_314_14 + arg_314_0 then
				arg_311_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_314_15 = 0
			local var_314_16 = 0.375

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_17 = arg_311_1:FormatText(StoryNameCfg[613].name)

				arg_311_1.leftNameTxt_.text = var_314_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_18 = arg_311_1:GetWordFromCfg(924041076)
				local var_314_19 = arg_311_1:FormatText(var_314_18.content)

				arg_311_1.text_.text = var_314_19

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_20 = 15
				local var_314_21 = utf8.len(var_314_19)
				local var_314_22 = var_314_20 <= 0 and var_314_16 or var_314_16 * (var_314_21 / var_314_20)

				if var_314_22 > 0 and var_314_16 < var_314_22 then
					arg_311_1.talkMaxDuration = var_314_22

					if var_314_22 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_22 + var_314_15
					end
				end

				arg_311_1.text_.text = var_314_19
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb") ~= 0 then
					local var_314_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb") / 1000

					if var_314_23 + var_314_15 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_23 + var_314_15
					end

					if var_314_18.prefab_name ~= "" and arg_311_1.actors_[var_314_18.prefab_name] ~= nil then
						local var_314_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_18.prefab_name].transform, "story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb")

						arg_311_1:RecordAudio("924041076", var_314_24)
						arg_311_1:RecordAudio("924041076", var_314_24)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_25 = math.max(var_314_16, arg_311_1.talkMaxDuration)

			if var_314_15 <= arg_311_1.time_ and arg_311_1.time_ < var_314_15 + var_314_25 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_15) / var_314_25

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_15 + var_314_25 and arg_311_1.time_ < var_314_15 + var_314_25 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play924041077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 924041077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play924041078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = arg_315_1.actors_["102003ui_story"]
			local var_318_1 = 0

			if var_318_1 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect102003ui_story == nil then
				arg_315_1.var_.characterEffect102003ui_story = var_318_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_2 and not isNil(var_318_0) then
				local var_318_3 = (arg_315_1.time_ - var_318_1) / var_318_2

				if arg_315_1.var_.characterEffect102003ui_story and not isNil(var_318_0) then
					local var_318_4 = Mathf.Lerp(0, 0.5, var_318_3)

					arg_315_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_315_1.var_.characterEffect102003ui_story.fillRatio = var_318_4
				end
			end

			if arg_315_1.time_ >= var_318_1 + var_318_2 and arg_315_1.time_ < var_318_1 + var_318_2 + arg_318_0 and not isNil(var_318_0) and arg_315_1.var_.characterEffect102003ui_story then
				local var_318_5 = 0.5

				arg_315_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_315_1.var_.characterEffect102003ui_story.fillRatio = var_318_5
			end

			local var_318_6 = 0
			local var_318_7 = 0.3

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

				local var_318_9 = arg_315_1:GetWordFromCfg(924041077)
				local var_318_10 = arg_315_1:FormatText(var_318_9.content)

				arg_315_1.text_.text = var_318_10

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 12
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
	Play924041078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 924041078
		arg_319_1.duration_ = 9.7

		local var_319_0 = {
			zh = 6.4,
			ja = 9.7
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play924041079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["102003ui_story"]
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect102003ui_story == nil then
				arg_319_1.var_.characterEffect102003ui_story = var_322_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 and not isNil(var_322_0) then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2

				if arg_319_1.var_.characterEffect102003ui_story and not isNil(var_322_0) then
					arg_319_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 and not isNil(var_322_0) and arg_319_1.var_.characterEffect102003ui_story then
				arg_319_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_322_4 = 0

			if var_322_4 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action12_2")
			end

			local var_322_5 = 0

			if var_322_5 < arg_319_1.time_ and arg_319_1.time_ <= var_322_5 + arg_322_0 then
				arg_319_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_322_6 = 0
			local var_322_7 = 0.8

			if var_322_6 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_8 = arg_319_1:FormatText(StoryNameCfg[613].name)

				arg_319_1.leftNameTxt_.text = var_322_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_9 = arg_319_1:GetWordFromCfg(924041078)
				local var_322_10 = arg_319_1:FormatText(var_322_9.content)

				arg_319_1.text_.text = var_322_10

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_11 = 32
				local var_322_12 = utf8.len(var_322_10)
				local var_322_13 = var_322_11 <= 0 and var_322_7 or var_322_7 * (var_322_12 / var_322_11)

				if var_322_13 > 0 and var_322_7 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_10
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb") / 1000

					if var_322_14 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_6
					end

					if var_322_9.prefab_name ~= "" and arg_319_1.actors_[var_322_9.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_9.prefab_name].transform, "story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb")

						arg_319_1:RecordAudio("924041078", var_322_15)
						arg_319_1:RecordAudio("924041078", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_16 and arg_319_1.time_ < var_322_6 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play924041079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 924041079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play924041080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["102003ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect102003ui_story == nil then
				arg_323_1.var_.characterEffect102003ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect102003ui_story and not isNil(var_326_0) then
					local var_326_4 = Mathf.Lerp(0, 0.5, var_326_3)

					arg_323_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_323_1.var_.characterEffect102003ui_story.fillRatio = var_326_4
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect102003ui_story then
				local var_326_5 = 0.5

				arg_323_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_323_1.var_.characterEffect102003ui_story.fillRatio = var_326_5
			end

			local var_326_6 = 0
			local var_326_7 = 0.225

			if var_326_6 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_8 = arg_323_1:FormatText(StoryNameCfg[7].name)

				arg_323_1.leftNameTxt_.text = var_326_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_9 = arg_323_1:GetWordFromCfg(924041079)
				local var_326_10 = arg_323_1:FormatText(var_326_9.content)

				arg_323_1.text_.text = var_326_10

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_11 = 9
				local var_326_12 = utf8.len(var_326_10)
				local var_326_13 = var_326_11 <= 0 and var_326_7 or var_326_7 * (var_326_12 / var_326_11)

				if var_326_13 > 0 and var_326_7 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_10
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_14 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_14 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_14

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_14 and arg_323_1.time_ < var_326_6 + var_326_14 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play924041080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 924041080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play924041081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["102003ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos102003ui_story = var_330_0.localPosition
			end

			local var_330_2 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2
				local var_330_4 = Vector3.New(0, 100, 0)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos102003ui_story, var_330_4, var_330_3)

				local var_330_5 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_5.x, var_330_5.y, var_330_5.z)

				local var_330_6 = var_330_0.localEulerAngles

				var_330_6.z = 0
				var_330_6.x = 0
				var_330_0.localEulerAngles = var_330_6
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, 100, 0)

				local var_330_7 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_7.x, var_330_7.y, var_330_7.z)

				local var_330_8 = var_330_0.localEulerAngles

				var_330_8.z = 0
				var_330_8.x = 0
				var_330_0.localEulerAngles = var_330_8
			end

			local var_330_9 = 0
			local var_330_10 = 0.4

			if var_330_9 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_11 = arg_327_1:GetWordFromCfg(924041080)
				local var_330_12 = arg_327_1:FormatText(var_330_11.content)

				arg_327_1.text_.text = var_330_12

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 16
				local var_330_14 = utf8.len(var_330_12)
				local var_330_15 = var_330_13 <= 0 and var_330_10 or var_330_10 * (var_330_14 / var_330_13)

				if var_330_15 > 0 and var_330_10 < var_330_15 then
					arg_327_1.talkMaxDuration = var_330_15

					if var_330_15 + var_330_9 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_15 + var_330_9
					end
				end

				arg_327_1.text_.text = var_330_12
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_10, arg_327_1.talkMaxDuration)

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_9) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_9 + var_330_16 and arg_327_1.time_ < var_330_9 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play924041081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 924041081
		arg_331_1.duration_ = 2.87

		local var_331_0 = {
			zh = 1.999999999999,
			ja = 2.866
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play924041082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["102003ui_story"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos102003ui_story = var_334_0.localPosition
			end

			local var_334_2 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2
				local var_334_4 = Vector3.New(0, -0.85, -6.21)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos102003ui_story, var_334_4, var_334_3)

				local var_334_5 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_5.x, var_334_5.y, var_334_5.z)

				local var_334_6 = var_334_0.localEulerAngles

				var_334_6.z = 0
				var_334_6.x = 0
				var_334_0.localEulerAngles = var_334_6
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_334_7 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_7.x, var_334_7.y, var_334_7.z)

				local var_334_8 = var_334_0.localEulerAngles

				var_334_8.z = 0
				var_334_8.x = 0
				var_334_0.localEulerAngles = var_334_8
			end

			local var_334_9 = arg_331_1.actors_["102003ui_story"]
			local var_334_10 = 0

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 and not isNil(var_334_9) and arg_331_1.var_.characterEffect102003ui_story == nil then
				arg_331_1.var_.characterEffect102003ui_story = var_334_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_11 = 0.200000002980232

			if var_334_10 <= arg_331_1.time_ and arg_331_1.time_ < var_334_10 + var_334_11 and not isNil(var_334_9) then
				local var_334_12 = (arg_331_1.time_ - var_334_10) / var_334_11

				if arg_331_1.var_.characterEffect102003ui_story and not isNil(var_334_9) then
					arg_331_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_10 + var_334_11 and arg_331_1.time_ < var_334_10 + var_334_11 + arg_334_0 and not isNil(var_334_9) and arg_331_1.var_.characterEffect102003ui_story then
				arg_331_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_334_13 = 0

			if var_334_13 < arg_331_1.time_ and arg_331_1.time_ <= var_334_13 + arg_334_0 then
				arg_331_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			local var_334_14 = 0

			if var_334_14 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_334_15 = 0
			local var_334_16 = 0.125

			if var_334_15 < arg_331_1.time_ and arg_331_1.time_ <= var_334_15 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_17 = arg_331_1:FormatText(StoryNameCfg[613].name)

				arg_331_1.leftNameTxt_.text = var_334_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_18 = arg_331_1:GetWordFromCfg(924041081)
				local var_334_19 = arg_331_1:FormatText(var_334_18.content)

				arg_331_1.text_.text = var_334_19

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_20 = 5
				local var_334_21 = utf8.len(var_334_19)
				local var_334_22 = var_334_20 <= 0 and var_334_16 or var_334_16 * (var_334_21 / var_334_20)

				if var_334_22 > 0 and var_334_16 < var_334_22 then
					arg_331_1.talkMaxDuration = var_334_22

					if var_334_22 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_22 + var_334_15
					end
				end

				arg_331_1.text_.text = var_334_19
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb") ~= 0 then
					local var_334_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb") / 1000

					if var_334_23 + var_334_15 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_23 + var_334_15
					end

					if var_334_18.prefab_name ~= "" and arg_331_1.actors_[var_334_18.prefab_name] ~= nil then
						local var_334_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_18.prefab_name].transform, "story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb")

						arg_331_1:RecordAudio("924041081", var_334_24)
						arg_331_1:RecordAudio("924041081", var_334_24)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_25 = math.max(var_334_16, arg_331_1.talkMaxDuration)

			if var_334_15 <= arg_331_1.time_ and arg_331_1.time_ < var_334_15 + var_334_25 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_15) / var_334_25

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_15 + var_334_25 and arg_331_1.time_ < var_334_15 + var_334_25 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play924041082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 924041082
		arg_335_1.duration_ = 9

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play924041083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 2

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				local var_338_1 = manager.ui.mainCamera.transform.localPosition
				local var_338_2 = Vector3.New(0, 0, 10) + Vector3.New(var_338_1.x, var_338_1.y, 0)
				local var_338_3 = arg_335_1.bgs_.STblack

				var_338_3.transform.localPosition = var_338_2
				var_338_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_338_4 = var_338_3:GetComponent("SpriteRenderer")

				if var_338_4 and var_338_4.sprite then
					local var_338_5 = (var_338_3.transform.localPosition - var_338_1).z
					local var_338_6 = manager.ui.mainCameraCom_
					local var_338_7 = 2 * var_338_5 * Mathf.Tan(var_338_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_338_8 = var_338_7 * var_338_6.aspect
					local var_338_9 = var_338_4.sprite.bounds.size.x
					local var_338_10 = var_338_4.sprite.bounds.size.y
					local var_338_11 = var_338_8 / var_338_9
					local var_338_12 = var_338_7 / var_338_10
					local var_338_13 = var_338_12 < var_338_11 and var_338_11 or var_338_12

					var_338_3.transform.localScale = Vector3.New(var_338_13, var_338_13, 0)
				end

				for iter_338_0, iter_338_1 in pairs(arg_335_1.bgs_) do
					if iter_338_0 ~= "STblack" then
						iter_338_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_338_14 = 4

			if var_338_14 < arg_335_1.time_ and arg_335_1.time_ <= var_338_14 + arg_338_0 then
				arg_335_1.allBtn_.enabled = false
			end

			local var_338_15 = 0.3

			if arg_335_1.time_ >= var_338_14 + var_338_15 and arg_335_1.time_ < var_338_14 + var_338_15 + arg_338_0 then
				arg_335_1.allBtn_.enabled = true
			end

			local var_338_16 = 0

			if var_338_16 < arg_335_1.time_ and arg_335_1.time_ <= var_338_16 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_17 = 2

			if var_338_16 <= arg_335_1.time_ and arg_335_1.time_ < var_338_16 + var_338_17 then
				local var_338_18 = (arg_335_1.time_ - var_338_16) / var_338_17
				local var_338_19 = Color.New(0, 0, 0)

				var_338_19.a = Mathf.Lerp(0, 1, var_338_18)
				arg_335_1.mask_.color = var_338_19
			end

			if arg_335_1.time_ >= var_338_16 + var_338_17 and arg_335_1.time_ < var_338_16 + var_338_17 + arg_338_0 then
				local var_338_20 = Color.New(0, 0, 0)

				var_338_20.a = 1
				arg_335_1.mask_.color = var_338_20
			end

			local var_338_21 = 2

			if var_338_21 < arg_335_1.time_ and arg_335_1.time_ <= var_338_21 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_22 = 2

			if var_338_21 <= arg_335_1.time_ and arg_335_1.time_ < var_338_21 + var_338_22 then
				local var_338_23 = (arg_335_1.time_ - var_338_21) / var_338_22
				local var_338_24 = Color.New(0, 0, 0)

				var_338_24.a = Mathf.Lerp(1, 0, var_338_23)
				arg_335_1.mask_.color = var_338_24
			end

			if arg_335_1.time_ >= var_338_21 + var_338_22 and arg_335_1.time_ < var_338_21 + var_338_22 + arg_338_0 then
				local var_338_25 = Color.New(0, 0, 0)
				local var_338_26 = 0

				arg_335_1.mask_.enabled = false
				var_338_25.a = var_338_26
				arg_335_1.mask_.color = var_338_25
			end

			local var_338_27 = arg_335_1.actors_["102003ui_story"].transform
			local var_338_28 = 1.96599999815226

			if var_338_28 < arg_335_1.time_ and arg_335_1.time_ <= var_338_28 + arg_338_0 then
				arg_335_1.var_.moveOldPos102003ui_story = var_338_27.localPosition
			end

			local var_338_29 = 0.001

			if var_338_28 <= arg_335_1.time_ and arg_335_1.time_ < var_338_28 + var_338_29 then
				local var_338_30 = (arg_335_1.time_ - var_338_28) / var_338_29
				local var_338_31 = Vector3.New(0, 100, 0)

				var_338_27.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos102003ui_story, var_338_31, var_338_30)

				local var_338_32 = manager.ui.mainCamera.transform.position - var_338_27.position

				var_338_27.forward = Vector3.New(var_338_32.x, var_338_32.y, var_338_32.z)

				local var_338_33 = var_338_27.localEulerAngles

				var_338_33.z = 0
				var_338_33.x = 0
				var_338_27.localEulerAngles = var_338_33
			end

			if arg_335_1.time_ >= var_338_28 + var_338_29 and arg_335_1.time_ < var_338_28 + var_338_29 + arg_338_0 then
				var_338_27.localPosition = Vector3.New(0, 100, 0)

				local var_338_34 = manager.ui.mainCamera.transform.position - var_338_27.position

				var_338_27.forward = Vector3.New(var_338_34.x, var_338_34.y, var_338_34.z)

				local var_338_35 = var_338_27.localEulerAngles

				var_338_35.z = 0
				var_338_35.x = 0
				var_338_27.localEulerAngles = var_338_35
			end

			local var_338_36 = arg_335_1.actors_["102003ui_story"]
			local var_338_37 = 1.96599999815226

			if var_338_37 < arg_335_1.time_ and arg_335_1.time_ <= var_338_37 + arg_338_0 and not isNil(var_338_36) and arg_335_1.var_.characterEffect102003ui_story == nil then
				arg_335_1.var_.characterEffect102003ui_story = var_338_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_38 = 0.034000001847744

			if var_338_37 <= arg_335_1.time_ and arg_335_1.time_ < var_338_37 + var_338_38 and not isNil(var_338_36) then
				local var_338_39 = (arg_335_1.time_ - var_338_37) / var_338_38

				if arg_335_1.var_.characterEffect102003ui_story and not isNil(var_338_36) then
					local var_338_40 = Mathf.Lerp(0, 0.5, var_338_39)

					arg_335_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_335_1.var_.characterEffect102003ui_story.fillRatio = var_338_40
				end
			end

			if arg_335_1.time_ >= var_338_37 + var_338_38 and arg_335_1.time_ < var_338_37 + var_338_38 + arg_338_0 and not isNil(var_338_36) and arg_335_1.var_.characterEffect102003ui_story then
				local var_338_41 = 0.5

				arg_335_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_335_1.var_.characterEffect102003ui_story.fillRatio = var_338_41
			end

			local var_338_42 = 0.133333333333333
			local var_338_43 = 1

			if var_338_42 < arg_335_1.time_ and arg_335_1.time_ <= var_338_42 + arg_338_0 then
				local var_338_44 = "play"
				local var_338_45 = "effect"

				arg_335_1:AudioAction(var_338_44, var_338_45, "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_338_46 = 0.133333333333333
			local var_338_47 = 0.2

			if var_338_46 < arg_335_1.time_ and arg_335_1.time_ <= var_338_46 + arg_338_0 then
				local var_338_48 = "play"
				local var_338_49 = "music"

				arg_335_1:AudioAction(var_338_48, var_338_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_338_50 = ""
				local var_338_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_338_51 ~= "" then
					if arg_335_1.bgmTxt_.text ~= var_338_51 and arg_335_1.bgmTxt_.text ~= "" then
						if arg_335_1.bgmTxt2_.text ~= "" then
							arg_335_1.bgmTxt_.text = arg_335_1.bgmTxt2_.text
						end

						arg_335_1.bgmTxt2_.text = var_338_51

						arg_335_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_335_1.bgmTxt_.text = var_338_51
						arg_335_1.bgmTxt2_.text = var_338_51
					end

					if arg_335_1.bgmTimer then
						arg_335_1.bgmTimer:Stop()

						arg_335_1.bgmTimer = nil
					end

					if arg_335_1.settingData.show_music_name == 1 then
						arg_335_1.musicController:SetSelectedState("show")
						arg_335_1.musicAnimator_:Play("open", 0, 0)

						if arg_335_1.settingData.music_time ~= 0 then
							arg_335_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_335_1.settingData.music_time), function()
								if arg_335_1 == nil or isNil(arg_335_1.bgmTxt_) then
									return
								end

								arg_335_1.musicController:SetSelectedState("hide")
								arg_335_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_335_1.frameCnt_ <= 1 then
				arg_335_1.dialog_:SetActive(false)
			end

			local var_338_52 = 4
			local var_338_53 = 0.75

			if var_338_52 < arg_335_1.time_ and arg_335_1.time_ <= var_338_52 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0

				arg_335_1.dialog_:SetActive(true)

				arg_335_1.dialogCg_.alpha = 0

				local var_338_54 = LeanTween.value(arg_335_1.dialog_, 0, 1, 0.3)

				var_338_54:setOnUpdate(LuaHelper.FloatAction(function(arg_340_0)
					arg_335_1.dialogCg_.alpha = arg_340_0
				end))
				var_338_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_335_1.dialog_)
					var_338_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_335_1.duration_ = arg_335_1.duration_ + 0.3

				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_55 = arg_335_1:GetWordFromCfg(924041082)
				local var_338_56 = arg_335_1:FormatText(var_338_55.content)

				arg_335_1.text_.text = var_338_56

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_57 = 30
				local var_338_58 = utf8.len(var_338_56)
				local var_338_59 = var_338_57 <= 0 and var_338_53 or var_338_53 * (var_338_58 / var_338_57)

				if var_338_59 > 0 and var_338_53 < var_338_59 then
					arg_335_1.talkMaxDuration = var_338_59
					var_338_52 = var_338_52 + 0.3

					if var_338_59 + var_338_52 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_59 + var_338_52
					end
				end

				arg_335_1.text_.text = var_338_56
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_60 = var_338_52 + 0.3
			local var_338_61 = math.max(var_338_53, arg_335_1.talkMaxDuration)

			if var_338_60 <= arg_335_1.time_ and arg_335_1.time_ < var_338_60 + var_338_61 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_60) / var_338_61

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_60 + var_338_61 and arg_335_1.time_ < var_338_60 + var_338_61 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play924041083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 924041083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play924041084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 0.6

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_2 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_2

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

				local var_345_3 = arg_342_1:GetWordFromCfg(924041083)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 24
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
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_8 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_8 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_8

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_8 and arg_342_1.time_ < var_345_0 + var_345_8 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play924041084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 924041084
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play924041085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.5

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[7].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(924041084)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 16
				local var_349_6 = utf8.len(var_349_4)
				local var_349_7 = var_349_5 <= 0 and var_349_1 or var_349_1 * (var_349_6 / var_349_5)

				if var_349_7 > 0 and var_349_1 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_4
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_8 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_8 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_8

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_8 and arg_346_1.time_ < var_349_0 + var_349_8 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play924041085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 924041085
		arg_350_1.duration_ = 1.1

		local var_350_0 = {
			zh = 0.999999999999,
			ja = 1.1
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play924041086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.1

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[613].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:GetWordFromCfg(924041085)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 4
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb") ~= 0 then
					local var_353_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb") / 1000

					if var_353_8 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_0
					end

					if var_353_3.prefab_name ~= "" and arg_350_1.actors_[var_353_3.prefab_name] ~= nil then
						local var_353_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_3.prefab_name].transform, "story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb")

						arg_350_1:RecordAudio("924041085", var_353_9)
						arg_350_1:RecordAudio("924041085", var_353_9)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_10 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_10 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_10

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_10 and arg_350_1.time_ < var_353_0 + var_353_10 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play924041086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 924041086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play924041087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["102003ui_story"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect102003ui_story == nil then
				arg_354_1.var_.characterEffect102003ui_story = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect102003ui_story and not isNil(var_357_0) then
					local var_357_4 = Mathf.Lerp(0, 0.5, var_357_3)

					arg_354_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_354_1.var_.characterEffect102003ui_story.fillRatio = var_357_4
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect102003ui_story then
				local var_357_5 = 0.5

				arg_354_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_354_1.var_.characterEffect102003ui_story.fillRatio = var_357_5
			end

			local var_357_6 = 0
			local var_357_7 = 0.575

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_8 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_9 = arg_354_1:GetWordFromCfg(924041086)
				local var_357_10 = arg_354_1:FormatText(var_357_9.content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_11 = 23
				local var_357_12 = utf8.len(var_357_10)
				local var_357_13 = var_357_11 <= 0 and var_357_7 or var_357_7 * (var_357_12 / var_357_11)

				if var_357_13 > 0 and var_357_7 < var_357_13 then
					arg_354_1.talkMaxDuration = var_357_13

					if var_357_13 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_6
					end
				end

				arg_354_1.text_.text = var_357_10
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_14 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_14 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_14

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_14 and arg_354_1.time_ < var_357_6 + var_357_14 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play924041087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 924041087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play924041088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 0.75

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				local var_361_2 = arg_358_1:FormatText(StoryNameCfg[7].name)

				arg_358_1.leftNameTxt_.text = var_361_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:GetWordFromCfg(924041087)
				local var_361_4 = arg_358_1:FormatText(var_361_3.content)

				arg_358_1.text_.text = var_361_4

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 30
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
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_8 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_8 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_8

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_8 and arg_358_1.time_ < var_361_0 + var_361_8 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play924041088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 924041088
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play924041089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.666666666666667
			local var_365_1 = 1

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				local var_365_2 = "play"
				local var_365_3 = "effect"

				arg_362_1:AudioAction(var_365_2, var_365_3, "se_story_140", "se_story_140_snap", "")
			end

			local var_365_4 = 0
			local var_365_5 = 0.2

			if var_365_4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				local var_365_6 = "play"
				local var_365_7 = "music"

				arg_362_1:AudioAction(var_365_6, var_365_7, "ui_battle", "ui_battle_stopbgm", "")

				local var_365_8 = ""
				local var_365_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_365_9 ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_9 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_9

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_9
						arg_362_1.bgmTxt2_.text = var_365_9
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_365_10 = 0.4
			local var_365_11 = 1

			if var_365_10 < arg_362_1.time_ and arg_362_1.time_ <= var_365_10 + arg_365_0 then
				local var_365_12 = "play"
				local var_365_13 = "music"

				arg_362_1:AudioAction(var_365_12, var_365_13, "bgm_activity_4_0_scene_102003_story", "bgm_activity_4_0_scene_102003_story", "bgm_activity_4_0_scene_102003_story.awb")

				local var_365_14 = ""
				local var_365_15 = manager.audio:GetAudioName("bgm_activity_4_0_scene_102003_story", "bgm_activity_4_0_scene_102003_story")

				if var_365_15 ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_15 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_15

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_15
						arg_362_1.bgmTxt2_.text = var_365_15
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_365_16 = 0
			local var_365_17 = 0.5

			if var_365_16 < arg_362_1.time_ and arg_362_1.time_ <= var_365_16 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_18 = arg_362_1:FormatText(StoryNameCfg[7].name)

				arg_362_1.leftNameTxt_.text = var_365_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_19 = arg_362_1:GetWordFromCfg(924041088)
				local var_365_20 = arg_362_1:FormatText(var_365_19.content)

				arg_362_1.text_.text = var_365_20

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_21 = 20
				local var_365_22 = utf8.len(var_365_20)
				local var_365_23 = var_365_21 <= 0 and var_365_17 or var_365_17 * (var_365_22 / var_365_21)

				if var_365_23 > 0 and var_365_17 < var_365_23 then
					arg_362_1.talkMaxDuration = var_365_23

					if var_365_23 + var_365_16 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_23 + var_365_16
					end
				end

				arg_362_1.text_.text = var_365_20
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_24 = math.max(var_365_17, arg_362_1.talkMaxDuration)

			if var_365_16 <= arg_362_1.time_ and arg_362_1.time_ < var_365_16 + var_365_24 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_16) / var_365_24

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_16 + var_365_24 and arg_362_1.time_ < var_365_16 + var_365_24 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play924041089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 924041089
		arg_368_1.duration_ = 7

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play924041090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = "ST0107"

			if arg_368_1.bgs_[var_371_0] == nil then
				local var_371_1 = Object.Instantiate(arg_368_1.paintGo_)

				var_371_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_371_0)
				var_371_1.name = var_371_0
				var_371_1.transform.parent = arg_368_1.stage_.transform
				var_371_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.bgs_[var_371_0] = var_371_1
			end

			local var_371_2 = 0

			if var_371_2 < arg_368_1.time_ and arg_368_1.time_ <= var_371_2 + arg_371_0 then
				local var_371_3 = manager.ui.mainCamera.transform.localPosition
				local var_371_4 = Vector3.New(0, 0, 10) + Vector3.New(var_371_3.x, var_371_3.y, 0)
				local var_371_5 = arg_368_1.bgs_.ST0107

				var_371_5.transform.localPosition = var_371_4
				var_371_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_371_6 = var_371_5:GetComponent("SpriteRenderer")

				if var_371_6 and var_371_6.sprite then
					local var_371_7 = (var_371_5.transform.localPosition - var_371_3).z
					local var_371_8 = manager.ui.mainCameraCom_
					local var_371_9 = 2 * var_371_7 * Mathf.Tan(var_371_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_371_10 = var_371_9 * var_371_8.aspect
					local var_371_11 = var_371_6.sprite.bounds.size.x
					local var_371_12 = var_371_6.sprite.bounds.size.y
					local var_371_13 = var_371_10 / var_371_11
					local var_371_14 = var_371_9 / var_371_12
					local var_371_15 = var_371_14 < var_371_13 and var_371_13 or var_371_14

					var_371_5.transform.localScale = Vector3.New(var_371_15, var_371_15, 0)
				end

				for iter_371_0, iter_371_1 in pairs(arg_368_1.bgs_) do
					if iter_371_0 ~= "ST0107" then
						iter_371_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_371_16 = 2

			if var_371_16 < arg_368_1.time_ and arg_368_1.time_ <= var_371_16 + arg_371_0 then
				arg_368_1.allBtn_.enabled = false
			end

			local var_371_17 = 0.3

			if arg_368_1.time_ >= var_371_16 + var_371_17 and arg_368_1.time_ < var_371_16 + var_371_17 + arg_371_0 then
				arg_368_1.allBtn_.enabled = true
			end

			local var_371_18 = 0

			if var_371_18 < arg_368_1.time_ and arg_368_1.time_ <= var_371_18 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_19 = 2

			if var_371_18 <= arg_368_1.time_ and arg_368_1.time_ < var_371_18 + var_371_19 then
				local var_371_20 = (arg_368_1.time_ - var_371_18) / var_371_19
				local var_371_21 = Color.New(0, 0, 0)

				var_371_21.a = Mathf.Lerp(1, 0, var_371_20)
				arg_368_1.mask_.color = var_371_21
			end

			if arg_368_1.time_ >= var_371_18 + var_371_19 and arg_368_1.time_ < var_371_18 + var_371_19 + arg_371_0 then
				local var_371_22 = Color.New(0, 0, 0)
				local var_371_23 = 0

				arg_368_1.mask_.enabled = false
				var_371_22.a = var_371_23
				arg_368_1.mask_.color = var_371_22
			end

			local var_371_24 = 0.125
			local var_371_25 = 1

			if var_371_24 < arg_368_1.time_ and arg_368_1.time_ <= var_371_24 + arg_371_0 then
				local var_371_26 = "play"
				local var_371_27 = "effect"

				arg_368_1:AudioAction(var_371_26, var_371_27, "se_story_141", "se_story_141_amb_street_night", "")
			end

			local var_371_28 = 0.125
			local var_371_29 = 1

			if var_371_28 < arg_368_1.time_ and arg_368_1.time_ <= var_371_28 + arg_371_0 then
				local var_371_30 = "stop"
				local var_371_31 = "effect"

				arg_368_1:AudioAction(var_371_30, var_371_31, "se_story_141", "se_story_141_amb_room", "")
			end

			if arg_368_1.frameCnt_ <= 1 then
				arg_368_1.dialog_:SetActive(false)
			end

			local var_371_32 = 2
			local var_371_33 = 1.125

			if var_371_32 < arg_368_1.time_ and arg_368_1.time_ <= var_371_32 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				arg_368_1.dialog_:SetActive(true)

				arg_368_1.dialogCg_.alpha = 0

				local var_371_34 = LeanTween.value(arg_368_1.dialog_, 0, 1, 0.3)

				var_371_34:setOnUpdate(LuaHelper.FloatAction(function(arg_372_0)
					arg_368_1.dialogCg_.alpha = arg_372_0
				end))
				var_371_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_368_1.dialog_)
					var_371_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_368_1.duration_ = arg_368_1.duration_ + 0.3

				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_35 = arg_368_1:GetWordFromCfg(924041089)
				local var_371_36 = arg_368_1:FormatText(var_371_35.content)

				arg_368_1.text_.text = var_371_36

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_37 = 45
				local var_371_38 = utf8.len(var_371_36)
				local var_371_39 = var_371_37 <= 0 and var_371_33 or var_371_33 * (var_371_38 / var_371_37)

				if var_371_39 > 0 and var_371_33 < var_371_39 then
					arg_368_1.talkMaxDuration = var_371_39
					var_371_32 = var_371_32 + 0.3

					if var_371_39 + var_371_32 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_39 + var_371_32
					end
				end

				arg_368_1.text_.text = var_371_36
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_40 = var_371_32 + 0.3
			local var_371_41 = math.max(var_371_33, arg_368_1.talkMaxDuration)

			if var_371_40 <= arg_368_1.time_ and arg_368_1.time_ < var_371_40 + var_371_41 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_40) / var_371_41

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_40 + var_371_41 and arg_368_1.time_ < var_371_40 + var_371_41 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play924041090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 924041090
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play924041091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 1.375

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_2 = arg_374_1:GetWordFromCfg(924041090)
				local var_377_3 = arg_374_1:FormatText(var_377_2.content)

				arg_374_1.text_.text = var_377_3

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 55
				local var_377_5 = utf8.len(var_377_3)
				local var_377_6 = var_377_4 <= 0 and var_377_1 or var_377_1 * (var_377_5 / var_377_4)

				if var_377_6 > 0 and var_377_1 < var_377_6 then
					arg_374_1.talkMaxDuration = var_377_6

					if var_377_6 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_6 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_3
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_7 and arg_374_1.time_ < var_377_0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play924041091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 924041091
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play924041092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0
			local var_381_1 = 0.95

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_2 = arg_378_1:FormatText(StoryNameCfg[7].name)

				arg_378_1.leftNameTxt_.text = var_381_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_3 = arg_378_1:GetWordFromCfg(924041091)
				local var_381_4 = arg_378_1:FormatText(var_381_3.content)

				arg_378_1.text_.text = var_381_4

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 38
				local var_381_6 = utf8.len(var_381_4)
				local var_381_7 = var_381_5 <= 0 and var_381_1 or var_381_1 * (var_381_6 / var_381_5)

				if var_381_7 > 0 and var_381_1 < var_381_7 then
					arg_378_1.talkMaxDuration = var_381_7

					if var_381_7 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_7 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_4
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_8 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_8 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_8

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_8 and arg_378_1.time_ < var_381_0 + var_381_8 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play924041092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 924041092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play924041093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0
			local var_385_1 = 1.425

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[7].name)

				arg_382_1.leftNameTxt_.text = var_385_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_3 = arg_382_1:GetWordFromCfg(924041092)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 57
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_8 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_8 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_8

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_8 and arg_382_1.time_ < var_385_0 + var_385_8 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play924041093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 924041093
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play924041094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.725

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[7].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:GetWordFromCfg(924041093)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 29
				local var_389_6 = utf8.len(var_389_4)
				local var_389_7 = var_389_5 <= 0 and var_389_1 or var_389_1 * (var_389_6 / var_389_5)

				if var_389_7 > 0 and var_389_1 < var_389_7 then
					arg_386_1.talkMaxDuration = var_389_7

					if var_389_7 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_7 + var_389_0
					end
				end

				arg_386_1.text_.text = var_389_4
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_8 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_8 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_8

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_8 and arg_386_1.time_ < var_389_0 + var_389_8 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play924041094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 924041094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play924041095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 1.15

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_2 = arg_390_1:GetWordFromCfg(924041094)
				local var_393_3 = arg_390_1:FormatText(var_393_2.content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 46
				local var_393_5 = utf8.len(var_393_3)
				local var_393_6 = var_393_4 <= 0 and var_393_1 or var_393_1 * (var_393_5 / var_393_4)

				if var_393_6 > 0 and var_393_1 < var_393_6 then
					arg_390_1.talkMaxDuration = var_393_6

					if var_393_6 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_6 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_7 and arg_390_1.time_ < var_393_0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play924041095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 924041095
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play924041096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 1.025

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_2 = arg_394_1:FormatText(StoryNameCfg[7].name)

				arg_394_1.leftNameTxt_.text = var_397_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:GetWordFromCfg(924041095)
				local var_397_4 = arg_394_1:FormatText(var_397_3.content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 41
				local var_397_6 = utf8.len(var_397_4)
				local var_397_7 = var_397_5 <= 0 and var_397_1 or var_397_1 * (var_397_6 / var_397_5)

				if var_397_7 > 0 and var_397_1 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_8 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_8 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_8

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_8 and arg_394_1.time_ < var_397_0 + var_397_8 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play924041096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 924041096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play924041097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 1.525

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[7].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:GetWordFromCfg(924041096)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 61
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
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_8 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_8 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_8

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_8 and arg_398_1.time_ < var_401_0 + var_401_8 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play924041097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 924041097
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play924041098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.25

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[7].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(924041097)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 10
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
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_8 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_8 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_8

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_8 and arg_402_1.time_ < var_405_0 + var_405_8 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play924041098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 924041098
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play924041099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 1.425

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_2 = arg_406_1:FormatText(StoryNameCfg[7].name)

				arg_406_1.leftNameTxt_.text = var_409_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:GetWordFromCfg(924041098)
				local var_409_4 = arg_406_1:FormatText(var_409_3.content)

				arg_406_1.text_.text = var_409_4

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 57
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
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_8 = math.max(var_409_1, arg_406_1.talkMaxDuration)

			if var_409_0 <= arg_406_1.time_ and arg_406_1.time_ < var_409_0 + var_409_8 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_0) / var_409_8

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_0 + var_409_8 and arg_406_1.time_ < var_409_0 + var_409_8 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play924041099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 924041099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play924041100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.775

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[7].name)

				arg_410_1.leftNameTxt_.text = var_413_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:GetWordFromCfg(924041099)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 31
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
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_8 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_8 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_8

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_8 and arg_410_1.time_ < var_413_0 + var_413_8 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play924041100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 924041100
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play924041101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.75

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_2 = arg_414_1:GetWordFromCfg(924041100)
				local var_417_3 = arg_414_1:FormatText(var_417_2.content)

				arg_414_1.text_.text = var_417_3

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 30
				local var_417_5 = utf8.len(var_417_3)
				local var_417_6 = var_417_4 <= 0 and var_417_1 or var_417_1 * (var_417_5 / var_417_4)

				if var_417_6 > 0 and var_417_1 < var_417_6 then
					arg_414_1.talkMaxDuration = var_417_6

					if var_417_6 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_3
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_7 and arg_414_1.time_ < var_417_0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play924041101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 924041101
		arg_418_1.duration_ = 5.73

		local var_418_0 = {
			zh = 5.633,
			ja = 5.733
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play924041102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = "SP92401"

			if arg_418_1.bgs_[var_421_0] == nil then
				local var_421_1 = Object.Instantiate(arg_418_1.paintGo_)

				var_421_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_421_0)
				var_421_1.name = var_421_0
				var_421_1.transform.parent = arg_418_1.stage_.transform
				var_421_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_418_1.bgs_[var_421_0] = var_421_1
			end

			local var_421_2 = 0

			if var_421_2 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				local var_421_3 = manager.ui.mainCamera.transform.localPosition
				local var_421_4 = Vector3.New(0, 0, 10) + Vector3.New(var_421_3.x, var_421_3.y, 0)
				local var_421_5 = arg_418_1.bgs_.SP92401

				var_421_5.transform.localPosition = var_421_4
				var_421_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_421_6 = var_421_5:GetComponent("SpriteRenderer")

				if var_421_6 and var_421_6.sprite then
					local var_421_7 = (var_421_5.transform.localPosition - var_421_3).z
					local var_421_8 = manager.ui.mainCameraCom_
					local var_421_9 = 2 * var_421_7 * Mathf.Tan(var_421_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_421_10 = var_421_9 * var_421_8.aspect
					local var_421_11 = var_421_6.sprite.bounds.size.x
					local var_421_12 = var_421_6.sprite.bounds.size.y
					local var_421_13 = var_421_10 / var_421_11
					local var_421_14 = var_421_9 / var_421_12
					local var_421_15 = var_421_14 < var_421_13 and var_421_13 or var_421_14

					var_421_5.transform.localScale = Vector3.New(var_421_15, var_421_15, 0)
				end

				for iter_421_0, iter_421_1 in pairs(arg_418_1.bgs_) do
					if iter_421_0 ~= "SP92401" then
						iter_421_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_421_16 = 2

			if var_421_16 < arg_418_1.time_ and arg_418_1.time_ <= var_421_16 + arg_421_0 then
				arg_418_1.allBtn_.enabled = false
			end

			local var_421_17 = 0.3

			if arg_418_1.time_ >= var_421_16 + var_421_17 and arg_418_1.time_ < var_421_16 + var_421_17 + arg_421_0 then
				arg_418_1.allBtn_.enabled = true
			end

			local var_421_18 = 0

			if var_421_18 < arg_418_1.time_ and arg_418_1.time_ <= var_421_18 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_19 = 2

			if var_421_18 <= arg_418_1.time_ and arg_418_1.time_ < var_421_18 + var_421_19 then
				local var_421_20 = (arg_418_1.time_ - var_421_18) / var_421_19
				local var_421_21 = Color.New(0, 0, 0)

				var_421_21.a = Mathf.Lerp(1, 0, var_421_20)
				arg_418_1.mask_.color = var_421_21
			end

			if arg_418_1.time_ >= var_421_18 + var_421_19 and arg_418_1.time_ < var_421_18 + var_421_19 + arg_421_0 then
				local var_421_22 = Color.New(0, 0, 0)
				local var_421_23 = 0

				arg_418_1.mask_.enabled = false
				var_421_22.a = var_421_23
				arg_418_1.mask_.color = var_421_22
			end

			local var_421_24 = 5.55111512312578e-17
			local var_421_25 = 1

			if var_421_24 < arg_418_1.time_ and arg_418_1.time_ <= var_421_24 + arg_421_0 then
				local var_421_26 = "play"
				local var_421_27 = "effect"

				arg_418_1:AudioAction(var_421_26, var_421_27, "se_story_141", "se_story_141_firework", "")
			end

			if arg_418_1.frameCnt_ <= 1 then
				arg_418_1.dialog_:SetActive(false)
			end

			local var_421_28 = 2
			local var_421_29 = 0.3

			if var_421_28 < arg_418_1.time_ and arg_418_1.time_ <= var_421_28 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0

				arg_418_1.dialog_:SetActive(true)

				arg_418_1.dialogCg_.alpha = 0

				local var_421_30 = LeanTween.value(arg_418_1.dialog_, 0, 1, 0.3)

				var_421_30:setOnUpdate(LuaHelper.FloatAction(function(arg_422_0)
					arg_418_1.dialogCg_.alpha = arg_422_0
				end))
				var_421_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_418_1.dialog_)
					var_421_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_418_1.duration_ = arg_418_1.duration_ + 0.3

				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_31 = arg_418_1:FormatText(StoryNameCfg[613].name)

				arg_418_1.leftNameTxt_.text = var_421_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_32 = arg_418_1:GetWordFromCfg(924041101)
				local var_421_33 = arg_418_1:FormatText(var_421_32.content)

				arg_418_1.text_.text = var_421_33

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_34 = 12
				local var_421_35 = utf8.len(var_421_33)
				local var_421_36 = var_421_34 <= 0 and var_421_29 or var_421_29 * (var_421_35 / var_421_34)

				if var_421_36 > 0 and var_421_29 < var_421_36 then
					arg_418_1.talkMaxDuration = var_421_36
					var_421_28 = var_421_28 + 0.3

					if var_421_36 + var_421_28 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_36 + var_421_28
					end
				end

				arg_418_1.text_.text = var_421_33
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb") ~= 0 then
					local var_421_37 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb") / 1000

					if var_421_37 + var_421_28 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_37 + var_421_28
					end

					if var_421_32.prefab_name ~= "" and arg_418_1.actors_[var_421_32.prefab_name] ~= nil then
						local var_421_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_32.prefab_name].transform, "story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb")

						arg_418_1:RecordAudio("924041101", var_421_38)
						arg_418_1:RecordAudio("924041101", var_421_38)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_39 = var_421_28 + 0.3
			local var_421_40 = math.max(var_421_29, arg_418_1.talkMaxDuration)

			if var_421_39 <= arg_418_1.time_ and arg_418_1.time_ < var_421_39 + var_421_40 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_39) / var_421_40

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_39 + var_421_40 and arg_418_1.time_ < var_421_39 + var_421_40 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play924041102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 924041102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play924041103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["102003ui_story"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect102003ui_story == nil then
				arg_424_1.var_.characterEffect102003ui_story = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect102003ui_story and not isNil(var_427_0) then
					local var_427_4 = Mathf.Lerp(0, 0.5, var_427_3)

					arg_424_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_424_1.var_.characterEffect102003ui_story.fillRatio = var_427_4
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect102003ui_story then
				local var_427_5 = 0.5

				arg_424_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_424_1.var_.characterEffect102003ui_story.fillRatio = var_427_5
			end

			local var_427_6 = 0
			local var_427_7 = 0.475

			if var_427_6 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_8 = arg_424_1:FormatText(StoryNameCfg[7].name)

				arg_424_1.leftNameTxt_.text = var_427_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_9 = arg_424_1:GetWordFromCfg(924041102)
				local var_427_10 = arg_424_1:FormatText(var_427_9.content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 19
				local var_427_12 = utf8.len(var_427_10)
				local var_427_13 = var_427_11 <= 0 and var_427_7 or var_427_7 * (var_427_12 / var_427_11)

				if var_427_13 > 0 and var_427_7 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_10
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_14 and arg_424_1.time_ < var_427_6 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play924041103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 924041103
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play924041104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 0.65

			if var_431_0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_2 = arg_428_1:FormatText(StoryNameCfg[7].name)

				arg_428_1.leftNameTxt_.text = var_431_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_3 = arg_428_1:GetWordFromCfg(924041103)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 26
				local var_431_6 = utf8.len(var_431_4)
				local var_431_7 = var_431_5 <= 0 and var_431_1 or var_431_1 * (var_431_6 / var_431_5)

				if var_431_7 > 0 and var_431_1 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_0
					end
				end

				arg_428_1.text_.text = var_431_4
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_8 = math.max(var_431_1, arg_428_1.talkMaxDuration)

			if var_431_0 <= arg_428_1.time_ and arg_428_1.time_ < var_431_0 + var_431_8 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_0) / var_431_8

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_0 + var_431_8 and arg_428_1.time_ < var_431_0 + var_431_8 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play924041104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 924041104
		arg_432_1.duration_ = 2

		local var_432_0 = {
			zh = 2,
			ja = 1.5
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play924041105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["102003ui_story"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect102003ui_story == nil then
				arg_432_1.var_.characterEffect102003ui_story = var_435_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.characterEffect102003ui_story and not isNil(var_435_0) then
					arg_432_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect102003ui_story then
				arg_432_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_435_4 = 0
			local var_435_5 = 0.05

			if var_435_4 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_6 = arg_432_1:FormatText(StoryNameCfg[613].name)

				arg_432_1.leftNameTxt_.text = var_435_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_7 = arg_432_1:GetWordFromCfg(924041104)
				local var_435_8 = arg_432_1:FormatText(var_435_7.content)

				arg_432_1.text_.text = var_435_8

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_9 = 2
				local var_435_10 = utf8.len(var_435_8)
				local var_435_11 = var_435_9 <= 0 and var_435_5 or var_435_5 * (var_435_10 / var_435_9)

				if var_435_11 > 0 and var_435_5 < var_435_11 then
					arg_432_1.talkMaxDuration = var_435_11

					if var_435_11 + var_435_4 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_11 + var_435_4
					end
				end

				arg_432_1.text_.text = var_435_8
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb") ~= 0 then
					local var_435_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb") / 1000

					if var_435_12 + var_435_4 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_12 + var_435_4
					end

					if var_435_7.prefab_name ~= "" and arg_432_1.actors_[var_435_7.prefab_name] ~= nil then
						local var_435_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_7.prefab_name].transform, "story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb")

						arg_432_1:RecordAudio("924041104", var_435_13)
						arg_432_1:RecordAudio("924041104", var_435_13)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_14 = math.max(var_435_5, arg_432_1.talkMaxDuration)

			if var_435_4 <= arg_432_1.time_ and arg_432_1.time_ < var_435_4 + var_435_14 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_4) / var_435_14

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_4 + var_435_14 and arg_432_1.time_ < var_435_4 + var_435_14 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play924041105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 924041105
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play924041106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["102003ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect102003ui_story == nil then
				arg_436_1.var_.characterEffect102003ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect102003ui_story and not isNil(var_439_0) then
					local var_439_4 = Mathf.Lerp(0, 0.5, var_439_3)

					arg_436_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_436_1.var_.characterEffect102003ui_story.fillRatio = var_439_4
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect102003ui_story then
				local var_439_5 = 0.5

				arg_436_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_436_1.var_.characterEffect102003ui_story.fillRatio = var_439_5
			end

			local var_439_6 = 0
			local var_439_7 = 0.725

			if var_439_6 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_8 = arg_436_1:FormatText(StoryNameCfg[7].name)

				arg_436_1.leftNameTxt_.text = var_439_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_9 = arg_436_1:GetWordFromCfg(924041105)
				local var_439_10 = arg_436_1:FormatText(var_439_9.content)

				arg_436_1.text_.text = var_439_10

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_11 = 29
				local var_439_12 = utf8.len(var_439_10)
				local var_439_13 = var_439_11 <= 0 and var_439_7 or var_439_7 * (var_439_12 / var_439_11)

				if var_439_13 > 0 and var_439_7 < var_439_13 then
					arg_436_1.talkMaxDuration = var_439_13

					if var_439_13 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_13 + var_439_6
					end
				end

				arg_436_1.text_.text = var_439_10
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_7, arg_436_1.talkMaxDuration)

			if var_439_6 <= arg_436_1.time_ and arg_436_1.time_ < var_439_6 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_6) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_6 + var_439_14 and arg_436_1.time_ < var_439_6 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play924041106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 924041106
		arg_440_1.duration_ = 1.47

		local var_440_0 = {
			zh = 1.033,
			ja = 1.466
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play924041107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["102003ui_story"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect102003ui_story == nil then
				arg_440_1.var_.characterEffect102003ui_story = var_443_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.characterEffect102003ui_story and not isNil(var_443_0) then
					arg_440_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect102003ui_story then
				arg_440_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_443_4 = 0
			local var_443_5 = 0.05

			if var_443_4 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_6 = arg_440_1:FormatText(StoryNameCfg[613].name)

				arg_440_1.leftNameTxt_.text = var_443_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_7 = arg_440_1:GetWordFromCfg(924041106)
				local var_443_8 = arg_440_1:FormatText(var_443_7.content)

				arg_440_1.text_.text = var_443_8

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_9 = 2
				local var_443_10 = utf8.len(var_443_8)
				local var_443_11 = var_443_9 <= 0 and var_443_5 or var_443_5 * (var_443_10 / var_443_9)

				if var_443_11 > 0 and var_443_5 < var_443_11 then
					arg_440_1.talkMaxDuration = var_443_11

					if var_443_11 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_11 + var_443_4
					end
				end

				arg_440_1.text_.text = var_443_8
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb") ~= 0 then
					local var_443_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb") / 1000

					if var_443_12 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_12 + var_443_4
					end

					if var_443_7.prefab_name ~= "" and arg_440_1.actors_[var_443_7.prefab_name] ~= nil then
						local var_443_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_7.prefab_name].transform, "story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb")

						arg_440_1:RecordAudio("924041106", var_443_13)
						arg_440_1:RecordAudio("924041106", var_443_13)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_5, arg_440_1.talkMaxDuration)

			if var_443_4 <= arg_440_1.time_ and arg_440_1.time_ < var_443_4 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_4) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_4 + var_443_14 and arg_440_1.time_ < var_443_4 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play924041107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 924041107
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play924041108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["102003ui_story"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect102003ui_story == nil then
				arg_444_1.var_.characterEffect102003ui_story = var_447_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.characterEffect102003ui_story and not isNil(var_447_0) then
					local var_447_4 = Mathf.Lerp(0, 0.5, var_447_3)

					arg_444_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_444_1.var_.characterEffect102003ui_story.fillRatio = var_447_4
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect102003ui_story then
				local var_447_5 = 0.5

				arg_444_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_444_1.var_.characterEffect102003ui_story.fillRatio = var_447_5
			end

			local var_447_6 = 0
			local var_447_7 = 0.225

			if var_447_6 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_8 = arg_444_1:FormatText(StoryNameCfg[7].name)

				arg_444_1.leftNameTxt_.text = var_447_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_9 = arg_444_1:GetWordFromCfg(924041107)
				local var_447_10 = arg_444_1:FormatText(var_447_9.content)

				arg_444_1.text_.text = var_447_10

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_11 = 9
				local var_447_12 = utf8.len(var_447_10)
				local var_447_13 = var_447_11 <= 0 and var_447_7 or var_447_7 * (var_447_12 / var_447_11)

				if var_447_13 > 0 and var_447_7 < var_447_13 then
					arg_444_1.talkMaxDuration = var_447_13

					if var_447_13 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_13 + var_447_6
					end
				end

				arg_444_1.text_.text = var_447_10
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_14 = math.max(var_447_7, arg_444_1.talkMaxDuration)

			if var_447_6 <= arg_444_1.time_ and arg_444_1.time_ < var_447_6 + var_447_14 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_6) / var_447_14

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_6 + var_447_14 and arg_444_1.time_ < var_447_6 + var_447_14 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play924041108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 924041108
		arg_448_1.duration_ = 1.3

		local var_448_0 = {
			zh = 1.3,
			ja = 1.133
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play924041109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["102003ui_story"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect102003ui_story == nil then
				arg_448_1.var_.characterEffect102003ui_story = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect102003ui_story and not isNil(var_451_0) then
					arg_448_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect102003ui_story then
				arg_448_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_451_4 = 0
			local var_451_5 = 0.15

			if var_451_4 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_6 = arg_448_1:FormatText(StoryNameCfg[613].name)

				arg_448_1.leftNameTxt_.text = var_451_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_7 = arg_448_1:GetWordFromCfg(924041108)
				local var_451_8 = arg_448_1:FormatText(var_451_7.content)

				arg_448_1.text_.text = var_451_8

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_9 = 6
				local var_451_10 = utf8.len(var_451_8)
				local var_451_11 = var_451_9 <= 0 and var_451_5 or var_451_5 * (var_451_10 / var_451_9)

				if var_451_11 > 0 and var_451_5 < var_451_11 then
					arg_448_1.talkMaxDuration = var_451_11

					if var_451_11 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_11 + var_451_4
					end
				end

				arg_448_1.text_.text = var_451_8
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb") ~= 0 then
					local var_451_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb") / 1000

					if var_451_12 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_12 + var_451_4
					end

					if var_451_7.prefab_name ~= "" and arg_448_1.actors_[var_451_7.prefab_name] ~= nil then
						local var_451_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_7.prefab_name].transform, "story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb")

						arg_448_1:RecordAudio("924041108", var_451_13)
						arg_448_1:RecordAudio("924041108", var_451_13)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_14 = math.max(var_451_5, arg_448_1.talkMaxDuration)

			if var_451_4 <= arg_448_1.time_ and arg_448_1.time_ < var_451_4 + var_451_14 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_4) / var_451_14

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_4 + var_451_14 and arg_448_1.time_ < var_451_4 + var_451_14 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play924041109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 924041109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play924041110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["102003ui_story"]
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect102003ui_story == nil then
				arg_452_1.var_.characterEffect102003ui_story = var_455_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 and not isNil(var_455_0) then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2

				if arg_452_1.var_.characterEffect102003ui_story and not isNil(var_455_0) then
					local var_455_4 = Mathf.Lerp(0, 0.5, var_455_3)

					arg_452_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_452_1.var_.characterEffect102003ui_story.fillRatio = var_455_4
				end
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 and not isNil(var_455_0) and arg_452_1.var_.characterEffect102003ui_story then
				local var_455_5 = 0.5

				arg_452_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_452_1.var_.characterEffect102003ui_story.fillRatio = var_455_5
			end

			local var_455_6 = 0
			local var_455_7 = 0.275

			if var_455_6 < arg_452_1.time_ and arg_452_1.time_ <= var_455_6 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_8 = arg_452_1:FormatText(StoryNameCfg[7].name)

				arg_452_1.leftNameTxt_.text = var_455_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_9 = arg_452_1:GetWordFromCfg(924041109)
				local var_455_10 = arg_452_1:FormatText(var_455_9.content)

				arg_452_1.text_.text = var_455_10

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_11 = 11
				local var_455_12 = utf8.len(var_455_10)
				local var_455_13 = var_455_11 <= 0 and var_455_7 or var_455_7 * (var_455_12 / var_455_11)

				if var_455_13 > 0 and var_455_7 < var_455_13 then
					arg_452_1.talkMaxDuration = var_455_13

					if var_455_13 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_13 + var_455_6
					end
				end

				arg_452_1.text_.text = var_455_10
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_14 = math.max(var_455_7, arg_452_1.talkMaxDuration)

			if var_455_6 <= arg_452_1.time_ and arg_452_1.time_ < var_455_6 + var_455_14 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_6) / var_455_14

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_6 + var_455_14 and arg_452_1.time_ < var_455_6 + var_455_14 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play924041110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 924041110
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play924041111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = "SP92401b"

			if arg_456_1.bgs_[var_459_0] == nil then
				local var_459_1 = Object.Instantiate(arg_456_1.paintGo_)

				var_459_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_459_0)
				var_459_1.name = var_459_0
				var_459_1.transform.parent = arg_456_1.stage_.transform
				var_459_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_456_1.bgs_[var_459_0] = var_459_1
			end

			local var_459_2 = 0

			if var_459_2 < arg_456_1.time_ and arg_456_1.time_ <= var_459_2 + arg_459_0 then
				local var_459_3 = manager.ui.mainCamera.transform.localPosition
				local var_459_4 = Vector3.New(0, 0, 10) + Vector3.New(var_459_3.x, var_459_3.y, 0)
				local var_459_5 = arg_456_1.bgs_.SP92401b

				var_459_5.transform.localPosition = var_459_4
				var_459_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_459_6 = var_459_5:GetComponent("SpriteRenderer")

				if var_459_6 and var_459_6.sprite then
					local var_459_7 = (var_459_5.transform.localPosition - var_459_3).z
					local var_459_8 = manager.ui.mainCameraCom_
					local var_459_9 = 2 * var_459_7 * Mathf.Tan(var_459_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_459_10 = var_459_9 * var_459_8.aspect
					local var_459_11 = var_459_6.sprite.bounds.size.x
					local var_459_12 = var_459_6.sprite.bounds.size.y
					local var_459_13 = var_459_10 / var_459_11
					local var_459_14 = var_459_9 / var_459_12
					local var_459_15 = var_459_14 < var_459_13 and var_459_13 or var_459_14

					var_459_5.transform.localScale = Vector3.New(var_459_15, var_459_15, 0)
				end

				for iter_459_0, iter_459_1 in pairs(arg_456_1.bgs_) do
					if iter_459_0 ~= "SP92401b" then
						iter_459_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_459_16 = 0

			if var_459_16 < arg_456_1.time_ and arg_456_1.time_ <= var_459_16 + arg_459_0 then
				arg_456_1.allBtn_.enabled = false
			end

			local var_459_17 = 0.3

			if arg_456_1.time_ >= var_459_16 + var_459_17 and arg_456_1.time_ < var_459_16 + var_459_17 + arg_459_0 then
				arg_456_1.allBtn_.enabled = true
			end

			local var_459_18 = 0

			if var_459_18 < arg_456_1.time_ and arg_456_1.time_ <= var_459_18 + arg_459_0 then
				arg_456_1.mask_.enabled = true
				arg_456_1.mask_.raycastTarget = true

				arg_456_1:SetGaussion(false)
			end

			local var_459_19 = 2

			if var_459_18 <= arg_456_1.time_ and arg_456_1.time_ < var_459_18 + var_459_19 then
				local var_459_20 = (arg_456_1.time_ - var_459_18) / var_459_19
				local var_459_21 = Color.New(0, 0, 0)

				var_459_21.a = Mathf.Lerp(1, 0, var_459_20)
				arg_456_1.mask_.color = var_459_21
			end

			if arg_456_1.time_ >= var_459_18 + var_459_19 and arg_456_1.time_ < var_459_18 + var_459_19 + arg_459_0 then
				local var_459_22 = Color.New(0, 0, 0)
				local var_459_23 = 0

				arg_456_1.mask_.enabled = false
				var_459_22.a = var_459_23
				arg_456_1.mask_.color = var_459_22
			end

			local var_459_24 = 0
			local var_459_25 = 1.275

			if var_459_24 < arg_456_1.time_ and arg_456_1.time_ <= var_459_24 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0

				arg_456_1.dialog_:SetActive(true)

				arg_456_1.dialogCg_.alpha = 0

				local var_459_26 = LeanTween.value(arg_456_1.dialog_, 0, 1, 0.3)

				var_459_26:setOnUpdate(LuaHelper.FloatAction(function(arg_460_0)
					arg_456_1.dialogCg_.alpha = arg_460_0
				end))
				var_459_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_456_1.dialog_)
					var_459_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_456_1.duration_ = arg_456_1.duration_ + 0.3

				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_27 = arg_456_1:GetWordFromCfg(924041110)
				local var_459_28 = arg_456_1:FormatText(var_459_27.content)

				arg_456_1.text_.text = var_459_28

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_29 = 51
				local var_459_30 = utf8.len(var_459_28)
				local var_459_31 = var_459_29 <= 0 and var_459_25 or var_459_25 * (var_459_30 / var_459_29)

				if var_459_31 > 0 and var_459_25 < var_459_31 then
					arg_456_1.talkMaxDuration = var_459_31
					var_459_24 = var_459_24 + 0.3

					if var_459_31 + var_459_24 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_31 + var_459_24
					end
				end

				arg_456_1.text_.text = var_459_28
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_32 = var_459_24 + 0.3
			local var_459_33 = math.max(var_459_25, arg_456_1.talkMaxDuration)

			if var_459_32 <= arg_456_1.time_ and arg_456_1.time_ < var_459_32 + var_459_33 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_32) / var_459_33

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_32 + var_459_33 and arg_456_1.time_ < var_459_32 + var_459_33 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play924041111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 924041111
		arg_462_1.duration_ = 4.77

		local var_462_0 = {
			zh = 4.766,
			ja = 3.3
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play924041112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = arg_462_1.actors_["102003ui_story"]
			local var_465_1 = 0

			if var_465_1 < arg_462_1.time_ and arg_462_1.time_ <= var_465_1 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect102003ui_story == nil then
				arg_462_1.var_.characterEffect102003ui_story = var_465_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_2 = 0.200000002980232

			if var_465_1 <= arg_462_1.time_ and arg_462_1.time_ < var_465_1 + var_465_2 and not isNil(var_465_0) then
				local var_465_3 = (arg_462_1.time_ - var_465_1) / var_465_2

				if arg_462_1.var_.characterEffect102003ui_story and not isNil(var_465_0) then
					arg_462_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= var_465_1 + var_465_2 and arg_462_1.time_ < var_465_1 + var_465_2 + arg_465_0 and not isNil(var_465_0) and arg_462_1.var_.characterEffect102003ui_story then
				arg_462_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_465_4 = 0
			local var_465_5 = 0.325

			if var_465_4 < arg_462_1.time_ and arg_462_1.time_ <= var_465_4 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_6 = arg_462_1:FormatText(StoryNameCfg[613].name)

				arg_462_1.leftNameTxt_.text = var_465_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_7 = arg_462_1:GetWordFromCfg(924041111)
				local var_465_8 = arg_462_1:FormatText(var_465_7.content)

				arg_462_1.text_.text = var_465_8

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_9 = 13
				local var_465_10 = utf8.len(var_465_8)
				local var_465_11 = var_465_9 <= 0 and var_465_5 or var_465_5 * (var_465_10 / var_465_9)

				if var_465_11 > 0 and var_465_5 < var_465_11 then
					arg_462_1.talkMaxDuration = var_465_11

					if var_465_11 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_11 + var_465_4
					end
				end

				arg_462_1.text_.text = var_465_8
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb") ~= 0 then
					local var_465_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb") / 1000

					if var_465_12 + var_465_4 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_12 + var_465_4
					end

					if var_465_7.prefab_name ~= "" and arg_462_1.actors_[var_465_7.prefab_name] ~= nil then
						local var_465_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_7.prefab_name].transform, "story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb")

						arg_462_1:RecordAudio("924041111", var_465_13)
						arg_462_1:RecordAudio("924041111", var_465_13)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_14 = math.max(var_465_5, arg_462_1.talkMaxDuration)

			if var_465_4 <= arg_462_1.time_ and arg_462_1.time_ < var_465_4 + var_465_14 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_4) / var_465_14

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_4 + var_465_14 and arg_462_1.time_ < var_465_4 + var_465_14 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play924041112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 924041112
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play924041113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["102003ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect102003ui_story == nil then
				arg_466_1.var_.characterEffect102003ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect102003ui_story and not isNil(var_469_0) then
					local var_469_4 = Mathf.Lerp(0, 0.5, var_469_3)

					arg_466_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_466_1.var_.characterEffect102003ui_story.fillRatio = var_469_4
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect102003ui_story then
				local var_469_5 = 0.5

				arg_466_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_466_1.var_.characterEffect102003ui_story.fillRatio = var_469_5
			end

			local var_469_6 = 0
			local var_469_7 = 0.25

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_8 = arg_466_1:FormatText(StoryNameCfg[7].name)

				arg_466_1.leftNameTxt_.text = var_469_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_9 = arg_466_1:GetWordFromCfg(924041112)
				local var_469_10 = arg_466_1:FormatText(var_469_9.content)

				arg_466_1.text_.text = var_469_10

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 10
				local var_469_12 = utf8.len(var_469_10)
				local var_469_13 = var_469_11 <= 0 and var_469_7 or var_469_7 * (var_469_12 / var_469_11)

				if var_469_13 > 0 and var_469_7 < var_469_13 then
					arg_466_1.talkMaxDuration = var_469_13

					if var_469_13 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_13 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_10
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_14 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_14 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_14

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_14 and arg_466_1.time_ < var_469_6 + var_469_14 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play924041113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 924041113
		arg_470_1.duration_ = 10.03

		local var_470_0 = {
			zh = 7.633,
			ja = 10.033
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play924041114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["102003ui_story"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect102003ui_story == nil then
				arg_470_1.var_.characterEffect102003ui_story = var_473_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.characterEffect102003ui_story and not isNil(var_473_0) then
					arg_470_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect102003ui_story then
				arg_470_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_473_4 = 0
			local var_473_5 = 0.85

			if var_473_4 < arg_470_1.time_ and arg_470_1.time_ <= var_473_4 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_6 = arg_470_1:FormatText(StoryNameCfg[613].name)

				arg_470_1.leftNameTxt_.text = var_473_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_7 = arg_470_1:GetWordFromCfg(924041113)
				local var_473_8 = arg_470_1:FormatText(var_473_7.content)

				arg_470_1.text_.text = var_473_8

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_9 = 34
				local var_473_10 = utf8.len(var_473_8)
				local var_473_11 = var_473_9 <= 0 and var_473_5 or var_473_5 * (var_473_10 / var_473_9)

				if var_473_11 > 0 and var_473_5 < var_473_11 then
					arg_470_1.talkMaxDuration = var_473_11

					if var_473_11 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_11 + var_473_4
					end
				end

				arg_470_1.text_.text = var_473_8
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb") ~= 0 then
					local var_473_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb") / 1000

					if var_473_12 + var_473_4 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_12 + var_473_4
					end

					if var_473_7.prefab_name ~= "" and arg_470_1.actors_[var_473_7.prefab_name] ~= nil then
						local var_473_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_7.prefab_name].transform, "story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb")

						arg_470_1:RecordAudio("924041113", var_473_13)
						arg_470_1:RecordAudio("924041113", var_473_13)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_14 = math.max(var_473_5, arg_470_1.talkMaxDuration)

			if var_473_4 <= arg_470_1.time_ and arg_470_1.time_ < var_473_4 + var_473_14 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_4) / var_473_14

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_4 + var_473_14 and arg_470_1.time_ < var_473_4 + var_473_14 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play924041114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 924041114
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play924041115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = arg_474_1.actors_["102003ui_story"]
			local var_477_1 = 0

			if var_477_1 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect102003ui_story == nil then
				arg_474_1.var_.characterEffect102003ui_story = var_477_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_2 = 0.200000002980232

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_2 and not isNil(var_477_0) then
				local var_477_3 = (arg_474_1.time_ - var_477_1) / var_477_2

				if arg_474_1.var_.characterEffect102003ui_story and not isNil(var_477_0) then
					local var_477_4 = Mathf.Lerp(0, 0.5, var_477_3)

					arg_474_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_474_1.var_.characterEffect102003ui_story.fillRatio = var_477_4
				end
			end

			if arg_474_1.time_ >= var_477_1 + var_477_2 and arg_474_1.time_ < var_477_1 + var_477_2 + arg_477_0 and not isNil(var_477_0) and arg_474_1.var_.characterEffect102003ui_story then
				local var_477_5 = 0.5

				arg_474_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_474_1.var_.characterEffect102003ui_story.fillRatio = var_477_5
			end

			local var_477_6 = 0
			local var_477_7 = 1.3

			if var_477_6 < arg_474_1.time_ and arg_474_1.time_ <= var_477_6 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_8 = arg_474_1:FormatText(StoryNameCfg[7].name)

				arg_474_1.leftNameTxt_.text = var_477_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_9 = arg_474_1:GetWordFromCfg(924041114)
				local var_477_10 = arg_474_1:FormatText(var_477_9.content)

				arg_474_1.text_.text = var_477_10

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_11 = 52
				local var_477_12 = utf8.len(var_477_10)
				local var_477_13 = var_477_11 <= 0 and var_477_7 or var_477_7 * (var_477_12 / var_477_11)

				if var_477_13 > 0 and var_477_7 < var_477_13 then
					arg_474_1.talkMaxDuration = var_477_13

					if var_477_13 + var_477_6 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_13 + var_477_6
					end
				end

				arg_474_1.text_.text = var_477_10
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_14 = math.max(var_477_7, arg_474_1.talkMaxDuration)

			if var_477_6 <= arg_474_1.time_ and arg_474_1.time_ < var_477_6 + var_477_14 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_6) / var_477_14

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_6 + var_477_14 and arg_474_1.time_ < var_477_6 + var_477_14 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play924041115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 924041115
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play924041116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 0.325

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_2 = arg_478_1:GetWordFromCfg(924041115)
				local var_481_3 = arg_478_1:FormatText(var_481_2.content)

				arg_478_1.text_.text = var_481_3

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_4 = 13
				local var_481_5 = utf8.len(var_481_3)
				local var_481_6 = var_481_4 <= 0 and var_481_1 or var_481_1 * (var_481_5 / var_481_4)

				if var_481_6 > 0 and var_481_1 < var_481_6 then
					arg_478_1.talkMaxDuration = var_481_6

					if var_481_6 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_6 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_3
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_7 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_7 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_7

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_7 and arg_478_1.time_ < var_481_0 + var_481_7 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play924041116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 924041116
		arg_482_1.duration_ = 6.57

		local var_482_0 = {
			zh = 6.566,
			ja = 6.133
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play924041117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = arg_482_1.actors_["102003ui_story"]
			local var_485_1 = 0

			if var_485_1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect102003ui_story == nil then
				arg_482_1.var_.characterEffect102003ui_story = var_485_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_2 and not isNil(var_485_0) then
				local var_485_3 = (arg_482_1.time_ - var_485_1) / var_485_2

				if arg_482_1.var_.characterEffect102003ui_story and not isNil(var_485_0) then
					arg_482_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= var_485_1 + var_485_2 and arg_482_1.time_ < var_485_1 + var_485_2 + arg_485_0 and not isNil(var_485_0) and arg_482_1.var_.characterEffect102003ui_story then
				arg_482_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_485_4 = 0
			local var_485_5 = 0.425

			if var_485_4 < arg_482_1.time_ and arg_482_1.time_ <= var_485_4 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_6 = arg_482_1:FormatText(StoryNameCfg[613].name)

				arg_482_1.leftNameTxt_.text = var_485_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_7 = arg_482_1:GetWordFromCfg(924041116)
				local var_485_8 = arg_482_1:FormatText(var_485_7.content)

				arg_482_1.text_.text = var_485_8

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_9 = 17
				local var_485_10 = utf8.len(var_485_8)
				local var_485_11 = var_485_9 <= 0 and var_485_5 or var_485_5 * (var_485_10 / var_485_9)

				if var_485_11 > 0 and var_485_5 < var_485_11 then
					arg_482_1.talkMaxDuration = var_485_11

					if var_485_11 + var_485_4 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_11 + var_485_4
					end
				end

				arg_482_1.text_.text = var_485_8
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb") ~= 0 then
					local var_485_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb") / 1000

					if var_485_12 + var_485_4 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_12 + var_485_4
					end

					if var_485_7.prefab_name ~= "" and arg_482_1.actors_[var_485_7.prefab_name] ~= nil then
						local var_485_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_7.prefab_name].transform, "story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb")

						arg_482_1:RecordAudio("924041116", var_485_13)
						arg_482_1:RecordAudio("924041116", var_485_13)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_14 = math.max(var_485_5, arg_482_1.talkMaxDuration)

			if var_485_4 <= arg_482_1.time_ and arg_482_1.time_ < var_485_4 + var_485_14 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_4) / var_485_14

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_4 + var_485_14 and arg_482_1.time_ < var_485_4 + var_485_14 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play924041117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 924041117
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play924041118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = arg_486_1.actors_["102003ui_story"]
			local var_489_1 = 0

			if var_489_1 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect102003ui_story == nil then
				arg_486_1.var_.characterEffect102003ui_story = var_489_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_2 and not isNil(var_489_0) then
				local var_489_3 = (arg_486_1.time_ - var_489_1) / var_489_2

				if arg_486_1.var_.characterEffect102003ui_story and not isNil(var_489_0) then
					local var_489_4 = Mathf.Lerp(0, 0.5, var_489_3)

					arg_486_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_486_1.var_.characterEffect102003ui_story.fillRatio = var_489_4
				end
			end

			if arg_486_1.time_ >= var_489_1 + var_489_2 and arg_486_1.time_ < var_489_1 + var_489_2 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect102003ui_story then
				local var_489_5 = 0.5

				arg_486_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_486_1.var_.characterEffect102003ui_story.fillRatio = var_489_5
			end

			local var_489_6 = 0
			local var_489_7 = 0.925

			if var_489_6 < arg_486_1.time_ and arg_486_1.time_ <= var_489_6 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_8 = arg_486_1:FormatText(StoryNameCfg[7].name)

				arg_486_1.leftNameTxt_.text = var_489_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_9 = arg_486_1:GetWordFromCfg(924041117)
				local var_489_10 = arg_486_1:FormatText(var_489_9.content)

				arg_486_1.text_.text = var_489_10

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_11 = 37
				local var_489_12 = utf8.len(var_489_10)
				local var_489_13 = var_489_11 <= 0 and var_489_7 or var_489_7 * (var_489_12 / var_489_11)

				if var_489_13 > 0 and var_489_7 < var_489_13 then
					arg_486_1.talkMaxDuration = var_489_13

					if var_489_13 + var_489_6 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_13 + var_489_6
					end
				end

				arg_486_1.text_.text = var_489_10
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_14 = math.max(var_489_7, arg_486_1.talkMaxDuration)

			if var_489_6 <= arg_486_1.time_ and arg_486_1.time_ < var_489_6 + var_489_14 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_6) / var_489_14

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_6 + var_489_14 and arg_486_1.time_ < var_489_6 + var_489_14 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play924041118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 924041118
		arg_490_1.duration_ = 1.73

		local var_490_0 = {
			zh = 1.533,
			ja = 1.733
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play924041119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["102003ui_story"]
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect102003ui_story == nil then
				arg_490_1.var_.characterEffect102003ui_story = var_493_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_2 = 0.200000002980232

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_2 and not isNil(var_493_0) then
				local var_493_3 = (arg_490_1.time_ - var_493_1) / var_493_2

				if arg_490_1.var_.characterEffect102003ui_story and not isNil(var_493_0) then
					arg_490_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= var_493_1 + var_493_2 and arg_490_1.time_ < var_493_1 + var_493_2 + arg_493_0 and not isNil(var_493_0) and arg_490_1.var_.characterEffect102003ui_story then
				arg_490_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_493_4 = 0
			local var_493_5 = 0.1

			if var_493_4 < arg_490_1.time_ and arg_490_1.time_ <= var_493_4 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_6 = arg_490_1:FormatText(StoryNameCfg[613].name)

				arg_490_1.leftNameTxt_.text = var_493_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_7 = arg_490_1:GetWordFromCfg(924041118)
				local var_493_8 = arg_490_1:FormatText(var_493_7.content)

				arg_490_1.text_.text = var_493_8

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_9 = 4
				local var_493_10 = utf8.len(var_493_8)
				local var_493_11 = var_493_9 <= 0 and var_493_5 or var_493_5 * (var_493_10 / var_493_9)

				if var_493_11 > 0 and var_493_5 < var_493_11 then
					arg_490_1.talkMaxDuration = var_493_11

					if var_493_11 + var_493_4 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_11 + var_493_4
					end
				end

				arg_490_1.text_.text = var_493_8
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb") ~= 0 then
					local var_493_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb") / 1000

					if var_493_12 + var_493_4 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_12 + var_493_4
					end

					if var_493_7.prefab_name ~= "" and arg_490_1.actors_[var_493_7.prefab_name] ~= nil then
						local var_493_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_7.prefab_name].transform, "story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb")

						arg_490_1:RecordAudio("924041118", var_493_13)
						arg_490_1:RecordAudio("924041118", var_493_13)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_14 = math.max(var_493_5, arg_490_1.talkMaxDuration)

			if var_493_4 <= arg_490_1.time_ and arg_490_1.time_ < var_493_4 + var_493_14 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_4) / var_493_14

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_4 + var_493_14 and arg_490_1.time_ < var_493_4 + var_493_14 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play924041119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 924041119
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play924041120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["102003ui_story"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect102003ui_story == nil then
				arg_494_1.var_.characterEffect102003ui_story = var_497_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.characterEffect102003ui_story and not isNil(var_497_0) then
					local var_497_4 = Mathf.Lerp(0, 0.5, var_497_3)

					arg_494_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_494_1.var_.characterEffect102003ui_story.fillRatio = var_497_4
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect102003ui_story then
				local var_497_5 = 0.5

				arg_494_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_494_1.var_.characterEffect102003ui_story.fillRatio = var_497_5
			end

			local var_497_6 = 0
			local var_497_7 = 0.55

			if var_497_6 < arg_494_1.time_ and arg_494_1.time_ <= var_497_6 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_8 = arg_494_1:FormatText(StoryNameCfg[7].name)

				arg_494_1.leftNameTxt_.text = var_497_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_9 = arg_494_1:GetWordFromCfg(924041119)
				local var_497_10 = arg_494_1:FormatText(var_497_9.content)

				arg_494_1.text_.text = var_497_10

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_11 = 22
				local var_497_12 = utf8.len(var_497_10)
				local var_497_13 = var_497_11 <= 0 and var_497_7 or var_497_7 * (var_497_12 / var_497_11)

				if var_497_13 > 0 and var_497_7 < var_497_13 then
					arg_494_1.talkMaxDuration = var_497_13

					if var_497_13 + var_497_6 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_13 + var_497_6
					end
				end

				arg_494_1.text_.text = var_497_10
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_14 = math.max(var_497_7, arg_494_1.talkMaxDuration)

			if var_497_6 <= arg_494_1.time_ and arg_494_1.time_ < var_497_6 + var_497_14 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_6) / var_497_14

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_6 + var_497_14 and arg_494_1.time_ < var_497_6 + var_497_14 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play924041120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 924041120
		arg_498_1.duration_ = 4.3

		local var_498_0 = {
			zh = 3.6,
			ja = 4.3
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play924041121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["102003ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect102003ui_story == nil then
				arg_498_1.var_.characterEffect102003ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect102003ui_story and not isNil(var_501_0) then
					arg_498_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect102003ui_story then
				arg_498_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_501_4 = 0
			local var_501_5 = 0.25

			if var_501_4 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_6 = arg_498_1:FormatText(StoryNameCfg[613].name)

				arg_498_1.leftNameTxt_.text = var_501_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_7 = arg_498_1:GetWordFromCfg(924041120)
				local var_501_8 = arg_498_1:FormatText(var_501_7.content)

				arg_498_1.text_.text = var_501_8

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 10
				local var_501_10 = utf8.len(var_501_8)
				local var_501_11 = var_501_9 <= 0 and var_501_5 or var_501_5 * (var_501_10 / var_501_9)

				if var_501_11 > 0 and var_501_5 < var_501_11 then
					arg_498_1.talkMaxDuration = var_501_11

					if var_501_11 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_11 + var_501_4
					end
				end

				arg_498_1.text_.text = var_501_8
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb") ~= 0 then
					local var_501_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb") / 1000

					if var_501_12 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_12 + var_501_4
					end

					if var_501_7.prefab_name ~= "" and arg_498_1.actors_[var_501_7.prefab_name] ~= nil then
						local var_501_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_7.prefab_name].transform, "story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb")

						arg_498_1:RecordAudio("924041120", var_501_13)
						arg_498_1:RecordAudio("924041120", var_501_13)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_14 = math.max(var_501_5, arg_498_1.talkMaxDuration)

			if var_501_4 <= arg_498_1.time_ and arg_498_1.time_ < var_501_4 + var_501_14 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_4) / var_501_14

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_4 + var_501_14 and arg_498_1.time_ < var_501_4 + var_501_14 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play924041121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 924041121
		arg_502_1.duration_ = 7

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play924041122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				local var_505_1 = manager.ui.mainCamera.transform.localPosition
				local var_505_2 = Vector3.New(0, 0, 10) + Vector3.New(var_505_1.x, var_505_1.y, 0)
				local var_505_3 = arg_502_1.bgs_.ST0107

				var_505_3.transform.localPosition = var_505_2
				var_505_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_505_4 = var_505_3:GetComponent("SpriteRenderer")

				if var_505_4 and var_505_4.sprite then
					local var_505_5 = (var_505_3.transform.localPosition - var_505_1).z
					local var_505_6 = manager.ui.mainCameraCom_
					local var_505_7 = 2 * var_505_5 * Mathf.Tan(var_505_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_505_8 = var_505_7 * var_505_6.aspect
					local var_505_9 = var_505_4.sprite.bounds.size.x
					local var_505_10 = var_505_4.sprite.bounds.size.y
					local var_505_11 = var_505_8 / var_505_9
					local var_505_12 = var_505_7 / var_505_10
					local var_505_13 = var_505_12 < var_505_11 and var_505_11 or var_505_12

					var_505_3.transform.localScale = Vector3.New(var_505_13, var_505_13, 0)
				end

				for iter_505_0, iter_505_1 in pairs(arg_502_1.bgs_) do
					if iter_505_0 ~= "ST0107" then
						iter_505_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_505_14 = 2

			if var_505_14 < arg_502_1.time_ and arg_502_1.time_ <= var_505_14 + arg_505_0 then
				arg_502_1.allBtn_.enabled = false
			end

			local var_505_15 = 0.3

			if arg_502_1.time_ >= var_505_14 + var_505_15 and arg_502_1.time_ < var_505_14 + var_505_15 + arg_505_0 then
				arg_502_1.allBtn_.enabled = true
			end

			local var_505_16 = 0

			if var_505_16 < arg_502_1.time_ and arg_502_1.time_ <= var_505_16 + arg_505_0 then
				arg_502_1.mask_.enabled = true
				arg_502_1.mask_.raycastTarget = true

				arg_502_1:SetGaussion(false)
			end

			local var_505_17 = 2

			if var_505_16 <= arg_502_1.time_ and arg_502_1.time_ < var_505_16 + var_505_17 then
				local var_505_18 = (arg_502_1.time_ - var_505_16) / var_505_17
				local var_505_19 = Color.New(0, 0, 0)

				var_505_19.a = Mathf.Lerp(1, 0, var_505_18)
				arg_502_1.mask_.color = var_505_19
			end

			if arg_502_1.time_ >= var_505_16 + var_505_17 and arg_502_1.time_ < var_505_16 + var_505_17 + arg_505_0 then
				local var_505_20 = Color.New(0, 0, 0)
				local var_505_21 = 0

				arg_502_1.mask_.enabled = false
				var_505_20.a = var_505_21
				arg_502_1.mask_.color = var_505_20
			end

			local var_505_22 = 0.125
			local var_505_23 = 1

			if var_505_22 < arg_502_1.time_ and arg_502_1.time_ <= var_505_22 + arg_505_0 then
				local var_505_24 = "stop"
				local var_505_25 = "effect"

				arg_502_1:AudioAction(var_505_24, var_505_25, "se_story_141", "se_story_141_firework", "")
			end

			if arg_502_1.frameCnt_ <= 1 then
				arg_502_1.dialog_:SetActive(false)
			end

			local var_505_26 = 2
			local var_505_27 = 0.6

			if var_505_26 < arg_502_1.time_ and arg_502_1.time_ <= var_505_26 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0

				arg_502_1.dialog_:SetActive(true)

				arg_502_1.dialogCg_.alpha = 0

				local var_505_28 = LeanTween.value(arg_502_1.dialog_, 0, 1, 0.3)

				var_505_28:setOnUpdate(LuaHelper.FloatAction(function(arg_506_0)
					arg_502_1.dialogCg_.alpha = arg_506_0
				end))
				var_505_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_502_1.dialog_)
					var_505_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_502_1.duration_ = arg_502_1.duration_ + 0.3

				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_29 = arg_502_1:GetWordFromCfg(924041121)
				local var_505_30 = arg_502_1:FormatText(var_505_29.content)

				arg_502_1.text_.text = var_505_30

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_31 = 24
				local var_505_32 = utf8.len(var_505_30)
				local var_505_33 = var_505_31 <= 0 and var_505_27 or var_505_27 * (var_505_32 / var_505_31)

				if var_505_33 > 0 and var_505_27 < var_505_33 then
					arg_502_1.talkMaxDuration = var_505_33
					var_505_26 = var_505_26 + 0.3

					if var_505_33 + var_505_26 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_33 + var_505_26
					end
				end

				arg_502_1.text_.text = var_505_30
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_34 = var_505_26 + 0.3
			local var_505_35 = math.max(var_505_27, arg_502_1.talkMaxDuration)

			if var_505_34 <= arg_502_1.time_ and arg_502_1.time_ < var_505_34 + var_505_35 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_34) / var_505_35

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_34 + var_505_35 and arg_502_1.time_ < var_505_34 + var_505_35 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play924041122 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 924041122
		arg_508_1.duration_ = 8.8

		local var_508_0 = {
			zh = 8.8,
			ja = 8.166
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play924041123(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["102003ui_story"].transform
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1.var_.moveOldPos102003ui_story = var_511_0.localPosition
			end

			local var_511_2 = 0.001

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2
				local var_511_4 = Vector3.New(0, -0.85, -6.21)

				var_511_0.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos102003ui_story, var_511_4, var_511_3)

				local var_511_5 = manager.ui.mainCamera.transform.position - var_511_0.position

				var_511_0.forward = Vector3.New(var_511_5.x, var_511_5.y, var_511_5.z)

				local var_511_6 = var_511_0.localEulerAngles

				var_511_6.z = 0
				var_511_6.x = 0
				var_511_0.localEulerAngles = var_511_6
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 then
				var_511_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_511_7 = manager.ui.mainCamera.transform.position - var_511_0.position

				var_511_0.forward = Vector3.New(var_511_7.x, var_511_7.y, var_511_7.z)

				local var_511_8 = var_511_0.localEulerAngles

				var_511_8.z = 0
				var_511_8.x = 0
				var_511_0.localEulerAngles = var_511_8
			end

			local var_511_9 = arg_508_1.actors_["102003ui_story"]
			local var_511_10 = 0

			if var_511_10 < arg_508_1.time_ and arg_508_1.time_ <= var_511_10 + arg_511_0 and not isNil(var_511_9) and arg_508_1.var_.characterEffect102003ui_story == nil then
				arg_508_1.var_.characterEffect102003ui_story = var_511_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_11 = 0.200000002980232

			if var_511_10 <= arg_508_1.time_ and arg_508_1.time_ < var_511_10 + var_511_11 and not isNil(var_511_9) then
				local var_511_12 = (arg_508_1.time_ - var_511_10) / var_511_11

				if arg_508_1.var_.characterEffect102003ui_story and not isNil(var_511_9) then
					arg_508_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= var_511_10 + var_511_11 and arg_508_1.time_ < var_511_10 + var_511_11 + arg_511_0 and not isNil(var_511_9) and arg_508_1.var_.characterEffect102003ui_story then
				arg_508_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_511_13 = 0

			if var_511_13 < arg_508_1.time_ and arg_508_1.time_ <= var_511_13 + arg_511_0 then
				arg_508_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_1")
			end

			local var_511_14 = 0

			if var_511_14 < arg_508_1.time_ and arg_508_1.time_ <= var_511_14 + arg_511_0 then
				arg_508_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_511_15 = 0
			local var_511_16 = 0.6

			if var_511_15 < arg_508_1.time_ and arg_508_1.time_ <= var_511_15 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_17 = arg_508_1:FormatText(StoryNameCfg[613].name)

				arg_508_1.leftNameTxt_.text = var_511_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_18 = arg_508_1:GetWordFromCfg(924041122)
				local var_511_19 = arg_508_1:FormatText(var_511_18.content)

				arg_508_1.text_.text = var_511_19

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_20 = 24
				local var_511_21 = utf8.len(var_511_19)
				local var_511_22 = var_511_20 <= 0 and var_511_16 or var_511_16 * (var_511_21 / var_511_20)

				if var_511_22 > 0 and var_511_16 < var_511_22 then
					arg_508_1.talkMaxDuration = var_511_22

					if var_511_22 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_22 + var_511_15
					end
				end

				arg_508_1.text_.text = var_511_19
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb") ~= 0 then
					local var_511_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb") / 1000

					if var_511_23 + var_511_15 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_23 + var_511_15
					end

					if var_511_18.prefab_name ~= "" and arg_508_1.actors_[var_511_18.prefab_name] ~= nil then
						local var_511_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_18.prefab_name].transform, "story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb")

						arg_508_1:RecordAudio("924041122", var_511_24)
						arg_508_1:RecordAudio("924041122", var_511_24)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_25 = math.max(var_511_16, arg_508_1.talkMaxDuration)

			if var_511_15 <= arg_508_1.time_ and arg_508_1.time_ < var_511_15 + var_511_25 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_15) / var_511_25

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_15 + var_511_25 and arg_508_1.time_ < var_511_15 + var_511_25 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play924041123 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 924041123
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play924041124(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["102003ui_story"]
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.characterEffect102003ui_story == nil then
				arg_512_1.var_.characterEffect102003ui_story = var_515_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_2 = 0.200000002980232

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_2 and not isNil(var_515_0) then
				local var_515_3 = (arg_512_1.time_ - var_515_1) / var_515_2

				if arg_512_1.var_.characterEffect102003ui_story and not isNil(var_515_0) then
					local var_515_4 = Mathf.Lerp(0, 0.5, var_515_3)

					arg_512_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_512_1.var_.characterEffect102003ui_story.fillRatio = var_515_4
				end
			end

			if arg_512_1.time_ >= var_515_1 + var_515_2 and arg_512_1.time_ < var_515_1 + var_515_2 + arg_515_0 and not isNil(var_515_0) and arg_512_1.var_.characterEffect102003ui_story then
				local var_515_5 = 0.5

				arg_512_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_512_1.var_.characterEffect102003ui_story.fillRatio = var_515_5
			end

			local var_515_6 = 0
			local var_515_7 = 0.225

			if var_515_6 < arg_512_1.time_ and arg_512_1.time_ <= var_515_6 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_8 = arg_512_1:FormatText(StoryNameCfg[7].name)

				arg_512_1.leftNameTxt_.text = var_515_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_9 = arg_512_1:GetWordFromCfg(924041123)
				local var_515_10 = arg_512_1:FormatText(var_515_9.content)

				arg_512_1.text_.text = var_515_10

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_11 = 9
				local var_515_12 = utf8.len(var_515_10)
				local var_515_13 = var_515_11 <= 0 and var_515_7 or var_515_7 * (var_515_12 / var_515_11)

				if var_515_13 > 0 and var_515_7 < var_515_13 then
					arg_512_1.talkMaxDuration = var_515_13

					if var_515_13 + var_515_6 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_13 + var_515_6
					end
				end

				arg_512_1.text_.text = var_515_10
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_14 = math.max(var_515_7, arg_512_1.talkMaxDuration)

			if var_515_6 <= arg_512_1.time_ and arg_512_1.time_ < var_515_6 + var_515_14 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_6) / var_515_14

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_6 + var_515_14 and arg_512_1.time_ < var_515_6 + var_515_14 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play924041124 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 924041124
		arg_516_1.duration_ = 4.83

		local var_516_0 = {
			zh = 4.833,
			ja = 3.333
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play924041125(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = arg_516_1.actors_["102003ui_story"].transform
			local var_519_1 = 0

			if var_519_1 < arg_516_1.time_ and arg_516_1.time_ <= var_519_1 + arg_519_0 then
				arg_516_1.var_.moveOldPos102003ui_story = var_519_0.localPosition
			end

			local var_519_2 = 0.001

			if var_519_1 <= arg_516_1.time_ and arg_516_1.time_ < var_519_1 + var_519_2 then
				local var_519_3 = (arg_516_1.time_ - var_519_1) / var_519_2
				local var_519_4 = Vector3.New(0, -0.85, -6.21)

				var_519_0.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos102003ui_story, var_519_4, var_519_3)

				local var_519_5 = manager.ui.mainCamera.transform.position - var_519_0.position

				var_519_0.forward = Vector3.New(var_519_5.x, var_519_5.y, var_519_5.z)

				local var_519_6 = var_519_0.localEulerAngles

				var_519_6.z = 0
				var_519_6.x = 0
				var_519_0.localEulerAngles = var_519_6
			end

			if arg_516_1.time_ >= var_519_1 + var_519_2 and arg_516_1.time_ < var_519_1 + var_519_2 + arg_519_0 then
				var_519_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_519_7 = manager.ui.mainCamera.transform.position - var_519_0.position

				var_519_0.forward = Vector3.New(var_519_7.x, var_519_7.y, var_519_7.z)

				local var_519_8 = var_519_0.localEulerAngles

				var_519_8.z = 0
				var_519_8.x = 0
				var_519_0.localEulerAngles = var_519_8
			end

			local var_519_9 = arg_516_1.actors_["102003ui_story"]
			local var_519_10 = 0

			if var_519_10 < arg_516_1.time_ and arg_516_1.time_ <= var_519_10 + arg_519_0 and not isNil(var_519_9) and arg_516_1.var_.characterEffect102003ui_story == nil then
				arg_516_1.var_.characterEffect102003ui_story = var_519_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_11 = 0.200000002980232

			if var_519_10 <= arg_516_1.time_ and arg_516_1.time_ < var_519_10 + var_519_11 and not isNil(var_519_9) then
				local var_519_12 = (arg_516_1.time_ - var_519_10) / var_519_11

				if arg_516_1.var_.characterEffect102003ui_story and not isNil(var_519_9) then
					arg_516_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= var_519_10 + var_519_11 and arg_516_1.time_ < var_519_10 + var_519_11 + arg_519_0 and not isNil(var_519_9) and arg_516_1.var_.characterEffect102003ui_story then
				arg_516_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_519_13 = 0

			if var_519_13 < arg_516_1.time_ and arg_516_1.time_ <= var_519_13 + arg_519_0 then
				arg_516_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action448")
			end

			local var_519_14 = 0

			if var_519_14 < arg_516_1.time_ and arg_516_1.time_ <= var_519_14 + arg_519_0 then
				arg_516_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_519_15 = 0
			local var_519_16 = 0.35

			if var_519_15 < arg_516_1.time_ and arg_516_1.time_ <= var_519_15 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_17 = arg_516_1:FormatText(StoryNameCfg[613].name)

				arg_516_1.leftNameTxt_.text = var_519_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_18 = arg_516_1:GetWordFromCfg(924041124)
				local var_519_19 = arg_516_1:FormatText(var_519_18.content)

				arg_516_1.text_.text = var_519_19

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_20 = 14
				local var_519_21 = utf8.len(var_519_19)
				local var_519_22 = var_519_20 <= 0 and var_519_16 or var_519_16 * (var_519_21 / var_519_20)

				if var_519_22 > 0 and var_519_16 < var_519_22 then
					arg_516_1.talkMaxDuration = var_519_22

					if var_519_22 + var_519_15 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_22 + var_519_15
					end
				end

				arg_516_1.text_.text = var_519_19
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb") ~= 0 then
					local var_519_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb") / 1000

					if var_519_23 + var_519_15 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_23 + var_519_15
					end

					if var_519_18.prefab_name ~= "" and arg_516_1.actors_[var_519_18.prefab_name] ~= nil then
						local var_519_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_18.prefab_name].transform, "story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb")

						arg_516_1:RecordAudio("924041124", var_519_24)
						arg_516_1:RecordAudio("924041124", var_519_24)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_25 = math.max(var_519_16, arg_516_1.talkMaxDuration)

			if var_519_15 <= arg_516_1.time_ and arg_516_1.time_ < var_519_15 + var_519_25 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_15) / var_519_25

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_15 + var_519_25 and arg_516_1.time_ < var_519_15 + var_519_25 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play924041125 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 924041125
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play924041126(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = arg_520_1.actors_["102003ui_story"]
			local var_523_1 = 0

			if var_523_1 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.characterEffect102003ui_story == nil then
				arg_520_1.var_.characterEffect102003ui_story = var_523_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_2 = 0.200000002980232

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_2 and not isNil(var_523_0) then
				local var_523_3 = (arg_520_1.time_ - var_523_1) / var_523_2

				if arg_520_1.var_.characterEffect102003ui_story and not isNil(var_523_0) then
					local var_523_4 = Mathf.Lerp(0, 0.5, var_523_3)

					arg_520_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_520_1.var_.characterEffect102003ui_story.fillRatio = var_523_4
				end
			end

			if arg_520_1.time_ >= var_523_1 + var_523_2 and arg_520_1.time_ < var_523_1 + var_523_2 + arg_523_0 and not isNil(var_523_0) and arg_520_1.var_.characterEffect102003ui_story then
				local var_523_5 = 0.5

				arg_520_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_520_1.var_.characterEffect102003ui_story.fillRatio = var_523_5
			end

			local var_523_6 = 0
			local var_523_7 = 0.125

			if var_523_6 < arg_520_1.time_ and arg_520_1.time_ <= var_523_6 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_8 = arg_520_1:FormatText(StoryNameCfg[7].name)

				arg_520_1.leftNameTxt_.text = var_523_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_9 = arg_520_1:GetWordFromCfg(924041125)
				local var_523_10 = arg_520_1:FormatText(var_523_9.content)

				arg_520_1.text_.text = var_523_10

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_11 = 5
				local var_523_12 = utf8.len(var_523_10)
				local var_523_13 = var_523_11 <= 0 and var_523_7 or var_523_7 * (var_523_12 / var_523_11)

				if var_523_13 > 0 and var_523_7 < var_523_13 then
					arg_520_1.talkMaxDuration = var_523_13

					if var_523_13 + var_523_6 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_13 + var_523_6
					end
				end

				arg_520_1.text_.text = var_523_10
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_14 = math.max(var_523_7, arg_520_1.talkMaxDuration)

			if var_523_6 <= arg_520_1.time_ and arg_520_1.time_ < var_523_6 + var_523_14 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_6) / var_523_14

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_6 + var_523_14 and arg_520_1.time_ < var_523_6 + var_523_14 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play924041126 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 924041126
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play924041127(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["102003ui_story"].transform
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.var_.moveOldPos102003ui_story = var_527_0.localPosition
			end

			local var_527_2 = 0.001

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2
				local var_527_4 = Vector3.New(0, 100, 0)

				var_527_0.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos102003ui_story, var_527_4, var_527_3)

				local var_527_5 = manager.ui.mainCamera.transform.position - var_527_0.position

				var_527_0.forward = Vector3.New(var_527_5.x, var_527_5.y, var_527_5.z)

				local var_527_6 = var_527_0.localEulerAngles

				var_527_6.z = 0
				var_527_6.x = 0
				var_527_0.localEulerAngles = var_527_6
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 then
				var_527_0.localPosition = Vector3.New(0, 100, 0)

				local var_527_7 = manager.ui.mainCamera.transform.position - var_527_0.position

				var_527_0.forward = Vector3.New(var_527_7.x, var_527_7.y, var_527_7.z)

				local var_527_8 = var_527_0.localEulerAngles

				var_527_8.z = 0
				var_527_8.x = 0
				var_527_0.localEulerAngles = var_527_8
			end

			local var_527_9 = 0
			local var_527_10 = 0.175

			if var_527_9 < arg_524_1.time_ and arg_524_1.time_ <= var_527_9 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_11 = arg_524_1:GetWordFromCfg(924041126)
				local var_527_12 = arg_524_1:FormatText(var_527_11.content)

				arg_524_1.text_.text = var_527_12

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_13 = 7
				local var_527_14 = utf8.len(var_527_12)
				local var_527_15 = var_527_13 <= 0 and var_527_10 or var_527_10 * (var_527_14 / var_527_13)

				if var_527_15 > 0 and var_527_10 < var_527_15 then
					arg_524_1.talkMaxDuration = var_527_15

					if var_527_15 + var_527_9 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_15 + var_527_9
					end
				end

				arg_524_1.text_.text = var_527_12
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_16 = math.max(var_527_10, arg_524_1.talkMaxDuration)

			if var_527_9 <= arg_524_1.time_ and arg_524_1.time_ < var_527_9 + var_527_16 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_9) / var_527_16

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_9 + var_527_16 and arg_524_1.time_ < var_527_9 + var_527_16 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play924041127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 924041127
		arg_528_1.duration_ = 5.87

		local var_528_0 = {
			zh = 5.866,
			ja = 4.666
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play924041128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["102003ui_story"].transform
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 then
				arg_528_1.var_.moveOldPos102003ui_story = var_531_0.localPosition
			end

			local var_531_2 = 0.001

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2
				local var_531_4 = Vector3.New(0, -0.85, -6.21)

				var_531_0.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos102003ui_story, var_531_4, var_531_3)

				local var_531_5 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_5.x, var_531_5.y, var_531_5.z)

				local var_531_6 = var_531_0.localEulerAngles

				var_531_6.z = 0
				var_531_6.x = 0
				var_531_0.localEulerAngles = var_531_6
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 then
				var_531_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_531_7 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_7.x, var_531_7.y, var_531_7.z)

				local var_531_8 = var_531_0.localEulerAngles

				var_531_8.z = 0
				var_531_8.x = 0
				var_531_0.localEulerAngles = var_531_8
			end

			local var_531_9 = arg_528_1.actors_["102003ui_story"]
			local var_531_10 = 0

			if var_531_10 < arg_528_1.time_ and arg_528_1.time_ <= var_531_10 + arg_531_0 and not isNil(var_531_9) and arg_528_1.var_.characterEffect102003ui_story == nil then
				arg_528_1.var_.characterEffect102003ui_story = var_531_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_11 = 0.200000002980232

			if var_531_10 <= arg_528_1.time_ and arg_528_1.time_ < var_531_10 + var_531_11 and not isNil(var_531_9) then
				local var_531_12 = (arg_528_1.time_ - var_531_10) / var_531_11

				if arg_528_1.var_.characterEffect102003ui_story and not isNil(var_531_9) then
					arg_528_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= var_531_10 + var_531_11 and arg_528_1.time_ < var_531_10 + var_531_11 + arg_531_0 and not isNil(var_531_9) and arg_528_1.var_.characterEffect102003ui_story then
				arg_528_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_531_13 = 0

			if var_531_13 < arg_528_1.time_ and arg_528_1.time_ <= var_531_13 + arg_531_0 then
				arg_528_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			local var_531_14 = 0

			if var_531_14 < arg_528_1.time_ and arg_528_1.time_ <= var_531_14 + arg_531_0 then
				arg_528_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_531_15 = 0
			local var_531_16 = 0.3

			if var_531_15 < arg_528_1.time_ and arg_528_1.time_ <= var_531_15 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_17 = arg_528_1:FormatText(StoryNameCfg[613].name)

				arg_528_1.leftNameTxt_.text = var_531_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_18 = arg_528_1:GetWordFromCfg(924041127)
				local var_531_19 = arg_528_1:FormatText(var_531_18.content)

				arg_528_1.text_.text = var_531_19

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_20 = 12
				local var_531_21 = utf8.len(var_531_19)
				local var_531_22 = var_531_20 <= 0 and var_531_16 or var_531_16 * (var_531_21 / var_531_20)

				if var_531_22 > 0 and var_531_16 < var_531_22 then
					arg_528_1.talkMaxDuration = var_531_22

					if var_531_22 + var_531_15 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_22 + var_531_15
					end
				end

				arg_528_1.text_.text = var_531_19
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb") ~= 0 then
					local var_531_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb") / 1000

					if var_531_23 + var_531_15 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_23 + var_531_15
					end

					if var_531_18.prefab_name ~= "" and arg_528_1.actors_[var_531_18.prefab_name] ~= nil then
						local var_531_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_18.prefab_name].transform, "story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb")

						arg_528_1:RecordAudio("924041127", var_531_24)
						arg_528_1:RecordAudio("924041127", var_531_24)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_25 = math.max(var_531_16, arg_528_1.talkMaxDuration)

			if var_531_15 <= arg_528_1.time_ and arg_528_1.time_ < var_531_15 + var_531_25 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_15) / var_531_25

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_15 + var_531_25 and arg_528_1.time_ < var_531_15 + var_531_25 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	Play924041128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 924041128
		arg_532_1.duration_ = 6

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play924041129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = arg_532_1.actors_["102003ui_story"]
			local var_535_1 = 0

			if var_535_1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_1 + arg_535_0 and not isNil(var_535_0) and arg_532_1.var_.characterEffect102003ui_story == nil then
				arg_532_1.var_.characterEffect102003ui_story = var_535_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_2 = 0.200000002980232

			if var_535_1 <= arg_532_1.time_ and arg_532_1.time_ < var_535_1 + var_535_2 and not isNil(var_535_0) then
				local var_535_3 = (arg_532_1.time_ - var_535_1) / var_535_2

				if arg_532_1.var_.characterEffect102003ui_story and not isNil(var_535_0) then
					local var_535_4 = Mathf.Lerp(0, 0.5, var_535_3)

					arg_532_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_532_1.var_.characterEffect102003ui_story.fillRatio = var_535_4
				end
			end

			if arg_532_1.time_ >= var_535_1 + var_535_2 and arg_532_1.time_ < var_535_1 + var_535_2 + arg_535_0 and not isNil(var_535_0) and arg_532_1.var_.characterEffect102003ui_story then
				local var_535_5 = 0.5

				arg_532_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_532_1.var_.characterEffect102003ui_story.fillRatio = var_535_5
			end

			local var_535_6 = arg_532_1.actors_["102003ui_story"].transform
			local var_535_7 = 0

			if var_535_7 < arg_532_1.time_ and arg_532_1.time_ <= var_535_7 + arg_535_0 then
				arg_532_1.var_.moveOldPos102003ui_story = var_535_6.localPosition
			end

			local var_535_8 = 0.001

			if var_535_7 <= arg_532_1.time_ and arg_532_1.time_ < var_535_7 + var_535_8 then
				local var_535_9 = (arg_532_1.time_ - var_535_7) / var_535_8
				local var_535_10 = Vector3.New(0, 100, 0)

				var_535_6.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos102003ui_story, var_535_10, var_535_9)

				local var_535_11 = manager.ui.mainCamera.transform.position - var_535_6.position

				var_535_6.forward = Vector3.New(var_535_11.x, var_535_11.y, var_535_11.z)

				local var_535_12 = var_535_6.localEulerAngles

				var_535_12.z = 0
				var_535_12.x = 0
				var_535_6.localEulerAngles = var_535_12
			end

			if arg_532_1.time_ >= var_535_7 + var_535_8 and arg_532_1.time_ < var_535_7 + var_535_8 + arg_535_0 then
				var_535_6.localPosition = Vector3.New(0, 100, 0)

				local var_535_13 = manager.ui.mainCamera.transform.position - var_535_6.position

				var_535_6.forward = Vector3.New(var_535_13.x, var_535_13.y, var_535_13.z)

				local var_535_14 = var_535_6.localEulerAngles

				var_535_14.z = 0
				var_535_14.x = 0
				var_535_6.localEulerAngles = var_535_14
			end

			local var_535_15 = manager.ui.mainCamera.transform
			local var_535_16 = 0

			if var_535_16 < arg_532_1.time_ and arg_532_1.time_ <= var_535_16 + arg_535_0 then
				arg_532_1.var_.shakeOldPos = var_535_15.localPosition
			end

			local var_535_17 = 0.766666666666667

			if var_535_16 <= arg_532_1.time_ and arg_532_1.time_ < var_535_16 + var_535_17 then
				local var_535_18 = (arg_532_1.time_ - var_535_16) / 0.066
				local var_535_19, var_535_20 = math.modf(var_535_18)

				var_535_15.localPosition = Vector3.New(var_535_20 * 0.13, var_535_20 * 0.13, var_535_20 * 0.13) + arg_532_1.var_.shakeOldPos
			end

			if arg_532_1.time_ >= var_535_16 + var_535_17 and arg_532_1.time_ < var_535_16 + var_535_17 + arg_535_0 then
				var_535_15.localPosition = arg_532_1.var_.shakeOldPos
			end

			local var_535_21 = 0

			if var_535_21 < arg_532_1.time_ and arg_532_1.time_ <= var_535_21 + arg_535_0 then
				arg_532_1.allBtn_.enabled = false
			end

			local var_535_22 = 1.2

			if arg_532_1.time_ >= var_535_21 + var_535_22 and arg_532_1.time_ < var_535_21 + var_535_22 + arg_535_0 then
				arg_532_1.allBtn_.enabled = true
			end

			if arg_532_1.frameCnt_ <= 1 then
				arg_532_1.dialog_:SetActive(false)
			end

			local var_535_23 = 1
			local var_535_24 = 0.35

			if var_535_23 < arg_532_1.time_ and arg_532_1.time_ <= var_535_23 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0

				arg_532_1.dialog_:SetActive(true)

				arg_532_1.dialogCg_.alpha = 0

				local var_535_25 = LeanTween.value(arg_532_1.dialog_, 0, 1, 0.3)

				var_535_25:setOnUpdate(LuaHelper.FloatAction(function(arg_536_0)
					arg_532_1.dialogCg_.alpha = arg_536_0
				end))
				var_535_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_532_1.dialog_)
					var_535_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_532_1.duration_ = arg_532_1.duration_ + 0.3

				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_26 = arg_532_1:FormatText(StoryNameCfg[7].name)

				arg_532_1.leftNameTxt_.text = var_535_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_27 = arg_532_1:GetWordFromCfg(924041128)
				local var_535_28 = arg_532_1:FormatText(var_535_27.content)

				arg_532_1.text_.text = var_535_28

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_29 = 14
				local var_535_30 = utf8.len(var_535_28)
				local var_535_31 = var_535_29 <= 0 and var_535_24 or var_535_24 * (var_535_30 / var_535_29)

				if var_535_31 > 0 and var_535_24 < var_535_31 then
					arg_532_1.talkMaxDuration = var_535_31
					var_535_23 = var_535_23 + 0.3

					if var_535_31 + var_535_23 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_31 + var_535_23
					end
				end

				arg_532_1.text_.text = var_535_28
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_32 = var_535_23 + 0.3
			local var_535_33 = math.max(var_535_24, arg_532_1.talkMaxDuration)

			if var_535_32 <= arg_532_1.time_ and arg_532_1.time_ < var_535_32 + var_535_33 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_32) / var_535_33

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_32 + var_535_33 and arg_532_1.time_ < var_535_32 + var_535_33 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play924041129 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 924041129
		arg_538_1.duration_ = 6.07

		local var_538_0 = {
			zh = 4.166,
			ja = 6.066
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play924041130(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["102003ui_story"].transform
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 then
				arg_538_1.var_.moveOldPos102003ui_story = var_541_0.localPosition
			end

			local var_541_2 = 0.001

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2
				local var_541_4 = Vector3.New(0, -0.85, -6.21)

				var_541_0.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos102003ui_story, var_541_4, var_541_3)

				local var_541_5 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_5.x, var_541_5.y, var_541_5.z)

				local var_541_6 = var_541_0.localEulerAngles

				var_541_6.z = 0
				var_541_6.x = 0
				var_541_0.localEulerAngles = var_541_6
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 then
				var_541_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_541_7 = manager.ui.mainCamera.transform.position - var_541_0.position

				var_541_0.forward = Vector3.New(var_541_7.x, var_541_7.y, var_541_7.z)

				local var_541_8 = var_541_0.localEulerAngles

				var_541_8.z = 0
				var_541_8.x = 0
				var_541_0.localEulerAngles = var_541_8
			end

			local var_541_9 = arg_538_1.actors_["102003ui_story"]
			local var_541_10 = 0

			if var_541_10 < arg_538_1.time_ and arg_538_1.time_ <= var_541_10 + arg_541_0 and not isNil(var_541_9) and arg_538_1.var_.characterEffect102003ui_story == nil then
				arg_538_1.var_.characterEffect102003ui_story = var_541_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_11 = 0.200000002980232

			if var_541_10 <= arg_538_1.time_ and arg_538_1.time_ < var_541_10 + var_541_11 and not isNil(var_541_9) then
				local var_541_12 = (arg_538_1.time_ - var_541_10) / var_541_11

				if arg_538_1.var_.characterEffect102003ui_story and not isNil(var_541_9) then
					arg_538_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= var_541_10 + var_541_11 and arg_538_1.time_ < var_541_10 + var_541_11 + arg_541_0 and not isNil(var_541_9) and arg_538_1.var_.characterEffect102003ui_story then
				arg_538_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_541_13 = 0

			if var_541_13 < arg_538_1.time_ and arg_538_1.time_ <= var_541_13 + arg_541_0 then
				arg_538_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action7_1")
			end

			local var_541_14 = 0

			if var_541_14 < arg_538_1.time_ and arg_538_1.time_ <= var_541_14 + arg_541_0 then
				arg_538_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_541_15 = 0
			local var_541_16 = 0.45

			if var_541_15 < arg_538_1.time_ and arg_538_1.time_ <= var_541_15 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_17 = arg_538_1:FormatText(StoryNameCfg[613].name)

				arg_538_1.leftNameTxt_.text = var_541_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_18 = arg_538_1:GetWordFromCfg(924041129)
				local var_541_19 = arg_538_1:FormatText(var_541_18.content)

				arg_538_1.text_.text = var_541_19

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_20 = 18
				local var_541_21 = utf8.len(var_541_19)
				local var_541_22 = var_541_20 <= 0 and var_541_16 or var_541_16 * (var_541_21 / var_541_20)

				if var_541_22 > 0 and var_541_16 < var_541_22 then
					arg_538_1.talkMaxDuration = var_541_22

					if var_541_22 + var_541_15 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_22 + var_541_15
					end
				end

				arg_538_1.text_.text = var_541_19
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb") ~= 0 then
					local var_541_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb") / 1000

					if var_541_23 + var_541_15 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_23 + var_541_15
					end

					if var_541_18.prefab_name ~= "" and arg_538_1.actors_[var_541_18.prefab_name] ~= nil then
						local var_541_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_18.prefab_name].transform, "story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb")

						arg_538_1:RecordAudio("924041129", var_541_24)
						arg_538_1:RecordAudio("924041129", var_541_24)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_25 = math.max(var_541_16, arg_538_1.talkMaxDuration)

			if var_541_15 <= arg_538_1.time_ and arg_538_1.time_ < var_541_15 + var_541_25 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_15) / var_541_25

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_15 + var_541_25 and arg_538_1.time_ < var_541_15 + var_541_25 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play924041130 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 924041130
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play924041131(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = arg_542_1.actors_["102003ui_story"]
			local var_545_1 = 0

			if var_545_1 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 and not isNil(var_545_0) and arg_542_1.var_.characterEffect102003ui_story == nil then
				arg_542_1.var_.characterEffect102003ui_story = var_545_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_2 = 0.200000002980232

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_2 and not isNil(var_545_0) then
				local var_545_3 = (arg_542_1.time_ - var_545_1) / var_545_2

				if arg_542_1.var_.characterEffect102003ui_story and not isNil(var_545_0) then
					local var_545_4 = Mathf.Lerp(0, 0.5, var_545_3)

					arg_542_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_542_1.var_.characterEffect102003ui_story.fillRatio = var_545_4
				end
			end

			if arg_542_1.time_ >= var_545_1 + var_545_2 and arg_542_1.time_ < var_545_1 + var_545_2 + arg_545_0 and not isNil(var_545_0) and arg_542_1.var_.characterEffect102003ui_story then
				local var_545_5 = 0.5

				arg_542_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_542_1.var_.characterEffect102003ui_story.fillRatio = var_545_5
			end

			local var_545_6 = 0
			local var_545_7 = 0.75

			if var_545_6 < arg_542_1.time_ and arg_542_1.time_ <= var_545_6 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_8 = arg_542_1:FormatText(StoryNameCfg[7].name)

				arg_542_1.leftNameTxt_.text = var_545_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_9 = arg_542_1:GetWordFromCfg(924041130)
				local var_545_10 = arg_542_1:FormatText(var_545_9.content)

				arg_542_1.text_.text = var_545_10

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_11 = 30
				local var_545_12 = utf8.len(var_545_10)
				local var_545_13 = var_545_11 <= 0 and var_545_7 or var_545_7 * (var_545_12 / var_545_11)

				if var_545_13 > 0 and var_545_7 < var_545_13 then
					arg_542_1.talkMaxDuration = var_545_13

					if var_545_13 + var_545_6 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_13 + var_545_6
					end
				end

				arg_542_1.text_.text = var_545_10
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_14 = math.max(var_545_7, arg_542_1.talkMaxDuration)

			if var_545_6 <= arg_542_1.time_ and arg_542_1.time_ < var_545_6 + var_545_14 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_6) / var_545_14

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_6 + var_545_14 and arg_542_1.time_ < var_545_6 + var_545_14 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play924041131 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 924041131
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play924041132(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = arg_546_1.actors_["102003ui_story"].transform
			local var_549_1 = 0

			if var_549_1 < arg_546_1.time_ and arg_546_1.time_ <= var_549_1 + arg_549_0 then
				arg_546_1.var_.moveOldPos102003ui_story = var_549_0.localPosition
			end

			local var_549_2 = 0.001

			if var_549_1 <= arg_546_1.time_ and arg_546_1.time_ < var_549_1 + var_549_2 then
				local var_549_3 = (arg_546_1.time_ - var_549_1) / var_549_2
				local var_549_4 = Vector3.New(0, 100, 0)

				var_549_0.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos102003ui_story, var_549_4, var_549_3)

				local var_549_5 = manager.ui.mainCamera.transform.position - var_549_0.position

				var_549_0.forward = Vector3.New(var_549_5.x, var_549_5.y, var_549_5.z)

				local var_549_6 = var_549_0.localEulerAngles

				var_549_6.z = 0
				var_549_6.x = 0
				var_549_0.localEulerAngles = var_549_6
			end

			if arg_546_1.time_ >= var_549_1 + var_549_2 and arg_546_1.time_ < var_549_1 + var_549_2 + arg_549_0 then
				var_549_0.localPosition = Vector3.New(0, 100, 0)

				local var_549_7 = manager.ui.mainCamera.transform.position - var_549_0.position

				var_549_0.forward = Vector3.New(var_549_7.x, var_549_7.y, var_549_7.z)

				local var_549_8 = var_549_0.localEulerAngles

				var_549_8.z = 0
				var_549_8.x = 0
				var_549_0.localEulerAngles = var_549_8
			end

			local var_549_9 = 0.125
			local var_549_10 = 1

			if var_549_9 < arg_546_1.time_ and arg_546_1.time_ <= var_549_9 + arg_549_0 then
				local var_549_11 = "play"
				local var_549_12 = "effect"

				arg_546_1:AudioAction(var_549_11, var_549_12, "se_story_side_1093", "se_story_1093_message_get", "")
			end

			local var_549_13 = 0
			local var_549_14 = 1.05

			if var_549_13 < arg_546_1.time_ and arg_546_1.time_ <= var_549_13 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_15 = arg_546_1:GetWordFromCfg(924041131)
				local var_549_16 = arg_546_1:FormatText(var_549_15.content)

				arg_546_1.text_.text = var_549_16

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_17 = 42
				local var_549_18 = utf8.len(var_549_16)
				local var_549_19 = var_549_17 <= 0 and var_549_14 or var_549_14 * (var_549_18 / var_549_17)

				if var_549_19 > 0 and var_549_14 < var_549_19 then
					arg_546_1.talkMaxDuration = var_549_19

					if var_549_19 + var_549_13 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_19 + var_549_13
					end
				end

				arg_546_1.text_.text = var_549_16
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_20 = math.max(var_549_14, arg_546_1.talkMaxDuration)

			if var_549_13 <= arg_546_1.time_ and arg_546_1.time_ < var_549_13 + var_549_20 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_13) / var_549_20

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_13 + var_549_20 and arg_546_1.time_ < var_549_13 + var_549_20 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_546_1:InitPlayNodeList()
	end,
	Play924041132 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 924041132
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play924041133(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0
			local var_553_1 = 0.125

			if var_553_0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				local var_553_2 = arg_550_1:FormatText(StoryNameCfg[7].name)

				arg_550_1.leftNameTxt_.text = var_553_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_3 = arg_550_1:GetWordFromCfg(924041132)
				local var_553_4 = arg_550_1:FormatText(var_553_3.content)

				arg_550_1.text_.text = var_553_4

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_5 = 5
				local var_553_6 = utf8.len(var_553_4)
				local var_553_7 = var_553_5 <= 0 and var_553_1 or var_553_1 * (var_553_6 / var_553_5)

				if var_553_7 > 0 and var_553_1 < var_553_7 then
					arg_550_1.talkMaxDuration = var_553_7

					if var_553_7 + var_553_0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_7 + var_553_0
					end
				end

				arg_550_1.text_.text = var_553_4
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_8 = math.max(var_553_1, arg_550_1.talkMaxDuration)

			if var_553_0 <= arg_550_1.time_ and arg_550_1.time_ < var_553_0 + var_553_8 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_0) / var_553_8

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_0 + var_553_8 and arg_550_1.time_ < var_553_0 + var_553_8 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play924041133 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 924041133
		arg_554_1.duration_ = 1.73

		local var_554_0 = {
			zh = 1.533,
			ja = 1.733
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play924041134(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = arg_554_1.actors_["102003ui_story"].transform
			local var_557_1 = 0

			if var_557_1 < arg_554_1.time_ and arg_554_1.time_ <= var_557_1 + arg_557_0 then
				arg_554_1.var_.moveOldPos102003ui_story = var_557_0.localPosition
			end

			local var_557_2 = 0.001

			if var_557_1 <= arg_554_1.time_ and arg_554_1.time_ < var_557_1 + var_557_2 then
				local var_557_3 = (arg_554_1.time_ - var_557_1) / var_557_2
				local var_557_4 = Vector3.New(0, -0.85, -6.21)

				var_557_0.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos102003ui_story, var_557_4, var_557_3)

				local var_557_5 = manager.ui.mainCamera.transform.position - var_557_0.position

				var_557_0.forward = Vector3.New(var_557_5.x, var_557_5.y, var_557_5.z)

				local var_557_6 = var_557_0.localEulerAngles

				var_557_6.z = 0
				var_557_6.x = 0
				var_557_0.localEulerAngles = var_557_6
			end

			if arg_554_1.time_ >= var_557_1 + var_557_2 and arg_554_1.time_ < var_557_1 + var_557_2 + arg_557_0 then
				var_557_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_557_7 = manager.ui.mainCamera.transform.position - var_557_0.position

				var_557_0.forward = Vector3.New(var_557_7.x, var_557_7.y, var_557_7.z)

				local var_557_8 = var_557_0.localEulerAngles

				var_557_8.z = 0
				var_557_8.x = 0
				var_557_0.localEulerAngles = var_557_8
			end

			local var_557_9 = arg_554_1.actors_["102003ui_story"]
			local var_557_10 = 0

			if var_557_10 < arg_554_1.time_ and arg_554_1.time_ <= var_557_10 + arg_557_0 and not isNil(var_557_9) and arg_554_1.var_.characterEffect102003ui_story == nil then
				arg_554_1.var_.characterEffect102003ui_story = var_557_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_11 = 0.200000002980232

			if var_557_10 <= arg_554_1.time_ and arg_554_1.time_ < var_557_10 + var_557_11 and not isNil(var_557_9) then
				local var_557_12 = (arg_554_1.time_ - var_557_10) / var_557_11

				if arg_554_1.var_.characterEffect102003ui_story and not isNil(var_557_9) then
					arg_554_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= var_557_10 + var_557_11 and arg_554_1.time_ < var_557_10 + var_557_11 + arg_557_0 and not isNil(var_557_9) and arg_554_1.var_.characterEffect102003ui_story then
				arg_554_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_557_13 = 0

			if var_557_13 < arg_554_1.time_ and arg_554_1.time_ <= var_557_13 + arg_557_0 then
				arg_554_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			local var_557_14 = 0

			if var_557_14 < arg_554_1.time_ and arg_554_1.time_ <= var_557_14 + arg_557_0 then
				arg_554_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_557_15 = 0
			local var_557_16 = 0.15

			if var_557_15 < arg_554_1.time_ and arg_554_1.time_ <= var_557_15 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_17 = arg_554_1:FormatText(StoryNameCfg[613].name)

				arg_554_1.leftNameTxt_.text = var_557_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_18 = arg_554_1:GetWordFromCfg(924041133)
				local var_557_19 = arg_554_1:FormatText(var_557_18.content)

				arg_554_1.text_.text = var_557_19

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_20 = 6
				local var_557_21 = utf8.len(var_557_19)
				local var_557_22 = var_557_20 <= 0 and var_557_16 or var_557_16 * (var_557_21 / var_557_20)

				if var_557_22 > 0 and var_557_16 < var_557_22 then
					arg_554_1.talkMaxDuration = var_557_22

					if var_557_22 + var_557_15 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_22 + var_557_15
					end
				end

				arg_554_1.text_.text = var_557_19
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb") ~= 0 then
					local var_557_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb") / 1000

					if var_557_23 + var_557_15 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_23 + var_557_15
					end

					if var_557_18.prefab_name ~= "" and arg_554_1.actors_[var_557_18.prefab_name] ~= nil then
						local var_557_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_18.prefab_name].transform, "story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb")

						arg_554_1:RecordAudio("924041133", var_557_24)
						arg_554_1:RecordAudio("924041133", var_557_24)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_25 = math.max(var_557_16, arg_554_1.talkMaxDuration)

			if var_557_15 <= arg_554_1.time_ and arg_554_1.time_ < var_557_15 + var_557_25 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_15) / var_557_25

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_15 + var_557_25 and arg_554_1.time_ < var_557_15 + var_557_25 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	Play924041134 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 924041134
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play924041135(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = arg_558_1.actors_["102003ui_story"]
			local var_561_1 = 0

			if var_561_1 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect102003ui_story == nil then
				arg_558_1.var_.characterEffect102003ui_story = var_561_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_2 = 0.200000002980232

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_2 and not isNil(var_561_0) then
				local var_561_3 = (arg_558_1.time_ - var_561_1) / var_561_2

				if arg_558_1.var_.characterEffect102003ui_story and not isNil(var_561_0) then
					local var_561_4 = Mathf.Lerp(0, 0.5, var_561_3)

					arg_558_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_558_1.var_.characterEffect102003ui_story.fillRatio = var_561_4
				end
			end

			if arg_558_1.time_ >= var_561_1 + var_561_2 and arg_558_1.time_ < var_561_1 + var_561_2 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect102003ui_story then
				local var_561_5 = 0.5

				arg_558_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_558_1.var_.characterEffect102003ui_story.fillRatio = var_561_5
			end

			local var_561_6 = 0
			local var_561_7 = 0.05

			if var_561_6 < arg_558_1.time_ and arg_558_1.time_ <= var_561_6 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_8 = arg_558_1:FormatText(StoryNameCfg[7].name)

				arg_558_1.leftNameTxt_.text = var_561_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_9 = arg_558_1:GetWordFromCfg(924041134)
				local var_561_10 = arg_558_1:FormatText(var_561_9.content)

				arg_558_1.text_.text = var_561_10

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_11 = 2
				local var_561_12 = utf8.len(var_561_10)
				local var_561_13 = var_561_11 <= 0 and var_561_7 or var_561_7 * (var_561_12 / var_561_11)

				if var_561_13 > 0 and var_561_7 < var_561_13 then
					arg_558_1.talkMaxDuration = var_561_13

					if var_561_13 + var_561_6 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_13 + var_561_6
					end
				end

				arg_558_1.text_.text = var_561_10
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_14 = math.max(var_561_7, arg_558_1.talkMaxDuration)

			if var_561_6 <= arg_558_1.time_ and arg_558_1.time_ < var_561_6 + var_561_14 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_6) / var_561_14

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_6 + var_561_14 and arg_558_1.time_ < var_561_6 + var_561_14 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play924041135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 924041135
		arg_562_1.duration_ = 4.83

		local var_562_0 = {
			zh = 4.066,
			ja = 4.833
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play924041136(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = arg_562_1.actors_["102003ui_story"].transform
			local var_565_1 = 0

			if var_565_1 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 then
				arg_562_1.var_.moveOldPos102003ui_story = var_565_0.localPosition
			end

			local var_565_2 = 0.001

			if var_565_1 <= arg_562_1.time_ and arg_562_1.time_ < var_565_1 + var_565_2 then
				local var_565_3 = (arg_562_1.time_ - var_565_1) / var_565_2
				local var_565_4 = Vector3.New(0, -0.85, -6.21)

				var_565_0.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos102003ui_story, var_565_4, var_565_3)

				local var_565_5 = manager.ui.mainCamera.transform.position - var_565_0.position

				var_565_0.forward = Vector3.New(var_565_5.x, var_565_5.y, var_565_5.z)

				local var_565_6 = var_565_0.localEulerAngles

				var_565_6.z = 0
				var_565_6.x = 0
				var_565_0.localEulerAngles = var_565_6
			end

			if arg_562_1.time_ >= var_565_1 + var_565_2 and arg_562_1.time_ < var_565_1 + var_565_2 + arg_565_0 then
				var_565_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_565_7 = manager.ui.mainCamera.transform.position - var_565_0.position

				var_565_0.forward = Vector3.New(var_565_7.x, var_565_7.y, var_565_7.z)

				local var_565_8 = var_565_0.localEulerAngles

				var_565_8.z = 0
				var_565_8.x = 0
				var_565_0.localEulerAngles = var_565_8
			end

			local var_565_9 = arg_562_1.actors_["102003ui_story"]
			local var_565_10 = 0

			if var_565_10 < arg_562_1.time_ and arg_562_1.time_ <= var_565_10 + arg_565_0 and not isNil(var_565_9) and arg_562_1.var_.characterEffect102003ui_story == nil then
				arg_562_1.var_.characterEffect102003ui_story = var_565_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_11 = 0.200000002980232

			if var_565_10 <= arg_562_1.time_ and arg_562_1.time_ < var_565_10 + var_565_11 and not isNil(var_565_9) then
				local var_565_12 = (arg_562_1.time_ - var_565_10) / var_565_11

				if arg_562_1.var_.characterEffect102003ui_story and not isNil(var_565_9) then
					arg_562_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_562_1.time_ >= var_565_10 + var_565_11 and arg_562_1.time_ < var_565_10 + var_565_11 + arg_565_0 and not isNil(var_565_9) and arg_562_1.var_.characterEffect102003ui_story then
				arg_562_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_565_13 = 0

			if var_565_13 < arg_562_1.time_ and arg_562_1.time_ <= var_565_13 + arg_565_0 then
				arg_562_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			local var_565_14 = 0

			if var_565_14 < arg_562_1.time_ and arg_562_1.time_ <= var_565_14 + arg_565_0 then
				arg_562_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_565_15 = 0
			local var_565_16 = 0.375

			if var_565_15 < arg_562_1.time_ and arg_562_1.time_ <= var_565_15 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_17 = arg_562_1:FormatText(StoryNameCfg[613].name)

				arg_562_1.leftNameTxt_.text = var_565_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_18 = arg_562_1:GetWordFromCfg(924041135)
				local var_565_19 = arg_562_1:FormatText(var_565_18.content)

				arg_562_1.text_.text = var_565_19

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_20 = 15
				local var_565_21 = utf8.len(var_565_19)
				local var_565_22 = var_565_20 <= 0 and var_565_16 or var_565_16 * (var_565_21 / var_565_20)

				if var_565_22 > 0 and var_565_16 < var_565_22 then
					arg_562_1.talkMaxDuration = var_565_22

					if var_565_22 + var_565_15 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_22 + var_565_15
					end
				end

				arg_562_1.text_.text = var_565_19
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb") ~= 0 then
					local var_565_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb") / 1000

					if var_565_23 + var_565_15 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_23 + var_565_15
					end

					if var_565_18.prefab_name ~= "" and arg_562_1.actors_[var_565_18.prefab_name] ~= nil then
						local var_565_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_18.prefab_name].transform, "story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb")

						arg_562_1:RecordAudio("924041135", var_565_24)
						arg_562_1:RecordAudio("924041135", var_565_24)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_25 = math.max(var_565_16, arg_562_1.talkMaxDuration)

			if var_565_15 <= arg_562_1.time_ and arg_562_1.time_ < var_565_15 + var_565_25 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_15) / var_565_25

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_15 + var_565_25 and arg_562_1.time_ < var_565_15 + var_565_25 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play924041136 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 924041136
		arg_566_1.duration_ = 9

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play924041137(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 2

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				local var_569_1 = manager.ui.mainCamera.transform.localPosition
				local var_569_2 = Vector3.New(0, 0, 10) + Vector3.New(var_569_1.x, var_569_1.y, 0)
				local var_569_3 = arg_566_1.bgs_.STblack

				var_569_3.transform.localPosition = var_569_2
				var_569_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_569_4 = var_569_3:GetComponent("SpriteRenderer")

				if var_569_4 and var_569_4.sprite then
					local var_569_5 = (var_569_3.transform.localPosition - var_569_1).z
					local var_569_6 = manager.ui.mainCameraCom_
					local var_569_7 = 2 * var_569_5 * Mathf.Tan(var_569_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_569_8 = var_569_7 * var_569_6.aspect
					local var_569_9 = var_569_4.sprite.bounds.size.x
					local var_569_10 = var_569_4.sprite.bounds.size.y
					local var_569_11 = var_569_8 / var_569_9
					local var_569_12 = var_569_7 / var_569_10
					local var_569_13 = var_569_12 < var_569_11 and var_569_11 or var_569_12

					var_569_3.transform.localScale = Vector3.New(var_569_13, var_569_13, 0)
				end

				for iter_569_0, iter_569_1 in pairs(arg_566_1.bgs_) do
					if iter_569_0 ~= "STblack" then
						iter_569_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_569_14 = 4

			if var_569_14 < arg_566_1.time_ and arg_566_1.time_ <= var_569_14 + arg_569_0 then
				arg_566_1.allBtn_.enabled = false
			end

			local var_569_15 = 0.3

			if arg_566_1.time_ >= var_569_14 + var_569_15 and arg_566_1.time_ < var_569_14 + var_569_15 + arg_569_0 then
				arg_566_1.allBtn_.enabled = true
			end

			local var_569_16 = 0

			if var_569_16 < arg_566_1.time_ and arg_566_1.time_ <= var_569_16 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = true

				arg_566_1:SetGaussion(false)
			end

			local var_569_17 = 2

			if var_569_16 <= arg_566_1.time_ and arg_566_1.time_ < var_569_16 + var_569_17 then
				local var_569_18 = (arg_566_1.time_ - var_569_16) / var_569_17
				local var_569_19 = Color.New(0, 0, 0)

				var_569_19.a = Mathf.Lerp(0, 1, var_569_18)
				arg_566_1.mask_.color = var_569_19
			end

			if arg_566_1.time_ >= var_569_16 + var_569_17 and arg_566_1.time_ < var_569_16 + var_569_17 + arg_569_0 then
				local var_569_20 = Color.New(0, 0, 0)

				var_569_20.a = 1
				arg_566_1.mask_.color = var_569_20
			end

			local var_569_21 = 2

			if var_569_21 < arg_566_1.time_ and arg_566_1.time_ <= var_569_21 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = true

				arg_566_1:SetGaussion(false)
			end

			local var_569_22 = 2

			if var_569_21 <= arg_566_1.time_ and arg_566_1.time_ < var_569_21 + var_569_22 then
				local var_569_23 = (arg_566_1.time_ - var_569_21) / var_569_22
				local var_569_24 = Color.New(0, 0, 0)

				var_569_24.a = Mathf.Lerp(1, 0, var_569_23)
				arg_566_1.mask_.color = var_569_24
			end

			if arg_566_1.time_ >= var_569_21 + var_569_22 and arg_566_1.time_ < var_569_21 + var_569_22 + arg_569_0 then
				local var_569_25 = Color.New(0, 0, 0)
				local var_569_26 = 0

				arg_566_1.mask_.enabled = false
				var_569_25.a = var_569_26
				arg_566_1.mask_.color = var_569_25
			end

			local var_569_27 = arg_566_1.actors_["102003ui_story"].transform
			local var_569_28 = 1.96599999815226

			if var_569_28 < arg_566_1.time_ and arg_566_1.time_ <= var_569_28 + arg_569_0 then
				arg_566_1.var_.moveOldPos102003ui_story = var_569_27.localPosition
			end

			local var_569_29 = 0.001

			if var_569_28 <= arg_566_1.time_ and arg_566_1.time_ < var_569_28 + var_569_29 then
				local var_569_30 = (arg_566_1.time_ - var_569_28) / var_569_29
				local var_569_31 = Vector3.New(0, 100, 0)

				var_569_27.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos102003ui_story, var_569_31, var_569_30)

				local var_569_32 = manager.ui.mainCamera.transform.position - var_569_27.position

				var_569_27.forward = Vector3.New(var_569_32.x, var_569_32.y, var_569_32.z)

				local var_569_33 = var_569_27.localEulerAngles

				var_569_33.z = 0
				var_569_33.x = 0
				var_569_27.localEulerAngles = var_569_33
			end

			if arg_566_1.time_ >= var_569_28 + var_569_29 and arg_566_1.time_ < var_569_28 + var_569_29 + arg_569_0 then
				var_569_27.localPosition = Vector3.New(0, 100, 0)

				local var_569_34 = manager.ui.mainCamera.transform.position - var_569_27.position

				var_569_27.forward = Vector3.New(var_569_34.x, var_569_34.y, var_569_34.z)

				local var_569_35 = var_569_27.localEulerAngles

				var_569_35.z = 0
				var_569_35.x = 0
				var_569_27.localEulerAngles = var_569_35
			end

			local var_569_36 = arg_566_1.actors_["102003ui_story"]
			local var_569_37 = 1.96599999815226

			if var_569_37 < arg_566_1.time_ and arg_566_1.time_ <= var_569_37 + arg_569_0 and not isNil(var_569_36) and arg_566_1.var_.characterEffect102003ui_story == nil then
				arg_566_1.var_.characterEffect102003ui_story = var_569_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_38 = 0.034000001847744

			if var_569_37 <= arg_566_1.time_ and arg_566_1.time_ < var_569_37 + var_569_38 and not isNil(var_569_36) then
				local var_569_39 = (arg_566_1.time_ - var_569_37) / var_569_38

				if arg_566_1.var_.characterEffect102003ui_story and not isNil(var_569_36) then
					local var_569_40 = Mathf.Lerp(0, 0.5, var_569_39)

					arg_566_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_566_1.var_.characterEffect102003ui_story.fillRatio = var_569_40
				end
			end

			if arg_566_1.time_ >= var_569_37 + var_569_38 and arg_566_1.time_ < var_569_37 + var_569_38 + arg_569_0 and not isNil(var_569_36) and arg_566_1.var_.characterEffect102003ui_story then
				local var_569_41 = 0.5

				arg_566_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_566_1.var_.characterEffect102003ui_story.fillRatio = var_569_41
			end

			if arg_566_1.frameCnt_ <= 1 then
				arg_566_1.dialog_:SetActive(false)
			end

			local var_569_42 = 4
			local var_569_43 = 0.425

			if var_569_42 < arg_566_1.time_ and arg_566_1.time_ <= var_569_42 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0

				arg_566_1.dialog_:SetActive(true)

				arg_566_1.dialogCg_.alpha = 0

				local var_569_44 = LeanTween.value(arg_566_1.dialog_, 0, 1, 0.3)

				var_569_44:setOnUpdate(LuaHelper.FloatAction(function(arg_570_0)
					arg_566_1.dialogCg_.alpha = arg_570_0
				end))
				var_569_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_566_1.dialog_)
					var_569_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_566_1.duration_ = arg_566_1.duration_ + 0.3

				SetActive(arg_566_1.leftNameGo_, false)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_45 = arg_566_1:GetWordFromCfg(924041136)
				local var_569_46 = arg_566_1:FormatText(var_569_45.content)

				arg_566_1.text_.text = var_569_46

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_47 = 17
				local var_569_48 = utf8.len(var_569_46)
				local var_569_49 = var_569_47 <= 0 and var_569_43 or var_569_43 * (var_569_48 / var_569_47)

				if var_569_49 > 0 and var_569_43 < var_569_49 then
					arg_566_1.talkMaxDuration = var_569_49
					var_569_42 = var_569_42 + 0.3

					if var_569_49 + var_569_42 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_49 + var_569_42
					end
				end

				arg_566_1.text_.text = var_569_46
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_50 = var_569_42 + 0.3
			local var_569_51 = math.max(var_569_43, arg_566_1.talkMaxDuration)

			if var_569_50 <= arg_566_1.time_ and arg_566_1.time_ < var_569_50 + var_569_51 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_50) / var_569_51

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_50 + var_569_51 and arg_566_1.time_ < var_569_50 + var_569_51 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play924041137 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 924041137
		arg_572_1.duration_ = 7

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play924041138(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = "X204_f"

			if arg_572_1.bgs_[var_575_0] == nil then
				local var_575_1 = Object.Instantiate(arg_572_1.paintGo_)

				var_575_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_575_0)
				var_575_1.name = var_575_0
				var_575_1.transform.parent = arg_572_1.stage_.transform
				var_575_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_572_1.bgs_[var_575_0] = var_575_1
			end

			local var_575_2 = 0

			if var_575_2 < arg_572_1.time_ and arg_572_1.time_ <= var_575_2 + arg_575_0 then
				local var_575_3 = manager.ui.mainCamera.transform.localPosition
				local var_575_4 = Vector3.New(0, 0, 10) + Vector3.New(var_575_3.x, var_575_3.y, 0)
				local var_575_5 = arg_572_1.bgs_.X204_f

				var_575_5.transform.localPosition = var_575_4
				var_575_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_575_6 = var_575_5:GetComponent("SpriteRenderer")

				if var_575_6 and var_575_6.sprite then
					local var_575_7 = (var_575_5.transform.localPosition - var_575_3).z
					local var_575_8 = manager.ui.mainCameraCom_
					local var_575_9 = 2 * var_575_7 * Mathf.Tan(var_575_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_575_10 = var_575_9 * var_575_8.aspect
					local var_575_11 = var_575_6.sprite.bounds.size.x
					local var_575_12 = var_575_6.sprite.bounds.size.y
					local var_575_13 = var_575_10 / var_575_11
					local var_575_14 = var_575_9 / var_575_12
					local var_575_15 = var_575_14 < var_575_13 and var_575_13 or var_575_14

					var_575_5.transform.localScale = Vector3.New(var_575_15, var_575_15, 0)
				end

				for iter_575_0, iter_575_1 in pairs(arg_572_1.bgs_) do
					if iter_575_0 ~= "X204_f" then
						iter_575_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_575_16 = 2

			if var_575_16 < arg_572_1.time_ and arg_572_1.time_ <= var_575_16 + arg_575_0 then
				arg_572_1.allBtn_.enabled = false
			end

			local var_575_17 = 0.3

			if arg_572_1.time_ >= var_575_16 + var_575_17 and arg_572_1.time_ < var_575_16 + var_575_17 + arg_575_0 then
				arg_572_1.allBtn_.enabled = true
			end

			local var_575_18 = 0

			if var_575_18 < arg_572_1.time_ and arg_572_1.time_ <= var_575_18 + arg_575_0 then
				arg_572_1.mask_.enabled = true
				arg_572_1.mask_.raycastTarget = true

				arg_572_1:SetGaussion(false)
			end

			local var_575_19 = 2

			if var_575_18 <= arg_572_1.time_ and arg_572_1.time_ < var_575_18 + var_575_19 then
				local var_575_20 = (arg_572_1.time_ - var_575_18) / var_575_19
				local var_575_21 = Color.New(0, 0, 0)

				var_575_21.a = Mathf.Lerp(1, 0, var_575_20)
				arg_572_1.mask_.color = var_575_21
			end

			if arg_572_1.time_ >= var_575_18 + var_575_19 and arg_572_1.time_ < var_575_18 + var_575_19 + arg_575_0 then
				local var_575_22 = Color.New(0, 0, 0)
				local var_575_23 = 0

				arg_572_1.mask_.enabled = false
				var_575_22.a = var_575_23
				arg_572_1.mask_.color = var_575_22
			end

			local var_575_24 = 5.55111512312578e-17
			local var_575_25 = 1

			if var_575_24 < arg_572_1.time_ and arg_572_1.time_ <= var_575_24 + arg_575_0 then
				local var_575_26 = "stop"
				local var_575_27 = "effect"

				arg_572_1:AudioAction(var_575_26, var_575_27, "se_story_141", "se_story_141_firework", "")
			end

			local var_575_28 = 5.55111512312578e-17
			local var_575_29 = 1

			if var_575_28 < arg_572_1.time_ and arg_572_1.time_ <= var_575_28 + arg_575_0 then
				local var_575_30 = "stop"
				local var_575_31 = "effect"

				arg_572_1:AudioAction(var_575_30, var_575_31, "se_story_141", "se_story_141_amb_street_night", "")
			end

			local var_575_32 = 0
			local var_575_33 = 1

			if var_575_32 < arg_572_1.time_ and arg_572_1.time_ <= var_575_32 + arg_575_0 then
				local var_575_34 = "play"
				local var_575_35 = "effect"

				arg_572_1:AudioAction(var_575_34, var_575_35, "se_story_141", "se_story_141_amb_room", "")
			end

			local var_575_36 = 0
			local var_575_37 = 1

			if var_575_36 < arg_572_1.time_ and arg_572_1.time_ <= var_575_36 + arg_575_0 then
				local var_575_38 = "play"
				local var_575_39 = "effect"

				arg_572_1:AudioAction(var_575_38, var_575_39, "se_story_140", "se_story_140_tinnitus", "")
			end

			local var_575_40 = 0
			local var_575_41 = 1

			if var_575_40 < arg_572_1.time_ and arg_572_1.time_ <= var_575_40 + arg_575_0 then
				local var_575_42 = "play"
				local var_575_43 = "effect"

				arg_572_1:AudioAction(var_575_42, var_575_43, "se_story_141", "se_story_141_boxing_drum03", "")
			end

			local var_575_44 = 0
			local var_575_45 = 0.2

			if var_575_44 < arg_572_1.time_ and arg_572_1.time_ <= var_575_44 + arg_575_0 then
				local var_575_46 = "play"
				local var_575_47 = "music"

				arg_572_1:AudioAction(var_575_46, var_575_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_575_48 = ""
				local var_575_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_575_49 ~= "" then
					if arg_572_1.bgmTxt_.text ~= var_575_49 and arg_572_1.bgmTxt_.text ~= "" then
						if arg_572_1.bgmTxt2_.text ~= "" then
							arg_572_1.bgmTxt_.text = arg_572_1.bgmTxt2_.text
						end

						arg_572_1.bgmTxt2_.text = var_575_49

						arg_572_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_572_1.bgmTxt_.text = var_575_49
						arg_572_1.bgmTxt2_.text = var_575_49
					end

					if arg_572_1.bgmTimer then
						arg_572_1.bgmTimer:Stop()

						arg_572_1.bgmTimer = nil
					end

					if arg_572_1.settingData.show_music_name == 1 then
						arg_572_1.musicController:SetSelectedState("show")
						arg_572_1.musicAnimator_:Play("open", 0, 0)

						if arg_572_1.settingData.music_time ~= 0 then
							arg_572_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_572_1.settingData.music_time), function()
								if arg_572_1 == nil or isNil(arg_572_1.bgmTxt_) then
									return
								end

								arg_572_1.musicController:SetSelectedState("hide")
								arg_572_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_572_1.frameCnt_ <= 1 then
				arg_572_1.dialog_:SetActive(false)
			end

			local var_575_50 = 2
			local var_575_51 = 1.15

			if var_575_50 < arg_572_1.time_ and arg_572_1.time_ <= var_575_50 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0

				arg_572_1.dialog_:SetActive(true)

				arg_572_1.dialogCg_.alpha = 0

				local var_575_52 = LeanTween.value(arg_572_1.dialog_, 0, 1, 0.3)

				var_575_52:setOnUpdate(LuaHelper.FloatAction(function(arg_577_0)
					arg_572_1.dialogCg_.alpha = arg_577_0
				end))
				var_575_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_572_1.dialog_)
					var_575_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_572_1.duration_ = arg_572_1.duration_ + 0.3

				SetActive(arg_572_1.leftNameGo_, false)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_53 = arg_572_1:GetWordFromCfg(924041137)
				local var_575_54 = arg_572_1:FormatText(var_575_53.content)

				arg_572_1.text_.text = var_575_54

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_55 = 46
				local var_575_56 = utf8.len(var_575_54)
				local var_575_57 = var_575_55 <= 0 and var_575_51 or var_575_51 * (var_575_56 / var_575_55)

				if var_575_57 > 0 and var_575_51 < var_575_57 then
					arg_572_1.talkMaxDuration = var_575_57
					var_575_50 = var_575_50 + 0.3

					if var_575_57 + var_575_50 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_57 + var_575_50
					end
				end

				arg_572_1.text_.text = var_575_54
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_58 = var_575_50 + 0.3
			local var_575_59 = math.max(var_575_51, arg_572_1.talkMaxDuration)

			if var_575_58 <= arg_572_1.time_ and arg_572_1.time_ < var_575_58 + var_575_59 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_58) / var_575_59

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_58 + var_575_59 and arg_572_1.time_ < var_575_58 + var_575_59 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play924041138 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 924041138
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play924041139(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0
			local var_582_1 = 0.825

			if var_582_0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_2 = arg_579_1:GetWordFromCfg(924041138)
				local var_582_3 = arg_579_1:FormatText(var_582_2.content)

				arg_579_1.text_.text = var_582_3

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_4 = 33
				local var_582_5 = utf8.len(var_582_3)
				local var_582_6 = var_582_4 <= 0 and var_582_1 or var_582_1 * (var_582_5 / var_582_4)

				if var_582_6 > 0 and var_582_1 < var_582_6 then
					arg_579_1.talkMaxDuration = var_582_6

					if var_582_6 + var_582_0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_6 + var_582_0
					end
				end

				arg_579_1.text_.text = var_582_3
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_1, arg_579_1.talkMaxDuration)

			if var_582_0 <= arg_579_1.time_ and arg_579_1.time_ < var_582_0 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_0) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_0 + var_582_7 and arg_579_1.time_ < var_582_0 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play924041139 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 924041139
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play924041140(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0
			local var_586_1 = 0.275

			if var_586_0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				local var_586_2 = arg_583_1:FormatText(StoryNameCfg[7].name)

				arg_583_1.leftNameTxt_.text = var_586_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_3 = arg_583_1:GetWordFromCfg(924041139)
				local var_586_4 = arg_583_1:FormatText(var_586_3.content)

				arg_583_1.text_.text = var_586_4

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_5 = 11
				local var_586_6 = utf8.len(var_586_4)
				local var_586_7 = var_586_5 <= 0 and var_586_1 or var_586_1 * (var_586_6 / var_586_5)

				if var_586_7 > 0 and var_586_1 < var_586_7 then
					arg_583_1.talkMaxDuration = var_586_7

					if var_586_7 + var_586_0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_7 + var_586_0
					end
				end

				arg_583_1.text_.text = var_586_4
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_8 = math.max(var_586_1, arg_583_1.talkMaxDuration)

			if var_586_0 <= arg_583_1.time_ and arg_583_1.time_ < var_586_0 + var_586_8 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_0) / var_586_8

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_0 + var_586_8 and arg_583_1.time_ < var_586_0 + var_586_8 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play924041140 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 924041140
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play924041141(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0.1
			local var_590_1 = 1

			if var_590_0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_0 + arg_590_0 then
				local var_590_2 = "play"
				local var_590_3 = "effect"

				arg_587_1:AudioAction(var_590_2, var_590_3, "se_story_1310", "se_story_1310_sofa", "")
			end

			local var_590_4 = 0
			local var_590_5 = 0.575

			if var_590_4 < arg_587_1.time_ and arg_587_1.time_ <= var_590_4 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_6 = arg_587_1:GetWordFromCfg(924041140)
				local var_590_7 = arg_587_1:FormatText(var_590_6.content)

				arg_587_1.text_.text = var_590_7

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_8 = 23
				local var_590_9 = utf8.len(var_590_7)
				local var_590_10 = var_590_8 <= 0 and var_590_5 or var_590_5 * (var_590_9 / var_590_8)

				if var_590_10 > 0 and var_590_5 < var_590_10 then
					arg_587_1.talkMaxDuration = var_590_10

					if var_590_10 + var_590_4 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_10 + var_590_4
					end
				end

				arg_587_1.text_.text = var_590_7
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_11 = math.max(var_590_5, arg_587_1.talkMaxDuration)

			if var_590_4 <= arg_587_1.time_ and arg_587_1.time_ < var_590_4 + var_590_11 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_4) / var_590_11

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_4 + var_590_11 and arg_587_1.time_ < var_590_4 + var_590_11 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play924041141 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 924041141
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play924041142(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0
			local var_594_1 = 0.45

			if var_594_0 < arg_591_1.time_ and arg_591_1.time_ <= var_594_0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				local var_594_2 = arg_591_1:FormatText(StoryNameCfg[7].name)

				arg_591_1.leftNameTxt_.text = var_594_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_3 = arg_591_1:GetWordFromCfg(924041141)
				local var_594_4 = arg_591_1:FormatText(var_594_3.content)

				arg_591_1.text_.text = var_594_4

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_5 = 18
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
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_8 = math.max(var_594_1, arg_591_1.talkMaxDuration)

			if var_594_0 <= arg_591_1.time_ and arg_591_1.time_ < var_594_0 + var_594_8 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - var_594_0) / var_594_8

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= var_594_0 + var_594_8 and arg_591_1.time_ < var_594_0 + var_594_8 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play924041142 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 924041142
		arg_595_1.duration_ = 4.83

		local var_595_0 = {
			zh = 2.6,
			ja = 4.833
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play924041143(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0
			local var_598_1 = 0.25

			if var_598_0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				local var_598_2 = arg_595_1:FormatText(StoryNameCfg[10].name)

				arg_595_1.leftNameTxt_.text = var_598_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_3 = arg_595_1:GetWordFromCfg(924041142)
				local var_598_4 = arg_595_1:FormatText(var_598_3.content)

				arg_595_1.text_.text = var_598_4

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_5 = 10
				local var_598_6 = utf8.len(var_598_4)
				local var_598_7 = var_598_5 <= 0 and var_598_1 or var_598_1 * (var_598_6 / var_598_5)

				if var_598_7 > 0 and var_598_1 < var_598_7 then
					arg_595_1.talkMaxDuration = var_598_7

					if var_598_7 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_7 + var_598_0
					end
				end

				arg_595_1.text_.text = var_598_4
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb") ~= 0 then
					local var_598_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb") / 1000

					if var_598_8 + var_598_0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_8 + var_598_0
					end

					if var_598_3.prefab_name ~= "" and arg_595_1.actors_[var_598_3.prefab_name] ~= nil then
						local var_598_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_3.prefab_name].transform, "story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb")

						arg_595_1:RecordAudio("924041142", var_598_9)
						arg_595_1:RecordAudio("924041142", var_598_9)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_10 = math.max(var_598_1, arg_595_1.talkMaxDuration)

			if var_598_0 <= arg_595_1.time_ and arg_595_1.time_ < var_598_0 + var_598_10 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_0) / var_598_10

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_0 + var_598_10 and arg_595_1.time_ < var_598_0 + var_598_10 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play924041143 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 924041143
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play924041144(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0
			local var_602_1 = 0.325

			if var_602_0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				local var_602_2 = arg_599_1:FormatText(StoryNameCfg[7].name)

				arg_599_1.leftNameTxt_.text = var_602_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_3 = arg_599_1:GetWordFromCfg(924041143)
				local var_602_4 = arg_599_1:FormatText(var_602_3.content)

				arg_599_1.text_.text = var_602_4

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 13
				local var_602_6 = utf8.len(var_602_4)
				local var_602_7 = var_602_5 <= 0 and var_602_1 or var_602_1 * (var_602_6 / var_602_5)

				if var_602_7 > 0 and var_602_1 < var_602_7 then
					arg_599_1.talkMaxDuration = var_602_7

					if var_602_7 + var_602_0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_7 + var_602_0
					end
				end

				arg_599_1.text_.text = var_602_4
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_8 = math.max(var_602_1, arg_599_1.talkMaxDuration)

			if var_602_0 <= arg_599_1.time_ and arg_599_1.time_ < var_602_0 + var_602_8 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_0) / var_602_8

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_0 + var_602_8 and arg_599_1.time_ < var_602_0 + var_602_8 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play924041144 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 924041144
		arg_603_1.duration_ = 8.5

		local var_603_0 = {
			zh = 6.633,
			ja = 8.5
		}
		local var_603_1 = manager.audio:GetLocalizationFlag()

		if var_603_0[var_603_1] ~= nil then
			arg_603_1.duration_ = var_603_0[var_603_1]
		end

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play924041145(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0
			local var_606_1 = 0.55

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				local var_606_2 = arg_603_1:FormatText(StoryNameCfg[10].name)

				arg_603_1.leftNameTxt_.text = var_606_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_3 = arg_603_1:GetWordFromCfg(924041144)
				local var_606_4 = arg_603_1:FormatText(var_606_3.content)

				arg_603_1.text_.text = var_606_4

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_5 = 22
				local var_606_6 = utf8.len(var_606_4)
				local var_606_7 = var_606_5 <= 0 and var_606_1 or var_606_1 * (var_606_6 / var_606_5)

				if var_606_7 > 0 and var_606_1 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_0
					end
				end

				arg_603_1.text_.text = var_606_4
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb") ~= 0 then
					local var_606_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb") / 1000

					if var_606_8 + var_606_0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_8 + var_606_0
					end

					if var_606_3.prefab_name ~= "" and arg_603_1.actors_[var_606_3.prefab_name] ~= nil then
						local var_606_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_3.prefab_name].transform, "story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb")

						arg_603_1:RecordAudio("924041144", var_606_9)
						arg_603_1:RecordAudio("924041144", var_606_9)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_10 = math.max(var_606_1, arg_603_1.talkMaxDuration)

			if var_606_0 <= arg_603_1.time_ and arg_603_1.time_ < var_606_0 + var_606_10 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_0) / var_606_10

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_0 + var_606_10 and arg_603_1.time_ < var_606_0 + var_606_10 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play924041145 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 924041145
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play924041146(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0
			local var_610_1 = 0.3

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_2 = arg_607_1:FormatText(StoryNameCfg[7].name)

				arg_607_1.leftNameTxt_.text = var_610_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_3 = arg_607_1:GetWordFromCfg(924041145)
				local var_610_4 = arg_607_1:FormatText(var_610_3.content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_5 = 12
				local var_610_6 = utf8.len(var_610_4)
				local var_610_7 = var_610_5 <= 0 and var_610_1 or var_610_1 * (var_610_6 / var_610_5)

				if var_610_7 > 0 and var_610_1 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_0
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_8 = math.max(var_610_1, arg_607_1.talkMaxDuration)

			if var_610_0 <= arg_607_1.time_ and arg_607_1.time_ < var_610_0 + var_610_8 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_0) / var_610_8

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_0 + var_610_8 and arg_607_1.time_ < var_610_0 + var_610_8 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play924041146 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 924041146
		arg_611_1.duration_ = 3.47

		local var_611_0 = {
			zh = 2.9,
			ja = 3.466
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play924041147(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["102003ui_story"].transform
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 then
				arg_611_1.var_.moveOldPos102003ui_story = var_614_0.localPosition
			end

			local var_614_2 = 0.001

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2
				local var_614_4 = Vector3.New(0, -0.85, -6.21)

				var_614_0.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos102003ui_story, var_614_4, var_614_3)

				local var_614_5 = manager.ui.mainCamera.transform.position - var_614_0.position

				var_614_0.forward = Vector3.New(var_614_5.x, var_614_5.y, var_614_5.z)

				local var_614_6 = var_614_0.localEulerAngles

				var_614_6.z = 0
				var_614_6.x = 0
				var_614_0.localEulerAngles = var_614_6
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 then
				var_614_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_614_7 = manager.ui.mainCamera.transform.position - var_614_0.position

				var_614_0.forward = Vector3.New(var_614_7.x, var_614_7.y, var_614_7.z)

				local var_614_8 = var_614_0.localEulerAngles

				var_614_8.z = 0
				var_614_8.x = 0
				var_614_0.localEulerAngles = var_614_8
			end

			local var_614_9 = arg_611_1.actors_["102003ui_story"]
			local var_614_10 = 0

			if var_614_10 < arg_611_1.time_ and arg_611_1.time_ <= var_614_10 + arg_614_0 and not isNil(var_614_9) and arg_611_1.var_.characterEffect102003ui_story == nil then
				arg_611_1.var_.characterEffect102003ui_story = var_614_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_11 = 0.200000002980232

			if var_614_10 <= arg_611_1.time_ and arg_611_1.time_ < var_614_10 + var_614_11 and not isNil(var_614_9) then
				local var_614_12 = (arg_611_1.time_ - var_614_10) / var_614_11

				if arg_611_1.var_.characterEffect102003ui_story and not isNil(var_614_9) then
					arg_611_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= var_614_10 + var_614_11 and arg_611_1.time_ < var_614_10 + var_614_11 + arg_614_0 and not isNil(var_614_9) and arg_611_1.var_.characterEffect102003ui_story then
				arg_611_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_614_13 = 0

			if var_614_13 < arg_611_1.time_ and arg_611_1.time_ <= var_614_13 + arg_614_0 then
				arg_611_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			local var_614_14 = 0

			if var_614_14 < arg_611_1.time_ and arg_611_1.time_ <= var_614_14 + arg_614_0 then
				arg_611_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_614_15 = 0.125
			local var_614_16 = 1

			if var_614_15 < arg_611_1.time_ and arg_611_1.time_ <= var_614_15 + arg_614_0 then
				local var_614_17 = "play"
				local var_614_18 = "effect"

				arg_611_1:AudioAction(var_614_17, var_614_18, "se_story_141", "se_story_141_knock", "")
			end

			local var_614_19 = 0
			local var_614_20 = 0.2

			if var_614_19 < arg_611_1.time_ and arg_611_1.time_ <= var_614_19 + arg_614_0 then
				local var_614_21 = "play"
				local var_614_22 = "music"

				arg_611_1:AudioAction(var_614_21, var_614_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_614_23 = ""
				local var_614_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_614_24 ~= "" then
					if arg_611_1.bgmTxt_.text ~= var_614_24 and arg_611_1.bgmTxt_.text ~= "" then
						if arg_611_1.bgmTxt2_.text ~= "" then
							arg_611_1.bgmTxt_.text = arg_611_1.bgmTxt2_.text
						end

						arg_611_1.bgmTxt2_.text = var_614_24

						arg_611_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_611_1.bgmTxt_.text = var_614_24
						arg_611_1.bgmTxt2_.text = var_614_24
					end

					if arg_611_1.bgmTimer then
						arg_611_1.bgmTimer:Stop()

						arg_611_1.bgmTimer = nil
					end

					if arg_611_1.settingData.show_music_name == 1 then
						arg_611_1.musicController:SetSelectedState("show")
						arg_611_1.musicAnimator_:Play("open", 0, 0)

						if arg_611_1.settingData.music_time ~= 0 then
							arg_611_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_611_1.settingData.music_time), function()
								if arg_611_1 == nil or isNil(arg_611_1.bgmTxt_) then
									return
								end

								arg_611_1.musicController:SetSelectedState("hide")
								arg_611_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_614_25 = 0.4
			local var_614_26 = 1

			if var_614_25 < arg_611_1.time_ and arg_611_1.time_ <= var_614_25 + arg_614_0 then
				local var_614_27 = "play"
				local var_614_28 = "music"

				arg_611_1:AudioAction(var_614_27, var_614_28, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_614_29 = ""
				local var_614_30 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_614_30 ~= "" then
					if arg_611_1.bgmTxt_.text ~= var_614_30 and arg_611_1.bgmTxt_.text ~= "" then
						if arg_611_1.bgmTxt2_.text ~= "" then
							arg_611_1.bgmTxt_.text = arg_611_1.bgmTxt2_.text
						end

						arg_611_1.bgmTxt2_.text = var_614_30

						arg_611_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_611_1.bgmTxt_.text = var_614_30
						arg_611_1.bgmTxt2_.text = var_614_30
					end

					if arg_611_1.bgmTimer then
						arg_611_1.bgmTimer:Stop()

						arg_611_1.bgmTimer = nil
					end

					if arg_611_1.settingData.show_music_name == 1 then
						arg_611_1.musicController:SetSelectedState("show")
						arg_611_1.musicAnimator_:Play("open", 0, 0)

						if arg_611_1.settingData.music_time ~= 0 then
							arg_611_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_611_1.settingData.music_time), function()
								if arg_611_1 == nil or isNil(arg_611_1.bgmTxt_) then
									return
								end

								arg_611_1.musicController:SetSelectedState("hide")
								arg_611_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_614_31 = 0
			local var_614_32 = 0.225

			if var_614_31 < arg_611_1.time_ and arg_611_1.time_ <= var_614_31 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_33 = arg_611_1:FormatText(StoryNameCfg[613].name)

				arg_611_1.leftNameTxt_.text = var_614_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_34 = arg_611_1:GetWordFromCfg(924041146)
				local var_614_35 = arg_611_1:FormatText(var_614_34.content)

				arg_611_1.text_.text = var_614_35

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_36 = 9
				local var_614_37 = utf8.len(var_614_35)
				local var_614_38 = var_614_36 <= 0 and var_614_32 or var_614_32 * (var_614_37 / var_614_36)

				if var_614_38 > 0 and var_614_32 < var_614_38 then
					arg_611_1.talkMaxDuration = var_614_38

					if var_614_38 + var_614_31 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_38 + var_614_31
					end
				end

				arg_611_1.text_.text = var_614_35
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb") ~= 0 then
					local var_614_39 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb") / 1000

					if var_614_39 + var_614_31 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_39 + var_614_31
					end

					if var_614_34.prefab_name ~= "" and arg_611_1.actors_[var_614_34.prefab_name] ~= nil then
						local var_614_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_34.prefab_name].transform, "story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb")

						arg_611_1:RecordAudio("924041146", var_614_40)
						arg_611_1:RecordAudio("924041146", var_614_40)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_41 = math.max(var_614_32, arg_611_1.talkMaxDuration)

			if var_614_31 <= arg_611_1.time_ and arg_611_1.time_ < var_614_31 + var_614_41 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_31) / var_614_41

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_31 + var_614_41 and arg_611_1.time_ < var_614_31 + var_614_41 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_611_1:InitPlayNodeList()
	end,
	Play924041147 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 924041147
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play924041148(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = arg_617_1.actors_["102003ui_story"].transform
			local var_620_1 = 0

			if var_620_1 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 then
				arg_617_1.var_.moveOldPos102003ui_story = var_620_0.localPosition
			end

			local var_620_2 = 0.001

			if var_620_1 <= arg_617_1.time_ and arg_617_1.time_ < var_620_1 + var_620_2 then
				local var_620_3 = (arg_617_1.time_ - var_620_1) / var_620_2
				local var_620_4 = Vector3.New(0, 100, 0)

				var_620_0.localPosition = Vector3.Lerp(arg_617_1.var_.moveOldPos102003ui_story, var_620_4, var_620_3)

				local var_620_5 = manager.ui.mainCamera.transform.position - var_620_0.position

				var_620_0.forward = Vector3.New(var_620_5.x, var_620_5.y, var_620_5.z)

				local var_620_6 = var_620_0.localEulerAngles

				var_620_6.z = 0
				var_620_6.x = 0
				var_620_0.localEulerAngles = var_620_6
			end

			if arg_617_1.time_ >= var_620_1 + var_620_2 and arg_617_1.time_ < var_620_1 + var_620_2 + arg_620_0 then
				var_620_0.localPosition = Vector3.New(0, 100, 0)

				local var_620_7 = manager.ui.mainCamera.transform.position - var_620_0.position

				var_620_0.forward = Vector3.New(var_620_7.x, var_620_7.y, var_620_7.z)

				local var_620_8 = var_620_0.localEulerAngles

				var_620_8.z = 0
				var_620_8.x = 0
				var_620_0.localEulerAngles = var_620_8
			end

			local var_620_9 = arg_617_1.actors_["102003ui_story"]
			local var_620_10 = 0

			if var_620_10 < arg_617_1.time_ and arg_617_1.time_ <= var_620_10 + arg_620_0 and not isNil(var_620_9) and arg_617_1.var_.characterEffect102003ui_story == nil then
				arg_617_1.var_.characterEffect102003ui_story = var_620_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_11 = 0.200000002980232

			if var_620_10 <= arg_617_1.time_ and arg_617_1.time_ < var_620_10 + var_620_11 and not isNil(var_620_9) then
				local var_620_12 = (arg_617_1.time_ - var_620_10) / var_620_11

				if arg_617_1.var_.characterEffect102003ui_story and not isNil(var_620_9) then
					local var_620_13 = Mathf.Lerp(0, 0.5, var_620_12)

					arg_617_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_617_1.var_.characterEffect102003ui_story.fillRatio = var_620_13
				end
			end

			if arg_617_1.time_ >= var_620_10 + var_620_11 and arg_617_1.time_ < var_620_10 + var_620_11 + arg_620_0 and not isNil(var_620_9) and arg_617_1.var_.characterEffect102003ui_story then
				local var_620_14 = 0.5

				arg_617_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_617_1.var_.characterEffect102003ui_story.fillRatio = var_620_14
			end

			local var_620_15 = 0
			local var_620_16 = 0.725

			if var_620_15 < arg_617_1.time_ and arg_617_1.time_ <= var_620_15 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_17 = arg_617_1:GetWordFromCfg(924041147)
				local var_620_18 = arg_617_1:FormatText(var_620_17.content)

				arg_617_1.text_.text = var_620_18

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_19 = 29
				local var_620_20 = utf8.len(var_620_18)
				local var_620_21 = var_620_19 <= 0 and var_620_16 or var_620_16 * (var_620_20 / var_620_19)

				if var_620_21 > 0 and var_620_16 < var_620_21 then
					arg_617_1.talkMaxDuration = var_620_21

					if var_620_21 + var_620_15 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_21 + var_620_15
					end
				end

				arg_617_1.text_.text = var_620_18
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_22 = math.max(var_620_16, arg_617_1.talkMaxDuration)

			if var_620_15 <= arg_617_1.time_ and arg_617_1.time_ < var_620_15 + var_620_22 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_15) / var_620_22

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_15 + var_620_22 and arg_617_1.time_ < var_620_15 + var_620_22 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_617_1:InitPlayNodeList()
	end,
	Play924041148 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 924041148
		arg_621_1.duration_ = 5.77

		local var_621_0 = {
			zh = 5.2,
			ja = 5.766
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play924041149(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = arg_621_1.actors_["102003ui_story"].transform
			local var_624_1 = 0

			if var_624_1 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.var_.moveOldPos102003ui_story = var_624_0.localPosition
			end

			local var_624_2 = 0.001

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_2 then
				local var_624_3 = (arg_621_1.time_ - var_624_1) / var_624_2
				local var_624_4 = Vector3.New(0, -0.85, -6.21)

				var_624_0.localPosition = Vector3.Lerp(arg_621_1.var_.moveOldPos102003ui_story, var_624_4, var_624_3)

				local var_624_5 = manager.ui.mainCamera.transform.position - var_624_0.position

				var_624_0.forward = Vector3.New(var_624_5.x, var_624_5.y, var_624_5.z)

				local var_624_6 = var_624_0.localEulerAngles

				var_624_6.z = 0
				var_624_6.x = 0
				var_624_0.localEulerAngles = var_624_6
			end

			if arg_621_1.time_ >= var_624_1 + var_624_2 and arg_621_1.time_ < var_624_1 + var_624_2 + arg_624_0 then
				var_624_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_624_7 = manager.ui.mainCamera.transform.position - var_624_0.position

				var_624_0.forward = Vector3.New(var_624_7.x, var_624_7.y, var_624_7.z)

				local var_624_8 = var_624_0.localEulerAngles

				var_624_8.z = 0
				var_624_8.x = 0
				var_624_0.localEulerAngles = var_624_8
			end

			local var_624_9 = arg_621_1.actors_["102003ui_story"]
			local var_624_10 = 0

			if var_624_10 < arg_621_1.time_ and arg_621_1.time_ <= var_624_10 + arg_624_0 and not isNil(var_624_9) and arg_621_1.var_.characterEffect102003ui_story == nil then
				arg_621_1.var_.characterEffect102003ui_story = var_624_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_11 = 0.200000002980232

			if var_624_10 <= arg_621_1.time_ and arg_621_1.time_ < var_624_10 + var_624_11 and not isNil(var_624_9) then
				local var_624_12 = (arg_621_1.time_ - var_624_10) / var_624_11

				if arg_621_1.var_.characterEffect102003ui_story and not isNil(var_624_9) then
					arg_621_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_621_1.time_ >= var_624_10 + var_624_11 and arg_621_1.time_ < var_624_10 + var_624_11 + arg_624_0 and not isNil(var_624_9) and arg_621_1.var_.characterEffect102003ui_story then
				arg_621_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_624_13 = 0

			if var_624_13 < arg_621_1.time_ and arg_621_1.time_ <= var_624_13 + arg_624_0 then
				arg_621_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action483")
			end

			local var_624_14 = 0

			if var_624_14 < arg_621_1.time_ and arg_621_1.time_ <= var_624_14 + arg_624_0 then
				arg_621_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_624_15 = 0
			local var_624_16 = 0.55

			if var_624_15 < arg_621_1.time_ and arg_621_1.time_ <= var_624_15 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_17 = arg_621_1:FormatText(StoryNameCfg[613].name)

				arg_621_1.leftNameTxt_.text = var_624_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_18 = arg_621_1:GetWordFromCfg(924041148)
				local var_624_19 = arg_621_1:FormatText(var_624_18.content)

				arg_621_1.text_.text = var_624_19

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_20 = 22
				local var_624_21 = utf8.len(var_624_19)
				local var_624_22 = var_624_20 <= 0 and var_624_16 or var_624_16 * (var_624_21 / var_624_20)

				if var_624_22 > 0 and var_624_16 < var_624_22 then
					arg_621_1.talkMaxDuration = var_624_22

					if var_624_22 + var_624_15 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_22 + var_624_15
					end
				end

				arg_621_1.text_.text = var_624_19
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb") ~= 0 then
					local var_624_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb") / 1000

					if var_624_23 + var_624_15 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_23 + var_624_15
					end

					if var_624_18.prefab_name ~= "" and arg_621_1.actors_[var_624_18.prefab_name] ~= nil then
						local var_624_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_18.prefab_name].transform, "story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb")

						arg_621_1:RecordAudio("924041148", var_624_24)
						arg_621_1:RecordAudio("924041148", var_624_24)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_25 = math.max(var_624_16, arg_621_1.talkMaxDuration)

			if var_624_15 <= arg_621_1.time_ and arg_621_1.time_ < var_624_15 + var_624_25 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_15) / var_624_25

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_15 + var_624_25 and arg_621_1.time_ < var_624_15 + var_624_25 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_621_1:InitPlayNodeList()
	end,
	Play924041149 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 924041149
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play924041150(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = arg_625_1.actors_["102003ui_story"]
			local var_628_1 = 0

			if var_628_1 < arg_625_1.time_ and arg_625_1.time_ <= var_628_1 + arg_628_0 and not isNil(var_628_0) and arg_625_1.var_.characterEffect102003ui_story == nil then
				arg_625_1.var_.characterEffect102003ui_story = var_628_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_2 = 0.200000002980232

			if var_628_1 <= arg_625_1.time_ and arg_625_1.time_ < var_628_1 + var_628_2 and not isNil(var_628_0) then
				local var_628_3 = (arg_625_1.time_ - var_628_1) / var_628_2

				if arg_625_1.var_.characterEffect102003ui_story and not isNil(var_628_0) then
					local var_628_4 = Mathf.Lerp(0, 0.5, var_628_3)

					arg_625_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_625_1.var_.characterEffect102003ui_story.fillRatio = var_628_4
				end
			end

			if arg_625_1.time_ >= var_628_1 + var_628_2 and arg_625_1.time_ < var_628_1 + var_628_2 + arg_628_0 and not isNil(var_628_0) and arg_625_1.var_.characterEffect102003ui_story then
				local var_628_5 = 0.5

				arg_625_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_625_1.var_.characterEffect102003ui_story.fillRatio = var_628_5
			end

			local var_628_6 = 0
			local var_628_7 = 0.2

			if var_628_6 < arg_625_1.time_ and arg_625_1.time_ <= var_628_6 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				local var_628_8 = arg_625_1:FormatText(StoryNameCfg[7].name)

				arg_625_1.leftNameTxt_.text = var_628_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, true)
				arg_625_1.iconController_:SetSelectedState("hero")

				arg_625_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_625_1.callingController_:SetSelectedState("normal")

				arg_625_1.keyicon_.color = Color.New(1, 1, 1)
				arg_625_1.icon_.color = Color.New(1, 1, 1)

				local var_628_9 = arg_625_1:GetWordFromCfg(924041149)
				local var_628_10 = arg_625_1:FormatText(var_628_9.content)

				arg_625_1.text_.text = var_628_10

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_11 = 8
				local var_628_12 = utf8.len(var_628_10)
				local var_628_13 = var_628_11 <= 0 and var_628_7 or var_628_7 * (var_628_12 / var_628_11)

				if var_628_13 > 0 and var_628_7 < var_628_13 then
					arg_625_1.talkMaxDuration = var_628_13

					if var_628_13 + var_628_6 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_13 + var_628_6
					end
				end

				arg_625_1.text_.text = var_628_10
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_14 = math.max(var_628_7, arg_625_1.talkMaxDuration)

			if var_628_6 <= arg_625_1.time_ and arg_625_1.time_ < var_628_6 + var_628_14 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_6) / var_628_14

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_6 + var_628_14 and arg_625_1.time_ < var_628_6 + var_628_14 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play924041150 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 924041150
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play924041151(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0
			local var_632_1 = 1.15

			if var_632_0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_2 = arg_629_1:GetWordFromCfg(924041150)
				local var_632_3 = arg_629_1:FormatText(var_632_2.content)

				arg_629_1.text_.text = var_632_3

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_4 = 46
				local var_632_5 = utf8.len(var_632_3)
				local var_632_6 = var_632_4 <= 0 and var_632_1 or var_632_1 * (var_632_5 / var_632_4)

				if var_632_6 > 0 and var_632_1 < var_632_6 then
					arg_629_1.talkMaxDuration = var_632_6

					if var_632_6 + var_632_0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_6 + var_632_0
					end
				end

				arg_629_1.text_.text = var_632_3
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_7 = math.max(var_632_1, arg_629_1.talkMaxDuration)

			if var_632_0 <= arg_629_1.time_ and arg_629_1.time_ < var_632_0 + var_632_7 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_0) / var_632_7

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_0 + var_632_7 and arg_629_1.time_ < var_632_0 + var_632_7 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play924041151 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 924041151
		arg_633_1.duration_ = 3.7

		local var_633_0 = {
			zh = 2.4,
			ja = 3.7
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play924041152(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = arg_633_1.actors_["102003ui_story"].transform
			local var_636_1 = 0

			if var_636_1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 then
				arg_633_1.var_.moveOldPos102003ui_story = var_636_0.localPosition
			end

			local var_636_2 = 0.001

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 then
				local var_636_3 = (arg_633_1.time_ - var_636_1) / var_636_2
				local var_636_4 = Vector3.New(0, -0.85, -6.21)

				var_636_0.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos102003ui_story, var_636_4, var_636_3)

				local var_636_5 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_5.x, var_636_5.y, var_636_5.z)

				local var_636_6 = var_636_0.localEulerAngles

				var_636_6.z = 0
				var_636_6.x = 0
				var_636_0.localEulerAngles = var_636_6
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 then
				var_636_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_636_7 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_7.x, var_636_7.y, var_636_7.z)

				local var_636_8 = var_636_0.localEulerAngles

				var_636_8.z = 0
				var_636_8.x = 0
				var_636_0.localEulerAngles = var_636_8
			end

			local var_636_9 = arg_633_1.actors_["102003ui_story"]
			local var_636_10 = 0

			if var_636_10 < arg_633_1.time_ and arg_633_1.time_ <= var_636_10 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect102003ui_story == nil then
				arg_633_1.var_.characterEffect102003ui_story = var_636_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_11 = 0.200000002980232

			if var_636_10 <= arg_633_1.time_ and arg_633_1.time_ < var_636_10 + var_636_11 and not isNil(var_636_9) then
				local var_636_12 = (arg_633_1.time_ - var_636_10) / var_636_11

				if arg_633_1.var_.characterEffect102003ui_story and not isNil(var_636_9) then
					arg_633_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= var_636_10 + var_636_11 and arg_633_1.time_ < var_636_10 + var_636_11 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect102003ui_story then
				arg_633_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_636_13 = 0

			if var_636_13 < arg_633_1.time_ and arg_633_1.time_ <= var_636_13 + arg_636_0 then
				arg_633_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action438")
			end

			local var_636_14 = 0

			if var_636_14 < arg_633_1.time_ and arg_633_1.time_ <= var_636_14 + arg_636_0 then
				arg_633_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_636_15 = 0
			local var_636_16 = 0.25

			if var_636_15 < arg_633_1.time_ and arg_633_1.time_ <= var_636_15 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_17 = arg_633_1:FormatText(StoryNameCfg[613].name)

				arg_633_1.leftNameTxt_.text = var_636_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_18 = arg_633_1:GetWordFromCfg(924041151)
				local var_636_19 = arg_633_1:FormatText(var_636_18.content)

				arg_633_1.text_.text = var_636_19

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_20 = 10
				local var_636_21 = utf8.len(var_636_19)
				local var_636_22 = var_636_20 <= 0 and var_636_16 or var_636_16 * (var_636_21 / var_636_20)

				if var_636_22 > 0 and var_636_16 < var_636_22 then
					arg_633_1.talkMaxDuration = var_636_22

					if var_636_22 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_22 + var_636_15
					end
				end

				arg_633_1.text_.text = var_636_19
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb") ~= 0 then
					local var_636_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb") / 1000

					if var_636_23 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_23 + var_636_15
					end

					if var_636_18.prefab_name ~= "" and arg_633_1.actors_[var_636_18.prefab_name] ~= nil then
						local var_636_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_18.prefab_name].transform, "story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb")

						arg_633_1:RecordAudio("924041151", var_636_24)
						arg_633_1:RecordAudio("924041151", var_636_24)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_25 = math.max(var_636_16, arg_633_1.talkMaxDuration)

			if var_636_15 <= arg_633_1.time_ and arg_633_1.time_ < var_636_15 + var_636_25 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_15) / var_636_25

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_15 + var_636_25 and arg_633_1.time_ < var_636_15 + var_636_25 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play924041152 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 924041152
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play924041153(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = arg_637_1.actors_["102003ui_story"].transform
			local var_640_1 = 0

			if var_640_1 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 then
				arg_637_1.var_.moveOldPos102003ui_story = var_640_0.localPosition
			end

			local var_640_2 = 0.001

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_2 then
				local var_640_3 = (arg_637_1.time_ - var_640_1) / var_640_2
				local var_640_4 = Vector3.New(0, 100, 0)

				var_640_0.localPosition = Vector3.Lerp(arg_637_1.var_.moveOldPos102003ui_story, var_640_4, var_640_3)

				local var_640_5 = manager.ui.mainCamera.transform.position - var_640_0.position

				var_640_0.forward = Vector3.New(var_640_5.x, var_640_5.y, var_640_5.z)

				local var_640_6 = var_640_0.localEulerAngles

				var_640_6.z = 0
				var_640_6.x = 0
				var_640_0.localEulerAngles = var_640_6
			end

			if arg_637_1.time_ >= var_640_1 + var_640_2 and arg_637_1.time_ < var_640_1 + var_640_2 + arg_640_0 then
				var_640_0.localPosition = Vector3.New(0, 100, 0)

				local var_640_7 = manager.ui.mainCamera.transform.position - var_640_0.position

				var_640_0.forward = Vector3.New(var_640_7.x, var_640_7.y, var_640_7.z)

				local var_640_8 = var_640_0.localEulerAngles

				var_640_8.z = 0
				var_640_8.x = 0
				var_640_0.localEulerAngles = var_640_8
			end

			local var_640_9 = arg_637_1.actors_["102003ui_story"]
			local var_640_10 = 0

			if var_640_10 < arg_637_1.time_ and arg_637_1.time_ <= var_640_10 + arg_640_0 and not isNil(var_640_9) and arg_637_1.var_.characterEffect102003ui_story == nil then
				arg_637_1.var_.characterEffect102003ui_story = var_640_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_11 = 0.200000002980232

			if var_640_10 <= arg_637_1.time_ and arg_637_1.time_ < var_640_10 + var_640_11 and not isNil(var_640_9) then
				local var_640_12 = (arg_637_1.time_ - var_640_10) / var_640_11

				if arg_637_1.var_.characterEffect102003ui_story and not isNil(var_640_9) then
					local var_640_13 = Mathf.Lerp(0, 0.5, var_640_12)

					arg_637_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_637_1.var_.characterEffect102003ui_story.fillRatio = var_640_13
				end
			end

			if arg_637_1.time_ >= var_640_10 + var_640_11 and arg_637_1.time_ < var_640_10 + var_640_11 + arg_640_0 and not isNil(var_640_9) and arg_637_1.var_.characterEffect102003ui_story then
				local var_640_14 = 0.5

				arg_637_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_637_1.var_.characterEffect102003ui_story.fillRatio = var_640_14
			end

			local var_640_15 = 0
			local var_640_16 = 0.775

			if var_640_15 < arg_637_1.time_ and arg_637_1.time_ <= var_640_15 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, false)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_17 = arg_637_1:GetWordFromCfg(924041152)
				local var_640_18 = arg_637_1:FormatText(var_640_17.content)

				arg_637_1.text_.text = var_640_18

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_19 = 31
				local var_640_20 = utf8.len(var_640_18)
				local var_640_21 = var_640_19 <= 0 and var_640_16 or var_640_16 * (var_640_20 / var_640_19)

				if var_640_21 > 0 and var_640_16 < var_640_21 then
					arg_637_1.talkMaxDuration = var_640_21

					if var_640_21 + var_640_15 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_21 + var_640_15
					end
				end

				arg_637_1.text_.text = var_640_18
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_22 = math.max(var_640_16, arg_637_1.talkMaxDuration)

			if var_640_15 <= arg_637_1.time_ and arg_637_1.time_ < var_640_15 + var_640_22 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_15) / var_640_22

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_15 + var_640_22 and arg_637_1.time_ < var_640_15 + var_640_22 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_637_1:InitPlayNodeList()
	end,
	Play924041153 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 924041153
		arg_641_1.duration_ = 4.87

		local var_641_0 = {
			zh = 3.733,
			ja = 4.866
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play924041154(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = arg_641_1.actors_["102003ui_story"].transform
			local var_644_1 = 0

			if var_644_1 < arg_641_1.time_ and arg_641_1.time_ <= var_644_1 + arg_644_0 then
				arg_641_1.var_.moveOldPos102003ui_story = var_644_0.localPosition
			end

			local var_644_2 = 0.001

			if var_644_1 <= arg_641_1.time_ and arg_641_1.time_ < var_644_1 + var_644_2 then
				local var_644_3 = (arg_641_1.time_ - var_644_1) / var_644_2
				local var_644_4 = Vector3.New(0, -0.85, -6.21)

				var_644_0.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos102003ui_story, var_644_4, var_644_3)

				local var_644_5 = manager.ui.mainCamera.transform.position - var_644_0.position

				var_644_0.forward = Vector3.New(var_644_5.x, var_644_5.y, var_644_5.z)

				local var_644_6 = var_644_0.localEulerAngles

				var_644_6.z = 0
				var_644_6.x = 0
				var_644_0.localEulerAngles = var_644_6
			end

			if arg_641_1.time_ >= var_644_1 + var_644_2 and arg_641_1.time_ < var_644_1 + var_644_2 + arg_644_0 then
				var_644_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_644_7 = manager.ui.mainCamera.transform.position - var_644_0.position

				var_644_0.forward = Vector3.New(var_644_7.x, var_644_7.y, var_644_7.z)

				local var_644_8 = var_644_0.localEulerAngles

				var_644_8.z = 0
				var_644_8.x = 0
				var_644_0.localEulerAngles = var_644_8
			end

			local var_644_9 = arg_641_1.actors_["102003ui_story"]
			local var_644_10 = 0

			if var_644_10 < arg_641_1.time_ and arg_641_1.time_ <= var_644_10 + arg_644_0 and not isNil(var_644_9) and arg_641_1.var_.characterEffect102003ui_story == nil then
				arg_641_1.var_.characterEffect102003ui_story = var_644_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_11 = 0.200000002980232

			if var_644_10 <= arg_641_1.time_ and arg_641_1.time_ < var_644_10 + var_644_11 and not isNil(var_644_9) then
				local var_644_12 = (arg_641_1.time_ - var_644_10) / var_644_11

				if arg_641_1.var_.characterEffect102003ui_story and not isNil(var_644_9) then
					arg_641_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= var_644_10 + var_644_11 and arg_641_1.time_ < var_644_10 + var_644_11 + arg_644_0 and not isNil(var_644_9) and arg_641_1.var_.characterEffect102003ui_story then
				arg_641_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_644_13 = 0

			if var_644_13 < arg_641_1.time_ and arg_641_1.time_ <= var_644_13 + arg_644_0 then
				arg_641_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action5_1")
			end

			local var_644_14 = 0

			if var_644_14 < arg_641_1.time_ and arg_641_1.time_ <= var_644_14 + arg_644_0 then
				arg_641_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_644_15 = 0
			local var_644_16 = 0.45

			if var_644_15 < arg_641_1.time_ and arg_641_1.time_ <= var_644_15 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_17 = arg_641_1:FormatText(StoryNameCfg[613].name)

				arg_641_1.leftNameTxt_.text = var_644_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_18 = arg_641_1:GetWordFromCfg(924041153)
				local var_644_19 = arg_641_1:FormatText(var_644_18.content)

				arg_641_1.text_.text = var_644_19

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_20 = 18
				local var_644_21 = utf8.len(var_644_19)
				local var_644_22 = var_644_20 <= 0 and var_644_16 or var_644_16 * (var_644_21 / var_644_20)

				if var_644_22 > 0 and var_644_16 < var_644_22 then
					arg_641_1.talkMaxDuration = var_644_22

					if var_644_22 + var_644_15 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_22 + var_644_15
					end
				end

				arg_641_1.text_.text = var_644_19
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb") ~= 0 then
					local var_644_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb") / 1000

					if var_644_23 + var_644_15 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_23 + var_644_15
					end

					if var_644_18.prefab_name ~= "" and arg_641_1.actors_[var_644_18.prefab_name] ~= nil then
						local var_644_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_18.prefab_name].transform, "story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb")

						arg_641_1:RecordAudio("924041153", var_644_24)
						arg_641_1:RecordAudio("924041153", var_644_24)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_25 = math.max(var_644_16, arg_641_1.talkMaxDuration)

			if var_644_15 <= arg_641_1.time_ and arg_641_1.time_ < var_644_15 + var_644_25 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_15) / var_644_25

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_15 + var_644_25 and arg_641_1.time_ < var_644_15 + var_644_25 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_641_1:InitPlayNodeList()
	end,
	Play924041154 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 924041154
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play924041155(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = arg_645_1.actors_["102003ui_story"]
			local var_648_1 = 0

			if var_648_1 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 and not isNil(var_648_0) and arg_645_1.var_.characterEffect102003ui_story == nil then
				arg_645_1.var_.characterEffect102003ui_story = var_648_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_2 = 0.200000002980232

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_2 and not isNil(var_648_0) then
				local var_648_3 = (arg_645_1.time_ - var_648_1) / var_648_2

				if arg_645_1.var_.characterEffect102003ui_story and not isNil(var_648_0) then
					local var_648_4 = Mathf.Lerp(0, 0.5, var_648_3)

					arg_645_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_645_1.var_.characterEffect102003ui_story.fillRatio = var_648_4
				end
			end

			if arg_645_1.time_ >= var_648_1 + var_648_2 and arg_645_1.time_ < var_648_1 + var_648_2 + arg_648_0 and not isNil(var_648_0) and arg_645_1.var_.characterEffect102003ui_story then
				local var_648_5 = 0.5

				arg_645_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_645_1.var_.characterEffect102003ui_story.fillRatio = var_648_5
			end

			local var_648_6 = 0
			local var_648_7 = 0.175

			if var_648_6 < arg_645_1.time_ and arg_645_1.time_ <= var_648_6 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				local var_648_8 = arg_645_1:FormatText(StoryNameCfg[7].name)

				arg_645_1.leftNameTxt_.text = var_648_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_9 = arg_645_1:GetWordFromCfg(924041154)
				local var_648_10 = arg_645_1:FormatText(var_648_9.content)

				arg_645_1.text_.text = var_648_10

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_11 = 7
				local var_648_12 = utf8.len(var_648_10)
				local var_648_13 = var_648_11 <= 0 and var_648_7 or var_648_7 * (var_648_12 / var_648_11)

				if var_648_13 > 0 and var_648_7 < var_648_13 then
					arg_645_1.talkMaxDuration = var_648_13

					if var_648_13 + var_648_6 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_13 + var_648_6
					end
				end

				arg_645_1.text_.text = var_648_10
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_14 = math.max(var_648_7, arg_645_1.talkMaxDuration)

			if var_648_6 <= arg_645_1.time_ and arg_645_1.time_ < var_648_6 + var_648_14 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_6) / var_648_14

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_6 + var_648_14 and arg_645_1.time_ < var_648_6 + var_648_14 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play924041155 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 924041155
		arg_649_1.duration_ = 3.47

		local var_649_0 = {
			zh = 3.266,
			ja = 3.466
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play924041156(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = arg_649_1.actors_["102003ui_story"]
			local var_652_1 = 0

			if var_652_1 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect102003ui_story == nil then
				arg_649_1.var_.characterEffect102003ui_story = var_652_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_2 = 0.200000002980232

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_2 and not isNil(var_652_0) then
				local var_652_3 = (arg_649_1.time_ - var_652_1) / var_652_2

				if arg_649_1.var_.characterEffect102003ui_story and not isNil(var_652_0) then
					arg_649_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_649_1.time_ >= var_652_1 + var_652_2 and arg_649_1.time_ < var_652_1 + var_652_2 + arg_652_0 and not isNil(var_652_0) and arg_649_1.var_.characterEffect102003ui_story then
				arg_649_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_652_4 = 0

			if var_652_4 < arg_649_1.time_ and arg_649_1.time_ <= var_652_4 + arg_652_0 then
				arg_649_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action453")
			end

			local var_652_5 = 0

			if var_652_5 < arg_649_1.time_ and arg_649_1.time_ <= var_652_5 + arg_652_0 then
				arg_649_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_652_6 = 0
			local var_652_7 = 0.175

			if var_652_6 < arg_649_1.time_ and arg_649_1.time_ <= var_652_6 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_8 = arg_649_1:FormatText(StoryNameCfg[613].name)

				arg_649_1.leftNameTxt_.text = var_652_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_9 = arg_649_1:GetWordFromCfg(924041155)
				local var_652_10 = arg_649_1:FormatText(var_652_9.content)

				arg_649_1.text_.text = var_652_10

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_11 = 7
				local var_652_12 = utf8.len(var_652_10)
				local var_652_13 = var_652_11 <= 0 and var_652_7 or var_652_7 * (var_652_12 / var_652_11)

				if var_652_13 > 0 and var_652_7 < var_652_13 then
					arg_649_1.talkMaxDuration = var_652_13

					if var_652_13 + var_652_6 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_13 + var_652_6
					end
				end

				arg_649_1.text_.text = var_652_10
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb") ~= 0 then
					local var_652_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb") / 1000

					if var_652_14 + var_652_6 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_14 + var_652_6
					end

					if var_652_9.prefab_name ~= "" and arg_649_1.actors_[var_652_9.prefab_name] ~= nil then
						local var_652_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_9.prefab_name].transform, "story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb")

						arg_649_1:RecordAudio("924041155", var_652_15)
						arg_649_1:RecordAudio("924041155", var_652_15)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_16 = math.max(var_652_7, arg_649_1.talkMaxDuration)

			if var_652_6 <= arg_649_1.time_ and arg_649_1.time_ < var_652_6 + var_652_16 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_6) / var_652_16

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_6 + var_652_16 and arg_649_1.time_ < var_652_6 + var_652_16 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play924041156 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 924041156
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play924041157(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = arg_653_1.actors_["102003ui_story"].transform
			local var_656_1 = 0

			if var_656_1 < arg_653_1.time_ and arg_653_1.time_ <= var_656_1 + arg_656_0 then
				arg_653_1.var_.moveOldPos102003ui_story = var_656_0.localPosition
			end

			local var_656_2 = 0.001

			if var_656_1 <= arg_653_1.time_ and arg_653_1.time_ < var_656_1 + var_656_2 then
				local var_656_3 = (arg_653_1.time_ - var_656_1) / var_656_2
				local var_656_4 = Vector3.New(0, 100, 0)

				var_656_0.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos102003ui_story, var_656_4, var_656_3)

				local var_656_5 = manager.ui.mainCamera.transform.position - var_656_0.position

				var_656_0.forward = Vector3.New(var_656_5.x, var_656_5.y, var_656_5.z)

				local var_656_6 = var_656_0.localEulerAngles

				var_656_6.z = 0
				var_656_6.x = 0
				var_656_0.localEulerAngles = var_656_6
			end

			if arg_653_1.time_ >= var_656_1 + var_656_2 and arg_653_1.time_ < var_656_1 + var_656_2 + arg_656_0 then
				var_656_0.localPosition = Vector3.New(0, 100, 0)

				local var_656_7 = manager.ui.mainCamera.transform.position - var_656_0.position

				var_656_0.forward = Vector3.New(var_656_7.x, var_656_7.y, var_656_7.z)

				local var_656_8 = var_656_0.localEulerAngles

				var_656_8.z = 0
				var_656_8.x = 0
				var_656_0.localEulerAngles = var_656_8
			end

			local var_656_9 = arg_653_1.actors_["102003ui_story"]
			local var_656_10 = 0

			if var_656_10 < arg_653_1.time_ and arg_653_1.time_ <= var_656_10 + arg_656_0 and not isNil(var_656_9) and arg_653_1.var_.characterEffect102003ui_story == nil then
				arg_653_1.var_.characterEffect102003ui_story = var_656_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_11 = 0.200000002980232

			if var_656_10 <= arg_653_1.time_ and arg_653_1.time_ < var_656_10 + var_656_11 and not isNil(var_656_9) then
				local var_656_12 = (arg_653_1.time_ - var_656_10) / var_656_11

				if arg_653_1.var_.characterEffect102003ui_story and not isNil(var_656_9) then
					local var_656_13 = Mathf.Lerp(0, 0.5, var_656_12)

					arg_653_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_653_1.var_.characterEffect102003ui_story.fillRatio = var_656_13
				end
			end

			if arg_653_1.time_ >= var_656_10 + var_656_11 and arg_653_1.time_ < var_656_10 + var_656_11 + arg_656_0 and not isNil(var_656_9) and arg_653_1.var_.characterEffect102003ui_story then
				local var_656_14 = 0.5

				arg_653_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_653_1.var_.characterEffect102003ui_story.fillRatio = var_656_14
			end

			local var_656_15 = 0
			local var_656_16 = 0.525

			if var_656_15 < arg_653_1.time_ and arg_653_1.time_ <= var_656_15 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_17 = arg_653_1:GetWordFromCfg(924041156)
				local var_656_18 = arg_653_1:FormatText(var_656_17.content)

				arg_653_1.text_.text = var_656_18

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_19 = 21
				local var_656_20 = utf8.len(var_656_18)
				local var_656_21 = var_656_19 <= 0 and var_656_16 or var_656_16 * (var_656_20 / var_656_19)

				if var_656_21 > 0 and var_656_16 < var_656_21 then
					arg_653_1.talkMaxDuration = var_656_21

					if var_656_21 + var_656_15 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_21 + var_656_15
					end
				end

				arg_653_1.text_.text = var_656_18
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_22 = math.max(var_656_16, arg_653_1.talkMaxDuration)

			if var_656_15 <= arg_653_1.time_ and arg_653_1.time_ < var_656_15 + var_656_22 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_15) / var_656_22

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_15 + var_656_22 and arg_653_1.time_ < var_656_15 + var_656_22 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_653_1:InitPlayNodeList()
	end,
	Play924041157 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 924041157
		arg_657_1.duration_ = 9

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play924041158(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 2

			if var_660_0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_0 + arg_660_0 then
				local var_660_1 = manager.ui.mainCamera.transform.localPosition
				local var_660_2 = Vector3.New(0, 0, 10) + Vector3.New(var_660_1.x, var_660_1.y, 0)
				local var_660_3 = arg_657_1.bgs_.STblack

				var_660_3.transform.localPosition = var_660_2
				var_660_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_660_4 = var_660_3:GetComponent("SpriteRenderer")

				if var_660_4 and var_660_4.sprite then
					local var_660_5 = (var_660_3.transform.localPosition - var_660_1).z
					local var_660_6 = manager.ui.mainCameraCom_
					local var_660_7 = 2 * var_660_5 * Mathf.Tan(var_660_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_660_8 = var_660_7 * var_660_6.aspect
					local var_660_9 = var_660_4.sprite.bounds.size.x
					local var_660_10 = var_660_4.sprite.bounds.size.y
					local var_660_11 = var_660_8 / var_660_9
					local var_660_12 = var_660_7 / var_660_10
					local var_660_13 = var_660_12 < var_660_11 and var_660_11 or var_660_12

					var_660_3.transform.localScale = Vector3.New(var_660_13, var_660_13, 0)
				end

				for iter_660_0, iter_660_1 in pairs(arg_657_1.bgs_) do
					if iter_660_0 ~= "STblack" then
						iter_660_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_660_14 = 4

			if var_660_14 < arg_657_1.time_ and arg_657_1.time_ <= var_660_14 + arg_660_0 then
				arg_657_1.allBtn_.enabled = false
			end

			local var_660_15 = 0.3

			if arg_657_1.time_ >= var_660_14 + var_660_15 and arg_657_1.time_ < var_660_14 + var_660_15 + arg_660_0 then
				arg_657_1.allBtn_.enabled = true
			end

			local var_660_16 = 0

			if var_660_16 < arg_657_1.time_ and arg_657_1.time_ <= var_660_16 + arg_660_0 then
				arg_657_1.mask_.enabled = true
				arg_657_1.mask_.raycastTarget = true

				arg_657_1:SetGaussion(false)
			end

			local var_660_17 = 2

			if var_660_16 <= arg_657_1.time_ and arg_657_1.time_ < var_660_16 + var_660_17 then
				local var_660_18 = (arg_657_1.time_ - var_660_16) / var_660_17
				local var_660_19 = Color.New(0, 0, 0)

				var_660_19.a = Mathf.Lerp(0, 1, var_660_18)
				arg_657_1.mask_.color = var_660_19
			end

			if arg_657_1.time_ >= var_660_16 + var_660_17 and arg_657_1.time_ < var_660_16 + var_660_17 + arg_660_0 then
				local var_660_20 = Color.New(0, 0, 0)

				var_660_20.a = 1
				arg_657_1.mask_.color = var_660_20
			end

			local var_660_21 = 2

			if var_660_21 < arg_657_1.time_ and arg_657_1.time_ <= var_660_21 + arg_660_0 then
				arg_657_1.mask_.enabled = true
				arg_657_1.mask_.raycastTarget = true

				arg_657_1:SetGaussion(false)
			end

			local var_660_22 = 2

			if var_660_21 <= arg_657_1.time_ and arg_657_1.time_ < var_660_21 + var_660_22 then
				local var_660_23 = (arg_657_1.time_ - var_660_21) / var_660_22
				local var_660_24 = Color.New(0, 0, 0)

				var_660_24.a = Mathf.Lerp(1, 0, var_660_23)
				arg_657_1.mask_.color = var_660_24
			end

			if arg_657_1.time_ >= var_660_21 + var_660_22 and arg_657_1.time_ < var_660_21 + var_660_22 + arg_660_0 then
				local var_660_25 = Color.New(0, 0, 0)
				local var_660_26 = 0

				arg_657_1.mask_.enabled = false
				var_660_25.a = var_660_26
				arg_657_1.mask_.color = var_660_25
			end

			if arg_657_1.frameCnt_ <= 1 then
				arg_657_1.dialog_:SetActive(false)
			end

			local var_660_27 = 4
			local var_660_28 = 1.15

			if var_660_27 < arg_657_1.time_ and arg_657_1.time_ <= var_660_27 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0

				arg_657_1.dialog_:SetActive(true)

				arg_657_1.dialogCg_.alpha = 0

				local var_660_29 = LeanTween.value(arg_657_1.dialog_, 0, 1, 0.3)

				var_660_29:setOnUpdate(LuaHelper.FloatAction(function(arg_661_0)
					arg_657_1.dialogCg_.alpha = arg_661_0
				end))
				var_660_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_657_1.dialog_)
					var_660_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_657_1.duration_ = arg_657_1.duration_ + 0.3

				SetActive(arg_657_1.leftNameGo_, false)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_30 = arg_657_1:GetWordFromCfg(924041157)
				local var_660_31 = arg_657_1:FormatText(var_660_30.content)

				arg_657_1.text_.text = var_660_31

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_32 = 46
				local var_660_33 = utf8.len(var_660_31)
				local var_660_34 = var_660_32 <= 0 and var_660_28 or var_660_28 * (var_660_33 / var_660_32)

				if var_660_34 > 0 and var_660_28 < var_660_34 then
					arg_657_1.talkMaxDuration = var_660_34
					var_660_27 = var_660_27 + 0.3

					if var_660_34 + var_660_27 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_34 + var_660_27
					end
				end

				arg_657_1.text_.text = var_660_31
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_35 = var_660_27 + 0.3
			local var_660_36 = math.max(var_660_28, arg_657_1.talkMaxDuration)

			if var_660_35 <= arg_657_1.time_ and arg_657_1.time_ < var_660_35 + var_660_36 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_35) / var_660_36

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_35 + var_660_36 and arg_657_1.time_ < var_660_35 + var_660_36 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play924041158 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 924041158
		arg_663_1.duration_ = 7

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play924041159(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = 0

			if var_666_0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_0 + arg_666_0 then
				local var_666_1 = manager.ui.mainCamera.transform.localPosition
				local var_666_2 = Vector3.New(0, 0, 10) + Vector3.New(var_666_1.x, var_666_1.y, 0)
				local var_666_3 = arg_663_1.bgs_.X204_g

				var_666_3.transform.localPosition = var_666_2
				var_666_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_666_4 = var_666_3:GetComponent("SpriteRenderer")

				if var_666_4 and var_666_4.sprite then
					local var_666_5 = (var_666_3.transform.localPosition - var_666_1).z
					local var_666_6 = manager.ui.mainCameraCom_
					local var_666_7 = 2 * var_666_5 * Mathf.Tan(var_666_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_666_8 = var_666_7 * var_666_6.aspect
					local var_666_9 = var_666_4.sprite.bounds.size.x
					local var_666_10 = var_666_4.sprite.bounds.size.y
					local var_666_11 = var_666_8 / var_666_9
					local var_666_12 = var_666_7 / var_666_10
					local var_666_13 = var_666_12 < var_666_11 and var_666_11 or var_666_12

					var_666_3.transform.localScale = Vector3.New(var_666_13, var_666_13, 0)
				end

				for iter_666_0, iter_666_1 in pairs(arg_663_1.bgs_) do
					if iter_666_0 ~= "X204_g" then
						iter_666_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_666_14 = 1.999999999999

			if var_666_14 < arg_663_1.time_ and arg_663_1.time_ <= var_666_14 + arg_666_0 then
				arg_663_1.allBtn_.enabled = false
			end

			local var_666_15 = 0.3

			if arg_663_1.time_ >= var_666_14 + var_666_15 and arg_663_1.time_ < var_666_14 + var_666_15 + arg_666_0 then
				arg_663_1.allBtn_.enabled = true
			end

			local var_666_16 = 0

			if var_666_16 < arg_663_1.time_ and arg_663_1.time_ <= var_666_16 + arg_666_0 then
				arg_663_1.mask_.enabled = true
				arg_663_1.mask_.raycastTarget = true

				arg_663_1:SetGaussion(false)
			end

			local var_666_17 = 2

			if var_666_16 <= arg_663_1.time_ and arg_663_1.time_ < var_666_16 + var_666_17 then
				local var_666_18 = (arg_663_1.time_ - var_666_16) / var_666_17
				local var_666_19 = Color.New(0, 0, 0)

				var_666_19.a = Mathf.Lerp(1, 0, var_666_18)
				arg_663_1.mask_.color = var_666_19
			end

			if arg_663_1.time_ >= var_666_16 + var_666_17 and arg_663_1.time_ < var_666_16 + var_666_17 + arg_666_0 then
				local var_666_20 = Color.New(0, 0, 0)
				local var_666_21 = 0

				arg_663_1.mask_.enabled = false
				var_666_20.a = var_666_21
				arg_663_1.mask_.color = var_666_20
			end

			if arg_663_1.frameCnt_ <= 1 then
				arg_663_1.dialog_:SetActive(false)
			end

			local var_666_22 = 1.999999999999
			local var_666_23 = 1.2

			if var_666_22 < arg_663_1.time_ and arg_663_1.time_ <= var_666_22 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0

				arg_663_1.dialog_:SetActive(true)

				arg_663_1.dialogCg_.alpha = 0

				local var_666_24 = LeanTween.value(arg_663_1.dialog_, 0, 1, 0.3)

				var_666_24:setOnUpdate(LuaHelper.FloatAction(function(arg_667_0)
					arg_663_1.dialogCg_.alpha = arg_667_0
				end))
				var_666_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_663_1.dialog_)
					var_666_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_663_1.duration_ = arg_663_1.duration_ + 0.3

				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_25 = arg_663_1:GetWordFromCfg(924041158)
				local var_666_26 = arg_663_1:FormatText(var_666_25.content)

				arg_663_1.text_.text = var_666_26

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_27 = 48
				local var_666_28 = utf8.len(var_666_26)
				local var_666_29 = var_666_27 <= 0 and var_666_23 or var_666_23 * (var_666_28 / var_666_27)

				if var_666_29 > 0 and var_666_23 < var_666_29 then
					arg_663_1.talkMaxDuration = var_666_29
					var_666_22 = var_666_22 + 0.3

					if var_666_29 + var_666_22 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_29 + var_666_22
					end
				end

				arg_663_1.text_.text = var_666_26
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_30 = var_666_22 + 0.3
			local var_666_31 = math.max(var_666_23, arg_663_1.talkMaxDuration)

			if var_666_30 <= arg_663_1.time_ and arg_663_1.time_ < var_666_30 + var_666_31 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_30) / var_666_31

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_30 + var_666_31 and arg_663_1.time_ < var_666_30 + var_666_31 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play924041159 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 924041159
		arg_669_1.duration_ = 7.9

		local var_669_0 = {
			zh = 6.333,
			ja = 7.9
		}
		local var_669_1 = manager.audio:GetLocalizationFlag()

		if var_669_0[var_669_1] ~= nil then
			arg_669_1.duration_ = var_669_0[var_669_1]
		end

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play924041160(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = arg_669_1.actors_["102003ui_story"].transform
			local var_672_1 = 0

			if var_672_1 < arg_669_1.time_ and arg_669_1.time_ <= var_672_1 + arg_672_0 then
				arg_669_1.var_.moveOldPos102003ui_story = var_672_0.localPosition
			end

			local var_672_2 = 0.001

			if var_672_1 <= arg_669_1.time_ and arg_669_1.time_ < var_672_1 + var_672_2 then
				local var_672_3 = (arg_669_1.time_ - var_672_1) / var_672_2
				local var_672_4 = Vector3.New(0, -0.85, -6.21)

				var_672_0.localPosition = Vector3.Lerp(arg_669_1.var_.moveOldPos102003ui_story, var_672_4, var_672_3)

				local var_672_5 = manager.ui.mainCamera.transform.position - var_672_0.position

				var_672_0.forward = Vector3.New(var_672_5.x, var_672_5.y, var_672_5.z)

				local var_672_6 = var_672_0.localEulerAngles

				var_672_6.z = 0
				var_672_6.x = 0
				var_672_0.localEulerAngles = var_672_6
			end

			if arg_669_1.time_ >= var_672_1 + var_672_2 and arg_669_1.time_ < var_672_1 + var_672_2 + arg_672_0 then
				var_672_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_672_7 = manager.ui.mainCamera.transform.position - var_672_0.position

				var_672_0.forward = Vector3.New(var_672_7.x, var_672_7.y, var_672_7.z)

				local var_672_8 = var_672_0.localEulerAngles

				var_672_8.z = 0
				var_672_8.x = 0
				var_672_0.localEulerAngles = var_672_8
			end

			local var_672_9 = arg_669_1.actors_["102003ui_story"]
			local var_672_10 = 0

			if var_672_10 < arg_669_1.time_ and arg_669_1.time_ <= var_672_10 + arg_672_0 and not isNil(var_672_9) and arg_669_1.var_.characterEffect102003ui_story == nil then
				arg_669_1.var_.characterEffect102003ui_story = var_672_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_11 = 0.200000002980232

			if var_672_10 <= arg_669_1.time_ and arg_669_1.time_ < var_672_10 + var_672_11 and not isNil(var_672_9) then
				local var_672_12 = (arg_669_1.time_ - var_672_10) / var_672_11

				if arg_669_1.var_.characterEffect102003ui_story and not isNil(var_672_9) then
					arg_669_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_669_1.time_ >= var_672_10 + var_672_11 and arg_669_1.time_ < var_672_10 + var_672_11 + arg_672_0 and not isNil(var_672_9) and arg_669_1.var_.characterEffect102003ui_story then
				arg_669_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_672_13 = 0

			if var_672_13 < arg_669_1.time_ and arg_669_1.time_ <= var_672_13 + arg_672_0 then
				arg_669_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			local var_672_14 = 0

			if var_672_14 < arg_669_1.time_ and arg_669_1.time_ <= var_672_14 + arg_672_0 then
				arg_669_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_672_15 = 0
			local var_672_16 = 0.5

			if var_672_15 < arg_669_1.time_ and arg_669_1.time_ <= var_672_15 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				local var_672_17 = arg_669_1:FormatText(StoryNameCfg[613].name)

				arg_669_1.leftNameTxt_.text = var_672_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_18 = arg_669_1:GetWordFromCfg(924041159)
				local var_672_19 = arg_669_1:FormatText(var_672_18.content)

				arg_669_1.text_.text = var_672_19

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_20 = 20
				local var_672_21 = utf8.len(var_672_19)
				local var_672_22 = var_672_20 <= 0 and var_672_16 or var_672_16 * (var_672_21 / var_672_20)

				if var_672_22 > 0 and var_672_16 < var_672_22 then
					arg_669_1.talkMaxDuration = var_672_22

					if var_672_22 + var_672_15 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_22 + var_672_15
					end
				end

				arg_669_1.text_.text = var_672_19
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb") ~= 0 then
					local var_672_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb") / 1000

					if var_672_23 + var_672_15 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_23 + var_672_15
					end

					if var_672_18.prefab_name ~= "" and arg_669_1.actors_[var_672_18.prefab_name] ~= nil then
						local var_672_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_18.prefab_name].transform, "story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb")

						arg_669_1:RecordAudio("924041159", var_672_24)
						arg_669_1:RecordAudio("924041159", var_672_24)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_25 = math.max(var_672_16, arg_669_1.talkMaxDuration)

			if var_672_15 <= arg_669_1.time_ and arg_669_1.time_ < var_672_15 + var_672_25 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_15) / var_672_25

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_15 + var_672_25 and arg_669_1.time_ < var_672_15 + var_672_25 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_669_1:InitPlayNodeList()
	end,
	Play924041160 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 924041160
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play924041161(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = arg_673_1.actors_["102003ui_story"]
			local var_676_1 = 0

			if var_676_1 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect102003ui_story == nil then
				arg_673_1.var_.characterEffect102003ui_story = var_676_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_2 = 0.200000002980232

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_2 and not isNil(var_676_0) then
				local var_676_3 = (arg_673_1.time_ - var_676_1) / var_676_2

				if arg_673_1.var_.characterEffect102003ui_story and not isNil(var_676_0) then
					local var_676_4 = Mathf.Lerp(0, 0.5, var_676_3)

					arg_673_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_673_1.var_.characterEffect102003ui_story.fillRatio = var_676_4
				end
			end

			if arg_673_1.time_ >= var_676_1 + var_676_2 and arg_673_1.time_ < var_676_1 + var_676_2 + arg_676_0 and not isNil(var_676_0) and arg_673_1.var_.characterEffect102003ui_story then
				local var_676_5 = 0.5

				arg_673_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_673_1.var_.characterEffect102003ui_story.fillRatio = var_676_5
			end

			local var_676_6 = 0
			local var_676_7 = 0.125

			if var_676_6 < arg_673_1.time_ and arg_673_1.time_ <= var_676_6 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_8 = arg_673_1:FormatText(StoryNameCfg[7].name)

				arg_673_1.leftNameTxt_.text = var_676_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, true)
				arg_673_1.iconController_:SetSelectedState("hero")

				arg_673_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_673_1.callingController_:SetSelectedState("normal")

				arg_673_1.keyicon_.color = Color.New(1, 1, 1)
				arg_673_1.icon_.color = Color.New(1, 1, 1)

				local var_676_9 = arg_673_1:GetWordFromCfg(924041160)
				local var_676_10 = arg_673_1:FormatText(var_676_9.content)

				arg_673_1.text_.text = var_676_10

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_11 = 5
				local var_676_12 = utf8.len(var_676_10)
				local var_676_13 = var_676_11 <= 0 and var_676_7 or var_676_7 * (var_676_12 / var_676_11)

				if var_676_13 > 0 and var_676_7 < var_676_13 then
					arg_673_1.talkMaxDuration = var_676_13

					if var_676_13 + var_676_6 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_13 + var_676_6
					end
				end

				arg_673_1.text_.text = var_676_10
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_14 = math.max(var_676_7, arg_673_1.talkMaxDuration)

			if var_676_6 <= arg_673_1.time_ and arg_673_1.time_ < var_676_6 + var_676_14 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_6) / var_676_14

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_6 + var_676_14 and arg_673_1.time_ < var_676_6 + var_676_14 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play924041161 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 924041161
		arg_677_1.duration_ = 3.37

		local var_677_0 = {
			zh = 3.366,
			ja = 2.933
		}
		local var_677_1 = manager.audio:GetLocalizationFlag()

		if var_677_0[var_677_1] ~= nil then
			arg_677_1.duration_ = var_677_0[var_677_1]
		end

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play924041162(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = arg_677_1.actors_["102003ui_story"]
			local var_680_1 = 0

			if var_680_1 < arg_677_1.time_ and arg_677_1.time_ <= var_680_1 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect102003ui_story == nil then
				arg_677_1.var_.characterEffect102003ui_story = var_680_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_2 = 0.200000002980232

			if var_680_1 <= arg_677_1.time_ and arg_677_1.time_ < var_680_1 + var_680_2 and not isNil(var_680_0) then
				local var_680_3 = (arg_677_1.time_ - var_680_1) / var_680_2

				if arg_677_1.var_.characterEffect102003ui_story and not isNil(var_680_0) then
					arg_677_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= var_680_1 + var_680_2 and arg_677_1.time_ < var_680_1 + var_680_2 + arg_680_0 and not isNil(var_680_0) and arg_677_1.var_.characterEffect102003ui_story then
				arg_677_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_680_4 = 0

			if var_680_4 < arg_677_1.time_ and arg_677_1.time_ <= var_680_4 + arg_680_0 then
				arg_677_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action468")
			end

			local var_680_5 = 0
			local var_680_6 = 0.3

			if var_680_5 < arg_677_1.time_ and arg_677_1.time_ <= var_680_5 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_7 = arg_677_1:FormatText(StoryNameCfg[613].name)

				arg_677_1.leftNameTxt_.text = var_680_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_8 = arg_677_1:GetWordFromCfg(924041161)
				local var_680_9 = arg_677_1:FormatText(var_680_8.content)

				arg_677_1.text_.text = var_680_9

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_10 = 12
				local var_680_11 = utf8.len(var_680_9)
				local var_680_12 = var_680_10 <= 0 and var_680_6 or var_680_6 * (var_680_11 / var_680_10)

				if var_680_12 > 0 and var_680_6 < var_680_12 then
					arg_677_1.talkMaxDuration = var_680_12

					if var_680_12 + var_680_5 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_12 + var_680_5
					end
				end

				arg_677_1.text_.text = var_680_9
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb") ~= 0 then
					local var_680_13 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb") / 1000

					if var_680_13 + var_680_5 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_13 + var_680_5
					end

					if var_680_8.prefab_name ~= "" and arg_677_1.actors_[var_680_8.prefab_name] ~= nil then
						local var_680_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_8.prefab_name].transform, "story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb")

						arg_677_1:RecordAudio("924041161", var_680_14)
						arg_677_1:RecordAudio("924041161", var_680_14)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_15 = math.max(var_680_6, arg_677_1.talkMaxDuration)

			if var_680_5 <= arg_677_1.time_ and arg_677_1.time_ < var_680_5 + var_680_15 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_5) / var_680_15

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_5 + var_680_15 and arg_677_1.time_ < var_680_5 + var_680_15 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play924041162 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 924041162
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play924041163(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = arg_681_1.actors_["102003ui_story"]
			local var_684_1 = 0

			if var_684_1 < arg_681_1.time_ and arg_681_1.time_ <= var_684_1 + arg_684_0 and not isNil(var_684_0) and arg_681_1.var_.characterEffect102003ui_story == nil then
				arg_681_1.var_.characterEffect102003ui_story = var_684_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_2 = 0.200000002980232

			if var_684_1 <= arg_681_1.time_ and arg_681_1.time_ < var_684_1 + var_684_2 and not isNil(var_684_0) then
				local var_684_3 = (arg_681_1.time_ - var_684_1) / var_684_2

				if arg_681_1.var_.characterEffect102003ui_story and not isNil(var_684_0) then
					local var_684_4 = Mathf.Lerp(0, 0.5, var_684_3)

					arg_681_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_681_1.var_.characterEffect102003ui_story.fillRatio = var_684_4
				end
			end

			if arg_681_1.time_ >= var_684_1 + var_684_2 and arg_681_1.time_ < var_684_1 + var_684_2 + arg_684_0 and not isNil(var_684_0) and arg_681_1.var_.characterEffect102003ui_story then
				local var_684_5 = 0.5

				arg_681_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_681_1.var_.characterEffect102003ui_story.fillRatio = var_684_5
			end

			local var_684_6 = 0
			local var_684_7 = 0.475

			if var_684_6 < arg_681_1.time_ and arg_681_1.time_ <= var_684_6 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				local var_684_8 = arg_681_1:FormatText(StoryNameCfg[7].name)

				arg_681_1.leftNameTxt_.text = var_684_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, true)
				arg_681_1.iconController_:SetSelectedState("hero")

				arg_681_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_681_1.callingController_:SetSelectedState("normal")

				arg_681_1.keyicon_.color = Color.New(1, 1, 1)
				arg_681_1.icon_.color = Color.New(1, 1, 1)

				local var_684_9 = arg_681_1:GetWordFromCfg(924041162)
				local var_684_10 = arg_681_1:FormatText(var_684_9.content)

				arg_681_1.text_.text = var_684_10

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_11 = 19
				local var_684_12 = utf8.len(var_684_10)
				local var_684_13 = var_684_11 <= 0 and var_684_7 or var_684_7 * (var_684_12 / var_684_11)

				if var_684_13 > 0 and var_684_7 < var_684_13 then
					arg_681_1.talkMaxDuration = var_684_13

					if var_684_13 + var_684_6 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_13 + var_684_6
					end
				end

				arg_681_1.text_.text = var_684_10
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_14 = math.max(var_684_7, arg_681_1.talkMaxDuration)

			if var_684_6 <= arg_681_1.time_ and arg_681_1.time_ < var_684_6 + var_684_14 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_6) / var_684_14

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_6 + var_684_14 and arg_681_1.time_ < var_684_6 + var_684_14 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play924041163 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 924041163
		arg_685_1.duration_ = 2.4

		local var_685_0 = {
			zh = 2.4,
			ja = 1.9
		}
		local var_685_1 = manager.audio:GetLocalizationFlag()

		if var_685_0[var_685_1] ~= nil then
			arg_685_1.duration_ = var_685_0[var_685_1]
		end

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play924041164(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = arg_685_1.actors_["102003ui_story"]
			local var_688_1 = 0

			if var_688_1 < arg_685_1.time_ and arg_685_1.time_ <= var_688_1 + arg_688_0 and not isNil(var_688_0) and arg_685_1.var_.characterEffect102003ui_story == nil then
				arg_685_1.var_.characterEffect102003ui_story = var_688_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_2 = 0.200000002980232

			if var_688_1 <= arg_685_1.time_ and arg_685_1.time_ < var_688_1 + var_688_2 and not isNil(var_688_0) then
				local var_688_3 = (arg_685_1.time_ - var_688_1) / var_688_2

				if arg_685_1.var_.characterEffect102003ui_story and not isNil(var_688_0) then
					arg_685_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_685_1.time_ >= var_688_1 + var_688_2 and arg_685_1.time_ < var_688_1 + var_688_2 + arg_688_0 and not isNil(var_688_0) and arg_685_1.var_.characterEffect102003ui_story then
				arg_685_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_688_4 = 0
			local var_688_5 = 0.15

			if var_688_4 < arg_685_1.time_ and arg_685_1.time_ <= var_688_4 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				local var_688_6 = arg_685_1:FormatText(StoryNameCfg[613].name)

				arg_685_1.leftNameTxt_.text = var_688_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_7 = arg_685_1:GetWordFromCfg(924041163)
				local var_688_8 = arg_685_1:FormatText(var_688_7.content)

				arg_685_1.text_.text = var_688_8

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_9 = 6
				local var_688_10 = utf8.len(var_688_8)
				local var_688_11 = var_688_9 <= 0 and var_688_5 or var_688_5 * (var_688_10 / var_688_9)

				if var_688_11 > 0 and var_688_5 < var_688_11 then
					arg_685_1.talkMaxDuration = var_688_11

					if var_688_11 + var_688_4 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_11 + var_688_4
					end
				end

				arg_685_1.text_.text = var_688_8
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb") ~= 0 then
					local var_688_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb") / 1000

					if var_688_12 + var_688_4 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_12 + var_688_4
					end

					if var_688_7.prefab_name ~= "" and arg_685_1.actors_[var_688_7.prefab_name] ~= nil then
						local var_688_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_685_1.actors_[var_688_7.prefab_name].transform, "story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb")

						arg_685_1:RecordAudio("924041163", var_688_13)
						arg_685_1:RecordAudio("924041163", var_688_13)
					else
						arg_685_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb")
					end

					arg_685_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb")
				end

				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_14 = math.max(var_688_5, arg_685_1.talkMaxDuration)

			if var_688_4 <= arg_685_1.time_ and arg_685_1.time_ < var_688_4 + var_688_14 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_4) / var_688_14

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_4 + var_688_14 and arg_685_1.time_ < var_688_4 + var_688_14 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play924041164 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 924041164
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play924041165(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = arg_689_1.actors_["102003ui_story"]
			local var_692_1 = 0

			if var_692_1 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 and not isNil(var_692_0) and arg_689_1.var_.characterEffect102003ui_story == nil then
				arg_689_1.var_.characterEffect102003ui_story = var_692_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_2 = 0.200000002980232

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_2 and not isNil(var_692_0) then
				local var_692_3 = (arg_689_1.time_ - var_692_1) / var_692_2

				if arg_689_1.var_.characterEffect102003ui_story and not isNil(var_692_0) then
					local var_692_4 = Mathf.Lerp(0, 0.5, var_692_3)

					arg_689_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_689_1.var_.characterEffect102003ui_story.fillRatio = var_692_4
				end
			end

			if arg_689_1.time_ >= var_692_1 + var_692_2 and arg_689_1.time_ < var_692_1 + var_692_2 + arg_692_0 and not isNil(var_692_0) and arg_689_1.var_.characterEffect102003ui_story then
				local var_692_5 = 0.5

				arg_689_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_689_1.var_.characterEffect102003ui_story.fillRatio = var_692_5
			end

			local var_692_6 = 0
			local var_692_7 = 1.1

			if var_692_6 < arg_689_1.time_ and arg_689_1.time_ <= var_692_6 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				local var_692_8 = arg_689_1:FormatText(StoryNameCfg[7].name)

				arg_689_1.leftNameTxt_.text = var_692_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, true)
				arg_689_1.iconController_:SetSelectedState("hero")

				arg_689_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_689_1.callingController_:SetSelectedState("normal")

				arg_689_1.keyicon_.color = Color.New(1, 1, 1)
				arg_689_1.icon_.color = Color.New(1, 1, 1)

				local var_692_9 = arg_689_1:GetWordFromCfg(924041164)
				local var_692_10 = arg_689_1:FormatText(var_692_9.content)

				arg_689_1.text_.text = var_692_10

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_11 = 44
				local var_692_12 = utf8.len(var_692_10)
				local var_692_13 = var_692_11 <= 0 and var_692_7 or var_692_7 * (var_692_12 / var_692_11)

				if var_692_13 > 0 and var_692_7 < var_692_13 then
					arg_689_1.talkMaxDuration = var_692_13

					if var_692_13 + var_692_6 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_13 + var_692_6
					end
				end

				arg_689_1.text_.text = var_692_10
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_14 = math.max(var_692_7, arg_689_1.talkMaxDuration)

			if var_692_6 <= arg_689_1.time_ and arg_689_1.time_ < var_692_6 + var_692_14 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_6) / var_692_14

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_6 + var_692_14 and arg_689_1.time_ < var_692_6 + var_692_14 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play924041165 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 924041165
		arg_693_1.duration_ = 3.6

		local var_693_0 = {
			zh = 2.3,
			ja = 3.6
		}
		local var_693_1 = manager.audio:GetLocalizationFlag()

		if var_693_0[var_693_1] ~= nil then
			arg_693_1.duration_ = var_693_0[var_693_1]
		end

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play924041166(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = arg_693_1.actors_["102003ui_story"]
			local var_696_1 = 0

			if var_696_1 < arg_693_1.time_ and arg_693_1.time_ <= var_696_1 + arg_696_0 and not isNil(var_696_0) and arg_693_1.var_.characterEffect102003ui_story == nil then
				arg_693_1.var_.characterEffect102003ui_story = var_696_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_2 = 0.200000002980232

			if var_696_1 <= arg_693_1.time_ and arg_693_1.time_ < var_696_1 + var_696_2 and not isNil(var_696_0) then
				local var_696_3 = (arg_693_1.time_ - var_696_1) / var_696_2

				if arg_693_1.var_.characterEffect102003ui_story and not isNil(var_696_0) then
					arg_693_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_693_1.time_ >= var_696_1 + var_696_2 and arg_693_1.time_ < var_696_1 + var_696_2 + arg_696_0 and not isNil(var_696_0) and arg_693_1.var_.characterEffect102003ui_story then
				arg_693_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_696_4 = 0

			if var_696_4 < arg_693_1.time_ and arg_693_1.time_ <= var_696_4 + arg_696_0 then
				arg_693_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_696_5 = 0
			local var_696_6 = 0.275

			if var_696_5 < arg_693_1.time_ and arg_693_1.time_ <= var_696_5 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				local var_696_7 = arg_693_1:FormatText(StoryNameCfg[613].name)

				arg_693_1.leftNameTxt_.text = var_696_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_8 = arg_693_1:GetWordFromCfg(924041165)
				local var_696_9 = arg_693_1:FormatText(var_696_8.content)

				arg_693_1.text_.text = var_696_9

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_10 = 11
				local var_696_11 = utf8.len(var_696_9)
				local var_696_12 = var_696_10 <= 0 and var_696_6 or var_696_6 * (var_696_11 / var_696_10)

				if var_696_12 > 0 and var_696_6 < var_696_12 then
					arg_693_1.talkMaxDuration = var_696_12

					if var_696_12 + var_696_5 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_12 + var_696_5
					end
				end

				arg_693_1.text_.text = var_696_9
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb") ~= 0 then
					local var_696_13 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb") / 1000

					if var_696_13 + var_696_5 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_13 + var_696_5
					end

					if var_696_8.prefab_name ~= "" and arg_693_1.actors_[var_696_8.prefab_name] ~= nil then
						local var_696_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_8.prefab_name].transform, "story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb")

						arg_693_1:RecordAudio("924041165", var_696_14)
						arg_693_1:RecordAudio("924041165", var_696_14)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_15 = math.max(var_696_6, arg_693_1.talkMaxDuration)

			if var_696_5 <= arg_693_1.time_ and arg_693_1.time_ < var_696_5 + var_696_15 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_5) / var_696_15

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_5 + var_696_15 and arg_693_1.time_ < var_696_5 + var_696_15 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play924041166 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 924041166
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play924041167(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = arg_697_1.actors_["102003ui_story"]
			local var_700_1 = 0

			if var_700_1 < arg_697_1.time_ and arg_697_1.time_ <= var_700_1 + arg_700_0 and not isNil(var_700_0) and arg_697_1.var_.characterEffect102003ui_story == nil then
				arg_697_1.var_.characterEffect102003ui_story = var_700_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_700_2 = 0.200000002980232

			if var_700_1 <= arg_697_1.time_ and arg_697_1.time_ < var_700_1 + var_700_2 and not isNil(var_700_0) then
				local var_700_3 = (arg_697_1.time_ - var_700_1) / var_700_2

				if arg_697_1.var_.characterEffect102003ui_story and not isNil(var_700_0) then
					local var_700_4 = Mathf.Lerp(0, 0.5, var_700_3)

					arg_697_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_697_1.var_.characterEffect102003ui_story.fillRatio = var_700_4
				end
			end

			if arg_697_1.time_ >= var_700_1 + var_700_2 and arg_697_1.time_ < var_700_1 + var_700_2 + arg_700_0 and not isNil(var_700_0) and arg_697_1.var_.characterEffect102003ui_story then
				local var_700_5 = 0.5

				arg_697_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_697_1.var_.characterEffect102003ui_story.fillRatio = var_700_5
			end

			local var_700_6 = 0
			local var_700_7 = 1.15

			if var_700_6 < arg_697_1.time_ and arg_697_1.time_ <= var_700_6 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				local var_700_8 = arg_697_1:FormatText(StoryNameCfg[7].name)

				arg_697_1.leftNameTxt_.text = var_700_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, true)
				arg_697_1.iconController_:SetSelectedState("hero")

				arg_697_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_697_1.callingController_:SetSelectedState("normal")

				arg_697_1.keyicon_.color = Color.New(1, 1, 1)
				arg_697_1.icon_.color = Color.New(1, 1, 1)

				local var_700_9 = arg_697_1:GetWordFromCfg(924041166)
				local var_700_10 = arg_697_1:FormatText(var_700_9.content)

				arg_697_1.text_.text = var_700_10

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_11 = 46
				local var_700_12 = utf8.len(var_700_10)
				local var_700_13 = var_700_11 <= 0 and var_700_7 or var_700_7 * (var_700_12 / var_700_11)

				if var_700_13 > 0 and var_700_7 < var_700_13 then
					arg_697_1.talkMaxDuration = var_700_13

					if var_700_13 + var_700_6 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_13 + var_700_6
					end
				end

				arg_697_1.text_.text = var_700_10
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_14 = math.max(var_700_7, arg_697_1.talkMaxDuration)

			if var_700_6 <= arg_697_1.time_ and arg_697_1.time_ < var_700_6 + var_700_14 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_6) / var_700_14

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_6 + var_700_14 and arg_697_1.time_ < var_700_6 + var_700_14 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play924041167 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 924041167
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play924041168(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0
			local var_704_1 = 0.35

			if var_704_0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				local var_704_2 = arg_701_1:FormatText(StoryNameCfg[7].name)

				arg_701_1.leftNameTxt_.text = var_704_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, true)
				arg_701_1.iconController_:SetSelectedState("hero")

				arg_701_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_701_1.callingController_:SetSelectedState("normal")

				arg_701_1.keyicon_.color = Color.New(1, 1, 1)
				arg_701_1.icon_.color = Color.New(1, 1, 1)

				local var_704_3 = arg_701_1:GetWordFromCfg(924041167)
				local var_704_4 = arg_701_1:FormatText(var_704_3.content)

				arg_701_1.text_.text = var_704_4

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_5 = 14
				local var_704_6 = utf8.len(var_704_4)
				local var_704_7 = var_704_5 <= 0 and var_704_1 or var_704_1 * (var_704_6 / var_704_5)

				if var_704_7 > 0 and var_704_1 < var_704_7 then
					arg_701_1.talkMaxDuration = var_704_7

					if var_704_7 + var_704_0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_7 + var_704_0
					end
				end

				arg_701_1.text_.text = var_704_4
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_8 = math.max(var_704_1, arg_701_1.talkMaxDuration)

			if var_704_0 <= arg_701_1.time_ and arg_701_1.time_ < var_704_0 + var_704_8 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_0) / var_704_8

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_0 + var_704_8 and arg_701_1.time_ < var_704_0 + var_704_8 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play924041168 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 924041168
		arg_705_1.duration_ = 1

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"

			SetActive(arg_705_1.choicesGo_, true)

			for iter_706_0, iter_706_1 in ipairs(arg_705_1.choices_) do
				local var_706_0 = iter_706_0 <= 1

				SetActive(iter_706_1.go, var_706_0)
			end

			arg_705_1.choices_[1].txt.text = arg_705_1:FormatText(StoryChoiceCfg[1214].name)
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play924041169(arg_705_1)
			end

			arg_705_1:RecordChoiceLog(924041168, 1214)
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = 0

			if var_708_0 < arg_705_1.time_ and arg_705_1.time_ <= var_708_0 + arg_708_0 then
				arg_705_1.allBtn_.enabled = false
			end

			local var_708_1 = 0.6

			if arg_705_1.time_ >= var_708_0 + var_708_1 and arg_705_1.time_ < var_708_0 + var_708_1 + arg_708_0 then
				arg_705_1.allBtn_.enabled = true
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play924041169 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 924041169
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play924041170(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = arg_709_1.actors_["102003ui_story"].transform
			local var_712_1 = 0

			if var_712_1 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 then
				arg_709_1.var_.moveOldPos102003ui_story = var_712_0.localPosition
			end

			local var_712_2 = 0.001

			if var_712_1 <= arg_709_1.time_ and arg_709_1.time_ < var_712_1 + var_712_2 then
				local var_712_3 = (arg_709_1.time_ - var_712_1) / var_712_2
				local var_712_4 = Vector3.New(0, 100, 0)

				var_712_0.localPosition = Vector3.Lerp(arg_709_1.var_.moveOldPos102003ui_story, var_712_4, var_712_3)

				local var_712_5 = manager.ui.mainCamera.transform.position - var_712_0.position

				var_712_0.forward = Vector3.New(var_712_5.x, var_712_5.y, var_712_5.z)

				local var_712_6 = var_712_0.localEulerAngles

				var_712_6.z = 0
				var_712_6.x = 0
				var_712_0.localEulerAngles = var_712_6
			end

			if arg_709_1.time_ >= var_712_1 + var_712_2 and arg_709_1.time_ < var_712_1 + var_712_2 + arg_712_0 then
				var_712_0.localPosition = Vector3.New(0, 100, 0)

				local var_712_7 = manager.ui.mainCamera.transform.position - var_712_0.position

				var_712_0.forward = Vector3.New(var_712_7.x, var_712_7.y, var_712_7.z)

				local var_712_8 = var_712_0.localEulerAngles

				var_712_8.z = 0
				var_712_8.x = 0
				var_712_0.localEulerAngles = var_712_8
			end

			local var_712_9 = 0
			local var_712_10 = 1

			if var_712_9 < arg_709_1.time_ and arg_709_1.time_ <= var_712_9 + arg_712_0 then
				local var_712_11 = "play"
				local var_712_12 = "effect"

				arg_709_1:AudioAction(var_712_11, var_712_12, "se_story_141", "se_story_141_firework02", "")
			end

			local var_712_13 = 0
			local var_712_14 = 0.5

			if var_712_13 < arg_709_1.time_ and arg_709_1.time_ <= var_712_13 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, false)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_15 = arg_709_1:GetWordFromCfg(924041169)
				local var_712_16 = arg_709_1:FormatText(var_712_15.content)

				arg_709_1.text_.text = var_712_16

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_17 = 20
				local var_712_18 = utf8.len(var_712_16)
				local var_712_19 = var_712_17 <= 0 and var_712_14 or var_712_14 * (var_712_18 / var_712_17)

				if var_712_19 > 0 and var_712_14 < var_712_19 then
					arg_709_1.talkMaxDuration = var_712_19

					if var_712_19 + var_712_13 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_19 + var_712_13
					end
				end

				arg_709_1.text_.text = var_712_16
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_20 = math.max(var_712_14, arg_709_1.talkMaxDuration)

			if var_712_13 <= arg_709_1.time_ and arg_709_1.time_ < var_712_13 + var_712_20 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_13) / var_712_20

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_13 + var_712_20 and arg_709_1.time_ < var_712_13 + var_712_20 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_709_1:InitPlayNodeList()
	end,
	Play924041170 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 924041170
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play924041171(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0
			local var_716_1 = 0.3

			if var_716_0 < arg_713_1.time_ and arg_713_1.time_ <= var_716_0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				local var_716_2 = arg_713_1:FormatText(StoryNameCfg[7].name)

				arg_713_1.leftNameTxt_.text = var_716_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_3 = arg_713_1:GetWordFromCfg(924041170)
				local var_716_4 = arg_713_1:FormatText(var_716_3.content)

				arg_713_1.text_.text = var_716_4

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_5 = 12
				local var_716_6 = utf8.len(var_716_4)
				local var_716_7 = var_716_5 <= 0 and var_716_1 or var_716_1 * (var_716_6 / var_716_5)

				if var_716_7 > 0 and var_716_1 < var_716_7 then
					arg_713_1.talkMaxDuration = var_716_7

					if var_716_7 + var_716_0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_7 + var_716_0
					end
				end

				arg_713_1.text_.text = var_716_4
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_8 = math.max(var_716_1, arg_713_1.talkMaxDuration)

			if var_716_0 <= arg_713_1.time_ and arg_713_1.time_ < var_716_0 + var_716_8 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_0) / var_716_8

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_0 + var_716_8 and arg_713_1.time_ < var_716_0 + var_716_8 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play924041171 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 924041171
		arg_717_1.duration_ = 7.8

		local var_717_0 = {
			zh = 5.1,
			ja = 7.8
		}
		local var_717_1 = manager.audio:GetLocalizationFlag()

		if var_717_0[var_717_1] ~= nil then
			arg_717_1.duration_ = var_717_0[var_717_1]
		end

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play924041172(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 2

			if var_720_0 < arg_717_1.time_ and arg_717_1.time_ <= var_720_0 + arg_720_0 then
				local var_720_1 = manager.ui.mainCamera.transform.localPosition
				local var_720_2 = Vector3.New(0, 0, 10) + Vector3.New(var_720_1.x, var_720_1.y, 0)
				local var_720_3 = arg_717_1.bgs_.SP92401b

				var_720_3.transform.localPosition = var_720_2
				var_720_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_720_4 = var_720_3:GetComponent("SpriteRenderer")

				if var_720_4 and var_720_4.sprite then
					local var_720_5 = (var_720_3.transform.localPosition - var_720_1).z
					local var_720_6 = manager.ui.mainCameraCom_
					local var_720_7 = 2 * var_720_5 * Mathf.Tan(var_720_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_720_8 = var_720_7 * var_720_6.aspect
					local var_720_9 = var_720_4.sprite.bounds.size.x
					local var_720_10 = var_720_4.sprite.bounds.size.y
					local var_720_11 = var_720_8 / var_720_9
					local var_720_12 = var_720_7 / var_720_10
					local var_720_13 = var_720_12 < var_720_11 and var_720_11 or var_720_12

					var_720_3.transform.localScale = Vector3.New(var_720_13, var_720_13, 0)
				end

				for iter_720_0, iter_720_1 in pairs(arg_717_1.bgs_) do
					if iter_720_0 ~= "SP92401b" then
						iter_720_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_720_14 = 4

			if var_720_14 < arg_717_1.time_ and arg_717_1.time_ <= var_720_14 + arg_720_0 then
				arg_717_1.allBtn_.enabled = false
			end

			local var_720_15 = 0.3

			if arg_717_1.time_ >= var_720_14 + var_720_15 and arg_717_1.time_ < var_720_14 + var_720_15 + arg_720_0 then
				arg_717_1.allBtn_.enabled = true
			end

			local var_720_16 = 0

			if var_720_16 < arg_717_1.time_ and arg_717_1.time_ <= var_720_16 + arg_720_0 then
				arg_717_1.mask_.enabled = true
				arg_717_1.mask_.raycastTarget = true

				arg_717_1:SetGaussion(false)
			end

			local var_720_17 = 2

			if var_720_16 <= arg_717_1.time_ and arg_717_1.time_ < var_720_16 + var_720_17 then
				local var_720_18 = (arg_717_1.time_ - var_720_16) / var_720_17
				local var_720_19 = Color.New(0, 0, 0)

				var_720_19.a = Mathf.Lerp(0, 1, var_720_18)
				arg_717_1.mask_.color = var_720_19
			end

			if arg_717_1.time_ >= var_720_16 + var_720_17 and arg_717_1.time_ < var_720_16 + var_720_17 + arg_720_0 then
				local var_720_20 = Color.New(0, 0, 0)

				var_720_20.a = 1
				arg_717_1.mask_.color = var_720_20
			end

			local var_720_21 = 2

			if var_720_21 < arg_717_1.time_ and arg_717_1.time_ <= var_720_21 + arg_720_0 then
				arg_717_1.mask_.enabled = true
				arg_717_1.mask_.raycastTarget = true

				arg_717_1:SetGaussion(false)
			end

			local var_720_22 = 2

			if var_720_21 <= arg_717_1.time_ and arg_717_1.time_ < var_720_21 + var_720_22 then
				local var_720_23 = (arg_717_1.time_ - var_720_21) / var_720_22
				local var_720_24 = Color.New(0, 0, 0)

				var_720_24.a = Mathf.Lerp(1, 0, var_720_23)
				arg_717_1.mask_.color = var_720_24
			end

			if arg_717_1.time_ >= var_720_21 + var_720_22 and arg_717_1.time_ < var_720_21 + var_720_22 + arg_720_0 then
				local var_720_25 = Color.New(0, 0, 0)
				local var_720_26 = 0

				arg_717_1.mask_.enabled = false
				var_720_25.a = var_720_26
				arg_717_1.mask_.color = var_720_25
			end

			local var_720_27 = 1.6
			local var_720_28 = 1

			if var_720_27 < arg_717_1.time_ and arg_717_1.time_ <= var_720_27 + arg_720_0 then
				local var_720_29 = "play"
				local var_720_30 = "effect"

				arg_717_1:AudioAction(var_720_29, var_720_30, "se_story_141", "se_story_141_amb_street_night", "")
			end

			local var_720_31 = 0.125
			local var_720_32 = 1

			if var_720_31 < arg_717_1.time_ and arg_717_1.time_ <= var_720_31 + arg_720_0 then
				local var_720_33 = "stop"
				local var_720_34 = "effect"

				arg_717_1:AudioAction(var_720_33, var_720_34, "se_story_141", "se_story_141_amb_room", "")
			end

			if arg_717_1.frameCnt_ <= 1 then
				arg_717_1.dialog_:SetActive(false)
			end

			local var_720_35 = 4
			local var_720_36 = 0.125

			if var_720_35 < arg_717_1.time_ and arg_717_1.time_ <= var_720_35 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0

				arg_717_1.dialog_:SetActive(true)

				arg_717_1.dialogCg_.alpha = 0

				local var_720_37 = LeanTween.value(arg_717_1.dialog_, 0, 1, 0.3)

				var_720_37:setOnUpdate(LuaHelper.FloatAction(function(arg_721_0)
					arg_717_1.dialogCg_.alpha = arg_721_0
				end))
				var_720_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_717_1.dialog_)
					var_720_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_717_1.duration_ = arg_717_1.duration_ + 0.3

				SetActive(arg_717_1.leftNameGo_, true)

				local var_720_38 = arg_717_1:FormatText(StoryNameCfg[613].name)

				arg_717_1.leftNameTxt_.text = var_720_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_39 = arg_717_1:GetWordFromCfg(924041171)
				local var_720_40 = arg_717_1:FormatText(var_720_39.content)

				arg_717_1.text_.text = var_720_40

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_41 = 5
				local var_720_42 = utf8.len(var_720_40)
				local var_720_43 = var_720_41 <= 0 and var_720_36 or var_720_36 * (var_720_42 / var_720_41)

				if var_720_43 > 0 and var_720_36 < var_720_43 then
					arg_717_1.talkMaxDuration = var_720_43
					var_720_35 = var_720_35 + 0.3

					if var_720_43 + var_720_35 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_43 + var_720_35
					end
				end

				arg_717_1.text_.text = var_720_40
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb") ~= 0 then
					local var_720_44 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb") / 1000

					if var_720_44 + var_720_35 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_44 + var_720_35
					end

					if var_720_39.prefab_name ~= "" and arg_717_1.actors_[var_720_39.prefab_name] ~= nil then
						local var_720_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_39.prefab_name].transform, "story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb")

						arg_717_1:RecordAudio("924041171", var_720_45)
						arg_717_1:RecordAudio("924041171", var_720_45)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_46 = var_720_35 + 0.3
			local var_720_47 = math.max(var_720_36, arg_717_1.talkMaxDuration)

			if var_720_46 <= arg_717_1.time_ and arg_717_1.time_ < var_720_46 + var_720_47 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_46) / var_720_47

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_46 + var_720_47 and arg_717_1.time_ < var_720_46 + var_720_47 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play924041172 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 924041172
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play924041173(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = arg_723_1.actors_["102003ui_story"]
			local var_726_1 = 0

			if var_726_1 < arg_723_1.time_ and arg_723_1.time_ <= var_726_1 + arg_726_0 and not isNil(var_726_0) and arg_723_1.var_.characterEffect102003ui_story == nil then
				arg_723_1.var_.characterEffect102003ui_story = var_726_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_2 = 0.200000002980232

			if var_726_1 <= arg_723_1.time_ and arg_723_1.time_ < var_726_1 + var_726_2 and not isNil(var_726_0) then
				local var_726_3 = (arg_723_1.time_ - var_726_1) / var_726_2

				if arg_723_1.var_.characterEffect102003ui_story and not isNil(var_726_0) then
					local var_726_4 = Mathf.Lerp(0, 0.5, var_726_3)

					arg_723_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_723_1.var_.characterEffect102003ui_story.fillRatio = var_726_4
				end
			end

			if arg_723_1.time_ >= var_726_1 + var_726_2 and arg_723_1.time_ < var_726_1 + var_726_2 + arg_726_0 and not isNil(var_726_0) and arg_723_1.var_.characterEffect102003ui_story then
				local var_726_5 = 0.5

				arg_723_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_723_1.var_.characterEffect102003ui_story.fillRatio = var_726_5
			end

			local var_726_6 = 0
			local var_726_7 = 0.8

			if var_726_6 < arg_723_1.time_ and arg_723_1.time_ <= var_726_6 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_8 = arg_723_1:GetWordFromCfg(924041172)
				local var_726_9 = arg_723_1:FormatText(var_726_8.content)

				arg_723_1.text_.text = var_726_9

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_10 = 32
				local var_726_11 = utf8.len(var_726_9)
				local var_726_12 = var_726_10 <= 0 and var_726_7 or var_726_7 * (var_726_11 / var_726_10)

				if var_726_12 > 0 and var_726_7 < var_726_12 then
					arg_723_1.talkMaxDuration = var_726_12

					if var_726_12 + var_726_6 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_12 + var_726_6
					end
				end

				arg_723_1.text_.text = var_726_9
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_13 = math.max(var_726_7, arg_723_1.talkMaxDuration)

			if var_726_6 <= arg_723_1.time_ and arg_723_1.time_ < var_726_6 + var_726_13 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_6) / var_726_13

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_6 + var_726_13 and arg_723_1.time_ < var_726_6 + var_726_13 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play924041173 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 924041173
		arg_727_1.duration_ = 3.93

		local var_727_0 = {
			zh = 1.766,
			ja = 3.933
		}
		local var_727_1 = manager.audio:GetLocalizationFlag()

		if var_727_0[var_727_1] ~= nil then
			arg_727_1.duration_ = var_727_0[var_727_1]
		end

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play924041174(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = arg_727_1.actors_["102003ui_story"]
			local var_730_1 = 0

			if var_730_1 < arg_727_1.time_ and arg_727_1.time_ <= var_730_1 + arg_730_0 and not isNil(var_730_0) and arg_727_1.var_.characterEffect102003ui_story == nil then
				arg_727_1.var_.characterEffect102003ui_story = var_730_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_2 = 0.200000002980232

			if var_730_1 <= arg_727_1.time_ and arg_727_1.time_ < var_730_1 + var_730_2 and not isNil(var_730_0) then
				local var_730_3 = (arg_727_1.time_ - var_730_1) / var_730_2

				if arg_727_1.var_.characterEffect102003ui_story and not isNil(var_730_0) then
					arg_727_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_727_1.time_ >= var_730_1 + var_730_2 and arg_727_1.time_ < var_730_1 + var_730_2 + arg_730_0 and not isNil(var_730_0) and arg_727_1.var_.characterEffect102003ui_story then
				arg_727_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_730_4 = 0
			local var_730_5 = 0.15

			if var_730_4 < arg_727_1.time_ and arg_727_1.time_ <= var_730_4 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				local var_730_6 = arg_727_1:FormatText(StoryNameCfg[613].name)

				arg_727_1.leftNameTxt_.text = var_730_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_7 = arg_727_1:GetWordFromCfg(924041173)
				local var_730_8 = arg_727_1:FormatText(var_730_7.content)

				arg_727_1.text_.text = var_730_8

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_9 = 6
				local var_730_10 = utf8.len(var_730_8)
				local var_730_11 = var_730_9 <= 0 and var_730_5 or var_730_5 * (var_730_10 / var_730_9)

				if var_730_11 > 0 and var_730_5 < var_730_11 then
					arg_727_1.talkMaxDuration = var_730_11

					if var_730_11 + var_730_4 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_11 + var_730_4
					end
				end

				arg_727_1.text_.text = var_730_8
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb") ~= 0 then
					local var_730_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb") / 1000

					if var_730_12 + var_730_4 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_12 + var_730_4
					end

					if var_730_7.prefab_name ~= "" and arg_727_1.actors_[var_730_7.prefab_name] ~= nil then
						local var_730_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_727_1.actors_[var_730_7.prefab_name].transform, "story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb")

						arg_727_1:RecordAudio("924041173", var_730_13)
						arg_727_1:RecordAudio("924041173", var_730_13)
					else
						arg_727_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb")
					end

					arg_727_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb")
				end

				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_14 = math.max(var_730_5, arg_727_1.talkMaxDuration)

			if var_730_4 <= arg_727_1.time_ and arg_727_1.time_ < var_730_4 + var_730_14 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_4) / var_730_14

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_4 + var_730_14 and arg_727_1.time_ < var_730_4 + var_730_14 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play924041174 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 924041174
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play924041175(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = arg_731_1.actors_["102003ui_story"]
			local var_734_1 = 0

			if var_734_1 < arg_731_1.time_ and arg_731_1.time_ <= var_734_1 + arg_734_0 and not isNil(var_734_0) and arg_731_1.var_.characterEffect102003ui_story == nil then
				arg_731_1.var_.characterEffect102003ui_story = var_734_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_2 = 0.200000002980232

			if var_734_1 <= arg_731_1.time_ and arg_731_1.time_ < var_734_1 + var_734_2 and not isNil(var_734_0) then
				local var_734_3 = (arg_731_1.time_ - var_734_1) / var_734_2

				if arg_731_1.var_.characterEffect102003ui_story and not isNil(var_734_0) then
					local var_734_4 = Mathf.Lerp(0, 0.5, var_734_3)

					arg_731_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_731_1.var_.characterEffect102003ui_story.fillRatio = var_734_4
				end
			end

			if arg_731_1.time_ >= var_734_1 + var_734_2 and arg_731_1.time_ < var_734_1 + var_734_2 + arg_734_0 and not isNil(var_734_0) and arg_731_1.var_.characterEffect102003ui_story then
				local var_734_5 = 0.5

				arg_731_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_731_1.var_.characterEffect102003ui_story.fillRatio = var_734_5
			end

			local var_734_6 = 0
			local var_734_7 = 0.175

			if var_734_6 < arg_731_1.time_ and arg_731_1.time_ <= var_734_6 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				local var_734_8 = arg_731_1:FormatText(StoryNameCfg[7].name)

				arg_731_1.leftNameTxt_.text = var_734_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, true)
				arg_731_1.iconController_:SetSelectedState("hero")

				arg_731_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_731_1.callingController_:SetSelectedState("normal")

				arg_731_1.keyicon_.color = Color.New(1, 1, 1)
				arg_731_1.icon_.color = Color.New(1, 1, 1)

				local var_734_9 = arg_731_1:GetWordFromCfg(924041174)
				local var_734_10 = arg_731_1:FormatText(var_734_9.content)

				arg_731_1.text_.text = var_734_10

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_11 = 7
				local var_734_12 = utf8.len(var_734_10)
				local var_734_13 = var_734_11 <= 0 and var_734_7 or var_734_7 * (var_734_12 / var_734_11)

				if var_734_13 > 0 and var_734_7 < var_734_13 then
					arg_731_1.talkMaxDuration = var_734_13

					if var_734_13 + var_734_6 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_13 + var_734_6
					end
				end

				arg_731_1.text_.text = var_734_10
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_14 = math.max(var_734_7, arg_731_1.talkMaxDuration)

			if var_734_6 <= arg_731_1.time_ and arg_731_1.time_ < var_734_6 + var_734_14 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_6) / var_734_14

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_6 + var_734_14 and arg_731_1.time_ < var_734_6 + var_734_14 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play924041175 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 924041175
		arg_735_1.duration_ = 5.83

		local var_735_0 = {
			zh = 5.7,
			ja = 5.833
		}
		local var_735_1 = manager.audio:GetLocalizationFlag()

		if var_735_0[var_735_1] ~= nil then
			arg_735_1.duration_ = var_735_0[var_735_1]
		end

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play924041176(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = arg_735_1.actors_["102003ui_story"]
			local var_738_1 = 0

			if var_738_1 < arg_735_1.time_ and arg_735_1.time_ <= var_738_1 + arg_738_0 and not isNil(var_738_0) and arg_735_1.var_.characterEffect102003ui_story == nil then
				arg_735_1.var_.characterEffect102003ui_story = var_738_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_2 = 0.200000002980232

			if var_738_1 <= arg_735_1.time_ and arg_735_1.time_ < var_738_1 + var_738_2 and not isNil(var_738_0) then
				local var_738_3 = (arg_735_1.time_ - var_738_1) / var_738_2

				if arg_735_1.var_.characterEffect102003ui_story and not isNil(var_738_0) then
					arg_735_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_735_1.time_ >= var_738_1 + var_738_2 and arg_735_1.time_ < var_738_1 + var_738_2 + arg_738_0 and not isNil(var_738_0) and arg_735_1.var_.characterEffect102003ui_story then
				arg_735_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_738_4 = 0
			local var_738_5 = 0.425

			if var_738_4 < arg_735_1.time_ and arg_735_1.time_ <= var_738_4 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				local var_738_6 = arg_735_1:FormatText(StoryNameCfg[613].name)

				arg_735_1.leftNameTxt_.text = var_738_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_7 = arg_735_1:GetWordFromCfg(924041175)
				local var_738_8 = arg_735_1:FormatText(var_738_7.content)

				arg_735_1.text_.text = var_738_8

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_9 = 17
				local var_738_10 = utf8.len(var_738_8)
				local var_738_11 = var_738_9 <= 0 and var_738_5 or var_738_5 * (var_738_10 / var_738_9)

				if var_738_11 > 0 and var_738_5 < var_738_11 then
					arg_735_1.talkMaxDuration = var_738_11

					if var_738_11 + var_738_4 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_11 + var_738_4
					end
				end

				arg_735_1.text_.text = var_738_8
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb") ~= 0 then
					local var_738_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb") / 1000

					if var_738_12 + var_738_4 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_12 + var_738_4
					end

					if var_738_7.prefab_name ~= "" and arg_735_1.actors_[var_738_7.prefab_name] ~= nil then
						local var_738_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_735_1.actors_[var_738_7.prefab_name].transform, "story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb")

						arg_735_1:RecordAudio("924041175", var_738_13)
						arg_735_1:RecordAudio("924041175", var_738_13)
					else
						arg_735_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb")
					end

					arg_735_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb")
				end

				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_14 = math.max(var_738_5, arg_735_1.talkMaxDuration)

			if var_738_4 <= arg_735_1.time_ and arg_735_1.time_ < var_738_4 + var_738_14 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_4) / var_738_14

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_4 + var_738_14 and arg_735_1.time_ < var_738_4 + var_738_14 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play924041176 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 924041176
		arg_739_1.duration_ = 5

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play924041177(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = arg_739_1.actors_["102003ui_story"]
			local var_742_1 = 0

			if var_742_1 < arg_739_1.time_ and arg_739_1.time_ <= var_742_1 + arg_742_0 and not isNil(var_742_0) and arg_739_1.var_.characterEffect102003ui_story == nil then
				arg_739_1.var_.characterEffect102003ui_story = var_742_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_742_2 = 0.200000002980232

			if var_742_1 <= arg_739_1.time_ and arg_739_1.time_ < var_742_1 + var_742_2 and not isNil(var_742_0) then
				local var_742_3 = (arg_739_1.time_ - var_742_1) / var_742_2

				if arg_739_1.var_.characterEffect102003ui_story and not isNil(var_742_0) then
					local var_742_4 = Mathf.Lerp(0, 0.5, var_742_3)

					arg_739_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_739_1.var_.characterEffect102003ui_story.fillRatio = var_742_4
				end
			end

			if arg_739_1.time_ >= var_742_1 + var_742_2 and arg_739_1.time_ < var_742_1 + var_742_2 + arg_742_0 and not isNil(var_742_0) and arg_739_1.var_.characterEffect102003ui_story then
				local var_742_5 = 0.5

				arg_739_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_739_1.var_.characterEffect102003ui_story.fillRatio = var_742_5
			end

			local var_742_6 = 0
			local var_742_7 = 0.175

			if var_742_6 < arg_739_1.time_ and arg_739_1.time_ <= var_742_6 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				local var_742_8 = arg_739_1:FormatText(StoryNameCfg[7].name)

				arg_739_1.leftNameTxt_.text = var_742_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, true)
				arg_739_1.iconController_:SetSelectedState("hero")

				arg_739_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_739_1.callingController_:SetSelectedState("normal")

				arg_739_1.keyicon_.color = Color.New(1, 1, 1)
				arg_739_1.icon_.color = Color.New(1, 1, 1)

				local var_742_9 = arg_739_1:GetWordFromCfg(924041176)
				local var_742_10 = arg_739_1:FormatText(var_742_9.content)

				arg_739_1.text_.text = var_742_10

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_11 = 7
				local var_742_12 = utf8.len(var_742_10)
				local var_742_13 = var_742_11 <= 0 and var_742_7 or var_742_7 * (var_742_12 / var_742_11)

				if var_742_13 > 0 and var_742_7 < var_742_13 then
					arg_739_1.talkMaxDuration = var_742_13

					if var_742_13 + var_742_6 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_13 + var_742_6
					end
				end

				arg_739_1.text_.text = var_742_10
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_14 = math.max(var_742_7, arg_739_1.talkMaxDuration)

			if var_742_6 <= arg_739_1.time_ and arg_739_1.time_ < var_742_6 + var_742_14 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_6) / var_742_14

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_6 + var_742_14 and arg_739_1.time_ < var_742_6 + var_742_14 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {}

		arg_739_1:InitPlayNodeList()
	end,
	Play924041177 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 924041177
		arg_743_1.duration_ = 5.27

		local var_743_0 = {
			zh = 4.533,
			ja = 5.266
		}
		local var_743_1 = manager.audio:GetLocalizationFlag()

		if var_743_0[var_743_1] ~= nil then
			arg_743_1.duration_ = var_743_0[var_743_1]
		end

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play924041178(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = arg_743_1.actors_["102003ui_story"]
			local var_746_1 = 0

			if var_746_1 < arg_743_1.time_ and arg_743_1.time_ <= var_746_1 + arg_746_0 and not isNil(var_746_0) and arg_743_1.var_.characterEffect102003ui_story == nil then
				arg_743_1.var_.characterEffect102003ui_story = var_746_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_2 = 0.200000002980232

			if var_746_1 <= arg_743_1.time_ and arg_743_1.time_ < var_746_1 + var_746_2 and not isNil(var_746_0) then
				local var_746_3 = (arg_743_1.time_ - var_746_1) / var_746_2

				if arg_743_1.var_.characterEffect102003ui_story and not isNil(var_746_0) then
					arg_743_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_743_1.time_ >= var_746_1 + var_746_2 and arg_743_1.time_ < var_746_1 + var_746_2 + arg_746_0 and not isNil(var_746_0) and arg_743_1.var_.characterEffect102003ui_story then
				arg_743_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_746_4 = 0
			local var_746_5 = 0.425

			if var_746_4 < arg_743_1.time_ and arg_743_1.time_ <= var_746_4 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				local var_746_6 = arg_743_1:FormatText(StoryNameCfg[613].name)

				arg_743_1.leftNameTxt_.text = var_746_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_7 = arg_743_1:GetWordFromCfg(924041177)
				local var_746_8 = arg_743_1:FormatText(var_746_7.content)

				arg_743_1.text_.text = var_746_8

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_9 = 17
				local var_746_10 = utf8.len(var_746_8)
				local var_746_11 = var_746_9 <= 0 and var_746_5 or var_746_5 * (var_746_10 / var_746_9)

				if var_746_11 > 0 and var_746_5 < var_746_11 then
					arg_743_1.talkMaxDuration = var_746_11

					if var_746_11 + var_746_4 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_11 + var_746_4
					end
				end

				arg_743_1.text_.text = var_746_8
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb") ~= 0 then
					local var_746_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb") / 1000

					if var_746_12 + var_746_4 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_12 + var_746_4
					end

					if var_746_7.prefab_name ~= "" and arg_743_1.actors_[var_746_7.prefab_name] ~= nil then
						local var_746_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_743_1.actors_[var_746_7.prefab_name].transform, "story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb")

						arg_743_1:RecordAudio("924041177", var_746_13)
						arg_743_1:RecordAudio("924041177", var_746_13)
					else
						arg_743_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb")
					end

					arg_743_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb")
				end

				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_14 = math.max(var_746_5, arg_743_1.talkMaxDuration)

			if var_746_4 <= arg_743_1.time_ and arg_743_1.time_ < var_746_4 + var_746_14 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_4) / var_746_14

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_4 + var_746_14 and arg_743_1.time_ < var_746_4 + var_746_14 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	Play924041178 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 924041178
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play924041179(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			local var_750_0 = arg_747_1.actors_["102003ui_story"]
			local var_750_1 = 0

			if var_750_1 < arg_747_1.time_ and arg_747_1.time_ <= var_750_1 + arg_750_0 and not isNil(var_750_0) and arg_747_1.var_.characterEffect102003ui_story == nil then
				arg_747_1.var_.characterEffect102003ui_story = var_750_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_750_2 = 0.200000002980232

			if var_750_1 <= arg_747_1.time_ and arg_747_1.time_ < var_750_1 + var_750_2 and not isNil(var_750_0) then
				local var_750_3 = (arg_747_1.time_ - var_750_1) / var_750_2

				if arg_747_1.var_.characterEffect102003ui_story and not isNil(var_750_0) then
					local var_750_4 = Mathf.Lerp(0, 0.5, var_750_3)

					arg_747_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_747_1.var_.characterEffect102003ui_story.fillRatio = var_750_4
				end
			end

			if arg_747_1.time_ >= var_750_1 + var_750_2 and arg_747_1.time_ < var_750_1 + var_750_2 + arg_750_0 and not isNil(var_750_0) and arg_747_1.var_.characterEffect102003ui_story then
				local var_750_5 = 0.5

				arg_747_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_747_1.var_.characterEffect102003ui_story.fillRatio = var_750_5
			end

			local var_750_6 = 0
			local var_750_7 = 0.175

			if var_750_6 < arg_747_1.time_ and arg_747_1.time_ <= var_750_6 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				local var_750_8 = arg_747_1:FormatText(StoryNameCfg[7].name)

				arg_747_1.leftNameTxt_.text = var_750_8

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

				local var_750_9 = arg_747_1:GetWordFromCfg(924041178)
				local var_750_10 = arg_747_1:FormatText(var_750_9.content)

				arg_747_1.text_.text = var_750_10

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_11 = 7
				local var_750_12 = utf8.len(var_750_10)
				local var_750_13 = var_750_11 <= 0 and var_750_7 or var_750_7 * (var_750_12 / var_750_11)

				if var_750_13 > 0 and var_750_7 < var_750_13 then
					arg_747_1.talkMaxDuration = var_750_13

					if var_750_13 + var_750_6 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_13 + var_750_6
					end
				end

				arg_747_1.text_.text = var_750_10
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_14 = math.max(var_750_7, arg_747_1.talkMaxDuration)

			if var_750_6 <= arg_747_1.time_ and arg_747_1.time_ < var_750_6 + var_750_14 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_6) / var_750_14

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_6 + var_750_14 and arg_747_1.time_ < var_750_6 + var_750_14 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	Play924041179 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 924041179
		arg_751_1.duration_ = 3

		local var_751_0 = {
			zh = 2,
			ja = 3
		}
		local var_751_1 = manager.audio:GetLocalizationFlag()

		if var_751_0[var_751_1] ~= nil then
			arg_751_1.duration_ = var_751_0[var_751_1]
		end

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play924041180(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			local var_754_0 = arg_751_1.actors_["102003ui_story"]
			local var_754_1 = 0

			if var_754_1 < arg_751_1.time_ and arg_751_1.time_ <= var_754_1 + arg_754_0 and not isNil(var_754_0) and arg_751_1.var_.characterEffect102003ui_story == nil then
				arg_751_1.var_.characterEffect102003ui_story = var_754_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_754_2 = 0.200000002980232

			if var_754_1 <= arg_751_1.time_ and arg_751_1.time_ < var_754_1 + var_754_2 and not isNil(var_754_0) then
				local var_754_3 = (arg_751_1.time_ - var_754_1) / var_754_2

				if arg_751_1.var_.characterEffect102003ui_story and not isNil(var_754_0) then
					arg_751_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_751_1.time_ >= var_754_1 + var_754_2 and arg_751_1.time_ < var_754_1 + var_754_2 + arg_754_0 and not isNil(var_754_0) and arg_751_1.var_.characterEffect102003ui_story then
				arg_751_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_754_4 = 0
			local var_754_5 = 0.175

			if var_754_4 < arg_751_1.time_ and arg_751_1.time_ <= var_754_4 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				local var_754_6 = arg_751_1:FormatText(StoryNameCfg[613].name)

				arg_751_1.leftNameTxt_.text = var_754_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_7 = arg_751_1:GetWordFromCfg(924041179)
				local var_754_8 = arg_751_1:FormatText(var_754_7.content)

				arg_751_1.text_.text = var_754_8

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_9 = 7
				local var_754_10 = utf8.len(var_754_8)
				local var_754_11 = var_754_9 <= 0 and var_754_5 or var_754_5 * (var_754_10 / var_754_9)

				if var_754_11 > 0 and var_754_5 < var_754_11 then
					arg_751_1.talkMaxDuration = var_754_11

					if var_754_11 + var_754_4 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_11 + var_754_4
					end
				end

				arg_751_1.text_.text = var_754_8
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb") ~= 0 then
					local var_754_12 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb") / 1000

					if var_754_12 + var_754_4 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_12 + var_754_4
					end

					if var_754_7.prefab_name ~= "" and arg_751_1.actors_[var_754_7.prefab_name] ~= nil then
						local var_754_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_751_1.actors_[var_754_7.prefab_name].transform, "story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb")

						arg_751_1:RecordAudio("924041179", var_754_13)
						arg_751_1:RecordAudio("924041179", var_754_13)
					else
						arg_751_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb")
					end

					arg_751_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb")
				end

				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_14 = math.max(var_754_5, arg_751_1.talkMaxDuration)

			if var_754_4 <= arg_751_1.time_ and arg_751_1.time_ < var_754_4 + var_754_14 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_4) / var_754_14

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_4 + var_754_14 and arg_751_1.time_ < var_754_4 + var_754_14 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {}

		arg_751_1:InitPlayNodeList()
	end,
	Play924041180 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 924041180
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play924041181(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			local var_758_0 = arg_755_1.actors_["102003ui_story"]
			local var_758_1 = 0

			if var_758_1 < arg_755_1.time_ and arg_755_1.time_ <= var_758_1 + arg_758_0 and not isNil(var_758_0) and arg_755_1.var_.characterEffect102003ui_story == nil then
				arg_755_1.var_.characterEffect102003ui_story = var_758_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_758_2 = 0.200000002980232

			if var_758_1 <= arg_755_1.time_ and arg_755_1.time_ < var_758_1 + var_758_2 and not isNil(var_758_0) then
				local var_758_3 = (arg_755_1.time_ - var_758_1) / var_758_2

				if arg_755_1.var_.characterEffect102003ui_story and not isNil(var_758_0) then
					local var_758_4 = Mathf.Lerp(0, 0.5, var_758_3)

					arg_755_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_755_1.var_.characterEffect102003ui_story.fillRatio = var_758_4
				end
			end

			if arg_755_1.time_ >= var_758_1 + var_758_2 and arg_755_1.time_ < var_758_1 + var_758_2 + arg_758_0 and not isNil(var_758_0) and arg_755_1.var_.characterEffect102003ui_story then
				local var_758_5 = 0.5

				arg_755_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_755_1.var_.characterEffect102003ui_story.fillRatio = var_758_5
			end

			local var_758_6 = 0
			local var_758_7 = 0.875

			if var_758_6 < arg_755_1.time_ and arg_755_1.time_ <= var_758_6 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, true)

				local var_758_8 = arg_755_1:FormatText(StoryNameCfg[7].name)

				arg_755_1.leftNameTxt_.text = var_758_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_755_1.leftNameTxt_.transform)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1.leftNameTxt_.text)
				SetActive(arg_755_1.iconTrs_.gameObject, true)
				arg_755_1.iconController_:SetSelectedState("hero")

				arg_755_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_755_1.callingController_:SetSelectedState("normal")

				arg_755_1.keyicon_.color = Color.New(1, 1, 1)
				arg_755_1.icon_.color = Color.New(1, 1, 1)

				local var_758_9 = arg_755_1:GetWordFromCfg(924041180)
				local var_758_10 = arg_755_1:FormatText(var_758_9.content)

				arg_755_1.text_.text = var_758_10

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_11 = 35
				local var_758_12 = utf8.len(var_758_10)
				local var_758_13 = var_758_11 <= 0 and var_758_7 or var_758_7 * (var_758_12 / var_758_11)

				if var_758_13 > 0 and var_758_7 < var_758_13 then
					arg_755_1.talkMaxDuration = var_758_13

					if var_758_13 + var_758_6 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_13 + var_758_6
					end
				end

				arg_755_1.text_.text = var_758_10
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_14 = math.max(var_758_7, arg_755_1.talkMaxDuration)

			if var_758_6 <= arg_755_1.time_ and arg_755_1.time_ < var_758_6 + var_758_14 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_6) / var_758_14

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_6 + var_758_14 and arg_755_1.time_ < var_758_6 + var_758_14 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {}

		arg_755_1:InitPlayNodeList()
	end,
	Play924041181 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 924041181
		arg_759_1.duration_ = 5

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play924041182(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			local var_762_0 = 0
			local var_762_1 = 0.775

			if var_762_0 < arg_759_1.time_ and arg_759_1.time_ <= var_762_0 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, true)

				local var_762_2 = arg_759_1:FormatText(StoryNameCfg[7].name)

				arg_759_1.leftNameTxt_.text = var_762_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_759_1.leftNameTxt_.transform)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1.leftNameTxt_.text)
				SetActive(arg_759_1.iconTrs_.gameObject, true)
				arg_759_1.iconController_:SetSelectedState("hero")

				arg_759_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_759_1.callingController_:SetSelectedState("normal")

				arg_759_1.keyicon_.color = Color.New(1, 1, 1)
				arg_759_1.icon_.color = Color.New(1, 1, 1)

				local var_762_3 = arg_759_1:GetWordFromCfg(924041181)
				local var_762_4 = arg_759_1:FormatText(var_762_3.content)

				arg_759_1.text_.text = var_762_4

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_5 = 31
				local var_762_6 = utf8.len(var_762_4)
				local var_762_7 = var_762_5 <= 0 and var_762_1 or var_762_1 * (var_762_6 / var_762_5)

				if var_762_7 > 0 and var_762_1 < var_762_7 then
					arg_759_1.talkMaxDuration = var_762_7

					if var_762_7 + var_762_0 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_7 + var_762_0
					end
				end

				arg_759_1.text_.text = var_762_4
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)
				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_8 = math.max(var_762_1, arg_759_1.talkMaxDuration)

			if var_762_0 <= arg_759_1.time_ and arg_759_1.time_ < var_762_0 + var_762_8 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - var_762_0) / var_762_8

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= var_762_0 + var_762_8 and arg_759_1.time_ < var_762_0 + var_762_8 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {}

		arg_759_1:InitPlayNodeList()
	end,
	Play924041182 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 924041182
		arg_763_1.duration_ = 6.73

		local var_763_0 = {
			zh = 6.733,
			ja = 4.566
		}
		local var_763_1 = manager.audio:GetLocalizationFlag()

		if var_763_0[var_763_1] ~= nil then
			arg_763_1.duration_ = var_763_0[var_763_1]
		end

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play924041183(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = 0
			local var_766_1 = 0.5

			if var_766_0 < arg_763_1.time_ and arg_763_1.time_ <= var_766_0 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				local var_766_2 = arg_763_1:FormatText(StoryNameCfg[613].name)

				arg_763_1.leftNameTxt_.text = var_766_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, false)
				arg_763_1.callingController_:SetSelectedState("normal")

				local var_766_3 = arg_763_1:GetWordFromCfg(924041182)
				local var_766_4 = arg_763_1:FormatText(var_766_3.content)

				arg_763_1.text_.text = var_766_4

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_5 = 20
				local var_766_6 = utf8.len(var_766_4)
				local var_766_7 = var_766_5 <= 0 and var_766_1 or var_766_1 * (var_766_6 / var_766_5)

				if var_766_7 > 0 and var_766_1 < var_766_7 then
					arg_763_1.talkMaxDuration = var_766_7

					if var_766_7 + var_766_0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_7 + var_766_0
					end
				end

				arg_763_1.text_.text = var_766_4
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb") ~= 0 then
					local var_766_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb") / 1000

					if var_766_8 + var_766_0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_8 + var_766_0
					end

					if var_766_3.prefab_name ~= "" and arg_763_1.actors_[var_766_3.prefab_name] ~= nil then
						local var_766_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_763_1.actors_[var_766_3.prefab_name].transform, "story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb")

						arg_763_1:RecordAudio("924041182", var_766_9)
						arg_763_1:RecordAudio("924041182", var_766_9)
					else
						arg_763_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb")
					end

					arg_763_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb")
				end

				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_10 = math.max(var_766_1, arg_763_1.talkMaxDuration)

			if var_766_0 <= arg_763_1.time_ and arg_763_1.time_ < var_766_0 + var_766_10 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - var_766_0) / var_766_10

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= var_766_0 + var_766_10 and arg_763_1.time_ < var_766_0 + var_766_10 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play924041183 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 924041183
		arg_767_1.duration_ = 5

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play924041184(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			local var_770_0 = arg_767_1.actors_["102003ui_story"]
			local var_770_1 = 0

			if var_770_1 < arg_767_1.time_ and arg_767_1.time_ <= var_770_1 + arg_770_0 and not isNil(var_770_0) and arg_767_1.var_.characterEffect102003ui_story == nil then
				arg_767_1.var_.characterEffect102003ui_story = var_770_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_770_2 = 0.200000002980232

			if var_770_1 <= arg_767_1.time_ and arg_767_1.time_ < var_770_1 + var_770_2 and not isNil(var_770_0) then
				local var_770_3 = (arg_767_1.time_ - var_770_1) / var_770_2

				if arg_767_1.var_.characterEffect102003ui_story and not isNil(var_770_0) then
					local var_770_4 = Mathf.Lerp(0, 0.5, var_770_3)

					arg_767_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_767_1.var_.characterEffect102003ui_story.fillRatio = var_770_4
				end
			end

			if arg_767_1.time_ >= var_770_1 + var_770_2 and arg_767_1.time_ < var_770_1 + var_770_2 + arg_770_0 and not isNil(var_770_0) and arg_767_1.var_.characterEffect102003ui_story then
				local var_770_5 = 0.5

				arg_767_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_767_1.var_.characterEffect102003ui_story.fillRatio = var_770_5
			end

			local var_770_6 = 0
			local var_770_7 = 0.1

			if var_770_6 < arg_767_1.time_ and arg_767_1.time_ <= var_770_6 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				local var_770_8 = arg_767_1:FormatText(StoryNameCfg[7].name)

				arg_767_1.leftNameTxt_.text = var_770_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, true)
				arg_767_1.iconController_:SetSelectedState("hero")

				arg_767_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_767_1.callingController_:SetSelectedState("normal")

				arg_767_1.keyicon_.color = Color.New(1, 1, 1)
				arg_767_1.icon_.color = Color.New(1, 1, 1)

				local var_770_9 = arg_767_1:GetWordFromCfg(924041183)
				local var_770_10 = arg_767_1:FormatText(var_770_9.content)

				arg_767_1.text_.text = var_770_10

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_11 = 4
				local var_770_12 = utf8.len(var_770_10)
				local var_770_13 = var_770_11 <= 0 and var_770_7 or var_770_7 * (var_770_12 / var_770_11)

				if var_770_13 > 0 and var_770_7 < var_770_13 then
					arg_767_1.talkMaxDuration = var_770_13

					if var_770_13 + var_770_6 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_13 + var_770_6
					end
				end

				arg_767_1.text_.text = var_770_10
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)
				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_14 = math.max(var_770_7, arg_767_1.talkMaxDuration)

			if var_770_6 <= arg_767_1.time_ and arg_767_1.time_ < var_770_6 + var_770_14 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_6) / var_770_14

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_6 + var_770_14 and arg_767_1.time_ < var_770_6 + var_770_14 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {}

		arg_767_1:InitPlayNodeList()
	end,
	Play924041184 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 924041184
		arg_771_1.duration_ = 7.53

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play924041185(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			local var_774_0 = 0.533333333333333

			if var_774_0 < arg_771_1.time_ and arg_771_1.time_ <= var_774_0 + arg_774_0 then
				local var_774_1 = manager.ui.mainCamera.transform.localPosition
				local var_774_2 = Vector3.New(0, 0, 10) + Vector3.New(var_774_1.x, var_774_1.y, 0)
				local var_774_3 = arg_771_1.bgs_.STblack

				var_774_3.transform.localPosition = var_774_2
				var_774_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_774_4 = var_774_3:GetComponent("SpriteRenderer")

				if var_774_4 and var_774_4.sprite then
					local var_774_5 = (var_774_3.transform.localPosition - var_774_1).z
					local var_774_6 = manager.ui.mainCameraCom_
					local var_774_7 = 2 * var_774_5 * Mathf.Tan(var_774_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_774_8 = var_774_7 * var_774_6.aspect
					local var_774_9 = var_774_4.sprite.bounds.size.x
					local var_774_10 = var_774_4.sprite.bounds.size.y
					local var_774_11 = var_774_8 / var_774_9
					local var_774_12 = var_774_7 / var_774_10
					local var_774_13 = var_774_12 < var_774_11 and var_774_11 or var_774_12

					var_774_3.transform.localScale = Vector3.New(var_774_13, var_774_13, 0)
				end

				for iter_774_0, iter_774_1 in pairs(arg_771_1.bgs_) do
					if iter_774_0 ~= "STblack" then
						iter_774_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_774_14 = 2.53333333333333

			if var_774_14 < arg_771_1.time_ and arg_771_1.time_ <= var_774_14 + arg_774_0 then
				arg_771_1.allBtn_.enabled = false
			end

			local var_774_15 = 0.3

			if arg_771_1.time_ >= var_774_14 + var_774_15 and arg_771_1.time_ < var_774_14 + var_774_15 + arg_774_0 then
				arg_771_1.allBtn_.enabled = true
			end

			local var_774_16 = 0.533333333333333

			if var_774_16 < arg_771_1.time_ and arg_771_1.time_ <= var_774_16 + arg_774_0 then
				arg_771_1.mask_.enabled = true
				arg_771_1.mask_.raycastTarget = true

				arg_771_1:SetGaussion(false)
			end

			local var_774_17 = 2

			if var_774_16 <= arg_771_1.time_ and arg_771_1.time_ < var_774_16 + var_774_17 then
				local var_774_18 = (arg_771_1.time_ - var_774_16) / var_774_17
				local var_774_19 = Color.New(1, 1, 1)

				var_774_19.a = Mathf.Lerp(1, 0, var_774_18)
				arg_771_1.mask_.color = var_774_19
			end

			if arg_771_1.time_ >= var_774_16 + var_774_17 and arg_771_1.time_ < var_774_16 + var_774_17 + arg_774_0 then
				local var_774_20 = Color.New(1, 1, 1)
				local var_774_21 = 0

				arg_771_1.mask_.enabled = false
				var_774_20.a = var_774_21
				arg_771_1.mask_.color = var_774_20
			end

			local var_774_22 = 2.7
			local var_774_23 = 1

			if var_774_22 < arg_771_1.time_ and arg_771_1.time_ <= var_774_22 + arg_774_0 then
				local var_774_24 = "play"
				local var_774_25 = "effect"

				arg_771_1:AudioAction(var_774_24, var_774_25, "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			local var_774_26 = 0.533333333333333
			local var_774_27 = 1

			if var_774_26 < arg_771_1.time_ and arg_771_1.time_ <= var_774_26 + arg_774_0 then
				local var_774_28 = "play"
				local var_774_29 = "effect"

				arg_771_1:AudioAction(var_774_28, var_774_29, "se_story_141", "se_story_141_boxing_drum02", "")
			end

			if arg_771_1.frameCnt_ <= 1 then
				arg_771_1.dialog_:SetActive(false)
			end

			local var_774_30 = 2.53333333333333
			local var_774_31 = 0.925

			if var_774_30 < arg_771_1.time_ and arg_771_1.time_ <= var_774_30 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0

				arg_771_1.dialog_:SetActive(true)

				arg_771_1.dialogCg_.alpha = 0

				local var_774_32 = LeanTween.value(arg_771_1.dialog_, 0, 1, 0.3)

				var_774_32:setOnUpdate(LuaHelper.FloatAction(function(arg_775_0)
					arg_771_1.dialogCg_.alpha = arg_775_0
				end))
				var_774_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_771_1.dialog_)
					var_774_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_771_1.duration_ = arg_771_1.duration_ + 0.3

				SetActive(arg_771_1.leftNameGo_, false)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_771_1.iconTrs_.gameObject, false)
				arg_771_1.callingController_:SetSelectedState("normal")

				local var_774_33 = arg_771_1:GetWordFromCfg(924041184)
				local var_774_34 = arg_771_1:FormatText(var_774_33.content)

				arg_771_1.text_.text = var_774_34

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_35 = 37
				local var_774_36 = utf8.len(var_774_34)
				local var_774_37 = var_774_35 <= 0 and var_774_31 or var_774_31 * (var_774_36 / var_774_35)

				if var_774_37 > 0 and var_774_31 < var_774_37 then
					arg_771_1.talkMaxDuration = var_774_37
					var_774_30 = var_774_30 + 0.3

					if var_774_37 + var_774_30 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_37 + var_774_30
					end
				end

				arg_771_1.text_.text = var_774_34
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)
				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_38 = var_774_30 + 0.3
			local var_774_39 = math.max(var_774_31, arg_771_1.talkMaxDuration)

			if var_774_38 <= arg_771_1.time_ and arg_771_1.time_ < var_774_38 + var_774_39 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - var_774_38) / var_774_39

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= var_774_38 + var_774_39 and arg_771_1.time_ < var_774_38 + var_774_39 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	Play924041185 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 924041185
		arg_777_1.duration_ = 5.67

		local var_777_0 = {
			zh = 4.966,
			ja = 5.666
		}
		local var_777_1 = manager.audio:GetLocalizationFlag()

		if var_777_0[var_777_1] ~= nil then
			arg_777_1.duration_ = var_777_0[var_777_1]
		end

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play924041186(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = 0
			local var_780_1 = 0.25

			if var_780_0 < arg_777_1.time_ and arg_777_1.time_ <= var_780_0 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				local var_780_2 = arg_777_1:FormatText(StoryNameCfg[613].name)

				arg_777_1.leftNameTxt_.text = var_780_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_3 = arg_777_1:GetWordFromCfg(924041185)
				local var_780_4 = arg_777_1:FormatText(var_780_3.content)

				arg_777_1.text_.text = var_780_4

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_5 = 10
				local var_780_6 = utf8.len(var_780_4)
				local var_780_7 = var_780_5 <= 0 and var_780_1 or var_780_1 * (var_780_6 / var_780_5)

				if var_780_7 > 0 and var_780_1 < var_780_7 then
					arg_777_1.talkMaxDuration = var_780_7

					if var_780_7 + var_780_0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_7 + var_780_0
					end
				end

				arg_777_1.text_.text = var_780_4
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb") ~= 0 then
					local var_780_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb") / 1000

					if var_780_8 + var_780_0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_8 + var_780_0
					end

					if var_780_3.prefab_name ~= "" and arg_777_1.actors_[var_780_3.prefab_name] ~= nil then
						local var_780_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_777_1.actors_[var_780_3.prefab_name].transform, "story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb")

						arg_777_1:RecordAudio("924041185", var_780_9)
						arg_777_1:RecordAudio("924041185", var_780_9)
					else
						arg_777_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb")
					end

					arg_777_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb")
				end

				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_10 = math.max(var_780_1, arg_777_1.talkMaxDuration)

			if var_780_0 <= arg_777_1.time_ and arg_777_1.time_ < var_780_0 + var_780_10 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_0) / var_780_10

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_0 + var_780_10 and arg_777_1.time_ < var_780_0 + var_780_10 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play924041186 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 924041186
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play924041187(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = 0
			local var_784_1 = 0.825

			if var_784_0 < arg_781_1.time_ and arg_781_1.time_ <= var_784_0 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, false)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_781_1.iconTrs_.gameObject, false)
				arg_781_1.callingController_:SetSelectedState("normal")

				local var_784_2 = arg_781_1:GetWordFromCfg(924041186)
				local var_784_3 = arg_781_1:FormatText(var_784_2.content)

				arg_781_1.text_.text = var_784_3

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_4 = 33
				local var_784_5 = utf8.len(var_784_3)
				local var_784_6 = var_784_4 <= 0 and var_784_1 or var_784_1 * (var_784_5 / var_784_4)

				if var_784_6 > 0 and var_784_1 < var_784_6 then
					arg_781_1.talkMaxDuration = var_784_6

					if var_784_6 + var_784_0 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_6 + var_784_0
					end
				end

				arg_781_1.text_.text = var_784_3
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)
				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_7 = math.max(var_784_1, arg_781_1.talkMaxDuration)

			if var_784_0 <= arg_781_1.time_ and arg_781_1.time_ < var_784_0 + var_784_7 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - var_784_0) / var_784_7

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= var_784_0 + var_784_7 and arg_781_1.time_ < var_784_0 + var_784_7 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play924041187 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 924041187
		arg_785_1.duration_ = 7

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play924041188(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			local var_788_0 = "X204_h"

			if arg_785_1.bgs_[var_788_0] == nil then
				local var_788_1 = Object.Instantiate(arg_785_1.paintGo_)

				var_788_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_788_0)
				var_788_1.name = var_788_0
				var_788_1.transform.parent = arg_785_1.stage_.transform
				var_788_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_785_1.bgs_[var_788_0] = var_788_1
			end

			local var_788_2 = 0

			if var_788_2 < arg_785_1.time_ and arg_785_1.time_ <= var_788_2 + arg_788_0 then
				local var_788_3 = manager.ui.mainCamera.transform.localPosition
				local var_788_4 = Vector3.New(0, 0, 10) + Vector3.New(var_788_3.x, var_788_3.y, 0)
				local var_788_5 = arg_785_1.bgs_.X204_h

				var_788_5.transform.localPosition = var_788_4
				var_788_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_788_6 = var_788_5:GetComponent("SpriteRenderer")

				if var_788_6 and var_788_6.sprite then
					local var_788_7 = (var_788_5.transform.localPosition - var_788_3).z
					local var_788_8 = manager.ui.mainCameraCom_
					local var_788_9 = 2 * var_788_7 * Mathf.Tan(var_788_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_788_10 = var_788_9 * var_788_8.aspect
					local var_788_11 = var_788_6.sprite.bounds.size.x
					local var_788_12 = var_788_6.sprite.bounds.size.y
					local var_788_13 = var_788_10 / var_788_11
					local var_788_14 = var_788_9 / var_788_12
					local var_788_15 = var_788_14 < var_788_13 and var_788_13 or var_788_14

					var_788_5.transform.localScale = Vector3.New(var_788_15, var_788_15, 0)
				end

				for iter_788_0, iter_788_1 in pairs(arg_785_1.bgs_) do
					if iter_788_0 ~= "X204_h" then
						iter_788_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_788_16 = 2

			if var_788_16 < arg_785_1.time_ and arg_785_1.time_ <= var_788_16 + arg_788_0 then
				arg_785_1.allBtn_.enabled = false
			end

			local var_788_17 = 0.3

			if arg_785_1.time_ >= var_788_16 + var_788_17 and arg_785_1.time_ < var_788_16 + var_788_17 + arg_788_0 then
				arg_785_1.allBtn_.enabled = true
			end

			local var_788_18 = 0

			if var_788_18 < arg_785_1.time_ and arg_785_1.time_ <= var_788_18 + arg_788_0 then
				arg_785_1.mask_.enabled = true
				arg_785_1.mask_.raycastTarget = true

				arg_785_1:SetGaussion(false)
			end

			local var_788_19 = 2

			if var_788_18 <= arg_785_1.time_ and arg_785_1.time_ < var_788_18 + var_788_19 then
				local var_788_20 = (arg_785_1.time_ - var_788_18) / var_788_19
				local var_788_21 = Color.New(0, 0, 0)

				var_788_21.a = Mathf.Lerp(1, 0, var_788_20)
				arg_785_1.mask_.color = var_788_21
			end

			if arg_785_1.time_ >= var_788_18 + var_788_19 and arg_785_1.time_ < var_788_18 + var_788_19 + arg_788_0 then
				local var_788_22 = Color.New(0, 0, 0)
				local var_788_23 = 0

				arg_785_1.mask_.enabled = false
				var_788_22.a = var_788_23
				arg_785_1.mask_.color = var_788_22
			end

			local var_788_24 = 5.55111512312578e-17
			local var_788_25 = 1

			if var_788_24 < arg_785_1.time_ and arg_785_1.time_ <= var_788_24 + arg_788_0 then
				local var_788_26 = "play"
				local var_788_27 = "effect"

				arg_785_1:AudioAction(var_788_26, var_788_27, "se_story_141", "se_story_141_amb_room", "")
			end

			local var_788_28 = 0
			local var_788_29 = 1

			if var_788_28 < arg_785_1.time_ and arg_785_1.time_ <= var_788_28 + arg_788_0 then
				local var_788_30 = "stop"
				local var_788_31 = "effect"

				arg_785_1:AudioAction(var_788_30, var_788_31, "se_story_141", "se_story_141_amb_street_night", "")
			end

			if arg_785_1.frameCnt_ <= 1 then
				arg_785_1.dialog_:SetActive(false)
			end

			local var_788_32 = 2
			local var_788_33 = 0.475

			if var_788_32 < arg_785_1.time_ and arg_785_1.time_ <= var_788_32 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0

				arg_785_1.dialog_:SetActive(true)

				arg_785_1.dialogCg_.alpha = 0

				local var_788_34 = LeanTween.value(arg_785_1.dialog_, 0, 1, 0.3)

				var_788_34:setOnUpdate(LuaHelper.FloatAction(function(arg_789_0)
					arg_785_1.dialogCg_.alpha = arg_789_0
				end))
				var_788_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_785_1.dialog_)
					var_788_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_785_1.duration_ = arg_785_1.duration_ + 0.3

				SetActive(arg_785_1.leftNameGo_, false)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_35 = arg_785_1:GetWordFromCfg(924041187)
				local var_788_36 = arg_785_1:FormatText(var_788_35.content)

				arg_785_1.text_.text = var_788_36

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_37 = 19
				local var_788_38 = utf8.len(var_788_36)
				local var_788_39 = var_788_37 <= 0 and var_788_33 or var_788_33 * (var_788_38 / var_788_37)

				if var_788_39 > 0 and var_788_33 < var_788_39 then
					arg_785_1.talkMaxDuration = var_788_39
					var_788_32 = var_788_32 + 0.3

					if var_788_39 + var_788_32 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_39 + var_788_32
					end
				end

				arg_785_1.text_.text = var_788_36
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)
				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_40 = var_788_32 + 0.3
			local var_788_41 = math.max(var_788_33, arg_785_1.talkMaxDuration)

			if var_788_40 <= arg_785_1.time_ and arg_785_1.time_ < var_788_40 + var_788_41 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_40) / var_788_41

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_40 + var_788_41 and arg_785_1.time_ < var_788_40 + var_788_41 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play924041188 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 924041188
		arg_791_1.duration_ = 5

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play924041189(arg_791_1)
			end
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			local var_794_0 = 0
			local var_794_1 = 0.275

			if var_794_0 < arg_791_1.time_ and arg_791_1.time_ <= var_794_0 + arg_794_0 then
				arg_791_1.talkMaxDuration = 0
				arg_791_1.dialogCg_.alpha = 1

				arg_791_1.dialog_:SetActive(true)
				SetActive(arg_791_1.leftNameGo_, true)

				local var_794_2 = arg_791_1:FormatText(StoryNameCfg[7].name)

				arg_791_1.leftNameTxt_.text = var_794_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_791_1.leftNameTxt_.transform)

				arg_791_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_791_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_791_1:RecordName(arg_791_1.leftNameTxt_.text)
				SetActive(arg_791_1.iconTrs_.gameObject, true)
				arg_791_1.iconController_:SetSelectedState("hero")

				arg_791_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_791_1.callingController_:SetSelectedState("normal")

				arg_791_1.keyicon_.color = Color.New(1, 1, 1)
				arg_791_1.icon_.color = Color.New(1, 1, 1)

				local var_794_3 = arg_791_1:GetWordFromCfg(924041188)
				local var_794_4 = arg_791_1:FormatText(var_794_3.content)

				arg_791_1.text_.text = var_794_4

				LuaForUtil.ClearLinePrefixSymbol(arg_791_1.text_)

				local var_794_5 = 11
				local var_794_6 = utf8.len(var_794_4)
				local var_794_7 = var_794_5 <= 0 and var_794_1 or var_794_1 * (var_794_6 / var_794_5)

				if var_794_7 > 0 and var_794_1 < var_794_7 then
					arg_791_1.talkMaxDuration = var_794_7

					if var_794_7 + var_794_0 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_7 + var_794_0
					end
				end

				arg_791_1.text_.text = var_794_4
				arg_791_1.typewritter.percent = 0

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(false)
				arg_791_1:RecordContent(arg_791_1.text_.text)
			end

			local var_794_8 = math.max(var_794_1, arg_791_1.talkMaxDuration)

			if var_794_0 <= arg_791_1.time_ and arg_791_1.time_ < var_794_0 + var_794_8 then
				arg_791_1.typewritter.percent = (arg_791_1.time_ - var_794_0) / var_794_8

				arg_791_1.typewritter:SetDirty()
			end

			if arg_791_1.time_ >= var_794_0 + var_794_8 and arg_791_1.time_ < var_794_0 + var_794_8 + arg_794_0 then
				arg_791_1.typewritter.percent = 1

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(true)
			end
		end

		arg_791_1.nodeConfigList_ = {}

		arg_791_1:InitPlayNodeList()
	end,
	Play924041189 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 924041189
		arg_795_1.duration_ = 5

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play924041190(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			local var_798_0 = 0
			local var_798_1 = 0.925

			if var_798_0 < arg_795_1.time_ and arg_795_1.time_ <= var_798_0 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, false)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_795_1.iconTrs_.gameObject, false)
				arg_795_1.callingController_:SetSelectedState("normal")

				local var_798_2 = arg_795_1:GetWordFromCfg(924041189)
				local var_798_3 = arg_795_1:FormatText(var_798_2.content)

				arg_795_1.text_.text = var_798_3

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_4 = 37
				local var_798_5 = utf8.len(var_798_3)
				local var_798_6 = var_798_4 <= 0 and var_798_1 or var_798_1 * (var_798_5 / var_798_4)

				if var_798_6 > 0 and var_798_1 < var_798_6 then
					arg_795_1.talkMaxDuration = var_798_6

					if var_798_6 + var_798_0 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_6 + var_798_0
					end
				end

				arg_795_1.text_.text = var_798_3
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)
				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_7 = math.max(var_798_1, arg_795_1.talkMaxDuration)

			if var_798_0 <= arg_795_1.time_ and arg_795_1.time_ < var_798_0 + var_798_7 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - var_798_0) / var_798_7

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= var_798_0 + var_798_7 and arg_795_1.time_ < var_798_0 + var_798_7 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end

		arg_795_1.nodeConfigList_ = {}

		arg_795_1:InitPlayNodeList()
	end,
	Play924041190 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 924041190
		arg_799_1.duration_ = 3.4

		local var_799_0 = {
			zh = 3.3,
			ja = 3.4
		}
		local var_799_1 = manager.audio:GetLocalizationFlag()

		if var_799_0[var_799_1] ~= nil then
			arg_799_1.duration_ = var_799_0[var_799_1]
		end

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play924041191(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			local var_802_0 = arg_799_1.actors_["102003ui_story"].transform
			local var_802_1 = 0

			if var_802_1 < arg_799_1.time_ and arg_799_1.time_ <= var_802_1 + arg_802_0 then
				arg_799_1.var_.moveOldPos102003ui_story = var_802_0.localPosition
			end

			local var_802_2 = 0.001

			if var_802_1 <= arg_799_1.time_ and arg_799_1.time_ < var_802_1 + var_802_2 then
				local var_802_3 = (arg_799_1.time_ - var_802_1) / var_802_2
				local var_802_4 = Vector3.New(0, -0.85, -6.21)

				var_802_0.localPosition = Vector3.Lerp(arg_799_1.var_.moveOldPos102003ui_story, var_802_4, var_802_3)

				local var_802_5 = manager.ui.mainCamera.transform.position - var_802_0.position

				var_802_0.forward = Vector3.New(var_802_5.x, var_802_5.y, var_802_5.z)

				local var_802_6 = var_802_0.localEulerAngles

				var_802_6.z = 0
				var_802_6.x = 0
				var_802_0.localEulerAngles = var_802_6
			end

			if arg_799_1.time_ >= var_802_1 + var_802_2 and arg_799_1.time_ < var_802_1 + var_802_2 + arg_802_0 then
				var_802_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_802_7 = manager.ui.mainCamera.transform.position - var_802_0.position

				var_802_0.forward = Vector3.New(var_802_7.x, var_802_7.y, var_802_7.z)

				local var_802_8 = var_802_0.localEulerAngles

				var_802_8.z = 0
				var_802_8.x = 0
				var_802_0.localEulerAngles = var_802_8
			end

			local var_802_9 = arg_799_1.actors_["102003ui_story"]
			local var_802_10 = 0

			if var_802_10 < arg_799_1.time_ and arg_799_1.time_ <= var_802_10 + arg_802_0 and not isNil(var_802_9) and arg_799_1.var_.characterEffect102003ui_story == nil then
				arg_799_1.var_.characterEffect102003ui_story = var_802_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_802_11 = 0.200000002980232

			if var_802_10 <= arg_799_1.time_ and arg_799_1.time_ < var_802_10 + var_802_11 and not isNil(var_802_9) then
				local var_802_12 = (arg_799_1.time_ - var_802_10) / var_802_11

				if arg_799_1.var_.characterEffect102003ui_story and not isNil(var_802_9) then
					arg_799_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_799_1.time_ >= var_802_10 + var_802_11 and arg_799_1.time_ < var_802_10 + var_802_11 + arg_802_0 and not isNil(var_802_9) and arg_799_1.var_.characterEffect102003ui_story then
				arg_799_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_802_13 = 0

			if var_802_13 < arg_799_1.time_ and arg_799_1.time_ <= var_802_13 + arg_802_0 then
				arg_799_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			local var_802_14 = 0

			if var_802_14 < arg_799_1.time_ and arg_799_1.time_ <= var_802_14 + arg_802_0 then
				arg_799_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_802_15 = 0
			local var_802_16 = 0.275

			if var_802_15 < arg_799_1.time_ and arg_799_1.time_ <= var_802_15 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, true)

				local var_802_17 = arg_799_1:FormatText(StoryNameCfg[613].name)

				arg_799_1.leftNameTxt_.text = var_802_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_799_1.leftNameTxt_.transform)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1.leftNameTxt_.text)
				SetActive(arg_799_1.iconTrs_.gameObject, false)
				arg_799_1.callingController_:SetSelectedState("normal")

				local var_802_18 = arg_799_1:GetWordFromCfg(924041190)
				local var_802_19 = arg_799_1:FormatText(var_802_18.content)

				arg_799_1.text_.text = var_802_19

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_20 = 11
				local var_802_21 = utf8.len(var_802_19)
				local var_802_22 = var_802_20 <= 0 and var_802_16 or var_802_16 * (var_802_21 / var_802_20)

				if var_802_22 > 0 and var_802_16 < var_802_22 then
					arg_799_1.talkMaxDuration = var_802_22

					if var_802_22 + var_802_15 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_22 + var_802_15
					end
				end

				arg_799_1.text_.text = var_802_19
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb") ~= 0 then
					local var_802_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb") / 1000

					if var_802_23 + var_802_15 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_23 + var_802_15
					end

					if var_802_18.prefab_name ~= "" and arg_799_1.actors_[var_802_18.prefab_name] ~= nil then
						local var_802_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_799_1.actors_[var_802_18.prefab_name].transform, "story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb")

						arg_799_1:RecordAudio("924041190", var_802_24)
						arg_799_1:RecordAudio("924041190", var_802_24)
					else
						arg_799_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb")
					end

					arg_799_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb")
				end

				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_25 = math.max(var_802_16, arg_799_1.talkMaxDuration)

			if var_802_15 <= arg_799_1.time_ and arg_799_1.time_ < var_802_15 + var_802_25 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - var_802_15) / var_802_25

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= var_802_15 + var_802_25 and arg_799_1.time_ < var_802_15 + var_802_25 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end

		arg_799_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_799_1:InitPlayNodeList()
	end,
	Play924041191 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 924041191
		arg_803_1.duration_ = 5

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play924041192(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			local var_806_0 = arg_803_1.actors_["102003ui_story"].transform
			local var_806_1 = 0

			if var_806_1 < arg_803_1.time_ and arg_803_1.time_ <= var_806_1 + arg_806_0 then
				arg_803_1.var_.moveOldPos102003ui_story = var_806_0.localPosition
			end

			local var_806_2 = 0.001

			if var_806_1 <= arg_803_1.time_ and arg_803_1.time_ < var_806_1 + var_806_2 then
				local var_806_3 = (arg_803_1.time_ - var_806_1) / var_806_2
				local var_806_4 = Vector3.New(0, 100, 0)

				var_806_0.localPosition = Vector3.Lerp(arg_803_1.var_.moveOldPos102003ui_story, var_806_4, var_806_3)

				local var_806_5 = manager.ui.mainCamera.transform.position - var_806_0.position

				var_806_0.forward = Vector3.New(var_806_5.x, var_806_5.y, var_806_5.z)

				local var_806_6 = var_806_0.localEulerAngles

				var_806_6.z = 0
				var_806_6.x = 0
				var_806_0.localEulerAngles = var_806_6
			end

			if arg_803_1.time_ >= var_806_1 + var_806_2 and arg_803_1.time_ < var_806_1 + var_806_2 + arg_806_0 then
				var_806_0.localPosition = Vector3.New(0, 100, 0)

				local var_806_7 = manager.ui.mainCamera.transform.position - var_806_0.position

				var_806_0.forward = Vector3.New(var_806_7.x, var_806_7.y, var_806_7.z)

				local var_806_8 = var_806_0.localEulerAngles

				var_806_8.z = 0
				var_806_8.x = 0
				var_806_0.localEulerAngles = var_806_8
			end

			local var_806_9 = arg_803_1.actors_["102003ui_story"]
			local var_806_10 = 0

			if var_806_10 < arg_803_1.time_ and arg_803_1.time_ <= var_806_10 + arg_806_0 and not isNil(var_806_9) and arg_803_1.var_.characterEffect102003ui_story == nil then
				arg_803_1.var_.characterEffect102003ui_story = var_806_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_806_11 = 0.200000002980232

			if var_806_10 <= arg_803_1.time_ and arg_803_1.time_ < var_806_10 + var_806_11 and not isNil(var_806_9) then
				local var_806_12 = (arg_803_1.time_ - var_806_10) / var_806_11

				if arg_803_1.var_.characterEffect102003ui_story and not isNil(var_806_9) then
					local var_806_13 = Mathf.Lerp(0, 0.5, var_806_12)

					arg_803_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_803_1.var_.characterEffect102003ui_story.fillRatio = var_806_13
				end
			end

			if arg_803_1.time_ >= var_806_10 + var_806_11 and arg_803_1.time_ < var_806_10 + var_806_11 + arg_806_0 and not isNil(var_806_9) and arg_803_1.var_.characterEffect102003ui_story then
				local var_806_14 = 0.5

				arg_803_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_803_1.var_.characterEffect102003ui_story.fillRatio = var_806_14
			end

			local var_806_15 = 0
			local var_806_16 = 0.85

			if var_806_15 < arg_803_1.time_ and arg_803_1.time_ <= var_806_15 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0
				arg_803_1.dialogCg_.alpha = 1

				arg_803_1.dialog_:SetActive(true)
				SetActive(arg_803_1.leftNameGo_, false)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_803_1.iconTrs_.gameObject, false)
				arg_803_1.callingController_:SetSelectedState("normal")

				local var_806_17 = arg_803_1:GetWordFromCfg(924041191)
				local var_806_18 = arg_803_1:FormatText(var_806_17.content)

				arg_803_1.text_.text = var_806_18

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_19 = 34
				local var_806_20 = utf8.len(var_806_18)
				local var_806_21 = var_806_19 <= 0 and var_806_16 or var_806_16 * (var_806_20 / var_806_19)

				if var_806_21 > 0 and var_806_16 < var_806_21 then
					arg_803_1.talkMaxDuration = var_806_21

					if var_806_21 + var_806_15 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_21 + var_806_15
					end
				end

				arg_803_1.text_.text = var_806_18
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)
				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_22 = math.max(var_806_16, arg_803_1.talkMaxDuration)

			if var_806_15 <= arg_803_1.time_ and arg_803_1.time_ < var_806_15 + var_806_22 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - var_806_15) / var_806_22

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= var_806_15 + var_806_22 and arg_803_1.time_ < var_806_15 + var_806_22 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end

		arg_803_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_803_1:InitPlayNodeList()
	end,
	Play924041192 = function(arg_807_0, arg_807_1)
		arg_807_1.time_ = 0
		arg_807_1.frameCnt_ = 0
		arg_807_1.state_ = "playing"
		arg_807_1.curTalkId_ = 924041192
		arg_807_1.duration_ = 5

		SetActive(arg_807_1.tipsGo_, false)

		function arg_807_1.onSingleLineFinish_()
			arg_807_1.onSingleLineUpdate_ = nil
			arg_807_1.onSingleLineFinish_ = nil
			arg_807_1.state_ = "waiting"
		end

		function arg_807_1.playNext_(arg_809_0)
			if arg_809_0 == 1 then
				arg_807_0:Play924041193(arg_807_1)
			end
		end

		function arg_807_1.onSingleLineUpdate_(arg_810_0)
			local var_810_0 = 0
			local var_810_1 = 0.25

			if var_810_0 < arg_807_1.time_ and arg_807_1.time_ <= var_810_0 + arg_810_0 then
				arg_807_1.talkMaxDuration = 0
				arg_807_1.dialogCg_.alpha = 1

				arg_807_1.dialog_:SetActive(true)
				SetActive(arg_807_1.leftNameGo_, true)

				local var_810_2 = arg_807_1:FormatText(StoryNameCfg[7].name)

				arg_807_1.leftNameTxt_.text = var_810_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_807_1.leftNameTxt_.transform)

				arg_807_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_807_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_807_1:RecordName(arg_807_1.leftNameTxt_.text)
				SetActive(arg_807_1.iconTrs_.gameObject, true)
				arg_807_1.iconController_:SetSelectedState("hero")

				arg_807_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_807_1.callingController_:SetSelectedState("normal")

				arg_807_1.keyicon_.color = Color.New(1, 1, 1)
				arg_807_1.icon_.color = Color.New(1, 1, 1)

				local var_810_3 = arg_807_1:GetWordFromCfg(924041192)
				local var_810_4 = arg_807_1:FormatText(var_810_3.content)

				arg_807_1.text_.text = var_810_4

				LuaForUtil.ClearLinePrefixSymbol(arg_807_1.text_)

				local var_810_5 = 10
				local var_810_6 = utf8.len(var_810_4)
				local var_810_7 = var_810_5 <= 0 and var_810_1 or var_810_1 * (var_810_6 / var_810_5)

				if var_810_7 > 0 and var_810_1 < var_810_7 then
					arg_807_1.talkMaxDuration = var_810_7

					if var_810_7 + var_810_0 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_7 + var_810_0
					end
				end

				arg_807_1.text_.text = var_810_4
				arg_807_1.typewritter.percent = 0

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(false)
				arg_807_1:RecordContent(arg_807_1.text_.text)
			end

			local var_810_8 = math.max(var_810_1, arg_807_1.talkMaxDuration)

			if var_810_0 <= arg_807_1.time_ and arg_807_1.time_ < var_810_0 + var_810_8 then
				arg_807_1.typewritter.percent = (arg_807_1.time_ - var_810_0) / var_810_8

				arg_807_1.typewritter:SetDirty()
			end

			if arg_807_1.time_ >= var_810_0 + var_810_8 and arg_807_1.time_ < var_810_0 + var_810_8 + arg_810_0 then
				arg_807_1.typewritter.percent = 1

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(true)
			end
		end

		arg_807_1.nodeConfigList_ = {}

		arg_807_1:InitPlayNodeList()
	end,
	Play924041193 = function(arg_811_0, arg_811_1)
		arg_811_1.time_ = 0
		arg_811_1.frameCnt_ = 0
		arg_811_1.state_ = "playing"
		arg_811_1.curTalkId_ = 924041193
		arg_811_1.duration_ = 8.5

		local var_811_0 = {
			zh = 8.5,
			ja = 8.1
		}
		local var_811_1 = manager.audio:GetLocalizationFlag()

		if var_811_0[var_811_1] ~= nil then
			arg_811_1.duration_ = var_811_0[var_811_1]
		end

		SetActive(arg_811_1.tipsGo_, false)

		function arg_811_1.onSingleLineFinish_()
			arg_811_1.onSingleLineUpdate_ = nil
			arg_811_1.onSingleLineFinish_ = nil
			arg_811_1.state_ = "waiting"
		end

		function arg_811_1.playNext_(arg_813_0)
			if arg_813_0 == 1 then
				arg_811_0:Play924041194(arg_811_1)
			end
		end

		function arg_811_1.onSingleLineUpdate_(arg_814_0)
			local var_814_0 = arg_811_1.actors_["102003ui_story"].transform
			local var_814_1 = 0

			if var_814_1 < arg_811_1.time_ and arg_811_1.time_ <= var_814_1 + arg_814_0 then
				arg_811_1.var_.moveOldPos102003ui_story = var_814_0.localPosition
			end

			local var_814_2 = 0.001

			if var_814_1 <= arg_811_1.time_ and arg_811_1.time_ < var_814_1 + var_814_2 then
				local var_814_3 = (arg_811_1.time_ - var_814_1) / var_814_2
				local var_814_4 = Vector3.New(0, -0.85, -6.21)

				var_814_0.localPosition = Vector3.Lerp(arg_811_1.var_.moveOldPos102003ui_story, var_814_4, var_814_3)

				local var_814_5 = manager.ui.mainCamera.transform.position - var_814_0.position

				var_814_0.forward = Vector3.New(var_814_5.x, var_814_5.y, var_814_5.z)

				local var_814_6 = var_814_0.localEulerAngles

				var_814_6.z = 0
				var_814_6.x = 0
				var_814_0.localEulerAngles = var_814_6
			end

			if arg_811_1.time_ >= var_814_1 + var_814_2 and arg_811_1.time_ < var_814_1 + var_814_2 + arg_814_0 then
				var_814_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_814_7 = manager.ui.mainCamera.transform.position - var_814_0.position

				var_814_0.forward = Vector3.New(var_814_7.x, var_814_7.y, var_814_7.z)

				local var_814_8 = var_814_0.localEulerAngles

				var_814_8.z = 0
				var_814_8.x = 0
				var_814_0.localEulerAngles = var_814_8
			end

			local var_814_9 = arg_811_1.actors_["102003ui_story"]
			local var_814_10 = 0

			if var_814_10 < arg_811_1.time_ and arg_811_1.time_ <= var_814_10 + arg_814_0 and not isNil(var_814_9) and arg_811_1.var_.characterEffect102003ui_story == nil then
				arg_811_1.var_.characterEffect102003ui_story = var_814_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_814_11 = 0.200000002980232

			if var_814_10 <= arg_811_1.time_ and arg_811_1.time_ < var_814_10 + var_814_11 and not isNil(var_814_9) then
				local var_814_12 = (arg_811_1.time_ - var_814_10) / var_814_11

				if arg_811_1.var_.characterEffect102003ui_story and not isNil(var_814_9) then
					arg_811_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_811_1.time_ >= var_814_10 + var_814_11 and arg_811_1.time_ < var_814_10 + var_814_11 + arg_814_0 and not isNil(var_814_9) and arg_811_1.var_.characterEffect102003ui_story then
				arg_811_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_814_13 = 0

			if var_814_13 < arg_811_1.time_ and arg_811_1.time_ <= var_814_13 + arg_814_0 then
				arg_811_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_2")
			end

			local var_814_14 = 0
			local var_814_15 = 0.875

			if var_814_14 < arg_811_1.time_ and arg_811_1.time_ <= var_814_14 + arg_814_0 then
				arg_811_1.talkMaxDuration = 0
				arg_811_1.dialogCg_.alpha = 1

				arg_811_1.dialog_:SetActive(true)
				SetActive(arg_811_1.leftNameGo_, true)

				local var_814_16 = arg_811_1:FormatText(StoryNameCfg[613].name)

				arg_811_1.leftNameTxt_.text = var_814_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_811_1.leftNameTxt_.transform)

				arg_811_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_811_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_811_1:RecordName(arg_811_1.leftNameTxt_.text)
				SetActive(arg_811_1.iconTrs_.gameObject, false)
				arg_811_1.callingController_:SetSelectedState("normal")

				local var_814_17 = arg_811_1:GetWordFromCfg(924041193)
				local var_814_18 = arg_811_1:FormatText(var_814_17.content)

				arg_811_1.text_.text = var_814_18

				LuaForUtil.ClearLinePrefixSymbol(arg_811_1.text_)

				local var_814_19 = 35
				local var_814_20 = utf8.len(var_814_18)
				local var_814_21 = var_814_19 <= 0 and var_814_15 or var_814_15 * (var_814_20 / var_814_19)

				if var_814_21 > 0 and var_814_15 < var_814_21 then
					arg_811_1.talkMaxDuration = var_814_21

					if var_814_21 + var_814_14 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_21 + var_814_14
					end
				end

				arg_811_1.text_.text = var_814_18
				arg_811_1.typewritter.percent = 0

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb") ~= 0 then
					local var_814_22 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb") / 1000

					if var_814_22 + var_814_14 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_22 + var_814_14
					end

					if var_814_17.prefab_name ~= "" and arg_811_1.actors_[var_814_17.prefab_name] ~= nil then
						local var_814_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_811_1.actors_[var_814_17.prefab_name].transform, "story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb")

						arg_811_1:RecordAudio("924041193", var_814_23)
						arg_811_1:RecordAudio("924041193", var_814_23)
					else
						arg_811_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb")
					end

					arg_811_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb")
				end

				arg_811_1:RecordContent(arg_811_1.text_.text)
			end

			local var_814_24 = math.max(var_814_15, arg_811_1.talkMaxDuration)

			if var_814_14 <= arg_811_1.time_ and arg_811_1.time_ < var_814_14 + var_814_24 then
				arg_811_1.typewritter.percent = (arg_811_1.time_ - var_814_14) / var_814_24

				arg_811_1.typewritter:SetDirty()
			end

			if arg_811_1.time_ >= var_814_14 + var_814_24 and arg_811_1.time_ < var_814_14 + var_814_24 + arg_814_0 then
				arg_811_1.typewritter.percent = 1

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(true)
			end
		end

		arg_811_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_811_1:InitPlayNodeList()
	end,
	Play924041194 = function(arg_815_0, arg_815_1)
		arg_815_1.time_ = 0
		arg_815_1.frameCnt_ = 0
		arg_815_1.state_ = "playing"
		arg_815_1.curTalkId_ = 924041194
		arg_815_1.duration_ = 5

		SetActive(arg_815_1.tipsGo_, false)

		function arg_815_1.onSingleLineFinish_()
			arg_815_1.onSingleLineUpdate_ = nil
			arg_815_1.onSingleLineFinish_ = nil
			arg_815_1.state_ = "waiting"
		end

		function arg_815_1.playNext_(arg_817_0)
			if arg_817_0 == 1 then
				arg_815_0:Play924041195(arg_815_1)
			end
		end

		function arg_815_1.onSingleLineUpdate_(arg_818_0)
			local var_818_0 = arg_815_1.actors_["102003ui_story"]
			local var_818_1 = 0

			if var_818_1 < arg_815_1.time_ and arg_815_1.time_ <= var_818_1 + arg_818_0 and not isNil(var_818_0) and arg_815_1.var_.characterEffect102003ui_story == nil then
				arg_815_1.var_.characterEffect102003ui_story = var_818_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_818_2 = 0.200000002980232

			if var_818_1 <= arg_815_1.time_ and arg_815_1.time_ < var_818_1 + var_818_2 and not isNil(var_818_0) then
				local var_818_3 = (arg_815_1.time_ - var_818_1) / var_818_2

				if arg_815_1.var_.characterEffect102003ui_story and not isNil(var_818_0) then
					local var_818_4 = Mathf.Lerp(0, 0.5, var_818_3)

					arg_815_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_815_1.var_.characterEffect102003ui_story.fillRatio = var_818_4
				end
			end

			if arg_815_1.time_ >= var_818_1 + var_818_2 and arg_815_1.time_ < var_818_1 + var_818_2 + arg_818_0 and not isNil(var_818_0) and arg_815_1.var_.characterEffect102003ui_story then
				local var_818_5 = 0.5

				arg_815_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_815_1.var_.characterEffect102003ui_story.fillRatio = var_818_5
			end

			local var_818_6 = 0
			local var_818_7 = 0.45

			if var_818_6 < arg_815_1.time_ and arg_815_1.time_ <= var_818_6 + arg_818_0 then
				arg_815_1.talkMaxDuration = 0
				arg_815_1.dialogCg_.alpha = 1

				arg_815_1.dialog_:SetActive(true)
				SetActive(arg_815_1.leftNameGo_, true)

				local var_818_8 = arg_815_1:FormatText(StoryNameCfg[7].name)

				arg_815_1.leftNameTxt_.text = var_818_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_815_1.leftNameTxt_.transform)

				arg_815_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_815_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_815_1:RecordName(arg_815_1.leftNameTxt_.text)
				SetActive(arg_815_1.iconTrs_.gameObject, true)
				arg_815_1.iconController_:SetSelectedState("hero")

				arg_815_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_815_1.callingController_:SetSelectedState("normal")

				arg_815_1.keyicon_.color = Color.New(1, 1, 1)
				arg_815_1.icon_.color = Color.New(1, 1, 1)

				local var_818_9 = arg_815_1:GetWordFromCfg(924041194)
				local var_818_10 = arg_815_1:FormatText(var_818_9.content)

				arg_815_1.text_.text = var_818_10

				LuaForUtil.ClearLinePrefixSymbol(arg_815_1.text_)

				local var_818_11 = 18
				local var_818_12 = utf8.len(var_818_10)
				local var_818_13 = var_818_11 <= 0 and var_818_7 or var_818_7 * (var_818_12 / var_818_11)

				if var_818_13 > 0 and var_818_7 < var_818_13 then
					arg_815_1.talkMaxDuration = var_818_13

					if var_818_13 + var_818_6 > arg_815_1.duration_ then
						arg_815_1.duration_ = var_818_13 + var_818_6
					end
				end

				arg_815_1.text_.text = var_818_10
				arg_815_1.typewritter.percent = 0

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(false)
				arg_815_1:RecordContent(arg_815_1.text_.text)
			end

			local var_818_14 = math.max(var_818_7, arg_815_1.talkMaxDuration)

			if var_818_6 <= arg_815_1.time_ and arg_815_1.time_ < var_818_6 + var_818_14 then
				arg_815_1.typewritter.percent = (arg_815_1.time_ - var_818_6) / var_818_14

				arg_815_1.typewritter:SetDirty()
			end

			if arg_815_1.time_ >= var_818_6 + var_818_14 and arg_815_1.time_ < var_818_6 + var_818_14 + arg_818_0 then
				arg_815_1.typewritter.percent = 1

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(true)
			end
		end

		arg_815_1.nodeConfigList_ = {}

		arg_815_1:InitPlayNodeList()
	end,
	Play924041195 = function(arg_819_0, arg_819_1)
		arg_819_1.time_ = 0
		arg_819_1.frameCnt_ = 0
		arg_819_1.state_ = "playing"
		arg_819_1.curTalkId_ = 924041195
		arg_819_1.duration_ = 3.23

		local var_819_0 = {
			zh = 1.366,
			ja = 3.233
		}
		local var_819_1 = manager.audio:GetLocalizationFlag()

		if var_819_0[var_819_1] ~= nil then
			arg_819_1.duration_ = var_819_0[var_819_1]
		end

		SetActive(arg_819_1.tipsGo_, false)

		function arg_819_1.onSingleLineFinish_()
			arg_819_1.onSingleLineUpdate_ = nil
			arg_819_1.onSingleLineFinish_ = nil
			arg_819_1.state_ = "waiting"
		end

		function arg_819_1.playNext_(arg_821_0)
			if arg_821_0 == 1 then
				arg_819_0:Play924041196(arg_819_1)
			end
		end

		function arg_819_1.onSingleLineUpdate_(arg_822_0)
			local var_822_0 = arg_819_1.actors_["102003ui_story"].transform
			local var_822_1 = 0

			if var_822_1 < arg_819_1.time_ and arg_819_1.time_ <= var_822_1 + arg_822_0 then
				arg_819_1.var_.moveOldPos102003ui_story = var_822_0.localPosition
			end

			local var_822_2 = 0.001

			if var_822_1 <= arg_819_1.time_ and arg_819_1.time_ < var_822_1 + var_822_2 then
				local var_822_3 = (arg_819_1.time_ - var_822_1) / var_822_2
				local var_822_4 = Vector3.New(0, -0.85, -6.21)

				var_822_0.localPosition = Vector3.Lerp(arg_819_1.var_.moveOldPos102003ui_story, var_822_4, var_822_3)

				local var_822_5 = manager.ui.mainCamera.transform.position - var_822_0.position

				var_822_0.forward = Vector3.New(var_822_5.x, var_822_5.y, var_822_5.z)

				local var_822_6 = var_822_0.localEulerAngles

				var_822_6.z = 0
				var_822_6.x = 0
				var_822_0.localEulerAngles = var_822_6
			end

			if arg_819_1.time_ >= var_822_1 + var_822_2 and arg_819_1.time_ < var_822_1 + var_822_2 + arg_822_0 then
				var_822_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_822_7 = manager.ui.mainCamera.transform.position - var_822_0.position

				var_822_0.forward = Vector3.New(var_822_7.x, var_822_7.y, var_822_7.z)

				local var_822_8 = var_822_0.localEulerAngles

				var_822_8.z = 0
				var_822_8.x = 0
				var_822_0.localEulerAngles = var_822_8
			end

			local var_822_9 = arg_819_1.actors_["102003ui_story"]
			local var_822_10 = 0

			if var_822_10 < arg_819_1.time_ and arg_819_1.time_ <= var_822_10 + arg_822_0 and not isNil(var_822_9) and arg_819_1.var_.characterEffect102003ui_story == nil then
				arg_819_1.var_.characterEffect102003ui_story = var_822_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_822_11 = 0.200000002980232

			if var_822_10 <= arg_819_1.time_ and arg_819_1.time_ < var_822_10 + var_822_11 and not isNil(var_822_9) then
				local var_822_12 = (arg_819_1.time_ - var_822_10) / var_822_11

				if arg_819_1.var_.characterEffect102003ui_story and not isNil(var_822_9) then
					arg_819_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_819_1.time_ >= var_822_10 + var_822_11 and arg_819_1.time_ < var_822_10 + var_822_11 + arg_822_0 and not isNil(var_822_9) and arg_819_1.var_.characterEffect102003ui_story then
				arg_819_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_822_13 = 0

			if var_822_13 < arg_819_1.time_ and arg_819_1.time_ <= var_822_13 + arg_822_0 then
				arg_819_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action12_1")
			end

			local var_822_14 = 0

			if var_822_14 < arg_819_1.time_ and arg_819_1.time_ <= var_822_14 + arg_822_0 then
				arg_819_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_822_15 = 0
			local var_822_16 = 0.175

			if var_822_15 < arg_819_1.time_ and arg_819_1.time_ <= var_822_15 + arg_822_0 then
				arg_819_1.talkMaxDuration = 0
				arg_819_1.dialogCg_.alpha = 1

				arg_819_1.dialog_:SetActive(true)
				SetActive(arg_819_1.leftNameGo_, true)

				local var_822_17 = arg_819_1:FormatText(StoryNameCfg[613].name)

				arg_819_1.leftNameTxt_.text = var_822_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_819_1.leftNameTxt_.transform)

				arg_819_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_819_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_819_1:RecordName(arg_819_1.leftNameTxt_.text)
				SetActive(arg_819_1.iconTrs_.gameObject, false)
				arg_819_1.callingController_:SetSelectedState("normal")

				local var_822_18 = arg_819_1:GetWordFromCfg(924041195)
				local var_822_19 = arg_819_1:FormatText(var_822_18.content)

				arg_819_1.text_.text = var_822_19

				LuaForUtil.ClearLinePrefixSymbol(arg_819_1.text_)

				local var_822_20 = 7
				local var_822_21 = utf8.len(var_822_19)
				local var_822_22 = var_822_20 <= 0 and var_822_16 or var_822_16 * (var_822_21 / var_822_20)

				if var_822_22 > 0 and var_822_16 < var_822_22 then
					arg_819_1.talkMaxDuration = var_822_22

					if var_822_22 + var_822_15 > arg_819_1.duration_ then
						arg_819_1.duration_ = var_822_22 + var_822_15
					end
				end

				arg_819_1.text_.text = var_822_19
				arg_819_1.typewritter.percent = 0

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb") ~= 0 then
					local var_822_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb") / 1000

					if var_822_23 + var_822_15 > arg_819_1.duration_ then
						arg_819_1.duration_ = var_822_23 + var_822_15
					end

					if var_822_18.prefab_name ~= "" and arg_819_1.actors_[var_822_18.prefab_name] ~= nil then
						local var_822_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_819_1.actors_[var_822_18.prefab_name].transform, "story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb")

						arg_819_1:RecordAudio("924041195", var_822_24)
						arg_819_1:RecordAudio("924041195", var_822_24)
					else
						arg_819_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb")
					end

					arg_819_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb")
				end

				arg_819_1:RecordContent(arg_819_1.text_.text)
			end

			local var_822_25 = math.max(var_822_16, arg_819_1.talkMaxDuration)

			if var_822_15 <= arg_819_1.time_ and arg_819_1.time_ < var_822_15 + var_822_25 then
				arg_819_1.typewritter.percent = (arg_819_1.time_ - var_822_15) / var_822_25

				arg_819_1.typewritter:SetDirty()
			end

			if arg_819_1.time_ >= var_822_15 + var_822_25 and arg_819_1.time_ < var_822_15 + var_822_25 + arg_822_0 then
				arg_819_1.typewritter.percent = 1

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(true)
			end
		end

		arg_819_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_819_1:InitPlayNodeList()
	end,
	Play924041196 = function(arg_823_0, arg_823_1)
		arg_823_1.time_ = 0
		arg_823_1.frameCnt_ = 0
		arg_823_1.state_ = "playing"
		arg_823_1.curTalkId_ = 924041196
		arg_823_1.duration_ = 5

		SetActive(arg_823_1.tipsGo_, false)

		function arg_823_1.onSingleLineFinish_()
			arg_823_1.onSingleLineUpdate_ = nil
			arg_823_1.onSingleLineFinish_ = nil
			arg_823_1.state_ = "waiting"
		end

		function arg_823_1.playNext_(arg_825_0)
			if arg_825_0 == 1 then
				arg_823_0:Play924041197(arg_823_1)
			end
		end

		function arg_823_1.onSingleLineUpdate_(arg_826_0)
			local var_826_0 = arg_823_1.actors_["102003ui_story"].transform
			local var_826_1 = 0

			if var_826_1 < arg_823_1.time_ and arg_823_1.time_ <= var_826_1 + arg_826_0 then
				arg_823_1.var_.moveOldPos102003ui_story = var_826_0.localPosition
			end

			local var_826_2 = 0.001

			if var_826_1 <= arg_823_1.time_ and arg_823_1.time_ < var_826_1 + var_826_2 then
				local var_826_3 = (arg_823_1.time_ - var_826_1) / var_826_2
				local var_826_4 = Vector3.New(0, 100, 0)

				var_826_0.localPosition = Vector3.Lerp(arg_823_1.var_.moveOldPos102003ui_story, var_826_4, var_826_3)

				local var_826_5 = manager.ui.mainCamera.transform.position - var_826_0.position

				var_826_0.forward = Vector3.New(var_826_5.x, var_826_5.y, var_826_5.z)

				local var_826_6 = var_826_0.localEulerAngles

				var_826_6.z = 0
				var_826_6.x = 0
				var_826_0.localEulerAngles = var_826_6
			end

			if arg_823_1.time_ >= var_826_1 + var_826_2 and arg_823_1.time_ < var_826_1 + var_826_2 + arg_826_0 then
				var_826_0.localPosition = Vector3.New(0, 100, 0)

				local var_826_7 = manager.ui.mainCamera.transform.position - var_826_0.position

				var_826_0.forward = Vector3.New(var_826_7.x, var_826_7.y, var_826_7.z)

				local var_826_8 = var_826_0.localEulerAngles

				var_826_8.z = 0
				var_826_8.x = 0
				var_826_0.localEulerAngles = var_826_8
			end

			local var_826_9 = arg_823_1.actors_["102003ui_story"]
			local var_826_10 = 0

			if var_826_10 < arg_823_1.time_ and arg_823_1.time_ <= var_826_10 + arg_826_0 and not isNil(var_826_9) and arg_823_1.var_.characterEffect102003ui_story == nil then
				arg_823_1.var_.characterEffect102003ui_story = var_826_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_826_11 = 0.200000002980232

			if var_826_10 <= arg_823_1.time_ and arg_823_1.time_ < var_826_10 + var_826_11 and not isNil(var_826_9) then
				local var_826_12 = (arg_823_1.time_ - var_826_10) / var_826_11

				if arg_823_1.var_.characterEffect102003ui_story and not isNil(var_826_9) then
					local var_826_13 = Mathf.Lerp(0, 0.5, var_826_12)

					arg_823_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_823_1.var_.characterEffect102003ui_story.fillRatio = var_826_13
				end
			end

			if arg_823_1.time_ >= var_826_10 + var_826_11 and arg_823_1.time_ < var_826_10 + var_826_11 + arg_826_0 and not isNil(var_826_9) and arg_823_1.var_.characterEffect102003ui_story then
				local var_826_14 = 0.5

				arg_823_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_823_1.var_.characterEffect102003ui_story.fillRatio = var_826_14
			end

			local var_826_15 = 0.566666666666667
			local var_826_16 = 1

			if var_826_15 < arg_823_1.time_ and arg_823_1.time_ <= var_826_15 + arg_826_0 then
				local var_826_17 = "play"
				local var_826_18 = "effect"

				arg_823_1:AudioAction(var_826_17, var_826_18, "se_story_140", "se_story_140_foley_hug", "")
			end

			local var_826_19 = 0
			local var_826_20 = 0.725

			if var_826_19 < arg_823_1.time_ and arg_823_1.time_ <= var_826_19 + arg_826_0 then
				arg_823_1.talkMaxDuration = 0
				arg_823_1.dialogCg_.alpha = 1

				arg_823_1.dialog_:SetActive(true)
				SetActive(arg_823_1.leftNameGo_, false)

				arg_823_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_823_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_823_1:RecordName(arg_823_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_823_1.iconTrs_.gameObject, false)
				arg_823_1.callingController_:SetSelectedState("normal")

				local var_826_21 = arg_823_1:GetWordFromCfg(924041196)
				local var_826_22 = arg_823_1:FormatText(var_826_21.content)

				arg_823_1.text_.text = var_826_22

				LuaForUtil.ClearLinePrefixSymbol(arg_823_1.text_)

				local var_826_23 = 29
				local var_826_24 = utf8.len(var_826_22)
				local var_826_25 = var_826_23 <= 0 and var_826_20 or var_826_20 * (var_826_24 / var_826_23)

				if var_826_25 > 0 and var_826_20 < var_826_25 then
					arg_823_1.talkMaxDuration = var_826_25

					if var_826_25 + var_826_19 > arg_823_1.duration_ then
						arg_823_1.duration_ = var_826_25 + var_826_19
					end
				end

				arg_823_1.text_.text = var_826_22
				arg_823_1.typewritter.percent = 0

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(false)
				arg_823_1:RecordContent(arg_823_1.text_.text)
			end

			local var_826_26 = math.max(var_826_20, arg_823_1.talkMaxDuration)

			if var_826_19 <= arg_823_1.time_ and arg_823_1.time_ < var_826_19 + var_826_26 then
				arg_823_1.typewritter.percent = (arg_823_1.time_ - var_826_19) / var_826_26

				arg_823_1.typewritter:SetDirty()
			end

			if arg_823_1.time_ >= var_826_19 + var_826_26 and arg_823_1.time_ < var_826_19 + var_826_26 + arg_826_0 then
				arg_823_1.typewritter.percent = 1

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(true)
			end
		end

		arg_823_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_823_1:InitPlayNodeList()
	end,
	Play924041197 = function(arg_827_0, arg_827_1)
		arg_827_1.time_ = 0
		arg_827_1.frameCnt_ = 0
		arg_827_1.state_ = "playing"
		arg_827_1.curTalkId_ = 924041197
		arg_827_1.duration_ = 5

		SetActive(arg_827_1.tipsGo_, false)

		function arg_827_1.onSingleLineFinish_()
			arg_827_1.onSingleLineUpdate_ = nil
			arg_827_1.onSingleLineFinish_ = nil
			arg_827_1.state_ = "waiting"
		end

		function arg_827_1.playNext_(arg_829_0)
			if arg_829_0 == 1 then
				arg_827_0:Play924041198(arg_827_1)
			end
		end

		function arg_827_1.onSingleLineUpdate_(arg_830_0)
			local var_830_0 = 0
			local var_830_1 = 0.4

			if var_830_0 < arg_827_1.time_ and arg_827_1.time_ <= var_830_0 + arg_830_0 then
				arg_827_1.talkMaxDuration = 0
				arg_827_1.dialogCg_.alpha = 1

				arg_827_1.dialog_:SetActive(true)
				SetActive(arg_827_1.leftNameGo_, true)

				local var_830_2 = arg_827_1:FormatText(StoryNameCfg[7].name)

				arg_827_1.leftNameTxt_.text = var_830_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_827_1.leftNameTxt_.transform)

				arg_827_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_827_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_827_1:RecordName(arg_827_1.leftNameTxt_.text)
				SetActive(arg_827_1.iconTrs_.gameObject, true)
				arg_827_1.iconController_:SetSelectedState("hero")

				arg_827_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_827_1.callingController_:SetSelectedState("normal")

				arg_827_1.keyicon_.color = Color.New(1, 1, 1)
				arg_827_1.icon_.color = Color.New(1, 1, 1)

				local var_830_3 = arg_827_1:GetWordFromCfg(924041197)
				local var_830_4 = arg_827_1:FormatText(var_830_3.content)

				arg_827_1.text_.text = var_830_4

				LuaForUtil.ClearLinePrefixSymbol(arg_827_1.text_)

				local var_830_5 = 16
				local var_830_6 = utf8.len(var_830_4)
				local var_830_7 = var_830_5 <= 0 and var_830_1 or var_830_1 * (var_830_6 / var_830_5)

				if var_830_7 > 0 and var_830_1 < var_830_7 then
					arg_827_1.talkMaxDuration = var_830_7

					if var_830_7 + var_830_0 > arg_827_1.duration_ then
						arg_827_1.duration_ = var_830_7 + var_830_0
					end
				end

				arg_827_1.text_.text = var_830_4
				arg_827_1.typewritter.percent = 0

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(false)
				arg_827_1:RecordContent(arg_827_1.text_.text)
			end

			local var_830_8 = math.max(var_830_1, arg_827_1.talkMaxDuration)

			if var_830_0 <= arg_827_1.time_ and arg_827_1.time_ < var_830_0 + var_830_8 then
				arg_827_1.typewritter.percent = (arg_827_1.time_ - var_830_0) / var_830_8

				arg_827_1.typewritter:SetDirty()
			end

			if arg_827_1.time_ >= var_830_0 + var_830_8 and arg_827_1.time_ < var_830_0 + var_830_8 + arg_830_0 then
				arg_827_1.typewritter.percent = 1

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(true)
			end
		end

		arg_827_1.nodeConfigList_ = {}

		arg_827_1:InitPlayNodeList()
	end,
	Play924041198 = function(arg_831_0, arg_831_1)
		arg_831_1.time_ = 0
		arg_831_1.frameCnt_ = 0
		arg_831_1.state_ = "playing"
		arg_831_1.curTalkId_ = 924041198
		arg_831_1.duration_ = 5.4

		local var_831_0 = {
			zh = 5.4,
			ja = 4.5
		}
		local var_831_1 = manager.audio:GetLocalizationFlag()

		if var_831_0[var_831_1] ~= nil then
			arg_831_1.duration_ = var_831_0[var_831_1]
		end

		SetActive(arg_831_1.tipsGo_, false)

		function arg_831_1.onSingleLineFinish_()
			arg_831_1.onSingleLineUpdate_ = nil
			arg_831_1.onSingleLineFinish_ = nil
			arg_831_1.state_ = "waiting"
		end

		function arg_831_1.playNext_(arg_833_0)
			if arg_833_0 == 1 then
				arg_831_0:Play924041199(arg_831_1)
			end
		end

		function arg_831_1.onSingleLineUpdate_(arg_834_0)
			local var_834_0 = arg_831_1.actors_["102003ui_story"].transform
			local var_834_1 = 0

			if var_834_1 < arg_831_1.time_ and arg_831_1.time_ <= var_834_1 + arg_834_0 then
				arg_831_1.var_.moveOldPos102003ui_story = var_834_0.localPosition
			end

			local var_834_2 = 0.001

			if var_834_1 <= arg_831_1.time_ and arg_831_1.time_ < var_834_1 + var_834_2 then
				local var_834_3 = (arg_831_1.time_ - var_834_1) / var_834_2
				local var_834_4 = Vector3.New(0, -0.85, -6.21)

				var_834_0.localPosition = Vector3.Lerp(arg_831_1.var_.moveOldPos102003ui_story, var_834_4, var_834_3)

				local var_834_5 = manager.ui.mainCamera.transform.position - var_834_0.position

				var_834_0.forward = Vector3.New(var_834_5.x, var_834_5.y, var_834_5.z)

				local var_834_6 = var_834_0.localEulerAngles

				var_834_6.z = 0
				var_834_6.x = 0
				var_834_0.localEulerAngles = var_834_6
			end

			if arg_831_1.time_ >= var_834_1 + var_834_2 and arg_831_1.time_ < var_834_1 + var_834_2 + arg_834_0 then
				var_834_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_834_7 = manager.ui.mainCamera.transform.position - var_834_0.position

				var_834_0.forward = Vector3.New(var_834_7.x, var_834_7.y, var_834_7.z)

				local var_834_8 = var_834_0.localEulerAngles

				var_834_8.z = 0
				var_834_8.x = 0
				var_834_0.localEulerAngles = var_834_8
			end

			local var_834_9 = arg_831_1.actors_["102003ui_story"]
			local var_834_10 = 0

			if var_834_10 < arg_831_1.time_ and arg_831_1.time_ <= var_834_10 + arg_834_0 and not isNil(var_834_9) and arg_831_1.var_.characterEffect102003ui_story == nil then
				arg_831_1.var_.characterEffect102003ui_story = var_834_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_834_11 = 0.200000002980232

			if var_834_10 <= arg_831_1.time_ and arg_831_1.time_ < var_834_10 + var_834_11 and not isNil(var_834_9) then
				local var_834_12 = (arg_831_1.time_ - var_834_10) / var_834_11

				if arg_831_1.var_.characterEffect102003ui_story and not isNil(var_834_9) then
					arg_831_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_831_1.time_ >= var_834_10 + var_834_11 and arg_831_1.time_ < var_834_10 + var_834_11 + arg_834_0 and not isNil(var_834_9) and arg_831_1.var_.characterEffect102003ui_story then
				arg_831_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_834_13 = 0

			if var_834_13 < arg_831_1.time_ and arg_831_1.time_ <= var_834_13 + arg_834_0 then
				arg_831_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			local var_834_14 = 0

			if var_834_14 < arg_831_1.time_ and arg_831_1.time_ <= var_834_14 + arg_834_0 then
				arg_831_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_834_15 = 0
			local var_834_16 = 0.475

			if var_834_15 < arg_831_1.time_ and arg_831_1.time_ <= var_834_15 + arg_834_0 then
				arg_831_1.talkMaxDuration = 0
				arg_831_1.dialogCg_.alpha = 1

				arg_831_1.dialog_:SetActive(true)
				SetActive(arg_831_1.leftNameGo_, true)

				local var_834_17 = arg_831_1:FormatText(StoryNameCfg[613].name)

				arg_831_1.leftNameTxt_.text = var_834_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_831_1.leftNameTxt_.transform)

				arg_831_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_831_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_831_1:RecordName(arg_831_1.leftNameTxt_.text)
				SetActive(arg_831_1.iconTrs_.gameObject, false)
				arg_831_1.callingController_:SetSelectedState("normal")

				local var_834_18 = arg_831_1:GetWordFromCfg(924041198)
				local var_834_19 = arg_831_1:FormatText(var_834_18.content)

				arg_831_1.text_.text = var_834_19

				LuaForUtil.ClearLinePrefixSymbol(arg_831_1.text_)

				local var_834_20 = 19
				local var_834_21 = utf8.len(var_834_19)
				local var_834_22 = var_834_20 <= 0 and var_834_16 or var_834_16 * (var_834_21 / var_834_20)

				if var_834_22 > 0 and var_834_16 < var_834_22 then
					arg_831_1.talkMaxDuration = var_834_22

					if var_834_22 + var_834_15 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_22 + var_834_15
					end
				end

				arg_831_1.text_.text = var_834_19
				arg_831_1.typewritter.percent = 0

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb") ~= 0 then
					local var_834_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb") / 1000

					if var_834_23 + var_834_15 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_23 + var_834_15
					end

					if var_834_18.prefab_name ~= "" and arg_831_1.actors_[var_834_18.prefab_name] ~= nil then
						local var_834_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_831_1.actors_[var_834_18.prefab_name].transform, "story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb")

						arg_831_1:RecordAudio("924041198", var_834_24)
						arg_831_1:RecordAudio("924041198", var_834_24)
					else
						arg_831_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb")
					end

					arg_831_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb")
				end

				arg_831_1:RecordContent(arg_831_1.text_.text)
			end

			local var_834_25 = math.max(var_834_16, arg_831_1.talkMaxDuration)

			if var_834_15 <= arg_831_1.time_ and arg_831_1.time_ < var_834_15 + var_834_25 then
				arg_831_1.typewritter.percent = (arg_831_1.time_ - var_834_15) / var_834_25

				arg_831_1.typewritter:SetDirty()
			end

			if arg_831_1.time_ >= var_834_15 + var_834_25 and arg_831_1.time_ < var_834_15 + var_834_25 + arg_834_0 then
				arg_831_1.typewritter.percent = 1

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(true)
			end
		end

		arg_831_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_831_1:InitPlayNodeList()
	end,
	Play924041199 = function(arg_835_0, arg_835_1)
		arg_835_1.time_ = 0
		arg_835_1.frameCnt_ = 0
		arg_835_1.state_ = "playing"
		arg_835_1.curTalkId_ = 924041199
		arg_835_1.duration_ = 5

		SetActive(arg_835_1.tipsGo_, false)

		function arg_835_1.onSingleLineFinish_()
			arg_835_1.onSingleLineUpdate_ = nil
			arg_835_1.onSingleLineFinish_ = nil
			arg_835_1.state_ = "waiting"
		end

		function arg_835_1.playNext_(arg_837_0)
			if arg_837_0 == 1 then
				arg_835_0:Play924041200(arg_835_1)
			end
		end

		function arg_835_1.onSingleLineUpdate_(arg_838_0)
			local var_838_0 = arg_835_1.actors_["102003ui_story"]
			local var_838_1 = 0

			if var_838_1 < arg_835_1.time_ and arg_835_1.time_ <= var_838_1 + arg_838_0 and not isNil(var_838_0) and arg_835_1.var_.characterEffect102003ui_story == nil then
				arg_835_1.var_.characterEffect102003ui_story = var_838_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_838_2 = 0.200000002980232

			if var_838_1 <= arg_835_1.time_ and arg_835_1.time_ < var_838_1 + var_838_2 and not isNil(var_838_0) then
				local var_838_3 = (arg_835_1.time_ - var_838_1) / var_838_2

				if arg_835_1.var_.characterEffect102003ui_story and not isNil(var_838_0) then
					local var_838_4 = Mathf.Lerp(0, 0.5, var_838_3)

					arg_835_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_835_1.var_.characterEffect102003ui_story.fillRatio = var_838_4
				end
			end

			if arg_835_1.time_ >= var_838_1 + var_838_2 and arg_835_1.time_ < var_838_1 + var_838_2 + arg_838_0 and not isNil(var_838_0) and arg_835_1.var_.characterEffect102003ui_story then
				local var_838_5 = 0.5

				arg_835_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_835_1.var_.characterEffect102003ui_story.fillRatio = var_838_5
			end

			local var_838_6 = 0
			local var_838_7 = 0.425

			if var_838_6 < arg_835_1.time_ and arg_835_1.time_ <= var_838_6 + arg_838_0 then
				arg_835_1.talkMaxDuration = 0
				arg_835_1.dialogCg_.alpha = 1

				arg_835_1.dialog_:SetActive(true)
				SetActive(arg_835_1.leftNameGo_, true)

				local var_838_8 = arg_835_1:FormatText(StoryNameCfg[7].name)

				arg_835_1.leftNameTxt_.text = var_838_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_835_1.leftNameTxt_.transform)

				arg_835_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_835_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_835_1:RecordName(arg_835_1.leftNameTxt_.text)
				SetActive(arg_835_1.iconTrs_.gameObject, true)
				arg_835_1.iconController_:SetSelectedState("hero")

				arg_835_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_835_1.callingController_:SetSelectedState("normal")

				arg_835_1.keyicon_.color = Color.New(1, 1, 1)
				arg_835_1.icon_.color = Color.New(1, 1, 1)

				local var_838_9 = arg_835_1:GetWordFromCfg(924041199)
				local var_838_10 = arg_835_1:FormatText(var_838_9.content)

				arg_835_1.text_.text = var_838_10

				LuaForUtil.ClearLinePrefixSymbol(arg_835_1.text_)

				local var_838_11 = 17
				local var_838_12 = utf8.len(var_838_10)
				local var_838_13 = var_838_11 <= 0 and var_838_7 or var_838_7 * (var_838_12 / var_838_11)

				if var_838_13 > 0 and var_838_7 < var_838_13 then
					arg_835_1.talkMaxDuration = var_838_13

					if var_838_13 + var_838_6 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_13 + var_838_6
					end
				end

				arg_835_1.text_.text = var_838_10
				arg_835_1.typewritter.percent = 0

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(false)
				arg_835_1:RecordContent(arg_835_1.text_.text)
			end

			local var_838_14 = math.max(var_838_7, arg_835_1.talkMaxDuration)

			if var_838_6 <= arg_835_1.time_ and arg_835_1.time_ < var_838_6 + var_838_14 then
				arg_835_1.typewritter.percent = (arg_835_1.time_ - var_838_6) / var_838_14

				arg_835_1.typewritter:SetDirty()
			end

			if arg_835_1.time_ >= var_838_6 + var_838_14 and arg_835_1.time_ < var_838_6 + var_838_14 + arg_838_0 then
				arg_835_1.typewritter.percent = 1

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(true)
			end
		end

		arg_835_1.nodeConfigList_ = {}

		arg_835_1:InitPlayNodeList()
	end,
	Play924041200 = function(arg_839_0, arg_839_1)
		arg_839_1.time_ = 0
		arg_839_1.frameCnt_ = 0
		arg_839_1.state_ = "playing"
		arg_839_1.curTalkId_ = 924041200
		arg_839_1.duration_ = 8.7

		local var_839_0 = {
			zh = 6.933,
			ja = 8.7
		}
		local var_839_1 = manager.audio:GetLocalizationFlag()

		if var_839_0[var_839_1] ~= nil then
			arg_839_1.duration_ = var_839_0[var_839_1]
		end

		SetActive(arg_839_1.tipsGo_, false)

		function arg_839_1.onSingleLineFinish_()
			arg_839_1.onSingleLineUpdate_ = nil
			arg_839_1.onSingleLineFinish_ = nil
			arg_839_1.state_ = "waiting"
			arg_839_1.auto_ = false
		end

		function arg_839_1.playNext_(arg_841_0)
			arg_839_1.onStoryFinished_()
		end

		function arg_839_1.onSingleLineUpdate_(arg_842_0)
			local var_842_0 = arg_839_1.actors_["102003ui_story"].transform
			local var_842_1 = 0

			if var_842_1 < arg_839_1.time_ and arg_839_1.time_ <= var_842_1 + arg_842_0 then
				arg_839_1.var_.moveOldPos102003ui_story = var_842_0.localPosition
			end

			local var_842_2 = 0.001

			if var_842_1 <= arg_839_1.time_ and arg_839_1.time_ < var_842_1 + var_842_2 then
				local var_842_3 = (arg_839_1.time_ - var_842_1) / var_842_2
				local var_842_4 = Vector3.New(0, -0.85, -6.21)

				var_842_0.localPosition = Vector3.Lerp(arg_839_1.var_.moveOldPos102003ui_story, var_842_4, var_842_3)

				local var_842_5 = manager.ui.mainCamera.transform.position - var_842_0.position

				var_842_0.forward = Vector3.New(var_842_5.x, var_842_5.y, var_842_5.z)

				local var_842_6 = var_842_0.localEulerAngles

				var_842_6.z = 0
				var_842_6.x = 0
				var_842_0.localEulerAngles = var_842_6
			end

			if arg_839_1.time_ >= var_842_1 + var_842_2 and arg_839_1.time_ < var_842_1 + var_842_2 + arg_842_0 then
				var_842_0.localPosition = Vector3.New(0, -0.85, -6.21)

				local var_842_7 = manager.ui.mainCamera.transform.position - var_842_0.position

				var_842_0.forward = Vector3.New(var_842_7.x, var_842_7.y, var_842_7.z)

				local var_842_8 = var_842_0.localEulerAngles

				var_842_8.z = 0
				var_842_8.x = 0
				var_842_0.localEulerAngles = var_842_8
			end

			local var_842_9 = arg_839_1.actors_["102003ui_story"]
			local var_842_10 = 0

			if var_842_10 < arg_839_1.time_ and arg_839_1.time_ <= var_842_10 + arg_842_0 and not isNil(var_842_9) and arg_839_1.var_.characterEffect102003ui_story == nil then
				arg_839_1.var_.characterEffect102003ui_story = var_842_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_842_11 = 0.200000002980232

			if var_842_10 <= arg_839_1.time_ and arg_839_1.time_ < var_842_10 + var_842_11 and not isNil(var_842_9) then
				local var_842_12 = (arg_839_1.time_ - var_842_10) / var_842_11

				if arg_839_1.var_.characterEffect102003ui_story and not isNil(var_842_9) then
					arg_839_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_839_1.time_ >= var_842_10 + var_842_11 and arg_839_1.time_ < var_842_10 + var_842_11 + arg_842_0 and not isNil(var_842_9) and arg_839_1.var_.characterEffect102003ui_story then
				arg_839_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_842_13 = 0

			if var_842_13 < arg_839_1.time_ and arg_839_1.time_ <= var_842_13 + arg_842_0 then
				arg_839_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action439")
			end

			local var_842_14 = 0

			if var_842_14 < arg_839_1.time_ and arg_839_1.time_ <= var_842_14 + arg_842_0 then
				arg_839_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_842_15 = 0
			local var_842_16 = 0.55

			if var_842_15 < arg_839_1.time_ and arg_839_1.time_ <= var_842_15 + arg_842_0 then
				arg_839_1.talkMaxDuration = 0
				arg_839_1.dialogCg_.alpha = 1

				arg_839_1.dialog_:SetActive(true)
				SetActive(arg_839_1.leftNameGo_, true)

				local var_842_17 = arg_839_1:FormatText(StoryNameCfg[613].name)

				arg_839_1.leftNameTxt_.text = var_842_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_839_1.leftNameTxt_.transform)

				arg_839_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_839_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_839_1:RecordName(arg_839_1.leftNameTxt_.text)
				SetActive(arg_839_1.iconTrs_.gameObject, false)
				arg_839_1.callingController_:SetSelectedState("normal")

				local var_842_18 = arg_839_1:GetWordFromCfg(924041200)
				local var_842_19 = arg_839_1:FormatText(var_842_18.content)

				arg_839_1.text_.text = var_842_19

				LuaForUtil.ClearLinePrefixSymbol(arg_839_1.text_)

				local var_842_20 = 22
				local var_842_21 = utf8.len(var_842_19)
				local var_842_22 = var_842_20 <= 0 and var_842_16 or var_842_16 * (var_842_21 / var_842_20)

				if var_842_22 > 0 and var_842_16 < var_842_22 then
					arg_839_1.talkMaxDuration = var_842_22

					if var_842_22 + var_842_15 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_22 + var_842_15
					end
				end

				arg_839_1.text_.text = var_842_19
				arg_839_1.typewritter.percent = 0

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb") ~= 0 then
					local var_842_23 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb") / 1000

					if var_842_23 + var_842_15 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_23 + var_842_15
					end

					if var_842_18.prefab_name ~= "" and arg_839_1.actors_[var_842_18.prefab_name] ~= nil then
						local var_842_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_839_1.actors_[var_842_18.prefab_name].transform, "story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb")

						arg_839_1:RecordAudio("924041200", var_842_24)
						arg_839_1:RecordAudio("924041200", var_842_24)
					else
						arg_839_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb")
					end

					arg_839_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb")
				end

				arg_839_1:RecordContent(arg_839_1.text_.text)
			end

			local var_842_25 = math.max(var_842_16, arg_839_1.talkMaxDuration)

			if var_842_15 <= arg_839_1.time_ and arg_839_1.time_ < var_842_15 + var_842_25 then
				arg_839_1.typewritter.percent = (arg_839_1.time_ - var_842_15) / var_842_25

				arg_839_1.typewritter:SetDirty()
			end

			if arg_839_1.time_ >= var_842_15 + var_842_25 and arg_839_1.time_ < var_842_15 + var_842_25 + arg_842_0 then
				arg_839_1.typewritter.percent = 1

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(true)
			end
		end

		arg_839_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_839_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/X204_g",
		"TextureConfig/Background/ST0107",
		"TextureConfig/Background/SP92401",
		"TextureConfig/Background/SP92401b",
		"TextureConfig/Background/X204_f",
		"TextureConfig/Background/X204_h"
	},
	voices = {
		"story_v_side_old_924041.awb"
	}
}
