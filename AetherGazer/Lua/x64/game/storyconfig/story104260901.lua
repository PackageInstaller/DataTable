return {
	Play426091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play426091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2012"

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
				local var_4_5 = arg_1_1.bgs_.ST2012

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
					if iter_4_0 ~= "ST2012" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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
			local var_4_25 = 0.3

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

			local var_4_30 = 0.133333333333333
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.1

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(426091001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 4
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play426091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 426091002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play426091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.125

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

				local var_11_2 = arg_8_1:GetWordFromCfg(426091002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 45
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
	Play426091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 426091003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play426091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.175

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

				local var_15_3 = arg_12_1:GetWordFromCfg(426091003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 7
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
	Play426091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 426091004
		arg_16_1.duration_ = 6.4

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play426091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "ST2007"

			if arg_16_1.bgs_[var_19_0] == nil then
				local var_19_1 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_0)
				var_19_1.name = var_19_0
				var_19_1.transform.parent = arg_16_1.stage_.transform
				var_19_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_0] = var_19_1
			end

			local var_19_2 = 0.9

			if var_19_2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				local var_19_3 = manager.ui.mainCamera.transform.localPosition
				local var_19_4 = Vector3.New(0, 0, 10) + Vector3.New(var_19_3.x, var_19_3.y, 0)
				local var_19_5 = arg_16_1.bgs_.ST2007

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
					if iter_19_0 ~= "ST2007" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_16 = 1.4

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_17 = 0.3

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_18 = manager.ui.mainCamera.transform
			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				local var_19_20 = arg_16_1.var_.effectqiulingongzhuanchang1
				local var_19_21
				local var_19_22 = var_19_18

				if not var_19_20 then
					var_19_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_19_22)
					var_19_20.name = "qiulingongzhuanchang1"
					arg_16_1.var_.effectqiulingongzhuanchang1 = var_19_20
				else
					var_19_20.transform:SetParent(var_19_22)
				end

				var_19_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_19_20.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_19_23 = 1.7777777777777777
				local var_19_24 = Screen.width / Screen.height
				local var_19_25 = var_19_24 / var_19_23
				local var_19_26 = Mathf.Max(var_19_23 / var_19_24, 1)

				var_19_20.transform.localScale = Vector3.New(var_19_20.transform.localScale.x * var_19_25, var_19_20.transform.localScale.y * var_19_26, var_19_20.transform.localScale.z)
			end

			local var_19_27 = manager.ui.mainCamera.transform
			local var_19_28 = 2.3

			if var_19_28 < arg_16_1.time_ and arg_16_1.time_ <= var_19_28 + arg_19_0 then
				local var_19_29 = arg_16_1.var_.effectqiulingongzhuanchang1

				if var_19_29 then
					Object.Destroy(var_19_29)

					arg_16_1.var_.effectqiulingongzhuanchang1 = nil
				end
			end

			local var_19_30 = 0.6
			local var_19_31 = 0.3

			if var_19_30 < arg_16_1.time_ and arg_16_1.time_ <= var_19_30 + arg_19_0 then
				local var_19_32 = "play"
				local var_19_33 = "music"

				arg_16_1:AudioAction(var_19_32, var_19_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_19_34 = ""
				local var_19_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_19_35 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_35 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_35

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_35
						arg_16_1.bgmTxt2_.text = var_19_35
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_36 = 1.03333333333333
			local var_19_37 = 1

			if var_19_36 < arg_16_1.time_ and arg_16_1.time_ <= var_19_36 + arg_19_0 then
				local var_19_38 = "play"
				local var_19_39 = "music"

				arg_16_1:AudioAction(var_19_38, var_19_39, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_19_40 = ""
				local var_19_41 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_19_41 ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_41 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_41

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_41
						arg_16_1.bgmTxt2_.text = var_19_41
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_42 = 0

			if var_19_42 < arg_16_1.time_ and arg_16_1.time_ <= var_19_42 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_43 = 2.4

			if arg_16_1.time_ >= var_19_42 + var_19_43 and arg_16_1.time_ < var_19_42 + var_19_43 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_44 = 1.4
			local var_19_45 = 1

			if var_19_44 < arg_16_1.time_ and arg_16_1.time_ <= var_19_44 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_46 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_46:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
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

				local var_19_47 = arg_16_1:GetWordFromCfg(426091004)
				local var_19_48 = arg_16_1:FormatText(var_19_47.content)

				arg_16_1.text_.text = var_19_48

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_49 = 40
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
	Play426091005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 426091005
		arg_24_1.duration_ = 7.07

		local var_24_0 = {
			zh = 4.3,
			ja = 7.066
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
				arg_24_0:Play426091006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "6148ui_story"

			if arg_24_1.actors_[var_27_0] == nil then
				local var_27_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_27_1) then
					local var_27_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_24_1.stage_.transform)

					var_27_2.name = var_27_0
					var_27_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_24_1.actors_[var_27_0] = var_27_2

					local var_27_3 = var_27_2:GetComponentInChildren(typeof(CharacterEffect))

					var_27_3.enabled = true

					local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_2, typeof(DynamicBoneHelper))

					if var_27_4 then
						var_27_4:EnableDynamicBone(false)
					end

					arg_24_1:ShowWeapon(var_27_3.transform, false)

					arg_24_1.var_[var_27_0 .. "Animator"] = var_27_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_24_1.var_[var_27_0 .. "Animator"].applyRootMotion = true
					arg_24_1.var_[var_27_0 .. "LipSync"] = var_27_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_27_5 = arg_24_1.actors_["6148ui_story"].transform
			local var_27_6 = 0

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.var_.moveOldPos6148ui_story = var_27_5.localPosition

				local var_27_7 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_7 then
					var_27_7:EnableDynamicBone(false)
				end
			end

			local var_27_8 = 0.001

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_8 then
				local var_27_9 = (arg_24_1.time_ - var_27_6) / var_27_8
				local var_27_10 = Vector3.New(0, -0.985, -6)

				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6148ui_story, var_27_10, var_27_9)

				local var_27_11 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_11.x, var_27_11.y, var_27_11.z)

				local var_27_12 = var_27_5.localEulerAngles

				var_27_12.z = 0
				var_27_12.x = 0
				var_27_5.localEulerAngles = var_27_12
			end

			if arg_24_1.time_ >= var_27_6 + var_27_8 and arg_24_1.time_ < var_27_6 + var_27_8 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_27_13 = manager.ui.mainCamera.transform.position - var_27_5.position

				var_27_5.forward = Vector3.New(var_27_13.x, var_27_13.y, var_27_13.z)

				local var_27_14 = var_27_5.localEulerAngles

				var_27_14.z = 0
				var_27_14.x = 0
				var_27_5.localEulerAngles = var_27_14

				local var_27_15 = GameObjectTools.GetOrAddComponent(var_27_5.gameObject, typeof(DynamicBoneHelper))

				if var_27_15 then
					var_27_15:EnableDynamicBone(true)
				end
			end

			local var_27_16 = arg_24_1.actors_["6148ui_story"]
			local var_27_17 = 0

			if var_27_17 < arg_24_1.time_ and arg_24_1.time_ <= var_27_17 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect6148ui_story == nil then
				arg_24_1.var_.characterEffect6148ui_story = var_27_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_18 = 0.200000002980232

			if var_27_17 <= arg_24_1.time_ and arg_24_1.time_ < var_27_17 + var_27_18 and not isNil(var_27_16) then
				local var_27_19 = (arg_24_1.time_ - var_27_17) / var_27_18

				if arg_24_1.var_.characterEffect6148ui_story and not isNil(var_27_16) then
					arg_24_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_17 + var_27_18 and arg_24_1.time_ < var_27_17 + var_27_18 + arg_27_0 and not isNil(var_27_16) and arg_24_1.var_.characterEffect6148ui_story then
				arg_24_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_27_20 = 0

			if var_27_20 < arg_24_1.time_ and arg_24_1.time_ <= var_27_20 + arg_27_0 then
				arg_24_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_27_22 = 0
			local var_27_23 = 0.375

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_24 = arg_24_1:FormatText(StoryNameCfg[1488].name)

				arg_24_1.leftNameTxt_.text = var_27_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_25 = arg_24_1:GetWordFromCfg(426091005)
				local var_27_26 = arg_24_1:FormatText(var_27_25.content)

				arg_24_1.text_.text = var_27_26

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_27 = 15
				local var_27_28 = utf8.len(var_27_26)
				local var_27_29 = var_27_27 <= 0 and var_27_23 or var_27_23 * (var_27_28 / var_27_27)

				if var_27_29 > 0 and var_27_23 < var_27_29 then
					arg_24_1.talkMaxDuration = var_27_29

					if var_27_29 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_29 + var_27_22
					end
				end

				arg_24_1.text_.text = var_27_26
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091005", "story_v_out_426091.awb") ~= 0 then
					local var_27_30 = manager.audio:GetVoiceLength("story_v_out_426091", "426091005", "story_v_out_426091.awb") / 1000

					if var_27_30 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_30 + var_27_22
					end

					if var_27_25.prefab_name ~= "" and arg_24_1.actors_[var_27_25.prefab_name] ~= nil then
						local var_27_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_25.prefab_name].transform, "story_v_out_426091", "426091005", "story_v_out_426091.awb")

						arg_24_1:RecordAudio("426091005", var_27_31)
						arg_24_1:RecordAudio("426091005", var_27_31)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_426091", "426091005", "story_v_out_426091.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_426091", "426091005", "story_v_out_426091.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_32 = math.max(var_27_23, arg_24_1.talkMaxDuration)

			if var_27_22 <= arg_24_1.time_ and arg_24_1.time_ < var_27_22 + var_27_32 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_22) / var_27_32

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_22 + var_27_32 and arg_24_1.time_ < var_27_22 + var_27_32 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 426091006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play426091007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["6148ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect6148ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_28_1.var_.characterEffect6148ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect6148ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_28_1.var_.characterEffect6148ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.2

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(426091006)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 8
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play426091007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 426091007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play426091008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["6148ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos6148ui_story = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6148ui_story, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = 0
			local var_35_12 = 0.575

			if var_35_11 < arg_32_1.time_ and arg_32_1.time_ <= var_35_11 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_13 = arg_32_1:GetWordFromCfg(426091007)
				local var_35_14 = arg_32_1:FormatText(var_35_13.content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 23
				local var_35_16 = utf8.len(var_35_14)
				local var_35_17 = var_35_15 <= 0 and var_35_12 or var_35_12 * (var_35_16 / var_35_15)

				if var_35_17 > 0 and var_35_12 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_11 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_11
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_18 = math.max(var_35_12, arg_32_1.talkMaxDuration)

			if var_35_11 <= arg_32_1.time_ and arg_32_1.time_ < var_35_11 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_11) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_11 + var_35_18 and arg_32_1.time_ < var_35_11 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 426091008
		arg_36_1.duration_ = 5.2

		local var_36_0 = {
			zh = 4.366,
			ja = 5.2
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
				arg_36_0:Play426091009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["6148ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos6148ui_story = var_39_0.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_3 then
				local var_39_4 = (arg_36_1.time_ - var_39_1) / var_39_3
				local var_39_5 = Vector3.New(0, -0.985, -6)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos6148ui_story, var_39_5, var_39_4)

				local var_39_6 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_6.x, var_39_6.y, var_39_6.z)

				local var_39_7 = var_39_0.localEulerAngles

				var_39_7.z = 0
				var_39_7.x = 0
				var_39_0.localEulerAngles = var_39_7
			end

			if arg_36_1.time_ >= var_39_1 + var_39_3 and arg_36_1.time_ < var_39_1 + var_39_3 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_39_8 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_8.x, var_39_8.y, var_39_8.z)

				local var_39_9 = var_39_0.localEulerAngles

				var_39_9.z = 0
				var_39_9.x = 0
				var_39_0.localEulerAngles = var_39_9

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_0.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["6148ui_story"]
			local var_39_12 = 0

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect6148ui_story == nil then
				arg_36_1.var_.characterEffect6148ui_story = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_13 = 0.200000002980232

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_13 and not isNil(var_39_11) then
				local var_39_14 = (arg_36_1.time_ - var_39_12) / var_39_13

				if arg_36_1.var_.characterEffect6148ui_story and not isNil(var_39_11) then
					arg_36_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_12 + var_39_13 and arg_36_1.time_ < var_39_12 + var_39_13 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect6148ui_story then
				arg_36_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_39_15 = 0

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_39_16 = 0

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_39_17 = 0
			local var_39_18 = 0.375

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_19 = arg_36_1:FormatText(StoryNameCfg[1488].name)

				arg_36_1.leftNameTxt_.text = var_39_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_20 = arg_36_1:GetWordFromCfg(426091008)
				local var_39_21 = arg_36_1:FormatText(var_39_20.content)

				arg_36_1.text_.text = var_39_21

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_22 = 15
				local var_39_23 = utf8.len(var_39_21)
				local var_39_24 = var_39_22 <= 0 and var_39_18 or var_39_18 * (var_39_23 / var_39_22)

				if var_39_24 > 0 and var_39_18 < var_39_24 then
					arg_36_1.talkMaxDuration = var_39_24

					if var_39_24 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_24 + var_39_17
					end
				end

				arg_36_1.text_.text = var_39_21
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091008", "story_v_out_426091.awb") ~= 0 then
					local var_39_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091008", "story_v_out_426091.awb") / 1000

					if var_39_25 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_25 + var_39_17
					end

					if var_39_20.prefab_name ~= "" and arg_36_1.actors_[var_39_20.prefab_name] ~= nil then
						local var_39_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_20.prefab_name].transform, "story_v_out_426091", "426091008", "story_v_out_426091.awb")

						arg_36_1:RecordAudio("426091008", var_39_26)
						arg_36_1:RecordAudio("426091008", var_39_26)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_426091", "426091008", "story_v_out_426091.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_426091", "426091008", "story_v_out_426091.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_27 = math.max(var_39_18, arg_36_1.talkMaxDuration)

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_27 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_17) / var_39_27

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_17 + var_39_27 and arg_36_1.time_ < var_39_17 + var_39_27 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 426091009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play426091010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["6148ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect6148ui_story == nil then
				arg_40_1.var_.characterEffect6148ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect6148ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_40_1.var_.characterEffect6148ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect6148ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_40_1.var_.characterEffect6148ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.4

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(426091009)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 16
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play426091010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 426091010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play426091011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.5

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(426091010)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 20
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
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play426091011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 426091011
		arg_48_1.duration_ = 15.03

		local var_48_0 = {
			zh = 8.2,
			ja = 15.033
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play426091012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["6148ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos6148ui_story = var_51_0.localPosition

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end
			end

			local var_51_3 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_3 then
				local var_51_4 = (arg_48_1.time_ - var_51_1) / var_51_3
				local var_51_5 = Vector3.New(0, -0.985, -6)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6148ui_story, var_51_5, var_51_4)

				local var_51_6 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_6.x, var_51_6.y, var_51_6.z)

				local var_51_7 = var_51_0.localEulerAngles

				var_51_7.z = 0
				var_51_7.x = 0
				var_51_0.localEulerAngles = var_51_7
			end

			if arg_48_1.time_ >= var_51_1 + var_51_3 and arg_48_1.time_ < var_51_1 + var_51_3 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_51_8 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_8.x, var_51_8.y, var_51_8.z)

				local var_51_9 = var_51_0.localEulerAngles

				var_51_9.z = 0
				var_51_9.x = 0
				var_51_0.localEulerAngles = var_51_9

				local var_51_10 = GameObjectTools.GetOrAddComponent(var_51_0.gameObject, typeof(DynamicBoneHelper))

				if var_51_10 then
					var_51_10:EnableDynamicBone(true)
				end
			end

			local var_51_11 = arg_48_1.actors_["6148ui_story"]
			local var_51_12 = 0

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 and not isNil(var_51_11) and arg_48_1.var_.characterEffect6148ui_story == nil then
				arg_48_1.var_.characterEffect6148ui_story = var_51_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_13 = 0.200000002980232

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_13 and not isNil(var_51_11) then
				local var_51_14 = (arg_48_1.time_ - var_51_12) / var_51_13

				if arg_48_1.var_.characterEffect6148ui_story and not isNil(var_51_11) then
					arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_12 + var_51_13 and arg_48_1.time_ < var_51_12 + var_51_13 + arg_51_0 and not isNil(var_51_11) and arg_48_1.var_.characterEffect6148ui_story then
				arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_51_16 = 0
			local var_51_17 = 0.875

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_18 = arg_48_1:FormatText(StoryNameCfg[1488].name)

				arg_48_1.leftNameTxt_.text = var_51_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_19 = arg_48_1:GetWordFromCfg(426091011)
				local var_51_20 = arg_48_1:FormatText(var_51_19.content)

				arg_48_1.text_.text = var_51_20

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_21 = 35
				local var_51_22 = utf8.len(var_51_20)
				local var_51_23 = var_51_21 <= 0 and var_51_17 or var_51_17 * (var_51_22 / var_51_21)

				if var_51_23 > 0 and var_51_17 < var_51_23 then
					arg_48_1.talkMaxDuration = var_51_23

					if var_51_23 + var_51_16 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_16
					end
				end

				arg_48_1.text_.text = var_51_20
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091011", "story_v_out_426091.awb") ~= 0 then
					local var_51_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091011", "story_v_out_426091.awb") / 1000

					if var_51_24 + var_51_16 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_24 + var_51_16
					end

					if var_51_19.prefab_name ~= "" and arg_48_1.actors_[var_51_19.prefab_name] ~= nil then
						local var_51_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_19.prefab_name].transform, "story_v_out_426091", "426091011", "story_v_out_426091.awb")

						arg_48_1:RecordAudio("426091011", var_51_25)
						arg_48_1:RecordAudio("426091011", var_51_25)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_426091", "426091011", "story_v_out_426091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_426091", "426091011", "story_v_out_426091.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_26 = math.max(var_51_17, arg_48_1.talkMaxDuration)

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_26 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_16) / var_51_26

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_16 + var_51_26 and arg_48_1.time_ < var_51_16 + var_51_26 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 426091012
		arg_52_1.duration_ = 11.57

		local var_52_0 = {
			zh = 7.1,
			ja = 11.566
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
				arg_52_0:Play426091013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_55_1 = 0
			local var_55_2 = 0.675

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_3 = arg_52_1:FormatText(StoryNameCfg[1488].name)

				arg_52_1.leftNameTxt_.text = var_55_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(426091012)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 27
				local var_55_7 = utf8.len(var_55_5)
				local var_55_8 = var_55_6 <= 0 and var_55_2 or var_55_2 * (var_55_7 / var_55_6)

				if var_55_8 > 0 and var_55_2 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091012", "story_v_out_426091.awb") ~= 0 then
					local var_55_9 = manager.audio:GetVoiceLength("story_v_out_426091", "426091012", "story_v_out_426091.awb") / 1000

					if var_55_9 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_1
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_426091", "426091012", "story_v_out_426091.awb")

						arg_52_1:RecordAudio("426091012", var_55_10)
						arg_52_1:RecordAudio("426091012", var_55_10)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_426091", "426091012", "story_v_out_426091.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_426091", "426091012", "story_v_out_426091.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_11 and arg_52_1.time_ < var_55_1 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play426091013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 426091013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play426091014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["6148ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect6148ui_story == nil then
				arg_56_1.var_.characterEffect6148ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect6148ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_56_1.var_.characterEffect6148ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect6148ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_56_1.var_.characterEffect6148ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.75

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

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(426091013)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 30
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
	Play426091014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 426091014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play426091015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.8

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

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(426091014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 32
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
	Play426091015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 426091015
		arg_64_1.duration_ = 8.3

		local var_64_0 = {
			zh = 7.4,
			ja = 8.3
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
				arg_64_0:Play426091016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["6148ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos6148ui_story = var_67_0.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_3 then
				local var_67_4 = (arg_64_1.time_ - var_67_1) / var_67_3
				local var_67_5 = Vector3.New(0, -0.985, -6)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos6148ui_story, var_67_5, var_67_4)

				local var_67_6 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_6.x, var_67_6.y, var_67_6.z)

				local var_67_7 = var_67_0.localEulerAngles

				var_67_7.z = 0
				var_67_7.x = 0
				var_67_0.localEulerAngles = var_67_7
			end

			if arg_64_1.time_ >= var_67_1 + var_67_3 and arg_64_1.time_ < var_67_1 + var_67_3 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_67_8 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_8.x, var_67_8.y, var_67_8.z)

				local var_67_9 = var_67_0.localEulerAngles

				var_67_9.z = 0
				var_67_9.x = 0
				var_67_0.localEulerAngles = var_67_9

				local var_67_10 = GameObjectTools.GetOrAddComponent(var_67_0.gameObject, typeof(DynamicBoneHelper))

				if var_67_10 then
					var_67_10:EnableDynamicBone(true)
				end
			end

			local var_67_11 = arg_64_1.actors_["6148ui_story"]
			local var_67_12 = 0

			if var_67_12 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 and not isNil(var_67_11) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_13 = 0.200000002980232

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_13 and not isNil(var_67_11) then
				local var_67_14 = (arg_64_1.time_ - var_67_12) / var_67_13

				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_11) then
					arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_12 + var_67_13 and arg_64_1.time_ < var_67_12 + var_67_13 + arg_67_0 and not isNil(var_67_11) and arg_64_1.var_.characterEffect6148ui_story then
				arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_67_15 = 0

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action442")
			end

			local var_67_16 = 0

			if var_67_16 < arg_64_1.time_ and arg_64_1.time_ <= var_67_16 + arg_67_0 then
				arg_64_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_67_17 = 0
			local var_67_18 = 0.55

			if var_67_17 < arg_64_1.time_ and arg_64_1.time_ <= var_67_17 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_19 = arg_64_1:FormatText(StoryNameCfg[1488].name)

				arg_64_1.leftNameTxt_.text = var_67_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_20 = arg_64_1:GetWordFromCfg(426091015)
				local var_67_21 = arg_64_1:FormatText(var_67_20.content)

				arg_64_1.text_.text = var_67_21

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_22 = 22
				local var_67_23 = utf8.len(var_67_21)
				local var_67_24 = var_67_22 <= 0 and var_67_18 or var_67_18 * (var_67_23 / var_67_22)

				if var_67_24 > 0 and var_67_18 < var_67_24 then
					arg_64_1.talkMaxDuration = var_67_24

					if var_67_24 + var_67_17 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_17
					end
				end

				arg_64_1.text_.text = var_67_21
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091015", "story_v_out_426091.awb") ~= 0 then
					local var_67_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091015", "story_v_out_426091.awb") / 1000

					if var_67_25 + var_67_17 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_25 + var_67_17
					end

					if var_67_20.prefab_name ~= "" and arg_64_1.actors_[var_67_20.prefab_name] ~= nil then
						local var_67_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_20.prefab_name].transform, "story_v_out_426091", "426091015", "story_v_out_426091.awb")

						arg_64_1:RecordAudio("426091015", var_67_26)
						arg_64_1:RecordAudio("426091015", var_67_26)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_426091", "426091015", "story_v_out_426091.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_426091", "426091015", "story_v_out_426091.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_27 = math.max(var_67_18, arg_64_1.talkMaxDuration)

			if var_67_17 <= arg_64_1.time_ and arg_64_1.time_ < var_67_17 + var_67_27 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_17) / var_67_27

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_17 + var_67_27 and arg_64_1.time_ < var_67_17 + var_67_27 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 426091016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play426091017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["6148ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect6148ui_story == nil then
				arg_68_1.var_.characterEffect6148ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect6148ui_story and not isNil(var_71_0) then
					local var_71_4 = Mathf.Lerp(0, 0.5, var_71_3)

					arg_68_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_68_1.var_.characterEffect6148ui_story.fillRatio = var_71_4
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect6148ui_story then
				local var_71_5 = 0.5

				arg_68_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_68_1.var_.characterEffect6148ui_story.fillRatio = var_71_5
			end

			local var_71_6 = 0
			local var_71_7 = 0.1

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

				local var_71_9 = arg_68_1:GetWordFromCfg(426091016)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 4
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
	Play426091017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 426091017
		arg_72_1.duration_ = 12.1

		local var_72_0 = {
			zh = 8.3,
			ja = 12.1
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
				arg_72_0:Play426091018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["6148ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos6148ui_story = var_75_0.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_3 then
				local var_75_4 = (arg_72_1.time_ - var_75_1) / var_75_3
				local var_75_5 = Vector3.New(0, -0.985, -6)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos6148ui_story, var_75_5, var_75_4)

				local var_75_6 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_6.x, var_75_6.y, var_75_6.z)

				local var_75_7 = var_75_0.localEulerAngles

				var_75_7.z = 0
				var_75_7.x = 0
				var_75_0.localEulerAngles = var_75_7
			end

			if arg_72_1.time_ >= var_75_1 + var_75_3 and arg_72_1.time_ < var_75_1 + var_75_3 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_75_8 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_8.x, var_75_8.y, var_75_8.z)

				local var_75_9 = var_75_0.localEulerAngles

				var_75_9.z = 0
				var_75_9.x = 0
				var_75_0.localEulerAngles = var_75_9

				local var_75_10 = GameObjectTools.GetOrAddComponent(var_75_0.gameObject, typeof(DynamicBoneHelper))

				if var_75_10 then
					var_75_10:EnableDynamicBone(true)
				end
			end

			local var_75_11 = arg_72_1.actors_["6148ui_story"]
			local var_75_12 = 0

			if var_75_12 < arg_72_1.time_ and arg_72_1.time_ <= var_75_12 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.characterEffect6148ui_story == nil then
				arg_72_1.var_.characterEffect6148ui_story = var_75_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_13 = 0.200000002980232

			if var_75_12 <= arg_72_1.time_ and arg_72_1.time_ < var_75_12 + var_75_13 and not isNil(var_75_11) then
				local var_75_14 = (arg_72_1.time_ - var_75_12) / var_75_13

				if arg_72_1.var_.characterEffect6148ui_story and not isNil(var_75_11) then
					arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_12 + var_75_13 and arg_72_1.time_ < var_75_12 + var_75_13 + arg_75_0 and not isNil(var_75_11) and arg_72_1.var_.characterEffect6148ui_story then
				arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_75_15 = 0

			if var_75_15 < arg_72_1.time_ and arg_72_1.time_ <= var_75_15 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action424")
			end

			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_75_17 = 0
			local var_75_18 = 0.8

			if var_75_17 < arg_72_1.time_ and arg_72_1.time_ <= var_75_17 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_19 = arg_72_1:FormatText(StoryNameCfg[1488].name)

				arg_72_1.leftNameTxt_.text = var_75_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_20 = arg_72_1:GetWordFromCfg(426091017)
				local var_75_21 = arg_72_1:FormatText(var_75_20.content)

				arg_72_1.text_.text = var_75_21

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_22 = 32
				local var_75_23 = utf8.len(var_75_21)
				local var_75_24 = var_75_22 <= 0 and var_75_18 or var_75_18 * (var_75_23 / var_75_22)

				if var_75_24 > 0 and var_75_18 < var_75_24 then
					arg_72_1.talkMaxDuration = var_75_24

					if var_75_24 + var_75_17 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_24 + var_75_17
					end
				end

				arg_72_1.text_.text = var_75_21
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091017", "story_v_out_426091.awb") ~= 0 then
					local var_75_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091017", "story_v_out_426091.awb") / 1000

					if var_75_25 + var_75_17 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_25 + var_75_17
					end

					if var_75_20.prefab_name ~= "" and arg_72_1.actors_[var_75_20.prefab_name] ~= nil then
						local var_75_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_20.prefab_name].transform, "story_v_out_426091", "426091017", "story_v_out_426091.awb")

						arg_72_1:RecordAudio("426091017", var_75_26)
						arg_72_1:RecordAudio("426091017", var_75_26)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_426091", "426091017", "story_v_out_426091.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_426091", "426091017", "story_v_out_426091.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_27 = math.max(var_75_18, arg_72_1.talkMaxDuration)

			if var_75_17 <= arg_72_1.time_ and arg_72_1.time_ < var_75_17 + var_75_27 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_17) / var_75_27

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_17 + var_75_27 and arg_72_1.time_ < var_75_17 + var_75_27 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play426091018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 426091018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play426091019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["6148ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect6148ui_story == nil then
				arg_76_1.var_.characterEffect6148ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect6148ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_76_1.var_.characterEffect6148ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect6148ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_76_1.var_.characterEffect6148ui_story.fillRatio = var_79_5
			end

			local var_79_6 = 0
			local var_79_7 = 0.85

			if var_79_6 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_8 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_9 = arg_76_1:GetWordFromCfg(426091018)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 34
				local var_79_12 = utf8.len(var_79_10)
				local var_79_13 = var_79_11 <= 0 and var_79_7 or var_79_7 * (var_79_12 / var_79_11)

				if var_79_13 > 0 and var_79_7 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play426091019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 426091019
		arg_80_1.duration_ = 9

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play426091020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 2

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				local var_83_1 = manager.ui.mainCamera.transform.localPosition
				local var_83_2 = Vector3.New(0, 0, 10) + Vector3.New(var_83_1.x, var_83_1.y, 0)
				local var_83_3 = arg_80_1.bgs_.ST2012

				var_83_3.transform.localPosition = var_83_2
				var_83_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_4 = var_83_3:GetComponent("SpriteRenderer")

				if var_83_4 and var_83_4.sprite then
					local var_83_5 = (var_83_3.transform.localPosition - var_83_1).z
					local var_83_6 = manager.ui.mainCameraCom_
					local var_83_7 = 2 * var_83_5 * Mathf.Tan(var_83_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_83_8 = var_83_7 * var_83_6.aspect
					local var_83_9 = var_83_4.sprite.bounds.size.x
					local var_83_10 = var_83_4.sprite.bounds.size.y
					local var_83_11 = var_83_8 / var_83_9
					local var_83_12 = var_83_7 / var_83_10
					local var_83_13 = var_83_12 < var_83_11 and var_83_11 or var_83_12

					var_83_3.transform.localScale = Vector3.New(var_83_13, var_83_13, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "ST2012" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_14 = 3.999999999999

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			local var_83_15 = 0.3

			if arg_80_1.time_ >= var_83_14 + var_83_15 and arg_80_1.time_ < var_83_14 + var_83_15 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_16 = 0

			if var_83_16 < arg_80_1.time_ and arg_80_1.time_ <= var_83_16 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_17 = 2

			if var_83_16 <= arg_80_1.time_ and arg_80_1.time_ < var_83_16 + var_83_17 then
				local var_83_18 = (arg_80_1.time_ - var_83_16) / var_83_17
				local var_83_19 = Color.New(0, 0, 0)

				var_83_19.a = Mathf.Lerp(0, 1, var_83_18)
				arg_80_1.mask_.color = var_83_19
			end

			if arg_80_1.time_ >= var_83_16 + var_83_17 and arg_80_1.time_ < var_83_16 + var_83_17 + arg_83_0 then
				local var_83_20 = Color.New(0, 0, 0)

				var_83_20.a = 1
				arg_80_1.mask_.color = var_83_20
			end

			local var_83_21 = 2

			if var_83_21 < arg_80_1.time_ and arg_80_1.time_ <= var_83_21 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_22 = 2

			if var_83_21 <= arg_80_1.time_ and arg_80_1.time_ < var_83_21 + var_83_22 then
				local var_83_23 = (arg_80_1.time_ - var_83_21) / var_83_22
				local var_83_24 = Color.New(0, 0, 0)

				var_83_24.a = Mathf.Lerp(1, 0, var_83_23)
				arg_80_1.mask_.color = var_83_24
			end

			if arg_80_1.time_ >= var_83_21 + var_83_22 and arg_80_1.time_ < var_83_21 + var_83_22 + arg_83_0 then
				local var_83_25 = Color.New(0, 0, 0)
				local var_83_26 = 0

				arg_80_1.mask_.enabled = false
				var_83_25.a = var_83_26
				arg_80_1.mask_.color = var_83_25
			end

			local var_83_27 = arg_80_1.actors_["6148ui_story"].transform
			local var_83_28 = 1.96599999815226

			if var_83_28 < arg_80_1.time_ and arg_80_1.time_ <= var_83_28 + arg_83_0 then
				arg_80_1.var_.moveOldPos6148ui_story = var_83_27.localPosition

				local var_83_29 = GameObjectTools.GetOrAddComponent(var_83_27.gameObject, typeof(DynamicBoneHelper))

				if var_83_29 then
					var_83_29:EnableDynamicBone(false)
				end
			end

			local var_83_30 = 0.001

			if var_83_28 <= arg_80_1.time_ and arg_80_1.time_ < var_83_28 + var_83_30 then
				local var_83_31 = (arg_80_1.time_ - var_83_28) / var_83_30
				local var_83_32 = Vector3.New(0, 100, 0)

				var_83_27.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos6148ui_story, var_83_32, var_83_31)

				local var_83_33 = manager.ui.mainCamera.transform.position - var_83_27.position

				var_83_27.forward = Vector3.New(var_83_33.x, var_83_33.y, var_83_33.z)

				local var_83_34 = var_83_27.localEulerAngles

				var_83_34.z = 0
				var_83_34.x = 0
				var_83_27.localEulerAngles = var_83_34
			end

			if arg_80_1.time_ >= var_83_28 + var_83_30 and arg_80_1.time_ < var_83_28 + var_83_30 + arg_83_0 then
				var_83_27.localPosition = Vector3.New(0, 100, 0)

				local var_83_35 = manager.ui.mainCamera.transform.position - var_83_27.position

				var_83_27.forward = Vector3.New(var_83_35.x, var_83_35.y, var_83_35.z)

				local var_83_36 = var_83_27.localEulerAngles

				var_83_36.z = 0
				var_83_36.x = 0
				var_83_27.localEulerAngles = var_83_36

				local var_83_37 = GameObjectTools.GetOrAddComponent(var_83_27.gameObject, typeof(DynamicBoneHelper))

				if var_83_37 then
					var_83_37:EnableDynamicBone(true)
				end
			end

			local var_83_38 = 2.63333333333333
			local var_83_39 = 1

			if var_83_38 < arg_80_1.time_ and arg_80_1.time_ <= var_83_38 + arg_83_0 then
				local var_83_40 = "play"
				local var_83_41 = "effect"

				arg_80_1:AudioAction(var_83_40, var_83_41, "se_story_10", "se_story_10_fall", "")
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_42 = 3.999999999999
			local var_83_43 = 0.925

			if var_83_42 < arg_80_1.time_ and arg_80_1.time_ <= var_83_42 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_44 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_44:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_45 = arg_80_1:GetWordFromCfg(426091019)
				local var_83_46 = arg_80_1:FormatText(var_83_45.content)

				arg_80_1.text_.text = var_83_46

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_47 = 37
				local var_83_48 = utf8.len(var_83_46)
				local var_83_49 = var_83_47 <= 0 and var_83_43 or var_83_43 * (var_83_48 / var_83_47)

				if var_83_49 > 0 and var_83_43 < var_83_49 then
					arg_80_1.talkMaxDuration = var_83_49
					var_83_42 = var_83_42 + 0.3

					if var_83_49 + var_83_42 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_49 + var_83_42
					end
				end

				arg_80_1.text_.text = var_83_46
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_50 = var_83_42 + 0.3
			local var_83_51 = math.max(var_83_43, arg_80_1.talkMaxDuration)

			if var_83_50 <= arg_80_1.time_ and arg_80_1.time_ < var_83_50 + var_83_51 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_50) / var_83_51

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_50 + var_83_51 and arg_80_1.time_ < var_83_50 + var_83_51 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play426091020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 426091020
		arg_86_1.duration_ = 2

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play426091021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["6148ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos6148ui_story = var_89_0.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_3 then
				local var_89_4 = (arg_86_1.time_ - var_89_1) / var_89_3
				local var_89_5 = Vector3.New(0, -0.985, -6)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6148ui_story, var_89_5, var_89_4)

				local var_89_6 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_6.x, var_89_6.y, var_89_6.z)

				local var_89_7 = var_89_0.localEulerAngles

				var_89_7.z = 0
				var_89_7.x = 0
				var_89_0.localEulerAngles = var_89_7
			end

			if arg_86_1.time_ >= var_89_1 + var_89_3 and arg_86_1.time_ < var_89_1 + var_89_3 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_89_8 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_8.x, var_89_8.y, var_89_8.z)

				local var_89_9 = var_89_0.localEulerAngles

				var_89_9.z = 0
				var_89_9.x = 0
				var_89_0.localEulerAngles = var_89_9

				local var_89_10 = GameObjectTools.GetOrAddComponent(var_89_0.gameObject, typeof(DynamicBoneHelper))

				if var_89_10 then
					var_89_10:EnableDynamicBone(true)
				end
			end

			local var_89_11 = arg_86_1.actors_["6148ui_story"]
			local var_89_12 = 0

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect6148ui_story == nil then
				arg_86_1.var_.characterEffect6148ui_story = var_89_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_13 = 0.200000002980232

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_13 and not isNil(var_89_11) then
				local var_89_14 = (arg_86_1.time_ - var_89_12) / var_89_13

				if arg_86_1.var_.characterEffect6148ui_story and not isNil(var_89_11) then
					arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_12 + var_89_13 and arg_86_1.time_ < var_89_12 + var_89_13 + arg_89_0 and not isNil(var_89_11) and arg_86_1.var_.characterEffect6148ui_story then
				arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_89_15 = 0

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_89_16 = 0

			if var_89_16 < arg_86_1.time_ and arg_86_1.time_ <= var_89_16 + arg_89_0 then
				arg_86_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_89_17 = 0
			local var_89_18 = 0.075

			if var_89_17 < arg_86_1.time_ and arg_86_1.time_ <= var_89_17 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_19 = arg_86_1:FormatText(StoryNameCfg[1488].name)

				arg_86_1.leftNameTxt_.text = var_89_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_20 = arg_86_1:GetWordFromCfg(426091020)
				local var_89_21 = arg_86_1:FormatText(var_89_20.content)

				arg_86_1.text_.text = var_89_21

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_22 = 3
				local var_89_23 = utf8.len(var_89_21)
				local var_89_24 = var_89_22 <= 0 and var_89_18 or var_89_18 * (var_89_23 / var_89_22)

				if var_89_24 > 0 and var_89_18 < var_89_24 then
					arg_86_1.talkMaxDuration = var_89_24

					if var_89_24 + var_89_17 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_24 + var_89_17
					end
				end

				arg_86_1.text_.text = var_89_21
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091020", "story_v_out_426091.awb") ~= 0 then
					local var_89_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091020", "story_v_out_426091.awb") / 1000

					if var_89_25 + var_89_17 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_25 + var_89_17
					end

					if var_89_20.prefab_name ~= "" and arg_86_1.actors_[var_89_20.prefab_name] ~= nil then
						local var_89_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_20.prefab_name].transform, "story_v_out_426091", "426091020", "story_v_out_426091.awb")

						arg_86_1:RecordAudio("426091020", var_89_26)
						arg_86_1:RecordAudio("426091020", var_89_26)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_426091", "426091020", "story_v_out_426091.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_426091", "426091020", "story_v_out_426091.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_27 = math.max(var_89_18, arg_86_1.talkMaxDuration)

			if var_89_17 <= arg_86_1.time_ and arg_86_1.time_ < var_89_17 + var_89_27 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_17) / var_89_27

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_17 + var_89_27 and arg_86_1.time_ < var_89_17 + var_89_27 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play426091021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 426091021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play426091022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["6148ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect6148ui_story == nil then
				arg_90_1.var_.characterEffect6148ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect6148ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_90_1.var_.characterEffect6148ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect6148ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_90_1.var_.characterEffect6148ui_story.fillRatio = var_93_5
			end

			local var_93_6 = 0
			local var_93_7 = 0.225

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_9 = arg_90_1:GetWordFromCfg(426091021)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 9
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play426091022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 426091022
		arg_94_1.duration_ = 6.8

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play426091023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.8

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				local var_97_1 = manager.ui.mainCamera.transform.localPosition
				local var_97_2 = Vector3.New(0, 0, 10) + Vector3.New(var_97_1.x, var_97_1.y, 0)
				local var_97_3 = arg_94_1.bgs_.ST2012

				var_97_3.transform.localPosition = var_97_2
				var_97_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_4 = var_97_3:GetComponent("SpriteRenderer")

				if var_97_4 and var_97_4.sprite then
					local var_97_5 = (var_97_3.transform.localPosition - var_97_1).z
					local var_97_6 = manager.ui.mainCameraCom_
					local var_97_7 = 2 * var_97_5 * Mathf.Tan(var_97_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_97_8 = var_97_7 * var_97_6.aspect
					local var_97_9 = var_97_4.sprite.bounds.size.x
					local var_97_10 = var_97_4.sprite.bounds.size.y
					local var_97_11 = var_97_8 / var_97_9
					local var_97_12 = var_97_7 / var_97_10
					local var_97_13 = var_97_12 < var_97_11 and var_97_11 or var_97_12

					var_97_3.transform.localScale = Vector3.New(var_97_13, var_97_13, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "ST2012" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_14 = 1.5

			if var_97_14 < arg_94_1.time_ and arg_94_1.time_ <= var_97_14 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			local var_97_15 = 0.3

			if arg_94_1.time_ >= var_97_14 + var_97_15 and arg_94_1.time_ < var_97_14 + var_97_15 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			local var_97_16 = manager.ui.mainCamera.transform
			local var_97_17 = 0

			if var_97_17 < arg_94_1.time_ and arg_94_1.time_ <= var_97_17 + arg_97_0 then
				local var_97_18 = arg_94_1.var_.effecttaoli1123123
				local var_97_19
				local var_97_20 = var_97_16

				if not var_97_18 then
					var_97_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), var_97_20)
					var_97_18.name = "taoli1123123"
					arg_94_1.var_.effecttaoli1123123 = var_97_18
				else
					var_97_18.transform:SetParent(var_97_20)
				end

				var_97_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_97_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_97_21 = 1.7777777777777777
				local var_97_22 = Screen.width / Screen.height
				local var_97_23 = var_97_22 / var_97_21
				local var_97_24 = Mathf.Max(var_97_21 / var_97_22, 1)

				var_97_18.transform.localScale = Vector3.New(var_97_18.transform.localScale.x * var_97_23, var_97_18.transform.localScale.y * var_97_24, var_97_18.transform.localScale.z)
			end

			local var_97_25 = manager.ui.mainCamera.transform
			local var_97_26 = 1.5

			if var_97_26 < arg_94_1.time_ and arg_94_1.time_ <= var_97_26 + arg_97_0 then
				local var_97_27 = arg_94_1.var_.effecttaoli1123123

				if var_97_27 then
					Object.Destroy(var_97_27)

					arg_94_1.var_.effecttaoli1123123 = nil
				end
			end

			local var_97_28 = arg_94_1.actors_["6148ui_story"].transform
			local var_97_29 = 0

			if var_97_29 < arg_94_1.time_ and arg_94_1.time_ <= var_97_29 + arg_97_0 then
				arg_94_1.var_.moveOldPos6148ui_story = var_97_28.localPosition

				local var_97_30 = GameObjectTools.GetOrAddComponent(var_97_28.gameObject, typeof(DynamicBoneHelper))

				if var_97_30 then
					var_97_30:EnableDynamicBone(false)
				end
			end

			local var_97_31 = 0.001

			if var_97_29 <= arg_94_1.time_ and arg_94_1.time_ < var_97_29 + var_97_31 then
				local var_97_32 = (arg_94_1.time_ - var_97_29) / var_97_31
				local var_97_33 = Vector3.New(0, 100, 0)

				var_97_28.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos6148ui_story, var_97_33, var_97_32)

				local var_97_34 = manager.ui.mainCamera.transform.position - var_97_28.position

				var_97_28.forward = Vector3.New(var_97_34.x, var_97_34.y, var_97_34.z)

				local var_97_35 = var_97_28.localEulerAngles

				var_97_35.z = 0
				var_97_35.x = 0
				var_97_28.localEulerAngles = var_97_35
			end

			if arg_94_1.time_ >= var_97_29 + var_97_31 and arg_94_1.time_ < var_97_29 + var_97_31 + arg_97_0 then
				var_97_28.localPosition = Vector3.New(0, 100, 0)

				local var_97_36 = manager.ui.mainCamera.transform.position - var_97_28.position

				var_97_28.forward = Vector3.New(var_97_36.x, var_97_36.y, var_97_36.z)

				local var_97_37 = var_97_28.localEulerAngles

				var_97_37.z = 0
				var_97_37.x = 0
				var_97_28.localEulerAngles = var_97_37

				local var_97_38 = GameObjectTools.GetOrAddComponent(var_97_28.gameObject, typeof(DynamicBoneHelper))

				if var_97_38 then
					var_97_38:EnableDynamicBone(true)
				end
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_39 = 1.8
			local var_97_40 = 1.175

			if var_97_39 < arg_94_1.time_ and arg_94_1.time_ <= var_97_39 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_41 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_41:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_42 = arg_94_1:GetWordFromCfg(426091022)
				local var_97_43 = arg_94_1:FormatText(var_97_42.content)

				arg_94_1.text_.text = var_97_43

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_44 = 47
				local var_97_45 = utf8.len(var_97_43)
				local var_97_46 = var_97_44 <= 0 and var_97_40 or var_97_40 * (var_97_45 / var_97_44)

				if var_97_46 > 0 and var_97_40 < var_97_46 then
					arg_94_1.talkMaxDuration = var_97_46
					var_97_39 = var_97_39 + 0.3

					if var_97_46 + var_97_39 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_46 + var_97_39
					end
				end

				arg_94_1.text_.text = var_97_43
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_47 = var_97_39 + 0.3
			local var_97_48 = math.max(var_97_40, arg_94_1.talkMaxDuration)

			if var_97_47 <= arg_94_1.time_ and arg_94_1.time_ < var_97_47 + var_97_48 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_47) / var_97_48

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_47 + var_97_48 and arg_94_1.time_ < var_97_47 + var_97_48 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play426091023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 426091023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play426091024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.175

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_2

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

				local var_103_3 = arg_100_1:GetWordFromCfg(426091023)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 7
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play426091024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 426091024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play426091025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.825

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_2 = arg_104_1:GetWordFromCfg(426091024)
				local var_107_3 = arg_104_1:FormatText(var_107_2.content)

				arg_104_1.text_.text = var_107_3

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 33
				local var_107_5 = utf8.len(var_107_3)
				local var_107_6 = var_107_4 <= 0 and var_107_1 or var_107_1 * (var_107_5 / var_107_4)

				if var_107_6 > 0 and var_107_1 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_3
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_7 and arg_104_1.time_ < var_107_0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play426091025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 426091025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play426091026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.125

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(426091025)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 5
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
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play426091026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 426091026
		arg_112_1.duration_ = 3.5

		local var_112_0 = {
			zh = 3.5,
			ja = 1.999999999999
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
				arg_112_0:Play426091027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = "1054ui_story"

			if arg_112_1.actors_[var_115_0] == nil then
				local var_115_1 = Asset.Load("Char/" .. "1054ui_story")

				if not isNil(var_115_1) then
					local var_115_2 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_112_1.stage_.transform)

					var_115_2.name = var_115_0
					var_115_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_112_1.actors_[var_115_0] = var_115_2

					local var_115_3 = var_115_2:GetComponentInChildren(typeof(CharacterEffect))

					var_115_3.enabled = true

					local var_115_4 = GameObjectTools.GetOrAddComponent(var_115_2, typeof(DynamicBoneHelper))

					if var_115_4 then
						var_115_4:EnableDynamicBone(false)
					end

					arg_112_1:ShowWeapon(var_115_3.transform, false)

					arg_112_1.var_[var_115_0 .. "Animator"] = var_115_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_112_1.var_[var_115_0 .. "Animator"].applyRootMotion = true
					arg_112_1.var_[var_115_0 .. "LipSync"] = var_115_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_115_5 = arg_112_1.actors_["1054ui_story"].transform
			local var_115_6 = 0

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.var_.moveOldPos1054ui_story = var_115_5.localPosition

				local var_115_7 = GameObjectTools.GetOrAddComponent(var_115_5.gameObject, typeof(DynamicBoneHelper))

				if var_115_7 then
					var_115_7:EnableDynamicBone(false)
				end
			end

			local var_115_8 = 0.001

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_8 then
				local var_115_9 = (arg_112_1.time_ - var_115_6) / var_115_8
				local var_115_10 = Vector3.New(0, -0.985, -6)

				var_115_5.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1054ui_story, var_115_10, var_115_9)

				local var_115_11 = manager.ui.mainCamera.transform.position - var_115_5.position

				var_115_5.forward = Vector3.New(var_115_11.x, var_115_11.y, var_115_11.z)

				local var_115_12 = var_115_5.localEulerAngles

				var_115_12.z = 0
				var_115_12.x = 0
				var_115_5.localEulerAngles = var_115_12
			end

			if arg_112_1.time_ >= var_115_6 + var_115_8 and arg_112_1.time_ < var_115_6 + var_115_8 + arg_115_0 then
				var_115_5.localPosition = Vector3.New(0, -0.985, -6)

				local var_115_13 = manager.ui.mainCamera.transform.position - var_115_5.position

				var_115_5.forward = Vector3.New(var_115_13.x, var_115_13.y, var_115_13.z)

				local var_115_14 = var_115_5.localEulerAngles

				var_115_14.z = 0
				var_115_14.x = 0
				var_115_5.localEulerAngles = var_115_14

				local var_115_15 = GameObjectTools.GetOrAddComponent(var_115_5.gameObject, typeof(DynamicBoneHelper))

				if var_115_15 then
					var_115_15:EnableDynamicBone(true)
				end
			end

			local var_115_16 = arg_112_1.actors_["1054ui_story"]
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 and not isNil(var_115_16) and arg_112_1.var_.characterEffect1054ui_story == nil then
				arg_112_1.var_.characterEffect1054ui_story = var_115_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_18 = 0.200000002980232

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_18 and not isNil(var_115_16) then
				local var_115_19 = (arg_112_1.time_ - var_115_17) / var_115_18

				if arg_112_1.var_.characterEffect1054ui_story and not isNil(var_115_16) then
					arg_112_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_17 + var_115_18 and arg_112_1.time_ < var_115_17 + var_115_18 + arg_115_0 and not isNil(var_115_16) and arg_112_1.var_.characterEffect1054ui_story then
				arg_112_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_115_20 = 0

			if var_115_20 < arg_112_1.time_ and arg_112_1.time_ <= var_115_20 + arg_115_0 then
				arg_112_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_115_21 = 0

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_115_22 = 0
			local var_115_23 = 0.175

			if var_115_22 < arg_112_1.time_ and arg_112_1.time_ <= var_115_22 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_24 = arg_112_1:FormatText(StoryNameCfg[1487].name)

				arg_112_1.leftNameTxt_.text = var_115_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_25 = arg_112_1:GetWordFromCfg(426091026)
				local var_115_26 = arg_112_1:FormatText(var_115_25.content)

				arg_112_1.text_.text = var_115_26

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_27 = 7
				local var_115_28 = utf8.len(var_115_26)
				local var_115_29 = var_115_27 <= 0 and var_115_23 or var_115_23 * (var_115_28 / var_115_27)

				if var_115_29 > 0 and var_115_23 < var_115_29 then
					arg_112_1.talkMaxDuration = var_115_29

					if var_115_29 + var_115_22 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_29 + var_115_22
					end
				end

				arg_112_1.text_.text = var_115_26
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091026", "story_v_out_426091.awb") ~= 0 then
					local var_115_30 = manager.audio:GetVoiceLength("story_v_out_426091", "426091026", "story_v_out_426091.awb") / 1000

					if var_115_30 + var_115_22 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_30 + var_115_22
					end

					if var_115_25.prefab_name ~= "" and arg_112_1.actors_[var_115_25.prefab_name] ~= nil then
						local var_115_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_25.prefab_name].transform, "story_v_out_426091", "426091026", "story_v_out_426091.awb")

						arg_112_1:RecordAudio("426091026", var_115_31)
						arg_112_1:RecordAudio("426091026", var_115_31)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_426091", "426091026", "story_v_out_426091.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_426091", "426091026", "story_v_out_426091.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_32 = math.max(var_115_23, arg_112_1.talkMaxDuration)

			if var_115_22 <= arg_112_1.time_ and arg_112_1.time_ < var_115_22 + var_115_32 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_22) / var_115_32

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_22 + var_115_32 and arg_112_1.time_ < var_115_22 + var_115_32 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 426091027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play426091028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1054ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1054ui_story = var_119_0.localPosition

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end
			end

			local var_119_3 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_3 then
				local var_119_4 = (arg_116_1.time_ - var_119_1) / var_119_3
				local var_119_5 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1054ui_story, var_119_5, var_119_4)

				local var_119_6 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_6.x, var_119_6.y, var_119_6.z)

				local var_119_7 = var_119_0.localEulerAngles

				var_119_7.z = 0
				var_119_7.x = 0
				var_119_0.localEulerAngles = var_119_7
			end

			if arg_116_1.time_ >= var_119_1 + var_119_3 and arg_116_1.time_ < var_119_1 + var_119_3 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

				local var_119_8 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_8.x, var_119_8.y, var_119_8.z)

				local var_119_9 = var_119_0.localEulerAngles

				var_119_9.z = 0
				var_119_9.x = 0
				var_119_0.localEulerAngles = var_119_9

				local var_119_10 = GameObjectTools.GetOrAddComponent(var_119_0.gameObject, typeof(DynamicBoneHelper))

				if var_119_10 then
					var_119_10:EnableDynamicBone(true)
				end
			end

			local var_119_11 = arg_116_1.actors_["1054ui_story"]
			local var_119_12 = 0

			if var_119_12 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 and not isNil(var_119_11) and arg_116_1.var_.characterEffect1054ui_story == nil then
				arg_116_1.var_.characterEffect1054ui_story = var_119_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_13 = 0.200000002980232

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_13 and not isNil(var_119_11) then
				local var_119_14 = (arg_116_1.time_ - var_119_12) / var_119_13

				if arg_116_1.var_.characterEffect1054ui_story and not isNil(var_119_11) then
					local var_119_15 = Mathf.Lerp(0, 0.5, var_119_14)

					arg_116_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1054ui_story.fillRatio = var_119_15
				end
			end

			if arg_116_1.time_ >= var_119_12 + var_119_13 and arg_116_1.time_ < var_119_12 + var_119_13 + arg_119_0 and not isNil(var_119_11) and arg_116_1.var_.characterEffect1054ui_story then
				local var_119_16 = 0.5

				arg_116_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1054ui_story.fillRatio = var_119_16
			end

			local var_119_17 = 0.200000002980232
			local var_119_18 = 1

			if var_119_17 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				local var_119_19 = "play"
				local var_119_20 = "effect"

				arg_116_1:AudioAction(var_119_19, var_119_20, "se_story_141", "se_story_141_xuanji03", "")
			end

			local var_119_21 = manager.ui.mainCamera.transform
			local var_119_22 = 0.200000002980232

			if var_119_22 < arg_116_1.time_ and arg_116_1.time_ <= var_119_22 + arg_119_0 then
				arg_116_1.var_.shakeOldPos = var_119_21.localPosition
			end

			local var_119_23 = 0.3

			if var_119_22 <= arg_116_1.time_ and arg_116_1.time_ < var_119_22 + var_119_23 then
				local var_119_24 = (arg_116_1.time_ - var_119_22) / 0.066
				local var_119_25, var_119_26 = math.modf(var_119_24)

				var_119_21.localPosition = Vector3.New(var_119_26 * 0.13, var_119_26 * 0.13, var_119_26 * 0.13) + arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.time_ >= var_119_22 + var_119_23 and arg_116_1.time_ < var_119_22 + var_119_23 + arg_119_0 then
				var_119_21.localPosition = arg_116_1.var_.shakeOldPos
			end

			local var_119_27 = 0

			if var_119_27 < arg_116_1.time_ and arg_116_1.time_ <= var_119_27 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			local var_119_28 = 0.500000002980232

			if arg_116_1.time_ >= var_119_27 + var_119_28 and arg_116_1.time_ < var_119_27 + var_119_28 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			local var_119_29 = 0
			local var_119_30 = 0.775

			if var_119_29 < arg_116_1.time_ and arg_116_1.time_ <= var_119_29 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_31 = arg_116_1:GetWordFromCfg(426091027)
				local var_119_32 = arg_116_1:FormatText(var_119_31.content)

				arg_116_1.text_.text = var_119_32

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_33 = 31
				local var_119_34 = utf8.len(var_119_32)
				local var_119_35 = var_119_33 <= 0 and var_119_30 or var_119_30 * (var_119_34 / var_119_33)

				if var_119_35 > 0 and var_119_30 < var_119_35 then
					arg_116_1.talkMaxDuration = var_119_35

					if var_119_35 + var_119_29 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_35 + var_119_29
					end
				end

				arg_116_1.text_.text = var_119_32
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_36 = math.max(var_119_30, arg_116_1.talkMaxDuration)

			if var_119_29 <= arg_116_1.time_ and arg_116_1.time_ < var_119_29 + var_119_36 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_29) / var_119_36

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_29 + var_119_36 and arg_116_1.time_ < var_119_29 + var_119_36 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 426091028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play426091029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.85

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(426091028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 34
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
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_8 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_8 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_8

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_8 and arg_120_1.time_ < var_123_0 + var_123_8 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play426091029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 426091029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play426091030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.625

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[7].name)

				arg_124_1.leftNameTxt_.text = var_127_2

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

				local var_127_3 = arg_124_1:GetWordFromCfg(426091029)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 25
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play426091030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 426091030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play426091031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.3

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				local var_131_2 = "play"
				local var_131_3 = "music"

				arg_128_1:AudioAction(var_131_2, var_131_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_131_4 = ""
				local var_131_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_131_5 ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_5 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_5

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_5
						arg_128_1.bgmTxt2_.text = var_131_5
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_131_6 = 0
			local var_131_7 = 0.875

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:GetWordFromCfg(426091030)
				local var_131_9 = arg_128_1:FormatText(var_131_8.content)

				arg_128_1.text_.text = var_131_9

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 35
				local var_131_11 = utf8.len(var_131_9)
				local var_131_12 = var_131_10 <= 0 and var_131_7 or var_131_7 * (var_131_11 / var_131_10)

				if var_131_12 > 0 and var_131_7 < var_131_12 then
					arg_128_1.talkMaxDuration = var_131_12

					if var_131_12 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_9
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_13 and arg_128_1.time_ < var_131_6 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play426091031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 426091031
		arg_133_1.duration_ = 2.13

		local var_133_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_133_0:Play426091032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1054ui_story"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1054ui_story = var_136_0.localPosition

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end
			end

			local var_136_3 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_3 then
				local var_136_4 = (arg_133_1.time_ - var_136_1) / var_136_3
				local var_136_5 = Vector3.New(0, -0.985, -6)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1054ui_story, var_136_5, var_136_4)

				local var_136_6 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_6.x, var_136_6.y, var_136_6.z)

				local var_136_7 = var_136_0.localEulerAngles

				var_136_7.z = 0
				var_136_7.x = 0
				var_136_0.localEulerAngles = var_136_7
			end

			if arg_133_1.time_ >= var_136_1 + var_136_3 and arg_133_1.time_ < var_136_1 + var_136_3 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_136_8 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_8.x, var_136_8.y, var_136_8.z)

				local var_136_9 = var_136_0.localEulerAngles

				var_136_9.z = 0
				var_136_9.x = 0
				var_136_0.localEulerAngles = var_136_9

				local var_136_10 = GameObjectTools.GetOrAddComponent(var_136_0.gameObject, typeof(DynamicBoneHelper))

				if var_136_10 then
					var_136_10:EnableDynamicBone(true)
				end
			end

			local var_136_11 = arg_133_1.actors_["1054ui_story"]
			local var_136_12 = 0

			if var_136_12 < arg_133_1.time_ and arg_133_1.time_ <= var_136_12 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1054ui_story == nil then
				arg_133_1.var_.characterEffect1054ui_story = var_136_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_13 = 0.200000002980232

			if var_136_12 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_13 and not isNil(var_136_11) then
				local var_136_14 = (arg_133_1.time_ - var_136_12) / var_136_13

				if arg_133_1.var_.characterEffect1054ui_story and not isNil(var_136_11) then
					arg_133_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_12 + var_136_13 and arg_133_1.time_ < var_136_12 + var_136_13 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1054ui_story then
				arg_133_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_136_15 = 0

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_136_17 = 0
			local var_136_18 = 0.1

			if var_136_17 < arg_133_1.time_ and arg_133_1.time_ <= var_136_17 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_19 = arg_133_1:FormatText(StoryNameCfg[1487].name)

				arg_133_1.leftNameTxt_.text = var_136_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_20 = arg_133_1:GetWordFromCfg(426091031)
				local var_136_21 = arg_133_1:FormatText(var_136_20.content)

				arg_133_1.text_.text = var_136_21

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_22 = 4
				local var_136_23 = utf8.len(var_136_21)
				local var_136_24 = var_136_22 <= 0 and var_136_18 or var_136_18 * (var_136_23 / var_136_22)

				if var_136_24 > 0 and var_136_18 < var_136_24 then
					arg_133_1.talkMaxDuration = var_136_24

					if var_136_24 + var_136_17 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_24 + var_136_17
					end
				end

				arg_133_1.text_.text = var_136_21
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091031", "story_v_out_426091.awb") ~= 0 then
					local var_136_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091031", "story_v_out_426091.awb") / 1000

					if var_136_25 + var_136_17 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_25 + var_136_17
					end

					if var_136_20.prefab_name ~= "" and arg_133_1.actors_[var_136_20.prefab_name] ~= nil then
						local var_136_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_20.prefab_name].transform, "story_v_out_426091", "426091031", "story_v_out_426091.awb")

						arg_133_1:RecordAudio("426091031", var_136_26)
						arg_133_1:RecordAudio("426091031", var_136_26)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_426091", "426091031", "story_v_out_426091.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_426091", "426091031", "story_v_out_426091.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_27 = math.max(var_136_18, arg_133_1.talkMaxDuration)

			if var_136_17 <= arg_133_1.time_ and arg_133_1.time_ < var_136_17 + var_136_27 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_17) / var_136_27

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_17 + var_136_27 and arg_133_1.time_ < var_136_17 + var_136_27 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play426091032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 426091032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play426091033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1054ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1054ui_story == nil then
				arg_137_1.var_.characterEffect1054ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1054ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1054ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1054ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1054ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 0.15

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_9 = arg_137_1:GetWordFromCfg(426091032)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 6
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play426091033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 426091033
		arg_141_1.duration_ = 1.87

		local var_141_0 = {
			zh = 1.866,
			ja = 1.666
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
				arg_141_0:Play426091034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = manager.ui.mainCamera.transform
			local var_144_1 = 0.1

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.shakeOldPos = var_144_0.localPosition
			end

			local var_144_2 = 0.6

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / 0.066
				local var_144_4, var_144_5 = math.modf(var_144_3)

				var_144_0.localPosition = Vector3.New(var_144_5 * 0.13, var_144_5 * 0.13, var_144_5 * 0.13) + arg_141_1.var_.shakeOldPos
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = arg_141_1.var_.shakeOldPos
			end

			local var_144_6 = 0

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_7 = 0.7

			if arg_141_1.time_ >= var_144_6 + var_144_7 and arg_141_1.time_ < var_144_6 + var_144_7 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_8 = arg_141_1.actors_["1054ui_story"].transform
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.var_.moveOldPos1054ui_story = var_144_8.localPosition

				local var_144_10 = GameObjectTools.GetOrAddComponent(var_144_8.gameObject, typeof(DynamicBoneHelper))

				if var_144_10 then
					var_144_10:EnableDynamicBone(false)
				end
			end

			local var_144_11 = 0.001

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_11 then
				local var_144_12 = (arg_141_1.time_ - var_144_9) / var_144_11
				local var_144_13 = Vector3.New(0, 100, 0)

				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1054ui_story, var_144_13, var_144_12)

				local var_144_14 = manager.ui.mainCamera.transform.position - var_144_8.position

				var_144_8.forward = Vector3.New(var_144_14.x, var_144_14.y, var_144_14.z)

				local var_144_15 = var_144_8.localEulerAngles

				var_144_15.z = 0
				var_144_15.x = 0
				var_144_8.localEulerAngles = var_144_15
			end

			if arg_141_1.time_ >= var_144_9 + var_144_11 and arg_141_1.time_ < var_144_9 + var_144_11 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(0, 100, 0)

				local var_144_16 = manager.ui.mainCamera.transform.position - var_144_8.position

				var_144_8.forward = Vector3.New(var_144_16.x, var_144_16.y, var_144_16.z)

				local var_144_17 = var_144_8.localEulerAngles

				var_144_17.z = 0
				var_144_17.x = 0
				var_144_8.localEulerAngles = var_144_17

				local var_144_18 = GameObjectTools.GetOrAddComponent(var_144_8.gameObject, typeof(DynamicBoneHelper))

				if var_144_18 then
					var_144_18:EnableDynamicBone(true)
				end
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_19 = 0.1
			local var_144_20 = 0.075

			if var_144_19 < arg_141_1.time_ and arg_141_1.time_ <= var_144_19 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_21 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_21:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_22 = arg_141_1:FormatText(StoryNameCfg[1487].name)

				arg_141_1.leftNameTxt_.text = var_144_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_23 = arg_141_1:GetWordFromCfg(426091033)
				local var_144_24 = arg_141_1:FormatText(var_144_23.content)

				arg_141_1.text_.text = var_144_24

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_25 = 3
				local var_144_26 = utf8.len(var_144_24)
				local var_144_27 = var_144_25 <= 0 and var_144_20 or var_144_20 * (var_144_26 / var_144_25)

				if var_144_27 > 0 and var_144_20 < var_144_27 then
					arg_141_1.talkMaxDuration = var_144_27
					var_144_19 = var_144_19 + 0.3

					if var_144_27 + var_144_19 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_27 + var_144_19
					end
				end

				arg_141_1.text_.text = var_144_24
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091033", "story_v_out_426091.awb") ~= 0 then
					local var_144_28 = manager.audio:GetVoiceLength("story_v_out_426091", "426091033", "story_v_out_426091.awb") / 1000

					if var_144_28 + var_144_19 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_28 + var_144_19
					end

					if var_144_23.prefab_name ~= "" and arg_141_1.actors_[var_144_23.prefab_name] ~= nil then
						local var_144_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_23.prefab_name].transform, "story_v_out_426091", "426091033", "story_v_out_426091.awb")

						arg_141_1:RecordAudio("426091033", var_144_29)
						arg_141_1:RecordAudio("426091033", var_144_29)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_426091", "426091033", "story_v_out_426091.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_426091", "426091033", "story_v_out_426091.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_30 = var_144_19 + 0.3
			local var_144_31 = math.max(var_144_20, arg_141_1.talkMaxDuration)

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_31 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_30) / var_144_31

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_30 + var_144_31 and arg_141_1.time_ < var_144_30 + var_144_31 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 426091034
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play426091035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1054ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1054ui_story == nil then
				arg_147_1.var_.characterEffect1054ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1054ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1054ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1054ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1054ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 0.075

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_9 = arg_147_1:GetWordFromCfg(426091034)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 3
				local var_150_12 = utf8.len(var_150_10)
				local var_150_13 = var_150_11 <= 0 and var_150_7 or var_150_7 * (var_150_12 / var_150_11)

				if var_150_13 > 0 and var_150_7 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play426091035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426091035
		arg_151_1.duration_ = 6

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426091036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = "J27g"

			if arg_151_1.bgs_[var_154_0] == nil then
				local var_154_1 = Object.Instantiate(arg_151_1.paintGo_)

				var_154_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_154_0)
				var_154_1.name = var_154_0
				var_154_1.transform.parent = arg_151_1.stage_.transform
				var_154_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.bgs_[var_154_0] = var_154_1
			end

			local var_154_2 = 0.3

			if var_154_2 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				local var_154_3 = manager.ui.mainCamera.transform.localPosition
				local var_154_4 = Vector3.New(0, 0, 10) + Vector3.New(var_154_3.x, var_154_3.y, 0)
				local var_154_5 = arg_151_1.bgs_.J27g

				var_154_5.transform.localPosition = var_154_4
				var_154_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_6 = var_154_5:GetComponent("SpriteRenderer")

				if var_154_6 and var_154_6.sprite then
					local var_154_7 = (var_154_5.transform.localPosition - var_154_3).z
					local var_154_8 = manager.ui.mainCameraCom_
					local var_154_9 = 2 * var_154_7 * Mathf.Tan(var_154_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_154_10 = var_154_9 * var_154_8.aspect
					local var_154_11 = var_154_6.sprite.bounds.size.x
					local var_154_12 = var_154_6.sprite.bounds.size.y
					local var_154_13 = var_154_10 / var_154_11
					local var_154_14 = var_154_9 / var_154_12
					local var_154_15 = var_154_14 < var_154_13 and var_154_13 or var_154_14

					var_154_5.transform.localScale = Vector3.New(var_154_15, var_154_15, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "J27g" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_16 = 1

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_17 = 0.3

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_18 = 0
			local var_154_19 = 0.3

			if var_154_18 < arg_151_1.time_ and arg_151_1.time_ <= var_154_18 + arg_154_0 then
				local var_154_20 = "play"
				local var_154_21 = "music"

				arg_151_1:AudioAction(var_154_20, var_154_21, "ui_battle", "ui_battle_stopbgm", "")

				local var_154_22 = ""
				local var_154_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_154_23 ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_23 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_23

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_23
						arg_151_1.bgmTxt2_.text = var_154_23
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_154_24 = 0.433333333333333
			local var_154_25 = 1

			if var_154_24 < arg_151_1.time_ and arg_151_1.time_ <= var_154_24 + arg_154_0 then
				local var_154_26 = "play"
				local var_154_27 = "music"

				arg_151_1:AudioAction(var_154_26, var_154_27, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_154_28 = ""
				local var_154_29 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_154_29 ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_29 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_29

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_29
						arg_151_1.bgmTxt2_.text = var_154_29
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_154_30 = 0.133333333333333
			local var_154_31 = 1

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				local var_154_32 = "stop"
				local var_154_33 = "effect"

				arg_151_1:AudioAction(var_154_32, var_154_33, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			local var_154_34 = 0.433333333333333
			local var_154_35 = 1

			if var_154_34 < arg_151_1.time_ and arg_151_1.time_ <= var_154_34 + arg_154_0 then
				local var_154_36 = "stop"
				local var_154_37 = "effect"

				arg_151_1:AudioAction(var_154_36, var_154_37, "se_story_150", "se_story_150_flower_field", "")
			end

			local var_154_38 = 0.7
			local var_154_39 = 1

			if var_154_38 < arg_151_1.time_ and arg_151_1.time_ <= var_154_38 + arg_154_0 then
				local var_154_40 = "play"
				local var_154_41 = "effect"

				arg_151_1:AudioAction(var_154_40, var_154_41, "se_story_birthday4", "se_story_birthday4_door_huge_break", "")
			end

			local var_154_42 = manager.ui.mainCamera.transform
			local var_154_43 = 0

			if var_154_43 < arg_151_1.time_ and arg_151_1.time_ <= var_154_43 + arg_154_0 then
				local var_154_44 = arg_151_1.var_.effectbaozhashinei1
				local var_154_45
				local var_154_46 = var_154_42

				if not var_154_44 then
					var_154_44 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_154_46)
					var_154_44.name = "baozhashinei1"
					arg_151_1.var_.effectbaozhashinei1 = var_154_44
				else
					var_154_44.transform:SetParent(var_154_46)
				end

				var_154_44.transform.localPosition = Vector3.New(0, 0, 0)
				var_154_44.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_154_47 = manager.ui.mainCamera.transform
			local var_154_48 = 1.7

			if var_154_48 < arg_151_1.time_ and arg_151_1.time_ <= var_154_48 + arg_154_0 then
				local var_154_49 = arg_151_1.var_.effectbaozhashinei1

				if var_154_49 then
					Object.Destroy(var_154_49)

					arg_151_1.var_.effectbaozhashinei1 = nil
				end
			end

			local var_154_50 = arg_151_1.bgs_.J27g.transform
			local var_154_51 = 0.3

			if var_154_51 < arg_151_1.time_ and arg_151_1.time_ <= var_154_51 + arg_154_0 then
				arg_151_1.var_.moveOldPosJ27g = var_154_50.localPosition
			end

			local var_154_52 = 1.43333333333333

			if var_154_51 <= arg_151_1.time_ and arg_151_1.time_ < var_154_51 + var_154_52 then
				local var_154_53 = (arg_151_1.time_ - var_154_51) / var_154_52
				local var_154_54 = Vector3.New(0, 1, 9.5)

				var_154_50.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPosJ27g, var_154_54, var_154_53)
			end

			if arg_151_1.time_ >= var_154_51 + var_154_52 and arg_151_1.time_ < var_154_51 + var_154_52 + arg_154_0 then
				var_154_50.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_154_55 = manager.ui.mainCamera.transform
			local var_154_56 = 0.833333333333333

			if var_154_56 < arg_151_1.time_ and arg_151_1.time_ <= var_154_56 + arg_154_0 then
				local var_154_57 = arg_151_1.var_.effectdachumenwai1
				local var_154_58
				local var_154_59 = var_154_55

				if not var_154_57 then
					var_154_57 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_154_59)
					var_154_57.name = "dachumenwai1"
					arg_151_1.var_.effectdachumenwai1 = var_154_57
				else
					var_154_57.transform:SetParent(var_154_59)
				end

				var_154_57.transform.localPosition = Vector3.New(0, 0, 0)
				var_154_57.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_154_60 = manager.ui.mainCamera.transform
			local var_154_61 = 3.2

			if var_154_61 < arg_151_1.time_ and arg_151_1.time_ <= var_154_61 + arg_154_0 then
				local var_154_62 = arg_151_1.var_.effectdachumenwai1

				if var_154_62 then
					Object.Destroy(var_154_62)

					arg_151_1.var_.effectdachumenwai1 = nil
				end
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_63 = 1
			local var_154_64 = 1

			if var_154_63 < arg_151_1.time_ and arg_151_1.time_ <= var_154_63 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_65 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_65:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_151_1.dialogCg_.alpha = arg_157_0
				end))
				var_154_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_66 = arg_151_1:GetWordFromCfg(426091035)
				local var_154_67 = arg_151_1:FormatText(var_154_66.content)

				arg_151_1.text_.text = var_154_67

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_68 = 40
				local var_154_69 = utf8.len(var_154_67)
				local var_154_70 = var_154_68 <= 0 and var_154_64 or var_154_64 * (var_154_69 / var_154_68)

				if var_154_70 > 0 and var_154_64 < var_154_70 then
					arg_151_1.talkMaxDuration = var_154_70
					var_154_63 = var_154_63 + 0.3

					if var_154_70 + var_154_63 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_70 + var_154_63
					end
				end

				arg_151_1.text_.text = var_154_67
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_71 = var_154_63 + 0.3
			local var_154_72 = math.max(var_154_64, arg_151_1.talkMaxDuration)

			if var_154_71 <= arg_151_1.time_ and arg_151_1.time_ < var_154_71 + var_154_72 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_71) / var_154_72

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_71 + var_154_72 and arg_151_1.time_ < var_154_71 + var_154_72 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "J27g",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.43333333333333,
				startTime = 0.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play426091036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426091036
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426091037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 1.175

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(426091036)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 47
				local var_162_5 = utf8.len(var_162_3)
				local var_162_6 = var_162_4 <= 0 and var_162_1 or var_162_1 * (var_162_5 / var_162_4)

				if var_162_6 > 0 and var_162_1 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_7 and arg_159_1.time_ < var_162_0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play426091037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426091037
		arg_163_1.duration_ = 2.7

		local var_163_0 = {
			zh = 2.7,
			ja = 1.999999999999
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
				arg_163_0:Play426091038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1054ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos1054ui_story = var_166_0.localPosition

				local var_166_2 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(false)
				end
			end

			local var_166_3 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_3 then
				local var_166_4 = (arg_163_1.time_ - var_166_1) / var_166_3
				local var_166_5 = Vector3.New(0, -0.985, -6)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1054ui_story, var_166_5, var_166_4)

				local var_166_6 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_6.x, var_166_6.y, var_166_6.z)

				local var_166_7 = var_166_0.localEulerAngles

				var_166_7.z = 0
				var_166_7.x = 0
				var_166_0.localEulerAngles = var_166_7
			end

			if arg_163_1.time_ >= var_166_1 + var_166_3 and arg_163_1.time_ < var_166_1 + var_166_3 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_166_8 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_8.x, var_166_8.y, var_166_8.z)

				local var_166_9 = var_166_0.localEulerAngles

				var_166_9.z = 0
				var_166_9.x = 0
				var_166_0.localEulerAngles = var_166_9

				local var_166_10 = GameObjectTools.GetOrAddComponent(var_166_0.gameObject, typeof(DynamicBoneHelper))

				if var_166_10 then
					var_166_10:EnableDynamicBone(true)
				end
			end

			local var_166_11 = arg_163_1.actors_["1054ui_story"]
			local var_166_12 = 0

			if var_166_12 < arg_163_1.time_ and arg_163_1.time_ <= var_166_12 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect1054ui_story == nil then
				arg_163_1.var_.characterEffect1054ui_story = var_166_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_13 = 0.200000002980232

			if var_166_12 <= arg_163_1.time_ and arg_163_1.time_ < var_166_12 + var_166_13 and not isNil(var_166_11) then
				local var_166_14 = (arg_163_1.time_ - var_166_12) / var_166_13

				if arg_163_1.var_.characterEffect1054ui_story and not isNil(var_166_11) then
					arg_163_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_12 + var_166_13 and arg_163_1.time_ < var_166_12 + var_166_13 + arg_166_0 and not isNil(var_166_11) and arg_163_1.var_.characterEffect1054ui_story then
				arg_163_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_166_15 = 0

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_166_17 = 0
			local var_166_18 = 0.125

			if var_166_17 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_19 = arg_163_1:FormatText(StoryNameCfg[1487].name)

				arg_163_1.leftNameTxt_.text = var_166_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_20 = arg_163_1:GetWordFromCfg(426091037)
				local var_166_21 = arg_163_1:FormatText(var_166_20.content)

				arg_163_1.text_.text = var_166_21

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_22 = 5
				local var_166_23 = utf8.len(var_166_21)
				local var_166_24 = var_166_22 <= 0 and var_166_18 or var_166_18 * (var_166_23 / var_166_22)

				if var_166_24 > 0 and var_166_18 < var_166_24 then
					arg_163_1.talkMaxDuration = var_166_24

					if var_166_24 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_24 + var_166_17
					end
				end

				arg_163_1.text_.text = var_166_21
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091037", "story_v_out_426091.awb") ~= 0 then
					local var_166_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091037", "story_v_out_426091.awb") / 1000

					if var_166_25 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_25 + var_166_17
					end

					if var_166_20.prefab_name ~= "" and arg_163_1.actors_[var_166_20.prefab_name] ~= nil then
						local var_166_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_20.prefab_name].transform, "story_v_out_426091", "426091037", "story_v_out_426091.awb")

						arg_163_1:RecordAudio("426091037", var_166_26)
						arg_163_1:RecordAudio("426091037", var_166_26)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_426091", "426091037", "story_v_out_426091.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_426091", "426091037", "story_v_out_426091.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_27 = math.max(var_166_18, arg_163_1.talkMaxDuration)

			if var_166_17 <= arg_163_1.time_ and arg_163_1.time_ < var_166_17 + var_166_27 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_17) / var_166_27

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_17 + var_166_27 and arg_163_1.time_ < var_166_17 + var_166_27 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426091038
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play426091039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1054ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1054ui_story == nil then
				arg_167_1.var_.characterEffect1054ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1054ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1054ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1054ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1054ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 0.35

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_9 = arg_167_1:GetWordFromCfg(426091038)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 14
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play426091039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426091039
		arg_171_1.duration_ = 5.13

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play426091040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1054ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos1054ui_story = var_174_0.localPosition

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end
			end

			local var_174_3 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_3 then
				local var_174_4 = (arg_171_1.time_ - var_174_1) / var_174_3
				local var_174_5 = Vector3.New(0, 100, 0)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1054ui_story, var_174_5, var_174_4)

				local var_174_6 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_6.x, var_174_6.y, var_174_6.z)

				local var_174_7 = var_174_0.localEulerAngles

				var_174_7.z = 0
				var_174_7.x = 0
				var_174_0.localEulerAngles = var_174_7
			end

			if arg_171_1.time_ >= var_174_1 + var_174_3 and arg_171_1.time_ < var_174_1 + var_174_3 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, 100, 0)

				local var_174_8 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_8.x, var_174_8.y, var_174_8.z)

				local var_174_9 = var_174_0.localEulerAngles

				var_174_9.z = 0
				var_174_9.x = 0
				var_174_0.localEulerAngles = var_174_9

				local var_174_10 = GameObjectTools.GetOrAddComponent(var_174_0.gameObject, typeof(DynamicBoneHelper))

				if var_174_10 then
					var_174_10:EnableDynamicBone(true)
				end
			end

			local var_174_11 = 0.133333333333333
			local var_174_12 = 1

			if var_174_11 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				local var_174_13 = "play"
				local var_174_14 = "effect"

				arg_171_1:AudioAction(var_174_13, var_174_14, "se_story_1310", "se_story_1310_rush", "")
			end

			local var_174_15 = manager.ui.mainCamera.transform
			local var_174_16 = 0.133333333333333

			if var_174_16 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.var_.shakeOldPos = var_174_15.localPosition
			end

			local var_174_17 = 0.591666666666667

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 then
				local var_174_18 = (arg_171_1.time_ - var_174_16) / 0.066
				local var_174_19, var_174_20 = math.modf(var_174_18)

				var_174_15.localPosition = Vector3.New(var_174_20 * 0.13, var_174_20 * 0.13, var_174_20 * 0.13) + arg_171_1.var_.shakeOldPos
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				var_174_15.localPosition = arg_171_1.var_.shakeOldPos
			end

			local var_174_21 = 0

			if var_174_21 < arg_171_1.time_ and arg_171_1.time_ <= var_174_21 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			local var_174_22 = 0.433333333333333

			if arg_171_1.time_ >= var_174_21 + var_174_22 and arg_171_1.time_ < var_174_21 + var_174_22 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_23 = 0.133333333333333
			local var_174_24 = 0.725

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_25 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_25:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_26 = arg_171_1:GetWordFromCfg(426091039)
				local var_174_27 = arg_171_1:FormatText(var_174_26.content)

				arg_171_1.text_.text = var_174_27

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_28 = 29
				local var_174_29 = utf8.len(var_174_27)
				local var_174_30 = var_174_28 <= 0 and var_174_24 or var_174_24 * (var_174_29 / var_174_28)

				if var_174_30 > 0 and var_174_24 < var_174_30 then
					arg_171_1.talkMaxDuration = var_174_30
					var_174_23 = var_174_23 + 0.3

					if var_174_30 + var_174_23 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_30 + var_174_23
					end
				end

				arg_171_1.text_.text = var_174_27
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_31 = var_174_23 + 0.3
			local var_174_32 = math.max(var_174_24, arg_171_1.talkMaxDuration)

			if var_174_31 <= arg_171_1.time_ and arg_171_1.time_ < var_174_31 + var_174_32 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_31) / var_174_32

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_31 + var_174_32 and arg_171_1.time_ < var_174_31 + var_174_32 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091040 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 426091040
		arg_177_1.duration_ = 2.17

		local var_177_0 = {
			zh = 2.166,
			ja = 1.999999999999
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
				arg_177_0:Play426091041(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1054ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1054ui_story = var_180_0.localPosition

				local var_180_2 = GameObjectTools.GetOrAddComponent(var_180_0.gameObject, typeof(DynamicBoneHelper))

				if var_180_2 then
					var_180_2:EnableDynamicBone(false)
				end
			end

			local var_180_3 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_3 then
				local var_180_4 = (arg_177_1.time_ - var_180_1) / var_180_3
				local var_180_5 = Vector3.New(0, -0.985, -6)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1054ui_story, var_180_5, var_180_4)

				local var_180_6 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_6.x, var_180_6.y, var_180_6.z)

				local var_180_7 = var_180_0.localEulerAngles

				var_180_7.z = 0
				var_180_7.x = 0
				var_180_0.localEulerAngles = var_180_7
			end

			if arg_177_1.time_ >= var_180_1 + var_180_3 and arg_177_1.time_ < var_180_1 + var_180_3 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_180_8 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_8.x, var_180_8.y, var_180_8.z)

				local var_180_9 = var_180_0.localEulerAngles

				var_180_9.z = 0
				var_180_9.x = 0
				var_180_0.localEulerAngles = var_180_9

				local var_180_10 = GameObjectTools.GetOrAddComponent(var_180_0.gameObject, typeof(DynamicBoneHelper))

				if var_180_10 then
					var_180_10:EnableDynamicBone(true)
				end
			end

			local var_180_11 = arg_177_1.actors_["1054ui_story"]
			local var_180_12 = 0

			if var_180_12 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.characterEffect1054ui_story == nil then
				arg_177_1.var_.characterEffect1054ui_story = var_180_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_13 = 0.200000002980232

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_13 and not isNil(var_180_11) then
				local var_180_14 = (arg_177_1.time_ - var_180_12) / var_180_13

				if arg_177_1.var_.characterEffect1054ui_story and not isNil(var_180_11) then
					arg_177_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_12 + var_180_13 and arg_177_1.time_ < var_180_12 + var_180_13 + arg_180_0 and not isNil(var_180_11) and arg_177_1.var_.characterEffect1054ui_story then
				arg_177_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_180_15 = 0

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_180_16 = 0
			local var_180_17 = 0.125

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_18 = arg_177_1:FormatText(StoryNameCfg[1487].name)

				arg_177_1.leftNameTxt_.text = var_180_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_19 = arg_177_1:GetWordFromCfg(426091040)
				local var_180_20 = arg_177_1:FormatText(var_180_19.content)

				arg_177_1.text_.text = var_180_20

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_21 = 5
				local var_180_22 = utf8.len(var_180_20)
				local var_180_23 = var_180_21 <= 0 and var_180_17 or var_180_17 * (var_180_22 / var_180_21)

				if var_180_23 > 0 and var_180_17 < var_180_23 then
					arg_177_1.talkMaxDuration = var_180_23

					if var_180_23 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_16
					end
				end

				arg_177_1.text_.text = var_180_20
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091040", "story_v_out_426091.awb") ~= 0 then
					local var_180_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091040", "story_v_out_426091.awb") / 1000

					if var_180_24 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_24 + var_180_16
					end

					if var_180_19.prefab_name ~= "" and arg_177_1.actors_[var_180_19.prefab_name] ~= nil then
						local var_180_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_19.prefab_name].transform, "story_v_out_426091", "426091040", "story_v_out_426091.awb")

						arg_177_1:RecordAudio("426091040", var_180_25)
						arg_177_1:RecordAudio("426091040", var_180_25)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_426091", "426091040", "story_v_out_426091.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_426091", "426091040", "story_v_out_426091.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_26 = math.max(var_180_17, arg_177_1.talkMaxDuration)

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_26 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_16) / var_180_26

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_16 + var_180_26 and arg_177_1.time_ < var_180_16 + var_180_26 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play426091041 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 426091041
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play426091042(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1054ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1054ui_story == nil then
				arg_181_1.var_.characterEffect1054ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1054ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1054ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1054ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1054ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.65

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(426091041)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 26
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play426091042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 426091042
		arg_185_1.duration_ = 1.73

		local var_185_0 = {
			zh = 1.4,
			ja = 1.733
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
				arg_185_0:Play426091043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1054ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1054ui_story = var_188_0.localPosition

				local var_188_2 = GameObjectTools.GetOrAddComponent(var_188_0.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(false)
				end
			end

			local var_188_3 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_3 then
				local var_188_4 = (arg_185_1.time_ - var_188_1) / var_188_3
				local var_188_5 = Vector3.New(0, 100, 0)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1054ui_story, var_188_5, var_188_4)

				local var_188_6 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_6.x, var_188_6.y, var_188_6.z)

				local var_188_7 = var_188_0.localEulerAngles

				var_188_7.z = 0
				var_188_7.x = 0
				var_188_0.localEulerAngles = var_188_7
			end

			if arg_185_1.time_ >= var_188_1 + var_188_3 and arg_185_1.time_ < var_188_1 + var_188_3 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, 100, 0)

				local var_188_8 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_8.x, var_188_8.y, var_188_8.z)

				local var_188_9 = var_188_0.localEulerAngles

				var_188_9.z = 0
				var_188_9.x = 0
				var_188_0.localEulerAngles = var_188_9

				local var_188_10 = GameObjectTools.GetOrAddComponent(var_188_0.gameObject, typeof(DynamicBoneHelper))

				if var_188_10 then
					var_188_10:EnableDynamicBone(true)
				end
			end

			local var_188_11 = 0
			local var_188_12 = 0.1

			if var_188_11 < arg_185_1.time_ and arg_185_1.time_ <= var_188_11 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_13 = arg_185_1:FormatText(StoryNameCfg[1488].name)

				arg_185_1.leftNameTxt_.text = var_188_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_14 = arg_185_1:GetWordFromCfg(426091042)
				local var_188_15 = arg_185_1:FormatText(var_188_14.content)

				arg_185_1.text_.text = var_188_15

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_16 = 4
				local var_188_17 = utf8.len(var_188_15)
				local var_188_18 = var_188_16 <= 0 and var_188_12 or var_188_12 * (var_188_17 / var_188_16)

				if var_188_18 > 0 and var_188_12 < var_188_18 then
					arg_185_1.talkMaxDuration = var_188_18

					if var_188_18 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_18 + var_188_11
					end
				end

				arg_185_1.text_.text = var_188_15
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091042", "story_v_out_426091.awb") ~= 0 then
					local var_188_19 = manager.audio:GetVoiceLength("story_v_out_426091", "426091042", "story_v_out_426091.awb") / 1000

					if var_188_19 + var_188_11 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_11
					end

					if var_188_14.prefab_name ~= "" and arg_185_1.actors_[var_188_14.prefab_name] ~= nil then
						local var_188_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_14.prefab_name].transform, "story_v_out_426091", "426091042", "story_v_out_426091.awb")

						arg_185_1:RecordAudio("426091042", var_188_20)
						arg_185_1:RecordAudio("426091042", var_188_20)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_426091", "426091042", "story_v_out_426091.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_426091", "426091042", "story_v_out_426091.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_21 = math.max(var_188_12, arg_185_1.talkMaxDuration)

			if var_188_11 <= arg_185_1.time_ and arg_185_1.time_ < var_188_11 + var_188_21 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_11) / var_188_21

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_11 + var_188_21 and arg_185_1.time_ < var_188_11 + var_188_21 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play426091043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 426091043
		arg_189_1.duration_ = 6.67

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play426091044(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = "SS2602"

			if arg_189_1.bgs_[var_192_0] == nil then
				local var_192_1 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_192_0)
				var_192_1.name = var_192_0
				var_192_1.transform.parent = arg_189_1.stage_.transform
				var_192_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_[var_192_0] = var_192_1
			end

			local var_192_2 = 0.883333333333333

			if var_192_2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				local var_192_3 = manager.ui.mainCamera.transform.localPosition
				local var_192_4 = Vector3.New(0, 0, 10) + Vector3.New(var_192_3.x, var_192_3.y, 0)
				local var_192_5 = arg_189_1.bgs_.SS2602

				var_192_5.transform.localPosition = var_192_4
				var_192_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_6 = var_192_5:GetComponent("SpriteRenderer")

				if var_192_6 and var_192_6.sprite then
					local var_192_7 = (var_192_5.transform.localPosition - var_192_3).z
					local var_192_8 = manager.ui.mainCameraCom_
					local var_192_9 = 2 * var_192_7 * Mathf.Tan(var_192_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_192_10 = var_192_9 * var_192_8.aspect
					local var_192_11 = var_192_6.sprite.bounds.size.x
					local var_192_12 = var_192_6.sprite.bounds.size.y
					local var_192_13 = var_192_10 / var_192_11
					local var_192_14 = var_192_9 / var_192_12
					local var_192_15 = var_192_14 < var_192_13 and var_192_13 or var_192_14

					var_192_5.transform.localScale = Vector3.New(var_192_15, var_192_15, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "SS2602" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_16 = 2.06666666368643

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			local var_192_17 = 0.3

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_18 = arg_189_1.actors_["1054ui_story"].transform
			local var_192_19 = 0

			if var_192_19 < arg_189_1.time_ and arg_189_1.time_ <= var_192_19 + arg_192_0 then
				arg_189_1.var_.moveOldPos1054ui_story = var_192_18.localPosition

				local var_192_20 = GameObjectTools.GetOrAddComponent(var_192_18.gameObject, typeof(DynamicBoneHelper))

				if var_192_20 then
					var_192_20:EnableDynamicBone(false)
				end
			end

			local var_192_21 = 0.001

			if var_192_19 <= arg_189_1.time_ and arg_189_1.time_ < var_192_19 + var_192_21 then
				local var_192_22 = (arg_189_1.time_ - var_192_19) / var_192_21
				local var_192_23 = Vector3.New(0, 100, 0)

				var_192_18.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1054ui_story, var_192_23, var_192_22)

				local var_192_24 = manager.ui.mainCamera.transform.position - var_192_18.position

				var_192_18.forward = Vector3.New(var_192_24.x, var_192_24.y, var_192_24.z)

				local var_192_25 = var_192_18.localEulerAngles

				var_192_25.z = 0
				var_192_25.x = 0
				var_192_18.localEulerAngles = var_192_25
			end

			if arg_189_1.time_ >= var_192_19 + var_192_21 and arg_189_1.time_ < var_192_19 + var_192_21 + arg_192_0 then
				var_192_18.localPosition = Vector3.New(0, 100, 0)

				local var_192_26 = manager.ui.mainCamera.transform.position - var_192_18.position

				var_192_18.forward = Vector3.New(var_192_26.x, var_192_26.y, var_192_26.z)

				local var_192_27 = var_192_18.localEulerAngles

				var_192_27.z = 0
				var_192_27.x = 0
				var_192_18.localEulerAngles = var_192_27

				local var_192_28 = GameObjectTools.GetOrAddComponent(var_192_18.gameObject, typeof(DynamicBoneHelper))

				if var_192_28 then
					var_192_28:EnableDynamicBone(true)
				end
			end

			local var_192_29 = arg_189_1.actors_["6148ui_story"]
			local var_192_30 = 0

			if var_192_30 < arg_189_1.time_ and arg_189_1.time_ <= var_192_30 + arg_192_0 and not isNil(var_192_29) and arg_189_1.var_.characterEffect6148ui_story == nil then
				arg_189_1.var_.characterEffect6148ui_story = var_192_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_31 = 0.200000002980232

			if var_192_30 <= arg_189_1.time_ and arg_189_1.time_ < var_192_30 + var_192_31 and not isNil(var_192_29) then
				local var_192_32 = (arg_189_1.time_ - var_192_30) / var_192_31

				if arg_189_1.var_.characterEffect6148ui_story and not isNil(var_192_29) then
					local var_192_33 = Mathf.Lerp(0, 0.5, var_192_32)

					arg_189_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_189_1.var_.characterEffect6148ui_story.fillRatio = var_192_33
				end
			end

			if arg_189_1.time_ >= var_192_30 + var_192_31 and arg_189_1.time_ < var_192_30 + var_192_31 + arg_192_0 and not isNil(var_192_29) and arg_189_1.var_.characterEffect6148ui_story then
				local var_192_34 = 0.5

				arg_189_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_189_1.var_.characterEffect6148ui_story.fillRatio = var_192_34
			end

			local var_192_35 = 0.133333333333333
			local var_192_36 = 1

			if var_192_35 < arg_189_1.time_ and arg_189_1.time_ <= var_192_35 + arg_192_0 then
				local var_192_37 = "play"
				local var_192_38 = "effect"

				arg_189_1:AudioAction(var_192_37, var_192_38, "se_story_side_1011", "se_story_side_1011_metalhit", "")
			end

			local var_192_39 = manager.ui.mainCamera.transform
			local var_192_40 = 0

			if var_192_40 < arg_189_1.time_ and arg_189_1.time_ <= var_192_40 + arg_192_0 then
				local var_192_41 = arg_189_1.var_.effecthuangyuanjiaozhan1
				local var_192_42
				local var_192_43 = var_192_39

				if not var_192_41 then
					var_192_41 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_in_keep"), var_192_43)
					var_192_41.name = "huangyuanjiaozhan1"
					arg_189_1.var_.effecthuangyuanjiaozhan1 = var_192_41
				else
					var_192_41.transform:SetParent(var_192_43)
				end

				var_192_41.transform.localPosition = Vector3.New(0, 0, 0)
				var_192_41.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_192_44 = manager.ui.mainCamera.transform
			local var_192_45 = 1.26666666666667

			if var_192_45 < arg_189_1.time_ and arg_189_1.time_ <= var_192_45 + arg_192_0 then
				local var_192_46 = arg_189_1.var_.effecthuangyuanjiaozhan1

				if var_192_46 then
					Object.Destroy(var_192_46)

					arg_189_1.var_.effecthuangyuanjiaozhan1 = nil
				end
			end

			local var_192_47 = manager.ui.mainCamera.transform
			local var_192_48 = 1.26666666666667

			if var_192_48 < arg_189_1.time_ and arg_189_1.time_ <= var_192_48 + arg_192_0 then
				local var_192_49 = arg_189_1.var_.effecthuangyuanjiaozhan2
				local var_192_50
				local var_192_51 = var_192_47

				if not var_192_49 then
					var_192_49 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_out"), var_192_51)
					var_192_49.name = "huangyuanjiaozhan2"
					arg_189_1.var_.effecthuangyuanjiaozhan2 = var_192_49
				else
					var_192_49.transform:SetParent(var_192_51)
				end

				var_192_49.transform.localPosition = Vector3.New(0, 0, 0)
				var_192_49.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_192_52 = manager.ui.mainCamera.transform
			local var_192_53 = 2.06666666666667

			if var_192_53 < arg_189_1.time_ and arg_189_1.time_ <= var_192_53 + arg_192_0 then
				local var_192_54 = arg_189_1.var_.effecthuangyuanjiaozhan2

				if var_192_54 then
					Object.Destroy(var_192_54)

					arg_189_1.var_.effecthuangyuanjiaozhan2 = nil
				end
			end

			local var_192_55 = arg_189_1.bgs_.SS2602.transform
			local var_192_56 = 0.883333333333333

			if var_192_56 < arg_189_1.time_ and arg_189_1.time_ <= var_192_56 + arg_192_0 then
				arg_189_1.var_.moveOldPosSS2602 = var_192_55.localPosition
			end

			local var_192_57 = 0.001

			if var_192_56 <= arg_189_1.time_ and arg_189_1.time_ < var_192_56 + var_192_57 then
				local var_192_58 = (arg_189_1.time_ - var_192_56) / var_192_57
				local var_192_59 = Vector3.New(0, 1, 1)

				var_192_55.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPosSS2602, var_192_59, var_192_58)
			end

			if arg_189_1.time_ >= var_192_56 + var_192_57 and arg_189_1.time_ < var_192_56 + var_192_57 + arg_192_0 then
				var_192_55.localPosition = Vector3.New(0, 1, 1)
			end

			local var_192_60 = arg_189_1.bgs_.SS2602.transform
			local var_192_61 = 0.9

			if var_192_61 < arg_189_1.time_ and arg_189_1.time_ <= var_192_61 + arg_192_0 then
				arg_189_1.var_.moveOldPosSS2602 = var_192_60.localPosition
			end

			local var_192_62 = 0.966666666666666

			if var_192_61 <= arg_189_1.time_ and arg_189_1.time_ < var_192_61 + var_192_62 then
				local var_192_63 = (arg_189_1.time_ - var_192_61) / var_192_62
				local var_192_64 = Vector3.New(0, 1, 10)

				var_192_60.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPosSS2602, var_192_64, var_192_63)
			end

			if arg_189_1.time_ >= var_192_61 + var_192_62 and arg_189_1.time_ < var_192_61 + var_192_62 + arg_192_0 then
				var_192_60.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_65 = 1.66666666368643
			local var_192_66 = 0.95

			if var_192_65 < arg_189_1.time_ and arg_189_1.time_ <= var_192_65 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_67 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_67:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_68 = arg_189_1:GetWordFromCfg(426091043)
				local var_192_69 = arg_189_1:FormatText(var_192_68.content)

				arg_189_1.text_.text = var_192_69

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_70 = 38
				local var_192_71 = utf8.len(var_192_69)
				local var_192_72 = var_192_70 <= 0 and var_192_66 or var_192_66 * (var_192_71 / var_192_70)

				if var_192_72 > 0 and var_192_66 < var_192_72 then
					arg_189_1.talkMaxDuration = var_192_72
					var_192_65 = var_192_65 + 0.3

					if var_192_72 + var_192_65 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_72 + var_192_65
					end
				end

				arg_189_1.text_.text = var_192_69
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_73 = var_192_65 + 0.3
			local var_192_74 = math.max(var_192_66, arg_189_1.talkMaxDuration)

			if var_192_73 <= arg_189_1.time_ and arg_189_1.time_ < var_192_73 + var_192_74 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_73) / var_192_74

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_73 + var_192_74 and arg_189_1.time_ < var_192_73 + var_192_74 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.0166666666666667,
				startTime = 0.883333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 1),
					endPos = Vector3.New(0, 1, 1),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.966666666666666,
				startTime = 0.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 1),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play426091044 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 426091044
		arg_195_1.duration_ = 5.17

		local var_195_0 = {
			zh = 5.166,
			ja = 4.133
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
				arg_195_0:Play426091045(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.45

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[1488].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(426091044)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 18
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091044", "story_v_out_426091.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091044", "story_v_out_426091.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_426091", "426091044", "story_v_out_426091.awb")

						arg_195_1:RecordAudio("426091044", var_198_9)
						arg_195_1:RecordAudio("426091044", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_426091", "426091044", "story_v_out_426091.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_426091", "426091044", "story_v_out_426091.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play426091045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 426091045
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play426091046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.225

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

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(426091045)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 9
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
	Play426091046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 426091046
		arg_203_1.duration_ = 7.2

		local var_203_0 = {
			zh = 5.233,
			ja = 7.2
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
				arg_203_0:Play426091047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.55

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[1488].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(426091046)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091046", "story_v_out_426091.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091046", "story_v_out_426091.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_426091", "426091046", "story_v_out_426091.awb")

						arg_203_1:RecordAudio("426091046", var_206_9)
						arg_203_1:RecordAudio("426091046", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_426091", "426091046", "story_v_out_426091.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_426091", "426091046", "story_v_out_426091.awb")
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
	Play426091047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 426091047
		arg_207_1.duration_ = 6.67

		local var_207_0 = {
			zh = 6.1,
			ja = 6.666
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
				arg_207_0:Play426091048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.775

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[1488].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:GetWordFromCfg(426091047)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091047", "story_v_out_426091.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091047", "story_v_out_426091.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_426091", "426091047", "story_v_out_426091.awb")

						arg_207_1:RecordAudio("426091047", var_210_9)
						arg_207_1:RecordAudio("426091047", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_426091", "426091047", "story_v_out_426091.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_426091", "426091047", "story_v_out_426091.awb")
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
	Play426091048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 426091048
		arg_211_1.duration_ = 3.97

		local var_211_0 = {
			zh = 2.466,
			ja = 3.966
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
				arg_211_0:Play426091049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0
			local var_214_1 = 0.175

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_2 = arg_211_1:FormatText(StoryNameCfg[1487].name)

				arg_211_1.leftNameTxt_.text = var_214_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:GetWordFromCfg(426091048)
				local var_214_4 = arg_211_1:FormatText(var_214_3.content)

				arg_211_1.text_.text = var_214_4

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091048", "story_v_out_426091.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091048", "story_v_out_426091.awb") / 1000

					if var_214_8 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_0
					end

					if var_214_3.prefab_name ~= "" and arg_211_1.actors_[var_214_3.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_3.prefab_name].transform, "story_v_out_426091", "426091048", "story_v_out_426091.awb")

						arg_211_1:RecordAudio("426091048", var_214_9)
						arg_211_1:RecordAudio("426091048", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_426091", "426091048", "story_v_out_426091.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_426091", "426091048", "story_v_out_426091.awb")
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
	Play426091049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 426091049
		arg_215_1.duration_ = 1.47

		local var_215_0 = {
			zh = 1.4,
			ja = 1.466
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
				arg_215_0:Play426091050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0
			local var_218_1 = 0.075

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_2 = arg_215_1:FormatText(StoryNameCfg[1488].name)

				arg_215_1.leftNameTxt_.text = var_218_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_3 = arg_215_1:GetWordFromCfg(426091049)
				local var_218_4 = arg_215_1:FormatText(var_218_3.content)

				arg_215_1.text_.text = var_218_4

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091049", "story_v_out_426091.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091049", "story_v_out_426091.awb") / 1000

					if var_218_8 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_0
					end

					if var_218_3.prefab_name ~= "" and arg_215_1.actors_[var_218_3.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_3.prefab_name].transform, "story_v_out_426091", "426091049", "story_v_out_426091.awb")

						arg_215_1:RecordAudio("426091049", var_218_9)
						arg_215_1:RecordAudio("426091049", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_426091", "426091049", "story_v_out_426091.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_426091", "426091049", "story_v_out_426091.awb")
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
	Play426091050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 426091050
		arg_219_1.duration_ = 5.33

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play426091051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.333333333333333
			local var_222_1 = 1

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				local var_222_2 = "play"
				local var_222_3 = "effect"

				arg_219_1:AudioAction(var_222_2, var_222_3, "se_story_144", "se_story_144_smoke02", "")
			end

			local var_222_4 = manager.ui.mainCamera.transform
			local var_222_5 = 0.333333333333333

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.var_.shakeOldPos = var_222_4.localPosition
			end

			local var_222_6 = 0.3

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_6 then
				local var_222_7 = (arg_219_1.time_ - var_222_5) / 0.066
				local var_222_8, var_222_9 = math.modf(var_222_7)

				var_222_4.localPosition = Vector3.New(var_222_9 * 0.13, var_222_9 * 0.13, var_222_9 * 0.13) + arg_219_1.var_.shakeOldPos
			end

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 then
				var_222_4.localPosition = arg_219_1.var_.shakeOldPos
			end

			local var_222_10 = manager.ui.mainCamera.transform
			local var_222_11 = 0.333333333333333

			if var_222_11 < arg_219_1.time_ and arg_219_1.time_ <= var_222_11 + arg_222_0 then
				local var_222_12 = arg_219_1.var_.effectwuchangdajia1
				local var_222_13
				local var_222_14 = var_222_10

				if not var_222_12 then
					var_222_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), var_222_14)
					var_222_12.name = "wuchangdajia1"
					arg_219_1.var_.effectwuchangdajia1 = var_222_12
				else
					var_222_12.transform:SetParent(var_222_14)
				end

				var_222_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_222_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_222_15 = manager.ui.mainCamera.transform
			local var_222_16 = 2.33333333333333

			if var_222_16 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				local var_222_17 = arg_219_1.var_.effectwuchangdajia1

				if var_222_17 then
					Object.Destroy(var_222_17)

					arg_219_1.var_.effectwuchangdajia1 = nil
				end
			end

			local var_222_18 = 0

			if var_222_18 < arg_219_1.time_ and arg_219_1.time_ <= var_222_18 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			local var_222_19 = 2.46666666666667

			if arg_219_1.time_ >= var_222_18 + var_222_19 and arg_219_1.time_ < var_222_18 + var_222_19 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_20 = 0.333333333333333
			local var_222_21 = 0.85

			if var_222_20 < arg_219_1.time_ and arg_219_1.time_ <= var_222_20 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_22 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_22:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_23 = arg_219_1:GetWordFromCfg(426091050)
				local var_222_24 = arg_219_1:FormatText(var_222_23.content)

				arg_219_1.text_.text = var_222_24

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_25 = 34
				local var_222_26 = utf8.len(var_222_24)
				local var_222_27 = var_222_25 <= 0 and var_222_21 or var_222_21 * (var_222_26 / var_222_25)

				if var_222_27 > 0 and var_222_21 < var_222_27 then
					arg_219_1.talkMaxDuration = var_222_27
					var_222_20 = var_222_20 + 0.3

					if var_222_27 + var_222_20 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_27 + var_222_20
					end
				end

				arg_219_1.text_.text = var_222_24
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_28 = var_222_20 + 0.3
			local var_222_29 = math.max(var_222_21, arg_219_1.talkMaxDuration)

			if var_222_28 <= arg_219_1.time_ and arg_219_1.time_ < var_222_28 + var_222_29 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_28) / var_222_29

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_28 + var_222_29 and arg_219_1.time_ < var_222_28 + var_222_29 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play426091051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 426091051
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play426091052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.875

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_2 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(426091051)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 35
				local var_228_6 = utf8.len(var_228_4)
				local var_228_7 = var_228_5 <= 0 and var_228_1 or var_228_1 * (var_228_6 / var_228_5)

				if var_228_7 > 0 and var_228_1 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_8 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_8 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_8

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_8 and arg_225_1.time_ < var_228_0 + var_228_8 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play426091052 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 426091052
		arg_229_1.duration_ = 10.13

		local var_229_0 = {
			zh = 10.133,
			ja = 9.533
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play426091053(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.75

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[1488].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(426091052)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 30
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091052", "story_v_out_426091.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091052", "story_v_out_426091.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_426091", "426091052", "story_v_out_426091.awb")

						arg_229_1:RecordAudio("426091052", var_232_9)
						arg_229_1:RecordAudio("426091052", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_426091", "426091052", "story_v_out_426091.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_426091", "426091052", "story_v_out_426091.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play426091053 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 426091053
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play426091054(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.775

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(426091053)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 31
				local var_236_5 = utf8.len(var_236_3)
				local var_236_6 = var_236_4 <= 0 and var_236_1 or var_236_1 * (var_236_5 / var_236_4)

				if var_236_6 > 0 and var_236_1 < var_236_6 then
					arg_233_1.talkMaxDuration = var_236_6

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_7 and arg_233_1.time_ < var_236_0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play426091054 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 426091054
		arg_237_1.duration_ = 2.03

		local var_237_0 = {
			zh = 2.033,
			ja = 1.966
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play426091055(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.125

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[1487].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(426091054)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 5
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091054", "story_v_out_426091.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091054", "story_v_out_426091.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_426091", "426091054", "story_v_out_426091.awb")

						arg_237_1:RecordAudio("426091054", var_240_9)
						arg_237_1:RecordAudio("426091054", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_426091", "426091054", "story_v_out_426091.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_426091", "426091054", "story_v_out_426091.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play426091055 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 426091055
		arg_241_1.duration_ = 6.73

		local var_241_0 = {
			zh = 6.733,
			ja = 6.6
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play426091056(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.675

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[1488].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(426091055)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 26
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091055", "story_v_out_426091.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091055", "story_v_out_426091.awb") / 1000

					if var_244_8 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_426091", "426091055", "story_v_out_426091.awb")

						arg_241_1:RecordAudio("426091055", var_244_9)
						arg_241_1:RecordAudio("426091055", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_426091", "426091055", "story_v_out_426091.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_426091", "426091055", "story_v_out_426091.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_10 and arg_241_1.time_ < var_244_0 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play426091056 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 426091056
		arg_245_1.duration_ = 6.13

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play426091057(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.133333333333333
			local var_248_1 = 1

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				local var_248_2 = "play"
				local var_248_3 = "effect"

				arg_245_1:AudioAction(var_248_2, var_248_3, "se_story_139", "se_story_139_metalhit01", "")
			end

			local var_248_4 = arg_245_1.bgs_.SS2602.transform
			local var_248_5 = 0

			if var_248_5 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.var_.moveOldPosSS2602 = var_248_4.localPosition
			end

			local var_248_6 = 2.03333333333333

			if var_248_5 <= arg_245_1.time_ and arg_245_1.time_ < var_248_5 + var_248_6 then
				local var_248_7 = (arg_245_1.time_ - var_248_5) / var_248_6
				local var_248_8 = Vector3.New(0, 1, 9.5)

				var_248_4.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPosSS2602, var_248_8, var_248_7)
			end

			if arg_245_1.time_ >= var_248_5 + var_248_6 and arg_245_1.time_ < var_248_5 + var_248_6 + arg_248_0 then
				var_248_4.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_248_9 = manager.ui.mainCamera.transform
			local var_248_10 = 0.133333333333333

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				local var_248_11 = arg_245_1.var_.effectwuchangdadouqiliu
				local var_248_12
				local var_248_13 = var_248_9

				if not var_248_11 then
					var_248_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), var_248_13)
					var_248_11.name = "wuchangdadouqiliu"
					arg_245_1.var_.effectwuchangdadouqiliu = var_248_11
				else
					var_248_11.transform:SetParent(var_248_13)
				end

				var_248_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_14 = 1.13333333333333
			local var_248_15 = 0.975

			if var_248_14 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_16 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_16:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_17 = arg_245_1:GetWordFromCfg(426091056)
				local var_248_18 = arg_245_1:FormatText(var_248_17.content)

				arg_245_1.text_.text = var_248_18

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_19 = 39
				local var_248_20 = utf8.len(var_248_18)
				local var_248_21 = var_248_19 <= 0 and var_248_15 or var_248_15 * (var_248_20 / var_248_19)

				if var_248_21 > 0 and var_248_15 < var_248_21 then
					arg_245_1.talkMaxDuration = var_248_21
					var_248_14 = var_248_14 + 0.3

					if var_248_21 + var_248_14 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_21 + var_248_14
					end
				end

				arg_245_1.text_.text = var_248_18
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_22 = var_248_14 + 0.3
			local var_248_23 = math.max(var_248_15, arg_245_1.talkMaxDuration)

			if var_248_22 <= arg_245_1.time_ and arg_245_1.time_ < var_248_22 + var_248_23 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_22) / var_248_23

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_22 + var_248_23 and arg_245_1.time_ < var_248_22 + var_248_23 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.03333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play426091057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 426091057
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play426091058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.9

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(426091057)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 36
				local var_254_5 = utf8.len(var_254_3)
				local var_254_6 = var_254_4 <= 0 and var_254_1 or var_254_1 * (var_254_5 / var_254_4)

				if var_254_6 > 0 and var_254_1 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_7 and arg_251_1.time_ < var_254_0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play426091058 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 426091058
		arg_255_1.duration_ = 7.03

		local var_255_0 = {
			zh = 6.166,
			ja = 7.033
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
				arg_255_0:Play426091059(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.55

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[1488].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:GetWordFromCfg(426091058)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 23
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091058", "story_v_out_426091.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091058", "story_v_out_426091.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_out_426091", "426091058", "story_v_out_426091.awb")

						arg_255_1:RecordAudio("426091058", var_258_9)
						arg_255_1:RecordAudio("426091058", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_426091", "426091058", "story_v_out_426091.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_426091", "426091058", "story_v_out_426091.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play426091059 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 426091059
		arg_259_1.duration_ = 3.57

		local var_259_0 = {
			zh = 3.3,
			ja = 3.566
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play426091060(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.2

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[1487].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:GetWordFromCfg(426091059)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 8
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091059", "story_v_out_426091.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091059", "story_v_out_426091.awb") / 1000

					if var_262_8 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_0
					end

					if var_262_3.prefab_name ~= "" and arg_259_1.actors_[var_262_3.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_3.prefab_name].transform, "story_v_out_426091", "426091059", "story_v_out_426091.awb")

						arg_259_1:RecordAudio("426091059", var_262_9)
						arg_259_1:RecordAudio("426091059", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_426091", "426091059", "story_v_out_426091.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_426091", "426091059", "story_v_out_426091.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_10 and arg_259_1.time_ < var_262_0 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play426091060 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 426091060
		arg_263_1.duration_ = 5.03

		local var_263_0 = {
			zh = 5.033,
			ja = 3.6
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play426091061(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.133333333333333
			local var_266_1 = 1

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				local var_266_2 = "play"
				local var_266_3 = "effect"

				arg_263_1:AudioAction(var_266_2, var_266_3, "ui_skip", "ui_bgm_66", "")
			end

			local var_266_4 = 0
			local var_266_5 = 0.3

			if var_266_4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_6 = arg_263_1:FormatText(StoryNameCfg[1488].name)

				arg_263_1.leftNameTxt_.text = var_266_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:GetWordFromCfg(426091060)
				local var_266_8 = arg_263_1:FormatText(var_266_7.content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 13
				local var_266_10 = utf8.len(var_266_8)
				local var_266_11 = var_266_9 <= 0 and var_266_5 or var_266_5 * (var_266_10 / var_266_9)

				if var_266_11 > 0 and var_266_5 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091060", "story_v_out_426091.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091060", "story_v_out_426091.awb") / 1000

					if var_266_12 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_4
					end

					if var_266_7.prefab_name ~= "" and arg_263_1.actors_[var_266_7.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_7.prefab_name].transform, "story_v_out_426091", "426091060", "story_v_out_426091.awb")

						arg_263_1:RecordAudio("426091060", var_266_13)
						arg_263_1:RecordAudio("426091060", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_426091", "426091060", "story_v_out_426091.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_426091", "426091060", "story_v_out_426091.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_14 and arg_263_1.time_ < var_266_4 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play426091061 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 426091061
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play426091062(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.133333333333333
			local var_270_1 = 1

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				local var_270_2 = "play"
				local var_270_3 = "effect"

				arg_267_1:AudioAction(var_270_2, var_270_3, "se_story_150", "se_story_150_metalhit", "")
			end

			local var_270_4 = arg_267_1.bgs_.SS2602.transform
			local var_270_5 = 0

			if var_270_5 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.var_.moveOldPosSS2602 = var_270_4.localPosition
			end

			local var_270_6 = 2.03333333333333

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 then
				local var_270_7 = (arg_267_1.time_ - var_270_5) / var_270_6
				local var_270_8 = Vector3.New(0.97, 1, 8)

				var_270_4.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPosSS2602, var_270_8, var_270_7)
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 then
				var_270_4.localPosition = Vector3.New(0.97, 1, 8)
			end

			local var_270_9 = 0

			if var_270_9 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			local var_270_10 = 2.03333333333333

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_11 = 0
			local var_270_12 = 1.4

			if var_270_11 < arg_267_1.time_ and arg_267_1.time_ <= var_270_11 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_13 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_13:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_14 = arg_267_1:GetWordFromCfg(426091061)
				local var_270_15 = arg_267_1:FormatText(var_270_14.content)

				arg_267_1.text_.text = var_270_15

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_16 = 56
				local var_270_17 = utf8.len(var_270_15)
				local var_270_18 = var_270_16 <= 0 and var_270_12 or var_270_12 * (var_270_17 / var_270_16)

				if var_270_18 > 0 and var_270_12 < var_270_18 then
					arg_267_1.talkMaxDuration = var_270_18
					var_270_11 = var_270_11 + 0.3

					if var_270_18 + var_270_11 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_18 + var_270_11
					end
				end

				arg_267_1.text_.text = var_270_15
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_19 = var_270_11 + 0.3
			local var_270_20 = math.max(var_270_12, arg_267_1.talkMaxDuration)

			if var_270_19 <= arg_267_1.time_ and arg_267_1.time_ < var_270_19 + var_270_20 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_19) / var_270_20

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_19 + var_270_20 and arg_267_1.time_ < var_270_19 + var_270_20 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.03333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0.97, 1, 8),
					easeType = LeanTweenType.easeInOutCirc
				}
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play426091062 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 426091062
		arg_273_1.duration_ = 2.13

		local var_273_0 = {
			zh = 2.133,
			ja = 1.333
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play426091063(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.175

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[1487].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(426091062)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 7
				local var_276_6 = utf8.len(var_276_4)
				local var_276_7 = var_276_5 <= 0 and var_276_1 or var_276_1 * (var_276_6 / var_276_5)

				if var_276_7 > 0 and var_276_1 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091062", "story_v_out_426091.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091062", "story_v_out_426091.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_426091", "426091062", "story_v_out_426091.awb")

						arg_273_1:RecordAudio("426091062", var_276_9)
						arg_273_1:RecordAudio("426091062", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_426091", "426091062", "story_v_out_426091.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_426091", "426091062", "story_v_out_426091.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_10 and arg_273_1.time_ < var_276_0 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play426091063 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 426091063
		arg_277_1.duration_ = 8.5

		local var_277_0 = {
			zh = 8.5,
			ja = 6.033
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play426091064(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.825

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[1488].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:GetWordFromCfg(426091063)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 33
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091063", "story_v_out_426091.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091063", "story_v_out_426091.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_426091", "426091063", "story_v_out_426091.awb")

						arg_277_1:RecordAudio("426091063", var_280_9)
						arg_277_1:RecordAudio("426091063", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_426091", "426091063", "story_v_out_426091.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_426091", "426091063", "story_v_out_426091.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play426091064 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 426091064
		arg_281_1.duration_ = 6.63

		local var_281_0 = {
			zh = 6.033,
			ja = 6.633
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play426091065(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.35

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_2 = arg_281_1:FormatText(StoryNameCfg[1487].name)

				arg_281_1.leftNameTxt_.text = var_284_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:GetWordFromCfg(426091064)
				local var_284_4 = arg_281_1:FormatText(var_284_3.content)

				arg_281_1.text_.text = var_284_4

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 14
				local var_284_6 = utf8.len(var_284_4)
				local var_284_7 = var_284_5 <= 0 and var_284_1 or var_284_1 * (var_284_6 / var_284_5)

				if var_284_7 > 0 and var_284_1 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_4
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091064", "story_v_out_426091.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091064", "story_v_out_426091.awb") / 1000

					if var_284_8 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_0
					end

					if var_284_3.prefab_name ~= "" and arg_281_1.actors_[var_284_3.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_3.prefab_name].transform, "story_v_out_426091", "426091064", "story_v_out_426091.awb")

						arg_281_1:RecordAudio("426091064", var_284_9)
						arg_281_1:RecordAudio("426091064", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_426091", "426091064", "story_v_out_426091.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_426091", "426091064", "story_v_out_426091.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_10 and arg_281_1.time_ < var_284_0 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play426091065 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 426091065
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play426091066(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0
			local var_288_1 = 0.3

			if var_288_0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_0 + arg_288_0 then
				local var_288_2 = "play"
				local var_288_3 = "music"

				arg_285_1:AudioAction(var_288_2, var_288_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_288_4 = ""
				local var_288_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_288_5 ~= "" then
					if arg_285_1.bgmTxt_.text ~= var_288_5 and arg_285_1.bgmTxt_.text ~= "" then
						if arg_285_1.bgmTxt2_.text ~= "" then
							arg_285_1.bgmTxt_.text = arg_285_1.bgmTxt2_.text
						end

						arg_285_1.bgmTxt2_.text = var_288_5

						arg_285_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_285_1.bgmTxt_.text = var_288_5
						arg_285_1.bgmTxt2_.text = var_288_5
					end

					if arg_285_1.bgmTimer then
						arg_285_1.bgmTimer:Stop()

						arg_285_1.bgmTimer = nil
					end

					if arg_285_1.settingData.show_music_name == 1 then
						arg_285_1.musicController:SetSelectedState("show")
						arg_285_1.musicAnimator_:Play("open", 0, 0)

						if arg_285_1.settingData.music_time ~= 0 then
							arg_285_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_285_1.settingData.music_time), function()
								if arg_285_1 == nil or isNil(arg_285_1.bgmTxt_) then
									return
								end

								arg_285_1.musicController:SetSelectedState("hide")
								arg_285_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_288_6 = 0
			local var_288_7 = 0.1

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_8 = arg_285_1:FormatText(StoryNameCfg[7].name)

				arg_285_1.leftNameTxt_.text = var_288_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_9 = arg_285_1:GetWordFromCfg(426091065)
				local var_288_10 = arg_285_1:FormatText(var_288_9.content)

				arg_285_1.text_.text = var_288_10

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_11 = 4
				local var_288_12 = utf8.len(var_288_10)
				local var_288_13 = var_288_11 <= 0 and var_288_7 or var_288_7 * (var_288_12 / var_288_11)

				if var_288_13 > 0 and var_288_7 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_10
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_14 and arg_285_1.time_ < var_288_6 + var_288_14 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play426091066 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 426091066
		arg_290_1.duration_ = 9

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play426091067(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = "J27h"

			if arg_290_1.bgs_[var_293_0] == nil then
				local var_293_1 = Object.Instantiate(arg_290_1.paintGo_)

				var_293_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_293_0)
				var_293_1.name = var_293_0
				var_293_1.transform.parent = arg_290_1.stage_.transform
				var_293_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_290_1.bgs_[var_293_0] = var_293_1
			end

			local var_293_2 = 2

			if var_293_2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				local var_293_3 = manager.ui.mainCamera.transform.localPosition
				local var_293_4 = Vector3.New(0, 0, 10) + Vector3.New(var_293_3.x, var_293_3.y, 0)
				local var_293_5 = arg_290_1.bgs_.J27h

				var_293_5.transform.localPosition = var_293_4
				var_293_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_6 = var_293_5:GetComponent("SpriteRenderer")

				if var_293_6 and var_293_6.sprite then
					local var_293_7 = (var_293_5.transform.localPosition - var_293_3).z
					local var_293_8 = manager.ui.mainCameraCom_
					local var_293_9 = 2 * var_293_7 * Mathf.Tan(var_293_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_293_10 = var_293_9 * var_293_8.aspect
					local var_293_11 = var_293_6.sprite.bounds.size.x
					local var_293_12 = var_293_6.sprite.bounds.size.y
					local var_293_13 = var_293_10 / var_293_11
					local var_293_14 = var_293_9 / var_293_12
					local var_293_15 = var_293_14 < var_293_13 and var_293_13 or var_293_14

					var_293_5.transform.localScale = Vector3.New(var_293_15, var_293_15, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "J27h" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_16 = 4

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			local var_293_17 = 0.3

			if arg_290_1.time_ >= var_293_16 + var_293_17 and arg_290_1.time_ < var_293_16 + var_293_17 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_18 = 0

			if var_293_18 < arg_290_1.time_ and arg_290_1.time_ <= var_293_18 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_19 = 2

			if var_293_18 <= arg_290_1.time_ and arg_290_1.time_ < var_293_18 + var_293_19 then
				local var_293_20 = (arg_290_1.time_ - var_293_18) / var_293_19
				local var_293_21 = Color.New(0, 0, 0)

				var_293_21.a = Mathf.Lerp(0, 1, var_293_20)
				arg_290_1.mask_.color = var_293_21
			end

			if arg_290_1.time_ >= var_293_18 + var_293_19 and arg_290_1.time_ < var_293_18 + var_293_19 + arg_293_0 then
				local var_293_22 = Color.New(0, 0, 0)

				var_293_22.a = 1
				arg_290_1.mask_.color = var_293_22
			end

			local var_293_23 = 2

			if var_293_23 < arg_290_1.time_ and arg_290_1.time_ <= var_293_23 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_24 = 2

			if var_293_23 <= arg_290_1.time_ and arg_290_1.time_ < var_293_23 + var_293_24 then
				local var_293_25 = (arg_290_1.time_ - var_293_23) / var_293_24
				local var_293_26 = Color.New(0, 0, 0)

				var_293_26.a = Mathf.Lerp(1, 0, var_293_25)
				arg_290_1.mask_.color = var_293_26
			end

			if arg_290_1.time_ >= var_293_23 + var_293_24 and arg_290_1.time_ < var_293_23 + var_293_24 + arg_293_0 then
				local var_293_27 = Color.New(0, 0, 0)
				local var_293_28 = 0

				arg_290_1.mask_.enabled = false
				var_293_27.a = var_293_28
				arg_290_1.mask_.color = var_293_27
			end

			local var_293_29 = 2
			local var_293_30 = 1

			if var_293_29 < arg_290_1.time_ and arg_290_1.time_ <= var_293_29 + arg_293_0 then
				local var_293_31 = "stop"
				local var_293_32 = "effect"

				arg_290_1:AudioAction(var_293_31, var_293_32, "se_story_150", "se_story_150_flower_field", "")
			end

			local var_293_33 = 2.3
			local var_293_34 = 1

			if var_293_33 < arg_290_1.time_ and arg_290_1.time_ <= var_293_33 + arg_293_0 then
				local var_293_35 = "play"
				local var_293_36 = "effect"

				arg_290_1:AudioAction(var_293_35, var_293_36, "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			local var_293_37 = manager.ui.mainCamera.transform
			local var_293_38 = 1.8

			if var_293_38 < arg_290_1.time_ and arg_290_1.time_ <= var_293_38 + arg_293_0 then
				local var_293_39 = arg_290_1.var_.effectwuchangdadouqiliu

				if var_293_39 then
					Object.Destroy(var_293_39)

					arg_290_1.var_.effectwuchangdadouqiliu = nil
				end
			end

			local var_293_40 = 2

			arg_290_1.isInRecall_ = true

			if var_293_40 < arg_290_1.time_ and arg_290_1.time_ <= var_293_40 + arg_293_0 then
				arg_290_1.screenFilterGo_:SetActive(true)

				arg_290_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_290_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_290_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_293_2, iter_293_3 in pairs(arg_290_1.actors_) do
					local var_293_41 = iter_293_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_293_4, iter_293_5 in ipairs(var_293_41) do
						if iter_293_5.color.r > 0.51 then
							iter_293_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_293_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_293_42 = 0.299999999999999

			if var_293_40 <= arg_290_1.time_ and arg_290_1.time_ < var_293_40 + var_293_42 then
				local var_293_43 = (arg_290_1.time_ - var_293_40) / var_293_42

				arg_290_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_293_43)
			end

			if arg_290_1.time_ >= var_293_40 + var_293_42 and arg_290_1.time_ < var_293_40 + var_293_42 + arg_293_0 then
				arg_290_1.screenFilterEffect_.weight = 1
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_44 = 4
			local var_293_45 = 0.95

			if var_293_44 < arg_290_1.time_ and arg_290_1.time_ <= var_293_44 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_46 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_46:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_47 = arg_290_1:GetWordFromCfg(426091066)
				local var_293_48 = arg_290_1:FormatText(var_293_47.content)

				arg_290_1.text_.text = var_293_48

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_49 = 38
				local var_293_50 = utf8.len(var_293_48)
				local var_293_51 = var_293_49 <= 0 and var_293_45 or var_293_45 * (var_293_50 / var_293_49)

				if var_293_51 > 0 and var_293_45 < var_293_51 then
					arg_290_1.talkMaxDuration = var_293_51
					var_293_44 = var_293_44 + 0.3

					if var_293_51 + var_293_44 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_51 + var_293_44
					end
				end

				arg_290_1.text_.text = var_293_48
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_52 = var_293_44 + 0.3
			local var_293_53 = math.max(var_293_45, arg_290_1.talkMaxDuration)

			if var_293_52 <= arg_290_1.time_ and arg_290_1.time_ < var_293_52 + var_293_53 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_52) / var_293_53

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_52 + var_293_53 and arg_290_1.time_ < var_293_52 + var_293_53 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play426091067 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 426091067
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play426091068(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.3

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				local var_299_2 = "play"
				local var_299_3 = "music"

				arg_296_1:AudioAction(var_299_2, var_299_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_299_4 = ""
				local var_299_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_299_5 ~= "" then
					if arg_296_1.bgmTxt_.text ~= var_299_5 and arg_296_1.bgmTxt_.text ~= "" then
						if arg_296_1.bgmTxt2_.text ~= "" then
							arg_296_1.bgmTxt_.text = arg_296_1.bgmTxt2_.text
						end

						arg_296_1.bgmTxt2_.text = var_299_5

						arg_296_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_296_1.bgmTxt_.text = var_299_5
						arg_296_1.bgmTxt2_.text = var_299_5
					end

					if arg_296_1.bgmTimer then
						arg_296_1.bgmTimer:Stop()

						arg_296_1.bgmTimer = nil
					end

					if arg_296_1.settingData.show_music_name == 1 then
						arg_296_1.musicController:SetSelectedState("show")
						arg_296_1.musicAnimator_:Play("open", 0, 0)

						if arg_296_1.settingData.music_time ~= 0 then
							arg_296_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_296_1.settingData.music_time), function()
								if arg_296_1 == nil or isNil(arg_296_1.bgmTxt_) then
									return
								end

								arg_296_1.musicController:SetSelectedState("hide")
								arg_296_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_299_6 = 0.433333333333333
			local var_299_7 = 1

			if var_299_6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				local var_299_8 = "play"
				local var_299_9 = "music"

				arg_296_1:AudioAction(var_299_8, var_299_9, "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_299_10 = ""
				local var_299_11 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

				if var_299_11 ~= "" then
					if arg_296_1.bgmTxt_.text ~= var_299_11 and arg_296_1.bgmTxt_.text ~= "" then
						if arg_296_1.bgmTxt2_.text ~= "" then
							arg_296_1.bgmTxt_.text = arg_296_1.bgmTxt2_.text
						end

						arg_296_1.bgmTxt2_.text = var_299_11

						arg_296_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_296_1.bgmTxt_.text = var_299_11
						arg_296_1.bgmTxt2_.text = var_299_11
					end

					if arg_296_1.bgmTimer then
						arg_296_1.bgmTimer:Stop()

						arg_296_1.bgmTimer = nil
					end

					if arg_296_1.settingData.show_music_name == 1 then
						arg_296_1.musicController:SetSelectedState("show")
						arg_296_1.musicAnimator_:Play("open", 0, 0)

						if arg_296_1.settingData.music_time ~= 0 then
							arg_296_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_296_1.settingData.music_time), function()
								if arg_296_1 == nil or isNil(arg_296_1.bgmTxt_) then
									return
								end

								arg_296_1.musicController:SetSelectedState("hide")
								arg_296_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_299_12 = 0
			local var_299_13 = 0.2

			if var_299_12 < arg_296_1.time_ and arg_296_1.time_ <= var_299_12 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_14 = arg_296_1:FormatText(StoryNameCfg[7].name)

				arg_296_1.leftNameTxt_.text = var_299_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_296_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_299_15 = arg_296_1:GetWordFromCfg(426091067)
				local var_299_16 = arg_296_1:FormatText(var_299_15.content)

				arg_296_1.text_.text = var_299_16

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_17 = 8
				local var_299_18 = utf8.len(var_299_16)
				local var_299_19 = var_299_17 <= 0 and var_299_13 or var_299_13 * (var_299_18 / var_299_17)

				if var_299_19 > 0 and var_299_13 < var_299_19 then
					arg_296_1.talkMaxDuration = var_299_19

					if var_299_19 + var_299_12 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_19 + var_299_12
					end
				end

				arg_296_1.text_.text = var_299_16
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_20 = math.max(var_299_13, arg_296_1.talkMaxDuration)

			if var_299_12 <= arg_296_1.time_ and arg_296_1.time_ < var_299_12 + var_299_20 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_12) / var_299_20

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_12 + var_299_20 and arg_296_1.time_ < var_299_12 + var_299_20 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play426091068 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 426091068
		arg_302_1.duration_ = 12.9

		local var_302_0 = {
			zh = 9.566,
			ja = 12.9
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
				arg_302_0:Play426091069(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["1054ui_story"].transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1.var_.moveOldPos1054ui_story = var_305_0.localPosition

				local var_305_2 = GameObjectTools.GetOrAddComponent(var_305_0.gameObject, typeof(DynamicBoneHelper))

				if var_305_2 then
					var_305_2:EnableDynamicBone(false)
				end
			end

			local var_305_3 = 0.001

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_3 then
				local var_305_4 = (arg_302_1.time_ - var_305_1) / var_305_3
				local var_305_5 = Vector3.New(0, -0.985, -6)

				var_305_0.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1054ui_story, var_305_5, var_305_4)

				local var_305_6 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_6.x, var_305_6.y, var_305_6.z)

				local var_305_7 = var_305_0.localEulerAngles

				var_305_7.z = 0
				var_305_7.x = 0
				var_305_0.localEulerAngles = var_305_7
			end

			if arg_302_1.time_ >= var_305_1 + var_305_3 and arg_302_1.time_ < var_305_1 + var_305_3 + arg_305_0 then
				var_305_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_305_8 = manager.ui.mainCamera.transform.position - var_305_0.position

				var_305_0.forward = Vector3.New(var_305_8.x, var_305_8.y, var_305_8.z)

				local var_305_9 = var_305_0.localEulerAngles

				var_305_9.z = 0
				var_305_9.x = 0
				var_305_0.localEulerAngles = var_305_9

				local var_305_10 = GameObjectTools.GetOrAddComponent(var_305_0.gameObject, typeof(DynamicBoneHelper))

				if var_305_10 then
					var_305_10:EnableDynamicBone(true)
				end
			end

			local var_305_11 = arg_302_1.actors_["1054ui_story"]
			local var_305_12 = 0

			if var_305_12 < arg_302_1.time_ and arg_302_1.time_ <= var_305_12 + arg_305_0 and not isNil(var_305_11) and arg_302_1.var_.characterEffect1054ui_story == nil then
				arg_302_1.var_.characterEffect1054ui_story = var_305_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_13 = 0.200000002980232

			if var_305_12 <= arg_302_1.time_ and arg_302_1.time_ < var_305_12 + var_305_13 and not isNil(var_305_11) then
				local var_305_14 = (arg_302_1.time_ - var_305_12) / var_305_13

				if arg_302_1.var_.characterEffect1054ui_story and not isNil(var_305_11) then
					arg_302_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_12 + var_305_13 and arg_302_1.time_ < var_305_12 + var_305_13 + arg_305_0 and not isNil(var_305_11) and arg_302_1.var_.characterEffect1054ui_story then
				arg_302_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_305_15 = 0

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu")
			end

			local var_305_16 = 0

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_305_17 = 0
			local var_305_18 = 0.775

			if var_305_17 < arg_302_1.time_ and arg_302_1.time_ <= var_305_17 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_19 = arg_302_1:FormatText(StoryNameCfg[1487].name)

				arg_302_1.leftNameTxt_.text = var_305_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_20 = arg_302_1:GetWordFromCfg(426091068)
				local var_305_21 = arg_302_1:FormatText(var_305_20.content)

				arg_302_1.text_.text = var_305_21

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_22 = 31
				local var_305_23 = utf8.len(var_305_21)
				local var_305_24 = var_305_22 <= 0 and var_305_18 or var_305_18 * (var_305_23 / var_305_22)

				if var_305_24 > 0 and var_305_18 < var_305_24 then
					arg_302_1.talkMaxDuration = var_305_24

					if var_305_24 + var_305_17 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_24 + var_305_17
					end
				end

				arg_302_1.text_.text = var_305_21
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091068", "story_v_out_426091.awb") ~= 0 then
					local var_305_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091068", "story_v_out_426091.awb") / 1000

					if var_305_25 + var_305_17 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_25 + var_305_17
					end

					if var_305_20.prefab_name ~= "" and arg_302_1.actors_[var_305_20.prefab_name] ~= nil then
						local var_305_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_20.prefab_name].transform, "story_v_out_426091", "426091068", "story_v_out_426091.awb")

						arg_302_1:RecordAudio("426091068", var_305_26)
						arg_302_1:RecordAudio("426091068", var_305_26)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_426091", "426091068", "story_v_out_426091.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_426091", "426091068", "story_v_out_426091.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_27 = math.max(var_305_18, arg_302_1.talkMaxDuration)

			if var_305_17 <= arg_302_1.time_ and arg_302_1.time_ < var_305_17 + var_305_27 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_17) / var_305_27

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_17 + var_305_27 and arg_302_1.time_ < var_305_17 + var_305_27 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091069 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 426091069
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play426091070(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1054ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1054ui_story == nil then
				arg_306_1.var_.characterEffect1054ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1054ui_story and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1054ui_story.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1054ui_story then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1054ui_story.fillRatio = var_309_5
			end

			local var_309_6 = 0
			local var_309_7 = 0.475

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_8 = arg_306_1:FormatText(StoryNameCfg[7].name)

				arg_306_1.leftNameTxt_.text = var_309_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_306_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_309_9 = arg_306_1:GetWordFromCfg(426091069)
				local var_309_10 = arg_306_1:FormatText(var_309_9.content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 19
				local var_309_12 = utf8.len(var_309_10)
				local var_309_13 = var_309_11 <= 0 and var_309_7 or var_309_7 * (var_309_12 / var_309_11)

				if var_309_13 > 0 and var_309_7 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_14 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_14 and arg_306_1.time_ < var_309_6 + var_309_14 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play426091070 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 426091070
		arg_310_1.duration_ = 6.57

		local var_310_0 = {
			zh = 6.133,
			ja = 6.566
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
				arg_310_0:Play426091071(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1054ui_story"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1054ui_story == nil then
				arg_310_1.var_.characterEffect1054ui_story = var_313_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.characterEffect1054ui_story and not isNil(var_313_0) then
					arg_310_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.characterEffect1054ui_story then
				arg_310_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_313_4 = 0
			local var_313_5 = 0.45

			if var_313_4 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_6 = arg_310_1:FormatText(StoryNameCfg[1487].name)

				arg_310_1.leftNameTxt_.text = var_313_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_7 = arg_310_1:GetWordFromCfg(426091070)
				local var_313_8 = arg_310_1:FormatText(var_313_7.content)

				arg_310_1.text_.text = var_313_8

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 18
				local var_313_10 = utf8.len(var_313_8)
				local var_313_11 = var_313_9 <= 0 and var_313_5 or var_313_5 * (var_313_10 / var_313_9)

				if var_313_11 > 0 and var_313_5 < var_313_11 then
					arg_310_1.talkMaxDuration = var_313_11

					if var_313_11 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_4
					end
				end

				arg_310_1.text_.text = var_313_8
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091070", "story_v_out_426091.awb") ~= 0 then
					local var_313_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091070", "story_v_out_426091.awb") / 1000

					if var_313_12 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_12 + var_313_4
					end

					if var_313_7.prefab_name ~= "" and arg_310_1.actors_[var_313_7.prefab_name] ~= nil then
						local var_313_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_7.prefab_name].transform, "story_v_out_426091", "426091070", "story_v_out_426091.awb")

						arg_310_1:RecordAudio("426091070", var_313_13)
						arg_310_1:RecordAudio("426091070", var_313_13)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_426091", "426091070", "story_v_out_426091.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_426091", "426091070", "story_v_out_426091.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_14 = math.max(var_313_5, arg_310_1.talkMaxDuration)

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_14 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_4) / var_313_14

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_4 + var_313_14 and arg_310_1.time_ < var_313_4 + var_313_14 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play426091071 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 426091071
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play426091072(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1054ui_story"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1054ui_story == nil then
				arg_314_1.var_.characterEffect1054ui_story = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1054ui_story and not isNil(var_317_0) then
					local var_317_4 = Mathf.Lerp(0, 0.5, var_317_3)

					arg_314_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1054ui_story.fillRatio = var_317_4
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1054ui_story then
				local var_317_5 = 0.5

				arg_314_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1054ui_story.fillRatio = var_317_5
			end

			local var_317_6 = 0
			local var_317_7 = 0.925

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_8 = arg_314_1:FormatText(StoryNameCfg[7].name)

				arg_314_1.leftNameTxt_.text = var_317_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_314_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_317_9 = arg_314_1:GetWordFromCfg(426091071)
				local var_317_10 = arg_314_1:FormatText(var_317_9.content)

				arg_314_1.text_.text = var_317_10

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_11 = 37
				local var_317_12 = utf8.len(var_317_10)
				local var_317_13 = var_317_11 <= 0 and var_317_7 or var_317_7 * (var_317_12 / var_317_11)

				if var_317_13 > 0 and var_317_7 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_6
					end
				end

				arg_314_1.text_.text = var_317_10
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_14 = math.max(var_317_7, arg_314_1.talkMaxDuration)

			if var_317_6 <= arg_314_1.time_ and arg_314_1.time_ < var_317_6 + var_317_14 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_6) / var_317_14

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_6 + var_317_14 and arg_314_1.time_ < var_317_6 + var_317_14 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play426091072 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 426091072
		arg_318_1.duration_ = 3.87

		local var_318_0 = {
			zh = 2.533,
			ja = 3.866
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
				arg_318_0:Play426091073(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1054ui_story"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos1054ui_story = var_321_0.localPosition

				local var_321_2 = GameObjectTools.GetOrAddComponent(var_321_0.gameObject, typeof(DynamicBoneHelper))

				if var_321_2 then
					var_321_2:EnableDynamicBone(false)
				end
			end

			local var_321_3 = 0.001

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_3 then
				local var_321_4 = (arg_318_1.time_ - var_321_1) / var_321_3
				local var_321_5 = Vector3.New(0, -0.985, -6)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1054ui_story, var_321_5, var_321_4)

				local var_321_6 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_6.x, var_321_6.y, var_321_6.z)

				local var_321_7 = var_321_0.localEulerAngles

				var_321_7.z = 0
				var_321_7.x = 0
				var_321_0.localEulerAngles = var_321_7
			end

			if arg_318_1.time_ >= var_321_1 + var_321_3 and arg_318_1.time_ < var_321_1 + var_321_3 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_321_8 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_8.x, var_321_8.y, var_321_8.z)

				local var_321_9 = var_321_0.localEulerAngles

				var_321_9.z = 0
				var_321_9.x = 0
				var_321_0.localEulerAngles = var_321_9

				local var_321_10 = GameObjectTools.GetOrAddComponent(var_321_0.gameObject, typeof(DynamicBoneHelper))

				if var_321_10 then
					var_321_10:EnableDynamicBone(true)
				end
			end

			local var_321_11 = arg_318_1.actors_["1054ui_story"]
			local var_321_12 = 0

			if var_321_12 < arg_318_1.time_ and arg_318_1.time_ <= var_321_12 + arg_321_0 and not isNil(var_321_11) and arg_318_1.var_.characterEffect1054ui_story == nil then
				arg_318_1.var_.characterEffect1054ui_story = var_321_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_13 = 0.200000002980232

			if var_321_12 <= arg_318_1.time_ and arg_318_1.time_ < var_321_12 + var_321_13 and not isNil(var_321_11) then
				local var_321_14 = (arg_318_1.time_ - var_321_12) / var_321_13

				if arg_318_1.var_.characterEffect1054ui_story and not isNil(var_321_11) then
					arg_318_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= var_321_12 + var_321_13 and arg_318_1.time_ < var_321_12 + var_321_13 + arg_321_0 and not isNil(var_321_11) and arg_318_1.var_.characterEffect1054ui_story then
				arg_318_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_321_15 = 0

			if var_321_15 < arg_318_1.time_ and arg_318_1.time_ <= var_321_15 + arg_321_0 then
				arg_318_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_321_16 = 0

			if var_321_16 < arg_318_1.time_ and arg_318_1.time_ <= var_321_16 + arg_321_0 then
				arg_318_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_321_17 = 0
			local var_321_18 = 0.15

			if var_321_17 < arg_318_1.time_ and arg_318_1.time_ <= var_321_17 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_19 = arg_318_1:FormatText(StoryNameCfg[1487].name)

				arg_318_1.leftNameTxt_.text = var_321_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_20 = arg_318_1:GetWordFromCfg(426091072)
				local var_321_21 = arg_318_1:FormatText(var_321_20.content)

				arg_318_1.text_.text = var_321_21

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_22 = 6
				local var_321_23 = utf8.len(var_321_21)
				local var_321_24 = var_321_22 <= 0 and var_321_18 or var_321_18 * (var_321_23 / var_321_22)

				if var_321_24 > 0 and var_321_18 < var_321_24 then
					arg_318_1.talkMaxDuration = var_321_24

					if var_321_24 + var_321_17 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_24 + var_321_17
					end
				end

				arg_318_1.text_.text = var_321_21
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091072", "story_v_out_426091.awb") ~= 0 then
					local var_321_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091072", "story_v_out_426091.awb") / 1000

					if var_321_25 + var_321_17 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_25 + var_321_17
					end

					if var_321_20.prefab_name ~= "" and arg_318_1.actors_[var_321_20.prefab_name] ~= nil then
						local var_321_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_20.prefab_name].transform, "story_v_out_426091", "426091072", "story_v_out_426091.awb")

						arg_318_1:RecordAudio("426091072", var_321_26)
						arg_318_1:RecordAudio("426091072", var_321_26)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_426091", "426091072", "story_v_out_426091.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_426091", "426091072", "story_v_out_426091.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_27 = math.max(var_321_18, arg_318_1.talkMaxDuration)

			if var_321_17 <= arg_318_1.time_ and arg_318_1.time_ < var_321_17 + var_321_27 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_17) / var_321_27

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_17 + var_321_27 and arg_318_1.time_ < var_321_17 + var_321_27 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091073 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 426091073
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play426091074(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["1054ui_story"].transform
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.var_.moveOldPos1054ui_story = var_325_0.localPosition

				local var_325_2 = GameObjectTools.GetOrAddComponent(var_325_0.gameObject, typeof(DynamicBoneHelper))

				if var_325_2 then
					var_325_2:EnableDynamicBone(false)
				end
			end

			local var_325_3 = 0.001

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_3 then
				local var_325_4 = (arg_322_1.time_ - var_325_1) / var_325_3
				local var_325_5 = Vector3.New(0, 100, 0)

				var_325_0.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1054ui_story, var_325_5, var_325_4)

				local var_325_6 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_6.x, var_325_6.y, var_325_6.z)

				local var_325_7 = var_325_0.localEulerAngles

				var_325_7.z = 0
				var_325_7.x = 0
				var_325_0.localEulerAngles = var_325_7
			end

			if arg_322_1.time_ >= var_325_1 + var_325_3 and arg_322_1.time_ < var_325_1 + var_325_3 + arg_325_0 then
				var_325_0.localPosition = Vector3.New(0, 100, 0)

				local var_325_8 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_8.x, var_325_8.y, var_325_8.z)

				local var_325_9 = var_325_0.localEulerAngles

				var_325_9.z = 0
				var_325_9.x = 0
				var_325_0.localEulerAngles = var_325_9

				local var_325_10 = GameObjectTools.GetOrAddComponent(var_325_0.gameObject, typeof(DynamicBoneHelper))

				if var_325_10 then
					var_325_10:EnableDynamicBone(true)
				end
			end

			local var_325_11 = arg_322_1.actors_["1054ui_story"]
			local var_325_12 = 0

			if var_325_12 < arg_322_1.time_ and arg_322_1.time_ <= var_325_12 + arg_325_0 and not isNil(var_325_11) and arg_322_1.var_.characterEffect1054ui_story == nil then
				arg_322_1.var_.characterEffect1054ui_story = var_325_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_13 = 0.200000002980232

			if var_325_12 <= arg_322_1.time_ and arg_322_1.time_ < var_325_12 + var_325_13 and not isNil(var_325_11) then
				local var_325_14 = (arg_322_1.time_ - var_325_12) / var_325_13

				if arg_322_1.var_.characterEffect1054ui_story and not isNil(var_325_11) then
					local var_325_15 = Mathf.Lerp(0, 0.5, var_325_14)

					arg_322_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1054ui_story.fillRatio = var_325_15
				end
			end

			if arg_322_1.time_ >= var_325_12 + var_325_13 and arg_322_1.time_ < var_325_12 + var_325_13 + arg_325_0 and not isNil(var_325_11) and arg_322_1.var_.characterEffect1054ui_story then
				local var_325_16 = 0.5

				arg_322_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1054ui_story.fillRatio = var_325_16
			end

			local var_325_17 = 0
			local var_325_18 = 0.575

			if var_325_17 < arg_322_1.time_ and arg_322_1.time_ <= var_325_17 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_19 = arg_322_1:GetWordFromCfg(426091073)
				local var_325_20 = arg_322_1:FormatText(var_325_19.content)

				arg_322_1.text_.text = var_325_20

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_21 = 23
				local var_325_22 = utf8.len(var_325_20)
				local var_325_23 = var_325_21 <= 0 and var_325_18 or var_325_18 * (var_325_22 / var_325_21)

				if var_325_23 > 0 and var_325_18 < var_325_23 then
					arg_322_1.talkMaxDuration = var_325_23

					if var_325_23 + var_325_17 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_23 + var_325_17
					end
				end

				arg_322_1.text_.text = var_325_20
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_24 = math.max(var_325_18, arg_322_1.talkMaxDuration)

			if var_325_17 <= arg_322_1.time_ and arg_322_1.time_ < var_325_17 + var_325_24 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_17) / var_325_24

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_17 + var_325_24 and arg_322_1.time_ < var_325_17 + var_325_24 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play426091074 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 426091074
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play426091075(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 1

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_2 = arg_326_1:GetWordFromCfg(426091074)
				local var_329_3 = arg_326_1:FormatText(var_329_2.content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 40
				local var_329_5 = utf8.len(var_329_3)
				local var_329_6 = var_329_4 <= 0 and var_329_1 or var_329_1 * (var_329_5 / var_329_4)

				if var_329_6 > 0 and var_329_1 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_7 and arg_326_1.time_ < var_329_0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play426091075 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 426091075
		arg_330_1.duration_ = 9.97

		local var_330_0 = {
			zh = 8.033,
			ja = 9.966
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
				arg_330_0:Play426091076(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1054ui_story"].transform
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.var_.moveOldPos1054ui_story = var_333_0.localPosition

				local var_333_2 = GameObjectTools.GetOrAddComponent(var_333_0.gameObject, typeof(DynamicBoneHelper))

				if var_333_2 then
					var_333_2:EnableDynamicBone(false)
				end
			end

			local var_333_3 = 0.001

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_3 then
				local var_333_4 = (arg_330_1.time_ - var_333_1) / var_333_3
				local var_333_5 = Vector3.New(0, -0.985, -6)

				var_333_0.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1054ui_story, var_333_5, var_333_4)

				local var_333_6 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_6.x, var_333_6.y, var_333_6.z)

				local var_333_7 = var_333_0.localEulerAngles

				var_333_7.z = 0
				var_333_7.x = 0
				var_333_0.localEulerAngles = var_333_7
			end

			if arg_330_1.time_ >= var_333_1 + var_333_3 and arg_330_1.time_ < var_333_1 + var_333_3 + arg_333_0 then
				var_333_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_333_8 = manager.ui.mainCamera.transform.position - var_333_0.position

				var_333_0.forward = Vector3.New(var_333_8.x, var_333_8.y, var_333_8.z)

				local var_333_9 = var_333_0.localEulerAngles

				var_333_9.z = 0
				var_333_9.x = 0
				var_333_0.localEulerAngles = var_333_9

				local var_333_10 = GameObjectTools.GetOrAddComponent(var_333_0.gameObject, typeof(DynamicBoneHelper))

				if var_333_10 then
					var_333_10:EnableDynamicBone(true)
				end
			end

			local var_333_11 = arg_330_1.actors_["1054ui_story"]
			local var_333_12 = 0

			if var_333_12 < arg_330_1.time_ and arg_330_1.time_ <= var_333_12 + arg_333_0 and not isNil(var_333_11) and arg_330_1.var_.characterEffect1054ui_story == nil then
				arg_330_1.var_.characterEffect1054ui_story = var_333_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_13 = 0.200000002980232

			if var_333_12 <= arg_330_1.time_ and arg_330_1.time_ < var_333_12 + var_333_13 and not isNil(var_333_11) then
				local var_333_14 = (arg_330_1.time_ - var_333_12) / var_333_13

				if arg_330_1.var_.characterEffect1054ui_story and not isNil(var_333_11) then
					arg_330_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= var_333_12 + var_333_13 and arg_330_1.time_ < var_333_12 + var_333_13 + arg_333_0 and not isNil(var_333_11) and arg_330_1.var_.characterEffect1054ui_story then
				arg_330_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_333_15 = 0

			if var_333_15 < arg_330_1.time_ and arg_330_1.time_ <= var_333_15 + arg_333_0 then
				arg_330_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_333_16 = 0
			local var_333_17 = 0.65

			if var_333_16 < arg_330_1.time_ and arg_330_1.time_ <= var_333_16 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_18 = arg_330_1:FormatText(StoryNameCfg[1487].name)

				arg_330_1.leftNameTxt_.text = var_333_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_19 = arg_330_1:GetWordFromCfg(426091075)
				local var_333_20 = arg_330_1:FormatText(var_333_19.content)

				arg_330_1.text_.text = var_333_20

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_21 = 26
				local var_333_22 = utf8.len(var_333_20)
				local var_333_23 = var_333_21 <= 0 and var_333_17 or var_333_17 * (var_333_22 / var_333_21)

				if var_333_23 > 0 and var_333_17 < var_333_23 then
					arg_330_1.talkMaxDuration = var_333_23

					if var_333_23 + var_333_16 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_23 + var_333_16
					end
				end

				arg_330_1.text_.text = var_333_20
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091075", "story_v_out_426091.awb") ~= 0 then
					local var_333_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091075", "story_v_out_426091.awb") / 1000

					if var_333_24 + var_333_16 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_24 + var_333_16
					end

					if var_333_19.prefab_name ~= "" and arg_330_1.actors_[var_333_19.prefab_name] ~= nil then
						local var_333_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_19.prefab_name].transform, "story_v_out_426091", "426091075", "story_v_out_426091.awb")

						arg_330_1:RecordAudio("426091075", var_333_25)
						arg_330_1:RecordAudio("426091075", var_333_25)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_426091", "426091075", "story_v_out_426091.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_426091", "426091075", "story_v_out_426091.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_26 = math.max(var_333_17, arg_330_1.talkMaxDuration)

			if var_333_16 <= arg_330_1.time_ and arg_330_1.time_ < var_333_16 + var_333_26 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_16) / var_333_26

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_16 + var_333_26 and arg_330_1.time_ < var_333_16 + var_333_26 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play426091076 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 426091076
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play426091077(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1054ui_story"]
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1054ui_story == nil then
				arg_334_1.var_.characterEffect1054ui_story = var_337_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_2 and not isNil(var_337_0) then
				local var_337_3 = (arg_334_1.time_ - var_337_1) / var_337_2

				if arg_334_1.var_.characterEffect1054ui_story and not isNil(var_337_0) then
					local var_337_4 = Mathf.Lerp(0, 0.5, var_337_3)

					arg_334_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1054ui_story.fillRatio = var_337_4
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_2 and arg_334_1.time_ < var_337_1 + var_337_2 + arg_337_0 and not isNil(var_337_0) and arg_334_1.var_.characterEffect1054ui_story then
				local var_337_5 = 0.5

				arg_334_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1054ui_story.fillRatio = var_337_5
			end

			local var_337_6 = 0
			local var_337_7 = 0.625

			if var_337_6 < arg_334_1.time_ and arg_334_1.time_ <= var_337_6 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_8 = arg_334_1:FormatText(StoryNameCfg[7].name)

				arg_334_1.leftNameTxt_.text = var_337_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_334_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_337_9 = arg_334_1:GetWordFromCfg(426091076)
				local var_337_10 = arg_334_1:FormatText(var_337_9.content)

				arg_334_1.text_.text = var_337_10

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_11 = 25
				local var_337_12 = utf8.len(var_337_10)
				local var_337_13 = var_337_11 <= 0 and var_337_7 or var_337_7 * (var_337_12 / var_337_11)

				if var_337_13 > 0 and var_337_7 < var_337_13 then
					arg_334_1.talkMaxDuration = var_337_13

					if var_337_13 + var_337_6 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_13 + var_337_6
					end
				end

				arg_334_1.text_.text = var_337_10
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_14 = math.max(var_337_7, arg_334_1.talkMaxDuration)

			if var_337_6 <= arg_334_1.time_ and arg_334_1.time_ < var_337_6 + var_337_14 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_6) / var_337_14

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_6 + var_337_14 and arg_334_1.time_ < var_337_6 + var_337_14 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play426091077 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 426091077
		arg_338_1.duration_ = 6.1

		local var_338_0 = {
			zh = 5.8,
			ja = 6.1
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
				arg_338_0:Play426091078(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1054ui_story"].transform
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.var_.moveOldPos1054ui_story = var_341_0.localPosition

				local var_341_2 = GameObjectTools.GetOrAddComponent(var_341_0.gameObject, typeof(DynamicBoneHelper))

				if var_341_2 then
					var_341_2:EnableDynamicBone(false)
				end
			end

			local var_341_3 = 0.001

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_3 then
				local var_341_4 = (arg_338_1.time_ - var_341_1) / var_341_3
				local var_341_5 = Vector3.New(0, -0.985, -6)

				var_341_0.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1054ui_story, var_341_5, var_341_4)

				local var_341_6 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_6.x, var_341_6.y, var_341_6.z)

				local var_341_7 = var_341_0.localEulerAngles

				var_341_7.z = 0
				var_341_7.x = 0
				var_341_0.localEulerAngles = var_341_7
			end

			if arg_338_1.time_ >= var_341_1 + var_341_3 and arg_338_1.time_ < var_341_1 + var_341_3 + arg_341_0 then
				var_341_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_341_8 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_8.x, var_341_8.y, var_341_8.z)

				local var_341_9 = var_341_0.localEulerAngles

				var_341_9.z = 0
				var_341_9.x = 0
				var_341_0.localEulerAngles = var_341_9

				local var_341_10 = GameObjectTools.GetOrAddComponent(var_341_0.gameObject, typeof(DynamicBoneHelper))

				if var_341_10 then
					var_341_10:EnableDynamicBone(true)
				end
			end

			local var_341_11 = arg_338_1.actors_["1054ui_story"]
			local var_341_12 = 0

			if var_341_12 < arg_338_1.time_ and arg_338_1.time_ <= var_341_12 + arg_341_0 and not isNil(var_341_11) and arg_338_1.var_.characterEffect1054ui_story == nil then
				arg_338_1.var_.characterEffect1054ui_story = var_341_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_13 = 0.200000002980232

			if var_341_12 <= arg_338_1.time_ and arg_338_1.time_ < var_341_12 + var_341_13 and not isNil(var_341_11) then
				local var_341_14 = (arg_338_1.time_ - var_341_12) / var_341_13

				if arg_338_1.var_.characterEffect1054ui_story and not isNil(var_341_11) then
					arg_338_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_12 + var_341_13 and arg_338_1.time_ < var_341_12 + var_341_13 + arg_341_0 and not isNil(var_341_11) and arg_338_1.var_.characterEffect1054ui_story then
				arg_338_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_341_15 = 0

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_341_16 = 0
			local var_341_17 = 0.45

			if var_341_16 < arg_338_1.time_ and arg_338_1.time_ <= var_341_16 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_18 = arg_338_1:FormatText(StoryNameCfg[1487].name)

				arg_338_1.leftNameTxt_.text = var_341_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_19 = arg_338_1:GetWordFromCfg(426091077)
				local var_341_20 = arg_338_1:FormatText(var_341_19.content)

				arg_338_1.text_.text = var_341_20

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_21 = 18
				local var_341_22 = utf8.len(var_341_20)
				local var_341_23 = var_341_21 <= 0 and var_341_17 or var_341_17 * (var_341_22 / var_341_21)

				if var_341_23 > 0 and var_341_17 < var_341_23 then
					arg_338_1.talkMaxDuration = var_341_23

					if var_341_23 + var_341_16 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_23 + var_341_16
					end
				end

				arg_338_1.text_.text = var_341_20
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091077", "story_v_out_426091.awb") ~= 0 then
					local var_341_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091077", "story_v_out_426091.awb") / 1000

					if var_341_24 + var_341_16 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_24 + var_341_16
					end

					if var_341_19.prefab_name ~= "" and arg_338_1.actors_[var_341_19.prefab_name] ~= nil then
						local var_341_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_19.prefab_name].transform, "story_v_out_426091", "426091077", "story_v_out_426091.awb")

						arg_338_1:RecordAudio("426091077", var_341_25)
						arg_338_1:RecordAudio("426091077", var_341_25)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_426091", "426091077", "story_v_out_426091.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_426091", "426091077", "story_v_out_426091.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_26 = math.max(var_341_17, arg_338_1.talkMaxDuration)

			if var_341_16 <= arg_338_1.time_ and arg_338_1.time_ < var_341_16 + var_341_26 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_16) / var_341_26

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_16 + var_341_26 and arg_338_1.time_ < var_341_16 + var_341_26 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091078 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 426091078
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play426091079(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1054ui_story"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1054ui_story == nil then
				arg_342_1.var_.characterEffect1054ui_story = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1054ui_story and not isNil(var_345_0) then
					local var_345_4 = Mathf.Lerp(0, 0.5, var_345_3)

					arg_342_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1054ui_story.fillRatio = var_345_4
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1054ui_story then
				local var_345_5 = 0.5

				arg_342_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1054ui_story.fillRatio = var_345_5
			end

			local var_345_6 = 0
			local var_345_7 = 0.675

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

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_342_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_345_9 = arg_342_1:GetWordFromCfg(426091078)
				local var_345_10 = arg_342_1:FormatText(var_345_9.content)

				arg_342_1.text_.text = var_345_10

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_11 = 27
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
	Play426091079 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 426091079
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play426091080(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 0.825

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

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_346_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_349_3 = arg_346_1:GetWordFromCfg(426091079)
				local var_349_4 = arg_346_1:FormatText(var_349_3.content)

				arg_346_1.text_.text = var_349_4

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_5 = 33
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
	Play426091080 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 426091080
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play426091081(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.425

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[7].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_350_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_353_3 = arg_350_1:GetWordFromCfg(426091080)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 17
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
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_8 and arg_350_1.time_ < var_353_0 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play426091081 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 426091081
		arg_354_1.duration_ = 7.27

		local var_354_0 = {
			zh = 5.3,
			ja = 7.266
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
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play426091082(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1054ui_story"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos1054ui_story = var_357_0.localPosition

				local var_357_2 = GameObjectTools.GetOrAddComponent(var_357_0.gameObject, typeof(DynamicBoneHelper))

				if var_357_2 then
					var_357_2:EnableDynamicBone(false)
				end
			end

			local var_357_3 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_3 then
				local var_357_4 = (arg_354_1.time_ - var_357_1) / var_357_3
				local var_357_5 = Vector3.New(0, -0.985, -6)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1054ui_story, var_357_5, var_357_4)

				local var_357_6 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_6.x, var_357_6.y, var_357_6.z)

				local var_357_7 = var_357_0.localEulerAngles

				var_357_7.z = 0
				var_357_7.x = 0
				var_357_0.localEulerAngles = var_357_7
			end

			if arg_354_1.time_ >= var_357_1 + var_357_3 and arg_354_1.time_ < var_357_1 + var_357_3 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_357_8 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_8.x, var_357_8.y, var_357_8.z)

				local var_357_9 = var_357_0.localEulerAngles

				var_357_9.z = 0
				var_357_9.x = 0
				var_357_0.localEulerAngles = var_357_9

				local var_357_10 = GameObjectTools.GetOrAddComponent(var_357_0.gameObject, typeof(DynamicBoneHelper))

				if var_357_10 then
					var_357_10:EnableDynamicBone(true)
				end
			end

			local var_357_11 = arg_354_1.actors_["1054ui_story"]
			local var_357_12 = 0

			if var_357_12 < arg_354_1.time_ and arg_354_1.time_ <= var_357_12 + arg_357_0 and not isNil(var_357_11) and arg_354_1.var_.characterEffect1054ui_story == nil then
				arg_354_1.var_.characterEffect1054ui_story = var_357_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_13 = 0.200000002980232

			if var_357_12 <= arg_354_1.time_ and arg_354_1.time_ < var_357_12 + var_357_13 and not isNil(var_357_11) then
				local var_357_14 = (arg_354_1.time_ - var_357_12) / var_357_13

				if arg_354_1.var_.characterEffect1054ui_story and not isNil(var_357_11) then
					arg_354_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_12 + var_357_13 and arg_354_1.time_ < var_357_12 + var_357_13 + arg_357_0 and not isNil(var_357_11) and arg_354_1.var_.characterEffect1054ui_story then
				arg_354_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_357_15 = 0

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				arg_354_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			local var_357_16 = 0

			if var_357_16 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_357_17 = 0
			local var_357_18 = 0.25

			if var_357_17 < arg_354_1.time_ and arg_354_1.time_ <= var_357_17 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_19 = arg_354_1:FormatText(StoryNameCfg[1487].name)

				arg_354_1.leftNameTxt_.text = var_357_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_20 = arg_354_1:GetWordFromCfg(426091081)
				local var_357_21 = arg_354_1:FormatText(var_357_20.content)

				arg_354_1.text_.text = var_357_21

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_22 = 10
				local var_357_23 = utf8.len(var_357_21)
				local var_357_24 = var_357_22 <= 0 and var_357_18 or var_357_18 * (var_357_23 / var_357_22)

				if var_357_24 > 0 and var_357_18 < var_357_24 then
					arg_354_1.talkMaxDuration = var_357_24

					if var_357_24 + var_357_17 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_24 + var_357_17
					end
				end

				arg_354_1.text_.text = var_357_21
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091081", "story_v_out_426091.awb") ~= 0 then
					local var_357_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091081", "story_v_out_426091.awb") / 1000

					if var_357_25 + var_357_17 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_25 + var_357_17
					end

					if var_357_20.prefab_name ~= "" and arg_354_1.actors_[var_357_20.prefab_name] ~= nil then
						local var_357_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_20.prefab_name].transform, "story_v_out_426091", "426091081", "story_v_out_426091.awb")

						arg_354_1:RecordAudio("426091081", var_357_26)
						arg_354_1:RecordAudio("426091081", var_357_26)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_426091", "426091081", "story_v_out_426091.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_426091", "426091081", "story_v_out_426091.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_27 = math.max(var_357_18, arg_354_1.talkMaxDuration)

			if var_357_17 <= arg_354_1.time_ and arg_354_1.time_ < var_357_17 + var_357_27 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_17) / var_357_27

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_17 + var_357_27 and arg_354_1.time_ < var_357_17 + var_357_27 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play426091082 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 426091082
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play426091083(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1054ui_story"].transform
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.var_.moveOldPos1054ui_story = var_361_0.localPosition

				local var_361_2 = GameObjectTools.GetOrAddComponent(var_361_0.gameObject, typeof(DynamicBoneHelper))

				if var_361_2 then
					var_361_2:EnableDynamicBone(false)
				end
			end

			local var_361_3 = 0.001

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_3 then
				local var_361_4 = (arg_358_1.time_ - var_361_1) / var_361_3
				local var_361_5 = Vector3.New(0, 100, 0)

				var_361_0.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1054ui_story, var_361_5, var_361_4)

				local var_361_6 = manager.ui.mainCamera.transform.position - var_361_0.position

				var_361_0.forward = Vector3.New(var_361_6.x, var_361_6.y, var_361_6.z)

				local var_361_7 = var_361_0.localEulerAngles

				var_361_7.z = 0
				var_361_7.x = 0
				var_361_0.localEulerAngles = var_361_7
			end

			if arg_358_1.time_ >= var_361_1 + var_361_3 and arg_358_1.time_ < var_361_1 + var_361_3 + arg_361_0 then
				var_361_0.localPosition = Vector3.New(0, 100, 0)

				local var_361_8 = manager.ui.mainCamera.transform.position - var_361_0.position

				var_361_0.forward = Vector3.New(var_361_8.x, var_361_8.y, var_361_8.z)

				local var_361_9 = var_361_0.localEulerAngles

				var_361_9.z = 0
				var_361_9.x = 0
				var_361_0.localEulerAngles = var_361_9

				local var_361_10 = GameObjectTools.GetOrAddComponent(var_361_0.gameObject, typeof(DynamicBoneHelper))

				if var_361_10 then
					var_361_10:EnableDynamicBone(true)
				end
			end

			local var_361_11 = arg_358_1.actors_["1054ui_story"]
			local var_361_12 = 0

			if var_361_12 < arg_358_1.time_ and arg_358_1.time_ <= var_361_12 + arg_361_0 and not isNil(var_361_11) and arg_358_1.var_.characterEffect1054ui_story == nil then
				arg_358_1.var_.characterEffect1054ui_story = var_361_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_13 = 0.200000002980232

			if var_361_12 <= arg_358_1.time_ and arg_358_1.time_ < var_361_12 + var_361_13 and not isNil(var_361_11) then
				local var_361_14 = (arg_358_1.time_ - var_361_12) / var_361_13

				if arg_358_1.var_.characterEffect1054ui_story and not isNil(var_361_11) then
					local var_361_15 = Mathf.Lerp(0, 0.5, var_361_14)

					arg_358_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1054ui_story.fillRatio = var_361_15
				end
			end

			if arg_358_1.time_ >= var_361_12 + var_361_13 and arg_358_1.time_ < var_361_12 + var_361_13 + arg_361_0 and not isNil(var_361_11) and arg_358_1.var_.characterEffect1054ui_story then
				local var_361_16 = 0.5

				arg_358_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1054ui_story.fillRatio = var_361_16
			end

			local var_361_17 = 0
			local var_361_18 = 1.05

			if var_361_17 < arg_358_1.time_ and arg_358_1.time_ <= var_361_17 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_19 = arg_358_1:GetWordFromCfg(426091082)
				local var_361_20 = arg_358_1:FormatText(var_361_19.content)

				arg_358_1.text_.text = var_361_20

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_21 = 42
				local var_361_22 = utf8.len(var_361_20)
				local var_361_23 = var_361_21 <= 0 and var_361_18 or var_361_18 * (var_361_22 / var_361_21)

				if var_361_23 > 0 and var_361_18 < var_361_23 then
					arg_358_1.talkMaxDuration = var_361_23

					if var_361_23 + var_361_17 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_23 + var_361_17
					end
				end

				arg_358_1.text_.text = var_361_20
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_24 = math.max(var_361_18, arg_358_1.talkMaxDuration)

			if var_361_17 <= arg_358_1.time_ and arg_358_1.time_ < var_361_17 + var_361_24 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_17) / var_361_24

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_17 + var_361_24 and arg_358_1.time_ < var_361_17 + var_361_24 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play426091083 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 426091083
		arg_362_1.duration_ = 8.4

		local var_362_0 = {
			zh = 8.4,
			ja = 6.633
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play426091084(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 2

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				local var_365_1 = manager.ui.mainCamera.transform.localPosition
				local var_365_2 = Vector3.New(0, 0, 10) + Vector3.New(var_365_1.x, var_365_1.y, 0)
				local var_365_3 = arg_362_1.bgs_.J27h

				var_365_3.transform.localPosition = var_365_2
				var_365_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_4 = var_365_3:GetComponent("SpriteRenderer")

				if var_365_4 and var_365_4.sprite then
					local var_365_5 = (var_365_3.transform.localPosition - var_365_1).z
					local var_365_6 = manager.ui.mainCameraCom_
					local var_365_7 = 2 * var_365_5 * Mathf.Tan(var_365_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_365_8 = var_365_7 * var_365_6.aspect
					local var_365_9 = var_365_4.sprite.bounds.size.x
					local var_365_10 = var_365_4.sprite.bounds.size.y
					local var_365_11 = var_365_8 / var_365_9
					local var_365_12 = var_365_7 / var_365_10
					local var_365_13 = var_365_12 < var_365_11 and var_365_11 or var_365_12

					var_365_3.transform.localScale = Vector3.New(var_365_13, var_365_13, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "J27h" then
						iter_365_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_365_14 = 4

			if var_365_14 < arg_362_1.time_ and arg_362_1.time_ <= var_365_14 + arg_365_0 then
				arg_362_1.allBtn_.enabled = false
			end

			local var_365_15 = 0.3

			if arg_362_1.time_ >= var_365_14 + var_365_15 and arg_362_1.time_ < var_365_14 + var_365_15 + arg_365_0 then
				arg_362_1.allBtn_.enabled = true
			end

			local var_365_16 = 0

			if var_365_16 < arg_362_1.time_ and arg_362_1.time_ <= var_365_16 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_17 = 2

			if var_365_16 <= arg_362_1.time_ and arg_362_1.time_ < var_365_16 + var_365_17 then
				local var_365_18 = (arg_362_1.time_ - var_365_16) / var_365_17
				local var_365_19 = Color.New(0, 0, 0)

				var_365_19.a = Mathf.Lerp(0, 1, var_365_18)
				arg_362_1.mask_.color = var_365_19
			end

			if arg_362_1.time_ >= var_365_16 + var_365_17 and arg_362_1.time_ < var_365_16 + var_365_17 + arg_365_0 then
				local var_365_20 = Color.New(0, 0, 0)

				var_365_20.a = 1
				arg_362_1.mask_.color = var_365_20
			end

			local var_365_21 = 2

			if var_365_21 < arg_362_1.time_ and arg_362_1.time_ <= var_365_21 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_22 = 2

			if var_365_21 <= arg_362_1.time_ and arg_362_1.time_ < var_365_21 + var_365_22 then
				local var_365_23 = (arg_362_1.time_ - var_365_21) / var_365_22
				local var_365_24 = Color.New(0, 0, 0)

				var_365_24.a = Mathf.Lerp(1, 0, var_365_23)
				arg_362_1.mask_.color = var_365_24
			end

			if arg_362_1.time_ >= var_365_21 + var_365_22 and arg_362_1.time_ < var_365_21 + var_365_22 + arg_365_0 then
				local var_365_25 = Color.New(0, 0, 0)
				local var_365_26 = 0

				arg_362_1.mask_.enabled = false
				var_365_25.a = var_365_26
				arg_362_1.mask_.color = var_365_25
			end

			local var_365_27 = arg_362_1.actors_["1054ui_story"].transform
			local var_365_28 = 3.8

			if var_365_28 < arg_362_1.time_ and arg_362_1.time_ <= var_365_28 + arg_365_0 then
				arg_362_1.var_.moveOldPos1054ui_story = var_365_27.localPosition

				local var_365_29 = GameObjectTools.GetOrAddComponent(var_365_27.gameObject, typeof(DynamicBoneHelper))

				if var_365_29 then
					var_365_29:EnableDynamicBone(false)
				end
			end

			local var_365_30 = 0.001

			if var_365_28 <= arg_362_1.time_ and arg_362_1.time_ < var_365_28 + var_365_30 then
				local var_365_31 = (arg_362_1.time_ - var_365_28) / var_365_30
				local var_365_32 = Vector3.New(0, -0.985, -6)

				var_365_27.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1054ui_story, var_365_32, var_365_31)

				local var_365_33 = manager.ui.mainCamera.transform.position - var_365_27.position

				var_365_27.forward = Vector3.New(var_365_33.x, var_365_33.y, var_365_33.z)

				local var_365_34 = var_365_27.localEulerAngles

				var_365_34.z = 0
				var_365_34.x = 0
				var_365_27.localEulerAngles = var_365_34
			end

			if arg_362_1.time_ >= var_365_28 + var_365_30 and arg_362_1.time_ < var_365_28 + var_365_30 + arg_365_0 then
				var_365_27.localPosition = Vector3.New(0, -0.985, -6)

				local var_365_35 = manager.ui.mainCamera.transform.position - var_365_27.position

				var_365_27.forward = Vector3.New(var_365_35.x, var_365_35.y, var_365_35.z)

				local var_365_36 = var_365_27.localEulerAngles

				var_365_36.z = 0
				var_365_36.x = 0
				var_365_27.localEulerAngles = var_365_36

				local var_365_37 = GameObjectTools.GetOrAddComponent(var_365_27.gameObject, typeof(DynamicBoneHelper))

				if var_365_37 then
					var_365_37:EnableDynamicBone(true)
				end
			end

			local var_365_38 = arg_362_1.actors_["1054ui_story"]
			local var_365_39 = 3.8

			if var_365_39 < arg_362_1.time_ and arg_362_1.time_ <= var_365_39 + arg_365_0 and not isNil(var_365_38) and arg_362_1.var_.characterEffect1054ui_story == nil then
				arg_362_1.var_.characterEffect1054ui_story = var_365_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_40 = 0.200000002980232

			if var_365_39 <= arg_362_1.time_ and arg_362_1.time_ < var_365_39 + var_365_40 and not isNil(var_365_38) then
				local var_365_41 = (arg_362_1.time_ - var_365_39) / var_365_40

				if arg_362_1.var_.characterEffect1054ui_story and not isNil(var_365_38) then
					arg_362_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_39 + var_365_40 and arg_362_1.time_ < var_365_39 + var_365_40 + arg_365_0 and not isNil(var_365_38) and arg_362_1.var_.characterEffect1054ui_story then
				arg_362_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_365_42 = 3.8

			if var_365_42 < arg_362_1.time_ and arg_362_1.time_ <= var_365_42 + arg_365_0 then
				arg_362_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action9_2")
			end

			local var_365_43 = 3.8

			if var_365_43 < arg_362_1.time_ and arg_362_1.time_ <= var_365_43 + arg_365_0 then
				arg_362_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if arg_362_1.frameCnt_ <= 1 then
				arg_362_1.dialog_:SetActive(false)
			end

			local var_365_44 = 4
			local var_365_45 = 0.225

			if var_365_44 < arg_362_1.time_ and arg_362_1.time_ <= var_365_44 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				arg_362_1.dialog_:SetActive(true)

				arg_362_1.dialogCg_.alpha = 0

				local var_365_46 = LeanTween.value(arg_362_1.dialog_, 0, 1, 0.3)

				var_365_46:setOnUpdate(LuaHelper.FloatAction(function(arg_366_0)
					arg_362_1.dialogCg_.alpha = arg_366_0
				end))
				var_365_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_362_1.dialog_)
					var_365_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_362_1.duration_ = arg_362_1.duration_ + 0.3

				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_47 = arg_362_1:FormatText(StoryNameCfg[1487].name)

				arg_362_1.leftNameTxt_.text = var_365_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_48 = arg_362_1:GetWordFromCfg(426091083)
				local var_365_49 = arg_362_1:FormatText(var_365_48.content)

				arg_362_1.text_.text = var_365_49

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_50 = 9
				local var_365_51 = utf8.len(var_365_49)
				local var_365_52 = var_365_50 <= 0 and var_365_45 or var_365_45 * (var_365_51 / var_365_50)

				if var_365_52 > 0 and var_365_45 < var_365_52 then
					arg_362_1.talkMaxDuration = var_365_52
					var_365_44 = var_365_44 + 0.3

					if var_365_52 + var_365_44 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_52 + var_365_44
					end
				end

				arg_362_1.text_.text = var_365_49
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091083", "story_v_out_426091.awb") ~= 0 then
					local var_365_53 = manager.audio:GetVoiceLength("story_v_out_426091", "426091083", "story_v_out_426091.awb") / 1000

					if var_365_53 + var_365_44 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_53 + var_365_44
					end

					if var_365_48.prefab_name ~= "" and arg_362_1.actors_[var_365_48.prefab_name] ~= nil then
						local var_365_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_48.prefab_name].transform, "story_v_out_426091", "426091083", "story_v_out_426091.awb")

						arg_362_1:RecordAudio("426091083", var_365_54)
						arg_362_1:RecordAudio("426091083", var_365_54)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_426091", "426091083", "story_v_out_426091.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_426091", "426091083", "story_v_out_426091.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_55 = var_365_44 + 0.3
			local var_365_56 = math.max(var_365_45, arg_362_1.talkMaxDuration)

			if var_365_55 <= arg_362_1.time_ and arg_362_1.time_ < var_365_55 + var_365_56 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_55) / var_365_56

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_55 + var_365_56 and arg_362_1.time_ < var_365_55 + var_365_56 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play426091084 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 426091084
		arg_368_1.duration_ = 6.47

		local var_368_0 = {
			zh = 6.466,
			ja = 5.966
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play426091085(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.3

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[1487].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_3 = arg_368_1:GetWordFromCfg(426091084)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091084", "story_v_out_426091.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091084", "story_v_out_426091.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_426091", "426091084", "story_v_out_426091.awb")

						arg_368_1:RecordAudio("426091084", var_371_9)
						arg_368_1:RecordAudio("426091084", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_426091", "426091084", "story_v_out_426091.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_426091", "426091084", "story_v_out_426091.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play426091085 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 426091085
		arg_372_1.duration_ = 4.5

		local var_372_0 = {
			zh = 4.5,
			ja = 1.5
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play426091086(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 0.05

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_2 = arg_372_1:FormatText(StoryNameCfg[1487].name)

				arg_372_1.leftNameTxt_.text = var_375_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:GetWordFromCfg(426091085)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091085", "story_v_out_426091.awb") ~= 0 then
					local var_375_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091085", "story_v_out_426091.awb") / 1000

					if var_375_8 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_8 + var_375_0
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_426091", "426091085", "story_v_out_426091.awb")

						arg_372_1:RecordAudio("426091085", var_375_9)
						arg_372_1:RecordAudio("426091085", var_375_9)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_426091", "426091085", "story_v_out_426091.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_426091", "426091085", "story_v_out_426091.awb")
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
	Play426091086 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 426091086
		arg_376_1.duration_ = 4.1

		local var_376_0 = {
			zh = 4.1,
			ja = 1.4
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play426091087(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 0.15

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_2 = arg_376_1:FormatText(StoryNameCfg[1487].name)

				arg_376_1.leftNameTxt_.text = var_379_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:GetWordFromCfg(426091086)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091086", "story_v_out_426091.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091086", "story_v_out_426091.awb") / 1000

					if var_379_8 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_0
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_426091", "426091086", "story_v_out_426091.awb")

						arg_376_1:RecordAudio("426091086", var_379_9)
						arg_376_1:RecordAudio("426091086", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_426091", "426091086", "story_v_out_426091.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_426091", "426091086", "story_v_out_426091.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_10 and arg_376_1.time_ < var_379_0 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play426091087 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 426091087
		arg_380_1.duration_ = 9

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play426091088(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 2

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				local var_383_1 = manager.ui.mainCamera.transform.localPosition
				local var_383_2 = Vector3.New(0, 0, 10) + Vector3.New(var_383_1.x, var_383_1.y, 0)
				local var_383_3 = arg_380_1.bgs_.SS2602

				var_383_3.transform.localPosition = var_383_2
				var_383_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_383_4 = var_383_3:GetComponent("SpriteRenderer")

				if var_383_4 and var_383_4.sprite then
					local var_383_5 = (var_383_3.transform.localPosition - var_383_1).z
					local var_383_6 = manager.ui.mainCameraCom_
					local var_383_7 = 2 * var_383_5 * Mathf.Tan(var_383_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_383_8 = var_383_7 * var_383_6.aspect
					local var_383_9 = var_383_4.sprite.bounds.size.x
					local var_383_10 = var_383_4.sprite.bounds.size.y
					local var_383_11 = var_383_8 / var_383_9
					local var_383_12 = var_383_7 / var_383_10
					local var_383_13 = var_383_12 < var_383_11 and var_383_11 or var_383_12

					var_383_3.transform.localScale = Vector3.New(var_383_13, var_383_13, 0)
				end

				for iter_383_0, iter_383_1 in pairs(arg_380_1.bgs_) do
					if iter_383_0 ~= "SS2602" then
						iter_383_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_383_14 = 4

			if var_383_14 < arg_380_1.time_ and arg_380_1.time_ <= var_383_14 + arg_383_0 then
				arg_380_1.allBtn_.enabled = false
			end

			local var_383_15 = 0.3

			if arg_380_1.time_ >= var_383_14 + var_383_15 and arg_380_1.time_ < var_383_14 + var_383_15 + arg_383_0 then
				arg_380_1.allBtn_.enabled = true
			end

			local var_383_16 = 0

			if var_383_16 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_17 = 2

			if var_383_16 <= arg_380_1.time_ and arg_380_1.time_ < var_383_16 + var_383_17 then
				local var_383_18 = (arg_380_1.time_ - var_383_16) / var_383_17
				local var_383_19 = Color.New(0, 0, 0)

				var_383_19.a = Mathf.Lerp(0, 1, var_383_18)
				arg_380_1.mask_.color = var_383_19
			end

			if arg_380_1.time_ >= var_383_16 + var_383_17 and arg_380_1.time_ < var_383_16 + var_383_17 + arg_383_0 then
				local var_383_20 = Color.New(0, 0, 0)

				var_383_20.a = 1
				arg_380_1.mask_.color = var_383_20
			end

			local var_383_21 = 2

			if var_383_21 < arg_380_1.time_ and arg_380_1.time_ <= var_383_21 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_22 = 2

			if var_383_21 <= arg_380_1.time_ and arg_380_1.time_ < var_383_21 + var_383_22 then
				local var_383_23 = (arg_380_1.time_ - var_383_21) / var_383_22
				local var_383_24 = Color.New(0, 0, 0)

				var_383_24.a = Mathf.Lerp(1, 0, var_383_23)
				arg_380_1.mask_.color = var_383_24
			end

			if arg_380_1.time_ >= var_383_21 + var_383_22 and arg_380_1.time_ < var_383_21 + var_383_22 + arg_383_0 then
				local var_383_25 = Color.New(0, 0, 0)
				local var_383_26 = 0

				arg_380_1.mask_.enabled = false
				var_383_25.a = var_383_26
				arg_380_1.mask_.color = var_383_25
			end

			local var_383_27 = arg_380_1.actors_["1054ui_story"].transform
			local var_383_28 = 1.96599999815226

			if var_383_28 < arg_380_1.time_ and arg_380_1.time_ <= var_383_28 + arg_383_0 then
				arg_380_1.var_.moveOldPos1054ui_story = var_383_27.localPosition

				local var_383_29 = GameObjectTools.GetOrAddComponent(var_383_27.gameObject, typeof(DynamicBoneHelper))

				if var_383_29 then
					var_383_29:EnableDynamicBone(false)
				end
			end

			local var_383_30 = 0.001

			if var_383_28 <= arg_380_1.time_ and arg_380_1.time_ < var_383_28 + var_383_30 then
				local var_383_31 = (arg_380_1.time_ - var_383_28) / var_383_30
				local var_383_32 = Vector3.New(0, 100, 0)

				var_383_27.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1054ui_story, var_383_32, var_383_31)

				local var_383_33 = manager.ui.mainCamera.transform.position - var_383_27.position

				var_383_27.forward = Vector3.New(var_383_33.x, var_383_33.y, var_383_33.z)

				local var_383_34 = var_383_27.localEulerAngles

				var_383_34.z = 0
				var_383_34.x = 0
				var_383_27.localEulerAngles = var_383_34
			end

			if arg_380_1.time_ >= var_383_28 + var_383_30 and arg_380_1.time_ < var_383_28 + var_383_30 + arg_383_0 then
				var_383_27.localPosition = Vector3.New(0, 100, 0)

				local var_383_35 = manager.ui.mainCamera.transform.position - var_383_27.position

				var_383_27.forward = Vector3.New(var_383_35.x, var_383_35.y, var_383_35.z)

				local var_383_36 = var_383_27.localEulerAngles

				var_383_36.z = 0
				var_383_36.x = 0
				var_383_27.localEulerAngles = var_383_36

				local var_383_37 = GameObjectTools.GetOrAddComponent(var_383_27.gameObject, typeof(DynamicBoneHelper))

				if var_383_37 then
					var_383_37:EnableDynamicBone(true)
				end
			end

			local var_383_38 = arg_380_1.actors_["1054ui_story"]
			local var_383_39 = 1.96599999815226

			if var_383_39 < arg_380_1.time_ and arg_380_1.time_ <= var_383_39 + arg_383_0 and not isNil(var_383_38) and arg_380_1.var_.characterEffect1054ui_story == nil then
				arg_380_1.var_.characterEffect1054ui_story = var_383_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_40 = 0.034000001847744

			if var_383_39 <= arg_380_1.time_ and arg_380_1.time_ < var_383_39 + var_383_40 and not isNil(var_383_38) then
				local var_383_41 = (arg_380_1.time_ - var_383_39) / var_383_40

				if arg_380_1.var_.characterEffect1054ui_story and not isNil(var_383_38) then
					local var_383_42 = Mathf.Lerp(0, 0.5, var_383_41)

					arg_380_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1054ui_story.fillRatio = var_383_42
				end
			end

			if arg_380_1.time_ >= var_383_39 + var_383_40 and arg_380_1.time_ < var_383_39 + var_383_40 + arg_383_0 and not isNil(var_383_38) and arg_380_1.var_.characterEffect1054ui_story then
				local var_383_43 = 0.5

				arg_380_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1054ui_story.fillRatio = var_383_43
			end

			local var_383_44 = 1.96599999815226

			arg_380_1.isInRecall_ = false

			if var_383_44 < arg_380_1.time_ and arg_380_1.time_ <= var_383_44 + arg_383_0 then
				arg_380_1.screenFilterGo_:SetActive(false)

				for iter_383_2, iter_383_3 in pairs(arg_380_1.actors_) do
					local var_383_45 = iter_383_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_383_4, iter_383_5 in ipairs(var_383_45) do
						if iter_383_5.color.r > 0.51 then
							iter_383_5.color = Color.New(1, 1, 1)
						else
							iter_383_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_383_46 = 0.299999999999999

			if var_383_44 <= arg_380_1.time_ and arg_380_1.time_ < var_383_44 + var_383_46 then
				local var_383_47 = (arg_380_1.time_ - var_383_44) / var_383_46

				arg_380_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_383_47)
			end

			if arg_380_1.time_ >= var_383_44 + var_383_46 and arg_380_1.time_ < var_383_44 + var_383_46 + arg_383_0 then
				arg_380_1.screenFilterEffect_.weight = 0
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_48 = 4
			local var_383_49 = 0.425

			if var_383_48 < arg_380_1.time_ and arg_380_1.time_ <= var_383_48 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_50 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_50:setOnUpdate(LuaHelper.FloatAction(function(arg_384_0)
					arg_380_1.dialogCg_.alpha = arg_384_0
				end))
				var_383_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_51 = arg_380_1:FormatText(StoryNameCfg[7].name)

				arg_380_1.leftNameTxt_.text = var_383_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_52 = arg_380_1:GetWordFromCfg(426091087)
				local var_383_53 = arg_380_1:FormatText(var_383_52.content)

				arg_380_1.text_.text = var_383_53

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_54 = 17
				local var_383_55 = utf8.len(var_383_53)
				local var_383_56 = var_383_54 <= 0 and var_383_49 or var_383_49 * (var_383_55 / var_383_54)

				if var_383_56 > 0 and var_383_49 < var_383_56 then
					arg_380_1.talkMaxDuration = var_383_56
					var_383_48 = var_383_48 + 0.3

					if var_383_56 + var_383_48 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_56 + var_383_48
					end
				end

				arg_380_1.text_.text = var_383_53
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_57 = var_383_48 + 0.3
			local var_383_58 = math.max(var_383_49, arg_380_1.talkMaxDuration)

			if var_383_57 <= arg_380_1.time_ and arg_380_1.time_ < var_383_57 + var_383_58 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_57) / var_383_58

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_57 + var_383_58 and arg_380_1.time_ < var_383_57 + var_383_58 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play426091088 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 426091088
		arg_386_1.duration_ = 6.7

		local var_386_0 = {
			zh = 6.7,
			ja = 4.566
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play426091089(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0
			local var_389_1 = 0.525

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_2 = arg_386_1:FormatText(StoryNameCfg[1488].name)

				arg_386_1.leftNameTxt_.text = var_389_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:GetWordFromCfg(426091088)
				local var_389_4 = arg_386_1:FormatText(var_389_3.content)

				arg_386_1.text_.text = var_389_4

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091088", "story_v_out_426091.awb") ~= 0 then
					local var_389_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091088", "story_v_out_426091.awb") / 1000

					if var_389_8 + var_389_0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_0
					end

					if var_389_3.prefab_name ~= "" and arg_386_1.actors_[var_389_3.prefab_name] ~= nil then
						local var_389_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_3.prefab_name].transform, "story_v_out_426091", "426091088", "story_v_out_426091.awb")

						arg_386_1:RecordAudio("426091088", var_389_9)
						arg_386_1:RecordAudio("426091088", var_389_9)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_426091", "426091088", "story_v_out_426091.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_426091", "426091088", "story_v_out_426091.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_10 = math.max(var_389_1, arg_386_1.talkMaxDuration)

			if var_389_0 <= arg_386_1.time_ and arg_386_1.time_ < var_389_0 + var_389_10 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_0) / var_389_10

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_0 + var_389_10 and arg_386_1.time_ < var_389_0 + var_389_10 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play426091089 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 426091089
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play426091090(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.075

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[7].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_3 = arg_390_1:GetWordFromCfg(426091089)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 3
				local var_393_6 = utf8.len(var_393_4)
				local var_393_7 = var_393_5 <= 0 and var_393_1 or var_393_1 * (var_393_6 / var_393_5)

				if var_393_7 > 0 and var_393_1 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_8 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_8 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_8

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_8 and arg_390_1.time_ < var_393_0 + var_393_8 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play426091090 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 426091090
		arg_394_1.duration_ = 5.63

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play426091091(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.633333333333333
			local var_397_1 = 1

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				local var_397_2 = "play"
				local var_397_3 = "effect"

				arg_394_1:AudioAction(var_397_2, var_397_3, "se_story_150", "se_story_150_stab", "")
			end

			local var_397_4 = 0

			if var_397_4 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_5 = 0.633333333333333

			if var_397_4 <= arg_394_1.time_ and arg_394_1.time_ < var_397_4 + var_397_5 then
				local var_397_6 = (arg_394_1.time_ - var_397_4) / var_397_5
				local var_397_7 = Color.New(1, 1, 1)

				var_397_7.a = Mathf.Lerp(1, 0, var_397_6)
				arg_394_1.mask_.color = var_397_7
			end

			if arg_394_1.time_ >= var_397_4 + var_397_5 and arg_394_1.time_ < var_397_4 + var_397_5 + arg_397_0 then
				local var_397_8 = Color.New(1, 1, 1)
				local var_397_9 = 0

				arg_394_1.mask_.enabled = false
				var_397_8.a = var_397_9
				arg_394_1.mask_.color = var_397_8
			end

			local var_397_10 = manager.ui.mainCamera.transform
			local var_397_11 = 0.4

			if var_397_11 < arg_394_1.time_ and arg_394_1.time_ <= var_397_11 + arg_397_0 then
				local var_397_12 = arg_394_1.var_.effectsuduxianwuchang1
				local var_397_13
				local var_397_14 = var_397_10

				if not var_397_12 then
					var_397_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_397_14)
					var_397_12.name = "suduxianwuchang1"
					arg_394_1.var_.effectsuduxianwuchang1 = var_397_12
				else
					var_397_12.transform:SetParent(var_397_14)
				end

				var_397_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_397_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_397_15 = arg_394_1.bgs_.SS2602.transform
			local var_397_16 = 0

			if var_397_16 < arg_394_1.time_ and arg_394_1.time_ <= var_397_16 + arg_397_0 then
				arg_394_1.var_.moveOldPosSS2602 = var_397_15.localPosition
			end

			local var_397_17 = 1.13333333333333

			if var_397_16 <= arg_394_1.time_ and arg_394_1.time_ < var_397_16 + var_397_17 then
				local var_397_18 = (arg_394_1.time_ - var_397_16) / var_397_17
				local var_397_19 = Vector3.New(0, 1, 9)

				var_397_15.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPosSS2602, var_397_19, var_397_18)
			end

			if arg_394_1.time_ >= var_397_16 + var_397_17 and arg_394_1.time_ < var_397_16 + var_397_17 + arg_397_0 then
				var_397_15.localPosition = Vector3.New(0, 1, 9)
			end

			local var_397_20 = 0

			if var_397_20 < arg_394_1.time_ and arg_394_1.time_ <= var_397_20 + arg_397_0 then
				arg_394_1.allBtn_.enabled = false
			end

			local var_397_21 = 2.03333333333333

			if arg_394_1.time_ >= var_397_20 + var_397_21 and arg_394_1.time_ < var_397_20 + var_397_21 + arg_397_0 then
				arg_394_1.allBtn_.enabled = true
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_22 = 0.633333333333333
			local var_397_23 = 0.9

			if var_397_22 < arg_394_1.time_ and arg_394_1.time_ <= var_397_22 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_24 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_24:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_25 = arg_394_1:GetWordFromCfg(426091090)
				local var_397_26 = arg_394_1:FormatText(var_397_25.content)

				arg_394_1.text_.text = var_397_26

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_27 = 36
				local var_397_28 = utf8.len(var_397_26)
				local var_397_29 = var_397_27 <= 0 and var_397_23 or var_397_23 * (var_397_28 / var_397_27)

				if var_397_29 > 0 and var_397_23 < var_397_29 then
					arg_394_1.talkMaxDuration = var_397_29
					var_397_22 = var_397_22 + 0.3

					if var_397_29 + var_397_22 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_29 + var_397_22
					end
				end

				arg_394_1.text_.text = var_397_26
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_30 = var_397_22 + 0.3
			local var_397_31 = math.max(var_397_23, arg_394_1.talkMaxDuration)

			if var_397_30 <= arg_394_1.time_ and arg_394_1.time_ < var_397_30 + var_397_31 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_30) / var_397_31

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_30 + var_397_31 and arg_394_1.time_ < var_397_30 + var_397_31 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play426091091 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 426091091
		arg_400_1.duration_ = 2.4

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"

			SetActive(arg_400_1.choicesGo_, true)

			for iter_401_0, iter_401_1 in ipairs(arg_400_1.choices_) do
				local var_401_0 = iter_401_0 <= 1

				SetActive(iter_401_1.go, var_401_0)
			end

			arg_400_1.choices_[1].txt.text = arg_400_1:FormatText(StoryChoiceCfg[1609].name)
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play426091092(arg_400_1)
			end

			arg_400_1:RecordChoiceLog(426091091, 1609)
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = "STblack"

			if arg_400_1.bgs_[var_403_0] == nil then
				local var_403_1 = Object.Instantiate(arg_400_1.paintGo_)

				var_403_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_403_0)
				var_403_1.name = var_403_0
				var_403_1.transform.parent = arg_400_1.stage_.transform
				var_403_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.bgs_[var_403_0] = var_403_1
			end

			local var_403_2 = 0.4

			if var_403_2 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				local var_403_3 = manager.ui.mainCamera.transform.localPosition
				local var_403_4 = Vector3.New(0, 0, 10) + Vector3.New(var_403_3.x, var_403_3.y, 0)
				local var_403_5 = arg_400_1.bgs_.STblack

				var_403_5.transform.localPosition = var_403_4
				var_403_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_403_6 = var_403_5:GetComponent("SpriteRenderer")

				if var_403_6 and var_403_6.sprite then
					local var_403_7 = (var_403_5.transform.localPosition - var_403_3).z
					local var_403_8 = manager.ui.mainCameraCom_
					local var_403_9 = 2 * var_403_7 * Mathf.Tan(var_403_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_403_10 = var_403_9 * var_403_8.aspect
					local var_403_11 = var_403_6.sprite.bounds.size.x
					local var_403_12 = var_403_6.sprite.bounds.size.y
					local var_403_13 = var_403_10 / var_403_11
					local var_403_14 = var_403_9 / var_403_12
					local var_403_15 = var_403_14 < var_403_13 and var_403_13 or var_403_14

					var_403_5.transform.localScale = Vector3.New(var_403_15, var_403_15, 0)
				end

				for iter_403_0, iter_403_1 in pairs(arg_400_1.bgs_) do
					if iter_403_0 ~= "STblack" then
						iter_403_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_403_16 = 2

			if var_403_16 < arg_400_1.time_ and arg_400_1.time_ <= var_403_16 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			local var_403_17 = 0.3

			if arg_400_1.time_ >= var_403_16 + var_403_17 and arg_400_1.time_ < var_403_16 + var_403_17 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_18 = 0

			if var_403_18 < arg_400_1.time_ and arg_400_1.time_ <= var_403_18 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_19 = 2

			if var_403_18 <= arg_400_1.time_ and arg_400_1.time_ < var_403_18 + var_403_19 then
				local var_403_20 = (arg_400_1.time_ - var_403_18) / var_403_19
				local var_403_21 = Color.New(0, 0, 0)

				var_403_21.a = Mathf.Lerp(1, 0, var_403_20)
				arg_400_1.mask_.color = var_403_21
			end

			if arg_400_1.time_ >= var_403_18 + var_403_19 and arg_400_1.time_ < var_403_18 + var_403_19 + arg_403_0 then
				local var_403_22 = Color.New(0, 0, 0)
				local var_403_23 = 0

				arg_400_1.mask_.enabled = false
				var_403_22.a = var_403_23
				arg_400_1.mask_.color = var_403_22
			end

			local var_403_24 = manager.ui.mainCamera.transform
			local var_403_25 = 0

			if var_403_25 < arg_400_1.time_ and arg_400_1.time_ <= var_403_25 + arg_403_0 then
				local var_403_26 = arg_400_1.var_.effectbushinidecuo1
				local var_403_27
				local var_403_28 = var_403_24

				if not var_403_26 then
					var_403_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_403_28)
					var_403_26.name = "bushinidecuo1"
					arg_400_1.var_.effectbushinidecuo1 = var_403_26
				else
					var_403_26.transform:SetParent(var_403_28)
				end

				var_403_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_403_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_403_29 = manager.ui.mainCamera.transform
			local var_403_30 = 2

			if var_403_30 < arg_400_1.time_ and arg_400_1.time_ <= var_403_30 + arg_403_0 then
				local var_403_31 = arg_400_1.var_.effectbushinidecuo1

				if var_403_31 then
					Object.Destroy(var_403_31)

					arg_400_1.var_.effectbushinidecuo1 = nil
				end
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play426091092 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 426091092
		arg_404_1.duration_ = 7

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play426091093(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				local var_407_1 = manager.ui.mainCamera.transform.localPosition
				local var_407_2 = Vector3.New(0, 0, 10) + Vector3.New(var_407_1.x, var_407_1.y, 0)
				local var_407_3 = arg_404_1.bgs_.J27g

				var_407_3.transform.localPosition = var_407_2
				var_407_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_407_4 = var_407_3:GetComponent("SpriteRenderer")

				if var_407_4 and var_407_4.sprite then
					local var_407_5 = (var_407_3.transform.localPosition - var_407_1).z
					local var_407_6 = manager.ui.mainCameraCom_
					local var_407_7 = 2 * var_407_5 * Mathf.Tan(var_407_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_407_8 = var_407_7 * var_407_6.aspect
					local var_407_9 = var_407_4.sprite.bounds.size.x
					local var_407_10 = var_407_4.sprite.bounds.size.y
					local var_407_11 = var_407_8 / var_407_9
					local var_407_12 = var_407_7 / var_407_10
					local var_407_13 = var_407_12 < var_407_11 and var_407_11 or var_407_12

					var_407_3.transform.localScale = Vector3.New(var_407_13, var_407_13, 0)
				end

				for iter_407_0, iter_407_1 in pairs(arg_404_1.bgs_) do
					if iter_407_0 ~= "J27g" then
						iter_407_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_407_14 = 2

			if var_407_14 < arg_404_1.time_ and arg_404_1.time_ <= var_407_14 + arg_407_0 then
				arg_404_1.allBtn_.enabled = false
			end

			local var_407_15 = 0.3

			if arg_404_1.time_ >= var_407_14 + var_407_15 and arg_404_1.time_ < var_407_14 + var_407_15 + arg_407_0 then
				arg_404_1.allBtn_.enabled = true
			end

			local var_407_16 = 0

			if var_407_16 < arg_404_1.time_ and arg_404_1.time_ <= var_407_16 + arg_407_0 then
				arg_404_1.mask_.enabled = true
				arg_404_1.mask_.raycastTarget = true

				arg_404_1:SetGaussion(false)
			end

			local var_407_17 = 2

			if var_407_16 <= arg_404_1.time_ and arg_404_1.time_ < var_407_16 + var_407_17 then
				local var_407_18 = (arg_404_1.time_ - var_407_16) / var_407_17
				local var_407_19 = Color.New(0, 0, 0)

				var_407_19.a = Mathf.Lerp(1, 0, var_407_18)
				arg_404_1.mask_.color = var_407_19
			end

			if arg_404_1.time_ >= var_407_16 + var_407_17 and arg_404_1.time_ < var_407_16 + var_407_17 + arg_407_0 then
				local var_407_20 = Color.New(0, 0, 0)
				local var_407_21 = 0

				arg_404_1.mask_.enabled = false
				var_407_20.a = var_407_21
				arg_404_1.mask_.color = var_407_20
			end

			local var_407_22 = 0.1
			local var_407_23 = 1

			if var_407_22 < arg_404_1.time_ and arg_404_1.time_ <= var_407_22 + arg_407_0 then
				local var_407_24 = "stop"
				local var_407_25 = "effect"

				arg_404_1:AudioAction(var_407_24, var_407_25, "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			local var_407_26 = 0.466666666666667
			local var_407_27 = 1

			if var_407_26 < arg_404_1.time_ and arg_404_1.time_ <= var_407_26 + arg_407_0 then
				local var_407_28 = "play"
				local var_407_29 = "effect"

				arg_404_1:AudioAction(var_407_28, var_407_29, "se_story_150", "se_story_150_flower_field", "")
			end

			if arg_404_1.frameCnt_ <= 1 then
				arg_404_1.dialog_:SetActive(false)
			end

			local var_407_30 = 2
			local var_407_31 = 0.65

			if var_407_30 < arg_404_1.time_ and arg_404_1.time_ <= var_407_30 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0

				arg_404_1.dialog_:SetActive(true)

				arg_404_1.dialogCg_.alpha = 0

				local var_407_32 = LeanTween.value(arg_404_1.dialog_, 0, 1, 0.3)

				var_407_32:setOnUpdate(LuaHelper.FloatAction(function(arg_408_0)
					arg_404_1.dialogCg_.alpha = arg_408_0
				end))
				var_407_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_404_1.dialog_)
					var_407_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_404_1.duration_ = arg_404_1.duration_ + 0.3

				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_33 = arg_404_1:GetWordFromCfg(426091092)
				local var_407_34 = arg_404_1:FormatText(var_407_33.content)

				arg_404_1.text_.text = var_407_34

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_35 = 26
				local var_407_36 = utf8.len(var_407_34)
				local var_407_37 = var_407_35 <= 0 and var_407_31 or var_407_31 * (var_407_36 / var_407_35)

				if var_407_37 > 0 and var_407_31 < var_407_37 then
					arg_404_1.talkMaxDuration = var_407_37
					var_407_30 = var_407_30 + 0.3

					if var_407_37 + var_407_30 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_37 + var_407_30
					end
				end

				arg_404_1.text_.text = var_407_34
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_38 = var_407_30 + 0.3
			local var_407_39 = math.max(var_407_31, arg_404_1.talkMaxDuration)

			if var_407_38 <= arg_404_1.time_ and arg_404_1.time_ < var_407_38 + var_407_39 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_38) / var_407_39

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_38 + var_407_39 and arg_404_1.time_ < var_407_38 + var_407_39 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play426091093 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 426091093
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play426091094(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 1.375

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_2 = arg_410_1:GetWordFromCfg(426091093)
				local var_413_3 = arg_410_1:FormatText(var_413_2.content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 55
				local var_413_5 = utf8.len(var_413_3)
				local var_413_6 = var_413_4 <= 0 and var_413_1 or var_413_1 * (var_413_5 / var_413_4)

				if var_413_6 > 0 and var_413_1 < var_413_6 then
					arg_410_1.talkMaxDuration = var_413_6

					if var_413_6 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_6 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_7 and arg_410_1.time_ < var_413_0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play426091094 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 426091094
		arg_414_1.duration_ = 5

		local var_414_0 = {
			zh = 5,
			ja = 3.5
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play426091095(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["6148ui_story"].transform
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.var_.moveOldPos6148ui_story = var_417_0.localPosition

				local var_417_2 = GameObjectTools.GetOrAddComponent(var_417_0.gameObject, typeof(DynamicBoneHelper))

				if var_417_2 then
					var_417_2:EnableDynamicBone(false)
				end
			end

			local var_417_3 = 0.001

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_3 then
				local var_417_4 = (arg_414_1.time_ - var_417_1) / var_417_3
				local var_417_5 = Vector3.New(0, -0.985, -6)

				var_417_0.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos6148ui_story, var_417_5, var_417_4)

				local var_417_6 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_6.x, var_417_6.y, var_417_6.z)

				local var_417_7 = var_417_0.localEulerAngles

				var_417_7.z = 0
				var_417_7.x = 0
				var_417_0.localEulerAngles = var_417_7
			end

			if arg_414_1.time_ >= var_417_1 + var_417_3 and arg_414_1.time_ < var_417_1 + var_417_3 + arg_417_0 then
				var_417_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_417_8 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_8.x, var_417_8.y, var_417_8.z)

				local var_417_9 = var_417_0.localEulerAngles

				var_417_9.z = 0
				var_417_9.x = 0
				var_417_0.localEulerAngles = var_417_9

				local var_417_10 = GameObjectTools.GetOrAddComponent(var_417_0.gameObject, typeof(DynamicBoneHelper))

				if var_417_10 then
					var_417_10:EnableDynamicBone(true)
				end
			end

			local var_417_11 = arg_414_1.actors_["6148ui_story"]
			local var_417_12 = 0

			if var_417_12 < arg_414_1.time_ and arg_414_1.time_ <= var_417_12 + arg_417_0 and not isNil(var_417_11) and arg_414_1.var_.characterEffect6148ui_story == nil then
				arg_414_1.var_.characterEffect6148ui_story = var_417_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_13 = 0.200000002980232

			if var_417_12 <= arg_414_1.time_ and arg_414_1.time_ < var_417_12 + var_417_13 and not isNil(var_417_11) then
				local var_417_14 = (arg_414_1.time_ - var_417_12) / var_417_13

				if arg_414_1.var_.characterEffect6148ui_story and not isNil(var_417_11) then
					arg_414_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= var_417_12 + var_417_13 and arg_414_1.time_ < var_417_12 + var_417_13 + arg_417_0 and not isNil(var_417_11) and arg_414_1.var_.characterEffect6148ui_story then
				arg_414_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_417_15 = 0

			if var_417_15 < arg_414_1.time_ and arg_414_1.time_ <= var_417_15 + arg_417_0 then
				arg_414_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_417_16 = 0

			if var_417_16 < arg_414_1.time_ and arg_414_1.time_ <= var_417_16 + arg_417_0 then
				arg_414_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_417_17 = 0
			local var_417_18 = 0.175

			if var_417_17 < arg_414_1.time_ and arg_414_1.time_ <= var_417_17 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_19 = arg_414_1:FormatText(StoryNameCfg[1488].name)

				arg_414_1.leftNameTxt_.text = var_417_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_20 = arg_414_1:GetWordFromCfg(426091094)
				local var_417_21 = arg_414_1:FormatText(var_417_20.content)

				arg_414_1.text_.text = var_417_21

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_22 = 7
				local var_417_23 = utf8.len(var_417_21)
				local var_417_24 = var_417_22 <= 0 and var_417_18 or var_417_18 * (var_417_23 / var_417_22)

				if var_417_24 > 0 and var_417_18 < var_417_24 then
					arg_414_1.talkMaxDuration = var_417_24

					if var_417_24 + var_417_17 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_24 + var_417_17
					end
				end

				arg_414_1.text_.text = var_417_21
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091094", "story_v_out_426091.awb") ~= 0 then
					local var_417_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091094", "story_v_out_426091.awb") / 1000

					if var_417_25 + var_417_17 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_25 + var_417_17
					end

					if var_417_20.prefab_name ~= "" and arg_414_1.actors_[var_417_20.prefab_name] ~= nil then
						local var_417_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_20.prefab_name].transform, "story_v_out_426091", "426091094", "story_v_out_426091.awb")

						arg_414_1:RecordAudio("426091094", var_417_26)
						arg_414_1:RecordAudio("426091094", var_417_26)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_426091", "426091094", "story_v_out_426091.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_426091", "426091094", "story_v_out_426091.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_27 = math.max(var_417_18, arg_414_1.talkMaxDuration)

			if var_417_17 <= arg_414_1.time_ and arg_414_1.time_ < var_417_17 + var_417_27 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_17) / var_417_27

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_17 + var_417_27 and arg_414_1.time_ < var_417_17 + var_417_27 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091095 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 426091095
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play426091096(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["6148ui_story"]
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect6148ui_story == nil then
				arg_418_1.var_.characterEffect6148ui_story = var_421_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 and not isNil(var_421_0) then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2

				if arg_418_1.var_.characterEffect6148ui_story and not isNil(var_421_0) then
					local var_421_4 = Mathf.Lerp(0, 0.5, var_421_3)

					arg_418_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_418_1.var_.characterEffect6148ui_story.fillRatio = var_421_4
				end
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 and not isNil(var_421_0) and arg_418_1.var_.characterEffect6148ui_story then
				local var_421_5 = 0.5

				arg_418_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_418_1.var_.characterEffect6148ui_story.fillRatio = var_421_5
			end

			local var_421_6 = 0
			local var_421_7 = 0.55

			if var_421_6 < arg_418_1.time_ and arg_418_1.time_ <= var_421_6 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_8 = arg_418_1:FormatText(StoryNameCfg[7].name)

				arg_418_1.leftNameTxt_.text = var_421_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_9 = arg_418_1:GetWordFromCfg(426091095)
				local var_421_10 = arg_418_1:FormatText(var_421_9.content)

				arg_418_1.text_.text = var_421_10

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_11 = 22
				local var_421_12 = utf8.len(var_421_10)
				local var_421_13 = var_421_11 <= 0 and var_421_7 or var_421_7 * (var_421_12 / var_421_11)

				if var_421_13 > 0 and var_421_7 < var_421_13 then
					arg_418_1.talkMaxDuration = var_421_13

					if var_421_13 + var_421_6 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_13 + var_421_6
					end
				end

				arg_418_1.text_.text = var_421_10
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_14 = math.max(var_421_7, arg_418_1.talkMaxDuration)

			if var_421_6 <= arg_418_1.time_ and arg_418_1.time_ < var_421_6 + var_421_14 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_6) / var_421_14

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_6 + var_421_14 and arg_418_1.time_ < var_421_6 + var_421_14 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play426091096 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 426091096
		arg_422_1.duration_ = 9

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play426091097(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 2

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				local var_425_1 = manager.ui.mainCamera.transform.localPosition
				local var_425_2 = Vector3.New(0, 0, 10) + Vector3.New(var_425_1.x, var_425_1.y, 0)
				local var_425_3 = arg_422_1.bgs_.ST2012

				var_425_3.transform.localPosition = var_425_2
				var_425_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_425_4 = var_425_3:GetComponent("SpriteRenderer")

				if var_425_4 and var_425_4.sprite then
					local var_425_5 = (var_425_3.transform.localPosition - var_425_1).z
					local var_425_6 = manager.ui.mainCameraCom_
					local var_425_7 = 2 * var_425_5 * Mathf.Tan(var_425_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_425_8 = var_425_7 * var_425_6.aspect
					local var_425_9 = var_425_4.sprite.bounds.size.x
					local var_425_10 = var_425_4.sprite.bounds.size.y
					local var_425_11 = var_425_8 / var_425_9
					local var_425_12 = var_425_7 / var_425_10
					local var_425_13 = var_425_12 < var_425_11 and var_425_11 or var_425_12

					var_425_3.transform.localScale = Vector3.New(var_425_13, var_425_13, 0)
				end

				for iter_425_0, iter_425_1 in pairs(arg_422_1.bgs_) do
					if iter_425_0 ~= "ST2012" then
						iter_425_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_425_14 = 4

			if var_425_14 < arg_422_1.time_ and arg_422_1.time_ <= var_425_14 + arg_425_0 then
				arg_422_1.allBtn_.enabled = false
			end

			local var_425_15 = 0.3

			if arg_422_1.time_ >= var_425_14 + var_425_15 and arg_422_1.time_ < var_425_14 + var_425_15 + arg_425_0 then
				arg_422_1.allBtn_.enabled = true
			end

			local var_425_16 = 0

			if var_425_16 < arg_422_1.time_ and arg_422_1.time_ <= var_425_16 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = true

				arg_422_1:SetGaussion(false)
			end

			local var_425_17 = 2

			if var_425_16 <= arg_422_1.time_ and arg_422_1.time_ < var_425_16 + var_425_17 then
				local var_425_18 = (arg_422_1.time_ - var_425_16) / var_425_17
				local var_425_19 = Color.New(0, 0, 0)

				var_425_19.a = Mathf.Lerp(0, 1, var_425_18)
				arg_422_1.mask_.color = var_425_19
			end

			if arg_422_1.time_ >= var_425_16 + var_425_17 and arg_422_1.time_ < var_425_16 + var_425_17 + arg_425_0 then
				local var_425_20 = Color.New(0, 0, 0)

				var_425_20.a = 1
				arg_422_1.mask_.color = var_425_20
			end

			local var_425_21 = 2

			if var_425_21 < arg_422_1.time_ and arg_422_1.time_ <= var_425_21 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = true

				arg_422_1:SetGaussion(false)
			end

			local var_425_22 = 2

			if var_425_21 <= arg_422_1.time_ and arg_422_1.time_ < var_425_21 + var_425_22 then
				local var_425_23 = (arg_422_1.time_ - var_425_21) / var_425_22
				local var_425_24 = Color.New(0, 0, 0)

				var_425_24.a = Mathf.Lerp(1, 0, var_425_23)
				arg_422_1.mask_.color = var_425_24
			end

			if arg_422_1.time_ >= var_425_21 + var_425_22 and arg_422_1.time_ < var_425_21 + var_425_22 + arg_425_0 then
				local var_425_25 = Color.New(0, 0, 0)
				local var_425_26 = 0

				arg_422_1.mask_.enabled = false
				var_425_25.a = var_425_26
				arg_422_1.mask_.color = var_425_25
			end

			local var_425_27 = arg_422_1.actors_["6148ui_story"].transform
			local var_425_28 = 2

			if var_425_28 < arg_422_1.time_ and arg_422_1.time_ <= var_425_28 + arg_425_0 then
				arg_422_1.var_.moveOldPos6148ui_story = var_425_27.localPosition

				local var_425_29 = GameObjectTools.GetOrAddComponent(var_425_27.gameObject, typeof(DynamicBoneHelper))

				if var_425_29 then
					var_425_29:EnableDynamicBone(false)
				end
			end

			local var_425_30 = 0.001

			if var_425_28 <= arg_422_1.time_ and arg_422_1.time_ < var_425_28 + var_425_30 then
				local var_425_31 = (arg_422_1.time_ - var_425_28) / var_425_30
				local var_425_32 = Vector3.New(0, 100, 0)

				var_425_27.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos6148ui_story, var_425_32, var_425_31)

				local var_425_33 = manager.ui.mainCamera.transform.position - var_425_27.position

				var_425_27.forward = Vector3.New(var_425_33.x, var_425_33.y, var_425_33.z)

				local var_425_34 = var_425_27.localEulerAngles

				var_425_34.z = 0
				var_425_34.x = 0
				var_425_27.localEulerAngles = var_425_34
			end

			if arg_422_1.time_ >= var_425_28 + var_425_30 and arg_422_1.time_ < var_425_28 + var_425_30 + arg_425_0 then
				var_425_27.localPosition = Vector3.New(0, 100, 0)

				local var_425_35 = manager.ui.mainCamera.transform.position - var_425_27.position

				var_425_27.forward = Vector3.New(var_425_35.x, var_425_35.y, var_425_35.z)

				local var_425_36 = var_425_27.localEulerAngles

				var_425_36.z = 0
				var_425_36.x = 0
				var_425_27.localEulerAngles = var_425_36

				local var_425_37 = GameObjectTools.GetOrAddComponent(var_425_27.gameObject, typeof(DynamicBoneHelper))

				if var_425_37 then
					var_425_37:EnableDynamicBone(true)
				end
			end

			local var_425_38 = 2.13333333333333
			local var_425_39 = 1

			if var_425_38 < arg_422_1.time_ and arg_422_1.time_ <= var_425_38 + arg_425_0 then
				local var_425_40 = "stop"
				local var_425_41 = "effect"

				arg_422_1:AudioAction(var_425_40, var_425_41, "se_story_150", "se_story_150_flower_field", "")
			end

			local var_425_42 = 2.5
			local var_425_43 = 1

			if var_425_42 < arg_422_1.time_ and arg_422_1.time_ <= var_425_42 + arg_425_0 then
				local var_425_44 = "play"
				local var_425_45 = "effect"

				arg_422_1:AudioAction(var_425_44, var_425_45, "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_422_1.frameCnt_ <= 1 then
				arg_422_1.dialog_:SetActive(false)
			end

			local var_425_46 = 4
			local var_425_47 = 0.5

			if var_425_46 < arg_422_1.time_ and arg_422_1.time_ <= var_425_46 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0

				arg_422_1.dialog_:SetActive(true)

				arg_422_1.dialogCg_.alpha = 0

				local var_425_48 = LeanTween.value(arg_422_1.dialog_, 0, 1, 0.3)

				var_425_48:setOnUpdate(LuaHelper.FloatAction(function(arg_426_0)
					arg_422_1.dialogCg_.alpha = arg_426_0
				end))
				var_425_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_422_1.dialog_)
					var_425_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_422_1.duration_ = arg_422_1.duration_ + 0.3

				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_49 = arg_422_1:FormatText(StoryNameCfg[7].name)

				arg_422_1.leftNameTxt_.text = var_425_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_50 = arg_422_1:GetWordFromCfg(426091096)
				local var_425_51 = arg_422_1:FormatText(var_425_50.content)

				arg_422_1.text_.text = var_425_51

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_52 = 20
				local var_425_53 = utf8.len(var_425_51)
				local var_425_54 = var_425_52 <= 0 and var_425_47 or var_425_47 * (var_425_53 / var_425_52)

				if var_425_54 > 0 and var_425_47 < var_425_54 then
					arg_422_1.talkMaxDuration = var_425_54
					var_425_46 = var_425_46 + 0.3

					if var_425_54 + var_425_46 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_54 + var_425_46
					end
				end

				arg_422_1.text_.text = var_425_51
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_55 = var_425_46 + 0.3
			local var_425_56 = math.max(var_425_47, arg_422_1.talkMaxDuration)

			if var_425_55 <= arg_422_1.time_ and arg_422_1.time_ < var_425_55 + var_425_56 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_55) / var_425_56

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_55 + var_425_56 and arg_422_1.time_ < var_425_55 + var_425_56 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play426091097 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 426091097
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play426091098(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0
			local var_431_1 = 0.4

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

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_3 = arg_428_1:GetWordFromCfg(426091097)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 16
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
	Play426091098 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 426091098
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play426091099(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 0.925

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_2 = arg_432_1:GetWordFromCfg(426091098)
				local var_435_3 = arg_432_1:FormatText(var_435_2.content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 37
				local var_435_5 = utf8.len(var_435_3)
				local var_435_6 = var_435_4 <= 0 and var_435_1 or var_435_1 * (var_435_5 / var_435_4)

				if var_435_6 > 0 and var_435_1 < var_435_6 then
					arg_432_1.talkMaxDuration = var_435_6

					if var_435_6 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_6 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_7 and arg_432_1.time_ < var_435_0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play426091099 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 426091099
		arg_436_1.duration_ = 7

		local var_436_0 = {
			zh = 7,
			ja = 6.366
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play426091100(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["6148ui_story"].transform
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.var_.moveOldPos6148ui_story = var_439_0.localPosition

				local var_439_2 = GameObjectTools.GetOrAddComponent(var_439_0.gameObject, typeof(DynamicBoneHelper))

				if var_439_2 then
					var_439_2:EnableDynamicBone(false)
				end
			end

			local var_439_3 = 0.001

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_3 then
				local var_439_4 = (arg_436_1.time_ - var_439_1) / var_439_3
				local var_439_5 = Vector3.New(0, -0.985, -6)

				var_439_0.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos6148ui_story, var_439_5, var_439_4)

				local var_439_6 = manager.ui.mainCamera.transform.position - var_439_0.position

				var_439_0.forward = Vector3.New(var_439_6.x, var_439_6.y, var_439_6.z)

				local var_439_7 = var_439_0.localEulerAngles

				var_439_7.z = 0
				var_439_7.x = 0
				var_439_0.localEulerAngles = var_439_7
			end

			if arg_436_1.time_ >= var_439_1 + var_439_3 and arg_436_1.time_ < var_439_1 + var_439_3 + arg_439_0 then
				var_439_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_439_8 = manager.ui.mainCamera.transform.position - var_439_0.position

				var_439_0.forward = Vector3.New(var_439_8.x, var_439_8.y, var_439_8.z)

				local var_439_9 = var_439_0.localEulerAngles

				var_439_9.z = 0
				var_439_9.x = 0
				var_439_0.localEulerAngles = var_439_9

				local var_439_10 = GameObjectTools.GetOrAddComponent(var_439_0.gameObject, typeof(DynamicBoneHelper))

				if var_439_10 then
					var_439_10:EnableDynamicBone(true)
				end
			end

			local var_439_11 = arg_436_1.actors_["6148ui_story"]
			local var_439_12 = 0

			if var_439_12 < arg_436_1.time_ and arg_436_1.time_ <= var_439_12 + arg_439_0 and not isNil(var_439_11) and arg_436_1.var_.characterEffect6148ui_story == nil then
				arg_436_1.var_.characterEffect6148ui_story = var_439_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_13 = 0.200000002980232

			if var_439_12 <= arg_436_1.time_ and arg_436_1.time_ < var_439_12 + var_439_13 and not isNil(var_439_11) then
				local var_439_14 = (arg_436_1.time_ - var_439_12) / var_439_13

				if arg_436_1.var_.characterEffect6148ui_story and not isNil(var_439_11) then
					arg_436_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_12 + var_439_13 and arg_436_1.time_ < var_439_12 + var_439_13 + arg_439_0 and not isNil(var_439_11) and arg_436_1.var_.characterEffect6148ui_story then
				arg_436_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_439_15 = 0

			if var_439_15 < arg_436_1.time_ and arg_436_1.time_ <= var_439_15 + arg_439_0 then
				arg_436_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_439_16 = 0

			if var_439_16 < arg_436_1.time_ and arg_436_1.time_ <= var_439_16 + arg_439_0 then
				arg_436_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_439_17 = 0
			local var_439_18 = 0.625

			if var_439_17 < arg_436_1.time_ and arg_436_1.time_ <= var_439_17 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_19 = arg_436_1:FormatText(StoryNameCfg[1488].name)

				arg_436_1.leftNameTxt_.text = var_439_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_20 = arg_436_1:GetWordFromCfg(426091099)
				local var_439_21 = arg_436_1:FormatText(var_439_20.content)

				arg_436_1.text_.text = var_439_21

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_22 = 25
				local var_439_23 = utf8.len(var_439_21)
				local var_439_24 = var_439_22 <= 0 and var_439_18 or var_439_18 * (var_439_23 / var_439_22)

				if var_439_24 > 0 and var_439_18 < var_439_24 then
					arg_436_1.talkMaxDuration = var_439_24

					if var_439_24 + var_439_17 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_24 + var_439_17
					end
				end

				arg_436_1.text_.text = var_439_21
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091099", "story_v_out_426091.awb") ~= 0 then
					local var_439_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091099", "story_v_out_426091.awb") / 1000

					if var_439_25 + var_439_17 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_25 + var_439_17
					end

					if var_439_20.prefab_name ~= "" and arg_436_1.actors_[var_439_20.prefab_name] ~= nil then
						local var_439_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_20.prefab_name].transform, "story_v_out_426091", "426091099", "story_v_out_426091.awb")

						arg_436_1:RecordAudio("426091099", var_439_26)
						arg_436_1:RecordAudio("426091099", var_439_26)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_426091", "426091099", "story_v_out_426091.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_426091", "426091099", "story_v_out_426091.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_27 = math.max(var_439_18, arg_436_1.talkMaxDuration)

			if var_439_17 <= arg_436_1.time_ and arg_436_1.time_ < var_439_17 + var_439_27 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_17) / var_439_27

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_17 + var_439_27 and arg_436_1.time_ < var_439_17 + var_439_27 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play426091100 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 426091100
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play426091101(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["6148ui_story"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect6148ui_story == nil then
				arg_440_1.var_.characterEffect6148ui_story = var_443_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.characterEffect6148ui_story and not isNil(var_443_0) then
					local var_443_4 = Mathf.Lerp(0, 0.5, var_443_3)

					arg_440_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_440_1.var_.characterEffect6148ui_story.fillRatio = var_443_4
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect6148ui_story then
				local var_443_5 = 0.5

				arg_440_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_440_1.var_.characterEffect6148ui_story.fillRatio = var_443_5
			end

			local var_443_6 = 0
			local var_443_7 = 0.2

			if var_443_6 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_8 = arg_440_1:FormatText(StoryNameCfg[7].name)

				arg_440_1.leftNameTxt_.text = var_443_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_9 = arg_440_1:GetWordFromCfg(426091100)
				local var_443_10 = arg_440_1:FormatText(var_443_9.content)

				arg_440_1.text_.text = var_443_10

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_11 = 8
				local var_443_12 = utf8.len(var_443_10)
				local var_443_13 = var_443_11 <= 0 and var_443_7 or var_443_7 * (var_443_12 / var_443_11)

				if var_443_13 > 0 and var_443_7 < var_443_13 then
					arg_440_1.talkMaxDuration = var_443_13

					if var_443_13 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_13 + var_443_6
					end
				end

				arg_440_1.text_.text = var_443_10
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_7, arg_440_1.talkMaxDuration)

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_6) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_6 + var_443_14 and arg_440_1.time_ < var_443_6 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play426091101 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 426091101
		arg_444_1.duration_ = 5.23

		local var_444_0 = {
			zh = 5.233,
			ja = 3.766
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play426091102(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["6148ui_story"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos6148ui_story = var_447_0.localPosition

				local var_447_2 = GameObjectTools.GetOrAddComponent(var_447_0.gameObject, typeof(DynamicBoneHelper))

				if var_447_2 then
					var_447_2:EnableDynamicBone(false)
				end
			end

			local var_447_3 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_3 then
				local var_447_4 = (arg_444_1.time_ - var_447_1) / var_447_3
				local var_447_5 = Vector3.New(0, -0.985, -6)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos6148ui_story, var_447_5, var_447_4)

				local var_447_6 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_6.x, var_447_6.y, var_447_6.z)

				local var_447_7 = var_447_0.localEulerAngles

				var_447_7.z = 0
				var_447_7.x = 0
				var_447_0.localEulerAngles = var_447_7
			end

			if arg_444_1.time_ >= var_447_1 + var_447_3 and arg_444_1.time_ < var_447_1 + var_447_3 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_447_8 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_8.x, var_447_8.y, var_447_8.z)

				local var_447_9 = var_447_0.localEulerAngles

				var_447_9.z = 0
				var_447_9.x = 0
				var_447_0.localEulerAngles = var_447_9

				local var_447_10 = GameObjectTools.GetOrAddComponent(var_447_0.gameObject, typeof(DynamicBoneHelper))

				if var_447_10 then
					var_447_10:EnableDynamicBone(true)
				end
			end

			local var_447_11 = arg_444_1.actors_["6148ui_story"]
			local var_447_12 = 0

			if var_447_12 < arg_444_1.time_ and arg_444_1.time_ <= var_447_12 + arg_447_0 and not isNil(var_447_11) and arg_444_1.var_.characterEffect6148ui_story == nil then
				arg_444_1.var_.characterEffect6148ui_story = var_447_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_13 = 0.200000002980232

			if var_447_12 <= arg_444_1.time_ and arg_444_1.time_ < var_447_12 + var_447_13 and not isNil(var_447_11) then
				local var_447_14 = (arg_444_1.time_ - var_447_12) / var_447_13

				if arg_444_1.var_.characterEffect6148ui_story and not isNil(var_447_11) then
					arg_444_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= var_447_12 + var_447_13 and arg_444_1.time_ < var_447_12 + var_447_13 + arg_447_0 and not isNil(var_447_11) and arg_444_1.var_.characterEffect6148ui_story then
				arg_444_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_447_15 = 0

			if var_447_15 < arg_444_1.time_ and arg_444_1.time_ <= var_447_15 + arg_447_0 then
				arg_444_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_447_16 = 0
			local var_447_17 = 0.4

			if var_447_16 < arg_444_1.time_ and arg_444_1.time_ <= var_447_16 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_18 = arg_444_1:FormatText(StoryNameCfg[1488].name)

				arg_444_1.leftNameTxt_.text = var_447_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_19 = arg_444_1:GetWordFromCfg(426091101)
				local var_447_20 = arg_444_1:FormatText(var_447_19.content)

				arg_444_1.text_.text = var_447_20

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_21 = 16
				local var_447_22 = utf8.len(var_447_20)
				local var_447_23 = var_447_21 <= 0 and var_447_17 or var_447_17 * (var_447_22 / var_447_21)

				if var_447_23 > 0 and var_447_17 < var_447_23 then
					arg_444_1.talkMaxDuration = var_447_23

					if var_447_23 + var_447_16 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_23 + var_447_16
					end
				end

				arg_444_1.text_.text = var_447_20
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091101", "story_v_out_426091.awb") ~= 0 then
					local var_447_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091101", "story_v_out_426091.awb") / 1000

					if var_447_24 + var_447_16 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_24 + var_447_16
					end

					if var_447_19.prefab_name ~= "" and arg_444_1.actors_[var_447_19.prefab_name] ~= nil then
						local var_447_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_19.prefab_name].transform, "story_v_out_426091", "426091101", "story_v_out_426091.awb")

						arg_444_1:RecordAudio("426091101", var_447_25)
						arg_444_1:RecordAudio("426091101", var_447_25)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_426091", "426091101", "story_v_out_426091.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_426091", "426091101", "story_v_out_426091.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_26 = math.max(var_447_17, arg_444_1.talkMaxDuration)

			if var_447_16 <= arg_444_1.time_ and arg_444_1.time_ < var_447_16 + var_447_26 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_16) / var_447_26

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_16 + var_447_26 and arg_444_1.time_ < var_447_16 + var_447_26 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play426091102 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 426091102
		arg_448_1.duration_ = 9.77

		local var_448_0 = {
			zh = 8.2,
			ja = 9.766
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
				arg_448_0:Play426091103(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 0.875

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_2 = arg_448_1:FormatText(StoryNameCfg[1488].name)

				arg_448_1.leftNameTxt_.text = var_451_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_3 = arg_448_1:GetWordFromCfg(426091102)
				local var_451_4 = arg_448_1:FormatText(var_451_3.content)

				arg_448_1.text_.text = var_451_4

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_5 = 35
				local var_451_6 = utf8.len(var_451_4)
				local var_451_7 = var_451_5 <= 0 and var_451_1 or var_451_1 * (var_451_6 / var_451_5)

				if var_451_7 > 0 and var_451_1 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_4
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091102", "story_v_out_426091.awb") ~= 0 then
					local var_451_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091102", "story_v_out_426091.awb") / 1000

					if var_451_8 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_8 + var_451_0
					end

					if var_451_3.prefab_name ~= "" and arg_448_1.actors_[var_451_3.prefab_name] ~= nil then
						local var_451_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_3.prefab_name].transform, "story_v_out_426091", "426091102", "story_v_out_426091.awb")

						arg_448_1:RecordAudio("426091102", var_451_9)
						arg_448_1:RecordAudio("426091102", var_451_9)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_426091", "426091102", "story_v_out_426091.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_426091", "426091102", "story_v_out_426091.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_10 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_10 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_10

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_10 and arg_448_1.time_ < var_451_0 + var_451_10 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play426091103 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 426091103
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play426091104(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["6148ui_story"].transform
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.var_.moveOldPos6148ui_story = var_455_0.localPosition

				local var_455_2 = GameObjectTools.GetOrAddComponent(var_455_0.gameObject, typeof(DynamicBoneHelper))

				if var_455_2 then
					var_455_2:EnableDynamicBone(false)
				end
			end

			local var_455_3 = 0.001

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_3 then
				local var_455_4 = (arg_452_1.time_ - var_455_1) / var_455_3
				local var_455_5 = Vector3.New(0, 100, 0)

				var_455_0.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos6148ui_story, var_455_5, var_455_4)

				local var_455_6 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_6.x, var_455_6.y, var_455_6.z)

				local var_455_7 = var_455_0.localEulerAngles

				var_455_7.z = 0
				var_455_7.x = 0
				var_455_0.localEulerAngles = var_455_7
			end

			if arg_452_1.time_ >= var_455_1 + var_455_3 and arg_452_1.time_ < var_455_1 + var_455_3 + arg_455_0 then
				var_455_0.localPosition = Vector3.New(0, 100, 0)

				local var_455_8 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_8.x, var_455_8.y, var_455_8.z)

				local var_455_9 = var_455_0.localEulerAngles

				var_455_9.z = 0
				var_455_9.x = 0
				var_455_0.localEulerAngles = var_455_9

				local var_455_10 = GameObjectTools.GetOrAddComponent(var_455_0.gameObject, typeof(DynamicBoneHelper))

				if var_455_10 then
					var_455_10:EnableDynamicBone(true)
				end
			end

			local var_455_11 = arg_452_1.actors_["6148ui_story"]
			local var_455_12 = 0

			if var_455_12 < arg_452_1.time_ and arg_452_1.time_ <= var_455_12 + arg_455_0 and not isNil(var_455_11) and arg_452_1.var_.characterEffect6148ui_story == nil then
				arg_452_1.var_.characterEffect6148ui_story = var_455_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_13 = 0.200000002980232

			if var_455_12 <= arg_452_1.time_ and arg_452_1.time_ < var_455_12 + var_455_13 and not isNil(var_455_11) then
				local var_455_14 = (arg_452_1.time_ - var_455_12) / var_455_13

				if arg_452_1.var_.characterEffect6148ui_story and not isNil(var_455_11) then
					local var_455_15 = Mathf.Lerp(0, 0.5, var_455_14)

					arg_452_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_452_1.var_.characterEffect6148ui_story.fillRatio = var_455_15
				end
			end

			if arg_452_1.time_ >= var_455_12 + var_455_13 and arg_452_1.time_ < var_455_12 + var_455_13 + arg_455_0 and not isNil(var_455_11) and arg_452_1.var_.characterEffect6148ui_story then
				local var_455_16 = 0.5

				arg_452_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_452_1.var_.characterEffect6148ui_story.fillRatio = var_455_16
			end

			local var_455_17 = 0
			local var_455_18 = 0.9

			if var_455_17 < arg_452_1.time_ and arg_452_1.time_ <= var_455_17 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_19 = arg_452_1:GetWordFromCfg(426091103)
				local var_455_20 = arg_452_1:FormatText(var_455_19.content)

				arg_452_1.text_.text = var_455_20

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_21 = 36
				local var_455_22 = utf8.len(var_455_20)
				local var_455_23 = var_455_21 <= 0 and var_455_18 or var_455_18 * (var_455_22 / var_455_21)

				if var_455_23 > 0 and var_455_18 < var_455_23 then
					arg_452_1.talkMaxDuration = var_455_23

					if var_455_23 + var_455_17 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_23 + var_455_17
					end
				end

				arg_452_1.text_.text = var_455_20
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_24 = math.max(var_455_18, arg_452_1.talkMaxDuration)

			if var_455_17 <= arg_452_1.time_ and arg_452_1.time_ < var_455_17 + var_455_24 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_17) / var_455_24

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_17 + var_455_24 and arg_452_1.time_ < var_455_17 + var_455_24 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091104 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 426091104
		arg_456_1.duration_ = 4.53

		local var_456_0 = {
			zh = 4.533,
			ja = 4.133
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play426091105(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["6148ui_story"].transform
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.var_.moveOldPos6148ui_story = var_459_0.localPosition

				local var_459_2 = GameObjectTools.GetOrAddComponent(var_459_0.gameObject, typeof(DynamicBoneHelper))

				if var_459_2 then
					var_459_2:EnableDynamicBone(false)
				end
			end

			local var_459_3 = 0.001

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_3 then
				local var_459_4 = (arg_456_1.time_ - var_459_1) / var_459_3
				local var_459_5 = Vector3.New(0, -0.985, -6)

				var_459_0.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos6148ui_story, var_459_5, var_459_4)

				local var_459_6 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_6.x, var_459_6.y, var_459_6.z)

				local var_459_7 = var_459_0.localEulerAngles

				var_459_7.z = 0
				var_459_7.x = 0
				var_459_0.localEulerAngles = var_459_7
			end

			if arg_456_1.time_ >= var_459_1 + var_459_3 and arg_456_1.time_ < var_459_1 + var_459_3 + arg_459_0 then
				var_459_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_459_8 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_8.x, var_459_8.y, var_459_8.z)

				local var_459_9 = var_459_0.localEulerAngles

				var_459_9.z = 0
				var_459_9.x = 0
				var_459_0.localEulerAngles = var_459_9

				local var_459_10 = GameObjectTools.GetOrAddComponent(var_459_0.gameObject, typeof(DynamicBoneHelper))

				if var_459_10 then
					var_459_10:EnableDynamicBone(true)
				end
			end

			local var_459_11 = arg_456_1.actors_["6148ui_story"]
			local var_459_12 = 0

			if var_459_12 < arg_456_1.time_ and arg_456_1.time_ <= var_459_12 + arg_459_0 and not isNil(var_459_11) and arg_456_1.var_.characterEffect6148ui_story == nil then
				arg_456_1.var_.characterEffect6148ui_story = var_459_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_13 = 0.200000002980232

			if var_459_12 <= arg_456_1.time_ and arg_456_1.time_ < var_459_12 + var_459_13 and not isNil(var_459_11) then
				local var_459_14 = (arg_456_1.time_ - var_459_12) / var_459_13

				if arg_456_1.var_.characterEffect6148ui_story and not isNil(var_459_11) then
					arg_456_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= var_459_12 + var_459_13 and arg_456_1.time_ < var_459_12 + var_459_13 + arg_459_0 and not isNil(var_459_11) and arg_456_1.var_.characterEffect6148ui_story then
				arg_456_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_459_15 = 0

			if var_459_15 < arg_456_1.time_ and arg_456_1.time_ <= var_459_15 + arg_459_0 then
				arg_456_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action446")
			end

			local var_459_16 = 0

			if var_459_16 < arg_456_1.time_ and arg_456_1.time_ <= var_459_16 + arg_459_0 then
				arg_456_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_459_17 = 0
			local var_459_18 = 0.425

			if var_459_17 < arg_456_1.time_ and arg_456_1.time_ <= var_459_17 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_19 = arg_456_1:FormatText(StoryNameCfg[1488].name)

				arg_456_1.leftNameTxt_.text = var_459_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_20 = arg_456_1:GetWordFromCfg(426091104)
				local var_459_21 = arg_456_1:FormatText(var_459_20.content)

				arg_456_1.text_.text = var_459_21

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_22 = 17
				local var_459_23 = utf8.len(var_459_21)
				local var_459_24 = var_459_22 <= 0 and var_459_18 or var_459_18 * (var_459_23 / var_459_22)

				if var_459_24 > 0 and var_459_18 < var_459_24 then
					arg_456_1.talkMaxDuration = var_459_24

					if var_459_24 + var_459_17 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_24 + var_459_17
					end
				end

				arg_456_1.text_.text = var_459_21
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091104", "story_v_out_426091.awb") ~= 0 then
					local var_459_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091104", "story_v_out_426091.awb") / 1000

					if var_459_25 + var_459_17 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_25 + var_459_17
					end

					if var_459_20.prefab_name ~= "" and arg_456_1.actors_[var_459_20.prefab_name] ~= nil then
						local var_459_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_20.prefab_name].transform, "story_v_out_426091", "426091104", "story_v_out_426091.awb")

						arg_456_1:RecordAudio("426091104", var_459_26)
						arg_456_1:RecordAudio("426091104", var_459_26)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_426091", "426091104", "story_v_out_426091.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_426091", "426091104", "story_v_out_426091.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_27 = math.max(var_459_18, arg_456_1.talkMaxDuration)

			if var_459_17 <= arg_456_1.time_ and arg_456_1.time_ < var_459_17 + var_459_27 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_17) / var_459_27

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_17 + var_459_27 and arg_456_1.time_ < var_459_17 + var_459_27 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play426091105 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 426091105
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play426091106(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["6148ui_story"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect6148ui_story == nil then
				arg_460_1.var_.characterEffect6148ui_story = var_463_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.characterEffect6148ui_story and not isNil(var_463_0) then
					local var_463_4 = Mathf.Lerp(0, 0.5, var_463_3)

					arg_460_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_460_1.var_.characterEffect6148ui_story.fillRatio = var_463_4
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect6148ui_story then
				local var_463_5 = 0.5

				arg_460_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_460_1.var_.characterEffect6148ui_story.fillRatio = var_463_5
			end

			local var_463_6 = 0
			local var_463_7 = 0.45

			if var_463_6 < arg_460_1.time_ and arg_460_1.time_ <= var_463_6 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_8 = arg_460_1:FormatText(StoryNameCfg[7].name)

				arg_460_1.leftNameTxt_.text = var_463_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_9 = arg_460_1:GetWordFromCfg(426091105)
				local var_463_10 = arg_460_1:FormatText(var_463_9.content)

				arg_460_1.text_.text = var_463_10

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_11 = 18
				local var_463_12 = utf8.len(var_463_10)
				local var_463_13 = var_463_11 <= 0 and var_463_7 or var_463_7 * (var_463_12 / var_463_11)

				if var_463_13 > 0 and var_463_7 < var_463_13 then
					arg_460_1.talkMaxDuration = var_463_13

					if var_463_13 + var_463_6 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_13 + var_463_6
					end
				end

				arg_460_1.text_.text = var_463_10
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_14 = math.max(var_463_7, arg_460_1.talkMaxDuration)

			if var_463_6 <= arg_460_1.time_ and arg_460_1.time_ < var_463_6 + var_463_14 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_6) / var_463_14

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_6 + var_463_14 and arg_460_1.time_ < var_463_6 + var_463_14 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play426091106 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 426091106
		arg_464_1.duration_ = 9.83

		local var_464_0 = {
			zh = 9.833,
			ja = 6.666
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play426091107(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["6148ui_story"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect6148ui_story == nil then
				arg_464_1.var_.characterEffect6148ui_story = var_467_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.200000002980232

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.characterEffect6148ui_story and not isNil(var_467_0) then
					arg_464_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect6148ui_story then
				arg_464_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_467_4 = 0

			if var_467_4 < arg_464_1.time_ and arg_464_1.time_ <= var_467_4 + arg_467_0 then
				arg_464_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action464")
			end

			local var_467_5 = 0
			local var_467_6 = 0.625

			if var_467_5 < arg_464_1.time_ and arg_464_1.time_ <= var_467_5 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_7 = arg_464_1:FormatText(StoryNameCfg[1488].name)

				arg_464_1.leftNameTxt_.text = var_467_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_8 = arg_464_1:GetWordFromCfg(426091106)
				local var_467_9 = arg_464_1:FormatText(var_467_8.content)

				arg_464_1.text_.text = var_467_9

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_10 = 25
				local var_467_11 = utf8.len(var_467_9)
				local var_467_12 = var_467_10 <= 0 and var_467_6 or var_467_6 * (var_467_11 / var_467_10)

				if var_467_12 > 0 and var_467_6 < var_467_12 then
					arg_464_1.talkMaxDuration = var_467_12

					if var_467_12 + var_467_5 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_12 + var_467_5
					end
				end

				arg_464_1.text_.text = var_467_9
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091106", "story_v_out_426091.awb") ~= 0 then
					local var_467_13 = manager.audio:GetVoiceLength("story_v_out_426091", "426091106", "story_v_out_426091.awb") / 1000

					if var_467_13 + var_467_5 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_13 + var_467_5
					end

					if var_467_8.prefab_name ~= "" and arg_464_1.actors_[var_467_8.prefab_name] ~= nil then
						local var_467_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_8.prefab_name].transform, "story_v_out_426091", "426091106", "story_v_out_426091.awb")

						arg_464_1:RecordAudio("426091106", var_467_14)
						arg_464_1:RecordAudio("426091106", var_467_14)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_426091", "426091106", "story_v_out_426091.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_426091", "426091106", "story_v_out_426091.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_15 = math.max(var_467_6, arg_464_1.talkMaxDuration)

			if var_467_5 <= arg_464_1.time_ and arg_464_1.time_ < var_467_5 + var_467_15 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_5) / var_467_15

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_5 + var_467_15 and arg_464_1.time_ < var_467_5 + var_467_15 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play426091107 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 426091107
		arg_468_1.duration_ = 8.4

		local var_468_0 = {
			zh = 8.133,
			ja = 8.4
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play426091108(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 0.75

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_2 = arg_468_1:FormatText(StoryNameCfg[1488].name)

				arg_468_1.leftNameTxt_.text = var_471_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_3 = arg_468_1:GetWordFromCfg(426091107)
				local var_471_4 = arg_468_1:FormatText(var_471_3.content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091107", "story_v_out_426091.awb") ~= 0 then
					local var_471_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091107", "story_v_out_426091.awb") / 1000

					if var_471_8 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_8 + var_471_0
					end

					if var_471_3.prefab_name ~= "" and arg_468_1.actors_[var_471_3.prefab_name] ~= nil then
						local var_471_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_3.prefab_name].transform, "story_v_out_426091", "426091107", "story_v_out_426091.awb")

						arg_468_1:RecordAudio("426091107", var_471_9)
						arg_468_1:RecordAudio("426091107", var_471_9)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_426091", "426091107", "story_v_out_426091.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_426091", "426091107", "story_v_out_426091.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_10 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_10 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_10

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_10 and arg_468_1.time_ < var_471_0 + var_471_10 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play426091108 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 426091108
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play426091109(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = arg_472_1.actors_["6148ui_story"].transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.var_.moveOldPos6148ui_story = var_475_0.localPosition

				local var_475_2 = GameObjectTools.GetOrAddComponent(var_475_0.gameObject, typeof(DynamicBoneHelper))

				if var_475_2 then
					var_475_2:EnableDynamicBone(false)
				end
			end

			local var_475_3 = 0.001

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_3 then
				local var_475_4 = (arg_472_1.time_ - var_475_1) / var_475_3
				local var_475_5 = Vector3.New(0, 100, 0)

				var_475_0.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos6148ui_story, var_475_5, var_475_4)

				local var_475_6 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_6.x, var_475_6.y, var_475_6.z)

				local var_475_7 = var_475_0.localEulerAngles

				var_475_7.z = 0
				var_475_7.x = 0
				var_475_0.localEulerAngles = var_475_7
			end

			if arg_472_1.time_ >= var_475_1 + var_475_3 and arg_472_1.time_ < var_475_1 + var_475_3 + arg_475_0 then
				var_475_0.localPosition = Vector3.New(0, 100, 0)

				local var_475_8 = manager.ui.mainCamera.transform.position - var_475_0.position

				var_475_0.forward = Vector3.New(var_475_8.x, var_475_8.y, var_475_8.z)

				local var_475_9 = var_475_0.localEulerAngles

				var_475_9.z = 0
				var_475_9.x = 0
				var_475_0.localEulerAngles = var_475_9

				local var_475_10 = GameObjectTools.GetOrAddComponent(var_475_0.gameObject, typeof(DynamicBoneHelper))

				if var_475_10 then
					var_475_10:EnableDynamicBone(true)
				end
			end

			local var_475_11 = arg_472_1.actors_["6148ui_story"]
			local var_475_12 = 0

			if var_475_12 < arg_472_1.time_ and arg_472_1.time_ <= var_475_12 + arg_475_0 and not isNil(var_475_11) and arg_472_1.var_.characterEffect6148ui_story == nil then
				arg_472_1.var_.characterEffect6148ui_story = var_475_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_13 = 0.200000002980232

			if var_475_12 <= arg_472_1.time_ and arg_472_1.time_ < var_475_12 + var_475_13 and not isNil(var_475_11) then
				local var_475_14 = (arg_472_1.time_ - var_475_12) / var_475_13

				if arg_472_1.var_.characterEffect6148ui_story and not isNil(var_475_11) then
					local var_475_15 = Mathf.Lerp(0, 0.5, var_475_14)

					arg_472_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_472_1.var_.characterEffect6148ui_story.fillRatio = var_475_15
				end
			end

			if arg_472_1.time_ >= var_475_12 + var_475_13 and arg_472_1.time_ < var_475_12 + var_475_13 + arg_475_0 and not isNil(var_475_11) and arg_472_1.var_.characterEffect6148ui_story then
				local var_475_16 = 0.5

				arg_472_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_472_1.var_.characterEffect6148ui_story.fillRatio = var_475_16
			end

			local var_475_17 = 0
			local var_475_18 = 0.675

			if var_475_17 < arg_472_1.time_ and arg_472_1.time_ <= var_475_17 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_19 = arg_472_1:GetWordFromCfg(426091108)
				local var_475_20 = arg_472_1:FormatText(var_475_19.content)

				arg_472_1.text_.text = var_475_20

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_21 = 27
				local var_475_22 = utf8.len(var_475_20)
				local var_475_23 = var_475_21 <= 0 and var_475_18 or var_475_18 * (var_475_22 / var_475_21)

				if var_475_23 > 0 and var_475_18 < var_475_23 then
					arg_472_1.talkMaxDuration = var_475_23

					if var_475_23 + var_475_17 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_23 + var_475_17
					end
				end

				arg_472_1.text_.text = var_475_20
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_24 = math.max(var_475_18, arg_472_1.talkMaxDuration)

			if var_475_17 <= arg_472_1.time_ and arg_472_1.time_ < var_475_17 + var_475_24 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_17) / var_475_24

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_17 + var_475_24 and arg_472_1.time_ < var_475_17 + var_475_24 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091109 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 426091109
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play426091110(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0
			local var_479_1 = 0.7

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_2 = arg_476_1:FormatText(StoryNameCfg[7].name)

				arg_476_1.leftNameTxt_.text = var_479_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:GetWordFromCfg(426091109)
				local var_479_4 = arg_476_1:FormatText(var_479_3.content)

				arg_476_1.text_.text = var_479_4

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 28
				local var_479_6 = utf8.len(var_479_4)
				local var_479_7 = var_479_5 <= 0 and var_479_1 or var_479_1 * (var_479_6 / var_479_5)

				if var_479_7 > 0 and var_479_1 < var_479_7 then
					arg_476_1.talkMaxDuration = var_479_7

					if var_479_7 + var_479_0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_7 + var_479_0
					end
				end

				arg_476_1.text_.text = var_479_4
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_8 = math.max(var_479_1, arg_476_1.talkMaxDuration)

			if var_479_0 <= arg_476_1.time_ and arg_476_1.time_ < var_479_0 + var_479_8 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_0) / var_479_8

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_0 + var_479_8 and arg_476_1.time_ < var_479_0 + var_479_8 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play426091110 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 426091110
		arg_480_1.duration_ = 4.97

		local var_480_0 = {
			zh = 4.966,
			ja = 4.366
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play426091111(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["6148ui_story"].transform
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.var_.moveOldPos6148ui_story = var_483_0.localPosition

				local var_483_2 = GameObjectTools.GetOrAddComponent(var_483_0.gameObject, typeof(DynamicBoneHelper))

				if var_483_2 then
					var_483_2:EnableDynamicBone(false)
				end
			end

			local var_483_3 = 0.001

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_3 then
				local var_483_4 = (arg_480_1.time_ - var_483_1) / var_483_3
				local var_483_5 = Vector3.New(0, -0.985, -6)

				var_483_0.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos6148ui_story, var_483_5, var_483_4)

				local var_483_6 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_6.x, var_483_6.y, var_483_6.z)

				local var_483_7 = var_483_0.localEulerAngles

				var_483_7.z = 0
				var_483_7.x = 0
				var_483_0.localEulerAngles = var_483_7
			end

			if arg_480_1.time_ >= var_483_1 + var_483_3 and arg_480_1.time_ < var_483_1 + var_483_3 + arg_483_0 then
				var_483_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_483_8 = manager.ui.mainCamera.transform.position - var_483_0.position

				var_483_0.forward = Vector3.New(var_483_8.x, var_483_8.y, var_483_8.z)

				local var_483_9 = var_483_0.localEulerAngles

				var_483_9.z = 0
				var_483_9.x = 0
				var_483_0.localEulerAngles = var_483_9

				local var_483_10 = GameObjectTools.GetOrAddComponent(var_483_0.gameObject, typeof(DynamicBoneHelper))

				if var_483_10 then
					var_483_10:EnableDynamicBone(true)
				end
			end

			local var_483_11 = arg_480_1.actors_["6148ui_story"]
			local var_483_12 = 0

			if var_483_12 < arg_480_1.time_ and arg_480_1.time_ <= var_483_12 + arg_483_0 and not isNil(var_483_11) and arg_480_1.var_.characterEffect6148ui_story == nil then
				arg_480_1.var_.characterEffect6148ui_story = var_483_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_13 = 0.200000002980232

			if var_483_12 <= arg_480_1.time_ and arg_480_1.time_ < var_483_12 + var_483_13 and not isNil(var_483_11) then
				local var_483_14 = (arg_480_1.time_ - var_483_12) / var_483_13

				if arg_480_1.var_.characterEffect6148ui_story and not isNil(var_483_11) then
					arg_480_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= var_483_12 + var_483_13 and arg_480_1.time_ < var_483_12 + var_483_13 + arg_483_0 and not isNil(var_483_11) and arg_480_1.var_.characterEffect6148ui_story then
				arg_480_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_483_15 = 0

			if var_483_15 < arg_480_1.time_ and arg_480_1.time_ <= var_483_15 + arg_483_0 then
				arg_480_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_483_16 = 0
			local var_483_17 = 0.35

			if var_483_16 < arg_480_1.time_ and arg_480_1.time_ <= var_483_16 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				local var_483_18 = arg_480_1:FormatText(StoryNameCfg[1488].name)

				arg_480_1.leftNameTxt_.text = var_483_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_19 = arg_480_1:GetWordFromCfg(426091110)
				local var_483_20 = arg_480_1:FormatText(var_483_19.content)

				arg_480_1.text_.text = var_483_20

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_21 = 14
				local var_483_22 = utf8.len(var_483_20)
				local var_483_23 = var_483_21 <= 0 and var_483_17 or var_483_17 * (var_483_22 / var_483_21)

				if var_483_23 > 0 and var_483_17 < var_483_23 then
					arg_480_1.talkMaxDuration = var_483_23

					if var_483_23 + var_483_16 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_23 + var_483_16
					end
				end

				arg_480_1.text_.text = var_483_20
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091110", "story_v_out_426091.awb") ~= 0 then
					local var_483_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091110", "story_v_out_426091.awb") / 1000

					if var_483_24 + var_483_16 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_24 + var_483_16
					end

					if var_483_19.prefab_name ~= "" and arg_480_1.actors_[var_483_19.prefab_name] ~= nil then
						local var_483_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_19.prefab_name].transform, "story_v_out_426091", "426091110", "story_v_out_426091.awb")

						arg_480_1:RecordAudio("426091110", var_483_25)
						arg_480_1:RecordAudio("426091110", var_483_25)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_426091", "426091110", "story_v_out_426091.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_426091", "426091110", "story_v_out_426091.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_26 = math.max(var_483_17, arg_480_1.talkMaxDuration)

			if var_483_16 <= arg_480_1.time_ and arg_480_1.time_ < var_483_16 + var_483_26 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_16) / var_483_26

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_16 + var_483_26 and arg_480_1.time_ < var_483_16 + var_483_26 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091111 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 426091111
		arg_484_1.duration_ = 9.47

		local var_484_0 = {
			zh = 9.066,
			ja = 9.466
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play426091112(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0
			local var_487_1 = 1.025

			if var_487_0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_2 = arg_484_1:FormatText(StoryNameCfg[1488].name)

				arg_484_1.leftNameTxt_.text = var_487_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_3 = arg_484_1:GetWordFromCfg(426091111)
				local var_487_4 = arg_484_1:FormatText(var_487_3.content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 41
				local var_487_6 = utf8.len(var_487_4)
				local var_487_7 = var_487_5 <= 0 and var_487_1 or var_487_1 * (var_487_6 / var_487_5)

				if var_487_7 > 0 and var_487_1 < var_487_7 then
					arg_484_1.talkMaxDuration = var_487_7

					if var_487_7 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_7 + var_487_0
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091111", "story_v_out_426091.awb") ~= 0 then
					local var_487_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091111", "story_v_out_426091.awb") / 1000

					if var_487_8 + var_487_0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_8 + var_487_0
					end

					if var_487_3.prefab_name ~= "" and arg_484_1.actors_[var_487_3.prefab_name] ~= nil then
						local var_487_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_3.prefab_name].transform, "story_v_out_426091", "426091111", "story_v_out_426091.awb")

						arg_484_1:RecordAudio("426091111", var_487_9)
						arg_484_1:RecordAudio("426091111", var_487_9)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_426091", "426091111", "story_v_out_426091.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_426091", "426091111", "story_v_out_426091.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_10 = math.max(var_487_1, arg_484_1.talkMaxDuration)

			if var_487_0 <= arg_484_1.time_ and arg_484_1.time_ < var_487_0 + var_487_10 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_0) / var_487_10

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_0 + var_487_10 and arg_484_1.time_ < var_487_0 + var_487_10 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play426091112 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 426091112
		arg_488_1.duration_ = 6.9

		local var_488_0 = {
			zh = 6.9,
			ja = 5.266
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play426091113(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0
			local var_491_1 = 0.7

			if var_491_0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_2 = arg_488_1:FormatText(StoryNameCfg[1488].name)

				arg_488_1.leftNameTxt_.text = var_491_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_3 = arg_488_1:GetWordFromCfg(426091112)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_5 = 28
				local var_491_6 = utf8.len(var_491_4)
				local var_491_7 = var_491_5 <= 0 and var_491_1 or var_491_1 * (var_491_6 / var_491_5)

				if var_491_7 > 0 and var_491_1 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_0
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091112", "story_v_out_426091.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091112", "story_v_out_426091.awb") / 1000

					if var_491_8 + var_491_0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_0
					end

					if var_491_3.prefab_name ~= "" and arg_488_1.actors_[var_491_3.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_3.prefab_name].transform, "story_v_out_426091", "426091112", "story_v_out_426091.awb")

						arg_488_1:RecordAudio("426091112", var_491_9)
						arg_488_1:RecordAudio("426091112", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_426091", "426091112", "story_v_out_426091.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_426091", "426091112", "story_v_out_426091.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_1, arg_488_1.talkMaxDuration)

			if var_491_0 <= arg_488_1.time_ and arg_488_1.time_ < var_491_0 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_0) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_0 + var_491_10 and arg_488_1.time_ < var_491_0 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play426091113 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 426091113
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play426091114(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["6148ui_story"]
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.characterEffect6148ui_story == nil then
				arg_492_1.var_.characterEffect6148ui_story = var_495_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_2 = 0.200000002980232

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_2 and not isNil(var_495_0) then
				local var_495_3 = (arg_492_1.time_ - var_495_1) / var_495_2

				if arg_492_1.var_.characterEffect6148ui_story and not isNil(var_495_0) then
					local var_495_4 = Mathf.Lerp(0, 0.5, var_495_3)

					arg_492_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_492_1.var_.characterEffect6148ui_story.fillRatio = var_495_4
				end
			end

			if arg_492_1.time_ >= var_495_1 + var_495_2 and arg_492_1.time_ < var_495_1 + var_495_2 + arg_495_0 and not isNil(var_495_0) and arg_492_1.var_.characterEffect6148ui_story then
				local var_495_5 = 0.5

				arg_492_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_492_1.var_.characterEffect6148ui_story.fillRatio = var_495_5
			end

			local var_495_6 = 0
			local var_495_7 = 0.675

			if var_495_6 < arg_492_1.time_ and arg_492_1.time_ <= var_495_6 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				local var_495_8 = arg_492_1:FormatText(StoryNameCfg[7].name)

				arg_492_1.leftNameTxt_.text = var_495_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_9 = arg_492_1:GetWordFromCfg(426091113)
				local var_495_10 = arg_492_1:FormatText(var_495_9.content)

				arg_492_1.text_.text = var_495_10

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_11 = 27
				local var_495_12 = utf8.len(var_495_10)
				local var_495_13 = var_495_11 <= 0 and var_495_7 or var_495_7 * (var_495_12 / var_495_11)

				if var_495_13 > 0 and var_495_7 < var_495_13 then
					arg_492_1.talkMaxDuration = var_495_13

					if var_495_13 + var_495_6 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_13 + var_495_6
					end
				end

				arg_492_1.text_.text = var_495_10
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_14 = math.max(var_495_7, arg_492_1.talkMaxDuration)

			if var_495_6 <= arg_492_1.time_ and arg_492_1.time_ < var_495_6 + var_495_14 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_6) / var_495_14

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_6 + var_495_14 and arg_492_1.time_ < var_495_6 + var_495_14 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play426091114 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 426091114
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play426091115(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0
			local var_499_1 = 0.825

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

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_3 = arg_496_1:GetWordFromCfg(426091114)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_5 = 33
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
	Play426091115 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 426091115
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play426091116(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.6

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

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_3 = arg_500_1:GetWordFromCfg(426091115)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 24
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
	Play426091116 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 426091116
		arg_504_1.duration_ = 2

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play426091117(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = arg_504_1.actors_["6148ui_story"].transform
			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 then
				arg_504_1.var_.moveOldPos6148ui_story = var_507_0.localPosition

				local var_507_2 = GameObjectTools.GetOrAddComponent(var_507_0.gameObject, typeof(DynamicBoneHelper))

				if var_507_2 then
					var_507_2:EnableDynamicBone(false)
				end
			end

			local var_507_3 = 0.001

			if var_507_1 <= arg_504_1.time_ and arg_504_1.time_ < var_507_1 + var_507_3 then
				local var_507_4 = (arg_504_1.time_ - var_507_1) / var_507_3
				local var_507_5 = Vector3.New(0, -0.985, -6)

				var_507_0.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos6148ui_story, var_507_5, var_507_4)

				local var_507_6 = manager.ui.mainCamera.transform.position - var_507_0.position

				var_507_0.forward = Vector3.New(var_507_6.x, var_507_6.y, var_507_6.z)

				local var_507_7 = var_507_0.localEulerAngles

				var_507_7.z = 0
				var_507_7.x = 0
				var_507_0.localEulerAngles = var_507_7
			end

			if arg_504_1.time_ >= var_507_1 + var_507_3 and arg_504_1.time_ < var_507_1 + var_507_3 + arg_507_0 then
				var_507_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_507_8 = manager.ui.mainCamera.transform.position - var_507_0.position

				var_507_0.forward = Vector3.New(var_507_8.x, var_507_8.y, var_507_8.z)

				local var_507_9 = var_507_0.localEulerAngles

				var_507_9.z = 0
				var_507_9.x = 0
				var_507_0.localEulerAngles = var_507_9

				local var_507_10 = GameObjectTools.GetOrAddComponent(var_507_0.gameObject, typeof(DynamicBoneHelper))

				if var_507_10 then
					var_507_10:EnableDynamicBone(true)
				end
			end

			local var_507_11 = arg_504_1.actors_["6148ui_story"]
			local var_507_12 = 0

			if var_507_12 < arg_504_1.time_ and arg_504_1.time_ <= var_507_12 + arg_507_0 and not isNil(var_507_11) and arg_504_1.var_.characterEffect6148ui_story == nil then
				arg_504_1.var_.characterEffect6148ui_story = var_507_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_13 = 0.200000002980232

			if var_507_12 <= arg_504_1.time_ and arg_504_1.time_ < var_507_12 + var_507_13 and not isNil(var_507_11) then
				local var_507_14 = (arg_504_1.time_ - var_507_12) / var_507_13

				if arg_504_1.var_.characterEffect6148ui_story and not isNil(var_507_11) then
					arg_504_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= var_507_12 + var_507_13 and arg_504_1.time_ < var_507_12 + var_507_13 + arg_507_0 and not isNil(var_507_11) and arg_504_1.var_.characterEffect6148ui_story then
				arg_504_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_507_15 = 0

			if var_507_15 < arg_504_1.time_ and arg_504_1.time_ <= var_507_15 + arg_507_0 then
				arg_504_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_507_16 = 0
			local var_507_17 = 0.075

			if var_507_16 < arg_504_1.time_ and arg_504_1.time_ <= var_507_16 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_18 = arg_504_1:FormatText(StoryNameCfg[1488].name)

				arg_504_1.leftNameTxt_.text = var_507_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_19 = arg_504_1:GetWordFromCfg(426091116)
				local var_507_20 = arg_504_1:FormatText(var_507_19.content)

				arg_504_1.text_.text = var_507_20

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_21 = 3
				local var_507_22 = utf8.len(var_507_20)
				local var_507_23 = var_507_21 <= 0 and var_507_17 or var_507_17 * (var_507_22 / var_507_21)

				if var_507_23 > 0 and var_507_17 < var_507_23 then
					arg_504_1.talkMaxDuration = var_507_23

					if var_507_23 + var_507_16 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_23 + var_507_16
					end
				end

				arg_504_1.text_.text = var_507_20
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091116", "story_v_out_426091.awb") ~= 0 then
					local var_507_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091116", "story_v_out_426091.awb") / 1000

					if var_507_24 + var_507_16 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_24 + var_507_16
					end

					if var_507_19.prefab_name ~= "" and arg_504_1.actors_[var_507_19.prefab_name] ~= nil then
						local var_507_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_19.prefab_name].transform, "story_v_out_426091", "426091116", "story_v_out_426091.awb")

						arg_504_1:RecordAudio("426091116", var_507_25)
						arg_504_1:RecordAudio("426091116", var_507_25)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_426091", "426091116", "story_v_out_426091.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_426091", "426091116", "story_v_out_426091.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_26 = math.max(var_507_17, arg_504_1.talkMaxDuration)

			if var_507_16 <= arg_504_1.time_ and arg_504_1.time_ < var_507_16 + var_507_26 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_16) / var_507_26

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_16 + var_507_26 and arg_504_1.time_ < var_507_16 + var_507_26 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091117 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 426091117
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play426091118(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["6148ui_story"]
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect6148ui_story == nil then
				arg_508_1.var_.characterEffect6148ui_story = var_511_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_2 = 0.200000002980232

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_2 and not isNil(var_511_0) then
				local var_511_3 = (arg_508_1.time_ - var_511_1) / var_511_2

				if arg_508_1.var_.characterEffect6148ui_story and not isNil(var_511_0) then
					local var_511_4 = Mathf.Lerp(0, 0.5, var_511_3)

					arg_508_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_508_1.var_.characterEffect6148ui_story.fillRatio = var_511_4
				end
			end

			if arg_508_1.time_ >= var_511_1 + var_511_2 and arg_508_1.time_ < var_511_1 + var_511_2 + arg_511_0 and not isNil(var_511_0) and arg_508_1.var_.characterEffect6148ui_story then
				local var_511_5 = 0.5

				arg_508_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_508_1.var_.characterEffect6148ui_story.fillRatio = var_511_5
			end

			local var_511_6 = 0
			local var_511_7 = 0.55

			if var_511_6 < arg_508_1.time_ and arg_508_1.time_ <= var_511_6 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_8 = arg_508_1:FormatText(StoryNameCfg[7].name)

				arg_508_1.leftNameTxt_.text = var_511_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_9 = arg_508_1:GetWordFromCfg(426091117)
				local var_511_10 = arg_508_1:FormatText(var_511_9.content)

				arg_508_1.text_.text = var_511_10

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_11 = 22
				local var_511_12 = utf8.len(var_511_10)
				local var_511_13 = var_511_11 <= 0 and var_511_7 or var_511_7 * (var_511_12 / var_511_11)

				if var_511_13 > 0 and var_511_7 < var_511_13 then
					arg_508_1.talkMaxDuration = var_511_13

					if var_511_13 + var_511_6 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_13 + var_511_6
					end
				end

				arg_508_1.text_.text = var_511_10
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_14 = math.max(var_511_7, arg_508_1.talkMaxDuration)

			if var_511_6 <= arg_508_1.time_ and arg_508_1.time_ < var_511_6 + var_511_14 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_6) / var_511_14

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_6 + var_511_14 and arg_508_1.time_ < var_511_6 + var_511_14 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play426091118 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 426091118
		arg_512_1.duration_ = 8

		local var_512_0 = {
			zh = 8,
			ja = 6.766
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play426091119(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = arg_512_1.actors_["6148ui_story"].transform
			local var_515_1 = 0

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.var_.moveOldPos6148ui_story = var_515_0.localPosition

				local var_515_2 = GameObjectTools.GetOrAddComponent(var_515_0.gameObject, typeof(DynamicBoneHelper))

				if var_515_2 then
					var_515_2:EnableDynamicBone(false)
				end
			end

			local var_515_3 = 0.001

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_3 then
				local var_515_4 = (arg_512_1.time_ - var_515_1) / var_515_3
				local var_515_5 = Vector3.New(0, -0.985, -6)

				var_515_0.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos6148ui_story, var_515_5, var_515_4)

				local var_515_6 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_6.x, var_515_6.y, var_515_6.z)

				local var_515_7 = var_515_0.localEulerAngles

				var_515_7.z = 0
				var_515_7.x = 0
				var_515_0.localEulerAngles = var_515_7
			end

			if arg_512_1.time_ >= var_515_1 + var_515_3 and arg_512_1.time_ < var_515_1 + var_515_3 + arg_515_0 then
				var_515_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_515_8 = manager.ui.mainCamera.transform.position - var_515_0.position

				var_515_0.forward = Vector3.New(var_515_8.x, var_515_8.y, var_515_8.z)

				local var_515_9 = var_515_0.localEulerAngles

				var_515_9.z = 0
				var_515_9.x = 0
				var_515_0.localEulerAngles = var_515_9

				local var_515_10 = GameObjectTools.GetOrAddComponent(var_515_0.gameObject, typeof(DynamicBoneHelper))

				if var_515_10 then
					var_515_10:EnableDynamicBone(true)
				end
			end

			local var_515_11 = arg_512_1.actors_["6148ui_story"]
			local var_515_12 = 0

			if var_515_12 < arg_512_1.time_ and arg_512_1.time_ <= var_515_12 + arg_515_0 and not isNil(var_515_11) and arg_512_1.var_.characterEffect6148ui_story == nil then
				arg_512_1.var_.characterEffect6148ui_story = var_515_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_13 = 0.200000002980232

			if var_515_12 <= arg_512_1.time_ and arg_512_1.time_ < var_515_12 + var_515_13 and not isNil(var_515_11) then
				local var_515_14 = (arg_512_1.time_ - var_515_12) / var_515_13

				if arg_512_1.var_.characterEffect6148ui_story and not isNil(var_515_11) then
					arg_512_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= var_515_12 + var_515_13 and arg_512_1.time_ < var_515_12 + var_515_13 + arg_515_0 and not isNil(var_515_11) and arg_512_1.var_.characterEffect6148ui_story then
				arg_512_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_515_15 = 0

			if var_515_15 < arg_512_1.time_ and arg_512_1.time_ <= var_515_15 + arg_515_0 then
				arg_512_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action464")
			end

			local var_515_16 = 0
			local var_515_17 = 0.925

			if var_515_16 < arg_512_1.time_ and arg_512_1.time_ <= var_515_16 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_18 = arg_512_1:FormatText(StoryNameCfg[1488].name)

				arg_512_1.leftNameTxt_.text = var_515_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_19 = arg_512_1:GetWordFromCfg(426091118)
				local var_515_20 = arg_512_1:FormatText(var_515_19.content)

				arg_512_1.text_.text = var_515_20

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_21 = 37
				local var_515_22 = utf8.len(var_515_20)
				local var_515_23 = var_515_21 <= 0 and var_515_17 or var_515_17 * (var_515_22 / var_515_21)

				if var_515_23 > 0 and var_515_17 < var_515_23 then
					arg_512_1.talkMaxDuration = var_515_23

					if var_515_23 + var_515_16 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_23 + var_515_16
					end
				end

				arg_512_1.text_.text = var_515_20
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091118", "story_v_out_426091.awb") ~= 0 then
					local var_515_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091118", "story_v_out_426091.awb") / 1000

					if var_515_24 + var_515_16 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_24 + var_515_16
					end

					if var_515_19.prefab_name ~= "" and arg_512_1.actors_[var_515_19.prefab_name] ~= nil then
						local var_515_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_19.prefab_name].transform, "story_v_out_426091", "426091118", "story_v_out_426091.awb")

						arg_512_1:RecordAudio("426091118", var_515_25)
						arg_512_1:RecordAudio("426091118", var_515_25)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_426091", "426091118", "story_v_out_426091.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_426091", "426091118", "story_v_out_426091.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_26 = math.max(var_515_17, arg_512_1.talkMaxDuration)

			if var_515_16 <= arg_512_1.time_ and arg_512_1.time_ < var_515_16 + var_515_26 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_16) / var_515_26

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_16 + var_515_26 and arg_512_1.time_ < var_515_16 + var_515_26 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091119 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 426091119
		arg_516_1.duration_ = 8.73

		local var_516_0 = {
			zh = 5.133,
			ja = 8.733
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
				arg_516_0:Play426091120(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0
			local var_519_1 = 0.525

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				local var_519_2 = arg_516_1:FormatText(StoryNameCfg[1488].name)

				arg_516_1.leftNameTxt_.text = var_519_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_3 = arg_516_1:GetWordFromCfg(426091119)
				local var_519_4 = arg_516_1:FormatText(var_519_3.content)

				arg_516_1.text_.text = var_519_4

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_5 = 21
				local var_519_6 = utf8.len(var_519_4)
				local var_519_7 = var_519_5 <= 0 and var_519_1 or var_519_1 * (var_519_6 / var_519_5)

				if var_519_7 > 0 and var_519_1 < var_519_7 then
					arg_516_1.talkMaxDuration = var_519_7

					if var_519_7 + var_519_0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_7 + var_519_0
					end
				end

				arg_516_1.text_.text = var_519_4
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091119", "story_v_out_426091.awb") ~= 0 then
					local var_519_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091119", "story_v_out_426091.awb") / 1000

					if var_519_8 + var_519_0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_8 + var_519_0
					end

					if var_519_3.prefab_name ~= "" and arg_516_1.actors_[var_519_3.prefab_name] ~= nil then
						local var_519_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_3.prefab_name].transform, "story_v_out_426091", "426091119", "story_v_out_426091.awb")

						arg_516_1:RecordAudio("426091119", var_519_9)
						arg_516_1:RecordAudio("426091119", var_519_9)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_426091", "426091119", "story_v_out_426091.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_426091", "426091119", "story_v_out_426091.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_10 = math.max(var_519_1, arg_516_1.talkMaxDuration)

			if var_519_0 <= arg_516_1.time_ and arg_516_1.time_ < var_519_0 + var_519_10 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_0) / var_519_10

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_0 + var_519_10 and arg_516_1.time_ < var_519_0 + var_519_10 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play426091120 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 426091120
		arg_520_1.duration_ = 18.93

		local var_520_0 = {
			zh = 16.266,
			ja = 18.933
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play426091121(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 1.25

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_2 = arg_520_1:FormatText(StoryNameCfg[1488].name)

				arg_520_1.leftNameTxt_.text = var_523_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_3 = arg_520_1:GetWordFromCfg(426091120)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 50
				local var_523_6 = utf8.len(var_523_4)
				local var_523_7 = var_523_5 <= 0 and var_523_1 or var_523_1 * (var_523_6 / var_523_5)

				if var_523_7 > 0 and var_523_1 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_0
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091120", "story_v_out_426091.awb") ~= 0 then
					local var_523_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091120", "story_v_out_426091.awb") / 1000

					if var_523_8 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_8 + var_523_0
					end

					if var_523_3.prefab_name ~= "" and arg_520_1.actors_[var_523_3.prefab_name] ~= nil then
						local var_523_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_3.prefab_name].transform, "story_v_out_426091", "426091120", "story_v_out_426091.awb")

						arg_520_1:RecordAudio("426091120", var_523_9)
						arg_520_1:RecordAudio("426091120", var_523_9)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_426091", "426091120", "story_v_out_426091.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_426091", "426091120", "story_v_out_426091.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_10 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_10 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_10

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_10 and arg_520_1.time_ < var_523_0 + var_523_10 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play426091121 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 426091121
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play426091122(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["6148ui_story"]
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect6148ui_story == nil then
				arg_524_1.var_.characterEffect6148ui_story = var_527_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_2 = 0.200000002980232

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_2 and not isNil(var_527_0) then
				local var_527_3 = (arg_524_1.time_ - var_527_1) / var_527_2

				if arg_524_1.var_.characterEffect6148ui_story and not isNil(var_527_0) then
					local var_527_4 = Mathf.Lerp(0, 0.5, var_527_3)

					arg_524_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_524_1.var_.characterEffect6148ui_story.fillRatio = var_527_4
				end
			end

			if arg_524_1.time_ >= var_527_1 + var_527_2 and arg_524_1.time_ < var_527_1 + var_527_2 + arg_527_0 and not isNil(var_527_0) and arg_524_1.var_.characterEffect6148ui_story then
				local var_527_5 = 0.5

				arg_524_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_524_1.var_.characterEffect6148ui_story.fillRatio = var_527_5
			end

			local var_527_6 = 0
			local var_527_7 = 0.45

			if var_527_6 < arg_524_1.time_ and arg_524_1.time_ <= var_527_6 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_8 = arg_524_1:FormatText(StoryNameCfg[7].name)

				arg_524_1.leftNameTxt_.text = var_527_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_9 = arg_524_1:GetWordFromCfg(426091121)
				local var_527_10 = arg_524_1:FormatText(var_527_9.content)

				arg_524_1.text_.text = var_527_10

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_11 = 18
				local var_527_12 = utf8.len(var_527_10)
				local var_527_13 = var_527_11 <= 0 and var_527_7 or var_527_7 * (var_527_12 / var_527_11)

				if var_527_13 > 0 and var_527_7 < var_527_13 then
					arg_524_1.talkMaxDuration = var_527_13

					if var_527_13 + var_527_6 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_13 + var_527_6
					end
				end

				arg_524_1.text_.text = var_527_10
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_14 = math.max(var_527_7, arg_524_1.talkMaxDuration)

			if var_527_6 <= arg_524_1.time_ and arg_524_1.time_ < var_527_6 + var_527_14 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_6) / var_527_14

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_6 + var_527_14 and arg_524_1.time_ < var_527_6 + var_527_14 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play426091122 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 426091122
		arg_528_1.duration_ = 12.3

		local var_528_0 = {
			zh = 12.3,
			ja = 9.466
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
				arg_528_0:Play426091123(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["6148ui_story"].transform
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 then
				arg_528_1.var_.moveOldPos6148ui_story = var_531_0.localPosition

				local var_531_2 = GameObjectTools.GetOrAddComponent(var_531_0.gameObject, typeof(DynamicBoneHelper))

				if var_531_2 then
					var_531_2:EnableDynamicBone(false)
				end
			end

			local var_531_3 = 0.001

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_3 then
				local var_531_4 = (arg_528_1.time_ - var_531_1) / var_531_3
				local var_531_5 = Vector3.New(0, -0.985, -6)

				var_531_0.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos6148ui_story, var_531_5, var_531_4)

				local var_531_6 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_6.x, var_531_6.y, var_531_6.z)

				local var_531_7 = var_531_0.localEulerAngles

				var_531_7.z = 0
				var_531_7.x = 0
				var_531_0.localEulerAngles = var_531_7
			end

			if arg_528_1.time_ >= var_531_1 + var_531_3 and arg_528_1.time_ < var_531_1 + var_531_3 + arg_531_0 then
				var_531_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_531_8 = manager.ui.mainCamera.transform.position - var_531_0.position

				var_531_0.forward = Vector3.New(var_531_8.x, var_531_8.y, var_531_8.z)

				local var_531_9 = var_531_0.localEulerAngles

				var_531_9.z = 0
				var_531_9.x = 0
				var_531_0.localEulerAngles = var_531_9

				local var_531_10 = GameObjectTools.GetOrAddComponent(var_531_0.gameObject, typeof(DynamicBoneHelper))

				if var_531_10 then
					var_531_10:EnableDynamicBone(true)
				end
			end

			local var_531_11 = arg_528_1.actors_["6148ui_story"]
			local var_531_12 = 0

			if var_531_12 < arg_528_1.time_ and arg_528_1.time_ <= var_531_12 + arg_531_0 and not isNil(var_531_11) and arg_528_1.var_.characterEffect6148ui_story == nil then
				arg_528_1.var_.characterEffect6148ui_story = var_531_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_13 = 0.200000002980232

			if var_531_12 <= arg_528_1.time_ and arg_528_1.time_ < var_531_12 + var_531_13 and not isNil(var_531_11) then
				local var_531_14 = (arg_528_1.time_ - var_531_12) / var_531_13

				if arg_528_1.var_.characterEffect6148ui_story and not isNil(var_531_11) then
					arg_528_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= var_531_12 + var_531_13 and arg_528_1.time_ < var_531_12 + var_531_13 + arg_531_0 and not isNil(var_531_11) and arg_528_1.var_.characterEffect6148ui_story then
				arg_528_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_531_15 = 0

			if var_531_15 < arg_528_1.time_ and arg_528_1.time_ <= var_531_15 + arg_531_0 then
				arg_528_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_531_16 = 0
			local var_531_17 = 0.925

			if var_531_16 < arg_528_1.time_ and arg_528_1.time_ <= var_531_16 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_18 = arg_528_1:FormatText(StoryNameCfg[1488].name)

				arg_528_1.leftNameTxt_.text = var_531_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_19 = arg_528_1:GetWordFromCfg(426091122)
				local var_531_20 = arg_528_1:FormatText(var_531_19.content)

				arg_528_1.text_.text = var_531_20

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_21 = 37
				local var_531_22 = utf8.len(var_531_20)
				local var_531_23 = var_531_21 <= 0 and var_531_17 or var_531_17 * (var_531_22 / var_531_21)

				if var_531_23 > 0 and var_531_17 < var_531_23 then
					arg_528_1.talkMaxDuration = var_531_23

					if var_531_23 + var_531_16 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_23 + var_531_16
					end
				end

				arg_528_1.text_.text = var_531_20
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091122", "story_v_out_426091.awb") ~= 0 then
					local var_531_24 = manager.audio:GetVoiceLength("story_v_out_426091", "426091122", "story_v_out_426091.awb") / 1000

					if var_531_24 + var_531_16 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_24 + var_531_16
					end

					if var_531_19.prefab_name ~= "" and arg_528_1.actors_[var_531_19.prefab_name] ~= nil then
						local var_531_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_19.prefab_name].transform, "story_v_out_426091", "426091122", "story_v_out_426091.awb")

						arg_528_1:RecordAudio("426091122", var_531_25)
						arg_528_1:RecordAudio("426091122", var_531_25)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_426091", "426091122", "story_v_out_426091.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_426091", "426091122", "story_v_out_426091.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_26 = math.max(var_531_17, arg_528_1.talkMaxDuration)

			if var_531_16 <= arg_528_1.time_ and arg_528_1.time_ < var_531_16 + var_531_26 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_16) / var_531_26

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_16 + var_531_26 and arg_528_1.time_ < var_531_16 + var_531_26 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091123 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 426091123
		arg_532_1.duration_ = 18.43

		local var_532_0 = {
			zh = 14.766,
			ja = 18.433
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play426091124(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 1.175

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[1488].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_3 = arg_532_1:GetWordFromCfg(426091123)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 47
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091123", "story_v_out_426091.awb") ~= 0 then
					local var_535_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091123", "story_v_out_426091.awb") / 1000

					if var_535_8 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_8 + var_535_0
					end

					if var_535_3.prefab_name ~= "" and arg_532_1.actors_[var_535_3.prefab_name] ~= nil then
						local var_535_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_3.prefab_name].transform, "story_v_out_426091", "426091123", "story_v_out_426091.awb")

						arg_532_1:RecordAudio("426091123", var_535_9)
						arg_532_1:RecordAudio("426091123", var_535_9)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_426091", "426091123", "story_v_out_426091.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_426091", "426091123", "story_v_out_426091.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_10 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_10 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_10

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_10 and arg_532_1.time_ < var_535_0 + var_535_10 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play426091124 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 426091124
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play426091125(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["6148ui_story"]
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.characterEffect6148ui_story == nil then
				arg_536_1.var_.characterEffect6148ui_story = var_539_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_2 = 0.200000002980232

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 and not isNil(var_539_0) then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2

				if arg_536_1.var_.characterEffect6148ui_story and not isNil(var_539_0) then
					local var_539_4 = Mathf.Lerp(0, 0.5, var_539_3)

					arg_536_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_536_1.var_.characterEffect6148ui_story.fillRatio = var_539_4
				end
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.characterEffect6148ui_story then
				local var_539_5 = 0.5

				arg_536_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_536_1.var_.characterEffect6148ui_story.fillRatio = var_539_5
			end

			local var_539_6 = 0
			local var_539_7 = 0.525

			if var_539_6 < arg_536_1.time_ and arg_536_1.time_ <= var_539_6 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_8 = arg_536_1:FormatText(StoryNameCfg[7].name)

				arg_536_1.leftNameTxt_.text = var_539_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_9 = arg_536_1:GetWordFromCfg(426091124)
				local var_539_10 = arg_536_1:FormatText(var_539_9.content)

				arg_536_1.text_.text = var_539_10

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_11 = 21
				local var_539_12 = utf8.len(var_539_10)
				local var_539_13 = var_539_11 <= 0 and var_539_7 or var_539_7 * (var_539_12 / var_539_11)

				if var_539_13 > 0 and var_539_7 < var_539_13 then
					arg_536_1.talkMaxDuration = var_539_13

					if var_539_13 + var_539_6 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_13 + var_539_6
					end
				end

				arg_536_1.text_.text = var_539_10
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_14 = math.max(var_539_7, arg_536_1.talkMaxDuration)

			if var_539_6 <= arg_536_1.time_ and arg_536_1.time_ < var_539_6 + var_539_14 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_6) / var_539_14

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_6 + var_539_14 and arg_536_1.time_ < var_539_6 + var_539_14 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play426091125 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 426091125
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play426091126(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["6148ui_story"].transform
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 then
				arg_540_1.var_.moveOldPos6148ui_story = var_543_0.localPosition

				local var_543_2 = GameObjectTools.GetOrAddComponent(var_543_0.gameObject, typeof(DynamicBoneHelper))

				if var_543_2 then
					var_543_2:EnableDynamicBone(false)
				end
			end

			local var_543_3 = 0.001

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_3 then
				local var_543_4 = (arg_540_1.time_ - var_543_1) / var_543_3
				local var_543_5 = Vector3.New(0, 100, 0)

				var_543_0.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos6148ui_story, var_543_5, var_543_4)

				local var_543_6 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_6.x, var_543_6.y, var_543_6.z)

				local var_543_7 = var_543_0.localEulerAngles

				var_543_7.z = 0
				var_543_7.x = 0
				var_543_0.localEulerAngles = var_543_7
			end

			if arg_540_1.time_ >= var_543_1 + var_543_3 and arg_540_1.time_ < var_543_1 + var_543_3 + arg_543_0 then
				var_543_0.localPosition = Vector3.New(0, 100, 0)

				local var_543_8 = manager.ui.mainCamera.transform.position - var_543_0.position

				var_543_0.forward = Vector3.New(var_543_8.x, var_543_8.y, var_543_8.z)

				local var_543_9 = var_543_0.localEulerAngles

				var_543_9.z = 0
				var_543_9.x = 0
				var_543_0.localEulerAngles = var_543_9

				local var_543_10 = GameObjectTools.GetOrAddComponent(var_543_0.gameObject, typeof(DynamicBoneHelper))

				if var_543_10 then
					var_543_10:EnableDynamicBone(true)
				end
			end

			local var_543_11 = 0
			local var_543_12 = 0.7

			if var_543_11 < arg_540_1.time_ and arg_540_1.time_ <= var_543_11 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_13 = arg_540_1:GetWordFromCfg(426091125)
				local var_543_14 = arg_540_1:FormatText(var_543_13.content)

				arg_540_1.text_.text = var_543_14

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_15 = 28
				local var_543_16 = utf8.len(var_543_14)
				local var_543_17 = var_543_15 <= 0 and var_543_12 or var_543_12 * (var_543_16 / var_543_15)

				if var_543_17 > 0 and var_543_12 < var_543_17 then
					arg_540_1.talkMaxDuration = var_543_17

					if var_543_17 + var_543_11 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_17 + var_543_11
					end
				end

				arg_540_1.text_.text = var_543_14
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_18 = math.max(var_543_12, arg_540_1.talkMaxDuration)

			if var_543_11 <= arg_540_1.time_ and arg_540_1.time_ < var_543_11 + var_543_18 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_11) / var_543_18

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_11 + var_543_18 and arg_540_1.time_ < var_543_11 + var_543_18 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_540_1:InitPlayNodeList()
	end,
	Play426091126 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 426091126
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play426091127(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0
			local var_547_1 = 0.475

			if var_547_0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_2 = arg_544_1:FormatText(StoryNameCfg[7].name)

				arg_544_1.leftNameTxt_.text = var_547_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_3 = arg_544_1:GetWordFromCfg(426091126)
				local var_547_4 = arg_544_1:FormatText(var_547_3.content)

				arg_544_1.text_.text = var_547_4

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_5 = 19
				local var_547_6 = utf8.len(var_547_4)
				local var_547_7 = var_547_5 <= 0 and var_547_1 or var_547_1 * (var_547_6 / var_547_5)

				if var_547_7 > 0 and var_547_1 < var_547_7 then
					arg_544_1.talkMaxDuration = var_547_7

					if var_547_7 + var_547_0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_7 + var_547_0
					end
				end

				arg_544_1.text_.text = var_547_4
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_8 = math.max(var_547_1, arg_544_1.talkMaxDuration)

			if var_547_0 <= arg_544_1.time_ and arg_544_1.time_ < var_547_0 + var_547_8 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_0) / var_547_8

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_0 + var_547_8 and arg_544_1.time_ < var_547_0 + var_547_8 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play426091127 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 426091127
		arg_548_1.duration_ = 8.33

		local var_548_0 = {
			zh = 7.166,
			ja = 8.333
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play426091128(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["6148ui_story"].transform
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 then
				arg_548_1.var_.moveOldPos6148ui_story = var_551_0.localPosition

				local var_551_2 = GameObjectTools.GetOrAddComponent(var_551_0.gameObject, typeof(DynamicBoneHelper))

				if var_551_2 then
					var_551_2:EnableDynamicBone(false)
				end
			end

			local var_551_3 = 0.001

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_3 then
				local var_551_4 = (arg_548_1.time_ - var_551_1) / var_551_3
				local var_551_5 = Vector3.New(0, -0.985, -6)

				var_551_0.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos6148ui_story, var_551_5, var_551_4)

				local var_551_6 = manager.ui.mainCamera.transform.position - var_551_0.position

				var_551_0.forward = Vector3.New(var_551_6.x, var_551_6.y, var_551_6.z)

				local var_551_7 = var_551_0.localEulerAngles

				var_551_7.z = 0
				var_551_7.x = 0
				var_551_0.localEulerAngles = var_551_7
			end

			if arg_548_1.time_ >= var_551_1 + var_551_3 and arg_548_1.time_ < var_551_1 + var_551_3 + arg_551_0 then
				var_551_0.localPosition = Vector3.New(0, -0.985, -6)

				local var_551_8 = manager.ui.mainCamera.transform.position - var_551_0.position

				var_551_0.forward = Vector3.New(var_551_8.x, var_551_8.y, var_551_8.z)

				local var_551_9 = var_551_0.localEulerAngles

				var_551_9.z = 0
				var_551_9.x = 0
				var_551_0.localEulerAngles = var_551_9

				local var_551_10 = GameObjectTools.GetOrAddComponent(var_551_0.gameObject, typeof(DynamicBoneHelper))

				if var_551_10 then
					var_551_10:EnableDynamicBone(true)
				end
			end

			local var_551_11 = arg_548_1.actors_["6148ui_story"]
			local var_551_12 = 0

			if var_551_12 < arg_548_1.time_ and arg_548_1.time_ <= var_551_12 + arg_551_0 and not isNil(var_551_11) and arg_548_1.var_.characterEffect6148ui_story == nil then
				arg_548_1.var_.characterEffect6148ui_story = var_551_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_13 = 0.200000002980232

			if var_551_12 <= arg_548_1.time_ and arg_548_1.time_ < var_551_12 + var_551_13 and not isNil(var_551_11) then
				local var_551_14 = (arg_548_1.time_ - var_551_12) / var_551_13

				if arg_548_1.var_.characterEffect6148ui_story and not isNil(var_551_11) then
					arg_548_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_548_1.time_ >= var_551_12 + var_551_13 and arg_548_1.time_ < var_551_12 + var_551_13 + arg_551_0 and not isNil(var_551_11) and arg_548_1.var_.characterEffect6148ui_story then
				arg_548_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_551_15 = 0

			if var_551_15 < arg_548_1.time_ and arg_548_1.time_ <= var_551_15 + arg_551_0 then
				arg_548_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_551_16 = 0

			if var_551_16 < arg_548_1.time_ and arg_548_1.time_ <= var_551_16 + arg_551_0 then
				arg_548_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_551_17 = 0
			local var_551_18 = 0.625

			if var_551_17 < arg_548_1.time_ and arg_548_1.time_ <= var_551_17 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				local var_551_19 = arg_548_1:FormatText(StoryNameCfg[1488].name)

				arg_548_1.leftNameTxt_.text = var_551_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_20 = arg_548_1:GetWordFromCfg(426091127)
				local var_551_21 = arg_548_1:FormatText(var_551_20.content)

				arg_548_1.text_.text = var_551_21

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_22 = 25
				local var_551_23 = utf8.len(var_551_21)
				local var_551_24 = var_551_22 <= 0 and var_551_18 or var_551_18 * (var_551_23 / var_551_22)

				if var_551_24 > 0 and var_551_18 < var_551_24 then
					arg_548_1.talkMaxDuration = var_551_24

					if var_551_24 + var_551_17 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_24 + var_551_17
					end
				end

				arg_548_1.text_.text = var_551_21
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091127", "story_v_out_426091.awb") ~= 0 then
					local var_551_25 = manager.audio:GetVoiceLength("story_v_out_426091", "426091127", "story_v_out_426091.awb") / 1000

					if var_551_25 + var_551_17 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_25 + var_551_17
					end

					if var_551_20.prefab_name ~= "" and arg_548_1.actors_[var_551_20.prefab_name] ~= nil then
						local var_551_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_20.prefab_name].transform, "story_v_out_426091", "426091127", "story_v_out_426091.awb")

						arg_548_1:RecordAudio("426091127", var_551_26)
						arg_548_1:RecordAudio("426091127", var_551_26)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_426091", "426091127", "story_v_out_426091.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_426091", "426091127", "story_v_out_426091.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_27 = math.max(var_551_18, arg_548_1.talkMaxDuration)

			if var_551_17 <= arg_548_1.time_ and arg_548_1.time_ < var_551_17 + var_551_27 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_17) / var_551_27

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_17 + var_551_27 and arg_548_1.time_ < var_551_17 + var_551_27 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_548_1:InitPlayNodeList()
	end,
	Play426091128 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 426091128
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
			arg_552_1.auto_ = false
		end

		function arg_552_1.playNext_(arg_554_0)
			arg_552_1.onStoryFinished_()
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = arg_552_1.actors_["6148ui_story"]
			local var_555_1 = 0

			if var_555_1 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.characterEffect6148ui_story == nil then
				arg_552_1.var_.characterEffect6148ui_story = var_555_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_2 = 0.200000002980232

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_2 and not isNil(var_555_0) then
				local var_555_3 = (arg_552_1.time_ - var_555_1) / var_555_2

				if arg_552_1.var_.characterEffect6148ui_story and not isNil(var_555_0) then
					local var_555_4 = Mathf.Lerp(0, 0.5, var_555_3)

					arg_552_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_552_1.var_.characterEffect6148ui_story.fillRatio = var_555_4
				end
			end

			if arg_552_1.time_ >= var_555_1 + var_555_2 and arg_552_1.time_ < var_555_1 + var_555_2 + arg_555_0 and not isNil(var_555_0) and arg_552_1.var_.characterEffect6148ui_story then
				local var_555_5 = 0.5

				arg_552_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_552_1.var_.characterEffect6148ui_story.fillRatio = var_555_5
			end

			local var_555_6 = 0
			local var_555_7 = 0.55

			if var_555_6 < arg_552_1.time_ and arg_552_1.time_ <= var_555_6 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_8 = arg_552_1:FormatText(StoryNameCfg[7].name)

				arg_552_1.leftNameTxt_.text = var_555_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_9 = arg_552_1:GetWordFromCfg(426091128)
				local var_555_10 = arg_552_1:FormatText(var_555_9.content)

				arg_552_1.text_.text = var_555_10

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_11 = 22
				local var_555_12 = utf8.len(var_555_10)
				local var_555_13 = var_555_11 <= 0 and var_555_7 or var_555_7 * (var_555_12 / var_555_11)

				if var_555_13 > 0 and var_555_7 < var_555_13 then
					arg_552_1.talkMaxDuration = var_555_13

					if var_555_13 + var_555_6 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_13 + var_555_6
					end
				end

				arg_552_1.text_.text = var_555_10
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_14 = math.max(var_555_7, arg_552_1.talkMaxDuration)

			if var_555_6 <= arg_552_1.time_ and arg_552_1.time_ < var_555_6 + var_555_14 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_6) / var_555_14

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_6 + var_555_14 and arg_552_1.time_ < var_555_6 + var_555_14 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2012",
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/SS2602",
		"TextureConfig/Background/J27h",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_426091.awb"
	}
}
