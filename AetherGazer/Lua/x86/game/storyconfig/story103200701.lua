return {
	Play320071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320071002(arg_1_1)
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 2
			local var_4_31 = 0.075

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_33 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_33

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

				local var_4_34 = arg_1_1:GetWordFromCfg(320071001)
				local var_4_35 = arg_1_1:FormatText(var_4_34.content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 3
				local var_4_37 = utf8.len(var_4_35)
				local var_4_38 = var_4_36 <= 0 and var_4_31 or var_4_31 * (var_4_37 / var_4_36)

				if var_4_38 > 0 and var_4_31 < var_4_38 then
					arg_1_1.talkMaxDuration = var_4_38
					var_4_30 = var_4_30 + 0.3

					if var_4_38 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_39 = var_4_30 + 0.3
			local var_4_40 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_39) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play320071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 320071002
		arg_8_1.duration_ = 7

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play320071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "ST61"

			if arg_8_1.bgs_[var_11_0] == nil then
				local var_11_1 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_0)
				var_11_1.name = var_11_0
				var_11_1.transform.parent = arg_8_1.stage_.transform
				var_11_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_0] = var_11_1
			end

			local var_11_2 = 0

			if var_11_2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				local var_11_3 = manager.ui.mainCamera.transform.localPosition
				local var_11_4 = Vector3.New(0, 0, 10) + Vector3.New(var_11_3.x, var_11_3.y, 0)
				local var_11_5 = arg_8_1.bgs_.ST61

				var_11_5.transform.localPosition = var_11_4
				var_11_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_6 = var_11_5:GetComponent("SpriteRenderer")

				if var_11_6 and var_11_6.sprite then
					local var_11_7 = (var_11_5.transform.localPosition - var_11_3).z
					local var_11_8 = manager.ui.mainCameraCom_
					local var_11_9 = 2 * var_11_7 * Mathf.Tan(var_11_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_11_10 = var_11_9 * var_11_8.aspect
					local var_11_11 = var_11_6.sprite.bounds.size.x
					local var_11_12 = var_11_6.sprite.bounds.size.y
					local var_11_13 = var_11_10 / var_11_11
					local var_11_14 = var_11_9 / var_11_12
					local var_11_15 = var_11_14 < var_11_13 and var_11_13 or var_11_14

					var_11_5.transform.localScale = Vector3.New(var_11_15, var_11_15, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "ST61" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_11_16 = 2

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			local var_11_17 = 0.3

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_19 = 2

			if var_11_18 <= arg_8_1.time_ and arg_8_1.time_ < var_11_18 + var_11_19 then
				local var_11_20 = (arg_8_1.time_ - var_11_18) / var_11_19
				local var_11_21 = Color.New(0, 0, 0)

				var_11_21.a = Mathf.Lerp(1, 0, var_11_20)
				arg_8_1.mask_.color = var_11_21
			end

			if arg_8_1.time_ >= var_11_18 + var_11_19 and arg_8_1.time_ < var_11_18 + var_11_19 + arg_11_0 then
				local var_11_22 = Color.New(0, 0, 0)
				local var_11_23 = 0

				arg_8_1.mask_.enabled = false
				var_11_22.a = var_11_23
				arg_8_1.mask_.color = var_11_22
			end

			local var_11_24 = "ST61_blur"

			if arg_8_1.bgs_[var_11_24] == nil then
				local var_11_25 = Object.Instantiate(arg_8_1.blurPaintGo_)
				local var_11_26 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_24)

				var_11_25:GetComponent("SpriteRenderer").sprite = var_11_26
				var_11_25.name = var_11_24
				var_11_25.transform.parent = arg_8_1.stage_.transform
				var_11_25.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_24] = var_11_25
			end

			local var_11_27 = 0
			local var_11_28 = arg_8_1.bgs_[var_11_24]

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				local var_11_29 = manager.ui.mainCamera.transform.localPosition
				local var_11_30 = Vector3.New(0, 0, 10) + Vector3.New(var_11_29.x, var_11_29.y, 0)

				var_11_28.transform.localPosition = var_11_30
				var_11_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_31 = var_11_28:GetComponent("SpriteRenderer")

				if var_11_31 and var_11_31.sprite then
					local var_11_32 = (var_11_28.transform.localPosition - var_11_29).z
					local var_11_33 = manager.ui.mainCameraCom_
					local var_11_34 = 2 * var_11_32 * Mathf.Tan(var_11_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_11_35 = var_11_34 * var_11_33.aspect
					local var_11_36 = var_11_31.sprite.bounds.size.x
					local var_11_37 = var_11_31.sprite.bounds.size.y
					local var_11_38 = var_11_35 / var_11_36
					local var_11_39 = var_11_34 / var_11_37
					local var_11_40 = var_11_39 < var_11_38 and var_11_38 or var_11_39

					var_11_28.transform.localScale = Vector3.New(var_11_40, var_11_40, 0)
				end
			end

			local var_11_41 = 2

			if var_11_27 <= arg_8_1.time_ and arg_8_1.time_ < var_11_27 + var_11_41 then
				local var_11_42 = (arg_8_1.time_ - var_11_27) / var_11_41
				local var_11_43 = Color.New(1, 1, 1)

				var_11_43.a = Mathf.Lerp(1, 0, var_11_42)

				var_11_28:GetComponent("SpriteRenderer").material:SetColor("_Color", var_11_43)
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_44 = 2
			local var_11_45 = 1.65

			if var_11_44 < arg_8_1.time_ and arg_8_1.time_ <= var_11_44 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_46 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_46:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_8_1.dialogCg_.alpha = arg_12_0
				end))
				var_11_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_47 = arg_8_1:GetWordFromCfg(320071002)
				local var_11_48 = arg_8_1:FormatText(var_11_47.content)

				arg_8_1.text_.text = var_11_48

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_49 = 66
				local var_11_50 = utf8.len(var_11_48)
				local var_11_51 = var_11_49 <= 0 and var_11_45 or var_11_45 * (var_11_50 / var_11_49)

				if var_11_51 > 0 and var_11_45 < var_11_51 then
					arg_8_1.talkMaxDuration = var_11_51
					var_11_44 = var_11_44 + 0.3

					if var_11_51 + var_11_44 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_51 + var_11_44
					end
				end

				arg_8_1.text_.text = var_11_48
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_52 = var_11_44 + 0.3
			local var_11_53 = math.max(var_11_45, arg_8_1.talkMaxDuration)

			if var_11_52 <= arg_8_1.time_ and arg_8_1.time_ < var_11_52 + var_11_53 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_52) / var_11_53

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_52 + var_11_53 and arg_8_1.time_ < var_11_52 + var_11_53 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play320071003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 320071003
		arg_14_1.duration_ = 2.67

		local var_14_0 = {
			zh = 2.666,
			ja = 2.466
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
				arg_14_0:Play320071004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 0.2

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				local var_17_2 = "play"
				local var_17_3 = "music"

				arg_14_1:AudioAction(var_17_2, var_17_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_17_4 = ""
				local var_17_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_17_5 ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_5 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_5

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_5
						arg_14_1.bgmTxt2_.text = var_17_5
					end

					if arg_14_1.bgmTimer then
						arg_14_1.bgmTimer:Stop()

						arg_14_1.bgmTimer = nil
					end

					if arg_14_1.settingData.show_music_name == 1 then
						arg_14_1.musicController:SetSelectedState("show")
						arg_14_1.musicAnimator_:Play("open", 0, 0)

						if arg_14_1.settingData.music_time ~= 0 then
							arg_14_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_14_1.settingData.music_time), function()
								if arg_14_1 == nil or isNil(arg_14_1.bgmTxt_) then
									return
								end

								arg_14_1.musicController:SetSelectedState("hide")
								arg_14_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_17_6 = 0.333333333333333
			local var_17_7 = 0.666666666666667

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				local var_17_8 = "play"
				local var_17_9 = "music"

				arg_14_1:AudioAction(var_17_8, var_17_9, "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_17_10 = ""
				local var_17_11 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if var_17_11 ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_11 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_11

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_11
						arg_14_1.bgmTxt2_.text = var_17_11
					end

					if arg_14_1.bgmTimer then
						arg_14_1.bgmTimer:Stop()

						arg_14_1.bgmTimer = nil
					end

					if arg_14_1.settingData.show_music_name == 1 then
						arg_14_1.musicController:SetSelectedState("show")
						arg_14_1.musicAnimator_:Play("open", 0, 0)

						if arg_14_1.settingData.music_time ~= 0 then
							arg_14_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_14_1.settingData.music_time), function()
								if arg_14_1 == nil or isNil(arg_14_1.bgmTxt_) then
									return
								end

								arg_14_1.musicController:SetSelectedState("hide")
								arg_14_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_17_12 = 0
			local var_17_13 = 0.15

			if var_17_12 < arg_14_1.time_ and arg_14_1.time_ <= var_17_12 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_14 = arg_14_1:FormatText(StoryNameCfg[1031].name)

				arg_14_1.leftNameTxt_.text = var_17_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_15 = arg_14_1:GetWordFromCfg(320071003)
				local var_17_16 = arg_14_1:FormatText(var_17_15.content)

				arg_14_1.text_.text = var_17_16

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_17 = 6
				local var_17_18 = utf8.len(var_17_16)
				local var_17_19 = var_17_17 <= 0 and var_17_13 or var_17_13 * (var_17_18 / var_17_17)

				if var_17_19 > 0 and var_17_13 < var_17_19 then
					arg_14_1.talkMaxDuration = var_17_19

					if var_17_19 + var_17_12 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_19 + var_17_12
					end
				end

				arg_14_1.text_.text = var_17_16
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071003", "story_v_out_320071.awb") ~= 0 then
					local var_17_20 = manager.audio:GetVoiceLength("story_v_out_320071", "320071003", "story_v_out_320071.awb") / 1000

					if var_17_20 + var_17_12 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_20 + var_17_12
					end

					if var_17_15.prefab_name ~= "" and arg_14_1.actors_[var_17_15.prefab_name] ~= nil then
						local var_17_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_15.prefab_name].transform, "story_v_out_320071", "320071003", "story_v_out_320071.awb")

						arg_14_1:RecordAudio("320071003", var_17_21)
						arg_14_1:RecordAudio("320071003", var_17_21)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_320071", "320071003", "story_v_out_320071.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_320071", "320071003", "story_v_out_320071.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_22 = math.max(var_17_13, arg_14_1.talkMaxDuration)

			if var_17_12 <= arg_14_1.time_ and arg_14_1.time_ < var_17_12 + var_17_22 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_12) / var_17_22

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_12 + var_17_22 and arg_14_1.time_ < var_17_12 + var_17_22 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play320071004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 320071004
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play320071005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 1.25

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(320071004)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 50
				local var_23_5 = utf8.len(var_23_3)
				local var_23_6 = var_23_4 <= 0 and var_23_1 or var_23_1 * (var_23_5 / var_23_4)

				if var_23_6 > 0 and var_23_1 < var_23_6 then
					arg_20_1.talkMaxDuration = var_23_6

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_7 and arg_20_1.time_ < var_23_0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play320071005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 320071005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play320071006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.4

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(320071005)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 16
				local var_27_5 = utf8.len(var_27_3)
				local var_27_6 = var_27_4 <= 0 and var_27_1 or var_27_1 * (var_27_5 / var_27_4)

				if var_27_6 > 0 and var_27_1 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_7 and arg_24_1.time_ < var_27_0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play320071006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 320071006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play320071007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_2

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

				local var_31_3 = arg_28_1:GetWordFromCfg(320071006)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 4
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_8 and arg_28_1.time_ < var_31_0 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play320071007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 320071007
		arg_32_1.duration_ = 2

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play320071008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "10102ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "10102ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["10102ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos10102ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(0, -0.985, -6.275)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10102ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["10102ui_story"]
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect10102ui_story == nil then
				arg_32_1.var_.characterEffect10102ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_16 = 0.200000002980232

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 and not isNil(var_35_14) then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16

				if arg_32_1.var_.characterEffect10102ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect10102ui_story then
				arg_32_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_35_18 = 0

			if var_35_18 < arg_32_1.time_ and arg_32_1.time_ <= var_35_18 + arg_35_0 then
				arg_32_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_35_20 = 0
			local var_35_21 = 0.05

			if var_35_20 < arg_32_1.time_ and arg_32_1.time_ <= var_35_20 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_22 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_23 = arg_32_1:GetWordFromCfg(320071007)
				local var_35_24 = arg_32_1:FormatText(var_35_23.content)

				arg_32_1.text_.text = var_35_24

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_25 = 2
				local var_35_26 = utf8.len(var_35_24)
				local var_35_27 = var_35_25 <= 0 and var_35_21 or var_35_21 * (var_35_26 / var_35_25)

				if var_35_27 > 0 and var_35_21 < var_35_27 then
					arg_32_1.talkMaxDuration = var_35_27

					if var_35_27 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_27 + var_35_20
					end
				end

				arg_32_1.text_.text = var_35_24
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071007", "story_v_out_320071.awb") ~= 0 then
					local var_35_28 = manager.audio:GetVoiceLength("story_v_out_320071", "320071007", "story_v_out_320071.awb") / 1000

					if var_35_28 + var_35_20 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_28 + var_35_20
					end

					if var_35_23.prefab_name ~= "" and arg_32_1.actors_[var_35_23.prefab_name] ~= nil then
						local var_35_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_23.prefab_name].transform, "story_v_out_320071", "320071007", "story_v_out_320071.awb")

						arg_32_1:RecordAudio("320071007", var_35_29)
						arg_32_1:RecordAudio("320071007", var_35_29)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_320071", "320071007", "story_v_out_320071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_320071", "320071007", "story_v_out_320071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_30 = math.max(var_35_21, arg_32_1.talkMaxDuration)

			if var_35_20 <= arg_32_1.time_ and arg_32_1.time_ < var_35_20 + var_35_30 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_20) / var_35_30

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_20 + var_35_30 and arg_32_1.time_ < var_35_20 + var_35_30 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play320071008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 320071008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play320071009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10102ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10102ui_story == nil then
				arg_36_1.var_.characterEffect10102ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10102ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10102ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10102ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10102ui_story.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.125

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(320071008)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 5
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play320071009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 320071009
		arg_40_1.duration_ = 8.2

		local var_40_0 = {
			zh = 8.2,
			ja = 4.8
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play320071010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10102ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10102ui_story == nil then
				arg_40_1.var_.characterEffect10102ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10102ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10102ui_story then
				arg_40_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_43_4 = 0
			local var_43_5 = 1.075

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_6 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(320071009)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 43
				local var_43_10 = utf8.len(var_43_8)
				local var_43_11 = var_43_9 <= 0 and var_43_5 or var_43_5 * (var_43_10 / var_43_9)

				if var_43_11 > 0 and var_43_5 < var_43_11 then
					arg_40_1.talkMaxDuration = var_43_11

					if var_43_11 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071009", "story_v_out_320071.awb") ~= 0 then
					local var_43_12 = manager.audio:GetVoiceLength("story_v_out_320071", "320071009", "story_v_out_320071.awb") / 1000

					if var_43_12 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_4
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_320071", "320071009", "story_v_out_320071.awb")

						arg_40_1:RecordAudio("320071009", var_43_13)
						arg_40_1:RecordAudio("320071009", var_43_13)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_320071", "320071009", "story_v_out_320071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_320071", "320071009", "story_v_out_320071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_14 and arg_40_1.time_ < var_43_4 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play320071010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 320071010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play320071011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10102ui_story"].transform
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.var_.moveOldPos10102ui_story = var_47_0.localPosition
			end

			local var_47_2 = 0.001

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2
				local var_47_4 = Vector3.New(0, 100, 0)

				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10102ui_story, var_47_4, var_47_3)

				local var_47_5 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_5.x, var_47_5.y, var_47_5.z)

				local var_47_6 = var_47_0.localEulerAngles

				var_47_6.z = 0
				var_47_6.x = 0
				var_47_0.localEulerAngles = var_47_6
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(0, 100, 0)

				local var_47_7 = manager.ui.mainCamera.transform.position - var_47_0.position

				var_47_0.forward = Vector3.New(var_47_7.x, var_47_7.y, var_47_7.z)

				local var_47_8 = var_47_0.localEulerAngles

				var_47_8.z = 0
				var_47_8.x = 0
				var_47_0.localEulerAngles = var_47_8
			end

			local var_47_9 = arg_44_1.actors_["10102ui_story"]
			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect10102ui_story == nil then
				arg_44_1.var_.characterEffect10102ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_11 = 0.200000002980232

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_11 and not isNil(var_47_9) then
				local var_47_12 = (arg_44_1.time_ - var_47_10) / var_47_11

				if arg_44_1.var_.characterEffect10102ui_story and not isNil(var_47_9) then
					local var_47_13 = Mathf.Lerp(0, 0.5, var_47_12)

					arg_44_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_44_1.var_.characterEffect10102ui_story.fillRatio = var_47_13
				end
			end

			if arg_44_1.time_ >= var_47_10 + var_47_11 and arg_44_1.time_ < var_47_10 + var_47_11 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect10102ui_story then
				local var_47_14 = 0.5

				arg_44_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_44_1.var_.characterEffect10102ui_story.fillRatio = var_47_14
			end

			local var_47_15 = 0
			local var_47_16 = 1.275

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_17 = arg_44_1:GetWordFromCfg(320071010)
				local var_47_18 = arg_44_1:FormatText(var_47_17.content)

				arg_44_1.text_.text = var_47_18

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_19 = 51
				local var_47_20 = utf8.len(var_47_18)
				local var_47_21 = var_47_19 <= 0 and var_47_16 or var_47_16 * (var_47_20 / var_47_19)

				if var_47_21 > 0 and var_47_16 < var_47_21 then
					arg_44_1.talkMaxDuration = var_47_21

					if var_47_21 + var_47_15 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_21 + var_47_15
					end
				end

				arg_44_1.text_.text = var_47_18
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_16, arg_44_1.talkMaxDuration)

			if var_47_15 <= arg_44_1.time_ and arg_44_1.time_ < var_47_15 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_15) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_15 + var_47_22 and arg_44_1.time_ < var_47_15 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play320071011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 320071011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play320071012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.425

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(320071011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 17
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play320071012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 320071012
		arg_52_1.duration_ = 5.6

		local var_52_0 = {
			zh = 2.833,
			ja = 5.6
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
				arg_52_0:Play320071013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = "1089ui_story"

			if arg_52_1.actors_[var_55_0] == nil then
				local var_55_1 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_55_1) then
					local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_52_1.stage_.transform)

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

			local var_55_5 = arg_52_1.actors_["1089ui_story"].transform
			local var_55_6 = 0

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.var_.moveOldPos1089ui_story = var_55_5.localPosition
			end

			local var_55_7 = 0.001

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_7 then
				local var_55_8 = (arg_52_1.time_ - var_55_6) / var_55_7
				local var_55_9 = Vector3.New(0, -1.1, -6.17)

				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1089ui_story, var_55_9, var_55_8)

				local var_55_10 = manager.ui.mainCamera.transform.position - var_55_5.position

				var_55_5.forward = Vector3.New(var_55_10.x, var_55_10.y, var_55_10.z)

				local var_55_11 = var_55_5.localEulerAngles

				var_55_11.z = 0
				var_55_11.x = 0
				var_55_5.localEulerAngles = var_55_11
			end

			if arg_52_1.time_ >= var_55_6 + var_55_7 and arg_52_1.time_ < var_55_6 + var_55_7 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_55_12 = manager.ui.mainCamera.transform.position - var_55_5.position

				var_55_5.forward = Vector3.New(var_55_12.x, var_55_12.y, var_55_12.z)

				local var_55_13 = var_55_5.localEulerAngles

				var_55_13.z = 0
				var_55_13.x = 0
				var_55_5.localEulerAngles = var_55_13
			end

			local var_55_14 = arg_52_1.actors_["1089ui_story"]
			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 and not isNil(var_55_14) and arg_52_1.var_.characterEffect1089ui_story == nil then
				arg_52_1.var_.characterEffect1089ui_story = var_55_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_16 = 0.200000002980232

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_16 and not isNil(var_55_14) then
				local var_55_17 = (arg_52_1.time_ - var_55_15) / var_55_16

				if arg_52_1.var_.characterEffect1089ui_story and not isNil(var_55_14) then
					arg_52_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_15 + var_55_16 and arg_52_1.time_ < var_55_15 + var_55_16 + arg_55_0 and not isNil(var_55_14) and arg_52_1.var_.characterEffect1089ui_story then
				arg_52_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_55_18 = 0

			if var_55_18 < arg_52_1.time_ and arg_52_1.time_ <= var_55_18 + arg_55_0 then
				arg_52_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_55_19 = 0

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_55_20 = 0
			local var_55_21 = 0.225

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_22 = arg_52_1:FormatText(StoryNameCfg[1031].name)

				arg_52_1.leftNameTxt_.text = var_55_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_23 = arg_52_1:GetWordFromCfg(320071012)
				local var_55_24 = arg_52_1:FormatText(var_55_23.content)

				arg_52_1.text_.text = var_55_24

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_25 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071012", "story_v_out_320071.awb") ~= 0 then
					local var_55_28 = manager.audio:GetVoiceLength("story_v_out_320071", "320071012", "story_v_out_320071.awb") / 1000

					if var_55_28 + var_55_20 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_20
					end

					if var_55_23.prefab_name ~= "" and arg_52_1.actors_[var_55_23.prefab_name] ~= nil then
						local var_55_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_23.prefab_name].transform, "story_v_out_320071", "320071012", "story_v_out_320071.awb")

						arg_52_1:RecordAudio("320071012", var_55_29)
						arg_52_1:RecordAudio("320071012", var_55_29)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_320071", "320071012", "story_v_out_320071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_320071", "320071012", "story_v_out_320071.awb")
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
				actorName = "1089ui_story",
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
	Play320071013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 320071013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play320071014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1089ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1089ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1089ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1089ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1089ui_story == nil then
				arg_56_1.var_.characterEffect1089ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1089ui_story and not isNil(var_59_9) then
					local var_59_13 = Mathf.Lerp(0, 0.5, var_59_12)

					arg_56_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1089ui_story.fillRatio = var_59_13
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1089ui_story then
				local var_59_14 = 0.5

				arg_56_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1089ui_story.fillRatio = var_59_14
			end

			local var_59_15 = 0
			local var_59_16 = 1.225

			if var_59_15 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_17 = arg_56_1:GetWordFromCfg(320071013)
				local var_59_18 = arg_56_1:FormatText(var_59_17.content)

				arg_56_1.text_.text = var_59_18

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_19 = 49
				local var_59_20 = utf8.len(var_59_18)
				local var_59_21 = var_59_19 <= 0 and var_59_16 or var_59_16 * (var_59_20 / var_59_19)

				if var_59_21 > 0 and var_59_16 < var_59_21 then
					arg_56_1.talkMaxDuration = var_59_21

					if var_59_21 + var_59_15 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_21 + var_59_15
					end
				end

				arg_56_1.text_.text = var_59_18
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_16, arg_56_1.talkMaxDuration)

			if var_59_15 <= arg_56_1.time_ and arg_56_1.time_ < var_59_15 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_15) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_15 + var_59_22 and arg_56_1.time_ < var_59_15 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play320071014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 320071014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play320071015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.125

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(320071014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 5
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play320071015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 320071015
		arg_64_1.duration_ = 8.97

		local var_64_0 = {
			zh = 7.2,
			ja = 8.966
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
				arg_64_0:Play320071016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = "1056ui_story"

			if arg_64_1.actors_[var_67_0] == nil then
				local var_67_1 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_67_1) then
					local var_67_2 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_64_1.stage_.transform)

					var_67_2.name = var_67_0
					var_67_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_64_1.actors_[var_67_0] = var_67_2

					local var_67_3 = var_67_2:GetComponentInChildren(typeof(CharacterEffect))

					var_67_3.enabled = true

					local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_2, typeof(DynamicBoneHelper))

					if var_67_4 then
						var_67_4:EnableDynamicBone(false)
					end

					arg_64_1:ShowWeapon(var_67_3.transform, false)

					arg_64_1.var_[var_67_0 .. "Animator"] = var_67_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_64_1.var_[var_67_0 .. "Animator"].applyRootMotion = true
					arg_64_1.var_[var_67_0 .. "LipSync"] = var_67_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_67_5 = arg_64_1.actors_["1056ui_story"].transform
			local var_67_6 = 0

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.var_.moveOldPos1056ui_story = var_67_5.localPosition
			end

			local var_67_7 = 0.001

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_7 then
				local var_67_8 = (arg_64_1.time_ - var_67_6) / var_67_7
				local var_67_9 = Vector3.New(0, -1, -5.75)

				var_67_5.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1056ui_story, var_67_9, var_67_8)

				local var_67_10 = manager.ui.mainCamera.transform.position - var_67_5.position

				var_67_5.forward = Vector3.New(var_67_10.x, var_67_10.y, var_67_10.z)

				local var_67_11 = var_67_5.localEulerAngles

				var_67_11.z = 0
				var_67_11.x = 0
				var_67_5.localEulerAngles = var_67_11
			end

			if arg_64_1.time_ >= var_67_6 + var_67_7 and arg_64_1.time_ < var_67_6 + var_67_7 + arg_67_0 then
				var_67_5.localPosition = Vector3.New(0, -1, -5.75)

				local var_67_12 = manager.ui.mainCamera.transform.position - var_67_5.position

				var_67_5.forward = Vector3.New(var_67_12.x, var_67_12.y, var_67_12.z)

				local var_67_13 = var_67_5.localEulerAngles

				var_67_13.z = 0
				var_67_13.x = 0
				var_67_5.localEulerAngles = var_67_13
			end

			local var_67_14 = arg_64_1.actors_["1056ui_story"]
			local var_67_15 = 0

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 and not isNil(var_67_14) and arg_64_1.var_.characterEffect1056ui_story == nil then
				arg_64_1.var_.characterEffect1056ui_story = var_67_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_16 = 0.200000002980232

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_16 and not isNil(var_67_14) then
				local var_67_17 = (arg_64_1.time_ - var_67_15) / var_67_16

				if arg_64_1.var_.characterEffect1056ui_story and not isNil(var_67_14) then
					arg_64_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_15 + var_67_16 and arg_64_1.time_ < var_67_15 + var_67_16 + arg_67_0 and not isNil(var_67_14) and arg_64_1.var_.characterEffect1056ui_story then
				arg_64_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_67_18 = 0

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_67_19 = 0

			if var_67_19 < arg_64_1.time_ and arg_64_1.time_ <= var_67_19 + arg_67_0 then
				arg_64_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_67_20 = 0
			local var_67_21 = 0.85

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_22 = arg_64_1:FormatText(StoryNameCfg[605].name)

				arg_64_1.leftNameTxt_.text = var_67_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_23 = arg_64_1:GetWordFromCfg(320071015)
				local var_67_24 = arg_64_1:FormatText(var_67_23.content)

				arg_64_1.text_.text = var_67_24

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_25 = 34
				local var_67_26 = utf8.len(var_67_24)
				local var_67_27 = var_67_25 <= 0 and var_67_21 or var_67_21 * (var_67_26 / var_67_25)

				if var_67_27 > 0 and var_67_21 < var_67_27 then
					arg_64_1.talkMaxDuration = var_67_27

					if var_67_27 + var_67_20 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_27 + var_67_20
					end
				end

				arg_64_1.text_.text = var_67_24
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071015", "story_v_out_320071.awb") ~= 0 then
					local var_67_28 = manager.audio:GetVoiceLength("story_v_out_320071", "320071015", "story_v_out_320071.awb") / 1000

					if var_67_28 + var_67_20 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_28 + var_67_20
					end

					if var_67_23.prefab_name ~= "" and arg_64_1.actors_[var_67_23.prefab_name] ~= nil then
						local var_67_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_23.prefab_name].transform, "story_v_out_320071", "320071015", "story_v_out_320071.awb")

						arg_64_1:RecordAudio("320071015", var_67_29)
						arg_64_1:RecordAudio("320071015", var_67_29)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_320071", "320071015", "story_v_out_320071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_320071", "320071015", "story_v_out_320071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_30 = math.max(var_67_21, arg_64_1.talkMaxDuration)

			if var_67_20 <= arg_64_1.time_ and arg_64_1.time_ < var_67_20 + var_67_30 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_20) / var_67_30

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_20 + var_67_30 and arg_64_1.time_ < var_67_20 + var_67_30 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320071016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 320071016
		arg_68_1.duration_ = 7

		local var_68_0 = {
			zh = 6.266,
			ja = 7
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
				arg_68_0:Play320071017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.9

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[605].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:GetWordFromCfg(320071016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 36
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071016", "story_v_out_320071.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071016", "story_v_out_320071.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_320071", "320071016", "story_v_out_320071.awb")

						arg_68_1:RecordAudio("320071016", var_71_9)
						arg_68_1:RecordAudio("320071016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_320071", "320071016", "story_v_out_320071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_320071", "320071016", "story_v_out_320071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play320071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 320071017
		arg_72_1.duration_ = 9.03

		local var_72_0 = {
			zh = 7.666,
			ja = 9.033
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
				arg_72_0:Play320071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 1.075

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_2 = arg_72_1:FormatText(StoryNameCfg[605].name)

				arg_72_1.leftNameTxt_.text = var_75_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(320071017)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071017", "story_v_out_320071.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071017", "story_v_out_320071.awb") / 1000

					if var_75_8 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_0
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_320071", "320071017", "story_v_out_320071.awb")

						arg_72_1:RecordAudio("320071017", var_75_9)
						arg_72_1:RecordAudio("320071017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_320071", "320071017", "story_v_out_320071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_320071", "320071017", "story_v_out_320071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_10 and arg_72_1.time_ < var_75_0 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play320071018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 320071018
		arg_76_1.duration_ = 12.7

		local var_76_0 = {
			zh = 8.5,
			ja = 12.7
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
				arg_76_0:Play320071019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_1 = 0
			local var_79_2 = 1.15

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_3 = arg_76_1:FormatText(StoryNameCfg[605].name)

				arg_76_1.leftNameTxt_.text = var_79_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(320071018)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 46
				local var_79_7 = utf8.len(var_79_5)
				local var_79_8 = var_79_6 <= 0 and var_79_2 or var_79_2 * (var_79_7 / var_79_6)

				if var_79_8 > 0 and var_79_2 < var_79_8 then
					arg_76_1.talkMaxDuration = var_79_8

					if var_79_8 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071018", "story_v_out_320071.awb") ~= 0 then
					local var_79_9 = manager.audio:GetVoiceLength("story_v_out_320071", "320071018", "story_v_out_320071.awb") / 1000

					if var_79_9 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_1
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_320071", "320071018", "story_v_out_320071.awb")

						arg_76_1:RecordAudio("320071018", var_79_10)
						arg_76_1:RecordAudio("320071018", var_79_10)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_320071", "320071018", "story_v_out_320071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_320071", "320071018", "story_v_out_320071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_11 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_11 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_11

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_11 and arg_76_1.time_ < var_79_1 + var_79_11 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play320071019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 320071019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play320071020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1056ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1056ui_story == nil then
				arg_80_1.var_.characterEffect1056ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1056ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1056ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1056ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1056ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.425

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

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(320071019)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 17
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
	Play320071020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 320071020
		arg_84_1.duration_ = 8.57

		local var_84_0 = {
			zh = 5.9,
			ja = 8.566
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play320071021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1056ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1056ui_story == nil then
				arg_84_1.var_.characterEffect1056ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1056ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1056ui_story then
				arg_84_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_1")
			end

			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_87_6 = 0
			local var_87_7 = 0.725

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[605].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_9 = arg_84_1:GetWordFromCfg(320071020)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 29
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071020", "story_v_out_320071.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071020", "story_v_out_320071.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_320071", "320071020", "story_v_out_320071.awb")

						arg_84_1:RecordAudio("320071020", var_87_15)
						arg_84_1:RecordAudio("320071020", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_320071", "320071020", "story_v_out_320071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_320071", "320071020", "story_v_out_320071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_16 and arg_84_1.time_ < var_87_6 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play320071021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 320071021
		arg_88_1.duration_ = 11.4

		local var_88_0 = {
			zh = 11.133,
			ja = 11.4
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play320071022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_2")
			end

			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_2 = 0
			local var_91_3 = 1.4

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_4 = arg_88_1:FormatText(StoryNameCfg[605].name)

				arg_88_1.leftNameTxt_.text = var_91_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:GetWordFromCfg(320071021)
				local var_91_6 = arg_88_1:FormatText(var_91_5.content)

				arg_88_1.text_.text = var_91_6

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 56
				local var_91_8 = utf8.len(var_91_6)
				local var_91_9 = var_91_7 <= 0 and var_91_3 or var_91_3 * (var_91_8 / var_91_7)

				if var_91_9 > 0 and var_91_3 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_6
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071021", "story_v_out_320071.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_320071", "320071021", "story_v_out_320071.awb") / 1000

					if var_91_10 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_2
					end

					if var_91_5.prefab_name ~= "" and arg_88_1.actors_[var_91_5.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_5.prefab_name].transform, "story_v_out_320071", "320071021", "story_v_out_320071.awb")

						arg_88_1:RecordAudio("320071021", var_91_11)
						arg_88_1:RecordAudio("320071021", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_320071", "320071021", "story_v_out_320071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_320071", "320071021", "story_v_out_320071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_12 and arg_88_1.time_ < var_91_2 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play320071022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 320071022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play320071023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1056ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1056ui_story == nil then
				arg_92_1.var_.characterEffect1056ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1056ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1056ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1056ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1056ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 1.2

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[7].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(320071022)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 48
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_14 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_14 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_14

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_14 and arg_92_1.time_ < var_95_6 + var_95_14 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play320071023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 320071023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play320071024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.975

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(320071023)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 39
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_8 and arg_96_1.time_ < var_99_0 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play320071024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 320071024
		arg_100_1.duration_ = 4.3

		local var_100_0 = {
			zh = 4.3,
			ja = 2.3
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
				arg_100_0:Play320071025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_103_2 = 0
			local var_103_3 = 0.475

			if var_103_2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_4 = arg_100_1:FormatText(StoryNameCfg[605].name)

				arg_100_1.leftNameTxt_.text = var_103_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:GetWordFromCfg(320071024)
				local var_103_6 = arg_100_1:FormatText(var_103_5.content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 19
				local var_103_8 = utf8.len(var_103_6)
				local var_103_9 = var_103_7 <= 0 and var_103_3 or var_103_3 * (var_103_8 / var_103_7)

				if var_103_9 > 0 and var_103_3 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071024", "story_v_out_320071.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_320071", "320071024", "story_v_out_320071.awb") / 1000

					if var_103_10 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_2
					end

					if var_103_5.prefab_name ~= "" and arg_100_1.actors_[var_103_5.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_5.prefab_name].transform, "story_v_out_320071", "320071024", "story_v_out_320071.awb")

						arg_100_1:RecordAudio("320071024", var_103_11)
						arg_100_1:RecordAudio("320071024", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_320071", "320071024", "story_v_out_320071.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_320071", "320071024", "story_v_out_320071.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_12 and arg_100_1.time_ < var_103_2 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play320071025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 320071025
		arg_104_1.duration_ = 3.63

		local var_104_0 = {
			zh = 3.233,
			ja = 3.633
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play320071026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1056ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1056ui_story = var_107_0.localPosition
			end

			local var_107_2 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2
				local var_107_4 = Vector3.New(-0.7, -1, -5.75)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1056ui_story, var_107_4, var_107_3)

				local var_107_5 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_5.x, var_107_5.y, var_107_5.z)

				local var_107_6 = var_107_0.localEulerAngles

				var_107_6.z = 0
				var_107_6.x = 0
				var_107_0.localEulerAngles = var_107_6
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(-0.7, -1, -5.75)

				local var_107_7 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_7.x, var_107_7.y, var_107_7.z)

				local var_107_8 = var_107_0.localEulerAngles

				var_107_8.z = 0
				var_107_8.x = 0
				var_107_0.localEulerAngles = var_107_8
			end

			local var_107_9 = arg_104_1.actors_["1056ui_story"]
			local var_107_10 = 0

			if var_107_10 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1056ui_story == nil then
				arg_104_1.var_.characterEffect1056ui_story = var_107_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_11 = 0.200000002980232

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_11 and not isNil(var_107_9) then
				local var_107_12 = (arg_104_1.time_ - var_107_10) / var_107_11

				if arg_104_1.var_.characterEffect1056ui_story and not isNil(var_107_9) then
					local var_107_13 = Mathf.Lerp(0, 0.5, var_107_12)

					arg_104_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1056ui_story.fillRatio = var_107_13
				end
			end

			if arg_104_1.time_ >= var_107_10 + var_107_11 and arg_104_1.time_ < var_107_10 + var_107_11 + arg_107_0 and not isNil(var_107_9) and arg_104_1.var_.characterEffect1056ui_story then
				local var_107_14 = 0.5

				arg_104_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1056ui_story.fillRatio = var_107_14
			end

			local var_107_15 = arg_104_1.actors_["1089ui_story"].transform
			local var_107_16 = 0

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.var_.moveOldPos1089ui_story = var_107_15.localPosition
			end

			local var_107_17 = 0.001

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_17 then
				local var_107_18 = (arg_104_1.time_ - var_107_16) / var_107_17
				local var_107_19 = Vector3.New(0.7, -1.1, -6.17)

				var_107_15.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1089ui_story, var_107_19, var_107_18)

				local var_107_20 = manager.ui.mainCamera.transform.position - var_107_15.position

				var_107_15.forward = Vector3.New(var_107_20.x, var_107_20.y, var_107_20.z)

				local var_107_21 = var_107_15.localEulerAngles

				var_107_21.z = 0
				var_107_21.x = 0
				var_107_15.localEulerAngles = var_107_21
			end

			if arg_104_1.time_ >= var_107_16 + var_107_17 and arg_104_1.time_ < var_107_16 + var_107_17 + arg_107_0 then
				var_107_15.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_107_22 = manager.ui.mainCamera.transform.position - var_107_15.position

				var_107_15.forward = Vector3.New(var_107_22.x, var_107_22.y, var_107_22.z)

				local var_107_23 = var_107_15.localEulerAngles

				var_107_23.z = 0
				var_107_23.x = 0
				var_107_15.localEulerAngles = var_107_23
			end

			local var_107_24 = arg_104_1.actors_["1089ui_story"]
			local var_107_25 = 0

			if var_107_25 < arg_104_1.time_ and arg_104_1.time_ <= var_107_25 + arg_107_0 and not isNil(var_107_24) and arg_104_1.var_.characterEffect1089ui_story == nil then
				arg_104_1.var_.characterEffect1089ui_story = var_107_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_26 = 0.200000002980232

			if var_107_25 <= arg_104_1.time_ and arg_104_1.time_ < var_107_25 + var_107_26 and not isNil(var_107_24) then
				local var_107_27 = (arg_104_1.time_ - var_107_25) / var_107_26

				if arg_104_1.var_.characterEffect1089ui_story and not isNil(var_107_24) then
					arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_25 + var_107_26 and arg_104_1.time_ < var_107_25 + var_107_26 + arg_107_0 and not isNil(var_107_24) and arg_104_1.var_.characterEffect1089ui_story then
				arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_107_28 = 0

			if var_107_28 < arg_104_1.time_ and arg_104_1.time_ <= var_107_28 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_107_29 = 0

			if var_107_29 < arg_104_1.time_ and arg_104_1.time_ <= var_107_29 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_107_30 = 0
			local var_107_31 = 0.2

			if var_107_30 < arg_104_1.time_ and arg_104_1.time_ <= var_107_30 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_32 = arg_104_1:FormatText(StoryNameCfg[1031].name)

				arg_104_1.leftNameTxt_.text = var_107_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_33 = arg_104_1:GetWordFromCfg(320071025)
				local var_107_34 = arg_104_1:FormatText(var_107_33.content)

				arg_104_1.text_.text = var_107_34

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_35 = 8
				local var_107_36 = utf8.len(var_107_34)
				local var_107_37 = var_107_35 <= 0 and var_107_31 or var_107_31 * (var_107_36 / var_107_35)

				if var_107_37 > 0 and var_107_31 < var_107_37 then
					arg_104_1.talkMaxDuration = var_107_37

					if var_107_37 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_37 + var_107_30
					end
				end

				arg_104_1.text_.text = var_107_34
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071025", "story_v_out_320071.awb") ~= 0 then
					local var_107_38 = manager.audio:GetVoiceLength("story_v_out_320071", "320071025", "story_v_out_320071.awb") / 1000

					if var_107_38 + var_107_30 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_38 + var_107_30
					end

					if var_107_33.prefab_name ~= "" and arg_104_1.actors_[var_107_33.prefab_name] ~= nil then
						local var_107_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_33.prefab_name].transform, "story_v_out_320071", "320071025", "story_v_out_320071.awb")

						arg_104_1:RecordAudio("320071025", var_107_39)
						arg_104_1:RecordAudio("320071025", var_107_39)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_320071", "320071025", "story_v_out_320071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_320071", "320071025", "story_v_out_320071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_40 = math.max(var_107_31, arg_104_1.talkMaxDuration)

			if var_107_30 <= arg_104_1.time_ and arg_104_1.time_ < var_107_30 + var_107_40 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_30) / var_107_40

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_30 + var_107_40 and arg_104_1.time_ < var_107_30 + var_107_40 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play320071026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 320071026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play320071027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1056ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1056ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, 100, 0)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1056ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, 100, 0)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["1056ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1056ui_story == nil then
				arg_108_1.var_.characterEffect1056ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect1056ui_story and not isNil(var_111_9) then
					local var_111_13 = Mathf.Lerp(0, 0.5, var_111_12)

					arg_108_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1056ui_story.fillRatio = var_111_13
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect1056ui_story then
				local var_111_14 = 0.5

				arg_108_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1056ui_story.fillRatio = var_111_14
			end

			local var_111_15 = arg_108_1.actors_["1089ui_story"].transform
			local var_111_16 = 0

			if var_111_16 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.var_.moveOldPos1089ui_story = var_111_15.localPosition
			end

			local var_111_17 = 0.001

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_17 then
				local var_111_18 = (arg_108_1.time_ - var_111_16) / var_111_17
				local var_111_19 = Vector3.New(0, 100, 0)

				var_111_15.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1089ui_story, var_111_19, var_111_18)

				local var_111_20 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_20.x, var_111_20.y, var_111_20.z)

				local var_111_21 = var_111_15.localEulerAngles

				var_111_21.z = 0
				var_111_21.x = 0
				var_111_15.localEulerAngles = var_111_21
			end

			if arg_108_1.time_ >= var_111_16 + var_111_17 and arg_108_1.time_ < var_111_16 + var_111_17 + arg_111_0 then
				var_111_15.localPosition = Vector3.New(0, 100, 0)

				local var_111_22 = manager.ui.mainCamera.transform.position - var_111_15.position

				var_111_15.forward = Vector3.New(var_111_22.x, var_111_22.y, var_111_22.z)

				local var_111_23 = var_111_15.localEulerAngles

				var_111_23.z = 0
				var_111_23.x = 0
				var_111_15.localEulerAngles = var_111_23
			end

			local var_111_24 = arg_108_1.actors_["1089ui_story"]
			local var_111_25 = 0

			if var_111_25 < arg_108_1.time_ and arg_108_1.time_ <= var_111_25 + arg_111_0 and not isNil(var_111_24) and arg_108_1.var_.characterEffect1089ui_story == nil then
				arg_108_1.var_.characterEffect1089ui_story = var_111_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_26 = 0.200000002980232

			if var_111_25 <= arg_108_1.time_ and arg_108_1.time_ < var_111_25 + var_111_26 and not isNil(var_111_24) then
				local var_111_27 = (arg_108_1.time_ - var_111_25) / var_111_26

				if arg_108_1.var_.characterEffect1089ui_story and not isNil(var_111_24) then
					local var_111_28 = Mathf.Lerp(0, 0.5, var_111_27)

					arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1089ui_story.fillRatio = var_111_28
				end
			end

			if arg_108_1.time_ >= var_111_25 + var_111_26 and arg_108_1.time_ < var_111_25 + var_111_26 + arg_111_0 and not isNil(var_111_24) and arg_108_1.var_.characterEffect1089ui_story then
				local var_111_29 = 0.5

				arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1089ui_story.fillRatio = var_111_29
			end

			local var_111_30 = 0
			local var_111_31 = 1.525

			if var_111_30 < arg_108_1.time_ and arg_108_1.time_ <= var_111_30 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_32 = arg_108_1:GetWordFromCfg(320071026)
				local var_111_33 = arg_108_1:FormatText(var_111_32.content)

				arg_108_1.text_.text = var_111_33

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_34 = 61
				local var_111_35 = utf8.len(var_111_33)
				local var_111_36 = var_111_34 <= 0 and var_111_31 or var_111_31 * (var_111_35 / var_111_34)

				if var_111_36 > 0 and var_111_31 < var_111_36 then
					arg_108_1.talkMaxDuration = var_111_36

					if var_111_36 + var_111_30 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_36 + var_111_30
					end
				end

				arg_108_1.text_.text = var_111_33
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_37 = math.max(var_111_31, arg_108_1.talkMaxDuration)

			if var_111_30 <= arg_108_1.time_ and arg_108_1.time_ < var_111_30 + var_111_37 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_30) / var_111_37

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_30 + var_111_37 and arg_108_1.time_ < var_111_30 + var_111_37 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play320071027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 320071027
		arg_112_1.duration_ = 6.1

		local var_112_0 = {
			zh = 5,
			ja = 6.1
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play320071028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10102ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos10102ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0, -0.985, -6.275)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10102ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["10102ui_story"]
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect10102ui_story == nil then
				arg_112_1.var_.characterEffect10102ui_story = var_115_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_11 = 0.200000002980232

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 and not isNil(var_115_9) then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11

				if arg_112_1.var_.characterEffect10102ui_story and not isNil(var_115_9) then
					arg_112_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect10102ui_story then
				arg_112_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_115_13 = 0

			if var_115_13 < arg_112_1.time_ and arg_112_1.time_ <= var_115_13 + arg_115_0 then
				arg_112_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_115_14 = 0

			if var_115_14 < arg_112_1.time_ and arg_112_1.time_ <= var_115_14 + arg_115_0 then
				arg_112_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_115_15 = 0
			local var_115_16 = 0.525

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_17 = arg_112_1:FormatText(StoryNameCfg[6].name)

				arg_112_1.leftNameTxt_.text = var_115_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_18 = arg_112_1:GetWordFromCfg(320071027)
				local var_115_19 = arg_112_1:FormatText(var_115_18.content)

				arg_112_1.text_.text = var_115_19

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_20 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071027", "story_v_out_320071.awb") ~= 0 then
					local var_115_23 = manager.audio:GetVoiceLength("story_v_out_320071", "320071027", "story_v_out_320071.awb") / 1000

					if var_115_23 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_23 + var_115_15
					end

					if var_115_18.prefab_name ~= "" and arg_112_1.actors_[var_115_18.prefab_name] ~= nil then
						local var_115_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_18.prefab_name].transform, "story_v_out_320071", "320071027", "story_v_out_320071.awb")

						arg_112_1:RecordAudio("320071027", var_115_24)
						arg_112_1:RecordAudio("320071027", var_115_24)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_320071", "320071027", "story_v_out_320071.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_320071", "320071027", "story_v_out_320071.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_25 = math.max(var_115_16, arg_112_1.talkMaxDuration)

			if var_115_15 <= arg_112_1.time_ and arg_112_1.time_ < var_115_15 + var_115_25 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_15) / var_115_25

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_15 + var_115_25 and arg_112_1.time_ < var_115_15 + var_115_25 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play320071028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 320071028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play320071029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10102ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos10102ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10102ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["10102ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect10102ui_story == nil then
				arg_116_1.var_.characterEffect10102ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect10102ui_story and not isNil(var_119_9) then
					local var_119_13 = Mathf.Lerp(0, 0.5, var_119_12)

					arg_116_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_116_1.var_.characterEffect10102ui_story.fillRatio = var_119_13
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect10102ui_story then
				local var_119_14 = 0.5

				arg_116_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_116_1.var_.characterEffect10102ui_story.fillRatio = var_119_14
			end

			local var_119_15 = 0
			local var_119_16 = 0.425

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_17 = arg_116_1:GetWordFromCfg(320071028)
				local var_119_18 = arg_116_1:FormatText(var_119_17.content)

				arg_116_1.text_.text = var_119_18

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_19 = 17
				local var_119_20 = utf8.len(var_119_18)
				local var_119_21 = var_119_19 <= 0 and var_119_16 or var_119_16 * (var_119_20 / var_119_19)

				if var_119_21 > 0 and var_119_16 < var_119_21 then
					arg_116_1.talkMaxDuration = var_119_21

					if var_119_21 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_21 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_18
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_22 and arg_116_1.time_ < var_119_15 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play320071029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 320071029
		arg_120_1.duration_ = 5.87

		local var_120_0 = {
			zh = 5.866,
			ja = 4.833
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play320071030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1056ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1056ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, -1, -5.75)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1056ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1056ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1056ui_story == nil then
				arg_120_1.var_.characterEffect1056ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect1056ui_story and not isNil(var_123_9) then
					arg_120_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1056ui_story then
				arg_120_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_123_13 = 0

			if var_123_13 < arg_120_1.time_ and arg_120_1.time_ <= var_123_13 + arg_123_0 then
				arg_120_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_123_14 = 0

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_123_15 = 0
			local var_123_16 = 0.775

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_17 = arg_120_1:FormatText(StoryNameCfg[605].name)

				arg_120_1.leftNameTxt_.text = var_123_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_18 = arg_120_1:GetWordFromCfg(320071029)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 31
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071029", "story_v_out_320071.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_320071", "320071029", "story_v_out_320071.awb") / 1000

					if var_123_23 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_15
					end

					if var_123_18.prefab_name ~= "" and arg_120_1.actors_[var_123_18.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_18.prefab_name].transform, "story_v_out_320071", "320071029", "story_v_out_320071.awb")

						arg_120_1:RecordAudio("320071029", var_123_24)
						arg_120_1:RecordAudio("320071029", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_320071", "320071029", "story_v_out_320071.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_320071", "320071029", "story_v_out_320071.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_15) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_15 + var_123_25 and arg_120_1.time_ < var_123_15 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play320071030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 320071030
		arg_124_1.duration_ = 9

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play320071031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 2

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				local var_127_1 = manager.ui.mainCamera.transform.localPosition
				local var_127_2 = Vector3.New(0, 0, 10) + Vector3.New(var_127_1.x, var_127_1.y, 0)
				local var_127_3 = arg_124_1.bgs_.STblack

				var_127_3.transform.localPosition = var_127_2
				var_127_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_4 = var_127_3:GetComponent("SpriteRenderer")

				if var_127_4 and var_127_4.sprite then
					local var_127_5 = (var_127_3.transform.localPosition - var_127_1).z
					local var_127_6 = manager.ui.mainCameraCom_
					local var_127_7 = 2 * var_127_5 * Mathf.Tan(var_127_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_127_8 = var_127_7 * var_127_6.aspect
					local var_127_9 = var_127_4.sprite.bounds.size.x
					local var_127_10 = var_127_4.sprite.bounds.size.y
					local var_127_11 = var_127_8 / var_127_9
					local var_127_12 = var_127_7 / var_127_10
					local var_127_13 = var_127_12 < var_127_11 and var_127_11 or var_127_12

					var_127_3.transform.localScale = Vector3.New(var_127_13, var_127_13, 0)
				end

				for iter_127_0, iter_127_1 in pairs(arg_124_1.bgs_) do
					if iter_127_0 ~= "STblack" then
						iter_127_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_127_14 = 4

			if var_127_14 < arg_124_1.time_ and arg_124_1.time_ <= var_127_14 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			local var_127_15 = 0.3

			if arg_124_1.time_ >= var_127_14 + var_127_15 and arg_124_1.time_ < var_127_14 + var_127_15 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end

			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_17 = 2

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_17 then
				local var_127_18 = (arg_124_1.time_ - var_127_16) / var_127_17
				local var_127_19 = Color.New(0, 0, 0)

				var_127_19.a = Mathf.Lerp(0, 1, var_127_18)
				arg_124_1.mask_.color = var_127_19
			end

			if arg_124_1.time_ >= var_127_16 + var_127_17 and arg_124_1.time_ < var_127_16 + var_127_17 + arg_127_0 then
				local var_127_20 = Color.New(0, 0, 0)

				var_127_20.a = 1
				arg_124_1.mask_.color = var_127_20
			end

			local var_127_21 = 2

			if var_127_21 < arg_124_1.time_ and arg_124_1.time_ <= var_127_21 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_22 = 2

			if var_127_21 <= arg_124_1.time_ and arg_124_1.time_ < var_127_21 + var_127_22 then
				local var_127_23 = (arg_124_1.time_ - var_127_21) / var_127_22
				local var_127_24 = Color.New(0, 0, 0)

				var_127_24.a = Mathf.Lerp(1, 0, var_127_23)
				arg_124_1.mask_.color = var_127_24
			end

			if arg_124_1.time_ >= var_127_21 + var_127_22 and arg_124_1.time_ < var_127_21 + var_127_22 + arg_127_0 then
				local var_127_25 = Color.New(0, 0, 0)
				local var_127_26 = 0

				arg_124_1.mask_.enabled = false
				var_127_25.a = var_127_26
				arg_124_1.mask_.color = var_127_25
			end

			local var_127_27 = arg_124_1.actors_["1056ui_story"].transform
			local var_127_28 = 1.96599999815226

			if var_127_28 < arg_124_1.time_ and arg_124_1.time_ <= var_127_28 + arg_127_0 then
				arg_124_1.var_.moveOldPos1056ui_story = var_127_27.localPosition
			end

			local var_127_29 = 0.001

			if var_127_28 <= arg_124_1.time_ and arg_124_1.time_ < var_127_28 + var_127_29 then
				local var_127_30 = (arg_124_1.time_ - var_127_28) / var_127_29
				local var_127_31 = Vector3.New(0, 100, 0)

				var_127_27.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1056ui_story, var_127_31, var_127_30)

				local var_127_32 = manager.ui.mainCamera.transform.position - var_127_27.position

				var_127_27.forward = Vector3.New(var_127_32.x, var_127_32.y, var_127_32.z)

				local var_127_33 = var_127_27.localEulerAngles

				var_127_33.z = 0
				var_127_33.x = 0
				var_127_27.localEulerAngles = var_127_33
			end

			if arg_124_1.time_ >= var_127_28 + var_127_29 and arg_124_1.time_ < var_127_28 + var_127_29 + arg_127_0 then
				var_127_27.localPosition = Vector3.New(0, 100, 0)

				local var_127_34 = manager.ui.mainCamera.transform.position - var_127_27.position

				var_127_27.forward = Vector3.New(var_127_34.x, var_127_34.y, var_127_34.z)

				local var_127_35 = var_127_27.localEulerAngles

				var_127_35.z = 0
				var_127_35.x = 0
				var_127_27.localEulerAngles = var_127_35
			end

			local var_127_36 = arg_124_1.actors_["1056ui_story"]
			local var_127_37 = 1.96599999815226

			if var_127_37 < arg_124_1.time_ and arg_124_1.time_ <= var_127_37 + arg_127_0 and not isNil(var_127_36) and arg_124_1.var_.characterEffect1056ui_story == nil then
				arg_124_1.var_.characterEffect1056ui_story = var_127_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_38 = 0.034000001847744

			if var_127_37 <= arg_124_1.time_ and arg_124_1.time_ < var_127_37 + var_127_38 and not isNil(var_127_36) then
				local var_127_39 = (arg_124_1.time_ - var_127_37) / var_127_38

				if arg_124_1.var_.characterEffect1056ui_story and not isNil(var_127_36) then
					local var_127_40 = Mathf.Lerp(0, 0.5, var_127_39)

					arg_124_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1056ui_story.fillRatio = var_127_40
				end
			end

			if arg_124_1.time_ >= var_127_37 + var_127_38 and arg_124_1.time_ < var_127_37 + var_127_38 + arg_127_0 and not isNil(var_127_36) and arg_124_1.var_.characterEffect1056ui_story then
				local var_127_41 = 0.5

				arg_124_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1056ui_story.fillRatio = var_127_41
			end

			if arg_124_1.frameCnt_ <= 1 then
				arg_124_1.dialog_:SetActive(false)
			end

			local var_127_42 = 4
			local var_127_43 = 1.05

			if var_127_42 < arg_124_1.time_ and arg_124_1.time_ <= var_127_42 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0

				arg_124_1.dialog_:SetActive(true)

				arg_124_1.dialogCg_.alpha = 0

				local var_127_44 = LeanTween.value(arg_124_1.dialog_, 0, 1, 0.3)

				var_127_44:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_124_1.dialogCg_.alpha = arg_128_0
				end))
				var_127_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_124_1.dialog_)
					var_127_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_124_1.duration_ = arg_124_1.duration_ + 0.3

				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_45 = arg_124_1:GetWordFromCfg(320071030)
				local var_127_46 = arg_124_1:FormatText(var_127_45.content)

				arg_124_1.text_.text = var_127_46

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_47 = 42
				local var_127_48 = utf8.len(var_127_46)
				local var_127_49 = var_127_47 <= 0 and var_127_43 or var_127_43 * (var_127_48 / var_127_47)

				if var_127_49 > 0 and var_127_43 < var_127_49 then
					arg_124_1.talkMaxDuration = var_127_49
					var_127_42 = var_127_42 + 0.3

					if var_127_49 + var_127_42 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_49 + var_127_42
					end
				end

				arg_124_1.text_.text = var_127_46
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_50 = var_127_42 + 0.3
			local var_127_51 = math.max(var_127_43, arg_124_1.talkMaxDuration)

			if var_127_50 <= arg_124_1.time_ and arg_124_1.time_ < var_127_50 + var_127_51 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_50) / var_127_51

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_50 + var_127_51 and arg_124_1.time_ < var_127_50 + var_127_51 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play320071031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 320071031
		arg_130_1.duration_ = 11.67

		local var_130_0 = {
			zh = 8.96600000298023,
			ja = 11.6660000029802
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play320071032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				local var_133_1 = manager.ui.mainCamera.transform.localPosition
				local var_133_2 = Vector3.New(0, 0, 10) + Vector3.New(var_133_1.x, var_133_1.y, 0)
				local var_133_3 = arg_130_1.bgs_.ST61

				var_133_3.transform.localPosition = var_133_2
				var_133_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_4 = var_133_3:GetComponent("SpriteRenderer")

				if var_133_4 and var_133_4.sprite then
					local var_133_5 = (var_133_3.transform.localPosition - var_133_1).z
					local var_133_6 = manager.ui.mainCameraCom_
					local var_133_7 = 2 * var_133_5 * Mathf.Tan(var_133_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_133_8 = var_133_7 * var_133_6.aspect
					local var_133_9 = var_133_4.sprite.bounds.size.x
					local var_133_10 = var_133_4.sprite.bounds.size.y
					local var_133_11 = var_133_8 / var_133_9
					local var_133_12 = var_133_7 / var_133_10
					local var_133_13 = var_133_12 < var_133_11 and var_133_11 or var_133_12

					var_133_3.transform.localScale = Vector3.New(var_133_13, var_133_13, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "ST61" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_14 = 2.00000000298023

			if var_133_14 < arg_130_1.time_ and arg_130_1.time_ <= var_133_14 + arg_133_0 then
				arg_130_1.allBtn_.enabled = false
			end

			local var_133_15 = 0.3

			if arg_130_1.time_ >= var_133_14 + var_133_15 and arg_130_1.time_ < var_133_14 + var_133_15 + arg_133_0 then
				arg_130_1.allBtn_.enabled = true
			end

			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.mask_.enabled = true
				arg_130_1.mask_.raycastTarget = true

				arg_130_1:SetGaussion(false)
			end

			local var_133_17 = 2

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_17 then
				local var_133_18 = (arg_130_1.time_ - var_133_16) / var_133_17
				local var_133_19 = Color.New(0, 0, 0)

				var_133_19.a = Mathf.Lerp(1, 0, var_133_18)
				arg_130_1.mask_.color = var_133_19
			end

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				local var_133_20 = Color.New(0, 0, 0)
				local var_133_21 = 0

				arg_130_1.mask_.enabled = false
				var_133_20.a = var_133_21
				arg_130_1.mask_.color = var_133_20
			end

			local var_133_22 = arg_130_1.actors_["10102ui_story"].transform
			local var_133_23 = 1.8

			if var_133_23 < arg_130_1.time_ and arg_130_1.time_ <= var_133_23 + arg_133_0 then
				arg_130_1.var_.moveOldPos10102ui_story = var_133_22.localPosition
			end

			local var_133_24 = 0.001

			if var_133_23 <= arg_130_1.time_ and arg_130_1.time_ < var_133_23 + var_133_24 then
				local var_133_25 = (arg_130_1.time_ - var_133_23) / var_133_24
				local var_133_26 = Vector3.New(0, -0.985, -6.275)

				var_133_22.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10102ui_story, var_133_26, var_133_25)

				local var_133_27 = manager.ui.mainCamera.transform.position - var_133_22.position

				var_133_22.forward = Vector3.New(var_133_27.x, var_133_27.y, var_133_27.z)

				local var_133_28 = var_133_22.localEulerAngles

				var_133_28.z = 0
				var_133_28.x = 0
				var_133_22.localEulerAngles = var_133_28
			end

			if arg_130_1.time_ >= var_133_23 + var_133_24 and arg_130_1.time_ < var_133_23 + var_133_24 + arg_133_0 then
				var_133_22.localPosition = Vector3.New(0, -0.985, -6.275)

				local var_133_29 = manager.ui.mainCamera.transform.position - var_133_22.position

				var_133_22.forward = Vector3.New(var_133_29.x, var_133_29.y, var_133_29.z)

				local var_133_30 = var_133_22.localEulerAngles

				var_133_30.z = 0
				var_133_30.x = 0
				var_133_22.localEulerAngles = var_133_30
			end

			local var_133_31 = arg_130_1.actors_["10102ui_story"]
			local var_133_32 = 1.8

			if var_133_32 < arg_130_1.time_ and arg_130_1.time_ <= var_133_32 + arg_133_0 and not isNil(var_133_31) and arg_130_1.var_.characterEffect10102ui_story == nil then
				arg_130_1.var_.characterEffect10102ui_story = var_133_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_33 = 0.200000002980232

			if var_133_32 <= arg_130_1.time_ and arg_130_1.time_ < var_133_32 + var_133_33 and not isNil(var_133_31) then
				local var_133_34 = (arg_130_1.time_ - var_133_32) / var_133_33

				if arg_130_1.var_.characterEffect10102ui_story and not isNil(var_133_31) then
					arg_130_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_32 + var_133_33 and arg_130_1.time_ < var_133_32 + var_133_33 + arg_133_0 and not isNil(var_133_31) and arg_130_1.var_.characterEffect10102ui_story then
				arg_130_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_133_35 = 1.8

			if var_133_35 < arg_130_1.time_ and arg_130_1.time_ <= var_133_35 + arg_133_0 then
				arg_130_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			local var_133_36 = 1.8

			if var_133_36 < arg_130_1.time_ and arg_130_1.time_ <= var_133_36 + arg_133_0 then
				arg_130_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_130_1.frameCnt_ <= 1 then
				arg_130_1.dialog_:SetActive(false)
			end

			local var_133_37 = 2.00000000298023
			local var_133_38 = 0.75

			if var_133_37 < arg_130_1.time_ and arg_130_1.time_ <= var_133_37 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				arg_130_1.dialog_:SetActive(true)

				arg_130_1.dialogCg_.alpha = 0

				local var_133_39 = LeanTween.value(arg_130_1.dialog_, 0, 1, 0.3)

				var_133_39:setOnUpdate(LuaHelper.FloatAction(function(arg_134_0)
					arg_130_1.dialogCg_.alpha = arg_134_0
				end))
				var_133_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_130_1.dialog_)
					var_133_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_130_1.duration_ = arg_130_1.duration_ + 0.3

				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_40 = arg_130_1:FormatText(StoryNameCfg[6].name)

				arg_130_1.leftNameTxt_.text = var_133_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_41 = arg_130_1:GetWordFromCfg(320071031)
				local var_133_42 = arg_130_1:FormatText(var_133_41.content)

				arg_130_1.text_.text = var_133_42

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_43 = 30
				local var_133_44 = utf8.len(var_133_42)
				local var_133_45 = var_133_43 <= 0 and var_133_38 or var_133_38 * (var_133_44 / var_133_43)

				if var_133_45 > 0 and var_133_38 < var_133_45 then
					arg_130_1.talkMaxDuration = var_133_45
					var_133_37 = var_133_37 + 0.3

					if var_133_45 + var_133_37 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_45 + var_133_37
					end
				end

				arg_130_1.text_.text = var_133_42
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071031", "story_v_out_320071.awb") ~= 0 then
					local var_133_46 = manager.audio:GetVoiceLength("story_v_out_320071", "320071031", "story_v_out_320071.awb") / 1000

					if var_133_46 + var_133_37 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_46 + var_133_37
					end

					if var_133_41.prefab_name ~= "" and arg_130_1.actors_[var_133_41.prefab_name] ~= nil then
						local var_133_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_41.prefab_name].transform, "story_v_out_320071", "320071031", "story_v_out_320071.awb")

						arg_130_1:RecordAudio("320071031", var_133_47)
						arg_130_1:RecordAudio("320071031", var_133_47)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_320071", "320071031", "story_v_out_320071.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_320071", "320071031", "story_v_out_320071.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_48 = var_133_37 + 0.3
			local var_133_49 = math.max(var_133_38, arg_130_1.talkMaxDuration)

			if var_133_48 <= arg_130_1.time_ and arg_130_1.time_ < var_133_48 + var_133_49 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_48) / var_133_49

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_48 + var_133_49 and arg_130_1.time_ < var_133_48 + var_133_49 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play320071032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 320071032
		arg_136_1.duration_ = 9.3

		local var_136_0 = {
			zh = 7.2,
			ja = 9.3
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play320071033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10102ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos10102ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10102ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["10102ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect10102ui_story == nil then
				arg_136_1.var_.characterEffect10102ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.200000002980232

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect10102ui_story and not isNil(var_139_9) then
					local var_139_13 = Mathf.Lerp(0, 0.5, var_139_12)

					arg_136_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10102ui_story.fillRatio = var_139_13
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect10102ui_story then
				local var_139_14 = 0.5

				arg_136_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10102ui_story.fillRatio = var_139_14
			end

			local var_139_15 = arg_136_1.actors_["1056ui_story"].transform
			local var_139_16 = 0

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1.var_.moveOldPos1056ui_story = var_139_15.localPosition
			end

			local var_139_17 = 0.001

			if var_139_16 <= arg_136_1.time_ and arg_136_1.time_ < var_139_16 + var_139_17 then
				local var_139_18 = (arg_136_1.time_ - var_139_16) / var_139_17
				local var_139_19 = Vector3.New(0.7, -1, -5.75)

				var_139_15.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1056ui_story, var_139_19, var_139_18)

				local var_139_20 = manager.ui.mainCamera.transform.position - var_139_15.position

				var_139_15.forward = Vector3.New(var_139_20.x, var_139_20.y, var_139_20.z)

				local var_139_21 = var_139_15.localEulerAngles

				var_139_21.z = 0
				var_139_21.x = 0
				var_139_15.localEulerAngles = var_139_21
			end

			if arg_136_1.time_ >= var_139_16 + var_139_17 and arg_136_1.time_ < var_139_16 + var_139_17 + arg_139_0 then
				var_139_15.localPosition = Vector3.New(0.7, -1, -5.75)

				local var_139_22 = manager.ui.mainCamera.transform.position - var_139_15.position

				var_139_15.forward = Vector3.New(var_139_22.x, var_139_22.y, var_139_22.z)

				local var_139_23 = var_139_15.localEulerAngles

				var_139_23.z = 0
				var_139_23.x = 0
				var_139_15.localEulerAngles = var_139_23
			end

			local var_139_24 = arg_136_1.actors_["1056ui_story"]
			local var_139_25 = 0

			if var_139_25 < arg_136_1.time_ and arg_136_1.time_ <= var_139_25 + arg_139_0 and not isNil(var_139_24) and arg_136_1.var_.characterEffect1056ui_story == nil then
				arg_136_1.var_.characterEffect1056ui_story = var_139_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_26 = 0.200000002980232

			if var_139_25 <= arg_136_1.time_ and arg_136_1.time_ < var_139_25 + var_139_26 and not isNil(var_139_24) then
				local var_139_27 = (arg_136_1.time_ - var_139_25) / var_139_26

				if arg_136_1.var_.characterEffect1056ui_story and not isNil(var_139_24) then
					arg_136_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_25 + var_139_26 and arg_136_1.time_ < var_139_25 + var_139_26 + arg_139_0 and not isNil(var_139_24) and arg_136_1.var_.characterEffect1056ui_story then
				arg_136_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_139_28 = 0

			if var_139_28 < arg_136_1.time_ and arg_136_1.time_ <= var_139_28 + arg_139_0 then
				arg_136_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_139_29 = 0

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				arg_136_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_139_30 = 0
			local var_139_31 = 0.925

			if var_139_30 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_32 = arg_136_1:FormatText(StoryNameCfg[605].name)

				arg_136_1.leftNameTxt_.text = var_139_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_33 = arg_136_1:GetWordFromCfg(320071032)
				local var_139_34 = arg_136_1:FormatText(var_139_33.content)

				arg_136_1.text_.text = var_139_34

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_35 = 37
				local var_139_36 = utf8.len(var_139_34)
				local var_139_37 = var_139_35 <= 0 and var_139_31 or var_139_31 * (var_139_36 / var_139_35)

				if var_139_37 > 0 and var_139_31 < var_139_37 then
					arg_136_1.talkMaxDuration = var_139_37

					if var_139_37 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_37 + var_139_30
					end
				end

				arg_136_1.text_.text = var_139_34
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071032", "story_v_out_320071.awb") ~= 0 then
					local var_139_38 = manager.audio:GetVoiceLength("story_v_out_320071", "320071032", "story_v_out_320071.awb") / 1000

					if var_139_38 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_38 + var_139_30
					end

					if var_139_33.prefab_name ~= "" and arg_136_1.actors_[var_139_33.prefab_name] ~= nil then
						local var_139_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_33.prefab_name].transform, "story_v_out_320071", "320071032", "story_v_out_320071.awb")

						arg_136_1:RecordAudio("320071032", var_139_39)
						arg_136_1:RecordAudio("320071032", var_139_39)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_320071", "320071032", "story_v_out_320071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_320071", "320071032", "story_v_out_320071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_40 = math.max(var_139_31, arg_136_1.talkMaxDuration)

			if var_139_30 <= arg_136_1.time_ and arg_136_1.time_ < var_139_30 + var_139_40 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_30) / var_139_40

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_30 + var_139_40 and arg_136_1.time_ < var_139_30 + var_139_40 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play320071033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 320071033
		arg_140_1.duration_ = 8.4

		local var_140_0 = {
			zh = 8.4,
			ja = 8.133
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play320071034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_143_1 = 0
			local var_143_2 = 1.175

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_3 = arg_140_1:FormatText(StoryNameCfg[605].name)

				arg_140_1.leftNameTxt_.text = var_143_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(320071033)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_6 = 47
				local var_143_7 = utf8.len(var_143_5)
				local var_143_8 = var_143_6 <= 0 and var_143_2 or var_143_2 * (var_143_7 / var_143_6)

				if var_143_8 > 0 and var_143_2 < var_143_8 then
					arg_140_1.talkMaxDuration = var_143_8

					if var_143_8 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071033", "story_v_out_320071.awb") ~= 0 then
					local var_143_9 = manager.audio:GetVoiceLength("story_v_out_320071", "320071033", "story_v_out_320071.awb") / 1000

					if var_143_9 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_1
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_320071", "320071033", "story_v_out_320071.awb")

						arg_140_1:RecordAudio("320071033", var_143_10)
						arg_140_1:RecordAudio("320071033", var_143_10)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_320071", "320071033", "story_v_out_320071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_320071", "320071033", "story_v_out_320071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_11 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_11 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_11

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_11 and arg_140_1.time_ < var_143_1 + var_143_11 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play320071034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 320071034
		arg_144_1.duration_ = 4

		local var_144_0 = {
			zh = 2.033,
			ja = 4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play320071035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10102ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos10102ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(-0.7, -0.985, -6.275)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10102ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(-0.7, -0.985, -6.275)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = arg_144_1.actors_["10102ui_story"]
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect10102ui_story == nil then
				arg_144_1.var_.characterEffect10102ui_story = var_147_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_11 = 0.200000002980232

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_11 and not isNil(var_147_9) then
				local var_147_12 = (arg_144_1.time_ - var_147_10) / var_147_11

				if arg_144_1.var_.characterEffect10102ui_story and not isNil(var_147_9) then
					arg_144_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect10102ui_story then
				arg_144_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_147_13 = 0

			if var_147_13 < arg_144_1.time_ and arg_144_1.time_ <= var_147_13 + arg_147_0 then
				arg_144_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			local var_147_14 = 0

			if var_147_14 < arg_144_1.time_ and arg_144_1.time_ <= var_147_14 + arg_147_0 then
				arg_144_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_147_15 = arg_144_1.actors_["1056ui_story"]
			local var_147_16 = 0

			if var_147_16 < arg_144_1.time_ and arg_144_1.time_ <= var_147_16 + arg_147_0 and not isNil(var_147_15) and arg_144_1.var_.characterEffect1056ui_story == nil then
				arg_144_1.var_.characterEffect1056ui_story = var_147_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_17 = 0.200000002980232

			if var_147_16 <= arg_144_1.time_ and arg_144_1.time_ < var_147_16 + var_147_17 and not isNil(var_147_15) then
				local var_147_18 = (arg_144_1.time_ - var_147_16) / var_147_17

				if arg_144_1.var_.characterEffect1056ui_story and not isNil(var_147_15) then
					local var_147_19 = Mathf.Lerp(0, 0.5, var_147_18)

					arg_144_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1056ui_story.fillRatio = var_147_19
				end
			end

			if arg_144_1.time_ >= var_147_16 + var_147_17 and arg_144_1.time_ < var_147_16 + var_147_17 + arg_147_0 and not isNil(var_147_15) and arg_144_1.var_.characterEffect1056ui_story then
				local var_147_20 = 0.5

				arg_144_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1056ui_story.fillRatio = var_147_20
			end

			local var_147_21 = 0
			local var_147_22 = 0.175

			if var_147_21 < arg_144_1.time_ and arg_144_1.time_ <= var_147_21 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_23 = arg_144_1:FormatText(StoryNameCfg[6].name)

				arg_144_1.leftNameTxt_.text = var_147_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_24 = arg_144_1:GetWordFromCfg(320071034)
				local var_147_25 = arg_144_1:FormatText(var_147_24.content)

				arg_144_1.text_.text = var_147_25

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_26 = 7
				local var_147_27 = utf8.len(var_147_25)
				local var_147_28 = var_147_26 <= 0 and var_147_22 or var_147_22 * (var_147_27 / var_147_26)

				if var_147_28 > 0 and var_147_22 < var_147_28 then
					arg_144_1.talkMaxDuration = var_147_28

					if var_147_28 + var_147_21 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_28 + var_147_21
					end
				end

				arg_144_1.text_.text = var_147_25
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071034", "story_v_out_320071.awb") ~= 0 then
					local var_147_29 = manager.audio:GetVoiceLength("story_v_out_320071", "320071034", "story_v_out_320071.awb") / 1000

					if var_147_29 + var_147_21 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_29 + var_147_21
					end

					if var_147_24.prefab_name ~= "" and arg_144_1.actors_[var_147_24.prefab_name] ~= nil then
						local var_147_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_24.prefab_name].transform, "story_v_out_320071", "320071034", "story_v_out_320071.awb")

						arg_144_1:RecordAudio("320071034", var_147_30)
						arg_144_1:RecordAudio("320071034", var_147_30)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_320071", "320071034", "story_v_out_320071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_320071", "320071034", "story_v_out_320071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_31 = math.max(var_147_22, arg_144_1.talkMaxDuration)

			if var_147_21 <= arg_144_1.time_ and arg_144_1.time_ < var_147_21 + var_147_31 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_21) / var_147_31

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_21 + var_147_31 and arg_144_1.time_ < var_147_21 + var_147_31 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play320071035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 320071035
		arg_148_1.duration_ = 7.57

		local var_148_0 = {
			zh = 7.566,
			ja = 7.266
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play320071036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1056ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1056ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0.7, -1, -5.75)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1056ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0.7, -1, -5.75)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1056ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1056ui_story == nil then
				arg_148_1.var_.characterEffect1056ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect1056ui_story and not isNil(var_151_9) then
					arg_148_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1056ui_story then
				arg_148_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_151_13 = 0

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_15 = arg_148_1.actors_["10102ui_story"]
			local var_151_16 = 0

			if var_151_16 < arg_148_1.time_ and arg_148_1.time_ <= var_151_16 + arg_151_0 and not isNil(var_151_15) and arg_148_1.var_.characterEffect10102ui_story == nil then
				arg_148_1.var_.characterEffect10102ui_story = var_151_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_17 = 0.200000002980232

			if var_151_16 <= arg_148_1.time_ and arg_148_1.time_ < var_151_16 + var_151_17 and not isNil(var_151_15) then
				local var_151_18 = (arg_148_1.time_ - var_151_16) / var_151_17

				if arg_148_1.var_.characterEffect10102ui_story and not isNil(var_151_15) then
					local var_151_19 = Mathf.Lerp(0, 0.5, var_151_18)

					arg_148_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10102ui_story.fillRatio = var_151_19
				end
			end

			if arg_148_1.time_ >= var_151_16 + var_151_17 and arg_148_1.time_ < var_151_16 + var_151_17 + arg_151_0 and not isNil(var_151_15) and arg_148_1.var_.characterEffect10102ui_story then
				local var_151_20 = 0.5

				arg_148_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10102ui_story.fillRatio = var_151_20
			end

			local var_151_21 = 0
			local var_151_22 = 0.75

			if var_151_21 < arg_148_1.time_ and arg_148_1.time_ <= var_151_21 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_23 = arg_148_1:FormatText(StoryNameCfg[605].name)

				arg_148_1.leftNameTxt_.text = var_151_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_24 = arg_148_1:GetWordFromCfg(320071035)
				local var_151_25 = arg_148_1:FormatText(var_151_24.content)

				arg_148_1.text_.text = var_151_25

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_26 = 30
				local var_151_27 = utf8.len(var_151_25)
				local var_151_28 = var_151_26 <= 0 and var_151_22 or var_151_22 * (var_151_27 / var_151_26)

				if var_151_28 > 0 and var_151_22 < var_151_28 then
					arg_148_1.talkMaxDuration = var_151_28

					if var_151_28 + var_151_21 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_28 + var_151_21
					end
				end

				arg_148_1.text_.text = var_151_25
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071035", "story_v_out_320071.awb") ~= 0 then
					local var_151_29 = manager.audio:GetVoiceLength("story_v_out_320071", "320071035", "story_v_out_320071.awb") / 1000

					if var_151_29 + var_151_21 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_29 + var_151_21
					end

					if var_151_24.prefab_name ~= "" and arg_148_1.actors_[var_151_24.prefab_name] ~= nil then
						local var_151_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_24.prefab_name].transform, "story_v_out_320071", "320071035", "story_v_out_320071.awb")

						arg_148_1:RecordAudio("320071035", var_151_30)
						arg_148_1:RecordAudio("320071035", var_151_30)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_320071", "320071035", "story_v_out_320071.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_320071", "320071035", "story_v_out_320071.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_31 = math.max(var_151_22, arg_148_1.talkMaxDuration)

			if var_151_21 <= arg_148_1.time_ and arg_148_1.time_ < var_151_21 + var_151_31 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_21) / var_151_31

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_21 + var_151_31 and arg_148_1.time_ < var_151_21 + var_151_31 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320071036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 320071036
		arg_152_1.duration_ = 8.5

		local var_152_0 = {
			zh = 5,
			ja = 8.5
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play320071037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_155_1 = 0
			local var_155_2 = 0.725

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_3 = arg_152_1:FormatText(StoryNameCfg[605].name)

				arg_152_1.leftNameTxt_.text = var_155_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_4 = arg_152_1:GetWordFromCfg(320071036)
				local var_155_5 = arg_152_1:FormatText(var_155_4.content)

				arg_152_1.text_.text = var_155_5

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_6 = 29
				local var_155_7 = utf8.len(var_155_5)
				local var_155_8 = var_155_6 <= 0 and var_155_2 or var_155_2 * (var_155_7 / var_155_6)

				if var_155_8 > 0 and var_155_2 < var_155_8 then
					arg_152_1.talkMaxDuration = var_155_8

					if var_155_8 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_5
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071036", "story_v_out_320071.awb") ~= 0 then
					local var_155_9 = manager.audio:GetVoiceLength("story_v_out_320071", "320071036", "story_v_out_320071.awb") / 1000

					if var_155_9 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_1
					end

					if var_155_4.prefab_name ~= "" and arg_152_1.actors_[var_155_4.prefab_name] ~= nil then
						local var_155_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_4.prefab_name].transform, "story_v_out_320071", "320071036", "story_v_out_320071.awb")

						arg_152_1:RecordAudio("320071036", var_155_10)
						arg_152_1:RecordAudio("320071036", var_155_10)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_320071", "320071036", "story_v_out_320071.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_320071", "320071036", "story_v_out_320071.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_11 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_11 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_11

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_11 and arg_152_1.time_ < var_155_1 + var_155_11 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play320071037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 320071037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play320071038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1056ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1056ui_story == nil then
				arg_156_1.var_.characterEffect1056ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1056ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1056ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1056ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1056ui_story.fillRatio = var_159_5
			end

			local var_159_6 = 0
			local var_159_7 = 0.125

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_8 = arg_156_1:FormatText(StoryNameCfg[7].name)

				arg_156_1.leftNameTxt_.text = var_159_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_9 = arg_156_1:GetWordFromCfg(320071037)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 5
				local var_159_12 = utf8.len(var_159_10)
				local var_159_13 = var_159_11 <= 0 and var_159_7 or var_159_7 * (var_159_12 / var_159_11)

				if var_159_13 > 0 and var_159_7 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play320071038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 320071038
		arg_160_1.duration_ = 7.8

		local var_160_0 = {
			zh = 7.5,
			ja = 7.8
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play320071039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1056ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1056ui_story == nil then
				arg_160_1.var_.characterEffect1056ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1056ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1056ui_story then
				arg_160_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_163_4 = 0

			if var_163_4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_163_5 = 0
			local var_163_6 = 0.95

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_7 = arg_160_1:FormatText(StoryNameCfg[605].name)

				arg_160_1.leftNameTxt_.text = var_163_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:GetWordFromCfg(320071038)
				local var_163_9 = arg_160_1:FormatText(var_163_8.content)

				arg_160_1.text_.text = var_163_9

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_10 = 38
				local var_163_11 = utf8.len(var_163_9)
				local var_163_12 = var_163_10 <= 0 and var_163_6 or var_163_6 * (var_163_11 / var_163_10)

				if var_163_12 > 0 and var_163_6 < var_163_12 then
					arg_160_1.talkMaxDuration = var_163_12

					if var_163_12 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_5
					end
				end

				arg_160_1.text_.text = var_163_9
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071038", "story_v_out_320071.awb") ~= 0 then
					local var_163_13 = manager.audio:GetVoiceLength("story_v_out_320071", "320071038", "story_v_out_320071.awb") / 1000

					if var_163_13 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_5
					end

					if var_163_8.prefab_name ~= "" and arg_160_1.actors_[var_163_8.prefab_name] ~= nil then
						local var_163_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_8.prefab_name].transform, "story_v_out_320071", "320071038", "story_v_out_320071.awb")

						arg_160_1:RecordAudio("320071038", var_163_14)
						arg_160_1:RecordAudio("320071038", var_163_14)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_320071", "320071038", "story_v_out_320071.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_320071", "320071038", "story_v_out_320071.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_15 = math.max(var_163_6, arg_160_1.talkMaxDuration)

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_15 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_5) / var_163_15

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_5 + var_163_15 and arg_160_1.time_ < var_163_5 + var_163_15 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play320071039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 320071039
		arg_164_1.duration_ = 6.37

		local var_164_0 = {
			zh = 6.366,
			ja = 4.7
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play320071040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.825

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[605].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:GetWordFromCfg(320071039)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071039", "story_v_out_320071.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071039", "story_v_out_320071.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_320071", "320071039", "story_v_out_320071.awb")

						arg_164_1:RecordAudio("320071039", var_167_9)
						arg_164_1:RecordAudio("320071039", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_320071", "320071039", "story_v_out_320071.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_320071", "320071039", "story_v_out_320071.awb")
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
	Play320071040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 320071040
		arg_168_1.duration_ = 5.87

		local var_168_0 = {
			zh = 2.866,
			ja = 5.866
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play320071041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10102ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10102ui_story == nil then
				arg_168_1.var_.characterEffect10102ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10102ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10102ui_story then
				arg_168_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action465")
			end

			local var_171_5 = 0

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_171_6 = arg_168_1.actors_["1056ui_story"]
			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1056ui_story == nil then
				arg_168_1.var_.characterEffect1056ui_story = var_171_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_8 = 0.200000002980232

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_8 and not isNil(var_171_6) then
				local var_171_9 = (arg_168_1.time_ - var_171_7) / var_171_8

				if arg_168_1.var_.characterEffect1056ui_story and not isNil(var_171_6) then
					local var_171_10 = Mathf.Lerp(0, 0.5, var_171_9)

					arg_168_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1056ui_story.fillRatio = var_171_10
				end
			end

			if arg_168_1.time_ >= var_171_7 + var_171_8 and arg_168_1.time_ < var_171_7 + var_171_8 + arg_171_0 and not isNil(var_171_6) and arg_168_1.var_.characterEffect1056ui_story then
				local var_171_11 = 0.5

				arg_168_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1056ui_story.fillRatio = var_171_11
			end

			local var_171_12 = 0
			local var_171_13 = 0.3

			if var_171_12 < arg_168_1.time_ and arg_168_1.time_ <= var_171_12 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_14 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_15 = arg_168_1:GetWordFromCfg(320071040)
				local var_171_16 = arg_168_1:FormatText(var_171_15.content)

				arg_168_1.text_.text = var_171_16

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_17 = 12
				local var_171_18 = utf8.len(var_171_16)
				local var_171_19 = var_171_17 <= 0 and var_171_13 or var_171_13 * (var_171_18 / var_171_17)

				if var_171_19 > 0 and var_171_13 < var_171_19 then
					arg_168_1.talkMaxDuration = var_171_19

					if var_171_19 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_12
					end
				end

				arg_168_1.text_.text = var_171_16
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071040", "story_v_out_320071.awb") ~= 0 then
					local var_171_20 = manager.audio:GetVoiceLength("story_v_out_320071", "320071040", "story_v_out_320071.awb") / 1000

					if var_171_20 + var_171_12 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_20 + var_171_12
					end

					if var_171_15.prefab_name ~= "" and arg_168_1.actors_[var_171_15.prefab_name] ~= nil then
						local var_171_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_15.prefab_name].transform, "story_v_out_320071", "320071040", "story_v_out_320071.awb")

						arg_168_1:RecordAudio("320071040", var_171_21)
						arg_168_1:RecordAudio("320071040", var_171_21)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_320071", "320071040", "story_v_out_320071.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_320071", "320071040", "story_v_out_320071.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_22 = math.max(var_171_13, arg_168_1.talkMaxDuration)

			if var_171_12 <= arg_168_1.time_ and arg_168_1.time_ < var_171_12 + var_171_22 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_12) / var_171_22

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_12 + var_171_22 and arg_168_1.time_ < var_171_12 + var_171_22 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play320071041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 320071041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play320071042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10102ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10102ui_story == nil then
				arg_172_1.var_.characterEffect10102ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10102ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_172_1.var_.characterEffect10102ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10102ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_172_1.var_.characterEffect10102ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 1.05

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_8 = arg_172_1:GetWordFromCfg(320071041)
				local var_175_9 = arg_172_1:FormatText(var_175_8.content)

				arg_172_1.text_.text = var_175_9

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_10 = 42
				local var_175_11 = utf8.len(var_175_9)
				local var_175_12 = var_175_10 <= 0 and var_175_7 or var_175_7 * (var_175_11 / var_175_10)

				if var_175_12 > 0 and var_175_7 < var_175_12 then
					arg_172_1.talkMaxDuration = var_175_12

					if var_175_12 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_9
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_13 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_13

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_13 and arg_172_1.time_ < var_175_6 + var_175_13 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play320071042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 320071042
		arg_176_1.duration_ = 8

		local var_176_0 = {
			zh = 4.866,
			ja = 8
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play320071043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1056ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos1056ui_story = var_179_0.localPosition
			end

			local var_179_2 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2
				local var_179_4 = Vector3.New(0.7, -1, -5.75)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1056ui_story, var_179_4, var_179_3)

				local var_179_5 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_5.x, var_179_5.y, var_179_5.z)

				local var_179_6 = var_179_0.localEulerAngles

				var_179_6.z = 0
				var_179_6.x = 0
				var_179_0.localEulerAngles = var_179_6
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0.7, -1, -5.75)

				local var_179_7 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_7.x, var_179_7.y, var_179_7.z)

				local var_179_8 = var_179_0.localEulerAngles

				var_179_8.z = 0
				var_179_8.x = 0
				var_179_0.localEulerAngles = var_179_8
			end

			local var_179_9 = arg_176_1.actors_["1056ui_story"]
			local var_179_10 = 0

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1056ui_story == nil then
				arg_176_1.var_.characterEffect1056ui_story = var_179_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_11 = 0.200000002980232

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_11 and not isNil(var_179_9) then
				local var_179_12 = (arg_176_1.time_ - var_179_10) / var_179_11

				if arg_176_1.var_.characterEffect1056ui_story and not isNil(var_179_9) then
					arg_176_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_10 + var_179_11 and arg_176_1.time_ < var_179_10 + var_179_11 + arg_179_0 and not isNil(var_179_9) and arg_176_1.var_.characterEffect1056ui_story then
				arg_176_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_179_13 = 0

			if var_179_13 < arg_176_1.time_ and arg_176_1.time_ <= var_179_13 + arg_179_0 then
				arg_176_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_1")
			end

			local var_179_14 = 0

			if var_179_14 < arg_176_1.time_ and arg_176_1.time_ <= var_179_14 + arg_179_0 then
				arg_176_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_179_15 = 0
			local var_179_16 = 0.475

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_17 = arg_176_1:FormatText(StoryNameCfg[605].name)

				arg_176_1.leftNameTxt_.text = var_179_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_18 = arg_176_1:GetWordFromCfg(320071042)
				local var_179_19 = arg_176_1:FormatText(var_179_18.content)

				arg_176_1.text_.text = var_179_19

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_20 = 19
				local var_179_21 = utf8.len(var_179_19)
				local var_179_22 = var_179_20 <= 0 and var_179_16 or var_179_16 * (var_179_21 / var_179_20)

				if var_179_22 > 0 and var_179_16 < var_179_22 then
					arg_176_1.talkMaxDuration = var_179_22

					if var_179_22 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_22 + var_179_15
					end
				end

				arg_176_1.text_.text = var_179_19
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071042", "story_v_out_320071.awb") ~= 0 then
					local var_179_23 = manager.audio:GetVoiceLength("story_v_out_320071", "320071042", "story_v_out_320071.awb") / 1000

					if var_179_23 + var_179_15 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_23 + var_179_15
					end

					if var_179_18.prefab_name ~= "" and arg_176_1.actors_[var_179_18.prefab_name] ~= nil then
						local var_179_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_18.prefab_name].transform, "story_v_out_320071", "320071042", "story_v_out_320071.awb")

						arg_176_1:RecordAudio("320071042", var_179_24)
						arg_176_1:RecordAudio("320071042", var_179_24)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_320071", "320071042", "story_v_out_320071.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_320071", "320071042", "story_v_out_320071.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_25 = math.max(var_179_16, arg_176_1.talkMaxDuration)

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_25 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_15) / var_179_25

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_15 + var_179_25 and arg_176_1.time_ < var_179_15 + var_179_25 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320071043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 320071043
		arg_180_1.duration_ = 13.03

		local var_180_0 = {
			zh = 7.066,
			ja = 13.033
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play320071044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action5_2")
			end

			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_183_2 = 0
			local var_183_3 = 1

			if var_183_2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_4 = arg_180_1:FormatText(StoryNameCfg[605].name)

				arg_180_1.leftNameTxt_.text = var_183_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:GetWordFromCfg(320071043)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 40
				local var_183_8 = utf8.len(var_183_6)
				local var_183_9 = var_183_7 <= 0 and var_183_3 or var_183_3 * (var_183_8 / var_183_7)

				if var_183_9 > 0 and var_183_3 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_6
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071043", "story_v_out_320071.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_out_320071", "320071043", "story_v_out_320071.awb") / 1000

					if var_183_10 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_2
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_out_320071", "320071043", "story_v_out_320071.awb")

						arg_180_1:RecordAudio("320071043", var_183_11)
						arg_180_1:RecordAudio("320071043", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_320071", "320071043", "story_v_out_320071.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_320071", "320071043", "story_v_out_320071.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_12 and arg_180_1.time_ < var_183_2 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play320071044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 320071044
		arg_184_1.duration_ = 5.97

		local var_184_0 = {
			zh = 5.966,
			ja = 5.2
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play320071045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10102ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10102ui_story == nil then
				arg_184_1.var_.characterEffect10102ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10102ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10102ui_story then
				arg_184_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_187_6 = arg_184_1.actors_["1056ui_story"]
			local var_187_7 = 0

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 and not isNil(var_187_6) and arg_184_1.var_.characterEffect1056ui_story == nil then
				arg_184_1.var_.characterEffect1056ui_story = var_187_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_8 = 0.200000002980232

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_8 and not isNil(var_187_6) then
				local var_187_9 = (arg_184_1.time_ - var_187_7) / var_187_8

				if arg_184_1.var_.characterEffect1056ui_story and not isNil(var_187_6) then
					local var_187_10 = Mathf.Lerp(0, 0.5, var_187_9)

					arg_184_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1056ui_story.fillRatio = var_187_10
				end
			end

			if arg_184_1.time_ >= var_187_7 + var_187_8 and arg_184_1.time_ < var_187_7 + var_187_8 + arg_187_0 and not isNil(var_187_6) and arg_184_1.var_.characterEffect1056ui_story then
				local var_187_11 = 0.5

				arg_184_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1056ui_story.fillRatio = var_187_11
			end

			local var_187_12 = 0
			local var_187_13 = 0.775

			if var_187_12 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_14 = arg_184_1:FormatText(StoryNameCfg[6].name)

				arg_184_1.leftNameTxt_.text = var_187_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_15 = arg_184_1:GetWordFromCfg(320071044)
				local var_187_16 = arg_184_1:FormatText(var_187_15.content)

				arg_184_1.text_.text = var_187_16

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_17 = 31
				local var_187_18 = utf8.len(var_187_16)
				local var_187_19 = var_187_17 <= 0 and var_187_13 or var_187_13 * (var_187_18 / var_187_17)

				if var_187_19 > 0 and var_187_13 < var_187_19 then
					arg_184_1.talkMaxDuration = var_187_19

					if var_187_19 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_19 + var_187_12
					end
				end

				arg_184_1.text_.text = var_187_16
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071044", "story_v_out_320071.awb") ~= 0 then
					local var_187_20 = manager.audio:GetVoiceLength("story_v_out_320071", "320071044", "story_v_out_320071.awb") / 1000

					if var_187_20 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_20 + var_187_12
					end

					if var_187_15.prefab_name ~= "" and arg_184_1.actors_[var_187_15.prefab_name] ~= nil then
						local var_187_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_15.prefab_name].transform, "story_v_out_320071", "320071044", "story_v_out_320071.awb")

						arg_184_1:RecordAudio("320071044", var_187_21)
						arg_184_1:RecordAudio("320071044", var_187_21)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_320071", "320071044", "story_v_out_320071.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_320071", "320071044", "story_v_out_320071.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_22 = math.max(var_187_13, arg_184_1.talkMaxDuration)

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_22 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_12) / var_187_22

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_12 + var_187_22 and arg_184_1.time_ < var_187_12 + var_187_22 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play320071045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 320071045
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play320071046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10102ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10102ui_story == nil then
				arg_188_1.var_.characterEffect10102ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect10102ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10102ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10102ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10102ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.525

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_8 = arg_188_1:FormatText(StoryNameCfg[7].name)

				arg_188_1.leftNameTxt_.text = var_191_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_9 = arg_188_1:GetWordFromCfg(320071045)
				local var_191_10 = arg_188_1:FormatText(var_191_9.content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 21
				local var_191_12 = utf8.len(var_191_10)
				local var_191_13 = var_191_11 <= 0 and var_191_7 or var_191_7 * (var_191_12 / var_191_11)

				if var_191_13 > 0 and var_191_7 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_10
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_14 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_14 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_14

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_14 and arg_188_1.time_ < var_191_6 + var_191_14 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play320071046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 320071046
		arg_192_1.duration_ = 8.47

		local var_192_0 = {
			zh = 7.465999999999,
			ja = 8.465999999999
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play320071047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = "ST65"

			if arg_192_1.bgs_[var_195_0] == nil then
				local var_195_1 = Object.Instantiate(arg_192_1.paintGo_)

				var_195_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_195_0)
				var_195_1.name = var_195_0
				var_195_1.transform.parent = arg_192_1.stage_.transform
				var_195_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.bgs_[var_195_0] = var_195_1
			end

			local var_195_2 = 1.999999999999

			if var_195_2 < arg_192_1.time_ and arg_192_1.time_ <= var_195_2 + arg_195_0 then
				local var_195_3 = manager.ui.mainCamera.transform.localPosition
				local var_195_4 = Vector3.New(0, 0, 10) + Vector3.New(var_195_3.x, var_195_3.y, 0)
				local var_195_5 = arg_192_1.bgs_.ST65

				var_195_5.transform.localPosition = var_195_4
				var_195_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_195_6 = var_195_5:GetComponent("SpriteRenderer")

				if var_195_6 and var_195_6.sprite then
					local var_195_7 = (var_195_5.transform.localPosition - var_195_3).z
					local var_195_8 = manager.ui.mainCameraCom_
					local var_195_9 = 2 * var_195_7 * Mathf.Tan(var_195_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_195_10 = var_195_9 * var_195_8.aspect
					local var_195_11 = var_195_6.sprite.bounds.size.x
					local var_195_12 = var_195_6.sprite.bounds.size.y
					local var_195_13 = var_195_10 / var_195_11
					local var_195_14 = var_195_9 / var_195_12
					local var_195_15 = var_195_14 < var_195_13 and var_195_13 or var_195_14

					var_195_5.transform.localScale = Vector3.New(var_195_15, var_195_15, 0)
				end

				for iter_195_0, iter_195_1 in pairs(arg_192_1.bgs_) do
					if iter_195_0 ~= "ST65" then
						iter_195_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_195_16 = 3.999999999999

			if var_195_16 < arg_192_1.time_ and arg_192_1.time_ <= var_195_16 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			local var_195_17 = 0.3

			if arg_192_1.time_ >= var_195_16 + var_195_17 and arg_192_1.time_ < var_195_16 + var_195_17 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			local var_195_18 = 0

			if var_195_18 < arg_192_1.time_ and arg_192_1.time_ <= var_195_18 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_19 = 2

			if var_195_18 <= arg_192_1.time_ and arg_192_1.time_ < var_195_18 + var_195_19 then
				local var_195_20 = (arg_192_1.time_ - var_195_18) / var_195_19
				local var_195_21 = Color.New(0, 0, 0)

				var_195_21.a = Mathf.Lerp(0, 1, var_195_20)
				arg_192_1.mask_.color = var_195_21
			end

			if arg_192_1.time_ >= var_195_18 + var_195_19 and arg_192_1.time_ < var_195_18 + var_195_19 + arg_195_0 then
				local var_195_22 = Color.New(0, 0, 0)

				var_195_22.a = 1
				arg_192_1.mask_.color = var_195_22
			end

			local var_195_23 = 2

			if var_195_23 < arg_192_1.time_ and arg_192_1.time_ <= var_195_23 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_24 = 2

			if var_195_23 <= arg_192_1.time_ and arg_192_1.time_ < var_195_23 + var_195_24 then
				local var_195_25 = (arg_192_1.time_ - var_195_23) / var_195_24
				local var_195_26 = Color.New(0, 0, 0)

				var_195_26.a = Mathf.Lerp(1, 0, var_195_25)
				arg_192_1.mask_.color = var_195_26
			end

			if arg_192_1.time_ >= var_195_23 + var_195_24 and arg_192_1.time_ < var_195_23 + var_195_24 + arg_195_0 then
				local var_195_27 = Color.New(0, 0, 0)
				local var_195_28 = 0

				arg_192_1.mask_.enabled = false
				var_195_27.a = var_195_28
				arg_192_1.mask_.color = var_195_27
			end

			local var_195_29 = arg_192_1.actors_["10102ui_story"].transform
			local var_195_30 = 1.96599999815226

			if var_195_30 < arg_192_1.time_ and arg_192_1.time_ <= var_195_30 + arg_195_0 then
				arg_192_1.var_.moveOldPos10102ui_story = var_195_29.localPosition
			end

			local var_195_31 = 0.001

			if var_195_30 <= arg_192_1.time_ and arg_192_1.time_ < var_195_30 + var_195_31 then
				local var_195_32 = (arg_192_1.time_ - var_195_30) / var_195_31
				local var_195_33 = Vector3.New(0, 100, 0)

				var_195_29.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10102ui_story, var_195_33, var_195_32)

				local var_195_34 = manager.ui.mainCamera.transform.position - var_195_29.position

				var_195_29.forward = Vector3.New(var_195_34.x, var_195_34.y, var_195_34.z)

				local var_195_35 = var_195_29.localEulerAngles

				var_195_35.z = 0
				var_195_35.x = 0
				var_195_29.localEulerAngles = var_195_35
			end

			if arg_192_1.time_ >= var_195_30 + var_195_31 and arg_192_1.time_ < var_195_30 + var_195_31 + arg_195_0 then
				var_195_29.localPosition = Vector3.New(0, 100, 0)

				local var_195_36 = manager.ui.mainCamera.transform.position - var_195_29.position

				var_195_29.forward = Vector3.New(var_195_36.x, var_195_36.y, var_195_36.z)

				local var_195_37 = var_195_29.localEulerAngles

				var_195_37.z = 0
				var_195_37.x = 0
				var_195_29.localEulerAngles = var_195_37
			end

			local var_195_38 = arg_192_1.actors_["10102ui_story"]
			local var_195_39 = 1.96599999815226

			if var_195_39 < arg_192_1.time_ and arg_192_1.time_ <= var_195_39 + arg_195_0 and not isNil(var_195_38) and arg_192_1.var_.characterEffect10102ui_story == nil then
				arg_192_1.var_.characterEffect10102ui_story = var_195_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_40 = 0.034000001847744

			if var_195_39 <= arg_192_1.time_ and arg_192_1.time_ < var_195_39 + var_195_40 and not isNil(var_195_38) then
				local var_195_41 = (arg_192_1.time_ - var_195_39) / var_195_40

				if arg_192_1.var_.characterEffect10102ui_story and not isNil(var_195_38) then
					local var_195_42 = Mathf.Lerp(0, 0.5, var_195_41)

					arg_192_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10102ui_story.fillRatio = var_195_42
				end
			end

			if arg_192_1.time_ >= var_195_39 + var_195_40 and arg_192_1.time_ < var_195_39 + var_195_40 + arg_195_0 and not isNil(var_195_38) and arg_192_1.var_.characterEffect10102ui_story then
				local var_195_43 = 0.5

				arg_192_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10102ui_story.fillRatio = var_195_43
			end

			local var_195_44 = arg_192_1.actors_["1056ui_story"].transform
			local var_195_45 = 1.96599999815226

			if var_195_45 < arg_192_1.time_ and arg_192_1.time_ <= var_195_45 + arg_195_0 then
				arg_192_1.var_.moveOldPos1056ui_story = var_195_44.localPosition
			end

			local var_195_46 = 0.001

			if var_195_45 <= arg_192_1.time_ and arg_192_1.time_ < var_195_45 + var_195_46 then
				local var_195_47 = (arg_192_1.time_ - var_195_45) / var_195_46
				local var_195_48 = Vector3.New(0, 100, 0)

				var_195_44.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1056ui_story, var_195_48, var_195_47)

				local var_195_49 = manager.ui.mainCamera.transform.position - var_195_44.position

				var_195_44.forward = Vector3.New(var_195_49.x, var_195_49.y, var_195_49.z)

				local var_195_50 = var_195_44.localEulerAngles

				var_195_50.z = 0
				var_195_50.x = 0
				var_195_44.localEulerAngles = var_195_50
			end

			if arg_192_1.time_ >= var_195_45 + var_195_46 and arg_192_1.time_ < var_195_45 + var_195_46 + arg_195_0 then
				var_195_44.localPosition = Vector3.New(0, 100, 0)

				local var_195_51 = manager.ui.mainCamera.transform.position - var_195_44.position

				var_195_44.forward = Vector3.New(var_195_51.x, var_195_51.y, var_195_51.z)

				local var_195_52 = var_195_44.localEulerAngles

				var_195_52.z = 0
				var_195_52.x = 0
				var_195_44.localEulerAngles = var_195_52
			end

			local var_195_53 = arg_192_1.actors_["1056ui_story"]
			local var_195_54 = 3.26599999815225

			if var_195_54 < arg_192_1.time_ and arg_192_1.time_ <= var_195_54 + arg_195_0 and not isNil(var_195_53) and arg_192_1.var_.characterEffect1056ui_story == nil then
				arg_192_1.var_.characterEffect1056ui_story = var_195_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_55 = 0.034000001847744

			if var_195_54 <= arg_192_1.time_ and arg_192_1.time_ < var_195_54 + var_195_55 and not isNil(var_195_53) then
				local var_195_56 = (arg_192_1.time_ - var_195_54) / var_195_55

				if arg_192_1.var_.characterEffect1056ui_story and not isNil(var_195_53) then
					local var_195_57 = Mathf.Lerp(0, 0.5, var_195_56)

					arg_192_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1056ui_story.fillRatio = var_195_57
				end
			end

			if arg_192_1.time_ >= var_195_54 + var_195_55 and arg_192_1.time_ < var_195_54 + var_195_55 + arg_195_0 and not isNil(var_195_53) and arg_192_1.var_.characterEffect1056ui_story then
				local var_195_58 = 0.5

				arg_192_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1056ui_story.fillRatio = var_195_58
			end

			local var_195_59 = 1.3
			local var_195_60 = 0.2

			if var_195_59 < arg_192_1.time_ and arg_192_1.time_ <= var_195_59 + arg_195_0 then
				local var_195_61 = "play"
				local var_195_62 = "music"

				arg_192_1:AudioAction(var_195_61, var_195_62, "ui_battle", "ui_battle_stopbgm", "")

				local var_195_63 = ""
				local var_195_64 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_195_64 ~= "" then
					if arg_192_1.bgmTxt_.text ~= var_195_64 and arg_192_1.bgmTxt_.text ~= "" then
						if arg_192_1.bgmTxt2_.text ~= "" then
							arg_192_1.bgmTxt_.text = arg_192_1.bgmTxt2_.text
						end

						arg_192_1.bgmTxt2_.text = var_195_64

						arg_192_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_192_1.bgmTxt_.text = var_195_64
						arg_192_1.bgmTxt2_.text = var_195_64
					end

					if arg_192_1.bgmTimer then
						arg_192_1.bgmTimer:Stop()

						arg_192_1.bgmTimer = nil
					end

					if arg_192_1.settingData.show_music_name == 1 then
						arg_192_1.musicController:SetSelectedState("show")
						arg_192_1.musicAnimator_:Play("open", 0, 0)

						if arg_192_1.settingData.music_time ~= 0 then
							arg_192_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_192_1.settingData.music_time), function()
								if arg_192_1 == nil or isNil(arg_192_1.bgmTxt_) then
									return
								end

								arg_192_1.musicController:SetSelectedState("hide")
								arg_192_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_195_65 = 1.63333333333333
			local var_195_66 = 1

			if var_195_65 < arg_192_1.time_ and arg_192_1.time_ <= var_195_65 + arg_195_0 then
				local var_195_67 = "play"
				local var_195_68 = "music"

				arg_192_1:AudioAction(var_195_67, var_195_68, "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_195_69 = ""
				local var_195_70 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if var_195_70 ~= "" then
					if arg_192_1.bgmTxt_.text ~= var_195_70 and arg_192_1.bgmTxt_.text ~= "" then
						if arg_192_1.bgmTxt2_.text ~= "" then
							arg_192_1.bgmTxt_.text = arg_192_1.bgmTxt2_.text
						end

						arg_192_1.bgmTxt2_.text = var_195_70

						arg_192_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_192_1.bgmTxt_.text = var_195_70
						arg_192_1.bgmTxt2_.text = var_195_70
					end

					if arg_192_1.bgmTimer then
						arg_192_1.bgmTimer:Stop()

						arg_192_1.bgmTimer = nil
					end

					if arg_192_1.settingData.show_music_name == 1 then
						arg_192_1.musicController:SetSelectedState("show")
						arg_192_1.musicAnimator_:Play("open", 0, 0)

						if arg_192_1.settingData.music_time ~= 0 then
							arg_192_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_192_1.settingData.music_time), function()
								if arg_192_1 == nil or isNil(arg_192_1.bgmTxt_) then
									return
								end

								arg_192_1.musicController:SetSelectedState("hide")
								arg_192_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_195_71 = 2
			local var_195_72 = 1

			if var_195_71 < arg_192_1.time_ and arg_192_1.time_ <= var_195_71 + arg_195_0 then
				local var_195_73 = "play"
				local var_195_74 = "effect"

				arg_192_1:AudioAction(var_195_73, var_195_74, "se_story_136", "se_story_136_boxing_loop", "")
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_75 = 3.999999999999
			local var_195_76 = 0.425

			if var_195_75 < arg_192_1.time_ and arg_192_1.time_ <= var_195_75 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_77 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_77:setOnUpdate(LuaHelper.FloatAction(function(arg_198_0)
					arg_192_1.dialogCg_.alpha = arg_198_0
				end))
				var_195_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_78 = arg_192_1:FormatText(StoryNameCfg[1034].name)

				arg_192_1.leftNameTxt_.text = var_195_78

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_79 = arg_192_1:GetWordFromCfg(320071046)
				local var_195_80 = arg_192_1:FormatText(var_195_79.content)

				arg_192_1.text_.text = var_195_80

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_81 = 17
				local var_195_82 = utf8.len(var_195_80)
				local var_195_83 = var_195_81 <= 0 and var_195_76 or var_195_76 * (var_195_82 / var_195_81)

				if var_195_83 > 0 and var_195_76 < var_195_83 then
					arg_192_1.talkMaxDuration = var_195_83
					var_195_75 = var_195_75 + 0.3

					if var_195_83 + var_195_75 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_83 + var_195_75
					end
				end

				arg_192_1.text_.text = var_195_80
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071046", "story_v_out_320071.awb") ~= 0 then
					local var_195_84 = manager.audio:GetVoiceLength("story_v_out_320071", "320071046", "story_v_out_320071.awb") / 1000

					if var_195_84 + var_195_75 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_84 + var_195_75
					end

					if var_195_79.prefab_name ~= "" and arg_192_1.actors_[var_195_79.prefab_name] ~= nil then
						local var_195_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_79.prefab_name].transform, "story_v_out_320071", "320071046", "story_v_out_320071.awb")

						arg_192_1:RecordAudio("320071046", var_195_85)
						arg_192_1:RecordAudio("320071046", var_195_85)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_320071", "320071046", "story_v_out_320071.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_320071", "320071046", "story_v_out_320071.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_86 = var_195_75 + 0.3
			local var_195_87 = math.max(var_195_76, arg_192_1.talkMaxDuration)

			if var_195_86 <= arg_192_1.time_ and arg_192_1.time_ < var_195_86 + var_195_87 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_86) / var_195_87

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_86 + var_195_87 and arg_192_1.time_ < var_195_86 + var_195_87 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play320071047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 320071047
		arg_200_1.duration_ = 3.33

		local var_200_0 = {
			zh = 2.6,
			ja = 3.333
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play320071048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1056ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos1056ui_story = var_203_0.localPosition
			end

			local var_203_2 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2
				local var_203_4 = Vector3.New(0, -1, -5.75)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1056ui_story, var_203_4, var_203_3)

				local var_203_5 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_5.x, var_203_5.y, var_203_5.z)

				local var_203_6 = var_203_0.localEulerAngles

				var_203_6.z = 0
				var_203_6.x = 0
				var_203_0.localEulerAngles = var_203_6
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_203_7 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_7.x, var_203_7.y, var_203_7.z)

				local var_203_8 = var_203_0.localEulerAngles

				var_203_8.z = 0
				var_203_8.x = 0
				var_203_0.localEulerAngles = var_203_8
			end

			local var_203_9 = arg_200_1.actors_["1056ui_story"]
			local var_203_10 = 0

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect1056ui_story == nil then
				arg_200_1.var_.characterEffect1056ui_story = var_203_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_11 = 0.200000002980232

			if var_203_10 <= arg_200_1.time_ and arg_200_1.time_ < var_203_10 + var_203_11 and not isNil(var_203_9) then
				local var_203_12 = (arg_200_1.time_ - var_203_10) / var_203_11

				if arg_200_1.var_.characterEffect1056ui_story and not isNil(var_203_9) then
					arg_200_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_10 + var_203_11 and arg_200_1.time_ < var_203_10 + var_203_11 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect1056ui_story then
				arg_200_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_203_13 = 0

			if var_203_13 < arg_200_1.time_ and arg_200_1.time_ <= var_203_13 + arg_203_0 then
				arg_200_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_203_14 = 0

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_203_15 = 0
			local var_203_16 = 0.25

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_17 = arg_200_1:FormatText(StoryNameCfg[605].name)

				arg_200_1.leftNameTxt_.text = var_203_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_18 = arg_200_1:GetWordFromCfg(320071047)
				local var_203_19 = arg_200_1:FormatText(var_203_18.content)

				arg_200_1.text_.text = var_203_19

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_20 = 10
				local var_203_21 = utf8.len(var_203_19)
				local var_203_22 = var_203_20 <= 0 and var_203_16 or var_203_16 * (var_203_21 / var_203_20)

				if var_203_22 > 0 and var_203_16 < var_203_22 then
					arg_200_1.talkMaxDuration = var_203_22

					if var_203_22 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_22 + var_203_15
					end
				end

				arg_200_1.text_.text = var_203_19
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071047", "story_v_out_320071.awb") ~= 0 then
					local var_203_23 = manager.audio:GetVoiceLength("story_v_out_320071", "320071047", "story_v_out_320071.awb") / 1000

					if var_203_23 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_23 + var_203_15
					end

					if var_203_18.prefab_name ~= "" and arg_200_1.actors_[var_203_18.prefab_name] ~= nil then
						local var_203_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_18.prefab_name].transform, "story_v_out_320071", "320071047", "story_v_out_320071.awb")

						arg_200_1:RecordAudio("320071047", var_203_24)
						arg_200_1:RecordAudio("320071047", var_203_24)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_320071", "320071047", "story_v_out_320071.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_320071", "320071047", "story_v_out_320071.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_25 = math.max(var_203_16, arg_200_1.talkMaxDuration)

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_25 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_15) / var_203_25

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_15 + var_203_25 and arg_200_1.time_ < var_203_15 + var_203_25 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320071048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 320071048
		arg_204_1.duration_ = 14.33

		local var_204_0 = {
			zh = 10.3,
			ja = 14.333
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play320071049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1056ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1056ui_story == nil then
				arg_204_1.var_.characterEffect1056ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1056ui_story and not isNil(var_207_0) then
					local var_207_4 = Mathf.Lerp(0, 0.5, var_207_3)

					arg_204_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1056ui_story.fillRatio = var_207_4
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1056ui_story then
				local var_207_5 = 0.5

				arg_204_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1056ui_story.fillRatio = var_207_5
			end

			local var_207_6 = 0
			local var_207_7 = 1.275

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_8 = arg_204_1:FormatText(StoryNameCfg[1034].name)

				arg_204_1.leftNameTxt_.text = var_207_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_9 = arg_204_1:GetWordFromCfg(320071048)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 51
				local var_207_12 = utf8.len(var_207_10)
				local var_207_13 = var_207_11 <= 0 and var_207_7 or var_207_7 * (var_207_12 / var_207_11)

				if var_207_13 > 0 and var_207_7 < var_207_13 then
					arg_204_1.talkMaxDuration = var_207_13

					if var_207_13 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_6
					end
				end

				arg_204_1.text_.text = var_207_10
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071048", "story_v_out_320071.awb") ~= 0 then
					local var_207_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071048", "story_v_out_320071.awb") / 1000

					if var_207_14 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_6
					end

					if var_207_9.prefab_name ~= "" and arg_204_1.actors_[var_207_9.prefab_name] ~= nil then
						local var_207_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_9.prefab_name].transform, "story_v_out_320071", "320071048", "story_v_out_320071.awb")

						arg_204_1:RecordAudio("320071048", var_207_15)
						arg_204_1:RecordAudio("320071048", var_207_15)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_320071", "320071048", "story_v_out_320071.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_320071", "320071048", "story_v_out_320071.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_16 = math.max(var_207_7, arg_204_1.talkMaxDuration)

			if var_207_6 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_16 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_6) / var_207_16

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_6 + var_207_16 and arg_204_1.time_ < var_207_6 + var_207_16 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play320071049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 320071049
		arg_208_1.duration_ = 3.87

		local var_208_0 = {
			zh = 3.866,
			ja = 3.1
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play320071050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1056ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1056ui_story == nil then
				arg_208_1.var_.characterEffect1056ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1056ui_story and not isNil(var_211_0) then
					arg_208_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1056ui_story then
				arg_208_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_211_4 = 0

			if var_211_4 < arg_208_1.time_ and arg_208_1.time_ <= var_211_4 + arg_211_0 then
				arg_208_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_211_5 = 0

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 then
				arg_208_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_211_6 = 0
			local var_211_7 = 0.475

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[605].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_9 = arg_208_1:GetWordFromCfg(320071049)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 19
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071049", "story_v_out_320071.awb") ~= 0 then
					local var_211_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071049", "story_v_out_320071.awb") / 1000

					if var_211_14 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_14 + var_211_6
					end

					if var_211_9.prefab_name ~= "" and arg_208_1.actors_[var_211_9.prefab_name] ~= nil then
						local var_211_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_9.prefab_name].transform, "story_v_out_320071", "320071049", "story_v_out_320071.awb")

						arg_208_1:RecordAudio("320071049", var_211_15)
						arg_208_1:RecordAudio("320071049", var_211_15)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_320071", "320071049", "story_v_out_320071.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_320071", "320071049", "story_v_out_320071.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_16 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_16 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_16

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_16 and arg_208_1.time_ < var_211_6 + var_211_16 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play320071050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 320071050
		arg_212_1.duration_ = 4.4

		local var_212_0 = {
			zh = 4.333,
			ja = 4.4
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play320071051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1056ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1056ui_story == nil then
				arg_212_1.var_.characterEffect1056ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1056ui_story and not isNil(var_215_0) then
					local var_215_4 = Mathf.Lerp(0, 0.5, var_215_3)

					arg_212_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1056ui_story.fillRatio = var_215_4
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1056ui_story then
				local var_215_5 = 0.5

				arg_212_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1056ui_story.fillRatio = var_215_5
			end

			local var_215_6 = 0
			local var_215_7 = 0.475

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[1034].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowcitizenwc")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_9 = arg_212_1:GetWordFromCfg(320071050)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 19
				local var_215_12 = utf8.len(var_215_10)
				local var_215_13 = var_215_11 <= 0 and var_215_7 or var_215_7 * (var_215_12 / var_215_11)

				if var_215_13 > 0 and var_215_7 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071050", "story_v_out_320071.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071050", "story_v_out_320071.awb") / 1000

					if var_215_14 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_6
					end

					if var_215_9.prefab_name ~= "" and arg_212_1.actors_[var_215_9.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_9.prefab_name].transform, "story_v_out_320071", "320071050", "story_v_out_320071.awb")

						arg_212_1:RecordAudio("320071050", var_215_15)
						arg_212_1:RecordAudio("320071050", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_320071", "320071050", "story_v_out_320071.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_320071", "320071050", "story_v_out_320071.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_16 and arg_212_1.time_ < var_215_6 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play320071051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 320071051
		arg_216_1.duration_ = 8.67

		local var_216_0 = {
			zh = 7.2,
			ja = 8.666
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play320071052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 1.025

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_2 = arg_216_1:FormatText(StoryNameCfg[1035].name)

				arg_216_1.leftNameTxt_.text = var_219_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:GetWordFromCfg(320071051)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 41
				local var_219_6 = utf8.len(var_219_4)
				local var_219_7 = var_219_5 <= 0 and var_219_1 or var_219_1 * (var_219_6 / var_219_5)

				if var_219_7 > 0 and var_219_1 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071051", "story_v_out_320071.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071051", "story_v_out_320071.awb") / 1000

					if var_219_8 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_0
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_320071", "320071051", "story_v_out_320071.awb")

						arg_216_1:RecordAudio("320071051", var_219_9)
						arg_216_1:RecordAudio("320071051", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_320071", "320071051", "story_v_out_320071.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_320071", "320071051", "story_v_out_320071.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_10 and arg_216_1.time_ < var_219_0 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play320071052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 320071052
		arg_220_1.duration_ = 6.7

		local var_220_0 = {
			zh = 6.7,
			ja = 5.766
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play320071053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 0.775

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_2 = arg_220_1:FormatText(StoryNameCfg[1035].name)

				arg_220_1.leftNameTxt_.text = var_223_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_3 = arg_220_1:GetWordFromCfg(320071052)
				local var_223_4 = arg_220_1:FormatText(var_223_3.content)

				arg_220_1.text_.text = var_223_4

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 31
				local var_223_6 = utf8.len(var_223_4)
				local var_223_7 = var_223_5 <= 0 and var_223_1 or var_223_1 * (var_223_6 / var_223_5)

				if var_223_7 > 0 and var_223_1 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_4
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071052", "story_v_out_320071.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071052", "story_v_out_320071.awb") / 1000

					if var_223_8 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_0
					end

					if var_223_3.prefab_name ~= "" and arg_220_1.actors_[var_223_3.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_3.prefab_name].transform, "story_v_out_320071", "320071052", "story_v_out_320071.awb")

						arg_220_1:RecordAudio("320071052", var_223_9)
						arg_220_1:RecordAudio("320071052", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_320071", "320071052", "story_v_out_320071.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_320071", "320071052", "story_v_out_320071.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_10 and arg_220_1.time_ < var_223_0 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play320071053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 320071053
		arg_224_1.duration_ = 4.7

		local var_224_0 = {
			zh = 2.9,
			ja = 4.7
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play320071054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1056ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1056ui_story == nil then
				arg_224_1.var_.characterEffect1056ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1056ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1056ui_story then
				arg_224_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_227_4 = 0

			if var_227_4 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_227_6 = 0
			local var_227_7 = 0.375

			if var_227_6 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_8 = arg_224_1:FormatText(StoryNameCfg[605].name)

				arg_224_1.leftNameTxt_.text = var_227_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_9 = arg_224_1:GetWordFromCfg(320071053)
				local var_227_10 = arg_224_1:FormatText(var_227_9.content)

				arg_224_1.text_.text = var_227_10

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071053", "story_v_out_320071.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071053", "story_v_out_320071.awb") / 1000

					if var_227_14 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_6
					end

					if var_227_9.prefab_name ~= "" and arg_224_1.actors_[var_227_9.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_9.prefab_name].transform, "story_v_out_320071", "320071053", "story_v_out_320071.awb")

						arg_224_1:RecordAudio("320071053", var_227_15)
						arg_224_1:RecordAudio("320071053", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_320071", "320071053", "story_v_out_320071.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_320071", "320071053", "story_v_out_320071.awb")
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
	Play320071054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 320071054
		arg_228_1.duration_ = 3.3

		local var_228_0 = {
			zh = 2.5,
			ja = 3.3
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play320071055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1056ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1056ui_story == nil then
				arg_228_1.var_.characterEffect1056ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1056ui_story and not isNil(var_231_0) then
					local var_231_4 = Mathf.Lerp(0, 0.5, var_231_3)

					arg_228_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1056ui_story.fillRatio = var_231_4
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1056ui_story then
				local var_231_5 = 0.5

				arg_228_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1056ui_story.fillRatio = var_231_5
			end

			local var_231_6 = 0
			local var_231_7 = 0.25

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_8 = arg_228_1:FormatText(StoryNameCfg[1035].name)

				arg_228_1.leftNameTxt_.text = var_231_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_9 = arg_228_1:GetWordFromCfg(320071054)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071054", "story_v_out_320071.awb") ~= 0 then
					local var_231_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071054", "story_v_out_320071.awb") / 1000

					if var_231_14 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_6
					end

					if var_231_9.prefab_name ~= "" and arg_228_1.actors_[var_231_9.prefab_name] ~= nil then
						local var_231_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_9.prefab_name].transform, "story_v_out_320071", "320071054", "story_v_out_320071.awb")

						arg_228_1:RecordAudio("320071054", var_231_15)
						arg_228_1:RecordAudio("320071054", var_231_15)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_320071", "320071054", "story_v_out_320071.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_320071", "320071054", "story_v_out_320071.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_16 and arg_228_1.time_ < var_231_6 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play320071055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 320071055
		arg_232_1.duration_ = 7.8

		local var_232_0 = {
			zh = 7.8,
			ja = 7.7
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play320071056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1056ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1056ui_story == nil then
				arg_232_1.var_.characterEffect1056ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect1056ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1056ui_story then
				arg_232_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_235_4 = 0

			if var_235_4 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_235_5 = 0
			local var_235_6 = 0.925

			if var_235_5 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_7 = arg_232_1:FormatText(StoryNameCfg[605].name)

				arg_232_1.leftNameTxt_.text = var_235_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_8 = arg_232_1:GetWordFromCfg(320071055)
				local var_235_9 = arg_232_1:FormatText(var_235_8.content)

				arg_232_1.text_.text = var_235_9

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_10 = 37
				local var_235_11 = utf8.len(var_235_9)
				local var_235_12 = var_235_10 <= 0 and var_235_6 or var_235_6 * (var_235_11 / var_235_10)

				if var_235_12 > 0 and var_235_6 < var_235_12 then
					arg_232_1.talkMaxDuration = var_235_12

					if var_235_12 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_12 + var_235_5
					end
				end

				arg_232_1.text_.text = var_235_9
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071055", "story_v_out_320071.awb") ~= 0 then
					local var_235_13 = manager.audio:GetVoiceLength("story_v_out_320071", "320071055", "story_v_out_320071.awb") / 1000

					if var_235_13 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_13 + var_235_5
					end

					if var_235_8.prefab_name ~= "" and arg_232_1.actors_[var_235_8.prefab_name] ~= nil then
						local var_235_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_8.prefab_name].transform, "story_v_out_320071", "320071055", "story_v_out_320071.awb")

						arg_232_1:RecordAudio("320071055", var_235_14)
						arg_232_1:RecordAudio("320071055", var_235_14)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_320071", "320071055", "story_v_out_320071.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_320071", "320071055", "story_v_out_320071.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_15 = math.max(var_235_6, arg_232_1.talkMaxDuration)

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_15 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_5) / var_235_15

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_5 + var_235_15 and arg_232_1.time_ < var_235_5 + var_235_15 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play320071056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 320071056
		arg_236_1.duration_ = 6.5

		local var_236_0 = {
			zh = 5.833,
			ja = 6.5
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play320071057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.775

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[605].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_3 = arg_236_1:GetWordFromCfg(320071056)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071056", "story_v_out_320071.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071056", "story_v_out_320071.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_320071", "320071056", "story_v_out_320071.awb")

						arg_236_1:RecordAudio("320071056", var_239_9)
						arg_236_1:RecordAudio("320071056", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_320071", "320071056", "story_v_out_320071.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_320071", "320071056", "story_v_out_320071.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play320071057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 320071057
		arg_240_1.duration_ = 6.83

		local var_240_0 = {
			zh = 4.733,
			ja = 6.833
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play320071058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action4_1")
			end

			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_243_2 = 0
			local var_243_3 = 0.625

			if var_243_2 < arg_240_1.time_ and arg_240_1.time_ <= var_243_2 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_4 = arg_240_1:FormatText(StoryNameCfg[605].name)

				arg_240_1.leftNameTxt_.text = var_243_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_5 = arg_240_1:GetWordFromCfg(320071057)
				local var_243_6 = arg_240_1:FormatText(var_243_5.content)

				arg_240_1.text_.text = var_243_6

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_7 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071057", "story_v_out_320071.awb") ~= 0 then
					local var_243_10 = manager.audio:GetVoiceLength("story_v_out_320071", "320071057", "story_v_out_320071.awb") / 1000

					if var_243_10 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_2
					end

					if var_243_5.prefab_name ~= "" and arg_240_1.actors_[var_243_5.prefab_name] ~= nil then
						local var_243_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_5.prefab_name].transform, "story_v_out_320071", "320071057", "story_v_out_320071.awb")

						arg_240_1:RecordAudio("320071057", var_243_11)
						arg_240_1:RecordAudio("320071057", var_243_11)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_320071", "320071057", "story_v_out_320071.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_320071", "320071057", "story_v_out_320071.awb")
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
	Play320071058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 320071058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play320071059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1056ui_story"].transform
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos1056ui_story = var_247_0.localPosition
			end

			local var_247_2 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2
				local var_247_4 = Vector3.New(0, 100, 0)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1056ui_story, var_247_4, var_247_3)

				local var_247_5 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_5.x, var_247_5.y, var_247_5.z)

				local var_247_6 = var_247_0.localEulerAngles

				var_247_6.z = 0
				var_247_6.x = 0
				var_247_0.localEulerAngles = var_247_6
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(0, 100, 0)

				local var_247_7 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_7.x, var_247_7.y, var_247_7.z)

				local var_247_8 = var_247_0.localEulerAngles

				var_247_8.z = 0
				var_247_8.x = 0
				var_247_0.localEulerAngles = var_247_8
			end

			local var_247_9 = arg_244_1.actors_["1056ui_story"]
			local var_247_10 = 0

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect1056ui_story == nil then
				arg_244_1.var_.characterEffect1056ui_story = var_247_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_11 = 0.200000002980232

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_11 and not isNil(var_247_9) then
				local var_247_12 = (arg_244_1.time_ - var_247_10) / var_247_11

				if arg_244_1.var_.characterEffect1056ui_story and not isNil(var_247_9) then
					local var_247_13 = Mathf.Lerp(0, 0.5, var_247_12)

					arg_244_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1056ui_story.fillRatio = var_247_13
				end
			end

			if arg_244_1.time_ >= var_247_10 + var_247_11 and arg_244_1.time_ < var_247_10 + var_247_11 + arg_247_0 and not isNil(var_247_9) and arg_244_1.var_.characterEffect1056ui_story then
				local var_247_14 = 0.5

				arg_244_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1056ui_story.fillRatio = var_247_14
			end

			local var_247_15 = 0.666666666666667
			local var_247_16 = 0.633333333333333

			if var_247_15 < arg_244_1.time_ and arg_244_1.time_ <= var_247_15 + arg_247_0 then
				local var_247_17 = "play"
				local var_247_18 = "effect"

				arg_244_1:AudioAction(var_247_17, var_247_18, "se_story_5", "se_story_5_cheer", "")
			end

			local var_247_19 = 0.3
			local var_247_20 = 1

			if var_247_19 < arg_244_1.time_ and arg_244_1.time_ <= var_247_19 + arg_247_0 then
				local var_247_21 = "stop"
				local var_247_22 = "effect"

				arg_244_1:AudioAction(var_247_21, var_247_22, "se_story_136", "se_story_136_boxing_loop", "")
			end

			local var_247_23 = 0
			local var_247_24 = 1.45

			if var_247_23 < arg_244_1.time_ and arg_244_1.time_ <= var_247_23 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_25 = arg_244_1:GetWordFromCfg(320071058)
				local var_247_26 = arg_244_1:FormatText(var_247_25.content)

				arg_244_1.text_.text = var_247_26

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_27 = 58
				local var_247_28 = utf8.len(var_247_26)
				local var_247_29 = var_247_27 <= 0 and var_247_24 or var_247_24 * (var_247_28 / var_247_27)

				if var_247_29 > 0 and var_247_24 < var_247_29 then
					arg_244_1.talkMaxDuration = var_247_29

					if var_247_29 + var_247_23 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_29 + var_247_23
					end
				end

				arg_244_1.text_.text = var_247_26
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_30 = math.max(var_247_24, arg_244_1.talkMaxDuration)

			if var_247_23 <= arg_244_1.time_ and arg_244_1.time_ < var_247_23 + var_247_30 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_23) / var_247_30

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_23 + var_247_30 and arg_244_1.time_ < var_247_23 + var_247_30 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play320071059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 320071059
		arg_248_1.duration_ = 10.87

		local var_248_0 = {
			zh = 7.5,
			ja = 10.866
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play320071060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = "L01g"

			if arg_248_1.bgs_[var_251_0] == nil then
				local var_251_1 = Object.Instantiate(arg_248_1.paintGo_)

				var_251_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_251_0)
				var_251_1.name = var_251_0
				var_251_1.transform.parent = arg_248_1.stage_.transform
				var_251_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.bgs_[var_251_0] = var_251_1
			end

			local var_251_2 = 2

			if var_251_2 < arg_248_1.time_ and arg_248_1.time_ <= var_251_2 + arg_251_0 then
				local var_251_3 = manager.ui.mainCamera.transform.localPosition
				local var_251_4 = Vector3.New(0, 0, 10) + Vector3.New(var_251_3.x, var_251_3.y, 0)
				local var_251_5 = arg_248_1.bgs_.L01g

				var_251_5.transform.localPosition = var_251_4
				var_251_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_251_6 = var_251_5:GetComponent("SpriteRenderer")

				if var_251_6 and var_251_6.sprite then
					local var_251_7 = (var_251_5.transform.localPosition - var_251_3).z
					local var_251_8 = manager.ui.mainCameraCom_
					local var_251_9 = 2 * var_251_7 * Mathf.Tan(var_251_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_251_10 = var_251_9 * var_251_8.aspect
					local var_251_11 = var_251_6.sprite.bounds.size.x
					local var_251_12 = var_251_6.sprite.bounds.size.y
					local var_251_13 = var_251_10 / var_251_11
					local var_251_14 = var_251_9 / var_251_12
					local var_251_15 = var_251_14 < var_251_13 and var_251_13 or var_251_14

					var_251_5.transform.localScale = Vector3.New(var_251_15, var_251_15, 0)
				end

				for iter_251_0, iter_251_1 in pairs(arg_248_1.bgs_) do
					if iter_251_0 ~= "L01g" then
						iter_251_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_251_16 = 4

			if var_251_16 < arg_248_1.time_ and arg_248_1.time_ <= var_251_16 + arg_251_0 then
				arg_248_1.allBtn_.enabled = false
			end

			local var_251_17 = 0.3

			if arg_248_1.time_ >= var_251_16 + var_251_17 and arg_248_1.time_ < var_251_16 + var_251_17 + arg_251_0 then
				arg_248_1.allBtn_.enabled = true
			end

			local var_251_18 = 0

			if var_251_18 < arg_248_1.time_ and arg_248_1.time_ <= var_251_18 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_19 = 2

			if var_251_18 <= arg_248_1.time_ and arg_248_1.time_ < var_251_18 + var_251_19 then
				local var_251_20 = (arg_248_1.time_ - var_251_18) / var_251_19
				local var_251_21 = Color.New(0, 0, 0)

				var_251_21.a = Mathf.Lerp(0, 1, var_251_20)
				arg_248_1.mask_.color = var_251_21
			end

			if arg_248_1.time_ >= var_251_18 + var_251_19 and arg_248_1.time_ < var_251_18 + var_251_19 + arg_251_0 then
				local var_251_22 = Color.New(0, 0, 0)

				var_251_22.a = 1
				arg_248_1.mask_.color = var_251_22
			end

			local var_251_23 = 2

			if var_251_23 < arg_248_1.time_ and arg_248_1.time_ <= var_251_23 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_24 = 2

			if var_251_23 <= arg_248_1.time_ and arg_248_1.time_ < var_251_23 + var_251_24 then
				local var_251_25 = (arg_248_1.time_ - var_251_23) / var_251_24
				local var_251_26 = Color.New(0, 0, 0)

				var_251_26.a = Mathf.Lerp(1, 0, var_251_25)
				arg_248_1.mask_.color = var_251_26
			end

			if arg_248_1.time_ >= var_251_23 + var_251_24 and arg_248_1.time_ < var_251_23 + var_251_24 + arg_251_0 then
				local var_251_27 = Color.New(0, 0, 0)
				local var_251_28 = 0

				arg_248_1.mask_.enabled = false
				var_251_27.a = var_251_28
				arg_248_1.mask_.color = var_251_27
			end

			local var_251_29 = arg_248_1.actors_["1056ui_story"].transform
			local var_251_30 = 3.8

			if var_251_30 < arg_248_1.time_ and arg_248_1.time_ <= var_251_30 + arg_251_0 then
				arg_248_1.var_.moveOldPos1056ui_story = var_251_29.localPosition
			end

			local var_251_31 = 0.001

			if var_251_30 <= arg_248_1.time_ and arg_248_1.time_ < var_251_30 + var_251_31 then
				local var_251_32 = (arg_248_1.time_ - var_251_30) / var_251_31
				local var_251_33 = Vector3.New(0, -1, -5.75)

				var_251_29.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1056ui_story, var_251_33, var_251_32)

				local var_251_34 = manager.ui.mainCamera.transform.position - var_251_29.position

				var_251_29.forward = Vector3.New(var_251_34.x, var_251_34.y, var_251_34.z)

				local var_251_35 = var_251_29.localEulerAngles

				var_251_35.z = 0
				var_251_35.x = 0
				var_251_29.localEulerAngles = var_251_35
			end

			if arg_248_1.time_ >= var_251_30 + var_251_31 and arg_248_1.time_ < var_251_30 + var_251_31 + arg_251_0 then
				var_251_29.localPosition = Vector3.New(0, -1, -5.75)

				local var_251_36 = manager.ui.mainCamera.transform.position - var_251_29.position

				var_251_29.forward = Vector3.New(var_251_36.x, var_251_36.y, var_251_36.z)

				local var_251_37 = var_251_29.localEulerAngles

				var_251_37.z = 0
				var_251_37.x = 0
				var_251_29.localEulerAngles = var_251_37
			end

			local var_251_38 = arg_248_1.actors_["1056ui_story"]
			local var_251_39 = 3.8

			if var_251_39 < arg_248_1.time_ and arg_248_1.time_ <= var_251_39 + arg_251_0 and not isNil(var_251_38) and arg_248_1.var_.characterEffect1056ui_story == nil then
				arg_248_1.var_.characterEffect1056ui_story = var_251_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_40 = 0.200000002980232

			if var_251_39 <= arg_248_1.time_ and arg_248_1.time_ < var_251_39 + var_251_40 and not isNil(var_251_38) then
				local var_251_41 = (arg_248_1.time_ - var_251_39) / var_251_40

				if arg_248_1.var_.characterEffect1056ui_story and not isNil(var_251_38) then
					arg_248_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_39 + var_251_40 and arg_248_1.time_ < var_251_39 + var_251_40 + arg_251_0 and not isNil(var_251_38) and arg_248_1.var_.characterEffect1056ui_story then
				arg_248_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_251_42 = 3.8

			if var_251_42 < arg_248_1.time_ and arg_248_1.time_ <= var_251_42 + arg_251_0 then
				arg_248_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_251_43 = 3.8

			if var_251_43 < arg_248_1.time_ and arg_248_1.time_ <= var_251_43 + arg_251_0 then
				arg_248_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_248_1.frameCnt_ <= 1 then
				arg_248_1.dialog_:SetActive(false)
			end

			local var_251_44 = 4
			local var_251_45 = 0.375

			if var_251_44 < arg_248_1.time_ and arg_248_1.time_ <= var_251_44 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0

				arg_248_1.dialog_:SetActive(true)

				arg_248_1.dialogCg_.alpha = 0

				local var_251_46 = LeanTween.value(arg_248_1.dialog_, 0, 1, 0.3)

				var_251_46:setOnUpdate(LuaHelper.FloatAction(function(arg_252_0)
					arg_248_1.dialogCg_.alpha = arg_252_0
				end))
				var_251_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_248_1.dialog_)
					var_251_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_248_1.duration_ = arg_248_1.duration_ + 0.3

				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_47 = arg_248_1:FormatText(StoryNameCfg[605].name)

				arg_248_1.leftNameTxt_.text = var_251_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_48 = arg_248_1:GetWordFromCfg(320071059)
				local var_251_49 = arg_248_1:FormatText(var_251_48.content)

				arg_248_1.text_.text = var_251_49

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_50 = 15
				local var_251_51 = utf8.len(var_251_49)
				local var_251_52 = var_251_50 <= 0 and var_251_45 or var_251_45 * (var_251_51 / var_251_50)

				if var_251_52 > 0 and var_251_45 < var_251_52 then
					arg_248_1.talkMaxDuration = var_251_52
					var_251_44 = var_251_44 + 0.3

					if var_251_52 + var_251_44 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_52 + var_251_44
					end
				end

				arg_248_1.text_.text = var_251_49
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071059", "story_v_out_320071.awb") ~= 0 then
					local var_251_53 = manager.audio:GetVoiceLength("story_v_out_320071", "320071059", "story_v_out_320071.awb") / 1000

					if var_251_53 + var_251_44 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_53 + var_251_44
					end

					if var_251_48.prefab_name ~= "" and arg_248_1.actors_[var_251_48.prefab_name] ~= nil then
						local var_251_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_48.prefab_name].transform, "story_v_out_320071", "320071059", "story_v_out_320071.awb")

						arg_248_1:RecordAudio("320071059", var_251_54)
						arg_248_1:RecordAudio("320071059", var_251_54)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_320071", "320071059", "story_v_out_320071.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_320071", "320071059", "story_v_out_320071.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_55 = var_251_44 + 0.3
			local var_251_56 = math.max(var_251_45, arg_248_1.talkMaxDuration)

			if var_251_55 <= arg_248_1.time_ and arg_248_1.time_ < var_251_55 + var_251_56 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_55) / var_251_56

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_55 + var_251_56 and arg_248_1.time_ < var_251_55 + var_251_56 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play320071060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 320071060
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play320071061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1056ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1056ui_story == nil then
				arg_254_1.var_.characterEffect1056ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1056ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1056ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1056ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1056ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0.3
			local var_257_7 = 1

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				local var_257_8 = "play"
				local var_257_9 = "effect"

				arg_254_1:AudioAction(var_257_8, var_257_9, "se_story_136", "se_story_136_mock", "")
			end

			local var_257_10 = 0
			local var_257_11 = 1.55

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_12 = arg_254_1:GetWordFromCfg(320071060)
				local var_257_13 = arg_254_1:FormatText(var_257_12.content)

				arg_254_1.text_.text = var_257_13

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_14 = 62
				local var_257_15 = utf8.len(var_257_13)
				local var_257_16 = var_257_14 <= 0 and var_257_11 or var_257_11 * (var_257_15 / var_257_14)

				if var_257_16 > 0 and var_257_11 < var_257_16 then
					arg_254_1.talkMaxDuration = var_257_16

					if var_257_16 + var_257_10 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_16 + var_257_10
					end
				end

				arg_254_1.text_.text = var_257_13
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_17 = math.max(var_257_11, arg_254_1.talkMaxDuration)

			if var_257_10 <= arg_254_1.time_ and arg_254_1.time_ < var_257_10 + var_257_17 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_10) / var_257_17

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_10 + var_257_17 and arg_254_1.time_ < var_257_10 + var_257_17 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play320071061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 320071061
		arg_258_1.duration_ = 8.27

		local var_258_0 = {
			zh = 8.266,
			ja = 6.2
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
				arg_258_0:Play320071062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 1

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				local var_261_2 = "stop"
				local var_261_3 = "effect"

				arg_258_1:AudioAction(var_261_2, var_261_3, "se_story_136", "se_story_136_mock", "")
			end

			local var_261_4 = 0
			local var_261_5 = 0.725

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_6 = arg_258_1:FormatText(StoryNameCfg[36].name)

				arg_258_1.leftNameTxt_.text = var_261_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_7 = arg_258_1:GetWordFromCfg(320071061)
				local var_261_8 = arg_258_1:FormatText(var_261_7.content)

				arg_258_1.text_.text = var_261_8

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 29
				local var_261_10 = utf8.len(var_261_8)
				local var_261_11 = var_261_9 <= 0 and var_261_5 or var_261_5 * (var_261_10 / var_261_9)

				if var_261_11 > 0 and var_261_5 < var_261_11 then
					arg_258_1.talkMaxDuration = var_261_11

					if var_261_11 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_11 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_8
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071061", "story_v_out_320071.awb") ~= 0 then
					local var_261_12 = manager.audio:GetVoiceLength("story_v_out_320071", "320071061", "story_v_out_320071.awb") / 1000

					if var_261_12 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_4
					end

					if var_261_7.prefab_name ~= "" and arg_258_1.actors_[var_261_7.prefab_name] ~= nil then
						local var_261_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_7.prefab_name].transform, "story_v_out_320071", "320071061", "story_v_out_320071.awb")

						arg_258_1:RecordAudio("320071061", var_261_13)
						arg_258_1:RecordAudio("320071061", var_261_13)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_320071", "320071061", "story_v_out_320071.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_320071", "320071061", "story_v_out_320071.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_14 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_14 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_14

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_14 and arg_258_1.time_ < var_261_4 + var_261_14 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play320071062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 320071062
		arg_262_1.duration_ = 2

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play320071063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1056ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1056ui_story == nil then
				arg_262_1.var_.characterEffect1056ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1056ui_story and not isNil(var_265_0) then
					arg_262_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1056ui_story then
				arg_262_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_265_4 = 0

			if var_265_4 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_265_5 = 0

			if var_265_5 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_265_6 = 0
			local var_265_7 = 0.15

			if var_265_6 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_8 = arg_262_1:FormatText(StoryNameCfg[605].name)

				arg_262_1.leftNameTxt_.text = var_265_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_9 = arg_262_1:GetWordFromCfg(320071062)
				local var_265_10 = arg_262_1:FormatText(var_265_9.content)

				arg_262_1.text_.text = var_265_10

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 6
				local var_265_12 = utf8.len(var_265_10)
				local var_265_13 = var_265_11 <= 0 and var_265_7 or var_265_7 * (var_265_12 / var_265_11)

				if var_265_13 > 0 and var_265_7 < var_265_13 then
					arg_262_1.talkMaxDuration = var_265_13

					if var_265_13 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_13 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_10
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071062", "story_v_out_320071.awb") ~= 0 then
					local var_265_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071062", "story_v_out_320071.awb") / 1000

					if var_265_14 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_14 + var_265_6
					end

					if var_265_9.prefab_name ~= "" and arg_262_1.actors_[var_265_9.prefab_name] ~= nil then
						local var_265_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_9.prefab_name].transform, "story_v_out_320071", "320071062", "story_v_out_320071.awb")

						arg_262_1:RecordAudio("320071062", var_265_15)
						arg_262_1:RecordAudio("320071062", var_265_15)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_320071", "320071062", "story_v_out_320071.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_320071", "320071062", "story_v_out_320071.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_16 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_16 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_16

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_16 and arg_262_1.time_ < var_265_6 + var_265_16 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play320071063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 320071063
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play320071064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1056ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1056ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, 100, 0)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1056ui_story, var_269_4, var_269_3)

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

			local var_269_9 = arg_266_1.actors_["1056ui_story"]
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1056ui_story == nil then
				arg_266_1.var_.characterEffect1056ui_story = var_269_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_11 = 0.200000002980232

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 and not isNil(var_269_9) then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11

				if arg_266_1.var_.characterEffect1056ui_story and not isNil(var_269_9) then
					local var_269_13 = Mathf.Lerp(0, 0.5, var_269_12)

					arg_266_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1056ui_story.fillRatio = var_269_13
				end
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1056ui_story then
				local var_269_14 = 0.5

				arg_266_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1056ui_story.fillRatio = var_269_14
			end

			local var_269_15 = 0
			local var_269_16 = 1.275

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

				local var_269_17 = arg_266_1:GetWordFromCfg(320071063)
				local var_269_18 = arg_266_1:FormatText(var_269_17.content)

				arg_266_1.text_.text = var_269_18

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_19 = 51
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
				actorName = "1056ui_story",
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
	Play320071064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 320071064
		arg_270_1.duration_ = 10.47

		local var_270_0 = {
			zh = 4.566,
			ja = 10.466
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
				arg_270_0:Play320071065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action8_1")
			end

			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_273_2 = arg_270_1.actors_["1056ui_story"].transform
			local var_273_3 = 0

			if var_273_3 < arg_270_1.time_ and arg_270_1.time_ <= var_273_3 + arg_273_0 then
				arg_270_1.var_.moveOldPos1056ui_story = var_273_2.localPosition
			end

			local var_273_4 = 0.001

			if var_273_3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_3 + var_273_4 then
				local var_273_5 = (arg_270_1.time_ - var_273_3) / var_273_4
				local var_273_6 = Vector3.New(0, -1, -5.75)

				var_273_2.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1056ui_story, var_273_6, var_273_5)

				local var_273_7 = manager.ui.mainCamera.transform.position - var_273_2.position

				var_273_2.forward = Vector3.New(var_273_7.x, var_273_7.y, var_273_7.z)

				local var_273_8 = var_273_2.localEulerAngles

				var_273_8.z = 0
				var_273_8.x = 0
				var_273_2.localEulerAngles = var_273_8
			end

			if arg_270_1.time_ >= var_273_3 + var_273_4 and arg_270_1.time_ < var_273_3 + var_273_4 + arg_273_0 then
				var_273_2.localPosition = Vector3.New(0, -1, -5.75)

				local var_273_9 = manager.ui.mainCamera.transform.position - var_273_2.position

				var_273_2.forward = Vector3.New(var_273_9.x, var_273_9.y, var_273_9.z)

				local var_273_10 = var_273_2.localEulerAngles

				var_273_10.z = 0
				var_273_10.x = 0
				var_273_2.localEulerAngles = var_273_10
			end

			local var_273_11 = arg_270_1.actors_["1056ui_story"]
			local var_273_12 = 0

			if var_273_12 < arg_270_1.time_ and arg_270_1.time_ <= var_273_12 + arg_273_0 and not isNil(var_273_11) and arg_270_1.var_.characterEffect1056ui_story == nil then
				arg_270_1.var_.characterEffect1056ui_story = var_273_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_13 = 0.200000002980232

			if var_273_12 <= arg_270_1.time_ and arg_270_1.time_ < var_273_12 + var_273_13 and not isNil(var_273_11) then
				local var_273_14 = (arg_270_1.time_ - var_273_12) / var_273_13

				if arg_270_1.var_.characterEffect1056ui_story and not isNil(var_273_11) then
					arg_270_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_12 + var_273_13 and arg_270_1.time_ < var_273_12 + var_273_13 + arg_273_0 and not isNil(var_273_11) and arg_270_1.var_.characterEffect1056ui_story then
				arg_270_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_273_15 = 0
			local var_273_16 = 0.55

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_17 = arg_270_1:FormatText(StoryNameCfg[605].name)

				arg_270_1.leftNameTxt_.text = var_273_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_18 = arg_270_1:GetWordFromCfg(320071064)
				local var_273_19 = arg_270_1:FormatText(var_273_18.content)

				arg_270_1.text_.text = var_273_19

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 22
				local var_273_21 = utf8.len(var_273_19)
				local var_273_22 = var_273_20 <= 0 and var_273_16 or var_273_16 * (var_273_21 / var_273_20)

				if var_273_22 > 0 and var_273_16 < var_273_22 then
					arg_270_1.talkMaxDuration = var_273_22

					if var_273_22 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_22 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_19
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071064", "story_v_out_320071.awb") ~= 0 then
					local var_273_23 = manager.audio:GetVoiceLength("story_v_out_320071", "320071064", "story_v_out_320071.awb") / 1000

					if var_273_23 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_15
					end

					if var_273_18.prefab_name ~= "" and arg_270_1.actors_[var_273_18.prefab_name] ~= nil then
						local var_273_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_18.prefab_name].transform, "story_v_out_320071", "320071064", "story_v_out_320071.awb")

						arg_270_1:RecordAudio("320071064", var_273_24)
						arg_270_1:RecordAudio("320071064", var_273_24)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_320071", "320071064", "story_v_out_320071.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_320071", "320071064", "story_v_out_320071.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_25 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_25 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_25

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_25 and arg_270_1.time_ < var_273_15 + var_273_25 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play320071065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 320071065
		arg_274_1.duration_ = 11.27

		local var_274_0 = {
			zh = 11.266,
			ja = 10
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
				arg_274_0:Play320071066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1056ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1056ui_story == nil then
				arg_274_1.var_.characterEffect1056ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect1056ui_story and not isNil(var_277_0) then
					local var_277_4 = Mathf.Lerp(0, 0.5, var_277_3)

					arg_274_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1056ui_story.fillRatio = var_277_4
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1056ui_story then
				local var_277_5 = 0.5

				arg_274_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1056ui_story.fillRatio = var_277_5
			end

			local var_277_6 = 0
			local var_277_7 = 1.15

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_8 = arg_274_1:FormatText(StoryNameCfg[1036].name)

				arg_274_1.leftNameTxt_.text = var_277_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_9 = arg_274_1:GetWordFromCfg(320071065)
				local var_277_10 = arg_274_1:FormatText(var_277_9.content)

				arg_274_1.text_.text = var_277_10

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 46
				local var_277_12 = utf8.len(var_277_10)
				local var_277_13 = var_277_11 <= 0 and var_277_7 or var_277_7 * (var_277_12 / var_277_11)

				if var_277_13 > 0 and var_277_7 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_10
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071065", "story_v_out_320071.awb") ~= 0 then
					local var_277_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071065", "story_v_out_320071.awb") / 1000

					if var_277_14 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_14 + var_277_6
					end

					if var_277_9.prefab_name ~= "" and arg_274_1.actors_[var_277_9.prefab_name] ~= nil then
						local var_277_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_9.prefab_name].transform, "story_v_out_320071", "320071065", "story_v_out_320071.awb")

						arg_274_1:RecordAudio("320071065", var_277_15)
						arg_274_1:RecordAudio("320071065", var_277_15)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_320071", "320071065", "story_v_out_320071.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_320071", "320071065", "story_v_out_320071.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_16 and arg_274_1.time_ < var_277_6 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play320071066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 320071066
		arg_278_1.duration_ = 12.47

		local var_278_0 = {
			zh = 12.466,
			ja = 10.366
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play320071067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.475

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[1036].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(320071066)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 59
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071066", "story_v_out_320071.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071066", "story_v_out_320071.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_320071", "320071066", "story_v_out_320071.awb")

						arg_278_1:RecordAudio("320071066", var_281_9)
						arg_278_1:RecordAudio("320071066", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_320071", "320071066", "story_v_out_320071.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_320071", "320071066", "story_v_out_320071.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play320071067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 320071067
		arg_282_1.duration_ = 10.77

		local var_282_0 = {
			zh = 10.766,
			ja = 9.666
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play320071068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1056ui_story"].transform
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.var_.moveOldPos1056ui_story = var_285_0.localPosition
			end

			local var_285_2 = 0.001

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2
				local var_285_4 = Vector3.New(0, -1, -5.75)

				var_285_0.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1056ui_story, var_285_4, var_285_3)

				local var_285_5 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_5.x, var_285_5.y, var_285_5.z)

				local var_285_6 = var_285_0.localEulerAngles

				var_285_6.z = 0
				var_285_6.x = 0
				var_285_0.localEulerAngles = var_285_6
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 then
				var_285_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_285_7 = manager.ui.mainCamera.transform.position - var_285_0.position

				var_285_0.forward = Vector3.New(var_285_7.x, var_285_7.y, var_285_7.z)

				local var_285_8 = var_285_0.localEulerAngles

				var_285_8.z = 0
				var_285_8.x = 0
				var_285_0.localEulerAngles = var_285_8
			end

			local var_285_9 = arg_282_1.actors_["1056ui_story"]
			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1056ui_story == nil then
				arg_282_1.var_.characterEffect1056ui_story = var_285_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_11 = 0.200000002980232

			if var_285_10 <= arg_282_1.time_ and arg_282_1.time_ < var_285_10 + var_285_11 and not isNil(var_285_9) then
				local var_285_12 = (arg_282_1.time_ - var_285_10) / var_285_11

				if arg_282_1.var_.characterEffect1056ui_story and not isNil(var_285_9) then
					arg_282_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_10 + var_285_11 and arg_282_1.time_ < var_285_10 + var_285_11 + arg_285_0 and not isNil(var_285_9) and arg_282_1.var_.characterEffect1056ui_story then
				arg_282_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_285_13 = 0

			if var_285_13 < arg_282_1.time_ and arg_282_1.time_ <= var_285_13 + arg_285_0 then
				arg_282_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056actionlink/1056action482")
			end

			local var_285_14 = 0

			if var_285_14 < arg_282_1.time_ and arg_282_1.time_ <= var_285_14 + arg_285_0 then
				arg_282_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_285_15 = 0
			local var_285_16 = 1.325

			if var_285_15 < arg_282_1.time_ and arg_282_1.time_ <= var_285_15 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_17 = arg_282_1:FormatText(StoryNameCfg[605].name)

				arg_282_1.leftNameTxt_.text = var_285_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_18 = arg_282_1:GetWordFromCfg(320071067)
				local var_285_19 = arg_282_1:FormatText(var_285_18.content)

				arg_282_1.text_.text = var_285_19

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_20 = 53
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071067", "story_v_out_320071.awb") ~= 0 then
					local var_285_23 = manager.audio:GetVoiceLength("story_v_out_320071", "320071067", "story_v_out_320071.awb") / 1000

					if var_285_23 + var_285_15 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_23 + var_285_15
					end

					if var_285_18.prefab_name ~= "" and arg_282_1.actors_[var_285_18.prefab_name] ~= nil then
						local var_285_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_18.prefab_name].transform, "story_v_out_320071", "320071067", "story_v_out_320071.awb")

						arg_282_1:RecordAudio("320071067", var_285_24)
						arg_282_1:RecordAudio("320071067", var_285_24)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_320071", "320071067", "story_v_out_320071.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_320071", "320071067", "story_v_out_320071.awb")
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
				actorName = "1056ui_story",
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
	Play320071068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 320071068
		arg_286_1.duration_ = 10.33

		local var_286_0 = {
			zh = 7.533,
			ja = 10.333
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play320071069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["1056ui_story"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1056ui_story == nil then
				arg_286_1.var_.characterEffect1056ui_story = var_289_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.characterEffect1056ui_story and not isNil(var_289_0) then
					local var_289_4 = Mathf.Lerp(0, 0.5, var_289_3)

					arg_286_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1056ui_story.fillRatio = var_289_4
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.characterEffect1056ui_story then
				local var_289_5 = 0.5

				arg_286_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1056ui_story.fillRatio = var_289_5
			end

			local var_289_6 = 0
			local var_289_7 = 0.575

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_8 = arg_286_1:FormatText(StoryNameCfg[1036].name)

				arg_286_1.leftNameTxt_.text = var_289_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_9 = arg_286_1:GetWordFromCfg(320071068)
				local var_289_10 = arg_286_1:FormatText(var_289_9.content)

				arg_286_1.text_.text = var_289_10

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_11 = 23
				local var_289_12 = utf8.len(var_289_10)
				local var_289_13 = var_289_11 <= 0 and var_289_7 or var_289_7 * (var_289_12 / var_289_11)

				if var_289_13 > 0 and var_289_7 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_6
					end
				end

				arg_286_1.text_.text = var_289_10
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071068", "story_v_out_320071.awb") ~= 0 then
					local var_289_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071068", "story_v_out_320071.awb") / 1000

					if var_289_14 + var_289_6 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_6
					end

					if var_289_9.prefab_name ~= "" and arg_286_1.actors_[var_289_9.prefab_name] ~= nil then
						local var_289_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_9.prefab_name].transform, "story_v_out_320071", "320071068", "story_v_out_320071.awb")

						arg_286_1:RecordAudio("320071068", var_289_15)
						arg_286_1:RecordAudio("320071068", var_289_15)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_320071", "320071068", "story_v_out_320071.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_320071", "320071068", "story_v_out_320071.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_7, arg_286_1.talkMaxDuration)

			if var_289_6 <= arg_286_1.time_ and arg_286_1.time_ < var_289_6 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_6) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_6 + var_289_16 and arg_286_1.time_ < var_289_6 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play320071069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 320071069
		arg_290_1.duration_ = 13.07

		local var_290_0 = {
			zh = 13.066,
			ja = 10.633
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play320071070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1056ui_story"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1056ui_story == nil then
				arg_290_1.var_.characterEffect1056ui_story = var_293_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.characterEffect1056ui_story and not isNil(var_293_0) then
					arg_290_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.characterEffect1056ui_story then
				arg_290_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_293_4 = 0

			if var_293_4 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action2_2")
			end

			local var_293_5 = 0

			if var_293_5 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_293_6 = 0
			local var_293_7 = 1.275

			if var_293_6 < arg_290_1.time_ and arg_290_1.time_ <= var_293_6 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_8 = arg_290_1:FormatText(StoryNameCfg[605].name)

				arg_290_1.leftNameTxt_.text = var_293_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_9 = arg_290_1:GetWordFromCfg(320071069)
				local var_293_10 = arg_290_1:FormatText(var_293_9.content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_11 = 51
				local var_293_12 = utf8.len(var_293_10)
				local var_293_13 = var_293_11 <= 0 and var_293_7 or var_293_7 * (var_293_12 / var_293_11)

				if var_293_13 > 0 and var_293_7 < var_293_13 then
					arg_290_1.talkMaxDuration = var_293_13

					if var_293_13 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_13 + var_293_6
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071069", "story_v_out_320071.awb") ~= 0 then
					local var_293_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071069", "story_v_out_320071.awb") / 1000

					if var_293_14 + var_293_6 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_14 + var_293_6
					end

					if var_293_9.prefab_name ~= "" and arg_290_1.actors_[var_293_9.prefab_name] ~= nil then
						local var_293_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_9.prefab_name].transform, "story_v_out_320071", "320071069", "story_v_out_320071.awb")

						arg_290_1:RecordAudio("320071069", var_293_15)
						arg_290_1:RecordAudio("320071069", var_293_15)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_320071", "320071069", "story_v_out_320071.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_320071", "320071069", "story_v_out_320071.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_16 = math.max(var_293_7, arg_290_1.talkMaxDuration)

			if var_293_6 <= arg_290_1.time_ and arg_290_1.time_ < var_293_6 + var_293_16 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_6) / var_293_16

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_6 + var_293_16 and arg_290_1.time_ < var_293_6 + var_293_16 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play320071070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 320071070
		arg_294_1.duration_ = 8.5

		local var_294_0 = {
			zh = 6.633,
			ja = 8.5
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play320071071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.95

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[605].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:GetWordFromCfg(320071070)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 38
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071070", "story_v_out_320071.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071070", "story_v_out_320071.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_320071", "320071070", "story_v_out_320071.awb")

						arg_294_1:RecordAudio("320071070", var_297_9)
						arg_294_1:RecordAudio("320071070", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_320071", "320071070", "story_v_out_320071.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_320071", "320071070", "story_v_out_320071.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_10 and arg_294_1.time_ < var_297_0 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play320071071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 320071071
		arg_298_1.duration_ = 7.13

		local var_298_0 = {
			zh = 7.033,
			ja = 7.133
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play320071072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.9

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[605].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_3 = arg_298_1:GetWordFromCfg(320071071)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071071", "story_v_out_320071.awb") ~= 0 then
					local var_301_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071071", "story_v_out_320071.awb") / 1000

					if var_301_8 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_8 + var_301_0
					end

					if var_301_3.prefab_name ~= "" and arg_298_1.actors_[var_301_3.prefab_name] ~= nil then
						local var_301_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_3.prefab_name].transform, "story_v_out_320071", "320071071", "story_v_out_320071.awb")

						arg_298_1:RecordAudio("320071071", var_301_9)
						arg_298_1:RecordAudio("320071071", var_301_9)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_320071", "320071071", "story_v_out_320071.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_320071", "320071071", "story_v_out_320071.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_10 and arg_298_1.time_ < var_301_0 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play320071072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 320071072
		arg_302_1.duration_ = 4.7

		local var_302_0 = {
			zh = 2.566,
			ja = 4.7
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play320071073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1056ui_story"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1056ui_story == nil then
				arg_302_1.var_.characterEffect1056ui_story = var_305_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.characterEffect1056ui_story and not isNil(var_305_0) then
					local var_305_4 = Mathf.Lerp(0, 0.5, var_305_3)

					arg_302_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1056ui_story.fillRatio = var_305_4
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.characterEffect1056ui_story then
				local var_305_5 = 0.5

				arg_302_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1056ui_story.fillRatio = var_305_5
			end

			local var_305_6 = 0
			local var_305_7 = 0.275

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_8 = arg_302_1:FormatText(StoryNameCfg[1036].name)

				arg_302_1.leftNameTxt_.text = var_305_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_9 = arg_302_1:GetWordFromCfg(320071072)
				local var_305_10 = arg_302_1:FormatText(var_305_9.content)

				arg_302_1.text_.text = var_305_10

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 11
				local var_305_12 = utf8.len(var_305_10)
				local var_305_13 = var_305_11 <= 0 and var_305_7 or var_305_7 * (var_305_12 / var_305_11)

				if var_305_13 > 0 and var_305_7 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_10
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071072", "story_v_out_320071.awb") ~= 0 then
					local var_305_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071072", "story_v_out_320071.awb") / 1000

					if var_305_14 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_6
					end

					if var_305_9.prefab_name ~= "" and arg_302_1.actors_[var_305_9.prefab_name] ~= nil then
						local var_305_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_9.prefab_name].transform, "story_v_out_320071", "320071072", "story_v_out_320071.awb")

						arg_302_1:RecordAudio("320071072", var_305_15)
						arg_302_1:RecordAudio("320071072", var_305_15)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_320071", "320071072", "story_v_out_320071.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_320071", "320071072", "story_v_out_320071.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_16 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_16 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_16

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_16 and arg_302_1.time_ < var_305_6 + var_305_16 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play320071073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 320071073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play320071074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1056ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos1056ui_story = var_309_0.localPosition
			end

			local var_309_2 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2
				local var_309_4 = Vector3.New(0, 100, 0)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1056ui_story, var_309_4, var_309_3)

				local var_309_5 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_5.x, var_309_5.y, var_309_5.z)

				local var_309_6 = var_309_0.localEulerAngles

				var_309_6.z = 0
				var_309_6.x = 0
				var_309_0.localEulerAngles = var_309_6
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, 100, 0)

				local var_309_7 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_7.x, var_309_7.y, var_309_7.z)

				local var_309_8 = var_309_0.localEulerAngles

				var_309_8.z = 0
				var_309_8.x = 0
				var_309_0.localEulerAngles = var_309_8
			end

			local var_309_9 = arg_306_1.actors_["1056ui_story"]
			local var_309_10 = 0

			if var_309_10 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1056ui_story == nil then
				arg_306_1.var_.characterEffect1056ui_story = var_309_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_11 = 0.200000002980232

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_11 and not isNil(var_309_9) then
				local var_309_12 = (arg_306_1.time_ - var_309_10) / var_309_11

				if arg_306_1.var_.characterEffect1056ui_story and not isNil(var_309_9) then
					local var_309_13 = Mathf.Lerp(0, 0.5, var_309_12)

					arg_306_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1056ui_story.fillRatio = var_309_13
				end
			end

			if arg_306_1.time_ >= var_309_10 + var_309_11 and arg_306_1.time_ < var_309_10 + var_309_11 + arg_309_0 and not isNil(var_309_9) and arg_306_1.var_.characterEffect1056ui_story then
				local var_309_14 = 0.5

				arg_306_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1056ui_story.fillRatio = var_309_14
			end

			local var_309_15 = 0
			local var_309_16 = 1.325

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_17 = arg_306_1:GetWordFromCfg(320071073)
				local var_309_18 = arg_306_1:FormatText(var_309_17.content)

				arg_306_1.text_.text = var_309_18

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_19 = 53
				local var_309_20 = utf8.len(var_309_18)
				local var_309_21 = var_309_19 <= 0 and var_309_16 or var_309_16 * (var_309_20 / var_309_19)

				if var_309_21 > 0 and var_309_16 < var_309_21 then
					arg_306_1.talkMaxDuration = var_309_21

					if var_309_21 + var_309_15 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_21 + var_309_15
					end
				end

				arg_306_1.text_.text = var_309_18
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_22 = math.max(var_309_16, arg_306_1.talkMaxDuration)

			if var_309_15 <= arg_306_1.time_ and arg_306_1.time_ < var_309_15 + var_309_22 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_15) / var_309_22

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_15 + var_309_22 and arg_306_1.time_ < var_309_15 + var_309_22 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play320071074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 320071074
		arg_310_1.duration_ = 9.53

		local var_310_0 = {
			zh = 9.533,
			ja = 6.266
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play320071075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 0.9

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_2 = arg_310_1:FormatText(StoryNameCfg[1036].name)

				arg_310_1.leftNameTxt_.text = var_313_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:GetWordFromCfg(320071074)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 36
				local var_313_6 = utf8.len(var_313_4)
				local var_313_7 = var_313_5 <= 0 and var_313_1 or var_313_1 * (var_313_6 / var_313_5)

				if var_313_7 > 0 and var_313_1 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071074", "story_v_out_320071.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071074", "story_v_out_320071.awb") / 1000

					if var_313_8 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_0
					end

					if var_313_3.prefab_name ~= "" and arg_310_1.actors_[var_313_3.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_3.prefab_name].transform, "story_v_out_320071", "320071074", "story_v_out_320071.awb")

						arg_310_1:RecordAudio("320071074", var_313_9)
						arg_310_1:RecordAudio("320071074", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_320071", "320071074", "story_v_out_320071.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_320071", "320071074", "story_v_out_320071.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_10 and arg_310_1.time_ < var_313_0 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play320071075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 320071075
		arg_314_1.duration_ = 18.17

		local var_314_0 = {
			zh = 11.3,
			ja = 18.166
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play320071076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 1.25

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_2 = arg_314_1:FormatText(StoryNameCfg[1036].name)

				arg_314_1.leftNameTxt_.text = var_317_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:GetWordFromCfg(320071075)
				local var_317_4 = arg_314_1:FormatText(var_317_3.content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 50
				local var_317_6 = utf8.len(var_317_4)
				local var_317_7 = var_317_5 <= 0 and var_317_1 or var_317_1 * (var_317_6 / var_317_5)

				if var_317_7 > 0 and var_317_1 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071075", "story_v_out_320071.awb") ~= 0 then
					local var_317_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071075", "story_v_out_320071.awb") / 1000

					if var_317_8 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_0
					end

					if var_317_3.prefab_name ~= "" and arg_314_1.actors_[var_317_3.prefab_name] ~= nil then
						local var_317_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_3.prefab_name].transform, "story_v_out_320071", "320071075", "story_v_out_320071.awb")

						arg_314_1:RecordAudio("320071075", var_317_9)
						arg_314_1:RecordAudio("320071075", var_317_9)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_320071", "320071075", "story_v_out_320071.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_320071", "320071075", "story_v_out_320071.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_10 and arg_314_1.time_ < var_317_0 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play320071076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 320071076
		arg_318_1.duration_ = 9.2

		local var_318_0 = {
			zh = 5.3,
			ja = 9.2
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play320071077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1056ui_story"]
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1056ui_story == nil then
				arg_318_1.var_.characterEffect1056ui_story = var_321_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 and not isNil(var_321_0) then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2

				if arg_318_1.var_.characterEffect1056ui_story and not isNil(var_321_0) then
					arg_318_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 and not isNil(var_321_0) and arg_318_1.var_.characterEffect1056ui_story then
				arg_318_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_321_4 = 0

			if var_321_4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_321_5 = arg_318_1.actors_["1056ui_story"].transform
			local var_321_6 = 0

			if var_321_6 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.var_.moveOldPos1056ui_story = var_321_5.localPosition
			end

			local var_321_7 = 0.001

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_7 then
				local var_321_8 = (arg_318_1.time_ - var_321_6) / var_321_7
				local var_321_9 = Vector3.New(0, -1, -5.75)

				var_321_5.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1056ui_story, var_321_9, var_321_8)

				local var_321_10 = manager.ui.mainCamera.transform.position - var_321_5.position

				var_321_5.forward = Vector3.New(var_321_10.x, var_321_10.y, var_321_10.z)

				local var_321_11 = var_321_5.localEulerAngles

				var_321_11.z = 0
				var_321_11.x = 0
				var_321_5.localEulerAngles = var_321_11
			end

			if arg_318_1.time_ >= var_321_6 + var_321_7 and arg_318_1.time_ < var_321_6 + var_321_7 + arg_321_0 then
				var_321_5.localPosition = Vector3.New(0, -1, -5.75)

				local var_321_12 = manager.ui.mainCamera.transform.position - var_321_5.position

				var_321_5.forward = Vector3.New(var_321_12.x, var_321_12.y, var_321_12.z)

				local var_321_13 = var_321_5.localEulerAngles

				var_321_13.z = 0
				var_321_13.x = 0
				var_321_5.localEulerAngles = var_321_13
			end

			local var_321_14 = 0

			if var_321_14 < arg_318_1.time_ and arg_318_1.time_ <= var_321_14 + arg_321_0 then
				arg_318_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_321_15 = 0
			local var_321_16 = 0.675

			if var_321_15 < arg_318_1.time_ and arg_318_1.time_ <= var_321_15 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_17 = arg_318_1:FormatText(StoryNameCfg[605].name)

				arg_318_1.leftNameTxt_.text = var_321_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_18 = arg_318_1:GetWordFromCfg(320071076)
				local var_321_19 = arg_318_1:FormatText(var_321_18.content)

				arg_318_1.text_.text = var_321_19

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_20 = 27
				local var_321_21 = utf8.len(var_321_19)
				local var_321_22 = var_321_20 <= 0 and var_321_16 or var_321_16 * (var_321_21 / var_321_20)

				if var_321_22 > 0 and var_321_16 < var_321_22 then
					arg_318_1.talkMaxDuration = var_321_22

					if var_321_22 + var_321_15 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_22 + var_321_15
					end
				end

				arg_318_1.text_.text = var_321_19
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071076", "story_v_out_320071.awb") ~= 0 then
					local var_321_23 = manager.audio:GetVoiceLength("story_v_out_320071", "320071076", "story_v_out_320071.awb") / 1000

					if var_321_23 + var_321_15 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_23 + var_321_15
					end

					if var_321_18.prefab_name ~= "" and arg_318_1.actors_[var_321_18.prefab_name] ~= nil then
						local var_321_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_18.prefab_name].transform, "story_v_out_320071", "320071076", "story_v_out_320071.awb")

						arg_318_1:RecordAudio("320071076", var_321_24)
						arg_318_1:RecordAudio("320071076", var_321_24)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_320071", "320071076", "story_v_out_320071.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_320071", "320071076", "story_v_out_320071.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_25 = math.max(var_321_16, arg_318_1.talkMaxDuration)

			if var_321_15 <= arg_318_1.time_ and arg_318_1.time_ < var_321_15 + var_321_25 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_15) / var_321_25

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_15 + var_321_25 and arg_318_1.time_ < var_321_15 + var_321_25 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play320071077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 320071077
		arg_322_1.duration_ = 6.97

		local var_322_0 = {
			zh = 4.9,
			ja = 6.966
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play320071078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1056ui_story"]
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1056ui_story == nil then
				arg_322_1.var_.characterEffect1056ui_story = var_325_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_2 = 0.200000002980232

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 and not isNil(var_325_0) then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / var_325_2

				if arg_322_1.var_.characterEffect1056ui_story and not isNil(var_325_0) then
					local var_325_4 = Mathf.Lerp(0, 0.5, var_325_3)

					arg_322_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1056ui_story.fillRatio = var_325_4
				end
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 and not isNil(var_325_0) and arg_322_1.var_.characterEffect1056ui_story then
				local var_325_5 = 0.5

				arg_322_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1056ui_story.fillRatio = var_325_5
			end

			local var_325_6 = 0
			local var_325_7 = 0.375

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_8 = arg_322_1:FormatText(StoryNameCfg[1036].name)

				arg_322_1.leftNameTxt_.text = var_325_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_9 = arg_322_1:GetWordFromCfg(320071077)
				local var_325_10 = arg_322_1:FormatText(var_325_9.content)

				arg_322_1.text_.text = var_325_10

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_11 = 15
				local var_325_12 = utf8.len(var_325_10)
				local var_325_13 = var_325_11 <= 0 and var_325_7 or var_325_7 * (var_325_12 / var_325_11)

				if var_325_13 > 0 and var_325_7 < var_325_13 then
					arg_322_1.talkMaxDuration = var_325_13

					if var_325_13 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_13 + var_325_6
					end
				end

				arg_322_1.text_.text = var_325_10
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071077", "story_v_out_320071.awb") ~= 0 then
					local var_325_14 = manager.audio:GetVoiceLength("story_v_out_320071", "320071077", "story_v_out_320071.awb") / 1000

					if var_325_14 + var_325_6 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_14 + var_325_6
					end

					if var_325_9.prefab_name ~= "" and arg_322_1.actors_[var_325_9.prefab_name] ~= nil then
						local var_325_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_9.prefab_name].transform, "story_v_out_320071", "320071077", "story_v_out_320071.awb")

						arg_322_1:RecordAudio("320071077", var_325_15)
						arg_322_1:RecordAudio("320071077", var_325_15)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_320071", "320071077", "story_v_out_320071.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_320071", "320071077", "story_v_out_320071.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_16 = math.max(var_325_7, arg_322_1.talkMaxDuration)

			if var_325_6 <= arg_322_1.time_ and arg_322_1.time_ < var_325_6 + var_325_16 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_6) / var_325_16

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_6 + var_325_16 and arg_322_1.time_ < var_325_6 + var_325_16 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play320071078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 320071078
		arg_326_1.duration_ = 7.77

		local var_326_0 = {
			zh = 7.766,
			ja = 6.8
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play320071079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 1

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[1036].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(320071078)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071078", "story_v_out_320071.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071078", "story_v_out_320071.awb") / 1000

					if var_329_8 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_0
					end

					if var_329_3.prefab_name ~= "" and arg_326_1.actors_[var_329_3.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_3.prefab_name].transform, "story_v_out_320071", "320071078", "story_v_out_320071.awb")

						arg_326_1:RecordAudio("320071078", var_329_9)
						arg_326_1:RecordAudio("320071078", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_320071", "320071078", "story_v_out_320071.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_320071", "320071078", "story_v_out_320071.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_10 and arg_326_1.time_ < var_329_0 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play320071079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 320071079
		arg_330_1.duration_ = 11.6

		local var_330_0 = {
			zh = 8.466,
			ja = 11.6
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play320071080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.75

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_2 = arg_330_1:FormatText(StoryNameCfg[1036].name)

				arg_330_1.leftNameTxt_.text = var_333_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:GetWordFromCfg(320071079)
				local var_333_4 = arg_330_1:FormatText(var_333_3.content)

				arg_330_1.text_.text = var_333_4

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071079", "story_v_out_320071.awb") ~= 0 then
					local var_333_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071079", "story_v_out_320071.awb") / 1000

					if var_333_8 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_8 + var_333_0
					end

					if var_333_3.prefab_name ~= "" and arg_330_1.actors_[var_333_3.prefab_name] ~= nil then
						local var_333_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_3.prefab_name].transform, "story_v_out_320071", "320071079", "story_v_out_320071.awb")

						arg_330_1:RecordAudio("320071079", var_333_9)
						arg_330_1:RecordAudio("320071079", var_333_9)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_320071", "320071079", "story_v_out_320071.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_320071", "320071079", "story_v_out_320071.awb")
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
	Play320071080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 320071080
		arg_334_1.duration_ = 13.8

		local var_334_0 = {
			zh = 13.8,
			ja = 5.4
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play320071081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1056ui_story"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1056ui_story == nil then
				arg_334_1.var_.characterEffect1056ui_story = var_337_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.characterEffect1056ui_story and not isNil(var_337_0) then
					arg_334_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1056ui_story then
				arg_334_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_337_4 = 0

			if var_337_4 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_337_5 = 0
			local var_337_6 = 1.575

			if var_337_5 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_7 = arg_334_1:FormatText(StoryNameCfg[605].name)

				arg_334_1.leftNameTxt_.text = var_337_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_8 = arg_334_1:GetWordFromCfg(320071080)
				local var_337_9 = arg_334_1:FormatText(var_337_8.content)

				arg_334_1.text_.text = var_337_9

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 63
				local var_337_11 = utf8.len(var_337_9)
				local var_337_12 = var_337_10 <= 0 and var_337_6 or var_337_6 * (var_337_11 / var_337_10)

				if var_337_12 > 0 and var_337_6 < var_337_12 then
					arg_334_1.talkMaxDuration = var_337_12

					if var_337_12 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_12 + var_337_5
					end
				end

				arg_334_1.text_.text = var_337_9
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071080", "story_v_out_320071.awb") ~= 0 then
					local var_337_13 = manager.audio:GetVoiceLength("story_v_out_320071", "320071080", "story_v_out_320071.awb") / 1000

					if var_337_13 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_5
					end

					if var_337_8.prefab_name ~= "" and arg_334_1.actors_[var_337_8.prefab_name] ~= nil then
						local var_337_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_8.prefab_name].transform, "story_v_out_320071", "320071080", "story_v_out_320071.awb")

						arg_334_1:RecordAudio("320071080", var_337_14)
						arg_334_1:RecordAudio("320071080", var_337_14)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_320071", "320071080", "story_v_out_320071.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_320071", "320071080", "story_v_out_320071.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_15 = math.max(var_337_6, arg_334_1.talkMaxDuration)

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_15 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_5) / var_337_15

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_5 + var_337_15 and arg_334_1.time_ < var_337_5 + var_337_15 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play320071081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 320071081
		arg_338_1.duration_ = 10.7

		local var_338_0 = {
			zh = 10.7,
			ja = 6.833
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play320071082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				arg_338_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action4_1")
			end

			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_341_2 = 0
			local var_341_3 = 0.9

			if var_341_2 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_4 = arg_338_1:FormatText(StoryNameCfg[605].name)

				arg_338_1.leftNameTxt_.text = var_341_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_5 = arg_338_1:GetWordFromCfg(320071081)
				local var_341_6 = arg_338_1:FormatText(var_341_5.content)

				arg_338_1.text_.text = var_341_6

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 36
				local var_341_8 = utf8.len(var_341_6)
				local var_341_9 = var_341_7 <= 0 and var_341_3 or var_341_3 * (var_341_8 / var_341_7)

				if var_341_9 > 0 and var_341_3 < var_341_9 then
					arg_338_1.talkMaxDuration = var_341_9

					if var_341_9 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_6
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071081", "story_v_out_320071.awb") ~= 0 then
					local var_341_10 = manager.audio:GetVoiceLength("story_v_out_320071", "320071081", "story_v_out_320071.awb") / 1000

					if var_341_10 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_2
					end

					if var_341_5.prefab_name ~= "" and arg_338_1.actors_[var_341_5.prefab_name] ~= nil then
						local var_341_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_5.prefab_name].transform, "story_v_out_320071", "320071081", "story_v_out_320071.awb")

						arg_338_1:RecordAudio("320071081", var_341_11)
						arg_338_1:RecordAudio("320071081", var_341_11)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_320071", "320071081", "story_v_out_320071.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_320071", "320071081", "story_v_out_320071.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_12 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_12 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_12

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_12 and arg_338_1.time_ < var_341_2 + var_341_12 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play320071082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 320071082
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play320071083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1056ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos1056ui_story = var_345_0.localPosition
			end

			local var_345_2 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2
				local var_345_4 = Vector3.New(0, 100, 0)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1056ui_story, var_345_4, var_345_3)

				local var_345_5 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_5.x, var_345_5.y, var_345_5.z)

				local var_345_6 = var_345_0.localEulerAngles

				var_345_6.z = 0
				var_345_6.x = 0
				var_345_0.localEulerAngles = var_345_6
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(0, 100, 0)

				local var_345_7 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_7.x, var_345_7.y, var_345_7.z)

				local var_345_8 = var_345_0.localEulerAngles

				var_345_8.z = 0
				var_345_8.x = 0
				var_345_0.localEulerAngles = var_345_8
			end

			local var_345_9 = arg_342_1.actors_["1056ui_story"]
			local var_345_10 = 0

			if var_345_10 < arg_342_1.time_ and arg_342_1.time_ <= var_345_10 + arg_345_0 and not isNil(var_345_9) and arg_342_1.var_.characterEffect1056ui_story == nil then
				arg_342_1.var_.characterEffect1056ui_story = var_345_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_11 = 0.200000002980232

			if var_345_10 <= arg_342_1.time_ and arg_342_1.time_ < var_345_10 + var_345_11 and not isNil(var_345_9) then
				local var_345_12 = (arg_342_1.time_ - var_345_10) / var_345_11

				if arg_342_1.var_.characterEffect1056ui_story and not isNil(var_345_9) then
					local var_345_13 = Mathf.Lerp(0, 0.5, var_345_12)

					arg_342_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1056ui_story.fillRatio = var_345_13
				end
			end

			if arg_342_1.time_ >= var_345_10 + var_345_11 and arg_342_1.time_ < var_345_10 + var_345_11 + arg_345_0 and not isNil(var_345_9) and arg_342_1.var_.characterEffect1056ui_story then
				local var_345_14 = 0.5

				arg_342_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1056ui_story.fillRatio = var_345_14
			end

			local var_345_15 = 0
			local var_345_16 = 1.125

			if var_345_15 < arg_342_1.time_ and arg_342_1.time_ <= var_345_15 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_17 = arg_342_1:GetWordFromCfg(320071082)
				local var_345_18 = arg_342_1:FormatText(var_345_17.content)

				arg_342_1.text_.text = var_345_18

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_19 = 45
				local var_345_20 = utf8.len(var_345_18)
				local var_345_21 = var_345_19 <= 0 and var_345_16 or var_345_16 * (var_345_20 / var_345_19)

				if var_345_21 > 0 and var_345_16 < var_345_21 then
					arg_342_1.talkMaxDuration = var_345_21

					if var_345_21 + var_345_15 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_21 + var_345_15
					end
				end

				arg_342_1.text_.text = var_345_18
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_22 = math.max(var_345_16, arg_342_1.talkMaxDuration)

			if var_345_15 <= arg_342_1.time_ and arg_342_1.time_ < var_345_15 + var_345_22 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_15) / var_345_22

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_15 + var_345_22 and arg_342_1.time_ < var_345_15 + var_345_22 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play320071083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 320071083
		arg_346_1.duration_ = 9.13

		local var_346_0 = {
			zh = 7.333,
			ja = 9.133
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play320071084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.675

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_2 = arg_346_1:FormatText(StoryNameCfg[1036].name)

				arg_346_1.leftNameTxt_.text = var_349_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_3 = arg_346_1:GetWordFromCfg(320071083)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071083", "story_v_out_320071.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_320071", "320071083", "story_v_out_320071.awb") / 1000

					if var_349_8 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_0
					end

					if var_349_3.prefab_name ~= "" and arg_346_1.actors_[var_349_3.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_3.prefab_name].transform, "story_v_out_320071", "320071083", "story_v_out_320071.awb")

						arg_346_1:RecordAudio("320071083", var_349_9)
						arg_346_1:RecordAudio("320071083", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_320071", "320071083", "story_v_out_320071.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_320071", "320071083", "story_v_out_320071.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_10 and arg_346_1.time_ < var_349_0 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play320071084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 320071084
		arg_350_1.duration_ = 7.07

		local var_350_0 = {
			zh = 5.533,
			ja = 7.066
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
				arg_350_0:Play320071085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["1056ui_story"].transform
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.var_.moveOldPos1056ui_story = var_353_0.localPosition
			end

			local var_353_2 = 0.001

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2
				local var_353_4 = Vector3.New(0, -1, -5.75)

				var_353_0.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1056ui_story, var_353_4, var_353_3)

				local var_353_5 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_5.x, var_353_5.y, var_353_5.z)

				local var_353_6 = var_353_0.localEulerAngles

				var_353_6.z = 0
				var_353_6.x = 0
				var_353_0.localEulerAngles = var_353_6
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 then
				var_353_0.localPosition = Vector3.New(0, -1, -5.75)

				local var_353_7 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_7.x, var_353_7.y, var_353_7.z)

				local var_353_8 = var_353_0.localEulerAngles

				var_353_8.z = 0
				var_353_8.x = 0
				var_353_0.localEulerAngles = var_353_8
			end

			local var_353_9 = arg_350_1.actors_["1056ui_story"]
			local var_353_10 = 0

			if var_353_10 < arg_350_1.time_ and arg_350_1.time_ <= var_353_10 + arg_353_0 and not isNil(var_353_9) and arg_350_1.var_.characterEffect1056ui_story == nil then
				arg_350_1.var_.characterEffect1056ui_story = var_353_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_11 = 0.200000002980232

			if var_353_10 <= arg_350_1.time_ and arg_350_1.time_ < var_353_10 + var_353_11 and not isNil(var_353_9) then
				local var_353_12 = (arg_350_1.time_ - var_353_10) / var_353_11

				if arg_350_1.var_.characterEffect1056ui_story and not isNil(var_353_9) then
					arg_350_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_10 + var_353_11 and arg_350_1.time_ < var_353_10 + var_353_11 + arg_353_0 and not isNil(var_353_9) and arg_350_1.var_.characterEffect1056ui_story then
				arg_350_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_353_13 = 0

			if var_353_13 < arg_350_1.time_ and arg_350_1.time_ <= var_353_13 + arg_353_0 then
				arg_350_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			local var_353_14 = 0

			if var_353_14 < arg_350_1.time_ and arg_350_1.time_ <= var_353_14 + arg_353_0 then
				arg_350_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_353_15 = 0
			local var_353_16 = 0.525

			if var_353_15 < arg_350_1.time_ and arg_350_1.time_ <= var_353_15 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_17 = arg_350_1:FormatText(StoryNameCfg[605].name)

				arg_350_1.leftNameTxt_.text = var_353_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_18 = arg_350_1:GetWordFromCfg(320071084)
				local var_353_19 = arg_350_1:FormatText(var_353_18.content)

				arg_350_1.text_.text = var_353_19

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_20 = 21
				local var_353_21 = utf8.len(var_353_19)
				local var_353_22 = var_353_20 <= 0 and var_353_16 or var_353_16 * (var_353_21 / var_353_20)

				if var_353_22 > 0 and var_353_16 < var_353_22 then
					arg_350_1.talkMaxDuration = var_353_22

					if var_353_22 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_22 + var_353_15
					end
				end

				arg_350_1.text_.text = var_353_19
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071084", "story_v_out_320071.awb") ~= 0 then
					local var_353_23 = manager.audio:GetVoiceLength("story_v_out_320071", "320071084", "story_v_out_320071.awb") / 1000

					if var_353_23 + var_353_15 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_23 + var_353_15
					end

					if var_353_18.prefab_name ~= "" and arg_350_1.actors_[var_353_18.prefab_name] ~= nil then
						local var_353_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_18.prefab_name].transform, "story_v_out_320071", "320071084", "story_v_out_320071.awb")

						arg_350_1:RecordAudio("320071084", var_353_24)
						arg_350_1:RecordAudio("320071084", var_353_24)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_320071", "320071084", "story_v_out_320071.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_320071", "320071084", "story_v_out_320071.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_25 = math.max(var_353_16, arg_350_1.talkMaxDuration)

			if var_353_15 <= arg_350_1.time_ and arg_350_1.time_ < var_353_15 + var_353_25 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_15) / var_353_25

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_15 + var_353_25 and arg_350_1.time_ < var_353_15 + var_353_25 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320071085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 320071085
		arg_354_1.duration_ = 4.1

		local var_354_0 = {
			zh = 4.1,
			ja = 3.466
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
			arg_354_1.auto_ = false
		end

		function arg_354_1.playNext_(arg_356_0)
			arg_354_1.onStoryFinished_()
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action8_1")
			end

			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_357_2 = 0
			local var_357_3 = 0.325

			if var_357_2 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_4 = arg_354_1:FormatText(StoryNameCfg[605].name)

				arg_354_1.leftNameTxt_.text = var_357_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_5 = arg_354_1:GetWordFromCfg(320071085)
				local var_357_6 = arg_354_1:FormatText(var_357_5.content)

				arg_354_1.text_.text = var_357_6

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_7 = 13
				local var_357_8 = utf8.len(var_357_6)
				local var_357_9 = var_357_7 <= 0 and var_357_3 or var_357_3 * (var_357_8 / var_357_7)

				if var_357_9 > 0 and var_357_3 < var_357_9 then
					arg_354_1.talkMaxDuration = var_357_9

					if var_357_9 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_6
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320071", "320071085", "story_v_out_320071.awb") ~= 0 then
					local var_357_10 = manager.audio:GetVoiceLength("story_v_out_320071", "320071085", "story_v_out_320071.awb") / 1000

					if var_357_10 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_2
					end

					if var_357_5.prefab_name ~= "" and arg_354_1.actors_[var_357_5.prefab_name] ~= nil then
						local var_357_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_5.prefab_name].transform, "story_v_out_320071", "320071085", "story_v_out_320071.awb")

						arg_354_1:RecordAudio("320071085", var_357_11)
						arg_354_1:RecordAudio("320071085", var_357_11)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_320071", "320071085", "story_v_out_320071.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_320071", "320071085", "story_v_out_320071.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_12 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_12 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_12

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_12 and arg_354_1.time_ < var_357_2 + var_357_12 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/ST65",
		"TextureConfig/Background/L01g"
	},
	voices = {
		"story_v_out_320071.awb"
	}
}
