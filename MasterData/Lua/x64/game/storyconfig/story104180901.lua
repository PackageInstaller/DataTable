return {
	Play418091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418091001
		arg_1_1.duration_ = 7.2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play418091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				var_4_8.a = 1
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = 1

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_10 = 1.63333333333333

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				local var_4_11 = Color.New(0, 0, 0)

				var_4_11.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_9) / var_4_10)
				arg_1_1.mask_.color = var_4_11
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				local var_4_12 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_12.a = 0
				arg_1_1.mask_.color = var_4_12
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_13 = arg_1_1.var_.effect44

				if not arg_1_1.var_.effect44 then
					var_4_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_light"), manager.ui.mainCamera.transform)
					var_4_13.name = "44"
					arg_1_1.var_.effect44 = var_4_13
				else
					var_4_13.transform:SetParent(var_4_9000)
				end

				var_4_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				if arg_1_1.var_.effect44 then
					Object.Destroy(arg_1_1.var_.effect44)

					arg_1_1.var_.effect44 = nil
				end
			end

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			local var_4_19 = 2.2
			local var_4_20 = 0.625

			if 2.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(418091001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 25 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 25)

				if (25 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 25)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play418091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418091002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play418091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.025

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(418091002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 41 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 41)

				if (41 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 41)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play418091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418091003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play418091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.85

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(418091003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 34 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 34)

				if (34 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 34)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play418091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418091004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play418091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.6

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(418091004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 24 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 24)

				if (24 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 24)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play418091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418091005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play418091006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.95

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(418091005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 38 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 38)

				if (38 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 38)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play418091006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418091006
		arg_24_1.duration_ = 7.67

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play418091007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.bgs_.ST1002a == nil then
				local var_27_0 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST1002a")
				var_27_0.name = "ST1002a"
				var_27_0.transform.parent = arg_24_1.stage_.transform
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_.ST1002a = var_27_0
			end

			if 0.666666666666667 < arg_24_1.time_ and arg_24_1.time_ <= 0.666666666666667 + arg_27_0 then
				local var_27_1 = arg_24_1.bgs_.ST1002a

				arg_24_1.bgs_.ST1002a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_27_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_2 = var_27_1:GetComponent("SpriteRenderer")

				if var_27_2 and var_27_2.sprite then
					local var_27_3 = 2 * (var_27_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_27_1.transform.localScale = Vector3.New(var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "ST1002a" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_4 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			if arg_24_1.time_ >= var_27_4 + 0.3 and arg_24_1.time_ < var_27_4 + 0.3 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_5 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_6 = 0.666666666666667

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 then
				local var_27_7 = Color.New(0, 0, 0)

				var_27_7.a = Mathf.Lerp(0, 1, (arg_24_1.time_ - var_27_5) / var_27_6)
				arg_24_1.mask_.color = var_27_7
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 then
				local var_27_8 = Color.New(0, 0, 0)

				var_27_8.a = 1
				arg_24_1.mask_.color = var_27_8
			end

			local var_27_9 = 0.666666666666667

			if 0.666666666666667 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_10 = 2.1

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_10 then
				local var_27_11 = Color.New(0, 0, 0)

				var_27_11.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_9) / var_27_10)
				arg_24_1.mask_.color = var_27_11
			end

			if arg_24_1.time_ >= var_27_9 + var_27_10 and arg_24_1.time_ < var_27_9 + var_27_10 + arg_27_0 then
				local var_27_12 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_12.a = 0
				arg_24_1.mask_.color = var_27_12
			end

			if 0.05 < arg_24_1.time_ and arg_24_1.time_ <= 0.05 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_square_night", "")
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_14 = 2.66666666666667
			local var_27_15 = 1.1

			if 2.66666666666667 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_16 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_16:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_17 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(418091006).content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 44 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 44)

				if (44 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 44)) > 0 and var_27_15 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19
					var_27_14 = var_27_14 + 0.3

					if var_27_19 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = var_27_14 + 0.3
			local var_27_21 = math.max(var_27_15, arg_24_1.talkMaxDuration)

			if var_27_14 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_20 + var_27_21 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_20) / var_27_21

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_20 + var_27_21 and arg_24_1.time_ < var_27_20 + var_27_21 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play418091007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 418091007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play418091008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.85

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(418091007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 34 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 34)

				if (34 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 34)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play418091008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 418091008
		arg_34_1.duration_ = 2.47

		local var_34_0 = {
			ja = 2.466,
			CriLanguages = 1.666,
			zh = 1.666
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play418091009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.actors_["10135"] == nil then
				local var_37_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10135")

				if not isNil(var_37_0) then
					local var_37_1 = Object.Instantiate(var_37_0, arg_34_1.canvasGo_.transform)

					var_37_1.transform:SetSiblingIndex(1)

					var_37_1.name = "10135"
					var_37_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_34_1.actors_["10135"] = var_37_1

					if arg_34_1.isInRecall_ then
						for iter_37_0, iter_37_1 in ipairs((var_37_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_37_1.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_37_2 = arg_34_1.actors_["10135"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.actorSpriteComps10135 == nil then
				arg_34_1.var_.actorSpriteComps10135 = var_37_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_3 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_3 and not isNil(var_37_2) then
				if arg_34_1.var_.actorSpriteComps10135 then
					for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_37_3 then
							if arg_34_1.isInRecall_ then
								iter_37_3.color = Color.New(Mathf.Lerp(iter_37_3.color.r, arg_34_1.hightColor1.r, (arg_34_1.time_ - 0) / var_37_3), Mathf.Lerp(iter_37_3.color.g, arg_34_1.hightColor1.g, (arg_34_1.time_ - 0) / var_37_3), (Mathf.Lerp(iter_37_3.color.b, arg_34_1.hightColor1.b, (arg_34_1.time_ - 0) / var_37_3)))
							else
								local var_37_4 = Mathf.Lerp(iter_37_3.color.r, 1, (arg_34_1.time_ - 0) / var_37_3)

								iter_37_3.color = Color.New(var_37_4, var_37_4, var_37_4)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_3 and arg_34_1.time_ < 0 + var_37_3 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.actorSpriteComps10135 then
				for iter_37_4, iter_37_5 in pairs(arg_34_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_37_5 then
						iter_37_5.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_34_1.var_.actorSpriteComps10135 = nil
			end

			local var_37_5 = arg_34_1.actors_["10135"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10135 = var_37_5.localPosition
				var_37_5.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10135", 2)

				for iter_37_6 = 0, var_37_5.childCount - 1 do
					local var_37_6 = var_37_5:GetChild(iter_37_6)

					if var_37_6.name == "split_5" or not string.find(var_37_6.name, "split") then
						var_37_6.gameObject:SetActive(true)
					else
						var_37_6.gameObject:SetActive(false)
					end
				end
			end

			local var_37_7 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				var_37_5.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10135, Vector3.New(-448.9, -363.6, -305.9), (arg_34_1.time_ - 0) / var_37_7)
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				var_37_5.localPosition = Vector3.New(-448.9, -363.6, -305.9)
			end

			local var_37_8 = 0
			local var_37_9 = 0.225

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_8 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_10 = arg_34_1:GetWordFromCfg(418091008)
				local var_37_11 = arg_34_1:FormatText(var_37_10.content)

				arg_34_1.text_.text = var_37_11

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_13 = 9 <= 0 and var_37_9 or var_37_9 * (utf8.len(var_37_11) / 9)

				if (9 <= 0 and var_37_9 or var_37_9 * (utf8.len(var_37_11) / 9)) > 0 and var_37_9 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_8
					end
				end

				arg_34_1.text_.text = var_37_11
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091008", "story_v_side_old_418091.awb") ~= 0 then
					local var_37_14 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091008", "story_v_side_old_418091.awb") / 1000

					if var_37_14 + var_37_8 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_14 + var_37_8
					end

					if var_37_10.prefab_name ~= "" and arg_34_1.actors_[var_37_10.prefab_name] ~= nil then
						local var_37_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_10.prefab_name].transform, "story_v_side_old_418091", "418091008", "story_v_side_old_418091.awb")

						arg_34_1:RecordAudio("418091008", var_37_15)
						arg_34_1:RecordAudio("418091008", var_37_15)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091008", "story_v_side_old_418091.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091008", "story_v_side_old_418091.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_16 = math.max(var_37_9, arg_34_1.talkMaxDuration)

			if var_37_8 <= arg_34_1.time_ and arg_34_1.time_ < var_37_8 + var_37_16 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_8) / var_37_16

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_8 + var_37_16 and arg_34_1.time_ < var_37_8 + var_37_16 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play418091009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 418091009
		arg_38_1.duration_ = 2.23

		local var_38_0 = {
			ja = 1.9,
			CriLanguages = 2.233,
			zh = 2.233
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play418091010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if arg_38_1.actors_["1074"] == nil then
				local var_41_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1074")

				if not isNil(var_41_0) then
					local var_41_1 = Object.Instantiate(var_41_0, arg_38_1.canvasGo_.transform)

					var_41_1.transform:SetSiblingIndex(1)

					var_41_1.name = "1074"
					var_41_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_38_1.actors_["1074"] = var_41_1

					if arg_38_1.isInRecall_ then
						for iter_41_0, iter_41_1 in ipairs((var_41_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_41_1.color = arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_41_2 = arg_38_1.actors_["1074"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.actorSpriteComps1074 == nil then
				arg_38_1.var_.actorSpriteComps1074 = var_41_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_3 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.actorSpriteComps1074 then
					for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_41_3 then
							if arg_38_1.isInRecall_ then
								iter_41_3.color = Color.New(Mathf.Lerp(iter_41_3.color.r, arg_38_1.hightColor1.r, (arg_38_1.time_ - 0) / var_41_3), Mathf.Lerp(iter_41_3.color.g, arg_38_1.hightColor1.g, (arg_38_1.time_ - 0) / var_41_3), (Mathf.Lerp(iter_41_3.color.b, arg_38_1.hightColor1.b, (arg_38_1.time_ - 0) / var_41_3)))
							else
								local var_41_4 = Mathf.Lerp(iter_41_3.color.r, 1, (arg_38_1.time_ - 0) / var_41_3)

								iter_41_3.color = Color.New(var_41_4, var_41_4, var_41_4)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.actorSpriteComps1074 then
				for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_41_5 then
						iter_41_5.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps1074 = nil
			end

			local var_41_5 = arg_38_1.actors_["10135"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_5) and arg_38_1.var_.actorSpriteComps10135 == nil then
				arg_38_1.var_.actorSpriteComps10135 = var_41_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_6 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_6 and not isNil(var_41_5) then
				if arg_38_1.var_.actorSpriteComps10135 then
					for iter_41_6, iter_41_7 in pairs(arg_38_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_41_7 then
							if arg_38_1.isInRecall_ then
								iter_41_7.color = Color.New(Mathf.Lerp(iter_41_7.color.r, arg_38_1.hightColor2.r, (arg_38_1.time_ - 0) / var_41_6), Mathf.Lerp(iter_41_7.color.g, arg_38_1.hightColor2.g, (arg_38_1.time_ - 0) / var_41_6), (Mathf.Lerp(iter_41_7.color.b, arg_38_1.hightColor2.b, (arg_38_1.time_ - 0) / var_41_6)))
							else
								local var_41_7 = Mathf.Lerp(iter_41_7.color.r, 0.5, (arg_38_1.time_ - 0) / var_41_6)

								iter_41_7.color = Color.New(var_41_7, var_41_7, var_41_7)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_6 and arg_38_1.time_ < 0 + var_41_6 + arg_41_0 and not isNil(var_41_5) and arg_38_1.var_.actorSpriteComps10135 then
				for iter_41_8, iter_41_9 in pairs(arg_38_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_41_9 then
						iter_41_9.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_38_1.var_.actorSpriteComps10135 = nil
			end

			local var_41_8 = arg_38_1.actors_["1074"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1074 = var_41_8.localPosition
				var_41_8.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1074", 4)

				for iter_41_10 = 0, var_41_8.childCount - 1 do
					local var_41_9 = var_41_8:GetChild(iter_41_10)

					if var_41_9.name == "" or not string.find(var_41_9.name, "split") then
						var_41_9.gameObject:SetActive(true)
					else
						var_41_9.gameObject:SetActive(false)
					end
				end
			end

			local var_41_10 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_10 then
				var_41_8.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1074, Vector3.New(487.8, -328.5, -206.1), (arg_38_1.time_ - 0) / var_41_10)
			end

			if arg_38_1.time_ >= 0 + var_41_10 and arg_38_1.time_ < 0 + var_41_10 + arg_41_0 then
				var_41_8.localPosition = Vector3.New(487.8, -328.5, -206.1)
			end

			local var_41_11 = 0
			local var_41_12 = 0.2

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_13 = arg_38_1:GetWordFromCfg(418091009)
				local var_41_14 = arg_38_1:FormatText(var_41_13.content)

				arg_38_1.text_.text = var_41_14

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_16 = 8 <= 0 and var_41_12 or var_41_12 * (utf8.len(var_41_14) / 8)

				if (8 <= 0 and var_41_12 or var_41_12 * (utf8.len(var_41_14) / 8)) > 0 and var_41_12 < var_41_16 then
					arg_38_1.talkMaxDuration = var_41_16

					if var_41_16 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_11
					end
				end

				arg_38_1.text_.text = var_41_14
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091009", "story_v_side_old_418091.awb") ~= 0 then
					local var_41_17 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091009", "story_v_side_old_418091.awb") / 1000

					if var_41_17 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_17 + var_41_11
					end

					if var_41_13.prefab_name ~= "" and arg_38_1.actors_[var_41_13.prefab_name] ~= nil then
						local var_41_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_13.prefab_name].transform, "story_v_side_old_418091", "418091009", "story_v_side_old_418091.awb")

						arg_38_1:RecordAudio("418091009", var_41_18)
						arg_38_1:RecordAudio("418091009", var_41_18)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091009", "story_v_side_old_418091.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091009", "story_v_side_old_418091.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_19 = math.max(var_41_12, arg_38_1.talkMaxDuration)

			if var_41_11 <= arg_38_1.time_ and arg_38_1.time_ < var_41_11 + var_41_19 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_11) / var_41_19

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_11 + var_41_19 and arg_38_1.time_ < var_41_11 + var_41_19 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play418091010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 418091010
		arg_42_1.duration_ = 3.07

		local var_42_0 = {
			ja = 3.066,
			CriLanguages = 2.233,
			zh = 2.233
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play418091011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["10135"]) and arg_42_1.var_.actorSpriteComps10135 == nil then
				arg_42_1.var_.actorSpriteComps10135 = arg_42_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["10135"]) then
				if arg_42_1.var_.actorSpriteComps10135 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								iter_45_1.color = Color.New(Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, (arg_42_1.time_ - 0) / var_45_0), Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, (arg_42_1.time_ - 0) / var_45_0), (Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, (arg_42_1.time_ - 0) / var_45_0)))
							else
								local var_45_1 = Mathf.Lerp(iter_45_1.color.r, 1, (arg_42_1.time_ - 0) / var_45_0)

								iter_45_1.color = Color.New(var_45_1, var_45_1, var_45_1)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["10135"]) and arg_42_1.var_.actorSpriteComps10135 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps10135 = nil
			end

			local var_45_2 = arg_42_1.actors_["1074"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps1074 == nil then
				arg_42_1.var_.actorSpriteComps1074 = var_45_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_3 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.actorSpriteComps1074 then
					for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_45_5 then
							if arg_42_1.isInRecall_ then
								iter_45_5.color = Color.New(Mathf.Lerp(iter_45_5.color.r, arg_42_1.hightColor2.r, (arg_42_1.time_ - 0) / var_45_3), Mathf.Lerp(iter_45_5.color.g, arg_42_1.hightColor2.g, (arg_42_1.time_ - 0) / var_45_3), (Mathf.Lerp(iter_45_5.color.b, arg_42_1.hightColor2.b, (arg_42_1.time_ - 0) / var_45_3)))
							else
								local var_45_4 = Mathf.Lerp(iter_45_5.color.r, 0.5, (arg_42_1.time_ - 0) / var_45_3)

								iter_45_5.color = Color.New(var_45_4, var_45_4, var_45_4)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps1074 then
				for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_45_7 then
						iter_45_7.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps1074 = nil
			end

			local var_45_5 = 0
			local var_45_6 = 0.275

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_7 = arg_42_1:GetWordFromCfg(418091010)
				local var_45_8 = arg_42_1:FormatText(var_45_7.content)

				arg_42_1.text_.text = var_45_8

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_10 = 11 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 11)

				if (11 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 11)) > 0 and var_45_6 < var_45_10 then
					arg_42_1.talkMaxDuration = var_45_10

					if var_45_10 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_5
					end
				end

				arg_42_1.text_.text = var_45_8
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091010", "story_v_side_old_418091.awb") ~= 0 then
					local var_45_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091010", "story_v_side_old_418091.awb") / 1000

					if var_45_11 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_5
					end

					if var_45_7.prefab_name ~= "" and arg_42_1.actors_[var_45_7.prefab_name] ~= nil then
						local var_45_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_7.prefab_name].transform, "story_v_side_old_418091", "418091010", "story_v_side_old_418091.awb")

						arg_42_1:RecordAudio("418091010", var_45_12)
						arg_42_1:RecordAudio("418091010", var_45_12)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091010", "story_v_side_old_418091.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091010", "story_v_side_old_418091.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_13 = math.max(var_45_6, arg_42_1.talkMaxDuration)

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_13 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_5) / var_45_13

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_5 + var_45_13 and arg_42_1.time_ < var_45_5 + var_45_13 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play418091011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 418091011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play418091012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10135"]) and arg_46_1.var_.actorSpriteComps10135 == nil then
				arg_46_1.var_.actorSpriteComps10135 = arg_46_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10135"]) then
				if arg_46_1.var_.actorSpriteComps10135 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor2.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor2.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor2.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 0.5, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10135"]) and arg_46_1.var_.actorSpriteComps10135 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps10135 = nil
			end

			local var_49_2 = 0
			local var_49_3 = 0.75

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(418091011).content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_6 = 30 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_4) / 30)

				if (30 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_4) / 30)) > 0 and var_49_3 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_7 and arg_46_1.time_ < var_49_2 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play418091012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 418091012
		arg_50_1.duration_ = 6.27

		local var_50_0 = {
			ja = 6.266,
			CriLanguages = 5.2,
			zh = 5.2
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play418091013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1074"]) and arg_50_1.var_.actorSpriteComps1074 == nil then
				arg_50_1.var_.actorSpriteComps1074 = arg_50_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1074"]) then
				if arg_50_1.var_.actorSpriteComps1074 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								iter_53_1.color = Color.New(Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor1.r, (arg_50_1.time_ - 0) / var_53_0), Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor1.g, (arg_50_1.time_ - 0) / var_53_0), (Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor1.b, (arg_50_1.time_ - 0) / var_53_0)))
							else
								local var_53_1 = Mathf.Lerp(iter_53_1.color.r, 1, (arg_50_1.time_ - 0) / var_53_0)

								iter_53_1.color = Color.New(var_53_1, var_53_1, var_53_1)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1074"]) and arg_50_1.var_.actorSpriteComps1074 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps1074 = nil
			end

			local var_53_2 = arg_50_1.actors_["1074"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1074 = var_53_2.localPosition
				var_53_2.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1074", 4)

				for iter_53_4 = 0, var_53_2.childCount - 1 do
					local var_53_3 = var_53_2:GetChild(iter_53_4)

					if var_53_3.name == "" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1074, Vector3.New(487.8, -328.5, -206.1), (arg_50_1.time_ - 0) / var_53_4)
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(487.8, -328.5, -206.1)
			end

			local var_53_5 = 0
			local var_53_6 = 0.725

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:GetWordFromCfg(418091012)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 29 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 29)

				if (29 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 29)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091012", "story_v_side_old_418091.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091012", "story_v_side_old_418091.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_side_old_418091", "418091012", "story_v_side_old_418091.awb")

						arg_50_1:RecordAudio("418091012", var_53_12)
						arg_50_1:RecordAudio("418091012", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091012", "story_v_side_old_418091.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091012", "story_v_side_old_418091.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_13 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_13 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_13

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_13 and arg_50_1.time_ < var_53_5 + var_53_13 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play418091013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 418091013
		arg_54_1.duration_ = 5.9

		local var_54_0 = {
			ja = 5.9,
			CriLanguages = 4.7,
			zh = 4.7
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play418091014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.475

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:GetWordFromCfg(418091013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 19 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 19)

				if (19 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 19)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091013", "story_v_side_old_418091.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091013", "story_v_side_old_418091.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_side_old_418091", "418091013", "story_v_side_old_418091.awb")

						arg_54_1:RecordAudio("418091013", var_57_6)
						arg_54_1:RecordAudio("418091013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091013", "story_v_side_old_418091.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091013", "story_v_side_old_418091.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play418091014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 418091014
		arg_58_1.duration_ = 1.87

		local var_58_0 = {
			ja = 1.866,
			CriLanguages = 1.533,
			zh = 1.533
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play418091015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10135"]) and arg_58_1.var_.actorSpriteComps10135 == nil then
				arg_58_1.var_.actorSpriteComps10135 = arg_58_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10135"]) then
				if arg_58_1.var_.actorSpriteComps10135 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 1, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10135"]) and arg_58_1.var_.actorSpriteComps10135 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10135 = nil
			end

			local var_61_2 = arg_58_1.actors_["1074"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps1074 == nil then
				arg_58_1.var_.actorSpriteComps1074 = var_61_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_3 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.actorSpriteComps1074 then
					for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_61_5 then
							if arg_58_1.isInRecall_ then
								iter_61_5.color = Color.New(Mathf.Lerp(iter_61_5.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_3), Mathf.Lerp(iter_61_5.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_3), (Mathf.Lerp(iter_61_5.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_3)))
							else
								local var_61_4 = Mathf.Lerp(iter_61_5.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_3)

								iter_61_5.color = Color.New(var_61_4, var_61_4, var_61_4)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps1074 then
				for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_61_7 then
						iter_61_7.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps1074 = nil
			end

			local var_61_5 = 0
			local var_61_6 = 0.15

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_7 = arg_58_1:GetWordFromCfg(418091014)
				local var_61_8 = arg_58_1:FormatText(var_61_7.content)

				arg_58_1.text_.text = var_61_8

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_10 = 6 <= 0 and var_61_6 or var_61_6 * (utf8.len(var_61_8) / 6)

				if (6 <= 0 and var_61_6 or var_61_6 * (utf8.len(var_61_8) / 6)) > 0 and var_61_6 < var_61_10 then
					arg_58_1.talkMaxDuration = var_61_10

					if var_61_10 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_5
					end
				end

				arg_58_1.text_.text = var_61_8
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091014", "story_v_side_old_418091.awb") ~= 0 then
					local var_61_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091014", "story_v_side_old_418091.awb") / 1000

					if var_61_11 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_5
					end

					if var_61_7.prefab_name ~= "" and arg_58_1.actors_[var_61_7.prefab_name] ~= nil then
						local var_61_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_7.prefab_name].transform, "story_v_side_old_418091", "418091014", "story_v_side_old_418091.awb")

						arg_58_1:RecordAudio("418091014", var_61_12)
						arg_58_1:RecordAudio("418091014", var_61_12)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091014", "story_v_side_old_418091.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091014", "story_v_side_old_418091.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_13 = math.max(var_61_6, arg_58_1.talkMaxDuration)

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_13 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_5) / var_61_13

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_5 + var_61_13 and arg_58_1.time_ < var_61_5 + var_61_13 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play418091015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 418091015
		arg_62_1.duration_ = 5.63

		local var_62_0 = {
			ja = 5.633,
			CriLanguages = 3.8,
			zh = 3.8
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play418091016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1074"]) and arg_62_1.var_.actorSpriteComps1074 == nil then
				arg_62_1.var_.actorSpriteComps1074 = arg_62_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1074"]) then
				if arg_62_1.var_.actorSpriteComps1074 then
					for iter_65_0, iter_65_1 in pairs(arg_62_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_65_1 then
							if arg_62_1.isInRecall_ then
								iter_65_1.color = Color.New(Mathf.Lerp(iter_65_1.color.r, arg_62_1.hightColor1.r, (arg_62_1.time_ - 0) / var_65_0), Mathf.Lerp(iter_65_1.color.g, arg_62_1.hightColor1.g, (arg_62_1.time_ - 0) / var_65_0), (Mathf.Lerp(iter_65_1.color.b, arg_62_1.hightColor1.b, (arg_62_1.time_ - 0) / var_65_0)))
							else
								local var_65_1 = Mathf.Lerp(iter_65_1.color.r, 1, (arg_62_1.time_ - 0) / var_65_0)

								iter_65_1.color = Color.New(var_65_1, var_65_1, var_65_1)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1074"]) and arg_62_1.var_.actorSpriteComps1074 then
				for iter_65_2, iter_65_3 in pairs(arg_62_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_65_3 then
						iter_65_3.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_62_1.var_.actorSpriteComps1074 = nil
			end

			local var_65_2 = arg_62_1.actors_["10135"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.actorSpriteComps10135 == nil then
				arg_62_1.var_.actorSpriteComps10135 = var_65_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_65_3 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.actorSpriteComps10135 then
					for iter_65_4, iter_65_5 in pairs(arg_62_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_65_5 then
							if arg_62_1.isInRecall_ then
								iter_65_5.color = Color.New(Mathf.Lerp(iter_65_5.color.r, arg_62_1.hightColor2.r, (arg_62_1.time_ - 0) / var_65_3), Mathf.Lerp(iter_65_5.color.g, arg_62_1.hightColor2.g, (arg_62_1.time_ - 0) / var_65_3), (Mathf.Lerp(iter_65_5.color.b, arg_62_1.hightColor2.b, (arg_62_1.time_ - 0) / var_65_3)))
							else
								local var_65_4 = Mathf.Lerp(iter_65_5.color.r, 0.5, (arg_62_1.time_ - 0) / var_65_3)

								iter_65_5.color = Color.New(var_65_4, var_65_4, var_65_4)
							end
						end
					end
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.actorSpriteComps10135 then
				for iter_65_6, iter_65_7 in pairs(arg_62_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_65_7 then
						iter_65_7.color = arg_62_1.isInRecall_ and (arg_62_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_62_1.var_.actorSpriteComps10135 = nil
			end

			local var_65_5 = arg_62_1.actors_["1074"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1074 = var_65_5.localPosition
				var_65_5.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("1074", 4)

				for iter_65_8 = 0, var_65_5.childCount - 1 do
					local var_65_6 = var_65_5:GetChild(iter_65_8)

					if var_65_6.name == "split_2" or not string.find(var_65_6.name, "split") then
						var_65_6.gameObject:SetActive(true)
					else
						var_65_6.gameObject:SetActive(false)
					end
				end
			end

			local var_65_7 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				var_65_5.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1074, Vector3.New(487.8, -328.5, -206.1), (arg_62_1.time_ - 0) / var_65_7)
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				var_65_5.localPosition = Vector3.New(487.8, -328.5, -206.1)
			end

			local var_65_8 = 0
			local var_65_9 = 0.35

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(418091015)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 14 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 14)

				if (14 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 14)) > 0 and var_65_9 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091015", "story_v_side_old_418091.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091015", "story_v_side_old_418091.awb") / 1000

					if var_65_14 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_8
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_side_old_418091", "418091015", "story_v_side_old_418091.awb")

						arg_62_1:RecordAudio("418091015", var_65_15)
						arg_62_1:RecordAudio("418091015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091015", "story_v_side_old_418091.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091015", "story_v_side_old_418091.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_16 and arg_62_1.time_ < var_65_8 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play418091016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 418091016
		arg_66_1.duration_ = 6.9

		local var_66_0 = {
			ja = 6.9,
			CriLanguages = 5.233,
			zh = 5.233
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play418091017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.55

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(418091016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 22 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 22)

				if (22 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 22)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091016", "story_v_side_old_418091.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091016", "story_v_side_old_418091.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_side_old_418091", "418091016", "story_v_side_old_418091.awb")

						arg_66_1:RecordAudio("418091016", var_69_6)
						arg_66_1:RecordAudio("418091016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091016", "story_v_side_old_418091.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091016", "story_v_side_old_418091.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play418091017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 418091017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play418091018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1074"]) and arg_70_1.var_.actorSpriteComps1074 == nil then
				arg_70_1.var_.actorSpriteComps1074 = arg_70_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1074"]) then
				if arg_70_1.var_.actorSpriteComps1074 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1074"]) and arg_70_1.var_.actorSpriteComps1074 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps1074 = nil
			end

			local var_73_2 = arg_70_1.actors_["1074"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1074 = var_73_2.localPosition
				var_73_2.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1074", 7)

				for iter_73_4 = 0, var_73_2.childCount - 1 do
					local var_73_3 = var_73_2:GetChild(iter_73_4)

					if var_73_3.name == "" or not string.find(var_73_3.name, "split") then
						var_73_3.gameObject:SetActive(true)
					else
						var_73_3.gameObject:SetActive(false)
					end
				end
			end

			local var_73_4 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				var_73_2.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1074, Vector3.New(0, -2000, 0), (arg_70_1.time_ - 0) / var_73_4)
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				var_73_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_5 = arg_70_1.actors_["10135"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos10135 = var_73_5.localPosition
				var_73_5.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("10135", 7)

				for iter_73_5 = 0, var_73_5.childCount - 1 do
					local var_73_6 = var_73_5:GetChild(iter_73_5)

					if var_73_6.name == "" or not string.find(var_73_6.name, "split") then
						var_73_6.gameObject:SetActive(true)
					else
						var_73_6.gameObject:SetActive(false)
					end
				end
			end

			local var_73_7 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				var_73_5.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_70_1.time_ - 0) / var_73_7)
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				var_73_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_8 = 0
			local var_73_9 = 0.6

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_10 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(418091017).content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_12 = 24 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_10) / 24)

				if (24 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_10) / 24)) > 0 and var_73_9 < var_73_12 then
					arg_70_1.talkMaxDuration = var_73_12

					if var_73_12 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_8
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_13 = math.max(var_73_9, arg_70_1.talkMaxDuration)

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_13 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_8) / var_73_13

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_8 + var_73_13 and arg_70_1.time_ < var_73_8 + var_73_13 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play418091018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 418091018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play418091019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 1.175

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(418091018).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 47 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 47)

				if (47 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 47)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play418091019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 418091019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play418091020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.25

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(418091019).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 10 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 10)

				if (10 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 10)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play418091020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 418091020
		arg_82_1.duration_ = 4

		local var_82_0 = {
			ja = 3.9,
			CriLanguages = 4,
			zh = 4
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play418091021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1074"]) and arg_82_1.var_.actorSpriteComps1074 == nil then
				arg_82_1.var_.actorSpriteComps1074 = arg_82_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1074"]) then
				if arg_82_1.var_.actorSpriteComps1074 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								iter_85_1.color = Color.New(Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor1.r, (arg_82_1.time_ - 0) / var_85_0), Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor1.g, (arg_82_1.time_ - 0) / var_85_0), (Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor1.b, (arg_82_1.time_ - 0) / var_85_0)))
							else
								local var_85_1 = Mathf.Lerp(iter_85_1.color.r, 1, (arg_82_1.time_ - 0) / var_85_0)

								iter_85_1.color = Color.New(var_85_1, var_85_1, var_85_1)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1074"]) and arg_82_1.var_.actorSpriteComps1074 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_82_1.var_.actorSpriteComps1074 = nil
			end

			local var_85_2 = arg_82_1.actors_["1074"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1074 = var_85_2.localPosition
				var_85_2.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("1074", 3)

				for iter_85_4 = 0, var_85_2.childCount - 1 do
					local var_85_3 = var_85_2:GetChild(iter_85_4)

					if var_85_3.name == "" or not string.find(var_85_3.name, "split") then
						var_85_3.gameObject:SetActive(true)
					else
						var_85_3.gameObject:SetActive(false)
					end
				end
			end

			local var_85_4 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				var_85_2.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1074, Vector3.New(9.7, -328, -206.1), (arg_82_1.time_ - 0) / var_85_4)
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				var_85_2.localPosition = Vector3.New(9.7, -328, -206.1)
			end

			local var_85_5 = 0
			local var_85_6 = 0.475

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:GetWordFromCfg(418091020)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 19 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 19)

				if (19 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 19)) > 0 and var_85_6 < var_85_10 then
					arg_82_1.talkMaxDuration = var_85_10

					if var_85_10 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_8
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091020", "story_v_side_old_418091.awb") ~= 0 then
					local var_85_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091020", "story_v_side_old_418091.awb") / 1000

					if var_85_11 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_5
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_side_old_418091", "418091020", "story_v_side_old_418091.awb")

						arg_82_1:RecordAudio("418091020", var_85_12)
						arg_82_1:RecordAudio("418091020", var_85_12)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091020", "story_v_side_old_418091.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091020", "story_v_side_old_418091.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_13 = math.max(var_85_6, arg_82_1.talkMaxDuration)

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_13 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_5) / var_85_13

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_5 + var_85_13 and arg_82_1.time_ < var_85_5 + var_85_13 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play418091021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 418091021
		arg_86_1.duration_ = 6.77

		local var_86_0 = {
			ja = 6.766,
			CriLanguages = 6.166,
			zh = 6.166
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play418091022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.775

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(418091021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 31 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 31)

				if (31 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 31)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091021", "story_v_side_old_418091.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091021", "story_v_side_old_418091.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_side_old_418091", "418091021", "story_v_side_old_418091.awb")

						arg_86_1:RecordAudio("418091021", var_89_6)
						arg_86_1:RecordAudio("418091021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091021", "story_v_side_old_418091.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091021", "story_v_side_old_418091.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play418091022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 418091022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play418091023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1074"]) and arg_90_1.var_.actorSpriteComps1074 == nil then
				arg_90_1.var_.actorSpriteComps1074 = arg_90_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1074"]) then
				if arg_90_1.var_.actorSpriteComps1074 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor2.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor2.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor2.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 0.5, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1074"]) and arg_90_1.var_.actorSpriteComps1074 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_90_1.var_.actorSpriteComps1074 = nil
			end

			local var_93_2 = arg_90_1.actors_["1074"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1074 = var_93_2.localPosition
				var_93_2.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("1074", 7)

				for iter_93_4 = 0, var_93_2.childCount - 1 do
					local var_93_3 = var_93_2:GetChild(iter_93_4)

					if var_93_3.name == "" or not string.find(var_93_3.name, "split") then
						var_93_3.gameObject:SetActive(true)
					else
						var_93_3.gameObject:SetActive(false)
					end
				end
			end

			local var_93_4 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				var_93_2.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1074, Vector3.New(0, -2000, 0), (arg_90_1.time_ - 0) / var_93_4)
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_93_5 = 0
			local var_93_6 = 0.625

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_7 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(418091022).content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 25 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_7) / 25)

				if (25 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_7) / 25)) > 0 and var_93_6 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_5
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_6, arg_90_1.talkMaxDuration)

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_5) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_5 + var_93_10 and arg_90_1.time_ < var_93_5 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play418091023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 418091023
		arg_94_1.duration_ = 3.93

		local var_94_0 = {
			ja = 3.933,
			CriLanguages = 3.2,
			zh = 3.2
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play418091024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10135"]) and arg_94_1.var_.actorSpriteComps10135 == nil then
				arg_94_1.var_.actorSpriteComps10135 = arg_94_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10135"]) then
				if arg_94_1.var_.actorSpriteComps10135 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor1.r, (arg_94_1.time_ - 0) / var_97_0), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor1.g, (arg_94_1.time_ - 0) / var_97_0), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor1.b, (arg_94_1.time_ - 0) / var_97_0)))
							else
								local var_97_1 = Mathf.Lerp(iter_97_1.color.r, 1, (arg_94_1.time_ - 0) / var_97_0)

								iter_97_1.color = Color.New(var_97_1, var_97_1, var_97_1)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10135"]) and arg_94_1.var_.actorSpriteComps10135 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps10135 = nil
			end

			local var_97_2 = arg_94_1.actors_["10135"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos10135 = var_97_2.localPosition
				var_97_2.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("10135", 2)

				for iter_97_4 = 0, var_97_2.childCount - 1 do
					local var_97_3 = var_97_2:GetChild(iter_97_4)

					if var_97_3.name == "split_5" or not string.find(var_97_3.name, "split") then
						var_97_3.gameObject:SetActive(true)
					else
						var_97_3.gameObject:SetActive(false)
					end
				end
			end

			local var_97_4 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				var_97_2.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10135, Vector3.New(-448.9, -363.6, -305.9), (arg_94_1.time_ - 0) / var_97_4)
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				var_97_2.localPosition = Vector3.New(-448.9, -363.6, -305.9)
			end

			local var_97_5 = 0
			local var_97_6 = 0.3

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:GetWordFromCfg(418091023)
				local var_97_8 = arg_94_1:FormatText(var_97_7.content)

				arg_94_1.text_.text = var_97_8

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_10 = 12 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 12)

				if (12 <= 0 and var_97_6 or var_97_6 * (utf8.len(var_97_8) / 12)) > 0 and var_97_6 < var_97_10 then
					arg_94_1.talkMaxDuration = var_97_10

					if var_97_10 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_5
					end
				end

				arg_94_1.text_.text = var_97_8
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091023", "story_v_side_old_418091.awb") ~= 0 then
					local var_97_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091023", "story_v_side_old_418091.awb") / 1000

					if var_97_11 + var_97_5 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_5
					end

					if var_97_7.prefab_name ~= "" and arg_94_1.actors_[var_97_7.prefab_name] ~= nil then
						local var_97_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_7.prefab_name].transform, "story_v_side_old_418091", "418091023", "story_v_side_old_418091.awb")

						arg_94_1:RecordAudio("418091023", var_97_12)
						arg_94_1:RecordAudio("418091023", var_97_12)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091023", "story_v_side_old_418091.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091023", "story_v_side_old_418091.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_13 = math.max(var_97_6, arg_94_1.talkMaxDuration)

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_13 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_5) / var_97_13

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_5 + var_97_13 and arg_94_1.time_ < var_97_5 + var_97_13 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play418091024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 418091024
		arg_98_1.duration_ = 2.67

		local var_98_0 = {
			ja = 2.666,
			CriLanguages = 1.733,
			zh = 1.733
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play418091025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1074"]) and arg_98_1.var_.actorSpriteComps1074 == nil then
				arg_98_1.var_.actorSpriteComps1074 = arg_98_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1074"]) then
				if arg_98_1.var_.actorSpriteComps1074 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								iter_101_1.color = Color.New(Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, (arg_98_1.time_ - 0) / var_101_0), Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, (arg_98_1.time_ - 0) / var_101_0), (Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, (arg_98_1.time_ - 0) / var_101_0)))
							else
								local var_101_1 = Mathf.Lerp(iter_101_1.color.r, 1, (arg_98_1.time_ - 0) / var_101_0)

								iter_101_1.color = Color.New(var_101_1, var_101_1, var_101_1)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1074"]) and arg_98_1.var_.actorSpriteComps1074 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_98_1.var_.actorSpriteComps1074 = nil
			end

			local var_101_2 = arg_98_1.actors_["10135"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.actorSpriteComps10135 == nil then
				arg_98_1.var_.actorSpriteComps10135 = var_101_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_3 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.actorSpriteComps10135 then
					for iter_101_4, iter_101_5 in pairs(arg_98_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_101_5 then
							if arg_98_1.isInRecall_ then
								iter_101_5.color = Color.New(Mathf.Lerp(iter_101_5.color.r, arg_98_1.hightColor2.r, (arg_98_1.time_ - 0) / var_101_3), Mathf.Lerp(iter_101_5.color.g, arg_98_1.hightColor2.g, (arg_98_1.time_ - 0) / var_101_3), (Mathf.Lerp(iter_101_5.color.b, arg_98_1.hightColor2.b, (arg_98_1.time_ - 0) / var_101_3)))
							else
								local var_101_4 = Mathf.Lerp(iter_101_5.color.r, 0.5, (arg_98_1.time_ - 0) / var_101_3)

								iter_101_5.color = Color.New(var_101_4, var_101_4, var_101_4)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.actorSpriteComps10135 then
				for iter_101_6, iter_101_7 in pairs(arg_98_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_101_7 then
						iter_101_7.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_98_1.var_.actorSpriteComps10135 = nil
			end

			local var_101_5 = arg_98_1.actors_["1074"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1074 = var_101_5.localPosition
				var_101_5.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("1074", 4)

				for iter_101_8 = 0, var_101_5.childCount - 1 do
					local var_101_6 = var_101_5:GetChild(iter_101_8)

					if var_101_6.name == "split_2" or not string.find(var_101_6.name, "split") then
						var_101_6.gameObject:SetActive(true)
					else
						var_101_6.gameObject:SetActive(false)
					end
				end
			end

			local var_101_7 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				var_101_5.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1074, Vector3.New(487.8, -328.5, -206.1), (arg_98_1.time_ - 0) / var_101_7)
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				var_101_5.localPosition = Vector3.New(487.8, -328.5, -206.1)
			end

			local var_101_8 = 0
			local var_101_9 = 0.25

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_10 = arg_98_1:GetWordFromCfg(418091024)
				local var_101_11 = arg_98_1:FormatText(var_101_10.content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 10 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 10)

				if (10 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 10)) > 0 and var_101_9 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091024", "story_v_side_old_418091.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091024", "story_v_side_old_418091.awb") / 1000

					if var_101_14 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_8
					end

					if var_101_10.prefab_name ~= "" and arg_98_1.actors_[var_101_10.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_10.prefab_name].transform, "story_v_side_old_418091", "418091024", "story_v_side_old_418091.awb")

						arg_98_1:RecordAudio("418091024", var_101_15)
						arg_98_1:RecordAudio("418091024", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091024", "story_v_side_old_418091.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091024", "story_v_side_old_418091.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_16 and arg_98_1.time_ < var_101_8 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play418091025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 418091025
		arg_102_1.duration_ = 12.53

		local var_102_0 = {
			ja = 12.533,
			CriLanguages = 8.233,
			zh = 8.233
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play418091026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 1.025

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(418091025)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 41 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 41)

				if (41 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 41)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091025", "story_v_side_old_418091.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091025", "story_v_side_old_418091.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_side_old_418091", "418091025", "story_v_side_old_418091.awb")

						arg_102_1:RecordAudio("418091025", var_105_6)
						arg_102_1:RecordAudio("418091025", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091025", "story_v_side_old_418091.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091025", "story_v_side_old_418091.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play418091026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 418091026
		arg_106_1.duration_ = 3

		local var_106_0 = {
			ja = 3,
			CriLanguages = 2.566,
			zh = 2.566
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play418091027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10135"]) and arg_106_1.var_.actorSpriteComps10135 == nil then
				arg_106_1.var_.actorSpriteComps10135 = arg_106_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10135"]) then
				if arg_106_1.var_.actorSpriteComps10135 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								iter_109_1.color = Color.New(Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, (arg_106_1.time_ - 0) / var_109_0), Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, (arg_106_1.time_ - 0) / var_109_0), (Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, (arg_106_1.time_ - 0) / var_109_0)))
							else
								local var_109_1 = Mathf.Lerp(iter_109_1.color.r, 1, (arg_106_1.time_ - 0) / var_109_0)

								iter_109_1.color = Color.New(var_109_1, var_109_1, var_109_1)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10135"]) and arg_106_1.var_.actorSpriteComps10135 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_106_1.var_.actorSpriteComps10135 = nil
			end

			local var_109_2 = arg_106_1.actors_["1074"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps1074 == nil then
				arg_106_1.var_.actorSpriteComps1074 = var_109_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_3 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.actorSpriteComps1074 then
					for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_109_5 then
							if arg_106_1.isInRecall_ then
								iter_109_5.color = Color.New(Mathf.Lerp(iter_109_5.color.r, arg_106_1.hightColor2.r, (arg_106_1.time_ - 0) / var_109_3), Mathf.Lerp(iter_109_5.color.g, arg_106_1.hightColor2.g, (arg_106_1.time_ - 0) / var_109_3), (Mathf.Lerp(iter_109_5.color.b, arg_106_1.hightColor2.b, (arg_106_1.time_ - 0) / var_109_3)))
							else
								local var_109_4 = Mathf.Lerp(iter_109_5.color.r, 0.5, (arg_106_1.time_ - 0) / var_109_3)

								iter_109_5.color = Color.New(var_109_4, var_109_4, var_109_4)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps1074 then
				for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_109_7 then
						iter_109_7.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_106_1.var_.actorSpriteComps1074 = nil
			end

			local var_109_5 = 0
			local var_109_6 = 0.225

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_7 = arg_106_1:GetWordFromCfg(418091026)
				local var_109_8 = arg_106_1:FormatText(var_109_7.content)

				arg_106_1.text_.text = var_109_8

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_10 = 9 <= 0 and var_109_6 or var_109_6 * (utf8.len(var_109_8) / 9)

				if (9 <= 0 and var_109_6 or var_109_6 * (utf8.len(var_109_8) / 9)) > 0 and var_109_6 < var_109_10 then
					arg_106_1.talkMaxDuration = var_109_10

					if var_109_10 + var_109_5 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_5
					end
				end

				arg_106_1.text_.text = var_109_8
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091026", "story_v_side_old_418091.awb") ~= 0 then
					local var_109_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091026", "story_v_side_old_418091.awb") / 1000

					if var_109_11 + var_109_5 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_5
					end

					if var_109_7.prefab_name ~= "" and arg_106_1.actors_[var_109_7.prefab_name] ~= nil then
						local var_109_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_7.prefab_name].transform, "story_v_side_old_418091", "418091026", "story_v_side_old_418091.awb")

						arg_106_1:RecordAudio("418091026", var_109_12)
						arg_106_1:RecordAudio("418091026", var_109_12)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091026", "story_v_side_old_418091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091026", "story_v_side_old_418091.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_13 = math.max(var_109_6, arg_106_1.talkMaxDuration)

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_13 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_5) / var_109_13

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_5 + var_109_13 and arg_106_1.time_ < var_109_5 + var_109_13 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play418091027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 418091027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play418091028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["10135"]) and arg_110_1.var_.actorSpriteComps10135 == nil then
				arg_110_1.var_.actorSpriteComps10135 = arg_110_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["10135"]) then
				if arg_110_1.var_.actorSpriteComps10135 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								iter_113_1.color = Color.New(Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor2.r, (arg_110_1.time_ - 0) / var_113_0), Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor2.g, (arg_110_1.time_ - 0) / var_113_0), (Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor2.b, (arg_110_1.time_ - 0) / var_113_0)))
							else
								local var_113_1 = Mathf.Lerp(iter_113_1.color.r, 0.5, (arg_110_1.time_ - 0) / var_113_0)

								iter_113_1.color = Color.New(var_113_1, var_113_1, var_113_1)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["10135"]) and arg_110_1.var_.actorSpriteComps10135 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_113_3 then
						iter_113_3.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_110_1.var_.actorSpriteComps10135 = nil
			end

			local var_113_2 = arg_110_1.actors_["1074"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1074 = var_113_2.localPosition
				var_113_2.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("1074", 7)

				for iter_113_4 = 0, var_113_2.childCount - 1 do
					local var_113_3 = var_113_2:GetChild(iter_113_4)

					if var_113_3.name == "" or not string.find(var_113_3.name, "split") then
						var_113_3.gameObject:SetActive(true)
					else
						var_113_3.gameObject:SetActive(false)
					end
				end
			end

			local var_113_4 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				var_113_2.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1074, Vector3.New(0, -2000, 0), (arg_110_1.time_ - 0) / var_113_4)
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				var_113_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_113_5 = arg_110_1.actors_["10135"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10135 = var_113_5.localPosition
				var_113_5.localScale = Vector3.New(1, 1, 1)

				arg_110_1:CheckSpriteTmpPos("10135", 7)

				for iter_113_5 = 0, var_113_5.childCount - 1 do
					local var_113_6 = var_113_5:GetChild(iter_113_5)

					if var_113_6.name == "" or not string.find(var_113_6.name, "split") then
						var_113_6.gameObject:SetActive(true)
					else
						var_113_6.gameObject:SetActive(false)
					end
				end
			end

			local var_113_7 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				var_113_5.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_110_1.time_ - 0) / var_113_7)
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				var_113_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_113_8 = 0
			local var_113_9 = 1.075

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_10 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(418091027).content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_12 = 43 <= 0 and var_113_9 or var_113_9 * (utf8.len(var_113_10) / 43)

				if (43 <= 0 and var_113_9 or var_113_9 * (utf8.len(var_113_10) / 43)) > 0 and var_113_9 < var_113_12 then
					arg_110_1.talkMaxDuration = var_113_12

					if var_113_12 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_8
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_13 = math.max(var_113_9, arg_110_1.talkMaxDuration)

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_13 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_8) / var_113_13

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_8 + var_113_13 and arg_110_1.time_ < var_113_8 + var_113_13 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play418091028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 418091028
		arg_114_1.duration_ = 8.27

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play418091029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 2 < arg_114_1.time_ and arg_114_1.time_ <= 2 + arg_117_0 then
				local var_117_0 = arg_114_1.bgs_.STblack

				arg_114_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_117_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_1 = var_117_0:GetComponent("SpriteRenderer")

				if var_117_1 and var_117_1.sprite then
					local var_117_2 = 2 * (var_117_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_117_0.transform.localScale = Vector3.New(var_117_2 / var_117_1.sprite.bounds.size.y < var_117_2 * manager.ui.mainCameraCom_.aspect / var_117_1.sprite.bounds.size.x and var_117_2 * manager.ui.mainCameraCom_.aspect / var_117_1.sprite.bounds.size.x or var_117_2 / var_117_1.sprite.bounds.size.y, var_117_2 / var_117_1.sprite.bounds.size.y < var_117_2 * manager.ui.mainCameraCom_.aspect / var_117_1.sprite.bounds.size.x and var_117_2 * manager.ui.mainCameraCom_.aspect / var_117_1.sprite.bounds.size.x or var_117_2 / var_117_1.sprite.bounds.size.y, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "STblack" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_3 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_3 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			if arg_114_1.time_ >= var_117_3 + 0.3 and arg_114_1.time_ < var_117_3 + 0.3 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_4 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_5 = 2

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_5 then
				local var_117_6 = Color.New(0, 0, 0)

				var_117_6.a = Mathf.Lerp(0, 1, (arg_114_1.time_ - var_117_4) / var_117_5)
				arg_114_1.mask_.color = var_117_6
			end

			if arg_114_1.time_ >= var_117_4 + var_117_5 and arg_114_1.time_ < var_117_4 + var_117_5 + arg_117_0 then
				local var_117_7 = Color.New(0, 0, 0)

				var_117_7.a = 1
				arg_114_1.mask_.color = var_117_7
			end

			local var_117_8 = 2

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_9 = 1.26666666666667

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_9 then
				local var_117_10 = Color.New(0, 0, 0)

				var_117_10.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_8) / var_117_9)
				arg_114_1.mask_.color = var_117_10
			end

			if arg_114_1.time_ >= var_117_8 + var_117_9 and arg_114_1.time_ < var_117_8 + var_117_9 + arg_117_0 then
				local var_117_11 = Color.New(0, 0, 0)

				arg_114_1.mask_.enabled = false
				var_117_11.a = 0
				arg_114_1.mask_.color = var_117_11
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_12 = 3.26666666666667
			local var_117_13 = 0.25

			if 3.26666666666667 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_14 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_14:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(418091028).content)

				arg_114_1.text_.text = var_117_15

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 10 <= 0 and var_117_13 or var_117_13 * (utf8.len(var_117_15) / 10)

				if (10 <= 0 and var_117_13 or var_117_13 * (utf8.len(var_117_15) / 10)) > 0 and var_117_13 < var_117_17 then
					arg_114_1.talkMaxDuration = var_117_17
					var_117_12 = var_117_12 + 0.3

					if var_117_17 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_17 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_15
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_18 = var_117_12 + 0.3
			local var_117_19 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_18 + var_117_19 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_18) / var_117_19

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_18 + var_117_19 and arg_114_1.time_ < var_117_18 + var_117_19 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play418091029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 418091029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play418091030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.825

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(418091029).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 33 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 33)

				if (33 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 33)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play418091030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 418091030
		arg_124_1.duration_ = 9.5

		local var_124_0 = {
			ja = 9.49966666666667,
			CriLanguages = 6.66666666666667,
			zh = 6.66666666666667
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play418091031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 1.399999999999 < arg_124_1.time_ and arg_124_1.time_ <= 1.399999999999 + arg_127_0 then
				local var_127_0 = arg_124_1.bgs_.ST1002a

				arg_124_1.bgs_.ST1002a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_127_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_127_1 = var_127_0:GetComponent("SpriteRenderer")

				if var_127_1 and var_127_1.sprite then
					local var_127_2 = 2 * (var_127_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_127_0.transform.localScale = Vector3.New(var_127_2 / var_127_1.sprite.bounds.size.y < var_127_2 * manager.ui.mainCameraCom_.aspect / var_127_1.sprite.bounds.size.x and var_127_2 * manager.ui.mainCameraCom_.aspect / var_127_1.sprite.bounds.size.x or var_127_2 / var_127_1.sprite.bounds.size.y, var_127_2 / var_127_1.sprite.bounds.size.y < var_127_2 * manager.ui.mainCameraCom_.aspect / var_127_1.sprite.bounds.size.x and var_127_2 * manager.ui.mainCameraCom_.aspect / var_127_1.sprite.bounds.size.x or var_127_2 / var_127_1.sprite.bounds.size.y, 0)
				end

				for iter_127_0, iter_127_1 in pairs(arg_124_1.bgs_) do
					if iter_127_0 ~= "ST1002a" then
						iter_127_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_127_3 = 1.399999999999

			if 1.399999999999 < arg_124_1.time_ and arg_124_1.time_ <= var_127_3 + arg_127_0 then
				arg_124_1.allBtn_.enabled = false
			end

			if arg_124_1.time_ >= var_127_3 + 0.3 and arg_124_1.time_ < var_127_3 + 0.3 + arg_127_0 then
				arg_124_1.allBtn_.enabled = true
			end

			local var_127_4 = 0

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_5 = 1.4

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_5 then
				local var_127_6 = Color.New(0, 0, 0)

				var_127_6.a = Mathf.Lerp(0, 1, (arg_124_1.time_ - var_127_4) / var_127_5)
				arg_124_1.mask_.color = var_127_6
			end

			if arg_124_1.time_ >= var_127_4 + var_127_5 and arg_124_1.time_ < var_127_4 + var_127_5 + arg_127_0 then
				local var_127_7 = Color.New(0, 0, 0)

				var_127_7.a = 1
				arg_124_1.mask_.color = var_127_7
			end

			local var_127_8 = 1.399999999999

			if 1.399999999999 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.mask_.enabled = true
				arg_124_1.mask_.raycastTarget = true

				arg_124_1:SetGaussion(false)
			end

			local var_127_9 = 2

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_9 then
				local var_127_10 = Color.New(0, 0, 0)

				var_127_10.a = Mathf.Lerp(1, 0, (arg_124_1.time_ - var_127_8) / var_127_9)
				arg_124_1.mask_.color = var_127_10
			end

			if arg_124_1.time_ >= var_127_8 + var_127_9 and arg_124_1.time_ < var_127_8 + var_127_9 + arg_127_0 then
				local var_127_11 = Color.New(0, 0, 0)

				arg_124_1.mask_.enabled = false
				var_127_11.a = 0
				arg_124_1.mask_.color = var_127_11
			end

			local var_127_12 = "1095"

			if arg_124_1.actors_["1095"] == nil then
				local var_127_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1095")

				if not isNil(var_127_13) then
					local var_127_14 = Object.Instantiate(var_127_13, arg_124_1.canvasGo_.transform)

					var_127_14.transform:SetSiblingIndex(1)

					var_127_14.name = var_127_12
					var_127_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_124_1.actors_[var_127_12] = var_127_14

					if arg_124_1.isInRecall_ then
						for iter_127_2, iter_127_3 in ipairs((var_127_14:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_127_3.color = arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_127_15 = arg_124_1.actors_["1095"]

			if 1.399999999999 < arg_124_1.time_ and arg_124_1.time_ <= 1.399999999999 + arg_127_0 and not isNil(var_127_15) and arg_124_1.var_.actorSpriteComps1095 == nil then
				arg_124_1.var_.actorSpriteComps1095 = var_127_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_16 = 0.2

			if 1.399999999999 <= arg_124_1.time_ and arg_124_1.time_ < 1.399999999999 + var_127_16 and not isNil(var_127_15) then
				if arg_124_1.var_.actorSpriteComps1095 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								iter_127_5.color = Color.New(Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 1.399999999999) / var_127_16), Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 1.399999999999) / var_127_16), (Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 1.399999999999) / var_127_16)))
							else
								local var_127_17 = Mathf.Lerp(iter_127_5.color.r, 1, (arg_124_1.time_ - 1.399999999999) / var_127_16)

								iter_127_5.color = Color.New(var_127_17, var_127_17, var_127_17)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 1.399999999999 + var_127_16 and arg_124_1.time_ < 1.399999999999 + var_127_16 + arg_127_0 and not isNil(var_127_15) and arg_124_1.var_.actorSpriteComps1095 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_127_7 then
						iter_127_7.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps1095 = nil
			end

			if arg_124_1.frameCnt_ <= 1 then
				arg_124_1.dialog_:SetActive(false)
			end

			local var_127_18 = 3.16666666666667
			local var_127_19 = 0.4

			if 3.16666666666667 < arg_124_1.time_ and arg_124_1.time_ <= var_127_18 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0

				arg_124_1.dialog_:SetActive(true)

				arg_124_1.dialogCg_.alpha = 0

				local var_127_20 = LeanTween.value(arg_124_1.dialog_, 0, 1, 0.3)

				var_127_20:setOnUpdate(LuaHelper.FloatAction(function(arg_128_0)
					arg_124_1.dialogCg_.alpha = arg_128_0
				end))
				var_127_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_124_1.dialog_)
					var_127_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_124_1.duration_ = arg_124_1.duration_ + 0.3

				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_107301_split_1")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_21 = arg_124_1:GetWordFromCfg(418091030)
				local var_127_22 = arg_124_1:FormatText(var_127_21.content)

				arg_124_1.text_.text = var_127_22

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_24 = 16 <= 0 and var_127_19 or var_127_19 * (utf8.len(var_127_22) / 16)

				if (16 <= 0 and var_127_19 or var_127_19 * (utf8.len(var_127_22) / 16)) > 0 and var_127_19 < var_127_24 then
					arg_124_1.talkMaxDuration = var_127_24
					var_127_18 = var_127_18 + 0.3

					if var_127_24 + var_127_18 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_24 + var_127_18
					end
				end

				arg_124_1.text_.text = var_127_22
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091030", "story_v_side_old_418091.awb") ~= 0 then
					local var_127_25 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091030", "story_v_side_old_418091.awb") / 1000

					if var_127_25 + var_127_18 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_25 + var_127_18
					end

					if var_127_21.prefab_name ~= "" and arg_124_1.actors_[var_127_21.prefab_name] ~= nil then
						local var_127_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_21.prefab_name].transform, "story_v_side_old_418091", "418091030", "story_v_side_old_418091.awb")

						arg_124_1:RecordAudio("418091030", var_127_26)
						arg_124_1:RecordAudio("418091030", var_127_26)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091030", "story_v_side_old_418091.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091030", "story_v_side_old_418091.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_27 = var_127_18 + 0.3
			local var_127_28 = math.max(var_127_19, arg_124_1.talkMaxDuration)

			if var_127_18 + 0.3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_27 + var_127_28 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_27) / var_127_28

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_27 + var_127_28 and arg_124_1.time_ < var_127_27 + var_127_28 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play418091031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 418091031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play418091032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1095"]) and arg_130_1.var_.actorSpriteComps1095 == nil then
				arg_130_1.var_.actorSpriteComps1095 = arg_130_1.actors_["1095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1095"]) then
				if arg_130_1.var_.actorSpriteComps1095 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								iter_133_1.color = Color.New(Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor2.r, (arg_130_1.time_ - 0) / var_133_0), Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor2.g, (arg_130_1.time_ - 0) / var_133_0), (Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor2.b, (arg_130_1.time_ - 0) / var_133_0)))
							else
								local var_133_1 = Mathf.Lerp(iter_133_1.color.r, 0.5, (arg_130_1.time_ - 0) / var_133_0)

								iter_133_1.color = Color.New(var_133_1, var_133_1, var_133_1)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1095"]) and arg_130_1.var_.actorSpriteComps1095 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_133_3 then
						iter_133_3.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_130_1.var_.actorSpriteComps1095 = nil
			end

			local var_133_2 = 0
			local var_133_3 = 1.525

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(418091031).content)

				arg_130_1.text_.text = var_133_4

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_6 = 61 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_4) / 61)

				if (61 <= 0 and var_133_3 or var_133_3 * (utf8.len(var_133_4) / 61)) > 0 and var_133_3 < var_133_6 then
					arg_130_1.talkMaxDuration = var_133_6

					if var_133_6 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_6 + var_133_2
					end
				end

				arg_130_1.text_.text = var_133_4
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_3, arg_130_1.talkMaxDuration)

			if var_133_2 <= arg_130_1.time_ and arg_130_1.time_ < var_133_2 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_2) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_2 + var_133_7 and arg_130_1.time_ < var_133_2 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play418091032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 418091032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play418091033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 1

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(418091032).content)

				arg_134_1.text_.text = var_137_1

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_3 = 40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)

				if (40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)) > 0 and var_137_0 < var_137_3 then
					arg_134_1.talkMaxDuration = var_137_3

					if var_137_3 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_3 + 0
					end
				end

				arg_134_1.text_.text = var_137_1
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_4 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_4

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play418091033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 418091033
		arg_138_1.duration_ = 3.93

		local var_138_0 = {
			ja = 2.833,
			CriLanguages = 3.933,
			zh = 1.933
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play418091034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10135"]) and arg_138_1.var_.actorSpriteComps10135 == nil then
				arg_138_1.var_.actorSpriteComps10135 = arg_138_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10135"]) then
				if arg_138_1.var_.actorSpriteComps10135 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								iter_141_1.color = Color.New(Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, (arg_138_1.time_ - 0) / var_141_0), Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, (arg_138_1.time_ - 0) / var_141_0), (Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, (arg_138_1.time_ - 0) / var_141_0)))
							else
								local var_141_1 = Mathf.Lerp(iter_141_1.color.r, 1, (arg_138_1.time_ - 0) / var_141_0)

								iter_141_1.color = Color.New(var_141_1, var_141_1, var_141_1)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10135"]) and arg_138_1.var_.actorSpriteComps10135 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps10135 = nil
			end

			local var_141_2 = arg_138_1.actors_["10135"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10135 = var_141_2.localPosition
				var_141_2.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10135", 3)

				for iter_141_4 = 0, var_141_2.childCount - 1 do
					local var_141_3 = var_141_2:GetChild(iter_141_4)

					if var_141_3.name == "split_1" or not string.find(var_141_3.name, "split") then
						var_141_3.gameObject:SetActive(true)
					else
						var_141_3.gameObject:SetActive(false)
					end
				end
			end

			local var_141_4 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				var_141_2.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10135, Vector3.New(-12.7, -363.6, -305.9), (arg_138_1.time_ - 0) / var_141_4)
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				var_141_2.localPosition = Vector3.New(-12.7, -363.6, -305.9)
			end

			local var_141_5 = 0
			local var_141_6 = 0.45

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:GetWordFromCfg(418091033)
				local var_141_8 = arg_138_1:FormatText(var_141_7.content)

				arg_138_1.text_.text = var_141_8

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_10 = 8 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 8)

				if (8 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_8) / 8)) > 0 and var_141_6 < var_141_10 then
					arg_138_1.talkMaxDuration = var_141_10

					if var_141_10 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_8
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091033", "story_v_side_old_418091.awb") ~= 0 then
					local var_141_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091033", "story_v_side_old_418091.awb") / 1000

					if var_141_11 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_5
					end

					if var_141_7.prefab_name ~= "" and arg_138_1.actors_[var_141_7.prefab_name] ~= nil then
						local var_141_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_7.prefab_name].transform, "story_v_side_old_418091", "418091033", "story_v_side_old_418091.awb")

						arg_138_1:RecordAudio("418091033", var_141_12)
						arg_138_1:RecordAudio("418091033", var_141_12)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091033", "story_v_side_old_418091.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091033", "story_v_side_old_418091.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_13 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_13 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_13

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_13 and arg_138_1.time_ < var_141_5 + var_141_13 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play418091034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 418091034
		arg_142_1.duration_ = 4.4

		local var_142_0 = {
			ja = 4.4,
			CriLanguages = 3.433,
			zh = 3.433
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play418091035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1074"]) and arg_142_1.var_.actorSpriteComps1074 == nil then
				arg_142_1.var_.actorSpriteComps1074 = arg_142_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1074"]) then
				if arg_142_1.var_.actorSpriteComps1074 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								iter_145_1.color = Color.New(Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, (arg_142_1.time_ - 0) / var_145_0), Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, (arg_142_1.time_ - 0) / var_145_0), (Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, (arg_142_1.time_ - 0) / var_145_0)))
							else
								local var_145_1 = Mathf.Lerp(iter_145_1.color.r, 1, (arg_142_1.time_ - 0) / var_145_0)

								iter_145_1.color = Color.New(var_145_1, var_145_1, var_145_1)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1074"]) and arg_142_1.var_.actorSpriteComps1074 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_145_3 then
						iter_145_3.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_142_1.var_.actorSpriteComps1074 = nil
			end

			local var_145_2 = arg_142_1.actors_["10135"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps10135 == nil then
				arg_142_1.var_.actorSpriteComps10135 = var_145_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_3 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.actorSpriteComps10135 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								iter_145_5.color = Color.New(Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, (arg_142_1.time_ - 0) / var_145_3), Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, (arg_142_1.time_ - 0) / var_145_3), (Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, (arg_142_1.time_ - 0) / var_145_3)))
							else
								local var_145_4 = Mathf.Lerp(iter_145_5.color.r, 0.5, (arg_142_1.time_ - 0) / var_145_3)

								iter_145_5.color = Color.New(var_145_4, var_145_4, var_145_4)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps10135 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_145_7 then
						iter_145_7.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_142_1.var_.actorSpriteComps10135 = nil
			end

			local var_145_5 = arg_142_1.actors_["10135"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10135 = var_145_5.localPosition
				var_145_5.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("10135", 7)

				for iter_145_8 = 0, var_145_5.childCount - 1 do
					local var_145_6 = var_145_5:GetChild(iter_145_8)

					if var_145_6.name == "split_5" or not string.find(var_145_6.name, "split") then
						var_145_6.gameObject:SetActive(true)
					else
						var_145_6.gameObject:SetActive(false)
					end
				end
			end

			local var_145_7 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				var_145_5.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_142_1.time_ - 0) / var_145_7)
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				var_145_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_145_8 = arg_142_1.actors_["1074"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1074 = var_145_8.localPosition
				var_145_8.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("1074", 3)

				for iter_145_9 = 0, var_145_8.childCount - 1 do
					local var_145_9 = var_145_8:GetChild(iter_145_9)

					if var_145_9.name == "split_2" or not string.find(var_145_9.name, "split") then
						var_145_9.gameObject:SetActive(true)
					else
						var_145_9.gameObject:SetActive(false)
					end
				end
			end

			local var_145_10 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_10 then
				var_145_8.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1074, Vector3.New(9.7, -328, -206.1), (arg_142_1.time_ - 0) / var_145_10)
			end

			if arg_142_1.time_ >= 0 + var_145_10 and arg_142_1.time_ < 0 + var_145_10 + arg_145_0 then
				var_145_8.localPosition = Vector3.New(9.7, -328, -206.1)
			end

			local var_145_11 = 0
			local var_145_12 = 0.425

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_11 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_13 = arg_142_1:GetWordFromCfg(418091034)
				local var_145_14 = arg_142_1:FormatText(var_145_13.content)

				arg_142_1.text_.text = var_145_14

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_16 = 17 <= 0 and var_145_12 or var_145_12 * (utf8.len(var_145_14) / 17)

				if (17 <= 0 and var_145_12 or var_145_12 * (utf8.len(var_145_14) / 17)) > 0 and var_145_12 < var_145_16 then
					arg_142_1.talkMaxDuration = var_145_16

					if var_145_16 + var_145_11 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_16 + var_145_11
					end
				end

				arg_142_1.text_.text = var_145_14
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091034", "story_v_side_old_418091.awb") ~= 0 then
					local var_145_17 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091034", "story_v_side_old_418091.awb") / 1000

					if var_145_17 + var_145_11 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_17 + var_145_11
					end

					if var_145_13.prefab_name ~= "" and arg_142_1.actors_[var_145_13.prefab_name] ~= nil then
						local var_145_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_13.prefab_name].transform, "story_v_side_old_418091", "418091034", "story_v_side_old_418091.awb")

						arg_142_1:RecordAudio("418091034", var_145_18)
						arg_142_1:RecordAudio("418091034", var_145_18)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091034", "story_v_side_old_418091.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091034", "story_v_side_old_418091.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_19 = math.max(var_145_12, arg_142_1.talkMaxDuration)

			if var_145_11 <= arg_142_1.time_ and arg_142_1.time_ < var_145_11 + var_145_19 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_11) / var_145_19

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_11 + var_145_19 and arg_142_1.time_ < var_145_11 + var_145_19 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play418091035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 418091035
		arg_146_1.duration_ = 9.13

		local var_146_0 = {
			ja = 9.133,
			CriLanguages = 8.9,
			zh = 8.9
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play418091036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if arg_146_1.actors_["107301"] == nil then
				local var_149_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "107301")

				if not isNil(var_149_0) then
					local var_149_1 = Object.Instantiate(var_149_0, arg_146_1.canvasGo_.transform)

					var_149_1.transform:SetSiblingIndex(1)

					var_149_1.name = "107301"
					var_149_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_146_1.actors_["107301"] = var_149_1

					if arg_146_1.isInRecall_ then
						for iter_149_0, iter_149_1 in ipairs((var_149_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_149_1.color = arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_149_2 = arg_146_1.actors_["107301"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.actorSpriteComps107301 == nil then
				arg_146_1.var_.actorSpriteComps107301 = var_149_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_3 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.actorSpriteComps107301 then
					for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_149_3 then
							if arg_146_1.isInRecall_ then
								iter_149_3.color = Color.New(Mathf.Lerp(iter_149_3.color.r, arg_146_1.hightColor1.r, (arg_146_1.time_ - 0) / var_149_3), Mathf.Lerp(iter_149_3.color.g, arg_146_1.hightColor1.g, (arg_146_1.time_ - 0) / var_149_3), (Mathf.Lerp(iter_149_3.color.b, arg_146_1.hightColor1.b, (arg_146_1.time_ - 0) / var_149_3)))
							else
								local var_149_4 = Mathf.Lerp(iter_149_3.color.r, 1, (arg_146_1.time_ - 0) / var_149_3)

								iter_149_3.color = Color.New(var_149_4, var_149_4, var_149_4)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.actorSpriteComps107301 then
				for iter_149_4, iter_149_5 in pairs(arg_146_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_149_5 then
						iter_149_5.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_146_1.var_.actorSpriteComps107301 = nil
			end

			local var_149_5 = arg_146_1.actors_["1074"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_5) and arg_146_1.var_.actorSpriteComps1074 == nil then
				arg_146_1.var_.actorSpriteComps1074 = var_149_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_6 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_6 and not isNil(var_149_5) then
				if arg_146_1.var_.actorSpriteComps1074 then
					for iter_149_6, iter_149_7 in pairs(arg_146_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_149_7 then
							if arg_146_1.isInRecall_ then
								iter_149_7.color = Color.New(Mathf.Lerp(iter_149_7.color.r, arg_146_1.hightColor2.r, (arg_146_1.time_ - 0) / var_149_6), Mathf.Lerp(iter_149_7.color.g, arg_146_1.hightColor2.g, (arg_146_1.time_ - 0) / var_149_6), (Mathf.Lerp(iter_149_7.color.b, arg_146_1.hightColor2.b, (arg_146_1.time_ - 0) / var_149_6)))
							else
								local var_149_7 = Mathf.Lerp(iter_149_7.color.r, 0.5, (arg_146_1.time_ - 0) / var_149_6)

								iter_149_7.color = Color.New(var_149_7, var_149_7, var_149_7)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_6 and arg_146_1.time_ < 0 + var_149_6 + arg_149_0 and not isNil(var_149_5) and arg_146_1.var_.actorSpriteComps1074 then
				for iter_149_8, iter_149_9 in pairs(arg_146_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_149_9 then
						iter_149_9.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_146_1.var_.actorSpriteComps1074 = nil
			end

			local var_149_8 = arg_146_1.actors_["1074"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1074 = var_149_8.localPosition
				var_149_8.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("1074", 7)

				for iter_149_10 = 0, var_149_8.childCount - 1 do
					local var_149_9 = var_149_8:GetChild(iter_149_10)

					if var_149_9.name == "" or not string.find(var_149_9.name, "split") then
						var_149_9.gameObject:SetActive(true)
					else
						var_149_9.gameObject:SetActive(false)
					end
				end
			end

			local var_149_10 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_10 then
				var_149_8.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1074, Vector3.New(0, -2000, 0), (arg_146_1.time_ - 0) / var_149_10)
			end

			if arg_146_1.time_ >= 0 + var_149_10 and arg_146_1.time_ < 0 + var_149_10 + arg_149_0 then
				var_149_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_149_11 = arg_146_1.actors_["107301"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos107301 = var_149_11.localPosition
				var_149_11.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("107301", 3)

				for iter_149_11 = 0, var_149_11.childCount - 1 do
					local var_149_12 = var_149_11:GetChild(iter_149_11)

					if var_149_12.name == "" or not string.find(var_149_12.name, "split") then
						var_149_12.gameObject:SetActive(true)
					else
						var_149_12.gameObject:SetActive(false)
					end
				end
			end

			local var_149_13 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_13 then
				var_149_11.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos107301, Vector3.New(-14.4, -367.6, -201.9), (arg_146_1.time_ - 0) / var_149_13)
			end

			if arg_146_1.time_ >= 0 + var_149_13 and arg_146_1.time_ < 0 + var_149_13 + arg_149_0 then
				var_149_11.localPosition = Vector3.New(-14.4, -367.6, -201.9)
			end

			local var_149_14 = 0
			local var_149_15 = 1.125

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_16 = arg_146_1:GetWordFromCfg(418091035)
				local var_149_17 = arg_146_1:FormatText(var_149_16.content)

				arg_146_1.text_.text = var_149_17

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_19 = 45 <= 0 and var_149_15 or var_149_15 * (utf8.len(var_149_17) / 45)

				if (45 <= 0 and var_149_15 or var_149_15 * (utf8.len(var_149_17) / 45)) > 0 and var_149_15 < var_149_19 then
					arg_146_1.talkMaxDuration = var_149_19

					if var_149_19 + var_149_14 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_19 + var_149_14
					end
				end

				arg_146_1.text_.text = var_149_17
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091035", "story_v_side_old_418091.awb") ~= 0 then
					local var_149_20 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091035", "story_v_side_old_418091.awb") / 1000

					if var_149_20 + var_149_14 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_20 + var_149_14
					end

					if var_149_16.prefab_name ~= "" and arg_146_1.actors_[var_149_16.prefab_name] ~= nil then
						local var_149_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_16.prefab_name].transform, "story_v_side_old_418091", "418091035", "story_v_side_old_418091.awb")

						arg_146_1:RecordAudio("418091035", var_149_21)
						arg_146_1:RecordAudio("418091035", var_149_21)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091035", "story_v_side_old_418091.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091035", "story_v_side_old_418091.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_22 = math.max(var_149_15, arg_146_1.talkMaxDuration)

			if var_149_14 <= arg_146_1.time_ and arg_146_1.time_ < var_149_14 + var_149_22 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_14) / var_149_22

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_14 + var_149_22 and arg_146_1.time_ < var_149_14 + var_149_22 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play418091036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 418091036
		arg_150_1.duration_ = 13.07

		local var_150_0 = {
			ja = 13.066,
			CriLanguages = 8.866,
			zh = 8.866
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play418091037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if arg_150_1.actors_["1060"] == nil then
				local var_153_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_153_0) then
					local var_153_1 = Object.Instantiate(var_153_0, arg_150_1.canvasGo_.transform)

					var_153_1.transform:SetSiblingIndex(1)

					var_153_1.name = "1060"
					var_153_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_150_1.actors_["1060"] = var_153_1

					if arg_150_1.isInRecall_ then
						for iter_153_0, iter_153_1 in ipairs((var_153_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_153_1.color = arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_153_2 = arg_150_1.actors_["1060"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps1060 == nil then
				arg_150_1.var_.actorSpriteComps1060 = var_153_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_3 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.actorSpriteComps1060 then
					for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_153_3 then
							if arg_150_1.isInRecall_ then
								iter_153_3.color = Color.New(Mathf.Lerp(iter_153_3.color.r, arg_150_1.hightColor1.r, (arg_150_1.time_ - 0) / var_153_3), Mathf.Lerp(iter_153_3.color.g, arg_150_1.hightColor1.g, (arg_150_1.time_ - 0) / var_153_3), (Mathf.Lerp(iter_153_3.color.b, arg_150_1.hightColor1.b, (arg_150_1.time_ - 0) / var_153_3)))
							else
								local var_153_4 = Mathf.Lerp(iter_153_3.color.r, 1, (arg_150_1.time_ - 0) / var_153_3)

								iter_153_3.color = Color.New(var_153_4, var_153_4, var_153_4)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps1060 then
				for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_153_5 then
						iter_153_5.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_150_1.var_.actorSpriteComps1060 = nil
			end

			local var_153_5 = arg_150_1.actors_["107301"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.actorSpriteComps107301 == nil then
				arg_150_1.var_.actorSpriteComps107301 = var_153_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_6 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_6 and not isNil(var_153_5) then
				if arg_150_1.var_.actorSpriteComps107301 then
					for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_153_7 then
							if arg_150_1.isInRecall_ then
								iter_153_7.color = Color.New(Mathf.Lerp(iter_153_7.color.r, arg_150_1.hightColor2.r, (arg_150_1.time_ - 0) / var_153_6), Mathf.Lerp(iter_153_7.color.g, arg_150_1.hightColor2.g, (arg_150_1.time_ - 0) / var_153_6), (Mathf.Lerp(iter_153_7.color.b, arg_150_1.hightColor2.b, (arg_150_1.time_ - 0) / var_153_6)))
							else
								local var_153_7 = Mathf.Lerp(iter_153_7.color.r, 0.5, (arg_150_1.time_ - 0) / var_153_6)

								iter_153_7.color = Color.New(var_153_7, var_153_7, var_153_7)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_6 and arg_150_1.time_ < 0 + var_153_6 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.actorSpriteComps107301 then
				for iter_153_8, iter_153_9 in pairs(arg_150_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_153_9 then
						iter_153_9.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_150_1.var_.actorSpriteComps107301 = nil
			end

			local var_153_8 = arg_150_1.actors_["107301"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos107301 = var_153_8.localPosition
				var_153_8.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("107301", 7)

				for iter_153_10 = 0, var_153_8.childCount - 1 do
					local var_153_9 = var_153_8:GetChild(iter_153_10)

					if var_153_9.name == "" or not string.find(var_153_9.name, "split") then
						var_153_9.gameObject:SetActive(true)
					else
						var_153_9.gameObject:SetActive(false)
					end
				end
			end

			local var_153_10 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_10 then
				var_153_8.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos107301, Vector3.New(0, -2000, 0), (arg_150_1.time_ - 0) / var_153_10)
			end

			if arg_150_1.time_ >= 0 + var_153_10 and arg_150_1.time_ < 0 + var_153_10 + arg_153_0 then
				var_153_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_153_11 = arg_150_1.actors_["1060"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1060 = var_153_11.localPosition
				var_153_11.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("1060", 3)

				for iter_153_11 = 0, var_153_11.childCount - 1 do
					local var_153_12 = var_153_11:GetChild(iter_153_11)

					if var_153_12.name == "split_2" or not string.find(var_153_12.name, "split") then
						var_153_12.gameObject:SetActive(true)
					else
						var_153_12.gameObject:SetActive(false)
					end
				end
			end

			local var_153_13 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_13 then
				var_153_11.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_150_1.time_ - 0) / var_153_13)
			end

			if arg_150_1.time_ >= 0 + var_153_13 and arg_150_1.time_ < 0 + var_153_13 + arg_153_0 then
				var_153_11.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_153_14 = 0
			local var_153_15 = 1.25

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_14 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_16 = arg_150_1:GetWordFromCfg(418091036)
				local var_153_17 = arg_150_1:FormatText(var_153_16.content)

				arg_150_1.text_.text = var_153_17

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_19 = 50 <= 0 and var_153_15 or var_153_15 * (utf8.len(var_153_17) / 50)

				if (50 <= 0 and var_153_15 or var_153_15 * (utf8.len(var_153_17) / 50)) > 0 and var_153_15 < var_153_19 then
					arg_150_1.talkMaxDuration = var_153_19

					if var_153_19 + var_153_14 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_14
					end
				end

				arg_150_1.text_.text = var_153_17
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091036", "story_v_side_old_418091.awb") ~= 0 then
					local var_153_20 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091036", "story_v_side_old_418091.awb") / 1000

					if var_153_20 + var_153_14 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_20 + var_153_14
					end

					if var_153_16.prefab_name ~= "" and arg_150_1.actors_[var_153_16.prefab_name] ~= nil then
						local var_153_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_16.prefab_name].transform, "story_v_side_old_418091", "418091036", "story_v_side_old_418091.awb")

						arg_150_1:RecordAudio("418091036", var_153_21)
						arg_150_1:RecordAudio("418091036", var_153_21)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091036", "story_v_side_old_418091.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091036", "story_v_side_old_418091.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_22 = math.max(var_153_15, arg_150_1.talkMaxDuration)

			if var_153_14 <= arg_150_1.time_ and arg_150_1.time_ < var_153_14 + var_153_22 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_14) / var_153_22

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_14 + var_153_22 and arg_150_1.time_ < var_153_14 + var_153_22 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play418091037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 418091037
		arg_154_1.duration_ = 5.7

		local var_154_0 = {
			ja = 5.7,
			CriLanguages = 4.933,
			zh = 4.933
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play418091038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if arg_154_1.actors_["1071"] == nil then
				local var_157_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1071")

				if not isNil(var_157_0) then
					local var_157_1 = Object.Instantiate(var_157_0, arg_154_1.canvasGo_.transform)

					var_157_1.transform:SetSiblingIndex(1)

					var_157_1.name = "1071"
					var_157_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_154_1.actors_["1071"] = var_157_1

					if arg_154_1.isInRecall_ then
						for iter_157_0, iter_157_1 in ipairs((var_157_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_157_1.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_157_2 = arg_154_1.actors_["1071"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps1071 == nil then
				arg_154_1.var_.actorSpriteComps1071 = var_157_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_3 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.actorSpriteComps1071 then
					for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_157_3 then
							if arg_154_1.isInRecall_ then
								iter_157_3.color = Color.New(Mathf.Lerp(iter_157_3.color.r, arg_154_1.hightColor1.r, (arg_154_1.time_ - 0) / var_157_3), Mathf.Lerp(iter_157_3.color.g, arg_154_1.hightColor1.g, (arg_154_1.time_ - 0) / var_157_3), (Mathf.Lerp(iter_157_3.color.b, arg_154_1.hightColor1.b, (arg_154_1.time_ - 0) / var_157_3)))
							else
								local var_157_4 = Mathf.Lerp(iter_157_3.color.r, 1, (arg_154_1.time_ - 0) / var_157_3)

								iter_157_3.color = Color.New(var_157_4, var_157_4, var_157_4)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps1071 then
				for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_157_5 then
						iter_157_5.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_154_1.var_.actorSpriteComps1071 = nil
			end

			local var_157_5 = arg_154_1.actors_["1060"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_5) and arg_154_1.var_.actorSpriteComps1060 == nil then
				arg_154_1.var_.actorSpriteComps1060 = var_157_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_6 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_6 and not isNil(var_157_5) then
				if arg_154_1.var_.actorSpriteComps1060 then
					for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_157_7 then
							if arg_154_1.isInRecall_ then
								iter_157_7.color = Color.New(Mathf.Lerp(iter_157_7.color.r, arg_154_1.hightColor2.r, (arg_154_1.time_ - 0) / var_157_6), Mathf.Lerp(iter_157_7.color.g, arg_154_1.hightColor2.g, (arg_154_1.time_ - 0) / var_157_6), (Mathf.Lerp(iter_157_7.color.b, arg_154_1.hightColor2.b, (arg_154_1.time_ - 0) / var_157_6)))
							else
								local var_157_7 = Mathf.Lerp(iter_157_7.color.r, 0.5, (arg_154_1.time_ - 0) / var_157_6)

								iter_157_7.color = Color.New(var_157_7, var_157_7, var_157_7)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_6 and arg_154_1.time_ < 0 + var_157_6 + arg_157_0 and not isNil(var_157_5) and arg_154_1.var_.actorSpriteComps1060 then
				for iter_157_8, iter_157_9 in pairs(arg_154_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_157_9 then
						iter_157_9.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_154_1.var_.actorSpriteComps1060 = nil
			end

			local var_157_8 = arg_154_1.actors_["1071"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1071 = var_157_8.localPosition
				var_157_8.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1071", 3)

				for iter_157_10 = 0, var_157_8.childCount - 1 do
					local var_157_9 = var_157_8:GetChild(iter_157_10)

					if var_157_9.name == "" or not string.find(var_157_9.name, "split") then
						var_157_9.gameObject:SetActive(true)
					else
						var_157_9.gameObject:SetActive(false)
					end
				end
			end

			local var_157_10 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_10 then
				var_157_8.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1071, Vector3.New(13.6, -392.9, -306.6), (arg_154_1.time_ - 0) / var_157_10)
			end

			if arg_154_1.time_ >= 0 + var_157_10 and arg_154_1.time_ < 0 + var_157_10 + arg_157_0 then
				var_157_8.localPosition = Vector3.New(13.6, -392.9, -306.6)
			end

			local var_157_11 = arg_154_1.actors_["1060"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1060 = var_157_11.localPosition
				var_157_11.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1060", 7)

				for iter_157_11 = 0, var_157_11.childCount - 1 do
					local var_157_12 = var_157_11:GetChild(iter_157_11)

					if var_157_12.name == "split_2" or not string.find(var_157_12.name, "split") then
						var_157_12.gameObject:SetActive(true)
					else
						var_157_12.gameObject:SetActive(false)
					end
				end
			end

			local var_157_13 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_13 then
				var_157_11.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_154_1.time_ - 0) / var_157_13)
			end

			if arg_154_1.time_ >= 0 + var_157_13 and arg_154_1.time_ < 0 + var_157_13 + arg_157_0 then
				var_157_11.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_157_14 = 0
			local var_157_15 = 0.75

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_16 = arg_154_1:GetWordFromCfg(418091037)
				local var_157_17 = arg_154_1:FormatText(var_157_16.content)

				arg_154_1.text_.text = var_157_17

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_19 = 30 <= 0 and var_157_15 or var_157_15 * (utf8.len(var_157_17) / 30)

				if (30 <= 0 and var_157_15 or var_157_15 * (utf8.len(var_157_17) / 30)) > 0 and var_157_15 < var_157_19 then
					arg_154_1.talkMaxDuration = var_157_19

					if var_157_19 + var_157_14 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_19 + var_157_14
					end
				end

				arg_154_1.text_.text = var_157_17
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091037", "story_v_side_old_418091.awb") ~= 0 then
					local var_157_20 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091037", "story_v_side_old_418091.awb") / 1000

					if var_157_20 + var_157_14 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_20 + var_157_14
					end

					if var_157_16.prefab_name ~= "" and arg_154_1.actors_[var_157_16.prefab_name] ~= nil then
						local var_157_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_16.prefab_name].transform, "story_v_side_old_418091", "418091037", "story_v_side_old_418091.awb")

						arg_154_1:RecordAudio("418091037", var_157_21)
						arg_154_1:RecordAudio("418091037", var_157_21)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091037", "story_v_side_old_418091.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091037", "story_v_side_old_418091.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_22 = math.max(var_157_15, arg_154_1.talkMaxDuration)

			if var_157_14 <= arg_154_1.time_ and arg_154_1.time_ < var_157_14 + var_157_22 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_14) / var_157_22

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_14 + var_157_22 and arg_154_1.time_ < var_157_14 + var_157_22 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play418091038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 418091038
		arg_158_1.duration_ = 5.5

		local var_158_0 = {
			ja = 5.5,
			CriLanguages = 4.066,
			zh = 4.066
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play418091039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.525

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:GetWordFromCfg(418091038)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 21 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 21)

				if (21 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 21)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091038", "story_v_side_old_418091.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091038", "story_v_side_old_418091.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_side_old_418091", "418091038", "story_v_side_old_418091.awb")

						arg_158_1:RecordAudio("418091038", var_161_6)
						arg_158_1:RecordAudio("418091038", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091038", "story_v_side_old_418091.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091038", "story_v_side_old_418091.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play418091039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 418091039
		arg_162_1.duration_ = 3.3

		local var_162_0 = {
			ja = 3.3,
			CriLanguages = 3.1,
			zh = 3.1
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play418091040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["107301"]) and arg_162_1.var_.actorSpriteComps107301 == nil then
				arg_162_1.var_.actorSpriteComps107301 = arg_162_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_0 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["107301"]) then
				if arg_162_1.var_.actorSpriteComps107301 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								iter_165_1.color = Color.New(Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, (arg_162_1.time_ - 0) / var_165_0), Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, (arg_162_1.time_ - 0) / var_165_0), (Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, (arg_162_1.time_ - 0) / var_165_0)))
							else
								local var_165_1 = Mathf.Lerp(iter_165_1.color.r, 1, (arg_162_1.time_ - 0) / var_165_0)

								iter_165_1.color = Color.New(var_165_1, var_165_1, var_165_1)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["107301"]) and arg_162_1.var_.actorSpriteComps107301 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_165_3 then
						iter_165_3.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_162_1.var_.actorSpriteComps107301 = nil
			end

			local var_165_2 = arg_162_1.actors_["1071"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_2) and arg_162_1.var_.actorSpriteComps1071 == nil then
				arg_162_1.var_.actorSpriteComps1071 = var_165_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_3 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_3 and not isNil(var_165_2) then
				if arg_162_1.var_.actorSpriteComps1071 then
					for iter_165_4, iter_165_5 in pairs(arg_162_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_165_5 then
							if arg_162_1.isInRecall_ then
								iter_165_5.color = Color.New(Mathf.Lerp(iter_165_5.color.r, arg_162_1.hightColor2.r, (arg_162_1.time_ - 0) / var_165_3), Mathf.Lerp(iter_165_5.color.g, arg_162_1.hightColor2.g, (arg_162_1.time_ - 0) / var_165_3), (Mathf.Lerp(iter_165_5.color.b, arg_162_1.hightColor2.b, (arg_162_1.time_ - 0) / var_165_3)))
							else
								local var_165_4 = Mathf.Lerp(iter_165_5.color.r, 0.5, (arg_162_1.time_ - 0) / var_165_3)

								iter_165_5.color = Color.New(var_165_4, var_165_4, var_165_4)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_3 and arg_162_1.time_ < 0 + var_165_3 + arg_165_0 and not isNil(var_165_2) and arg_162_1.var_.actorSpriteComps1071 then
				for iter_165_6, iter_165_7 in pairs(arg_162_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_165_7 then
						iter_165_7.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_162_1.var_.actorSpriteComps1071 = nil
			end

			local var_165_5 = arg_162_1.actors_["1071"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1071 = var_165_5.localPosition
				var_165_5.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("1071", 4)

				for iter_165_8 = 0, var_165_5.childCount - 1 do
					local var_165_6 = var_165_5:GetChild(iter_165_8)

					if var_165_6.name == "" or not string.find(var_165_6.name, "split") then
						var_165_6.gameObject:SetActive(true)
					else
						var_165_6.gameObject:SetActive(false)
					end
				end
			end

			local var_165_7 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				var_165_5.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1071, Vector3.New(519.94, -392.9, -306.6), (arg_162_1.time_ - 0) / var_165_7)
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				var_165_5.localPosition = Vector3.New(519.94, -392.9, -306.6)
			end

			local var_165_8 = arg_162_1.actors_["107301"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos107301 = var_165_8.localPosition
				var_165_8.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("107301", 2)

				for iter_165_9 = 0, var_165_8.childCount - 1 do
					local var_165_9 = var_165_8:GetChild(iter_165_9)

					if var_165_9.name == "" or not string.find(var_165_9.name, "split") then
						var_165_9.gameObject:SetActive(true)
					else
						var_165_9.gameObject:SetActive(false)
					end
				end
			end

			local var_165_10 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_10 then
				var_165_8.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos107301, Vector3.New(-527.7, -367.6, -206), (arg_162_1.time_ - 0) / var_165_10)
			end

			if arg_162_1.time_ >= 0 + var_165_10 and arg_162_1.time_ < 0 + var_165_10 + arg_165_0 then
				var_165_8.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_165_11 = 0
			local var_165_12 = 0.3

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_11 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_13 = arg_162_1:GetWordFromCfg(418091039)
				local var_165_14 = arg_162_1:FormatText(var_165_13.content)

				arg_162_1.text_.text = var_165_14

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_16 = 12 <= 0 and var_165_12 or var_165_12 * (utf8.len(var_165_14) / 12)

				if (12 <= 0 and var_165_12 or var_165_12 * (utf8.len(var_165_14) / 12)) > 0 and var_165_12 < var_165_16 then
					arg_162_1.talkMaxDuration = var_165_16

					if var_165_16 + var_165_11 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_16 + var_165_11
					end
				end

				arg_162_1.text_.text = var_165_14
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091039", "story_v_side_old_418091.awb") ~= 0 then
					local var_165_17 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091039", "story_v_side_old_418091.awb") / 1000

					if var_165_17 + var_165_11 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_17 + var_165_11
					end

					if var_165_13.prefab_name ~= "" and arg_162_1.actors_[var_165_13.prefab_name] ~= nil then
						local var_165_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_13.prefab_name].transform, "story_v_side_old_418091", "418091039", "story_v_side_old_418091.awb")

						arg_162_1:RecordAudio("418091039", var_165_18)
						arg_162_1:RecordAudio("418091039", var_165_18)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091039", "story_v_side_old_418091.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091039", "story_v_side_old_418091.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_19 = math.max(var_165_12, arg_162_1.talkMaxDuration)

			if var_165_11 <= arg_162_1.time_ and arg_162_1.time_ < var_165_11 + var_165_19 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_11) / var_165_19

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_11 + var_165_19 and arg_162_1.time_ < var_165_11 + var_165_19 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play418091040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 418091040
		arg_166_1.duration_ = 11.2

		local var_166_0 = {
			ja = 11.2,
			CriLanguages = 9.233,
			zh = 9.233
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play418091041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 1.225

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:GetWordFromCfg(418091040)
				local var_169_2 = arg_166_1:FormatText(var_169_1.content)

				arg_166_1.text_.text = var_169_2

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 49 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 49)

				if (49 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 49)) > 0 and var_169_0 < var_169_4 then
					arg_166_1.talkMaxDuration = var_169_4

					if var_169_4 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_4 + 0
					end
				end

				arg_166_1.text_.text = var_169_2
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091040", "story_v_side_old_418091.awb") ~= 0 then
					local var_169_5 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091040", "story_v_side_old_418091.awb") / 1000

					if var_169_5 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + 0
					end

					if var_169_1.prefab_name ~= "" and arg_166_1.actors_[var_169_1.prefab_name] ~= nil then
						local var_169_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_1.prefab_name].transform, "story_v_side_old_418091", "418091040", "story_v_side_old_418091.awb")

						arg_166_1:RecordAudio("418091040", var_169_6)
						arg_166_1:RecordAudio("418091040", var_169_6)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091040", "story_v_side_old_418091.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091040", "story_v_side_old_418091.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play418091041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 418091041
		arg_170_1.duration_ = 5.57

		local var_170_0 = {
			ja = 5.566,
			CriLanguages = 5.166,
			zh = 5.166
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play418091042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1071"]) and arg_170_1.var_.actorSpriteComps1071 == nil then
				arg_170_1.var_.actorSpriteComps1071 = arg_170_1.actors_["1071"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1071"]) then
				if arg_170_1.var_.actorSpriteComps1071 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 1, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1071"]) and arg_170_1.var_.actorSpriteComps1071 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps1071 = nil
			end

			local var_173_2 = arg_170_1.actors_["107301"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps107301 == nil then
				arg_170_1.var_.actorSpriteComps107301 = var_173_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_3 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.actorSpriteComps107301 then
					for iter_173_4, iter_173_5 in pairs(arg_170_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_173_5 then
							if arg_170_1.isInRecall_ then
								iter_173_5.color = Color.New(Mathf.Lerp(iter_173_5.color.r, arg_170_1.hightColor2.r, (arg_170_1.time_ - 0) / var_173_3), Mathf.Lerp(iter_173_5.color.g, arg_170_1.hightColor2.g, (arg_170_1.time_ - 0) / var_173_3), (Mathf.Lerp(iter_173_5.color.b, arg_170_1.hightColor2.b, (arg_170_1.time_ - 0) / var_173_3)))
							else
								local var_173_4 = Mathf.Lerp(iter_173_5.color.r, 0.5, (arg_170_1.time_ - 0) / var_173_3)

								iter_173_5.color = Color.New(var_173_4, var_173_4, var_173_4)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.actorSpriteComps107301 then
				for iter_173_6, iter_173_7 in pairs(arg_170_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_173_7 then
						iter_173_7.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_170_1.var_.actorSpriteComps107301 = nil
			end

			local var_173_5 = 0
			local var_173_6 = 0.45

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_7 = arg_170_1:GetWordFromCfg(418091041)
				local var_173_8 = arg_170_1:FormatText(var_173_7.content)

				arg_170_1.text_.text = var_173_8

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_10 = 18 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_8) / 18)

				if (18 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_8) / 18)) > 0 and var_173_6 < var_173_10 then
					arg_170_1.talkMaxDuration = var_173_10

					if var_173_10 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_5
					end
				end

				arg_170_1.text_.text = var_173_8
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091041", "story_v_side_old_418091.awb") ~= 0 then
					local var_173_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091041", "story_v_side_old_418091.awb") / 1000

					if var_173_11 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_11 + var_173_5
					end

					if var_173_7.prefab_name ~= "" and arg_170_1.actors_[var_173_7.prefab_name] ~= nil then
						local var_173_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_7.prefab_name].transform, "story_v_side_old_418091", "418091041", "story_v_side_old_418091.awb")

						arg_170_1:RecordAudio("418091041", var_173_12)
						arg_170_1:RecordAudio("418091041", var_173_12)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091041", "story_v_side_old_418091.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091041", "story_v_side_old_418091.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_13 = math.max(var_173_6, arg_170_1.talkMaxDuration)

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_13 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_5) / var_173_13

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_5 + var_173_13 and arg_170_1.time_ < var_173_5 + var_173_13 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play418091042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 418091042
		arg_174_1.duration_ = 12.3

		local var_174_0 = {
			ja = 12.3,
			CriLanguages = 9.366,
			zh = 9.366
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play418091043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["107301"]) and arg_174_1.var_.actorSpriteComps107301 == nil then
				arg_174_1.var_.actorSpriteComps107301 = arg_174_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["107301"]) then
				if arg_174_1.var_.actorSpriteComps107301 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 1, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["107301"]) and arg_174_1.var_.actorSpriteComps107301 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps107301 = nil
			end

			local var_177_2 = arg_174_1.actors_["1071"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps1071 == nil then
				arg_174_1.var_.actorSpriteComps1071 = var_177_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_3 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.actorSpriteComps1071 then
					for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_177_5 then
							if arg_174_1.isInRecall_ then
								iter_177_5.color = Color.New(Mathf.Lerp(iter_177_5.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_3), Mathf.Lerp(iter_177_5.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_3), (Mathf.Lerp(iter_177_5.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_3)))
							else
								local var_177_4 = Mathf.Lerp(iter_177_5.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_3)

								iter_177_5.color = Color.New(var_177_4, var_177_4, var_177_4)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps1071 then
				for iter_177_6, iter_177_7 in pairs(arg_174_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_177_7 then
						iter_177_7.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps1071 = nil
			end

			local var_177_5 = arg_174_1.actors_["107301"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos107301 = var_177_5.localPosition
				var_177_5.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("107301", 2)

				for iter_177_8 = 0, var_177_5.childCount - 1 do
					local var_177_6 = var_177_5:GetChild(iter_177_8)

					if var_177_6.name == "" or not string.find(var_177_6.name, "split") then
						var_177_6.gameObject:SetActive(true)
					else
						var_177_6.gameObject:SetActive(false)
					end
				end
			end

			local var_177_7 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				var_177_5.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos107301, Vector3.New(-527.7, -367.6, -206), (arg_174_1.time_ - 0) / var_177_7)
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				var_177_5.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_177_8 = 0
			local var_177_9 = 1.25

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(418091042)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 50 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 50)

				if (50 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 50)) > 0 and var_177_9 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091042", "story_v_side_old_418091.awb") ~= 0 then
					local var_177_14 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091042", "story_v_side_old_418091.awb") / 1000

					if var_177_14 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_8
					end

					if var_177_10.prefab_name ~= "" and arg_174_1.actors_[var_177_10.prefab_name] ~= nil then
						local var_177_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_10.prefab_name].transform, "story_v_side_old_418091", "418091042", "story_v_side_old_418091.awb")

						arg_174_1:RecordAudio("418091042", var_177_15)
						arg_174_1:RecordAudio("418091042", var_177_15)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091042", "story_v_side_old_418091.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091042", "story_v_side_old_418091.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_16 and arg_174_1.time_ < var_177_8 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play418091043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 418091043
		arg_178_1.duration_ = 5.87

		local var_178_0 = {
			ja = 5.866,
			CriLanguages = 5.6,
			zh = 5.6
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play418091044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1074"]) and arg_178_1.var_.actorSpriteComps1074 == nil then
				arg_178_1.var_.actorSpriteComps1074 = arg_178_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1074"]) then
				if arg_178_1.var_.actorSpriteComps1074 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 1, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1074"]) and arg_178_1.var_.actorSpriteComps1074 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_178_1.var_.actorSpriteComps1074 = nil
			end

			local var_181_2 = arg_178_1.actors_["107301"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps107301 == nil then
				arg_178_1.var_.actorSpriteComps107301 = var_181_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_3 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_3 and not isNil(var_181_2) then
				if arg_178_1.var_.actorSpriteComps107301 then
					for iter_181_4, iter_181_5 in pairs(arg_178_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_181_5 then
							if arg_178_1.isInRecall_ then
								iter_181_5.color = Color.New(Mathf.Lerp(iter_181_5.color.r, arg_178_1.hightColor2.r, (arg_178_1.time_ - 0) / var_181_3), Mathf.Lerp(iter_181_5.color.g, arg_178_1.hightColor2.g, (arg_178_1.time_ - 0) / var_181_3), (Mathf.Lerp(iter_181_5.color.b, arg_178_1.hightColor2.b, (arg_178_1.time_ - 0) / var_181_3)))
							else
								local var_181_4 = Mathf.Lerp(iter_181_5.color.r, 0.5, (arg_178_1.time_ - 0) / var_181_3)

								iter_181_5.color = Color.New(var_181_4, var_181_4, var_181_4)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_3 and arg_178_1.time_ < 0 + var_181_3 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps107301 then
				for iter_181_6, iter_181_7 in pairs(arg_178_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_181_7 then
						iter_181_7.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_178_1.var_.actorSpriteComps107301 = nil
			end

			local var_181_5 = arg_178_1.actors_["1071"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1071 = var_181_5.localPosition
				var_181_5.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1071", 7)

				for iter_181_8 = 0, var_181_5.childCount - 1 do
					local var_181_6 = var_181_5:GetChild(iter_181_8)

					if var_181_6.name == "" or not string.find(var_181_6.name, "split") then
						var_181_6.gameObject:SetActive(true)
					else
						var_181_6.gameObject:SetActive(false)
					end
				end
			end

			local var_181_7 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				var_181_5.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1071, Vector3.New(0, -2000, 7.24), (arg_178_1.time_ - 0) / var_181_7)
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				var_181_5.localPosition = Vector3.New(0, -2000, 7.24)
			end

			local var_181_8 = arg_178_1.actors_["1074"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1074 = var_181_8.localPosition
				var_181_8.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1074", 4)

				for iter_181_9 = 0, var_181_8.childCount - 1 do
					local var_181_9 = var_181_8:GetChild(iter_181_9)

					if var_181_9.name == "" or not string.find(var_181_9.name, "split") then
						var_181_9.gameObject:SetActive(true)
					else
						var_181_9.gameObject:SetActive(false)
					end
				end
			end

			local var_181_10 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_10 then
				var_181_8.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1074, Vector3.New(487.8, -328.5, -206.1), (arg_178_1.time_ - 0) / var_181_10)
			end

			if arg_178_1.time_ >= 0 + var_181_10 and arg_178_1.time_ < 0 + var_181_10 + arg_181_0 then
				var_181_8.localPosition = Vector3.New(487.8, -328.5, -206.1)
			end

			local var_181_11 = 0
			local var_181_12 = 0.675

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_11 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_13 = arg_178_1:GetWordFromCfg(418091043)
				local var_181_14 = arg_178_1:FormatText(var_181_13.content)

				arg_178_1.text_.text = var_181_14

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_16 = 27 <= 0 and var_181_12 or var_181_12 * (utf8.len(var_181_14) / 27)

				if (27 <= 0 and var_181_12 or var_181_12 * (utf8.len(var_181_14) / 27)) > 0 and var_181_12 < var_181_16 then
					arg_178_1.talkMaxDuration = var_181_16

					if var_181_16 + var_181_11 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_16 + var_181_11
					end
				end

				arg_178_1.text_.text = var_181_14
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091043", "story_v_side_old_418091.awb") ~= 0 then
					local var_181_17 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091043", "story_v_side_old_418091.awb") / 1000

					if var_181_17 + var_181_11 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_17 + var_181_11
					end

					if var_181_13.prefab_name ~= "" and arg_178_1.actors_[var_181_13.prefab_name] ~= nil then
						local var_181_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_13.prefab_name].transform, "story_v_side_old_418091", "418091043", "story_v_side_old_418091.awb")

						arg_178_1:RecordAudio("418091043", var_181_18)
						arg_178_1:RecordAudio("418091043", var_181_18)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091043", "story_v_side_old_418091.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091043", "story_v_side_old_418091.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_19 = math.max(var_181_12, arg_178_1.talkMaxDuration)

			if var_181_11 <= arg_178_1.time_ and arg_178_1.time_ < var_181_11 + var_181_19 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_11) / var_181_19

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_11 + var_181_19 and arg_178_1.time_ < var_181_11 + var_181_19 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play418091044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 418091044
		arg_182_1.duration_ = 4.73

		local var_182_0 = {
			ja = 4.733,
			CriLanguages = 2.9,
			zh = 2.9
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play418091045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["107301"]) and arg_182_1.var_.actorSpriteComps107301 == nil then
				arg_182_1.var_.actorSpriteComps107301 = arg_182_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["107301"]) then
				if arg_182_1.var_.actorSpriteComps107301 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 1, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["107301"]) and arg_182_1.var_.actorSpriteComps107301 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps107301 = nil
			end

			local var_185_2 = arg_182_1.actors_["1074"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps1074 == nil then
				arg_182_1.var_.actorSpriteComps1074 = var_185_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_3 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_3 and not isNil(var_185_2) then
				if arg_182_1.var_.actorSpriteComps1074 then
					for iter_185_4, iter_185_5 in pairs(arg_182_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_185_5 then
							if arg_182_1.isInRecall_ then
								iter_185_5.color = Color.New(Mathf.Lerp(iter_185_5.color.r, arg_182_1.hightColor2.r, (arg_182_1.time_ - 0) / var_185_3), Mathf.Lerp(iter_185_5.color.g, arg_182_1.hightColor2.g, (arg_182_1.time_ - 0) / var_185_3), (Mathf.Lerp(iter_185_5.color.b, arg_182_1.hightColor2.b, (arg_182_1.time_ - 0) / var_185_3)))
							else
								local var_185_4 = Mathf.Lerp(iter_185_5.color.r, 0.5, (arg_182_1.time_ - 0) / var_185_3)

								iter_185_5.color = Color.New(var_185_4, var_185_4, var_185_4)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_3 and arg_182_1.time_ < 0 + var_185_3 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps1074 then
				for iter_185_6, iter_185_7 in pairs(arg_182_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_185_7 then
						iter_185_7.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_182_1.var_.actorSpriteComps1074 = nil
			end

			local var_185_5 = arg_182_1.actors_["107301"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos107301 = var_185_5.localPosition
				var_185_5.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("107301", 2)

				for iter_185_8 = 0, var_185_5.childCount - 1 do
					local var_185_6 = var_185_5:GetChild(iter_185_8)

					if var_185_6.name == "split_5" or not string.find(var_185_6.name, "split") then
						var_185_6.gameObject:SetActive(true)
					else
						var_185_6.gameObject:SetActive(false)
					end
				end
			end

			local var_185_7 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				var_185_5.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos107301, Vector3.New(-527.7, -367.6, -206), (arg_182_1.time_ - 0) / var_185_7)
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				var_185_5.localPosition = Vector3.New(-527.7, -367.6, -206)
			end

			local var_185_8 = 0
			local var_185_9 = 0.3

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_8 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_10 = arg_182_1:GetWordFromCfg(418091044)
				local var_185_11 = arg_182_1:FormatText(var_185_10.content)

				arg_182_1.text_.text = var_185_11

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_13 = 12 <= 0 and var_185_9 or var_185_9 * (utf8.len(var_185_11) / 12)

				if (12 <= 0 and var_185_9 or var_185_9 * (utf8.len(var_185_11) / 12)) > 0 and var_185_9 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_8
					end
				end

				arg_182_1.text_.text = var_185_11
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091044", "story_v_side_old_418091.awb") ~= 0 then
					local var_185_14 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091044", "story_v_side_old_418091.awb") / 1000

					if var_185_14 + var_185_8 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_8
					end

					if var_185_10.prefab_name ~= "" and arg_182_1.actors_[var_185_10.prefab_name] ~= nil then
						local var_185_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_10.prefab_name].transform, "story_v_side_old_418091", "418091044", "story_v_side_old_418091.awb")

						arg_182_1:RecordAudio("418091044", var_185_15)
						arg_182_1:RecordAudio("418091044", var_185_15)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091044", "story_v_side_old_418091.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091044", "story_v_side_old_418091.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_16 = math.max(var_185_9, arg_182_1.talkMaxDuration)

			if var_185_8 <= arg_182_1.time_ and arg_182_1.time_ < var_185_8 + var_185_16 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_8) / var_185_16

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_8 + var_185_16 and arg_182_1.time_ < var_185_8 + var_185_16 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play418091045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 418091045
		arg_186_1.duration_ = 4.03

		local var_186_0 = {
			ja = 4.033,
			CriLanguages = 2.566,
			zh = 2.566
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play418091046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1074"]) and arg_186_1.var_.actorSpriteComps1074 == nil then
				arg_186_1.var_.actorSpriteComps1074 = arg_186_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1074"]) then
				if arg_186_1.var_.actorSpriteComps1074 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 1, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1074"]) and arg_186_1.var_.actorSpriteComps1074 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps1074 = nil
			end

			local var_189_2 = arg_186_1.actors_["107301"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps107301 == nil then
				arg_186_1.var_.actorSpriteComps107301 = var_189_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_3 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 and not isNil(var_189_2) then
				if arg_186_1.var_.actorSpriteComps107301 then
					for iter_189_4, iter_189_5 in pairs(arg_186_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_189_5 then
							if arg_186_1.isInRecall_ then
								iter_189_5.color = Color.New(Mathf.Lerp(iter_189_5.color.r, arg_186_1.hightColor2.r, (arg_186_1.time_ - 0) / var_189_3), Mathf.Lerp(iter_189_5.color.g, arg_186_1.hightColor2.g, (arg_186_1.time_ - 0) / var_189_3), (Mathf.Lerp(iter_189_5.color.b, arg_186_1.hightColor2.b, (arg_186_1.time_ - 0) / var_189_3)))
							else
								local var_189_4 = Mathf.Lerp(iter_189_5.color.r, 0.5, (arg_186_1.time_ - 0) / var_189_3)

								iter_189_5.color = Color.New(var_189_4, var_189_4, var_189_4)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps107301 then
				for iter_189_6, iter_189_7 in pairs(arg_186_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_189_7 then
						iter_189_7.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps107301 = nil
			end

			local var_189_5 = arg_186_1.actors_["1074"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1074 = var_189_5.localPosition
				var_189_5.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("1074", 4)

				for iter_189_8 = 0, var_189_5.childCount - 1 do
					local var_189_6 = var_189_5:GetChild(iter_189_8)

					if var_189_6.name == "split_4" or not string.find(var_189_6.name, "split") then
						var_189_6.gameObject:SetActive(true)
					else
						var_189_6.gameObject:SetActive(false)
					end
				end
			end

			local var_189_7 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 then
				var_189_5.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1074, Vector3.New(487.8, -328.5, -206.1), (arg_186_1.time_ - 0) / var_189_7)
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 then
				var_189_5.localPosition = Vector3.New(487.8, -328.5, -206.1)
			end

			local var_189_8 = 0
			local var_189_9 = 0.2

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_10 = arg_186_1:GetWordFromCfg(418091045)
				local var_189_11 = arg_186_1:FormatText(var_189_10.content)

				arg_186_1.text_.text = var_189_11

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 8 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 8)

				if (8 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 8)) > 0 and var_189_9 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_11
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091045", "story_v_side_old_418091.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091045", "story_v_side_old_418091.awb") / 1000

					if var_189_14 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_8
					end

					if var_189_10.prefab_name ~= "" and arg_186_1.actors_[var_189_10.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_10.prefab_name].transform, "story_v_side_old_418091", "418091045", "story_v_side_old_418091.awb")

						arg_186_1:RecordAudio("418091045", var_189_15)
						arg_186_1:RecordAudio("418091045", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091045", "story_v_side_old_418091.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091045", "story_v_side_old_418091.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_16 and arg_186_1.time_ < var_189_8 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play418091046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 418091046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play418091047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1074"]) and arg_190_1.var_.actorSpriteComps1074 == nil then
				arg_190_1.var_.actorSpriteComps1074 = arg_190_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1074"]) then
				if arg_190_1.var_.actorSpriteComps1074 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								iter_193_1.color = Color.New(Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor2.r, (arg_190_1.time_ - 0) / var_193_0), Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor2.g, (arg_190_1.time_ - 0) / var_193_0), (Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor2.b, (arg_190_1.time_ - 0) / var_193_0)))
							else
								local var_193_1 = Mathf.Lerp(iter_193_1.color.r, 0.5, (arg_190_1.time_ - 0) / var_193_0)

								iter_193_1.color = Color.New(var_193_1, var_193_1, var_193_1)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1074"]) and arg_190_1.var_.actorSpriteComps1074 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_190_1.var_.actorSpriteComps1074 = nil
			end

			local var_193_2 = arg_190_1.actors_["1074"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1074 = var_193_2.localPosition
				var_193_2.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("1074", 7)

				for iter_193_4 = 0, var_193_2.childCount - 1 do
					local var_193_3 = var_193_2:GetChild(iter_193_4)

					if var_193_3.name == "" or not string.find(var_193_3.name, "split") then
						var_193_3.gameObject:SetActive(true)
					else
						var_193_3.gameObject:SetActive(false)
					end
				end
			end

			local var_193_4 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				var_193_2.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1074, Vector3.New(0, -2000, 0), (arg_190_1.time_ - 0) / var_193_4)
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				var_193_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_193_5 = arg_190_1.actors_["107301"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos107301 = var_193_5.localPosition
				var_193_5.localScale = Vector3.New(1, 1, 1)

				arg_190_1:CheckSpriteTmpPos("107301", 7)

				for iter_193_5 = 0, var_193_5.childCount - 1 do
					local var_193_6 = var_193_5:GetChild(iter_193_5)

					if var_193_6.name == "" or not string.find(var_193_6.name, "split") then
						var_193_6.gameObject:SetActive(true)
					else
						var_193_6.gameObject:SetActive(false)
					end
				end
			end

			local var_193_7 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 then
				var_193_5.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos107301, Vector3.New(0, -2000, 0), (arg_190_1.time_ - 0) / var_193_7)
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 then
				var_193_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_193_8 = 0
			local var_193_9 = 0.725

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_10 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(418091046).content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_12 = 29 <= 0 and var_193_9 or var_193_9 * (utf8.len(var_193_10) / 29)

				if (29 <= 0 and var_193_9 or var_193_9 * (utf8.len(var_193_10) / 29)) > 0 and var_193_9 < var_193_12 then
					arg_190_1.talkMaxDuration = var_193_12

					if var_193_12 + var_193_8 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_12 + var_193_8
					end
				end

				arg_190_1.text_.text = var_193_10
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_13 = math.max(var_193_9, arg_190_1.talkMaxDuration)

			if var_193_8 <= arg_190_1.time_ and arg_190_1.time_ < var_193_8 + var_193_13 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_8) / var_193_13

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_8 + var_193_13 and arg_190_1.time_ < var_193_8 + var_193_13 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "107301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play418091047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 418091047
		arg_194_1.duration_ = 6.3

		local var_194_0 = {
			ja = 6.3,
			CriLanguages = 5.5,
			zh = 5.5
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play418091048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1074"]) and arg_194_1.var_.actorSpriteComps1074 == nil then
				arg_194_1.var_.actorSpriteComps1074 = arg_194_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1074"]) then
				if arg_194_1.var_.actorSpriteComps1074 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								iter_197_1.color = Color.New(Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, (arg_194_1.time_ - 0) / var_197_0), Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, (arg_194_1.time_ - 0) / var_197_0), (Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, (arg_194_1.time_ - 0) / var_197_0)))
							else
								local var_197_1 = Mathf.Lerp(iter_197_1.color.r, 1, (arg_194_1.time_ - 0) / var_197_0)

								iter_197_1.color = Color.New(var_197_1, var_197_1, var_197_1)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1074"]) and arg_194_1.var_.actorSpriteComps1074 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_197_3 then
						iter_197_3.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_194_1.var_.actorSpriteComps1074 = nil
			end

			local var_197_2 = arg_194_1.actors_["1074"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1074 = var_197_2.localPosition
				var_197_2.localScale = Vector3.New(1, 1, 1)

				arg_194_1:CheckSpriteTmpPos("1074", 4)

				for iter_197_4 = 0, var_197_2.childCount - 1 do
					local var_197_3 = var_197_2:GetChild(iter_197_4)

					if var_197_3.name == "" or not string.find(var_197_3.name, "split") then
						var_197_3.gameObject:SetActive(true)
					else
						var_197_3.gameObject:SetActive(false)
					end
				end
			end

			local var_197_4 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				var_197_2.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1074, Vector3.New(487.8, -328.5, -206.1), (arg_194_1.time_ - 0) / var_197_4)
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				var_197_2.localPosition = Vector3.New(487.8, -328.5, -206.1)
			end

			local var_197_5 = 0
			local var_197_6 = 0.75

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_7 = arg_194_1:GetWordFromCfg(418091047)
				local var_197_8 = arg_194_1:FormatText(var_197_7.content)

				arg_194_1.text_.text = var_197_8

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 30 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_8) / 30)

				if (30 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_8) / 30)) > 0 and var_197_6 < var_197_10 then
					arg_194_1.talkMaxDuration = var_197_10

					if var_197_10 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_5
					end
				end

				arg_194_1.text_.text = var_197_8
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091047", "story_v_side_old_418091.awb") ~= 0 then
					local var_197_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091047", "story_v_side_old_418091.awb") / 1000

					if var_197_11 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_11 + var_197_5
					end

					if var_197_7.prefab_name ~= "" and arg_194_1.actors_[var_197_7.prefab_name] ~= nil then
						local var_197_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_7.prefab_name].transform, "story_v_side_old_418091", "418091047", "story_v_side_old_418091.awb")

						arg_194_1:RecordAudio("418091047", var_197_12)
						arg_194_1:RecordAudio("418091047", var_197_12)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091047", "story_v_side_old_418091.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091047", "story_v_side_old_418091.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_13 = math.max(var_197_6, arg_194_1.talkMaxDuration)

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_13 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_5) / var_197_13

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_5 + var_197_13 and arg_194_1.time_ < var_197_5 + var_197_13 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play418091048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 418091048
		arg_198_1.duration_ = 8.4

		local var_198_0 = {
			ja = 8.333,
			CriLanguages = 8.4,
			zh = 8.4
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play418091049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["10135"]) and arg_198_1.var_.actorSpriteComps10135 == nil then
				arg_198_1.var_.actorSpriteComps10135 = arg_198_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["10135"]) then
				if arg_198_1.var_.actorSpriteComps10135 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 1, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["10135"]) and arg_198_1.var_.actorSpriteComps10135 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_198_1.var_.actorSpriteComps10135 = nil
			end

			local var_201_2 = arg_198_1.actors_["1074"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1074 == nil then
				arg_198_1.var_.actorSpriteComps1074 = var_201_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_3 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 and not isNil(var_201_2) then
				if arg_198_1.var_.actorSpriteComps1074 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								iter_201_5.color = Color.New(Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, (arg_198_1.time_ - 0) / var_201_3), Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, (arg_198_1.time_ - 0) / var_201_3), (Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, (arg_198_1.time_ - 0) / var_201_3)))
							else
								local var_201_4 = Mathf.Lerp(iter_201_5.color.r, 0.5, (arg_198_1.time_ - 0) / var_201_3)

								iter_201_5.color = Color.New(var_201_4, var_201_4, var_201_4)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1074 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_201_7 then
						iter_201_7.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_198_1.var_.actorSpriteComps1074 = nil
			end

			local var_201_5 = arg_198_1.actors_["10135"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10135 = var_201_5.localPosition
				var_201_5.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("10135", 2)

				for iter_201_8 = 0, var_201_5.childCount - 1 do
					local var_201_6 = var_201_5:GetChild(iter_201_8)

					if var_201_6.name == "split_1" or not string.find(var_201_6.name, "split") then
						var_201_6.gameObject:SetActive(true)
					else
						var_201_6.gameObject:SetActive(false)
					end
				end
			end

			local var_201_7 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				var_201_5.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10135, Vector3.New(-448.9, -363.6, -305.9), (arg_198_1.time_ - 0) / var_201_7)
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				var_201_5.localPosition = Vector3.New(-448.9, -363.6, -305.9)
			end

			local var_201_8 = 0
			local var_201_9 = 0.975

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(418091048)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 39 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 39)

				if (39 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 39)) > 0 and var_201_9 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091048", "story_v_side_old_418091.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091048", "story_v_side_old_418091.awb") / 1000

					if var_201_14 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_8
					end

					if var_201_10.prefab_name ~= "" and arg_198_1.actors_[var_201_10.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_10.prefab_name].transform, "story_v_side_old_418091", "418091048", "story_v_side_old_418091.awb")

						arg_198_1:RecordAudio("418091048", var_201_15)
						arg_198_1:RecordAudio("418091048", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091048", "story_v_side_old_418091.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091048", "story_v_side_old_418091.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_16 and arg_198_1.time_ < var_201_8 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play418091049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 418091049
		arg_202_1.duration_ = 9.37

		local var_202_0 = {
			ja = 9.366,
			CriLanguages = 5.533,
			zh = 5.533
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play418091050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.65

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_1 = arg_202_1:GetWordFromCfg(418091049)
				local var_205_2 = arg_202_1:FormatText(var_205_1.content)

				arg_202_1.text_.text = var_205_2

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_4 = 26 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 26)

				if (26 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_2) / 26)) > 0 and var_205_0 < var_205_4 then
					arg_202_1.talkMaxDuration = var_205_4

					if var_205_4 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_4 + 0
					end
				end

				arg_202_1.text_.text = var_205_2
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091049", "story_v_side_old_418091.awb") ~= 0 then
					local var_205_5 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091049", "story_v_side_old_418091.awb") / 1000

					if var_205_5 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + 0
					end

					if var_205_1.prefab_name ~= "" and arg_202_1.actors_[var_205_1.prefab_name] ~= nil then
						local var_205_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_1.prefab_name].transform, "story_v_side_old_418091", "418091049", "story_v_side_old_418091.awb")

						arg_202_1:RecordAudio("418091049", var_205_6)
						arg_202_1:RecordAudio("418091049", var_205_6)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091049", "story_v_side_old_418091.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091049", "story_v_side_old_418091.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_7

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play418091050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 418091050
		arg_206_1.duration_ = 2.93

		local var_206_0 = {
			ja = 2.933,
			CriLanguages = 1.366,
			zh = 1.366
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play418091051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["107301"]) and arg_206_1.var_.actorSpriteComps107301 == nil then
				arg_206_1.var_.actorSpriteComps107301 = arg_206_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["107301"]) then
				if arg_206_1.var_.actorSpriteComps107301 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 1, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["107301"]) and arg_206_1.var_.actorSpriteComps107301 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps107301 = nil
			end

			local var_209_2 = arg_206_1.actors_["10135"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps10135 == nil then
				arg_206_1.var_.actorSpriteComps10135 = var_209_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_3 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 and not isNil(var_209_2) then
				if arg_206_1.var_.actorSpriteComps10135 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								iter_209_5.color = Color.New(Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 0) / var_209_3), Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 0) / var_209_3), (Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 0) / var_209_3)))
							else
								local var_209_4 = Mathf.Lerp(iter_209_5.color.r, 0.5, (arg_206_1.time_ - 0) / var_209_3)

								iter_209_5.color = Color.New(var_209_4, var_209_4, var_209_4)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps10135 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_209_7 then
						iter_209_7.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps10135 = nil
			end

			local var_209_5 = 0
			local var_209_6 = 0.15

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_107301_split_1")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_7 = arg_206_1:GetWordFromCfg(418091050)
				local var_209_8 = arg_206_1:FormatText(var_209_7.content)

				arg_206_1.text_.text = var_209_8

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_10 = 6 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_8) / 6)

				if (6 <= 0 and var_209_6 or var_209_6 * (utf8.len(var_209_8) / 6)) > 0 and var_209_6 < var_209_10 then
					arg_206_1.talkMaxDuration = var_209_10

					if var_209_10 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_5
					end
				end

				arg_206_1.text_.text = var_209_8
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091050", "story_v_side_old_418091.awb") ~= 0 then
					local var_209_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091050", "story_v_side_old_418091.awb") / 1000

					if var_209_11 + var_209_5 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_11 + var_209_5
					end

					if var_209_7.prefab_name ~= "" and arg_206_1.actors_[var_209_7.prefab_name] ~= nil then
						local var_209_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_7.prefab_name].transform, "story_v_side_old_418091", "418091050", "story_v_side_old_418091.awb")

						arg_206_1:RecordAudio("418091050", var_209_12)
						arg_206_1:RecordAudio("418091050", var_209_12)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091050", "story_v_side_old_418091.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091050", "story_v_side_old_418091.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_13 = math.max(var_209_6, arg_206_1.talkMaxDuration)

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_13 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_5) / var_209_13

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_5 + var_209_13 and arg_206_1.time_ < var_209_5 + var_209_13 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play418091051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 418091051
		arg_210_1.duration_ = 2

		local var_210_0 = {
			ja = 2,
			CriLanguages = 1.333,
			zh = 1.333
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play418091052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1074"]) and arg_210_1.var_.actorSpriteComps1074 == nil then
				arg_210_1.var_.actorSpriteComps1074 = arg_210_1.actors_["1074"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1074"]) then
				if arg_210_1.var_.actorSpriteComps1074 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 1, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1074"]) and arg_210_1.var_.actorSpriteComps1074 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps1074 = nil
			end

			local var_213_2 = arg_210_1.actors_["107301"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps107301 == nil then
				arg_210_1.var_.actorSpriteComps107301 = var_213_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_3 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.actorSpriteComps107301 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								iter_213_5.color = Color.New(Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_3), Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_3), (Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_3)))
							else
								local var_213_4 = Mathf.Lerp(iter_213_5.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_3)

								iter_213_5.color = Color.New(var_213_4, var_213_4, var_213_4)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps107301 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_213_7 then
						iter_213_7.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps107301 = nil
			end

			local var_213_5 = 0
			local var_213_6 = 0.125

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_7 = arg_210_1:GetWordFromCfg(418091051)
				local var_213_8 = arg_210_1:FormatText(var_213_7.content)

				arg_210_1.text_.text = var_213_8

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_10 = 5 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 5)

				if (5 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 5)) > 0 and var_213_6 < var_213_10 then
					arg_210_1.talkMaxDuration = var_213_10

					if var_213_10 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_8
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091051", "story_v_side_old_418091.awb") ~= 0 then
					local var_213_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091051", "story_v_side_old_418091.awb") / 1000

					if var_213_11 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_11 + var_213_5
					end

					if var_213_7.prefab_name ~= "" and arg_210_1.actors_[var_213_7.prefab_name] ~= nil then
						local var_213_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_7.prefab_name].transform, "story_v_side_old_418091", "418091051", "story_v_side_old_418091.awb")

						arg_210_1:RecordAudio("418091051", var_213_12)
						arg_210_1:RecordAudio("418091051", var_213_12)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091051", "story_v_side_old_418091.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091051", "story_v_side_old_418091.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_13 = math.max(var_213_6, arg_210_1.talkMaxDuration)

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_13 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_5) / var_213_13

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_5 + var_213_13 and arg_210_1.time_ < var_213_5 + var_213_13 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play418091052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 418091052
		arg_214_1.duration_ = 3.13

		local var_214_0 = {
			ja = 3.133,
			CriLanguages = 2.633,
			zh = 2.633
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play418091053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1060"]) and arg_214_1.var_.actorSpriteComps1060 == nil then
				arg_214_1.var_.actorSpriteComps1060 = arg_214_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1060"]) then
				if arg_214_1.var_.actorSpriteComps1060 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 1, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1060"]) and arg_214_1.var_.actorSpriteComps1060 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps1060 = nil
			end

			local var_217_2 = arg_214_1.actors_["1074"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps1074 == nil then
				arg_214_1.var_.actorSpriteComps1074 = var_217_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_3 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.actorSpriteComps1074 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps1074:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								iter_217_5.color = Color.New(Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_3), Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_3), (Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_3)))
							else
								local var_217_4 = Mathf.Lerp(iter_217_5.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_3)

								iter_217_5.color = Color.New(var_217_4, var_217_4, var_217_4)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps1074 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps1074:ToTable()) do
					if iter_217_7 then
						iter_217_7.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps1074 = nil
			end

			local var_217_5 = arg_214_1.actors_["10135"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10135 = var_217_5.localPosition
				var_217_5.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10135", 7)

				for iter_217_8 = 0, var_217_5.childCount - 1 do
					local var_217_6 = var_217_5:GetChild(iter_217_8)

					if var_217_6.name == "split_5" or not string.find(var_217_6.name, "split") then
						var_217_6.gameObject:SetActive(true)
					else
						var_217_6.gameObject:SetActive(false)
					end
				end
			end

			local var_217_7 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				var_217_5.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10135, Vector3.New(0, -2000, 0), (arg_214_1.time_ - 0) / var_217_7)
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				var_217_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_217_8 = arg_214_1.actors_["1074"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1074 = var_217_8.localPosition
				var_217_8.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("1074", 7)

				for iter_217_9 = 0, var_217_8.childCount - 1 do
					local var_217_9 = var_217_8:GetChild(iter_217_9)

					if var_217_9.name == "" or not string.find(var_217_9.name, "split") then
						var_217_9.gameObject:SetActive(true)
					else
						var_217_9.gameObject:SetActive(false)
					end
				end
			end

			local var_217_10 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_10 then
				var_217_8.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1074, Vector3.New(0, -2000, 0), (arg_214_1.time_ - 0) / var_217_10)
			end

			if arg_214_1.time_ >= 0 + var_217_10 and arg_214_1.time_ < 0 + var_217_10 + arg_217_0 then
				var_217_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_217_11 = arg_214_1.actors_["1060"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1060 = var_217_11.localPosition
				var_217_11.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("1060", 3)

				for iter_217_10 = 0, var_217_11.childCount - 1 do
					local var_217_12 = var_217_11:GetChild(iter_217_10)

					if var_217_12.name == "split_1" or not string.find(var_217_12.name, "split") then
						var_217_12.gameObject:SetActive(true)
					else
						var_217_12.gameObject:SetActive(false)
					end
				end
			end

			local var_217_13 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_13 then
				var_217_11.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_214_1.time_ - 0) / var_217_13)
			end

			if arg_214_1.time_ >= 0 + var_217_13 and arg_214_1.time_ < 0 + var_217_13 + arg_217_0 then
				var_217_11.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_217_14 = 0
			local var_217_15 = 0.375

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_16 = arg_214_1:GetWordFromCfg(418091052)
				local var_217_17 = arg_214_1:FormatText(var_217_16.content)

				arg_214_1.text_.text = var_217_17

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_19 = 15 <= 0 and var_217_15 or var_217_15 * (utf8.len(var_217_17) / 15)

				if (15 <= 0 and var_217_15 or var_217_15 * (utf8.len(var_217_17) / 15)) > 0 and var_217_15 < var_217_19 then
					arg_214_1.talkMaxDuration = var_217_19

					if var_217_19 + var_217_14 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_19 + var_217_14
					end
				end

				arg_214_1.text_.text = var_217_17
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091052", "story_v_side_old_418091.awb") ~= 0 then
					local var_217_20 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091052", "story_v_side_old_418091.awb") / 1000

					if var_217_20 + var_217_14 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_20 + var_217_14
					end

					if var_217_16.prefab_name ~= "" and arg_214_1.actors_[var_217_16.prefab_name] ~= nil then
						local var_217_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_16.prefab_name].transform, "story_v_side_old_418091", "418091052", "story_v_side_old_418091.awb")

						arg_214_1:RecordAudio("418091052", var_217_21)
						arg_214_1:RecordAudio("418091052", var_217_21)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091052", "story_v_side_old_418091.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091052", "story_v_side_old_418091.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_22 = math.max(var_217_15, arg_214_1.talkMaxDuration)

			if var_217_14 <= arg_214_1.time_ and arg_214_1.time_ < var_217_14 + var_217_22 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_14) / var_217_22

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_14 + var_217_22 and arg_214_1.time_ < var_217_14 + var_217_22 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10135",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1074",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play418091053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 418091053
		arg_218_1.duration_ = 6.93

		local var_218_0 = {
			ja = 6.933,
			CriLanguages = 4.3,
			zh = 4.3
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play418091054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.675

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:GetWordFromCfg(418091053)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 27 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 27)

				if (27 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 27)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091053", "story_v_side_old_418091.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091053", "story_v_side_old_418091.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_side_old_418091", "418091053", "story_v_side_old_418091.awb")

						arg_218_1:RecordAudio("418091053", var_221_6)
						arg_218_1:RecordAudio("418091053", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091053", "story_v_side_old_418091.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091053", "story_v_side_old_418091.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play418091054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 418091054
		arg_222_1.duration_ = 4.23

		local var_222_0 = {
			ja = 4.233,
			CriLanguages = 3.366,
			zh = 3.366
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play418091055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1071"]) and arg_222_1.var_.actorSpriteComps1071 == nil then
				arg_222_1.var_.actorSpriteComps1071 = arg_222_1.actors_["1071"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1071"]) then
				if arg_222_1.var_.actorSpriteComps1071 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 1, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1071"]) and arg_222_1.var_.actorSpriteComps1071 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps1071 = nil
			end

			local var_225_2 = arg_222_1.actors_["1060"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps1060 == nil then
				arg_222_1.var_.actorSpriteComps1060 = var_225_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_3 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.actorSpriteComps1060 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								iter_225_5.color = Color.New(Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_3), Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_3), (Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_3)))
							else
								local var_225_4 = Mathf.Lerp(iter_225_5.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_3)

								iter_225_5.color = Color.New(var_225_4, var_225_4, var_225_4)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps1060 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_225_7 then
						iter_225_7.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps1060 = nil
			end

			local var_225_5 = arg_222_1.actors_["1060"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1060 = var_225_5.localPosition
				var_225_5.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1060", 7)

				for iter_225_8 = 0, var_225_5.childCount - 1 do
					local var_225_6 = var_225_5:GetChild(iter_225_8)

					if var_225_6.name == "split_2" or not string.find(var_225_6.name, "split") then
						var_225_6.gameObject:SetActive(true)
					else
						var_225_6.gameObject:SetActive(false)
					end
				end
			end

			local var_225_7 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				var_225_5.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_222_1.time_ - 0) / var_225_7)
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				var_225_5.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_225_8 = arg_222_1.actors_["1071"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1071 = var_225_8.localPosition
				var_225_8.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1071", 3)

				for iter_225_9 = 0, var_225_8.childCount - 1 do
					local var_225_9 = var_225_8:GetChild(iter_225_9)

					if var_225_9.name == "" or not string.find(var_225_9.name, "split") then
						var_225_9.gameObject:SetActive(true)
					else
						var_225_9.gameObject:SetActive(false)
					end
				end
			end

			local var_225_10 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_10 then
				var_225_8.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1071, Vector3.New(13.6, -392.9, -306.6), (arg_222_1.time_ - 0) / var_225_10)
			end

			if arg_222_1.time_ >= 0 + var_225_10 and arg_222_1.time_ < 0 + var_225_10 + arg_225_0 then
				var_225_8.localPosition = Vector3.New(13.6, -392.9, -306.6)
			end

			local var_225_11 = 0
			local var_225_12 = 0.45

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_11 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_13 = arg_222_1:GetWordFromCfg(418091054)
				local var_225_14 = arg_222_1:FormatText(var_225_13.content)

				arg_222_1.text_.text = var_225_14

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_16 = 18 <= 0 and var_225_12 or var_225_12 * (utf8.len(var_225_14) / 18)

				if (18 <= 0 and var_225_12 or var_225_12 * (utf8.len(var_225_14) / 18)) > 0 and var_225_12 < var_225_16 then
					arg_222_1.talkMaxDuration = var_225_16

					if var_225_16 + var_225_11 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_16 + var_225_11
					end
				end

				arg_222_1.text_.text = var_225_14
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091054", "story_v_side_old_418091.awb") ~= 0 then
					local var_225_17 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091054", "story_v_side_old_418091.awb") / 1000

					if var_225_17 + var_225_11 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_17 + var_225_11
					end

					if var_225_13.prefab_name ~= "" and arg_222_1.actors_[var_225_13.prefab_name] ~= nil then
						local var_225_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_13.prefab_name].transform, "story_v_side_old_418091", "418091054", "story_v_side_old_418091.awb")

						arg_222_1:RecordAudio("418091054", var_225_18)
						arg_222_1:RecordAudio("418091054", var_225_18)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091054", "story_v_side_old_418091.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091054", "story_v_side_old_418091.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_19 = math.max(var_225_12, arg_222_1.talkMaxDuration)

			if var_225_11 <= arg_222_1.time_ and arg_222_1.time_ < var_225_11 + var_225_19 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_11) / var_225_19

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_11 + var_225_19 and arg_222_1.time_ < var_225_11 + var_225_19 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1071",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play418091055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 418091055
		arg_226_1.duration_ = 13.57

		local var_226_0 = {
			ja = 13.566,
			CriLanguages = 8.633,
			zh = 8.633
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play418091056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["10135"]) and arg_226_1.var_.actorSpriteComps10135 == nil then
				arg_226_1.var_.actorSpriteComps10135 = arg_226_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["10135"]) then
				if arg_226_1.var_.actorSpriteComps10135 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor1.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor1.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor1.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 1, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["10135"]) and arg_226_1.var_.actorSpriteComps10135 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_226_1.var_.actorSpriteComps10135 = nil
			end

			local var_229_2 = arg_226_1.actors_["1071"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps1071 == nil then
				arg_226_1.var_.actorSpriteComps1071 = var_229_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_3 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 and not isNil(var_229_2) then
				if arg_226_1.var_.actorSpriteComps1071 then
					for iter_229_4, iter_229_5 in pairs(arg_226_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_229_5 then
							if arg_226_1.isInRecall_ then
								iter_229_5.color = Color.New(Mathf.Lerp(iter_229_5.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_3), Mathf.Lerp(iter_229_5.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_3), (Mathf.Lerp(iter_229_5.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_3)))
							else
								local var_229_4 = Mathf.Lerp(iter_229_5.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_3)

								iter_229_5.color = Color.New(var_229_4, var_229_4, var_229_4)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.actorSpriteComps1071 then
				for iter_229_6, iter_229_7 in pairs(arg_226_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_229_7 then
						iter_229_7.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps1071 = nil
			end

			local var_229_5 = 0
			local var_229_6 = 1.1

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10135_split_1")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_7 = arg_226_1:GetWordFromCfg(418091055)
				local var_229_8 = arg_226_1:FormatText(var_229_7.content)

				arg_226_1.text_.text = var_229_8

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_10 = 44 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_8) / 44)

				if (44 <= 0 and var_229_6 or var_229_6 * (utf8.len(var_229_8) / 44)) > 0 and var_229_6 < var_229_10 then
					arg_226_1.talkMaxDuration = var_229_10

					if var_229_10 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_5
					end
				end

				arg_226_1.text_.text = var_229_8
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091055", "story_v_side_old_418091.awb") ~= 0 then
					local var_229_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091055", "story_v_side_old_418091.awb") / 1000

					if var_229_11 + var_229_5 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_5
					end

					if var_229_7.prefab_name ~= "" and arg_226_1.actors_[var_229_7.prefab_name] ~= nil then
						local var_229_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_7.prefab_name].transform, "story_v_side_old_418091", "418091055", "story_v_side_old_418091.awb")

						arg_226_1:RecordAudio("418091055", var_229_12)
						arg_226_1:RecordAudio("418091055", var_229_12)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091055", "story_v_side_old_418091.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091055", "story_v_side_old_418091.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_13 = math.max(var_229_6, arg_226_1.talkMaxDuration)

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_13 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_5) / var_229_13

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_5 + var_229_13 and arg_226_1.time_ < var_229_5 + var_229_13 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play418091056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 418091056
		arg_230_1.duration_ = 6.67

		local var_230_0 = {
			ja = 6.666,
			CriLanguages = 3.733,
			zh = 3.733
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play418091057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1071"]) and arg_230_1.var_.actorSpriteComps1071 == nil then
				arg_230_1.var_.actorSpriteComps1071 = arg_230_1.actors_["1071"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1071"]) then
				if arg_230_1.var_.actorSpriteComps1071 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 1, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1071"]) and arg_230_1.var_.actorSpriteComps1071 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps1071 = nil
			end

			local var_233_2 = arg_230_1.actors_["10135"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps10135 == nil then
				arg_230_1.var_.actorSpriteComps10135 = var_233_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_3 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.actorSpriteComps10135 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								iter_233_5.color = Color.New(Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_3), Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_3), (Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_3)))
							else
								local var_233_4 = Mathf.Lerp(iter_233_5.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_3)

								iter_233_5.color = Color.New(var_233_4, var_233_4, var_233_4)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps10135 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_233_7 then
						iter_233_7.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps10135 = nil
			end

			local var_233_5 = 0
			local var_233_6 = 0.475

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_7 = arg_230_1:GetWordFromCfg(418091056)
				local var_233_8 = arg_230_1:FormatText(var_233_7.content)

				arg_230_1.text_.text = var_233_8

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_10 = 19 <= 0 and var_233_6 or var_233_6 * (utf8.len(var_233_8) / 19)

				if (19 <= 0 and var_233_6 or var_233_6 * (utf8.len(var_233_8) / 19)) > 0 and var_233_6 < var_233_10 then
					arg_230_1.talkMaxDuration = var_233_10

					if var_233_10 + var_233_5 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_5
					end
				end

				arg_230_1.text_.text = var_233_8
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091056", "story_v_side_old_418091.awb") ~= 0 then
					local var_233_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091056", "story_v_side_old_418091.awb") / 1000

					if var_233_11 + var_233_5 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_5
					end

					if var_233_7.prefab_name ~= "" and arg_230_1.actors_[var_233_7.prefab_name] ~= nil then
						local var_233_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_7.prefab_name].transform, "story_v_side_old_418091", "418091056", "story_v_side_old_418091.awb")

						arg_230_1:RecordAudio("418091056", var_233_12)
						arg_230_1:RecordAudio("418091056", var_233_12)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091056", "story_v_side_old_418091.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091056", "story_v_side_old_418091.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_13 = math.max(var_233_6, arg_230_1.talkMaxDuration)

			if var_233_5 <= arg_230_1.time_ and arg_230_1.time_ < var_233_5 + var_233_13 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_5) / var_233_13

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_5 + var_233_13 and arg_230_1.time_ < var_233_5 + var_233_13 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play418091057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 418091057
		arg_234_1.duration_ = 5.23

		local var_234_0 = {
			ja = 5.233,
			CriLanguages = 3.5,
			zh = 3.5
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play418091058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1060"]) and arg_234_1.var_.actorSpriteComps1060 == nil then
				arg_234_1.var_.actorSpriteComps1060 = arg_234_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1060"]) then
				if arg_234_1.var_.actorSpriteComps1060 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								iter_237_1.color = Color.New(Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor1.r, (arg_234_1.time_ - 0) / var_237_0), Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor1.g, (arg_234_1.time_ - 0) / var_237_0), (Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor1.b, (arg_234_1.time_ - 0) / var_237_0)))
							else
								local var_237_1 = Mathf.Lerp(iter_237_1.color.r, 1, (arg_234_1.time_ - 0) / var_237_0)

								iter_237_1.color = Color.New(var_237_1, var_237_1, var_237_1)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1060"]) and arg_234_1.var_.actorSpriteComps1060 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps1060 = nil
			end

			local var_237_2 = arg_234_1.actors_["1071"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps1071 == nil then
				arg_234_1.var_.actorSpriteComps1071 = var_237_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_3 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 and not isNil(var_237_2) then
				if arg_234_1.var_.actorSpriteComps1071 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps1071:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								iter_237_5.color = Color.New(Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor2.r, (arg_234_1.time_ - 0) / var_237_3), Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor2.g, (arg_234_1.time_ - 0) / var_237_3), (Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor2.b, (arg_234_1.time_ - 0) / var_237_3)))
							else
								local var_237_4 = Mathf.Lerp(iter_237_5.color.r, 0.5, (arg_234_1.time_ - 0) / var_237_3)

								iter_237_5.color = Color.New(var_237_4, var_237_4, var_237_4)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps1071 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps1071:ToTable()) do
					if iter_237_7 then
						iter_237_7.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps1071 = nil
			end

			local var_237_5 = arg_234_1.actors_["1071"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1071 = var_237_5.localPosition
				var_237_5.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1071", 7)

				for iter_237_8 = 0, var_237_5.childCount - 1 do
					local var_237_6 = var_237_5:GetChild(iter_237_8)

					if var_237_6.name == "" or not string.find(var_237_6.name, "split") then
						var_237_6.gameObject:SetActive(true)
					else
						var_237_6.gameObject:SetActive(false)
					end
				end
			end

			local var_237_7 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 then
				var_237_5.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1071, Vector3.New(0, -2000, 7.24), (arg_234_1.time_ - 0) / var_237_7)
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 then
				var_237_5.localPosition = Vector3.New(0, -2000, 7.24)
			end

			local var_237_8 = arg_234_1.actors_["1060"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1060 = var_237_8.localPosition
				var_237_8.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1060", 3)

				for iter_237_9 = 0, var_237_8.childCount - 1 do
					local var_237_9 = var_237_8:GetChild(iter_237_9)

					if var_237_9.name == "split_1" or not string.find(var_237_9.name, "split") then
						var_237_9.gameObject:SetActive(true)
					else
						var_237_9.gameObject:SetActive(false)
					end
				end
			end

			local var_237_10 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_10 then
				var_237_8.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_234_1.time_ - 0) / var_237_10)
			end

			if arg_234_1.time_ >= 0 + var_237_10 and arg_234_1.time_ < 0 + var_237_10 + arg_237_0 then
				var_237_8.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_237_11 = 0
			local var_237_12 = 0.4

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_11 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_13 = arg_234_1:GetWordFromCfg(418091057)
				local var_237_14 = arg_234_1:FormatText(var_237_13.content)

				arg_234_1.text_.text = var_237_14

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_16 = 16 <= 0 and var_237_12 or var_237_12 * (utf8.len(var_237_14) / 16)

				if (16 <= 0 and var_237_12 or var_237_12 * (utf8.len(var_237_14) / 16)) > 0 and var_237_12 < var_237_16 then
					arg_234_1.talkMaxDuration = var_237_16

					if var_237_16 + var_237_11 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_16 + var_237_11
					end
				end

				arg_234_1.text_.text = var_237_14
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091057", "story_v_side_old_418091.awb") ~= 0 then
					local var_237_17 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091057", "story_v_side_old_418091.awb") / 1000

					if var_237_17 + var_237_11 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_17 + var_237_11
					end

					if var_237_13.prefab_name ~= "" and arg_234_1.actors_[var_237_13.prefab_name] ~= nil then
						local var_237_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_13.prefab_name].transform, "story_v_side_old_418091", "418091057", "story_v_side_old_418091.awb")

						arg_234_1:RecordAudio("418091057", var_237_18)
						arg_234_1:RecordAudio("418091057", var_237_18)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091057", "story_v_side_old_418091.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091057", "story_v_side_old_418091.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_19 = math.max(var_237_12, arg_234_1.talkMaxDuration)

			if var_237_11 <= arg_234_1.time_ and arg_234_1.time_ < var_237_11 + var_237_19 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_11) / var_237_19

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_11 + var_237_19 and arg_234_1.time_ < var_237_11 + var_237_19 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play418091058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 418091058
		arg_238_1.duration_ = 4.57

		local var_238_0 = {
			ja = 4.566,
			CriLanguages = 3.5,
			zh = 3.5
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play418091059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10135"]) and arg_238_1.var_.actorSpriteComps10135 == nil then
				arg_238_1.var_.actorSpriteComps10135 = arg_238_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10135"]) then
				if arg_238_1.var_.actorSpriteComps10135 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								iter_241_1.color = Color.New(Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor1.r, (arg_238_1.time_ - 0) / var_241_0), Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor1.g, (arg_238_1.time_ - 0) / var_241_0), (Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor1.b, (arg_238_1.time_ - 0) / var_241_0)))
							else
								local var_241_1 = Mathf.Lerp(iter_241_1.color.r, 1, (arg_238_1.time_ - 0) / var_241_0)

								iter_241_1.color = Color.New(var_241_1, var_241_1, var_241_1)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10135"]) and arg_238_1.var_.actorSpriteComps10135 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps10135 = nil
			end

			local var_241_2 = arg_238_1.actors_["1060"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1060 == nil then
				arg_238_1.var_.actorSpriteComps1060 = var_241_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_3 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_3 and not isNil(var_241_2) then
				if arg_238_1.var_.actorSpriteComps1060 then
					for iter_241_4, iter_241_5 in pairs(arg_238_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_241_5 then
							if arg_238_1.isInRecall_ then
								iter_241_5.color = Color.New(Mathf.Lerp(iter_241_5.color.r, arg_238_1.hightColor2.r, (arg_238_1.time_ - 0) / var_241_3), Mathf.Lerp(iter_241_5.color.g, arg_238_1.hightColor2.g, (arg_238_1.time_ - 0) / var_241_3), (Mathf.Lerp(iter_241_5.color.b, arg_238_1.hightColor2.b, (arg_238_1.time_ - 0) / var_241_3)))
							else
								local var_241_4 = Mathf.Lerp(iter_241_5.color.r, 0.5, (arg_238_1.time_ - 0) / var_241_3)

								iter_241_5.color = Color.New(var_241_4, var_241_4, var_241_4)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_3 and arg_238_1.time_ < 0 + var_241_3 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1060 then
				for iter_241_6, iter_241_7 in pairs(arg_238_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_241_7 then
						iter_241_7.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_238_1.var_.actorSpriteComps1060 = nil
			end

			local var_241_5 = 0
			local var_241_6 = 0.175

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10135_split_1")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_7 = arg_238_1:GetWordFromCfg(418091058)
				local var_241_8 = arg_238_1:FormatText(var_241_7.content)

				arg_238_1.text_.text = var_241_8

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_10 = 7 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_8) / 7)

				if (7 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_8) / 7)) > 0 and var_241_6 < var_241_10 then
					arg_238_1.talkMaxDuration = var_241_10

					if var_241_10 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_5
					end
				end

				arg_238_1.text_.text = var_241_8
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091058", "story_v_side_old_418091.awb") ~= 0 then
					local var_241_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091058", "story_v_side_old_418091.awb") / 1000

					if var_241_11 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_11 + var_241_5
					end

					if var_241_7.prefab_name ~= "" and arg_238_1.actors_[var_241_7.prefab_name] ~= nil then
						local var_241_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_7.prefab_name].transform, "story_v_side_old_418091", "418091058", "story_v_side_old_418091.awb")

						arg_238_1:RecordAudio("418091058", var_241_12)
						arg_238_1:RecordAudio("418091058", var_241_12)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091058", "story_v_side_old_418091.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091058", "story_v_side_old_418091.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_13 = math.max(var_241_6, arg_238_1.talkMaxDuration)

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_13 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_5) / var_241_13

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_5 + var_241_13 and arg_238_1.time_ < var_241_5 + var_241_13 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play418091059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 418091059
		arg_242_1.duration_ = 3.57

		local var_242_0 = {
			ja = 3.566,
			CriLanguages = 3,
			zh = 3
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play418091060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["107301"]) and arg_242_1.var_.actorSpriteComps107301 == nil then
				arg_242_1.var_.actorSpriteComps107301 = arg_242_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_0 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["107301"]) then
				if arg_242_1.var_.actorSpriteComps107301 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								iter_245_1.color = Color.New(Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor1.r, (arg_242_1.time_ - 0) / var_245_0), Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor1.g, (arg_242_1.time_ - 0) / var_245_0), (Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor1.b, (arg_242_1.time_ - 0) / var_245_0)))
							else
								local var_245_1 = Mathf.Lerp(iter_245_1.color.r, 1, (arg_242_1.time_ - 0) / var_245_0)

								iter_245_1.color = Color.New(var_245_1, var_245_1, var_245_1)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["107301"]) and arg_242_1.var_.actorSpriteComps107301 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_245_3 then
						iter_245_3.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_242_1.var_.actorSpriteComps107301 = nil
			end

			local var_245_2 = arg_242_1.actors_["10135"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps10135 == nil then
				arg_242_1.var_.actorSpriteComps10135 = var_245_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_3 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 and not isNil(var_245_2) then
				if arg_242_1.var_.actorSpriteComps10135 then
					for iter_245_4, iter_245_5 in pairs(arg_242_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_245_5 then
							if arg_242_1.isInRecall_ then
								iter_245_5.color = Color.New(Mathf.Lerp(iter_245_5.color.r, arg_242_1.hightColor2.r, (arg_242_1.time_ - 0) / var_245_3), Mathf.Lerp(iter_245_5.color.g, arg_242_1.hightColor2.g, (arg_242_1.time_ - 0) / var_245_3), (Mathf.Lerp(iter_245_5.color.b, arg_242_1.hightColor2.b, (arg_242_1.time_ - 0) / var_245_3)))
							else
								local var_245_4 = Mathf.Lerp(iter_245_5.color.r, 0.5, (arg_242_1.time_ - 0) / var_245_3)

								iter_245_5.color = Color.New(var_245_4, var_245_4, var_245_4)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps10135 then
				for iter_245_6, iter_245_7 in pairs(arg_242_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_245_7 then
						iter_245_7.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_242_1.var_.actorSpriteComps10135 = nil
			end

			local var_245_5 = 0
			local var_245_6 = 0.375

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_107301_split_3")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_7 = arg_242_1:GetWordFromCfg(418091059)
				local var_245_8 = arg_242_1:FormatText(var_245_7.content)

				arg_242_1.text_.text = var_245_8

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_10 = 15 <= 0 and var_245_6 or var_245_6 * (utf8.len(var_245_8) / 15)

				if (15 <= 0 and var_245_6 or var_245_6 * (utf8.len(var_245_8) / 15)) > 0 and var_245_6 < var_245_10 then
					arg_242_1.talkMaxDuration = var_245_10

					if var_245_10 + var_245_5 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_5
					end
				end

				arg_242_1.text_.text = var_245_8
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091059", "story_v_side_old_418091.awb") ~= 0 then
					local var_245_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091059", "story_v_side_old_418091.awb") / 1000

					if var_245_11 + var_245_5 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_11 + var_245_5
					end

					if var_245_7.prefab_name ~= "" and arg_242_1.actors_[var_245_7.prefab_name] ~= nil then
						local var_245_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_7.prefab_name].transform, "story_v_side_old_418091", "418091059", "story_v_side_old_418091.awb")

						arg_242_1:RecordAudio("418091059", var_245_12)
						arg_242_1:RecordAudio("418091059", var_245_12)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091059", "story_v_side_old_418091.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091059", "story_v_side_old_418091.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_13 = math.max(var_245_6, arg_242_1.talkMaxDuration)

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_13 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_5) / var_245_13

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_5 + var_245_13 and arg_242_1.time_ < var_245_5 + var_245_13 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play418091060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 418091060
		arg_246_1.duration_ = 1.5

		local var_246_0 = {
			ja = 1.5,
			CriLanguages = 0.999999999999,
			zh = 0.999999999999
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play418091061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1060"]) and arg_246_1.var_.actorSpriteComps1060 == nil then
				arg_246_1.var_.actorSpriteComps1060 = arg_246_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1060"]) then
				if arg_246_1.var_.actorSpriteComps1060 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								iter_249_1.color = Color.New(Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor1.r, (arg_246_1.time_ - 0) / var_249_0), Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor1.g, (arg_246_1.time_ - 0) / var_249_0), (Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor1.b, (arg_246_1.time_ - 0) / var_249_0)))
							else
								local var_249_1 = Mathf.Lerp(iter_249_1.color.r, 1, (arg_246_1.time_ - 0) / var_249_0)

								iter_249_1.color = Color.New(var_249_1, var_249_1, var_249_1)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1060"]) and arg_246_1.var_.actorSpriteComps1060 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_249_3 then
						iter_249_3.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_246_1.var_.actorSpriteComps1060 = nil
			end

			local var_249_2 = arg_246_1.actors_["107301"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps107301 == nil then
				arg_246_1.var_.actorSpriteComps107301 = var_249_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_3 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_3 and not isNil(var_249_2) then
				if arg_246_1.var_.actorSpriteComps107301 then
					for iter_249_4, iter_249_5 in pairs(arg_246_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_249_5 then
							if arg_246_1.isInRecall_ then
								iter_249_5.color = Color.New(Mathf.Lerp(iter_249_5.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_3), Mathf.Lerp(iter_249_5.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_3), (Mathf.Lerp(iter_249_5.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_3)))
							else
								local var_249_4 = Mathf.Lerp(iter_249_5.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_3)

								iter_249_5.color = Color.New(var_249_4, var_249_4, var_249_4)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_3 and arg_246_1.time_ < 0 + var_249_3 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps107301 then
				for iter_249_6, iter_249_7 in pairs(arg_246_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_249_7 then
						iter_249_7.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps107301 = nil
			end

			local var_249_5 = arg_246_1.actors_["1060"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1060 = var_249_5.localPosition
				var_249_5.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("1060", 3)

				for iter_249_8 = 0, var_249_5.childCount - 1 do
					local var_249_6 = var_249_5:GetChild(iter_249_8)

					if var_249_6.name == "split_4" or not string.find(var_249_6.name, "split") then
						var_249_6.gameObject:SetActive(true)
					else
						var_249_6.gameObject:SetActive(false)
					end
				end
			end

			local var_249_7 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				var_249_5.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_246_1.time_ - 0) / var_249_7)
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				var_249_5.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_249_8 = 0
			local var_249_9 = 0.05

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_10 = arg_246_1:GetWordFromCfg(418091060)
				local var_249_11 = arg_246_1:FormatText(var_249_10.content)

				arg_246_1.text_.text = var_249_11

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_13 = 2 <= 0 and var_249_9 or var_249_9 * (utf8.len(var_249_11) / 2)

				if (2 <= 0 and var_249_9 or var_249_9 * (utf8.len(var_249_11) / 2)) > 0 and var_249_9 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_8
					end
				end

				arg_246_1.text_.text = var_249_11
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091060", "story_v_side_old_418091.awb") ~= 0 then
					local var_249_14 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091060", "story_v_side_old_418091.awb") / 1000

					if var_249_14 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_8
					end

					if var_249_10.prefab_name ~= "" and arg_246_1.actors_[var_249_10.prefab_name] ~= nil then
						local var_249_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_10.prefab_name].transform, "story_v_side_old_418091", "418091060", "story_v_side_old_418091.awb")

						arg_246_1:RecordAudio("418091060", var_249_15)
						arg_246_1:RecordAudio("418091060", var_249_15)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091060", "story_v_side_old_418091.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091060", "story_v_side_old_418091.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_9, arg_246_1.talkMaxDuration)

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_8) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_8 + var_249_16 and arg_246_1.time_ < var_249_8 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play418091061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 418091061
		arg_250_1.duration_ = 2.4

		local var_250_0 = {
			ja = 2.4,
			CriLanguages = 1.7,
			zh = 1.7
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
			arg_250_1.auto_ = false
		end

		function arg_250_1.playNext_(arg_252_0)
			arg_250_1.onStoryFinished_()
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["107301"]) and arg_250_1.var_.actorSpriteComps107301 == nil then
				arg_250_1.var_.actorSpriteComps107301 = arg_250_1.actors_["107301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["107301"]) then
				if arg_250_1.var_.actorSpriteComps107301 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps107301:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								iter_253_1.color = Color.New(Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, (arg_250_1.time_ - 0) / var_253_0), Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, (arg_250_1.time_ - 0) / var_253_0), (Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, (arg_250_1.time_ - 0) / var_253_0)))
							else
								local var_253_1 = Mathf.Lerp(iter_253_1.color.r, 1, (arg_250_1.time_ - 0) / var_253_0)

								iter_253_1.color = Color.New(var_253_1, var_253_1, var_253_1)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["107301"]) and arg_250_1.var_.actorSpriteComps107301 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps107301:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_250_1.var_.actorSpriteComps107301 = nil
			end

			local var_253_2 = arg_250_1.actors_["1060"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.actorSpriteComps1060 == nil then
				arg_250_1.var_.actorSpriteComps1060 = var_253_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_3 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_3 and not isNil(var_253_2) then
				if arg_250_1.var_.actorSpriteComps1060 then
					for iter_253_4, iter_253_5 in pairs(arg_250_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_253_5 then
							if arg_250_1.isInRecall_ then
								iter_253_5.color = Color.New(Mathf.Lerp(iter_253_5.color.r, arg_250_1.hightColor2.r, (arg_250_1.time_ - 0) / var_253_3), Mathf.Lerp(iter_253_5.color.g, arg_250_1.hightColor2.g, (arg_250_1.time_ - 0) / var_253_3), (Mathf.Lerp(iter_253_5.color.b, arg_250_1.hightColor2.b, (arg_250_1.time_ - 0) / var_253_3)))
							else
								local var_253_4 = Mathf.Lerp(iter_253_5.color.r, 0.5, (arg_250_1.time_ - 0) / var_253_3)

								iter_253_5.color = Color.New(var_253_4, var_253_4, var_253_4)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_3 and arg_250_1.time_ < 0 + var_253_3 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.actorSpriteComps1060 then
				for iter_253_6, iter_253_7 in pairs(arg_250_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_253_7 then
						iter_253_7.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_250_1.var_.actorSpriteComps1060 = nil
			end

			local var_253_5 = 0
			local var_253_6 = 0.2

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_107301_split_1")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_7 = arg_250_1:GetWordFromCfg(418091061)
				local var_253_8 = arg_250_1:FormatText(var_253_7.content)

				arg_250_1.text_.text = var_253_8

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 8 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 8)

				if (8 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 8)) > 0 and var_253_6 < var_253_10 then
					arg_250_1.talkMaxDuration = var_253_10

					if var_253_10 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_8
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418091", "418091061", "story_v_side_old_418091.awb") ~= 0 then
					local var_253_11 = manager.audio:GetVoiceLength("story_v_side_old_418091", "418091061", "story_v_side_old_418091.awb") / 1000

					if var_253_11 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_11 + var_253_5
					end

					if var_253_7.prefab_name ~= "" and arg_250_1.actors_[var_253_7.prefab_name] ~= nil then
						local var_253_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_7.prefab_name].transform, "story_v_side_old_418091", "418091061", "story_v_side_old_418091.awb")

						arg_250_1:RecordAudio("418091061", var_253_12)
						arg_250_1:RecordAudio("418091061", var_253_12)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_old_418091", "418091061", "story_v_side_old_418091.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_old_418091", "418091061", "story_v_side_old_418091.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_13 and arg_250_1.time_ < var_253_5 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST1002a"
	},
	voices = {
		"story_v_side_old_418091.awb"
	}
}
