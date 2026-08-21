return {
	Play122011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = (arg_1_1.time_ - var_4_0) / var_4_1
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(1, 0, var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)
				local var_4_5 = 0

				arg_1_1.mask_.enabled = false
				var_4_4.a = var_4_5
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_6 = "STblack"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = 0

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_9 = manager.ui.mainCamera.transform.localPosition
				local var_4_10 = Vector3.New(0, 0, 10) + Vector3.New(var_4_9.x, var_4_9.y, 0)
				local var_4_11 = arg_1_1.bgs_.STblack

				var_4_11.transform.localPosition = var_4_10
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = (var_4_11.transform.localPosition - var_4_9).z
					local var_4_14 = manager.ui.mainCameraCom_
					local var_4_15 = 2 * var_4_13 * Mathf.Tan(var_4_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_16 = var_4_15 * var_4_14.aspect
					local var_4_17 = var_4_12.sprite.bounds.size.x
					local var_4_18 = var_4_12.sprite.bounds.size.y
					local var_4_19 = var_4_16 / var_4_17
					local var_4_20 = var_4_15 / var_4_18
					local var_4_21 = var_4_20 < var_4_19 and var_4_19 or var_4_20

					var_4_11.transform.localScale = Vector3.New(var_4_21, var_4_21, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_28 = 0
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "effect"

				arg_1_1:AudioAction(var_4_30, var_4_31, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 2
			local var_4_33 = 0.25

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_35 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_35

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

				local var_4_36 = arg_1_1:GetWordFromCfg(122011001)
				local var_4_37 = arg_1_1:FormatText(var_4_36.content)

				arg_1_1.text_.text = var_4_37

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 10
				local var_4_39 = utf8.len(var_4_37)
				local var_4_40 = var_4_38 <= 0 and var_4_33 or var_4_33 * (var_4_39 / var_4_38)

				if var_4_40 > 0 and var_4_33 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_32 = var_4_32 + 0.3

					if var_4_40 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_37
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_32 + 0.3
			local var_4_42 = math.max(var_4_33, arg_1_1.talkMaxDuration)

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
	Play122011002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 122011002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play122011003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.625

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

				local var_11_2 = arg_8_1:GetWordFromCfg(122011002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 65
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
	Play122011003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 122011003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play122011004(arg_12_1)
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

				local var_15_2 = arg_12_1:GetWordFromCfg(122011003)
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
	Play122011004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 122011004
		arg_16_1.duration_ = 7

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play122011005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "XH0204"

			if arg_16_1.bgs_[var_19_0] == nil then
				local var_19_1 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_0)
				var_19_1.name = var_19_0
				var_19_1.transform.parent = arg_16_1.stage_.transform
				var_19_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_0] = var_19_1
			end

			local var_19_2 = 0

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				local var_19_3 = manager.ui.mainCamera.transform.localPosition
				local var_19_4 = Vector3.New(0, 0, 10) + Vector3.New(var_19_3.x, var_19_3.y, 0)
				local var_19_5 = arg_16_1.bgs_.XH0204

				var_19_5.transform.localPosition = var_19_4
				var_19_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_6 = var_19_5:GetComponent("SpriteRenderer")

				if var_19_6 and var_19_6.sprite then
					local var_19_7 = (var_19_5.transform.localPosition - var_19_3).z
					local var_19_8 = manager.ui.mainCameraCom_
					local var_19_9 = 2 * var_19_7 * Mathf.Tan(var_19_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_10 = var_19_9 * var_19_8.aspect
					local var_19_11 = var_19_6.sprite.bounds.size.x
					local var_19_12 = var_19_6.sprite.bounds.size.y
					local var_19_13 = var_19_10 / var_19_11
					local var_19_14 = var_19_9 / var_19_12
					local var_19_15 = var_19_14 < var_19_13 and var_19_13 or var_19_14

					var_19_5.transform.localScale = Vector3.New(var_19_15, var_19_15, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "XH0204" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_17 = 2

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Color.New(0, 0, 0)

				var_19_19.a = Mathf.Lerp(1, 0, var_19_18)
				arg_16_1.mask_.color = var_19_19
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				local var_19_20 = Color.New(0, 0, 0)
				local var_19_21 = 0

				arg_16_1.mask_.enabled = false
				var_19_20.a = var_19_21
				arg_16_1.mask_.color = var_19_20
			end

			local var_19_22 = 2

			if var_19_22 < arg_16_1.time_ and arg_16_1.time_ <= var_19_22 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_23 = 2

			if arg_16_1.time_ >= var_19_22 + var_19_23 and arg_16_1.time_ < var_19_22 + var_19_23 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_24 = "XH0204_blur"

			if arg_16_1.bgs_[var_19_24] == nil then
				local var_19_25 = Object.Instantiate(arg_16_1.blurPaintGo_)
				local var_19_26 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_24)

				var_19_25:GetComponent("SpriteRenderer").sprite = var_19_26
				var_19_25.name = var_19_24
				var_19_25.transform.parent = arg_16_1.stage_.transform
				var_19_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_24] = var_19_25
			end

			local var_19_27 = 0
			local var_19_28 = arg_16_1.bgs_[var_19_24]

			if var_19_27 < arg_16_1.time_ and arg_16_1.time_ <= var_19_27 + arg_19_0 then
				local var_19_29 = manager.ui.mainCamera.transform.localPosition
				local var_19_30 = Vector3.New(0, 0, 10) + Vector3.New(var_19_29.x, var_19_29.y, 0)

				var_19_28.transform.localPosition = var_19_30
				var_19_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_31 = var_19_28:GetComponent("SpriteRenderer")

				if var_19_31 and var_19_31.sprite then
					local var_19_32 = (var_19_28.transform.localPosition - var_19_29).z
					local var_19_33 = manager.ui.mainCameraCom_
					local var_19_34 = 2 * var_19_32 * Mathf.Tan(var_19_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_35 = var_19_34 * var_19_33.aspect
					local var_19_36 = var_19_31.sprite.bounds.size.x
					local var_19_37 = var_19_31.sprite.bounds.size.y
					local var_19_38 = var_19_35 / var_19_36
					local var_19_39 = var_19_34 / var_19_37
					local var_19_40 = var_19_39 < var_19_38 and var_19_38 or var_19_39

					var_19_28.transform.localScale = Vector3.New(var_19_40, var_19_40, 0)
				end
			end

			local var_19_41 = 2.000000000002

			if var_19_27 <= arg_16_1.time_ and arg_16_1.time_ < var_19_27 + var_19_41 then
				local var_19_42 = (arg_16_1.time_ - var_19_27) / var_19_41
				local var_19_43 = Color.New(1, 1, 1)

				var_19_43.a = Mathf.Lerp(0, 1, var_19_42)

				var_19_28:GetComponent("SpriteRenderer").material:SetColor("_Color", var_19_43)
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_44 = 1.999999999998
			local var_19_45 = 0.725

			if var_19_44 < arg_16_1.time_ and arg_16_1.time_ <= var_19_44 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_46 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_46:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_47 = arg_16_1:GetWordFromCfg(122011004)
				local var_19_48 = arg_16_1:FormatText(var_19_47.content)

				arg_16_1.text_.text = var_19_48

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_49 = 29
				local var_19_50 = utf8.len(var_19_48)
				local var_19_51 = var_19_49 <= 0 and var_19_45 or var_19_45 * (var_19_50 / var_19_49)

				if var_19_51 > 0 and var_19_45 < var_19_51 then
					arg_16_1.talkMaxDuration = var_19_51
					var_19_44 = var_19_44 + 0.3

					if var_19_51 + var_19_44 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_51 + var_19_44
					end
				end

				arg_16_1.text_.text = var_19_48
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_52 = var_19_44 + 0.3
			local var_19_53 = math.max(var_19_45, arg_16_1.talkMaxDuration)

			if var_19_52 <= arg_16_1.time_ and arg_16_1.time_ < var_19_52 + var_19_53 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_52) / var_19_53

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_52 + var_19_53 and arg_16_1.time_ < var_19_52 + var_19_53 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play122011005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 122011005
		arg_22_1.duration_ = 9

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play122011006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "XH0508a"

			if arg_22_1.bgs_[var_25_0] == nil then
				local var_25_1 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_0)
				var_25_1.name = var_25_0
				var_25_1.transform.parent = arg_22_1.stage_.transform
				var_25_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_0] = var_25_1
			end

			local var_25_2 = 2

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = manager.ui.mainCamera.transform.localPosition
				local var_25_4 = Vector3.New(0, 0, 10) + Vector3.New(var_25_3.x, var_25_3.y, 0)
				local var_25_5 = arg_22_1.bgs_.XH0508a

				var_25_5.transform.localPosition = var_25_4
				var_25_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_6 = var_25_5:GetComponent("SpriteRenderer")

				if var_25_6 and var_25_6.sprite then
					local var_25_7 = (var_25_5.transform.localPosition - var_25_3).z
					local var_25_8 = manager.ui.mainCameraCom_
					local var_25_9 = 2 * var_25_7 * Mathf.Tan(var_25_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_10 = var_25_9 * var_25_8.aspect
					local var_25_11 = var_25_6.sprite.bounds.size.x
					local var_25_12 = var_25_6.sprite.bounds.size.y
					local var_25_13 = var_25_10 / var_25_11
					local var_25_14 = var_25_9 / var_25_12
					local var_25_15 = var_25_14 < var_25_13 and var_25_13 or var_25_14

					var_25_5.transform.localScale = Vector3.New(var_25_15, var_25_15, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "XH0508a" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_16 = 0

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_17 = 2

			if var_25_16 <= arg_22_1.time_ and arg_22_1.time_ < var_25_16 + var_25_17 then
				local var_25_18 = (arg_22_1.time_ - var_25_16) / var_25_17
				local var_25_19 = Color.New(0, 0, 0)

				var_25_19.a = Mathf.Lerp(0, 1, var_25_18)
				arg_22_1.mask_.color = var_25_19
			end

			if arg_22_1.time_ >= var_25_16 + var_25_17 and arg_22_1.time_ < var_25_16 + var_25_17 + arg_25_0 then
				local var_25_20 = Color.New(0, 0, 0)

				var_25_20.a = 1
				arg_22_1.mask_.color = var_25_20
			end

			local var_25_21 = 2

			if var_25_21 < arg_22_1.time_ and arg_22_1.time_ <= var_25_21 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_22 = 2

			if var_25_21 <= arg_22_1.time_ and arg_22_1.time_ < var_25_21 + var_25_22 then
				local var_25_23 = (arg_22_1.time_ - var_25_21) / var_25_22
				local var_25_24 = Color.New(0, 0, 0)

				var_25_24.a = Mathf.Lerp(1, 0, var_25_23)
				arg_22_1.mask_.color = var_25_24
			end

			if arg_22_1.time_ >= var_25_21 + var_25_22 and arg_22_1.time_ < var_25_21 + var_25_22 + arg_25_0 then
				local var_25_25 = Color.New(0, 0, 0)
				local var_25_26 = 0

				arg_22_1.mask_.enabled = false
				var_25_25.a = var_25_26
				arg_22_1.mask_.color = var_25_25
			end

			local var_25_27 = 3.999999999999

			if var_25_27 < arg_22_1.time_ and arg_22_1.time_ <= var_25_27 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			local var_25_28 = 2.000000000001

			if arg_22_1.time_ >= var_25_27 + var_25_28 and arg_22_1.time_ < var_25_27 + var_25_28 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_29 = "XH0508a_blur"

			if arg_22_1.bgs_[var_25_29] == nil then
				local var_25_30 = Object.Instantiate(arg_22_1.blurPaintGo_)
				local var_25_31 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_29)

				var_25_30:GetComponent("SpriteRenderer").sprite = var_25_31
				var_25_30.name = var_25_29
				var_25_30.transform.parent = arg_22_1.stage_.transform
				var_25_30.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_29] = var_25_30
			end

			local var_25_32 = 1.999999999998
			local var_25_33 = arg_22_1.bgs_[var_25_29]

			if var_25_32 < arg_22_1.time_ and arg_22_1.time_ <= var_25_32 + arg_25_0 then
				local var_25_34 = manager.ui.mainCamera.transform.localPosition
				local var_25_35 = Vector3.New(0, 0, 10) + Vector3.New(var_25_34.x, var_25_34.y, 0)

				var_25_33.transform.localPosition = var_25_35
				var_25_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_36 = var_25_33:GetComponent("SpriteRenderer")

				if var_25_36 and var_25_36.sprite then
					local var_25_37 = (var_25_33.transform.localPosition - var_25_34).z
					local var_25_38 = manager.ui.mainCameraCom_
					local var_25_39 = 2 * var_25_37 * Mathf.Tan(var_25_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_40 = var_25_39 * var_25_38.aspect
					local var_25_41 = var_25_36.sprite.bounds.size.x
					local var_25_42 = var_25_36.sprite.bounds.size.y
					local var_25_43 = var_25_40 / var_25_41
					local var_25_44 = var_25_39 / var_25_42
					local var_25_45 = var_25_44 < var_25_43 and var_25_43 or var_25_44

					var_25_33.transform.localScale = Vector3.New(var_25_45, var_25_45, 0)
				end
			end

			local var_25_46 = 2.000000000001

			if var_25_32 <= arg_22_1.time_ and arg_22_1.time_ < var_25_32 + var_25_46 then
				local var_25_47 = (arg_22_1.time_ - var_25_32) / var_25_46
				local var_25_48 = Color.New(1, 1, 1)

				var_25_48.a = Mathf.Lerp(0, 1, var_25_47)

				var_25_33:GetComponent("SpriteRenderer").material:SetColor("_Color", var_25_48)
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_49 = 3.999999999999
			local var_25_50 = 0.725

			if var_25_49 < arg_22_1.time_ and arg_22_1.time_ <= var_25_49 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_51 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_51:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_52 = arg_22_1:GetWordFromCfg(122011005)
				local var_25_53 = arg_22_1:FormatText(var_25_52.content)

				arg_22_1.text_.text = var_25_53

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_54 = 29
				local var_25_55 = utf8.len(var_25_53)
				local var_25_56 = var_25_54 <= 0 and var_25_50 or var_25_50 * (var_25_55 / var_25_54)

				if var_25_56 > 0 and var_25_50 < var_25_56 then
					arg_22_1.talkMaxDuration = var_25_56
					var_25_49 = var_25_49 + 0.3

					if var_25_56 + var_25_49 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_56 + var_25_49
					end
				end

				arg_22_1.text_.text = var_25_53
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_57 = var_25_49 + 0.3
			local var_25_58 = math.max(var_25_50, arg_22_1.talkMaxDuration)

			if var_25_57 <= arg_22_1.time_ and arg_22_1.time_ < var_25_57 + var_25_58 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_57) / var_25_58

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_57 + var_25_58 and arg_22_1.time_ < var_25_57 + var_25_58 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play122011006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 122011006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play122011007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.bgs_.XH0508a
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				local var_31_2 = var_31_0:GetComponent("SpriteRenderer")

				if var_31_2 then
					arg_28_1.var_.alphaOldValueXH0508a = var_31_2.color.a
					arg_28_1.var_.alphaMatValueXH0508a = var_31_2
				end

				arg_28_1.var_.alphaOldValueXH0508a = 1
			end

			local var_31_3 = 0.6

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_3 then
				local var_31_4 = (arg_28_1.time_ - var_31_1) / var_31_3
				local var_31_5 = Mathf.Lerp(arg_28_1.var_.alphaOldValueXH0508a, 0, var_31_4)

				if arg_28_1.var_.alphaMatValueXH0508a then
					local var_31_6 = arg_28_1.var_.alphaMatValueXH0508a.color

					var_31_6.a = var_31_5
					arg_28_1.var_.alphaMatValueXH0508a.color = var_31_6
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_3 and arg_28_1.time_ < var_31_1 + var_31_3 + arg_31_0 and arg_28_1.var_.alphaMatValueXH0508a then
				local var_31_7 = arg_28_1.var_.alphaMatValueXH0508a
				local var_31_8 = var_31_7.color

				var_31_8.a = 0
				var_31_7.color = var_31_8
			end

			local var_31_9 = 0
			local var_31_10 = 0.6

			if var_31_9 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_11 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_12 = arg_28_1:GetWordFromCfg(122011006)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_14 = 24
				local var_31_15 = utf8.len(var_31_13)
				local var_31_16 = var_31_14 <= 0 and var_31_10 or var_31_10 * (var_31_15 / var_31_14)

				if var_31_16 > 0 and var_31_10 < var_31_16 then
					arg_28_1.talkMaxDuration = var_31_16

					if var_31_16 + var_31_9 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_9
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_17 = math.max(var_31_10, arg_28_1.talkMaxDuration)

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_17 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_9) / var_31_17

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_9 + var_31_17 and arg_28_1.time_ < var_31_9 + var_31_17 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play122011007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 122011007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play122011008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.9

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

				local var_35_2 = arg_32_1:GetWordFromCfg(122011007)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 36
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
	Play122011008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 122011008
		arg_36_1.duration_ = 11.4

		local var_36_0 = {
			ja = 11.399999999999,
			ko = 4.299999999999,
			zh = 4.299999999999
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
				arg_36_0:Play122011009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "J10i"

			if arg_36_1.bgs_[var_39_0] == nil then
				local var_39_1 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_39_0)
				var_39_1.name = var_39_0
				var_39_1.transform.parent = arg_36_1.stage_.transform
				var_39_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_[var_39_0] = var_39_1
			end

			local var_39_2 = 0

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				local var_39_3 = manager.ui.mainCamera.transform.localPosition
				local var_39_4 = Vector3.New(0, 0, 10) + Vector3.New(var_39_3.x, var_39_3.y, 0)
				local var_39_5 = arg_36_1.bgs_.J10i

				var_39_5.transform.localPosition = var_39_4
				var_39_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_6 = var_39_5:GetComponent("SpriteRenderer")

				if var_39_6 and var_39_6.sprite then
					local var_39_7 = (var_39_5.transform.localPosition - var_39_3).z
					local var_39_8 = manager.ui.mainCameraCom_
					local var_39_9 = 2 * var_39_7 * Mathf.Tan(var_39_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_39_10 = var_39_9 * var_39_8.aspect
					local var_39_11 = var_39_6.sprite.bounds.size.x
					local var_39_12 = var_39_6.sprite.bounds.size.y
					local var_39_13 = var_39_10 / var_39_11
					local var_39_14 = var_39_9 / var_39_12
					local var_39_15 = var_39_14 < var_39_13 and var_39_13 or var_39_14

					var_39_5.transform.localScale = Vector3.New(var_39_15, var_39_15, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "J10i" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_16 = 0

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_17 = 2

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_17 then
				local var_39_18 = (arg_36_1.time_ - var_39_16) / var_39_17
				local var_39_19 = Color.New(1, 1, 1)

				var_39_19.a = Mathf.Lerp(1, 0, var_39_18)
				arg_36_1.mask_.color = var_39_19
			end

			if arg_36_1.time_ >= var_39_16 + var_39_17 and arg_36_1.time_ < var_39_16 + var_39_17 + arg_39_0 then
				local var_39_20 = Color.New(1, 1, 1)
				local var_39_21 = 0

				arg_36_1.mask_.enabled = false
				var_39_20.a = var_39_21
				arg_36_1.mask_.color = var_39_20
			end

			local var_39_22 = 0
			local var_39_23 = 0.8

			if var_39_22 < arg_36_1.time_ and arg_36_1.time_ <= var_39_22 + arg_39_0 then
				local var_39_24 = "play"
				local var_39_25 = "music"

				arg_36_1:AudioAction(var_39_24, var_39_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_39_26 = ""
				local var_39_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_39_27 ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_27 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_27

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_27
						arg_36_1.bgmTxt2_.text = var_39_27
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_39_28 = 1.324999999999
			local var_39_29 = 1

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				local var_39_30 = "play"
				local var_39_31 = "music"

				arg_36_1:AudioAction(var_39_30, var_39_31, "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city.awb")

				local var_39_32 = ""
				local var_39_33 = manager.audio:GetAudioName("bgm_activity_2_1_story_city", "bgm_activity_2_1_story_city")

				if var_39_33 ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_33 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_33

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_33
						arg_36_1.bgmTxt2_.text = var_39_33
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_39_34 = 0
			local var_39_35 = 1

			if var_39_34 < arg_36_1.time_ and arg_36_1.time_ <= var_39_34 + arg_39_0 then
				local var_39_36 = "stop"
				local var_39_37 = "effect"

				arg_36_1:AudioAction(var_39_36, var_39_37, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_38 = 1.999999999999
			local var_39_39 = 0.325

			if var_39_38 < arg_36_1.time_ and arg_36_1.time_ <= var_39_38 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_40 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_40:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_36_1.dialogCg_.alpha = arg_42_0
				end))
				var_39_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_41 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_42 = arg_36_1:GetWordFromCfg(122011008)
				local var_39_43 = arg_36_1:FormatText(var_39_42.content)

				arg_36_1.text_.text = var_39_43

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_44 = 13
				local var_39_45 = utf8.len(var_39_43)
				local var_39_46 = var_39_44 <= 0 and var_39_39 or var_39_39 * (var_39_45 / var_39_44)

				if var_39_46 > 0 and var_39_39 < var_39_46 then
					arg_36_1.talkMaxDuration = var_39_46
					var_39_38 = var_39_38 + 0.3

					if var_39_46 + var_39_38 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_46 + var_39_38
					end
				end

				arg_36_1.text_.text = var_39_43
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122011", "122011008", "story_v_out_122011.awb") ~= 0 then
					local var_39_47 = manager.audio:GetVoiceLength("story_v_out_122011", "122011008", "story_v_out_122011.awb") / 1000

					if var_39_47 + var_39_38 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_47 + var_39_38
					end

					if var_39_42.prefab_name ~= "" and arg_36_1.actors_[var_39_42.prefab_name] ~= nil then
						local var_39_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_42.prefab_name].transform, "story_v_out_122011", "122011008", "story_v_out_122011.awb")

						arg_36_1:RecordAudio("122011008", var_39_48)
						arg_36_1:RecordAudio("122011008", var_39_48)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_122011", "122011008", "story_v_out_122011.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_122011", "122011008", "story_v_out_122011.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_49 = var_39_38 + 0.3
			local var_39_50 = math.max(var_39_39, arg_36_1.talkMaxDuration)

			if var_39_49 <= arg_36_1.time_ and arg_36_1.time_ < var_39_49 + var_39_50 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_49) / var_39_50

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_49 + var_39_50 and arg_36_1.time_ < var_39_49 + var_39_50 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play122011009 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 122011009
		arg_44_1.duration_ = 5.9

		local var_44_0 = {
			ja = 5.9,
			ko = 3.433,
			zh = 3.433
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
				arg_44_0:Play122011010(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.3

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[384].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(122011009)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 12
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122011", "122011009", "story_v_out_122011.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_122011", "122011009", "story_v_out_122011.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_122011", "122011009", "story_v_out_122011.awb")

						arg_44_1:RecordAudio("122011009", var_47_9)
						arg_44_1:RecordAudio("122011009", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_122011", "122011009", "story_v_out_122011.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_122011", "122011009", "story_v_out_122011.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play122011010 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 122011010
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play122011011(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.45

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(122011010)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 58
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play122011011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 122011011
		arg_52_1.duration_ = 8.1

		local var_52_0 = {
			ja = 8.1,
			ko = 4,
			zh = 4
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play122011012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "1184ui_story"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_52_1.stage_.transform)

					var_55_2.name = var_55_0
					var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_0] = var_55_2

					local var_55_3 = var_55_2:GetComponentInChildren(typeof(CharacterEffect))

					var_55_3.enabled = true

					local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_2, typeof(DynamicBoneHelper))

					if var_55_4 then
						var_55_4:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_3.transform, false)

					arg_52_1.var_[var_55_0 .. "Animator"] = var_55_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_0 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_0 .. "LipSync"] = var_55_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_5 = arg_52_1.actors_["1184ui_story"].transform
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.var_.moveOldPos1184ui_story = var_55_5.localPosition
			end

			local var_55_7 = 0.001

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7
				local var_55_9 = Vector3.New(0, -0.97, -6)

				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1184ui_story, var_55_9, var_55_8)

				local var_55_10 = manager.ui.mainCamera.transform.position - var_55_5.position

				var_55_5.forward = Vector3.New(var_55_10.x, var_55_10.y, var_55_10.z)

				local var_55_11 = var_55_5.localEulerAngles

				var_55_11.z = 0
				var_55_11.x = 0
				var_55_5.localEulerAngles = var_55_11
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_55_12 = manager.ui.mainCamera.transform.position - var_55_5.position

				var_55_5.forward = Vector3.New(var_55_12.x, var_55_12.y, var_55_12.z)

				local var_55_13 = var_55_5.localEulerAngles

				var_55_13.z = 0
				var_55_13.x = 0
				var_55_5.localEulerAngles = var_55_13
			end

			local var_55_14 = arg_52_1.actors_["1184ui_story"]
			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 and not isNil(var_55_14) and arg_52_1.var_.characterEffect1184ui_story == nil then
				arg_52_1.var_.characterEffect1184ui_story = var_55_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_16 = 0.200000002980232

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_16 and not isNil(var_55_14) then
				local var_55_17 = (arg_52_1.time_ - var_55_15) / var_55_16

				if arg_52_1.var_.characterEffect1184ui_story and not isNil(var_55_14) then
					arg_52_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_15 + var_55_16 and arg_52_1.time_ < var_55_15 + var_55_16 + arg_55_0 and not isNil(var_55_14) and arg_52_1.var_.characterEffect1184ui_story then
				arg_52_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_55_20 = 0
			local var_55_21 = 0.35

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_22 = arg_52_1:FormatText(StoryNameCfg[6].name)

				arg_52_1.leftNameTxt_.text = var_55_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_23 = arg_52_1:GetWordFromCfg(122011011)
				local var_55_24 = arg_52_1:FormatText(var_55_23.content)

				arg_52_1.text_.text = var_55_24

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_25 = 14
				local var_55_26 = utf8.len(var_55_24)
				local var_55_27 = var_55_25 <= 0 and var_55_21 or var_55_21 * (var_55_26 / var_55_25)

				if var_55_27 > 0 and var_55_21 < var_55_27 then
					arg_52_1.talkMaxDuration = var_55_27

					if var_55_27 + var_55_20 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_27 + var_55_20
					end
				end

				arg_52_1.text_.text = var_55_24
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122011", "122011011", "story_v_out_122011.awb") ~= 0 then
					local var_55_28 = manager.audio:GetVoiceLength("story_v_out_122011", "122011011", "story_v_out_122011.awb") / 1000

					if var_55_28 + var_55_20 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_20
					end

					if var_55_23.prefab_name ~= "" and arg_52_1.actors_[var_55_23.prefab_name] ~= nil then
						local var_55_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_23.prefab_name].transform, "story_v_out_122011", "122011011", "story_v_out_122011.awb")

						arg_52_1:RecordAudio("122011011", var_55_29)
						arg_52_1:RecordAudio("122011011", var_55_29)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_122011", "122011011", "story_v_out_122011.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_122011", "122011011", "story_v_out_122011.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_30 = math.max(var_55_21, arg_52_1.talkMaxDuration)

			if var_55_20 <= arg_52_1.time_ and arg_52_1.time_ < var_55_20 + var_55_30 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_20) / var_55_30

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_20 + var_55_30 and arg_52_1.time_ < var_55_20 + var_55_30 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play122011012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 122011012
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play122011013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1184ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1184ui_story == nil then
				arg_56_1.var_.characterEffect1184ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1184ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1184ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1184ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1184ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.4

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(122011012)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 16
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play122011013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 122011013
		arg_60_1.duration_ = 8.57

		local var_60_0 = {
			ja = 8.566,
			ko = 2.133,
			zh = 2.133
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
				arg_60_0:Play122011014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1184ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1184ui_story == nil then
				arg_60_1.var_.characterEffect1184ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1184ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1184ui_story then
				arg_60_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_63_4 = 0

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_63_6 = "1071ui_story"

			if arg_60_1.actors_[var_63_6] == nil then
				local var_63_7 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_63_7) then
					local var_63_8 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_60_1.stage_.transform)

					var_63_8.name = var_63_6
					var_63_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_6] = var_63_8

					local var_63_9 = var_63_8:GetComponentInChildren(typeof(CharacterEffect))

					var_63_9.enabled = true

					local var_63_10 = GameObjectTools.GetOrAddComponent(var_63_8, typeof(DynamicBoneHelper))

					if var_63_10 then
						var_63_10:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_9.transform, false)

					arg_60_1.var_[var_63_6 .. "Animator"] = var_63_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_6 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_6 .. "LipSync"] = var_63_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_63_12 = 0
			local var_63_13 = 0.3

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(122011013)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 12
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122011", "122011013", "story_v_out_122011.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_122011", "122011013", "story_v_out_122011.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_122011", "122011013", "story_v_out_122011.awb")

						arg_60_1:RecordAudio("122011013", var_63_21)
						arg_60_1:RecordAudio("122011013", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_122011", "122011013", "story_v_out_122011.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_122011", "122011013", "story_v_out_122011.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play122011014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 122011014
		arg_64_1.duration_ = 7.07

		local var_64_0 = {
			ja = 7.066,
			ko = 3.8,
			zh = 3.8
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
				arg_64_0:Play122011015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1184ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1184ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1184ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1184ui_story"]
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1184ui_story == nil then
				arg_64_1.var_.characterEffect1184ui_story = var_67_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 and not isNil(var_67_9) then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11

				if arg_64_1.var_.characterEffect1184ui_story and not isNil(var_67_9) then
					local var_67_13 = Mathf.Lerp(0, 0.5, var_67_12)

					arg_64_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1184ui_story.fillRatio = var_67_13
				end
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1184ui_story then
				local var_67_14 = 0.5

				arg_64_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1184ui_story.fillRatio = var_67_14
			end

			local var_67_15 = arg_64_1.actors_["1071ui_story"].transform
			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1.var_.moveOldPos1071ui_story = var_67_15.localPosition
			end

			local var_67_17 = 0.001

			if var_67_16 <= arg_64_1.time_ and arg_64_1.time_ < var_67_16 + var_67_17 then
				local var_67_18 = (arg_64_1.time_ - var_67_16) / var_67_17
				local var_67_19 = Vector3.New(0, -1.05, -6.2)

				var_67_15.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1071ui_story, var_67_19, var_67_18)

				local var_67_20 = manager.ui.mainCamera.transform.position - var_67_15.position

				var_67_15.forward = Vector3.New(var_67_20.x, var_67_20.y, var_67_20.z)

				local var_67_21 = var_67_15.localEulerAngles

				var_67_21.z = 0
				var_67_21.x = 0
				var_67_15.localEulerAngles = var_67_21
			end

			if arg_64_1.time_ >= var_67_16 + var_67_17 and arg_64_1.time_ < var_67_16 + var_67_17 + arg_67_0 then
				var_67_15.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_67_22 = manager.ui.mainCamera.transform.position - var_67_15.position

				var_67_15.forward = Vector3.New(var_67_22.x, var_67_22.y, var_67_22.z)

				local var_67_23 = var_67_15.localEulerAngles

				var_67_23.z = 0
				var_67_23.x = 0
				var_67_15.localEulerAngles = var_67_23
			end

			local var_67_24 = arg_64_1.actors_["1071ui_story"]
			local var_67_25 = 0

			if var_67_25 < arg_64_1.time_ and arg_64_1.time_ <= var_67_25 + arg_67_0 and not isNil(var_67_24) and arg_64_1.var_.characterEffect1071ui_story == nil then
				arg_64_1.var_.characterEffect1071ui_story = var_67_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_26 = 0.200000002980232

			if var_67_25 <= arg_64_1.time_ and arg_64_1.time_ < var_67_25 + var_67_26 and not isNil(var_67_24) then
				local var_67_27 = (arg_64_1.time_ - var_67_25) / var_67_26

				if arg_64_1.var_.characterEffect1071ui_story and not isNil(var_67_24) then
					arg_64_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_25 + var_67_26 and arg_64_1.time_ < var_67_25 + var_67_26 + arg_67_0 and not isNil(var_67_24) and arg_64_1.var_.characterEffect1071ui_story then
				arg_64_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_67_28 = 0

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 then
				arg_64_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_67_29 = 0
			local var_67_30 = 1

			if var_67_29 < arg_64_1.time_ and arg_64_1.time_ <= var_67_29 + arg_67_0 then
				local var_67_31 = "stop"
				local var_67_32 = "effect"

				arg_64_1:AudioAction(var_67_31, var_67_32, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_67_33 = 0
			local var_67_34 = 0.675

			if var_67_33 < arg_64_1.time_ and arg_64_1.time_ <= var_67_33 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_35 = arg_64_1:FormatText(StoryNameCfg[384].name)

				arg_64_1.leftNameTxt_.text = var_67_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_36 = arg_64_1:GetWordFromCfg(122011014)
				local var_67_37 = arg_64_1:FormatText(var_67_36.content)

				arg_64_1.text_.text = var_67_37

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_38 = 27
				local var_67_39 = utf8.len(var_67_37)
				local var_67_40 = var_67_38 <= 0 and var_67_34 or var_67_34 * (var_67_39 / var_67_38)

				if var_67_40 > 0 and var_67_34 < var_67_40 then
					arg_64_1.talkMaxDuration = var_67_40

					if var_67_40 + var_67_33 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_40 + var_67_33
					end
				end

				arg_64_1.text_.text = var_67_37
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122011", "122011014", "story_v_out_122011.awb") ~= 0 then
					local var_67_41 = manager.audio:GetVoiceLength("story_v_out_122011", "122011014", "story_v_out_122011.awb") / 1000

					if var_67_41 + var_67_33 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_41 + var_67_33
					end

					if var_67_36.prefab_name ~= "" and arg_64_1.actors_[var_67_36.prefab_name] ~= nil then
						local var_67_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_36.prefab_name].transform, "story_v_out_122011", "122011014", "story_v_out_122011.awb")

						arg_64_1:RecordAudio("122011014", var_67_42)
						arg_64_1:RecordAudio("122011014", var_67_42)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_122011", "122011014", "story_v_out_122011.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_122011", "122011014", "story_v_out_122011.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_43 = math.max(var_67_34, arg_64_1.talkMaxDuration)

			if var_67_33 <= arg_64_1.time_ and arg_64_1.time_ < var_67_33 + var_67_43 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_33) / var_67_43

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_33 + var_67_43 and arg_64_1.time_ < var_67_33 + var_67_43 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
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
	Play122011015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 122011015
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play122011016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1071ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1071ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1071ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["1071ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1071ui_story == nil then
				arg_68_1.var_.characterEffect1071ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1071ui_story and not isNil(var_71_9) then
					local var_71_13 = Mathf.Lerp(0, 0.5, var_71_12)

					arg_68_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1071ui_story.fillRatio = var_71_13
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1071ui_story then
				local var_71_14 = 0.5

				arg_68_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1071ui_story.fillRatio = var_71_14
			end

			local var_71_15 = 0
			local var_71_16 = 1.25

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_17 = arg_68_1:GetWordFromCfg(122011015)
				local var_71_18 = arg_68_1:FormatText(var_71_17.content)

				arg_68_1.text_.text = var_71_18

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_19 = 50
				local var_71_20 = utf8.len(var_71_18)
				local var_71_21 = var_71_19 <= 0 and var_71_16 or var_71_16 * (var_71_20 / var_71_19)

				if var_71_21 > 0 and var_71_16 < var_71_21 then
					arg_68_1.talkMaxDuration = var_71_21

					if var_71_21 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_21 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_18
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_22 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_22 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_22

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_22 and arg_68_1.time_ < var_71_15 + var_71_22 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play122011016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 122011016
		arg_72_1.duration_ = 1.83

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play122011017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = manager.ui.mainCamera.transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.shakeOldPos = var_75_0.localPosition
			end

			local var_75_2 = 1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / 0.066
				local var_75_4, var_75_5 = math.modf(var_75_3)

				var_75_0.localPosition = Vector3.New(var_75_5 * 0.13, var_75_5 * 0.13, var_75_5 * 0.13) + arg_72_1.var_.shakeOldPos
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = arg_72_1.var_.shakeOldPos
			end

			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			local var_75_7 = 1

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_8 = 0
			local var_75_9 = 1

			if var_75_8 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				local var_75_10 = "play"
				local var_75_11 = "effect"

				arg_72_1:AudioAction(var_75_10, var_75_11, "se_story_122_01", "se_story_122_01_monsterattack02_loop", "")
			end

			local var_75_12 = 0
			local var_75_13 = 0.075

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_14 = arg_72_1:FormatText(StoryNameCfg[68].name)

				arg_72_1.leftNameTxt_.text = var_75_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2080")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_15 = arg_72_1:GetWordFromCfg(122011016)
				local var_75_16 = arg_72_1:FormatText(var_75_15.content)

				arg_72_1.text_.text = var_75_16

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_17 = 3
				local var_75_18 = utf8.len(var_75_16)
				local var_75_19 = var_75_17 <= 0 and var_75_13 or var_75_13 * (var_75_18 / var_75_17)

				if var_75_19 > 0 and var_75_13 < var_75_19 then
					arg_72_1.talkMaxDuration = var_75_19

					if var_75_19 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_19 + var_75_12
					end
				end

				arg_72_1.text_.text = var_75_16
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122011", "122011016", "story_v_out_122011.awb") ~= 0 then
					local var_75_20 = manager.audio:GetVoiceLength("story_v_out_122011", "122011016", "story_v_out_122011.awb") / 1000

					if var_75_20 + var_75_12 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_20 + var_75_12
					end

					if var_75_15.prefab_name ~= "" and arg_72_1.actors_[var_75_15.prefab_name] ~= nil then
						local var_75_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_15.prefab_name].transform, "story_v_out_122011", "122011016", "story_v_out_122011.awb")

						arg_72_1:RecordAudio("122011016", var_75_21)
						arg_72_1:RecordAudio("122011016", var_75_21)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_122011", "122011016", "story_v_out_122011.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_122011", "122011016", "story_v_out_122011.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_22 = math.max(var_75_13, arg_72_1.talkMaxDuration)

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_22 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_12) / var_75_22

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_12 + var_75_22 and arg_72_1.time_ < var_75_12 + var_75_22 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play122011017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 122011017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play122011018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1.35

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(122011017)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 54
				local var_79_5 = utf8.len(var_79_3)
				local var_79_6 = var_79_4 <= 0 and var_79_1 or var_79_1 * (var_79_5 / var_79_4)

				if var_79_6 > 0 and var_79_1 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_7 and arg_76_1.time_ < var_79_0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play122011018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 122011018
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play122011019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 1.975

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(122011018)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 79
				local var_83_5 = utf8.len(var_83_3)
				local var_83_6 = var_83_4 <= 0 and var_83_1 or var_83_1 * (var_83_5 / var_83_4)

				if var_83_6 > 0 and var_83_1 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_7 and arg_80_1.time_ < var_83_0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play122011019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 122011019
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play122011020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 1.175

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(122011019)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 47
				local var_87_5 = utf8.len(var_87_3)
				local var_87_6 = var_87_4 <= 0 and var_87_1 or var_87_1 * (var_87_5 / var_87_4)

				if var_87_6 > 0 and var_87_1 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_7 and arg_84_1.time_ < var_87_0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play122011020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 122011020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play122011021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.225

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:GetWordFromCfg(122011020)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 9
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play122011021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 122011021
		arg_92_1.duration_ = 3.87

		local var_92_0 = {
			ja = 3.866,
			ko = 2,
			zh = 2
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play122011022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = manager.ui.mainCamera.transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.shakeOldPos = var_95_0.localPosition
			end

			local var_95_2 = 0.6

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / 0.066
				local var_95_4, var_95_5 = math.modf(var_95_3)

				var_95_0.localPosition = Vector3.New(var_95_5 * 0.13, var_95_5 * 0.13, var_95_5 * 0.13) + arg_92_1.var_.shakeOldPos
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = arg_92_1.var_.shakeOldPos
			end

			local var_95_6 = 0

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.allBtn_.enabled = false
			end

			local var_95_7 = 0.6

			if arg_92_1.time_ >= var_95_6 + var_95_7 and arg_92_1.time_ < var_95_6 + var_95_7 + arg_95_0 then
				arg_92_1.allBtn_.enabled = true
			end

			local var_95_8 = 0
			local var_95_9 = 0.225

			if var_95_8 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_10 = arg_92_1:FormatText(StoryNameCfg[384].name)

				arg_92_1.leftNameTxt_.text = var_95_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_11 = arg_92_1:GetWordFromCfg(122011021)
				local var_95_12 = arg_92_1:FormatText(var_95_11.content)

				arg_92_1.text_.text = var_95_12

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 9
				local var_95_14 = utf8.len(var_95_12)
				local var_95_15 = var_95_13 <= 0 and var_95_9 or var_95_9 * (var_95_14 / var_95_13)

				if var_95_15 > 0 and var_95_9 < var_95_15 then
					arg_92_1.talkMaxDuration = var_95_15

					if var_95_15 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_15 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_12
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122011", "122011021", "story_v_out_122011.awb") ~= 0 then
					local var_95_16 = manager.audio:GetVoiceLength("story_v_out_122011", "122011021", "story_v_out_122011.awb") / 1000

					if var_95_16 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_16 + var_95_8
					end

					if var_95_11.prefab_name ~= "" and arg_92_1.actors_[var_95_11.prefab_name] ~= nil then
						local var_95_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_11.prefab_name].transform, "story_v_out_122011", "122011021", "story_v_out_122011.awb")

						arg_92_1:RecordAudio("122011021", var_95_17)
						arg_92_1:RecordAudio("122011021", var_95_17)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_122011", "122011021", "story_v_out_122011.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_122011", "122011021", "story_v_out_122011.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_18 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_18 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_18

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_18 and arg_92_1.time_ < var_95_8 + var_95_18 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play122011022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 122011022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play122011023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 1.375

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(122011022)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 55
				local var_99_5 = utf8.len(var_99_3)
				local var_99_6 = var_99_4 <= 0 and var_99_1 or var_99_1 * (var_99_5 / var_99_4)

				if var_99_6 > 0 and var_99_1 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_7 and arg_96_1.time_ < var_99_0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play122011023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 122011023
		arg_100_1.duration_ = 4.9

		local var_100_0 = {
			ja = 4.9,
			ko = 3,
			zh = 3
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play122011024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1071ui_story"].transform
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.var_.moveOldPos1071ui_story = var_103_0.localPosition
			end

			local var_103_2 = 0.001

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2
				local var_103_4 = Vector3.New(0, -1.05, -6.2)

				var_103_0.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1071ui_story, var_103_4, var_103_3)

				local var_103_5 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_5.x, var_103_5.y, var_103_5.z)

				local var_103_6 = var_103_0.localEulerAngles

				var_103_6.z = 0
				var_103_6.x = 0
				var_103_0.localEulerAngles = var_103_6
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 then
				var_103_0.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_103_7 = manager.ui.mainCamera.transform.position - var_103_0.position

				var_103_0.forward = Vector3.New(var_103_7.x, var_103_7.y, var_103_7.z)

				local var_103_8 = var_103_0.localEulerAngles

				var_103_8.z = 0
				var_103_8.x = 0
				var_103_0.localEulerAngles = var_103_8
			end

			local var_103_9 = arg_100_1.actors_["1071ui_story"]
			local var_103_10 = 0

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1071ui_story == nil then
				arg_100_1.var_.characterEffect1071ui_story = var_103_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_11 = 0.200000002980232

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_11 and not isNil(var_103_9) then
				local var_103_12 = (arg_100_1.time_ - var_103_10) / var_103_11

				if arg_100_1.var_.characterEffect1071ui_story and not isNil(var_103_9) then
					arg_100_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_10 + var_103_11 and arg_100_1.time_ < var_103_10 + var_103_11 + arg_103_0 and not isNil(var_103_9) and arg_100_1.var_.characterEffect1071ui_story then
				arg_100_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_103_13 = 0

			if var_103_13 < arg_100_1.time_ and arg_100_1.time_ <= var_103_13 + arg_103_0 then
				arg_100_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_103_14 = 0
			local var_103_15 = 0.275

			if var_103_14 < arg_100_1.time_ and arg_100_1.time_ <= var_103_14 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_16 = arg_100_1:FormatText(StoryNameCfg[384].name)

				arg_100_1.leftNameTxt_.text = var_103_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_17 = arg_100_1:GetWordFromCfg(122011023)
				local var_103_18 = arg_100_1:FormatText(var_103_17.content)

				arg_100_1.text_.text = var_103_18

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_19 = 11
				local var_103_20 = utf8.len(var_103_18)
				local var_103_21 = var_103_19 <= 0 and var_103_15 or var_103_15 * (var_103_20 / var_103_19)

				if var_103_21 > 0 and var_103_15 < var_103_21 then
					arg_100_1.talkMaxDuration = var_103_21

					if var_103_21 + var_103_14 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_21 + var_103_14
					end
				end

				arg_100_1.text_.text = var_103_18
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122011", "122011023", "story_v_out_122011.awb") ~= 0 then
					local var_103_22 = manager.audio:GetVoiceLength("story_v_out_122011", "122011023", "story_v_out_122011.awb") / 1000

					if var_103_22 + var_103_14 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_22 + var_103_14
					end

					if var_103_17.prefab_name ~= "" and arg_100_1.actors_[var_103_17.prefab_name] ~= nil then
						local var_103_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_17.prefab_name].transform, "story_v_out_122011", "122011023", "story_v_out_122011.awb")

						arg_100_1:RecordAudio("122011023", var_103_23)
						arg_100_1:RecordAudio("122011023", var_103_23)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_122011", "122011023", "story_v_out_122011.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_122011", "122011023", "story_v_out_122011.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_24 = math.max(var_103_15, arg_100_1.talkMaxDuration)

			if var_103_14 <= arg_100_1.time_ and arg_100_1.time_ < var_103_14 + var_103_24 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_14) / var_103_24

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_14 + var_103_24 and arg_100_1.time_ < var_103_14 + var_103_24 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play122011024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 122011024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play122011025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1071ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1071ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(0, 100, 0)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1071ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, 100, 0)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = arg_104_1.actors_["1071ui_story"]
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1071ui_story == nil then
				arg_104_1.var_.characterEffect1071ui_story = var_107_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.200000002980232

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_11 and not isNil(var_107_9) then
				local var_107_12 = (arg_104_1.time_ - var_107_10) / var_107_11

				if arg_104_1.var_.characterEffect1071ui_story and not isNil(var_107_9) then
					local var_107_13 = Mathf.Lerp(0, 0.5, var_107_12)

					arg_104_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1071ui_story.fillRatio = var_107_13
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_11 and arg_104_1.time_ < var_107_10 + var_107_11 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1071ui_story then
				local var_107_14 = 0.5

				arg_104_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1071ui_story.fillRatio = var_107_14
			end

			local var_107_15 = 0
			local var_107_16 = 0.95

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_17 = arg_104_1:GetWordFromCfg(122011024)
				local var_107_18 = arg_104_1:FormatText(var_107_17.content)

				arg_104_1.text_.text = var_107_18

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_19 = 38
				local var_107_20 = utf8.len(var_107_18)
				local var_107_21 = var_107_19 <= 0 and var_107_16 or var_107_16 * (var_107_20 / var_107_19)

				if var_107_21 > 0 and var_107_16 < var_107_21 then
					arg_104_1.talkMaxDuration = var_107_21

					if var_107_21 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_21 + var_107_15
					end
				end

				arg_104_1.text_.text = var_107_18
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_22 = math.max(var_107_16, arg_104_1.talkMaxDuration)

			if var_107_15 <= arg_104_1.time_ and arg_104_1.time_ < var_107_15 + var_107_22 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_15) / var_107_22

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_15 + var_107_22 and arg_104_1.time_ < var_107_15 + var_107_22 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play122011025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 122011025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
			arg_108_1.auto_ = false
		end

		function arg_108_1.playNext_(arg_110_0)
			arg_108_1.onStoryFinished_()
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 1.35

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(122011025)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 54
				local var_111_5 = utf8.len(var_111_3)
				local var_111_6 = var_111_4 <= 0 and var_111_1 or var_111_1 * (var_111_5 / var_111_4)

				if var_111_6 > 0 and var_111_1 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_7 and arg_108_1.time_ < var_111_0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0204",
		"TextureConfig/Background/XH0508a",
		"TextureConfig/Background/J10i"
	},
	voices = {
		"story_v_out_122011.awb"
	}
}
