return {
	Play116391001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116391001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116391002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST18_blur == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST18_blur")
				var_4_0.name = "ST18_blur"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST18_blur = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST18_blur

				arg_1_1.bgs_.ST18_blur.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST18_blur" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "ST18_blur"

			if arg_1_1.bgs_.ST18_blur == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.blurPaintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			local var_4_10 = 0
			local var_4_11 = arg_1_1.bgs_[var_4_8]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				var_4_11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end
			end

			local var_4_14 = 2

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_14 then
				local var_4_15 = Color.New(1, 1, 1)

				var_4_15.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_10) / var_4_14)

				var_4_11:GetComponent("SpriteRenderer").material:SetColor("_Color", var_4_15)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.866666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.866666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			local var_4_22 = 2
			local var_4_23 = 1.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116391001).content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 51 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 51)

				if (51 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 51)) > 0 and var_4_23 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_22 = var_4_22 + 0.3

					if var_4_27 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_22 + 0.3
			local var_4_29 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116391002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116391002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116391003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(116391002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 26)

				if (26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 26)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play116391003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116391003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116391004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(116391003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 24 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 24)

				if (24 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 24)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play116391004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116391004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play116391005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.975

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(116391004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 39 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 39)

				if (39 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 39)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play116391005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116391005
		arg_21_1.duration_ = 11.57

		local var_21_0 = {
			zh = 11.566,
			ja = 7.666
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play116391006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.bgs_.I05a == nil then
				local var_24_0 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05a")
				var_24_0.name = "I05a"
				var_24_0.transform.parent = arg_21_1.stage_.transform
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_.I05a = var_24_0
			end

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= 2 + arg_24_0 then
				local var_24_1 = arg_21_1.bgs_.I05a

				arg_21_1.bgs_.I05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_2 = var_24_1:GetComponent("SpriteRenderer")

				if var_24_2 and var_24_2.sprite then
					local var_24_3 = 2 * (var_24_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_1.transform.localScale = Vector3.New(var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "I05a" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_4 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_5 = 2

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_5 then
				local var_24_6 = Color.New(0, 0, 0)

				var_24_6.a = Mathf.Lerp(0, 1, (arg_21_1.time_ - var_24_4) / var_24_5)
				arg_21_1.mask_.color = var_24_6
			end

			if arg_21_1.time_ >= var_24_4 + var_24_5 and arg_21_1.time_ < var_24_4 + var_24_5 + arg_24_0 then
				local var_24_7 = Color.New(0, 0, 0)

				var_24_7.a = 1
				arg_21_1.mask_.color = var_24_7
			end

			local var_24_8 = 2

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_9 = 2

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 then
				local var_24_10 = Color.New(0, 0, 0)

				var_24_10.a = Mathf.Lerp(1, 0, (arg_21_1.time_ - var_24_8) / var_24_9)
				arg_21_1.mask_.color = var_24_10
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 then
				local var_24_11 = Color.New(0, 0, 0)

				arg_21_1.mask_.enabled = false
				var_24_11.a = 0
				arg_21_1.mask_.color = var_24_11
			end

			local var_24_12 = "10025ui_story"

			if arg_21_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_24_13 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_21_1.stage_.transform)

				var_24_13.name = var_24_12
				var_24_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_[var_24_12] = var_24_13

				local var_24_14 = var_24_13:GetComponentInChildren(typeof(CharacterEffect))

				var_24_14.enabled = true

				local var_24_15 = GameObjectTools.GetOrAddComponent(var_24_13, typeof(DynamicBoneHelper))

				if var_24_15 then
					var_24_15:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_14.transform, false)

				arg_21_1.var_[var_24_12 .. "Animator"] = var_24_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_[var_24_12 .. "Animator"].applyRootMotion = true
				arg_21_1.var_[var_24_12 .. "LipSync"] = var_24_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_16 = arg_21_1.actors_["10025ui_story"].transform

			if 4 < arg_21_1.time_ and arg_21_1.time_ <= 4 + arg_24_0 then
				arg_21_1.var_.moveOldPos10025ui_story = var_24_16.localPosition
			end

			local var_24_17 = 0.001

			if 4 <= arg_21_1.time_ and arg_21_1.time_ < 4 + var_24_17 then
				var_24_16.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_21_1.time_ - 4) / var_24_17)
				var_24_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_16.position).x, (manager.ui.mainCamera.transform.position - var_24_16.position).y, (manager.ui.mainCamera.transform.position - var_24_16.position).z)
				var_24_16.localEulerAngles.z = 0
				var_24_16.localEulerAngles.x = 0
				var_24_16.localEulerAngles = var_24_16.localEulerAngles
			end

			if arg_21_1.time_ >= 4 + var_24_17 and arg_21_1.time_ < 4 + var_24_17 + arg_24_0 then
				var_24_16.localPosition = Vector3.New(0, -1.1, -5.9)
				var_24_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_16.position).x, (manager.ui.mainCamera.transform.position - var_24_16.position).y, (manager.ui.mainCamera.transform.position - var_24_16.position).z)
				var_24_16.localEulerAngles.z = 0
				var_24_16.localEulerAngles.x = 0
				var_24_16.localEulerAngles = var_24_16.localEulerAngles
			end

			if 4 < arg_21_1.time_ and arg_21_1.time_ <= 4 + arg_24_0 then
				arg_21_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action9_2")
			end

			if 4 < arg_21_1.time_ and arg_21_1.time_ <= 4 + arg_24_0 then
				arg_21_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_18 = 4
			local var_24_19 = 0.3

			if 4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_20 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_20:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_21 = arg_21_1:GetWordFromCfg(116391005)
				local var_24_22 = arg_21_1:FormatText(var_24_21.content)

				arg_21_1.text_.text = var_24_22

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_24 = 12 <= 0 and var_24_19 or var_24_19 * (utf8.len(var_24_22) / 12)

				if (12 <= 0 and var_24_19 or var_24_19 * (utf8.len(var_24_22) / 12)) > 0 and var_24_19 < var_24_24 then
					arg_21_1.talkMaxDuration = var_24_24
					var_24_18 = var_24_18 + 0.3

					if var_24_24 + var_24_18 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_18
					end
				end

				arg_21_1.text_.text = var_24_22
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391005", "story_v_out_116391.awb") ~= 0 then
					local var_24_25 = manager.audio:GetVoiceLength("story_v_out_116391", "116391005", "story_v_out_116391.awb") / 1000

					if var_24_25 + var_24_18 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_25 + var_24_18
					end

					if var_24_21.prefab_name ~= "" and arg_21_1.actors_[var_24_21.prefab_name] ~= nil then
						local var_24_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_21.prefab_name].transform, "story_v_out_116391", "116391005", "story_v_out_116391.awb")

						arg_21_1:RecordAudio("116391005", var_24_26)
						arg_21_1:RecordAudio("116391005", var_24_26)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116391", "116391005", "story_v_out_116391.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116391", "116391005", "story_v_out_116391.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_27 = var_24_18 + 0.3
			local var_24_28 = math.max(var_24_19, arg_21_1.talkMaxDuration)

			if var_24_18 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_27 + var_24_28 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_27) / var_24_28

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_27 + var_24_28 and arg_21_1.time_ < var_24_27 + var_24_28 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play116391006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 116391006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play116391007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos10025ui_story = arg_27_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["10025ui_story"].transform.position).z)
				arg_27_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["10025ui_story"].transform.localEulerAngles = arg_27_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["10025ui_story"].transform.position).z)
				arg_27_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["10025ui_story"].transform.localEulerAngles = arg_27_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_30_1 = 0
			local var_30_2 = 0.95

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(116391006).content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 38 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 38)

				if (38 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 38)) > 0 and var_30_2 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_1
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_6 = math.max(var_30_2, arg_27_1.talkMaxDuration)

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_6 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_1) / var_30_6

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_1 + var_30_6 and arg_27_1.time_ < var_30_1 + var_30_6 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play116391007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 116391007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play116391008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 1.175

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(116391007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 47 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 47)

				if (47 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 47)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play116391008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 116391008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play116391009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.675

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(116391008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 27 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 27)

				if (27 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 27)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play116391009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 116391009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play116391010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.25

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(116391009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 50 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 50)

				if (50 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 50)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play116391010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116391010
		arg_43_1.duration_ = 4.4

		local var_43_0 = {
			zh = 4.4,
			ja = 3.5
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
				arg_43_0:Play116391011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10025ui_story = arg_43_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10025ui_story"].transform.position).z)
				arg_43_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10025ui_story"].transform.localEulerAngles = arg_43_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_43_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["10025ui_story"].transform.position).z)
				arg_43_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["10025ui_story"].transform.localEulerAngles = arg_43_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_46_1 = arg_43_1.actors_["10025ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect10025ui_story == nil then
				arg_43_1.var_.characterEffect10025ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect10025ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect10025ui_story then
				arg_43_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_46_4 = 0
			local var_46_5 = 0.2

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(116391010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 8 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 8)

				if (8 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 8)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391010", "story_v_out_116391.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_116391", "116391010", "story_v_out_116391.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_116391", "116391010", "story_v_out_116391.awb")

						arg_43_1:RecordAudio("116391010", var_46_11)
						arg_43_1:RecordAudio("116391010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116391", "116391010", "story_v_out_116391.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116391", "116391010", "story_v_out_116391.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play116391011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116391011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play116391012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10025ui_story = arg_47_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10025ui_story"].transform.position).z)
				arg_47_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10025ui_story"].transform.localEulerAngles = arg_47_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10025ui_story"].transform.position).z)
				arg_47_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10025ui_story"].transform.localEulerAngles = arg_47_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_50_1 = 0
			local var_50_2 = 1.125

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(116391011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 45 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 45)

				if (45 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 45)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play116391012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116391012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play116391013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0.749999999999 < arg_51_1.time_ and arg_51_1.time_ <= 0.749999999999 + arg_54_0 then
				arg_51_1:AudioAction("play", "effect", "se_story_9", "se_story_9_tearing", "")
			end

			local var_54_1 = 0
			local var_54_2 = 1.25

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(116391012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 50 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 50)

				if (50 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 50)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play116391013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 116391013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play116391014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_16", "se_story_16_droplet_loop", "")
			end

			local var_58_1 = 0
			local var_58_2 = 0.85

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(116391013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 34 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 34)

				if (34 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 34)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play116391014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116391014
		arg_59_1.duration_ = 5.03

		local var_59_0 = {
			zh = 3.466,
			ja = 5.033
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
				arg_59_0:Play116391015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:AudioAction("stop", "music", "se_story_16", "se_story_16_droplet_loop", "")

				local var_62_2 = manager.audio:GetAudioName("se_story_16", "se_story_16_droplet_loop")

				if "" ~= "" then
					if arg_59_1.bgmTxt_.text ~= var_62_2 and arg_59_1.bgmTxt_.text ~= "" then
						if arg_59_1.bgmTxt2_.text ~= "" then
							arg_59_1.bgmTxt_.text = arg_59_1.bgmTxt2_.text
						end

						arg_59_1.bgmTxt2_.text = var_62_2

						arg_59_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_59_1.bgmTxt_.text = var_62_2
						arg_59_1.bgmTxt2_.text = var_62_2
					end

					if arg_59_1.bgmTimer then
						arg_59_1.bgmTimer:Stop()

						arg_59_1.bgmTimer = nil
					end

					if arg_59_1.settingData.show_music_name == 1 then
						arg_59_1.musicController:SetSelectedState("show")
						arg_59_1.musicAnimator_:Play("open", 0, 0)

						if arg_59_1.settingData.music_time ~= 0 then
							arg_59_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_59_1.settingData.music_time), function()
								if arg_59_1 == nil or isNil(arg_59_1.bgmTxt_) then
									return
								end

								arg_59_1.musicController:SetSelectedState("hide")
								arg_59_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_62_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_59_1.bgmTxt_.text ~= var_62_5 and arg_59_1.bgmTxt_.text ~= "" then
						if arg_59_1.bgmTxt2_.text ~= "" then
							arg_59_1.bgmTxt_.text = arg_59_1.bgmTxt2_.text
						end

						arg_59_1.bgmTxt2_.text = var_62_5

						arg_59_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_59_1.bgmTxt_.text = var_62_5
						arg_59_1.bgmTxt2_.text = var_62_5
					end

					if arg_59_1.bgmTimer then
						arg_59_1.bgmTimer:Stop()

						arg_59_1.bgmTimer = nil
					end

					if arg_59_1.settingData.show_music_name == 1 then
						arg_59_1.musicController:SetSelectedState("show")
						arg_59_1.musicAnimator_:Play("open", 0, 0)

						if arg_59_1.settingData.music_time ~= 0 then
							arg_59_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_59_1.settingData.music_time), function()
								if arg_59_1 == nil or isNil(arg_59_1.bgmTxt_) then
									return
								end

								arg_59_1.musicController:SetSelectedState("hide")
								arg_59_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_59_1.time_ and arg_59_1.time_ <= 0.4 + arg_62_0 then
				arg_59_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_62_8 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_59_1.bgmTxt_.text ~= var_62_8 and arg_59_1.bgmTxt_.text ~= "" then
						if arg_59_1.bgmTxt2_.text ~= "" then
							arg_59_1.bgmTxt_.text = arg_59_1.bgmTxt2_.text
						end

						arg_59_1.bgmTxt2_.text = var_62_8

						arg_59_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_59_1.bgmTxt_.text = var_62_8
						arg_59_1.bgmTxt2_.text = var_62_8
					end

					if arg_59_1.bgmTimer then
						arg_59_1.bgmTimer:Stop()

						arg_59_1.bgmTimer = nil
					end

					if arg_59_1.settingData.show_music_name == 1 then
						arg_59_1.musicController:SetSelectedState("show")
						arg_59_1.musicAnimator_:Play("open", 0, 0)

						if arg_59_1.settingData.music_time ~= 0 then
							arg_59_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_59_1.settingData.music_time), function()
								if arg_59_1 == nil or isNil(arg_59_1.bgmTxt_) then
									return
								end

								arg_59_1.musicController:SetSelectedState("hide")
								arg_59_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_62_9 = 0
			local var_62_10 = 0.3

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_9 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_11 = arg_59_1:GetWordFromCfg(116391014)
				local var_62_12 = arg_59_1:FormatText(var_62_11.content)

				arg_59_1.text_.text = var_62_12

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_14 = 12 <= 0 and var_62_10 or var_62_10 * (utf8.len(var_62_12) / 12)

				if (12 <= 0 and var_62_10 or var_62_10 * (utf8.len(var_62_12) / 12)) > 0 and var_62_10 < var_62_14 then
					arg_59_1.talkMaxDuration = var_62_14

					if var_62_14 + var_62_9 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_9
					end
				end

				arg_59_1.text_.text = var_62_12
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391014", "story_v_out_116391.awb") ~= 0 then
					local var_62_15 = manager.audio:GetVoiceLength("story_v_out_116391", "116391014", "story_v_out_116391.awb") / 1000

					if var_62_15 + var_62_9 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_15 + var_62_9
					end

					if var_62_11.prefab_name ~= "" and arg_59_1.actors_[var_62_11.prefab_name] ~= nil then
						local var_62_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_11.prefab_name].transform, "story_v_out_116391", "116391014", "story_v_out_116391.awb")

						arg_59_1:RecordAudio("116391014", var_62_16)
						arg_59_1:RecordAudio("116391014", var_62_16)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116391", "116391014", "story_v_out_116391.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116391", "116391014", "story_v_out_116391.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_17 = math.max(var_62_10, arg_59_1.talkMaxDuration)

			if var_62_9 <= arg_59_1.time_ and arg_59_1.time_ < var_62_9 + var_62_17 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_9) / var_62_17

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_9 + var_62_17 and arg_59_1.time_ < var_62_9 + var_62_17 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play116391015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116391015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play116391016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 1.075

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(116391015).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 43 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 43)

				if (43 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 43)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play116391016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116391016
		arg_70_1.duration_ = 11.3

		local var_70_0 = {
			zh = 11.3,
			ja = 8.466
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116391017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.actors_["10024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10024ui_story"))) then
				local var_73_0 = Object.Instantiate(Asset.Load("Char/" .. "10024ui_story"), arg_70_1.stage_.transform)

				var_73_0.name = "10024ui_story"
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["10024ui_story"] = var_73_0

				local var_73_1 = var_73_0:GetComponentInChildren(typeof(CharacterEffect))

				var_73_1.enabled = true

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end

				arg_70_1:ShowWeapon(var_73_1.transform, false)

				arg_70_1.var_["10024ui_story" .. "Animator"] = var_73_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_70_1.var_["10024ui_story" .. "Animator"].applyRootMotion = true
				arg_70_1.var_["10024ui_story" .. "LipSync"] = var_73_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action4_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_73_3 = arg_70_1.actors_["10024ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect10024ui_story == nil then
				arg_70_1.var_.characterEffect10024ui_story = var_73_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_4 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 and not isNil(var_73_3) then
				if arg_70_1.var_.characterEffect10024ui_story and not isNil(var_73_3) then
					arg_70_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect10024ui_story then
				arg_70_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_73_6 = arg_70_1.actors_["10025ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_6) and arg_70_1.var_.characterEffect10025ui_story == nil then
				arg_70_1.var_.characterEffect10025ui_story = var_73_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.034

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 and not isNil(var_73_6) then
				if arg_70_1.var_.characterEffect10025ui_story and not isNil(var_73_6) then
					arg_70_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_7)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 and not isNil(var_73_6) and arg_70_1.var_.characterEffect10025ui_story then
				arg_70_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_73_8 = arg_70_1.actors_["10024ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos10024ui_story = var_73_8.localPosition
			end

			local var_73_9 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_9 then
				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_70_1.time_ - 0) / var_73_9)
				var_73_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_8.position).x, (manager.ui.mainCamera.transform.position - var_73_8.position).y, (manager.ui.mainCamera.transform.position - var_73_8.position).z)
				var_73_8.localEulerAngles.z = 0
				var_73_8.localEulerAngles.x = 0
				var_73_8.localEulerAngles = var_73_8.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_9 and arg_70_1.time_ < 0 + var_73_9 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(-0.7, -1, -6)
				var_73_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_8.position).x, (manager.ui.mainCamera.transform.position - var_73_8.position).y, (manager.ui.mainCamera.transform.position - var_73_8.position).z)
				var_73_8.localEulerAngles.z = 0
				var_73_8.localEulerAngles.x = 0
				var_73_8.localEulerAngles = var_73_8.localEulerAngles
			end

			local var_73_10 = arg_70_1.actors_["10025ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos10025ui_story = var_73_10.localPosition
			end

			local var_73_11 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_11 then
				var_73_10.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_70_1.time_ - 0) / var_73_11)
				var_73_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_10.position).x, (manager.ui.mainCamera.transform.position - var_73_10.position).y, (manager.ui.mainCamera.transform.position - var_73_10.position).z)
				var_73_10.localEulerAngles.z = 0
				var_73_10.localEulerAngles.x = 0
				var_73_10.localEulerAngles = var_73_10.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_11 and arg_70_1.time_ < 0 + var_73_11 + arg_73_0 then
				var_73_10.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_73_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_10.position).x, (manager.ui.mainCamera.transform.position - var_73_10.position).y, (manager.ui.mainCamera.transform.position - var_73_10.position).z)
				var_73_10.localEulerAngles.z = 0
				var_73_10.localEulerAngles.x = 0
				var_73_10.localEulerAngles = var_73_10.localEulerAngles
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_73_12 = 0
			local var_73_13 = 1.175

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_14 = arg_70_1:GetWordFromCfg(116391016)
				local var_73_15 = arg_70_1:FormatText(var_73_14.content)

				arg_70_1.text_.text = var_73_15

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 47 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 47)

				if (47 <= 0 and var_73_13 or var_73_13 * (utf8.len(var_73_15) / 47)) > 0 and var_73_13 < var_73_17 then
					arg_70_1.talkMaxDuration = var_73_17

					if var_73_17 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_17 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_15
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391016", "story_v_out_116391.awb") ~= 0 then
					local var_73_18 = manager.audio:GetVoiceLength("story_v_out_116391", "116391016", "story_v_out_116391.awb") / 1000

					if var_73_18 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_12
					end

					if var_73_14.prefab_name ~= "" and arg_70_1.actors_[var_73_14.prefab_name] ~= nil then
						local var_73_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_14.prefab_name].transform, "story_v_out_116391", "116391016", "story_v_out_116391.awb")

						arg_70_1:RecordAudio("116391016", var_73_19)
						arg_70_1:RecordAudio("116391016", var_73_19)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_116391", "116391016", "story_v_out_116391.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_116391", "116391016", "story_v_out_116391.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_20 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_20 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_12) / var_73_20

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_20 and arg_70_1.time_ < var_73_12 + var_73_20 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play116391017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116391017
		arg_74_1.duration_ = 11.47

		local var_74_0 = {
			zh = 5.1,
			ja = 11.466
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play116391018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos10024ui_story = arg_74_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_77_0 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 then
				arg_74_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_74_1.time_ - 0) / var_77_0)
				arg_74_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10024ui_story"].transform.position).z)
				arg_74_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["10024ui_story"].transform.localEulerAngles = arg_74_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 then
				arg_74_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_74_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["10024ui_story"].transform.position).z)
				arg_74_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["10024ui_story"].transform.localEulerAngles = arg_74_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action4_2")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_77_1 = 0
			local var_77_2 = 0.55

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(116391017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 22 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_4) / 22)

				if (22 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_4) / 22)) > 0 and var_77_2 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391017", "story_v_out_116391.awb") ~= 0 then
					local var_77_7 = manager.audio:GetVoiceLength("story_v_out_116391", "116391017", "story_v_out_116391.awb") / 1000

					if var_77_7 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_1
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_116391", "116391017", "story_v_out_116391.awb")

						arg_74_1:RecordAudio("116391017", var_77_8)
						arg_74_1:RecordAudio("116391017", var_77_8)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_116391", "116391017", "story_v_out_116391.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_116391", "116391017", "story_v_out_116391.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_9 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_9 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_9

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_9 and arg_74_1.time_ < var_77_1 + var_77_9 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play116391018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116391018
		arg_78_1.duration_ = 6.33

		local var_78_0 = {
			zh = 6.333,
			ja = 3.8
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116391019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos10024ui_story = arg_78_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10024ui_story"].transform.position).z)
				arg_78_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["10024ui_story"].transform.localEulerAngles = arg_78_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_78_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["10024ui_story"].transform.position).z)
				arg_78_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["10024ui_story"].transform.localEulerAngles = arg_78_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_81_1 = arg_78_1.actors_["10025ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos10025ui_story = var_81_1.localPosition
			end

			local var_81_2 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 then
				var_81_1.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_78_1.time_ - 0) / var_81_2)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 then
				var_81_1.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action6_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_81_3 = arg_78_1.actors_["10024ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect10024ui_story == nil then
				arg_78_1.var_.characterEffect10024ui_story = var_81_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_4 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 and not isNil(var_81_3) then
				if arg_78_1.var_.characterEffect10024ui_story and not isNil(var_81_3) then
					arg_78_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_4)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect10024ui_story then
				arg_78_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_81_5 = arg_78_1.actors_["10025ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect10025ui_story == nil then
				arg_78_1.var_.characterEffect10025ui_story = var_81_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_6 and not isNil(var_81_5) then
				if arg_78_1.var_.characterEffect10025ui_story and not isNil(var_81_5) then
					arg_78_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_6 and arg_78_1.time_ < 0 + var_81_6 + arg_81_0 and not isNil(var_81_5) and arg_78_1.var_.characterEffect10025ui_story then
				arg_78_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_81_8 = 0
			local var_81_9 = 0.3

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_10 = arg_78_1:GetWordFromCfg(116391018)
				local var_81_11 = arg_78_1:FormatText(var_81_10.content)

				arg_78_1.text_.text = var_81_11

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 12 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 12)

				if (12 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 12)) > 0 and var_81_9 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_8
					end
				end

				arg_78_1.text_.text = var_81_11
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391018", "story_v_out_116391.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_116391", "116391018", "story_v_out_116391.awb") / 1000

					if var_81_14 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_8
					end

					if var_81_10.prefab_name ~= "" and arg_78_1.actors_[var_81_10.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_10.prefab_name].transform, "story_v_out_116391", "116391018", "story_v_out_116391.awb")

						arg_78_1:RecordAudio("116391018", var_81_15)
						arg_78_1:RecordAudio("116391018", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_116391", "116391018", "story_v_out_116391.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_116391", "116391018", "story_v_out_116391.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_9, arg_78_1.talkMaxDuration)

			if var_81_8 <= arg_78_1.time_ and arg_78_1.time_ < var_81_8 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_8) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_8 + var_81_16 and arg_78_1.time_ < var_81_8 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play116391019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116391019
		arg_82_1.duration_ = 3.1

		local var_82_0 = {
			zh = 2.5,
			ja = 3.1
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
				arg_82_0:Play116391020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_85_0 = arg_82_1.actors_["10024ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10024ui_story == nil then
				arg_82_1.var_.characterEffect10024ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_1 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 and not isNil(var_85_0) then
				if arg_82_1.var_.characterEffect10024ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10024ui_story then
				arg_82_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_85_3 = arg_82_1.actors_["10025ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect10025ui_story == nil then
				arg_82_1.var_.characterEffect10025ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect10025ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_82_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_4)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect10025ui_story then
				arg_82_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_82_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_85_5 = 0
			local var_85_6 = 0.2

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:GetWordFromCfg(116391019)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 8 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 8)

				if (8 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 8)) > 0 and var_85_6 < var_85_10 then
					arg_82_1.talkMaxDuration = var_85_10

					if var_85_10 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_8
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391019", "story_v_out_116391.awb") ~= 0 then
					local var_85_11 = manager.audio:GetVoiceLength("story_v_out_116391", "116391019", "story_v_out_116391.awb") / 1000

					if var_85_11 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_5
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_out_116391", "116391019", "story_v_out_116391.awb")

						arg_82_1:RecordAudio("116391019", var_85_12)
						arg_82_1:RecordAudio("116391019", var_85_12)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_116391", "116391019", "story_v_out_116391.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_116391", "116391019", "story_v_out_116391.awb")
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

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116391020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116391020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116391021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10024ui_story = arg_86_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10024ui_story"].transform.position).z)
				arg_86_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["10024ui_story"].transform.localEulerAngles = arg_86_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["10024ui_story"].transform.position).z)
				arg_86_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["10024ui_story"].transform.localEulerAngles = arg_86_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["10025ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10025ui_story = var_89_1.localPosition
			end

			local var_89_2 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 then
				var_89_1.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_2)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 then
				var_89_1.localPosition = Vector3.New(0, 100, 0)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			local var_89_3 = 0
			local var_89_4 = 0.6

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_5 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(116391020).content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 24 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 24)

				if (24 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 24)) > 0 and var_89_4 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_3 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_3
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_8 = math.max(var_89_4, arg_86_1.talkMaxDuration)

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_8 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_3) / var_89_8

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_3 + var_89_8 and arg_86_1.time_ < var_89_3 + var_89_8 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play116391021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116391021
		arg_90_1.duration_ = 4.07

		local var_90_0 = {
			zh = 4.066,
			ja = 2.566
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116391022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action2_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_93_0 = arg_90_1.actors_["10024ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10024ui_story == nil then
				arg_90_1.var_.characterEffect10024ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_1 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_1 and not isNil(var_93_0) then
				if arg_90_1.var_.characterEffect10024ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_1 and arg_90_1.time_ < 0 + var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10024ui_story then
				arg_90_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_93_3 = arg_90_1.actors_["10024ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10024ui_story = var_93_3.localPosition
			end

			local var_93_4 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				var_93_3.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_90_1.time_ - 0) / var_93_4)
				var_93_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_3.position).x, (manager.ui.mainCamera.transform.position - var_93_3.position).y, (manager.ui.mainCamera.transform.position - var_93_3.position).z)
				var_93_3.localEulerAngles.z = 0
				var_93_3.localEulerAngles.x = 0
				var_93_3.localEulerAngles = var_93_3.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_3.localPosition = Vector3.New(-0.7, -1, -6)
				var_93_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_3.position).x, (manager.ui.mainCamera.transform.position - var_93_3.position).y, (manager.ui.mainCamera.transform.position - var_93_3.position).z)
				var_93_3.localEulerAngles.z = 0
				var_93_3.localEulerAngles.x = 0
				var_93_3.localEulerAngles = var_93_3.localEulerAngles
			end

			local var_93_5 = arg_90_1.actors_["10025ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10025ui_story = var_93_5.localPosition
			end

			local var_93_6 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_6 then
				var_93_5.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_90_1.time_ - 0) / var_93_6)
				var_93_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_5.position).x, (manager.ui.mainCamera.transform.position - var_93_5.position).y, (manager.ui.mainCamera.transform.position - var_93_5.position).z)
				var_93_5.localEulerAngles.z = 0
				var_93_5.localEulerAngles.x = 0
				var_93_5.localEulerAngles = var_93_5.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_6 and arg_90_1.time_ < 0 + var_93_6 + arg_93_0 then
				var_93_5.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_93_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_5.position).x, (manager.ui.mainCamera.transform.position - var_93_5.position).y, (manager.ui.mainCamera.transform.position - var_93_5.position).z)
				var_93_5.localEulerAngles.z = 0
				var_93_5.localEulerAngles.x = 0
				var_93_5.localEulerAngles = var_93_5.localEulerAngles
			end

			local var_93_7 = 0
			local var_93_8 = 0.35

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_9 = arg_90_1:GetWordFromCfg(116391021)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_12 = 14 <= 0 and var_93_8 or var_93_8 * (utf8.len(var_93_10) / 14)

				if (14 <= 0 and var_93_8 or var_93_8 * (utf8.len(var_93_10) / 14)) > 0 and var_93_8 < var_93_12 then
					arg_90_1.talkMaxDuration = var_93_12

					if var_93_12 + var_93_7 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_7
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391021", "story_v_out_116391.awb") ~= 0 then
					local var_93_13 = manager.audio:GetVoiceLength("story_v_out_116391", "116391021", "story_v_out_116391.awb") / 1000

					if var_93_13 + var_93_7 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_7
					end

					if var_93_9.prefab_name ~= "" and arg_90_1.actors_[var_93_9.prefab_name] ~= nil then
						local var_93_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_9.prefab_name].transform, "story_v_out_116391", "116391021", "story_v_out_116391.awb")

						arg_90_1:RecordAudio("116391021", var_93_14)
						arg_90_1:RecordAudio("116391021", var_93_14)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_116391", "116391021", "story_v_out_116391.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_116391", "116391021", "story_v_out_116391.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_15 = math.max(var_93_8, arg_90_1.talkMaxDuration)

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_15 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_7) / var_93_15

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_7 + var_93_15 and arg_90_1.time_ < var_93_7 + var_93_15 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play116391022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116391022
		arg_94_1.duration_ = 10.8

		local var_94_0 = {
			zh = 7.9,
			ja = 10.8
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
				arg_94_0:Play116391023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_97_0 = 0
			local var_97_1 = 0.975

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(116391022)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 39 <= 0 and var_97_1 or var_97_1 * (utf8.len(var_97_3) / 39)

				if (39 <= 0 and var_97_1 or var_97_1 * (utf8.len(var_97_3) / 39)) > 0 and var_97_1 < var_97_5 then
					arg_94_1.talkMaxDuration = var_97_5

					if var_97_5 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391022", "story_v_out_116391.awb") ~= 0 then
					local var_97_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391022", "story_v_out_116391.awb") / 1000

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end

					if var_97_2.prefab_name ~= "" and arg_94_1.actors_[var_97_2.prefab_name] ~= nil then
						local var_97_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_2.prefab_name].transform, "story_v_out_116391", "116391022", "story_v_out_116391.awb")

						arg_94_1:RecordAudio("116391022", var_97_7)
						arg_94_1:RecordAudio("116391022", var_97_7)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_116391", "116391022", "story_v_out_116391.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_116391", "116391022", "story_v_out_116391.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_8 and arg_94_1.time_ < var_97_0 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play116391023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116391023
		arg_98_1.duration_ = 14.67

		local var_98_0 = {
			zh = 9.7,
			ja = 14.666
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
				arg_98_0:Play116391024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action2_2")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_101_0 = 0
			local var_101_1 = 1.15

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(116391023)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 46 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 46)

				if (46 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 46)) > 0 and var_101_1 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391023", "story_v_out_116391.awb") ~= 0 then
					local var_101_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391023", "story_v_out_116391.awb") / 1000

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end

					if var_101_2.prefab_name ~= "" and arg_98_1.actors_[var_101_2.prefab_name] ~= nil then
						local var_101_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_2.prefab_name].transform, "story_v_out_116391", "116391023", "story_v_out_116391.awb")

						arg_98_1:RecordAudio("116391023", var_101_7)
						arg_98_1:RecordAudio("116391023", var_101_7)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_116391", "116391023", "story_v_out_116391.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_116391", "116391023", "story_v_out_116391.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play116391024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116391024
		arg_102_1.duration_ = 18.07

		local var_102_0 = {
			zh = 12.133,
			ja = 18.066
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
				arg_102_0:Play116391025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_105_0 = 0
			local var_105_1 = 1.225

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(116391024)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 50 <= 0 and var_105_1 or var_105_1 * (utf8.len(var_105_3) / 50)

				if (50 <= 0 and var_105_1 or var_105_1 * (utf8.len(var_105_3) / 50)) > 0 and var_105_1 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391024", "story_v_out_116391.awb") ~= 0 then
					local var_105_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391024", "story_v_out_116391.awb") / 1000

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end

					if var_105_2.prefab_name ~= "" and arg_102_1.actors_[var_105_2.prefab_name] ~= nil then
						local var_105_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_2.prefab_name].transform, "story_v_out_116391", "116391024", "story_v_out_116391.awb")

						arg_102_1:RecordAudio("116391024", var_105_7)
						arg_102_1:RecordAudio("116391024", var_105_7)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_116391", "116391024", "story_v_out_116391.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_116391", "116391024", "story_v_out_116391.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_8 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_8 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_8

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_8 and arg_102_1.time_ < var_105_0 + var_105_8 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play116391025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116391025
		arg_106_1.duration_ = 4.4

		local var_106_0 = {
			zh = 2.399999999999,
			ja = 4.4
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
				arg_106_0:Play116391026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action467")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_109_0 = arg_106_1.actors_["10024ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10024ui_story == nil then
				arg_106_1.var_.characterEffect10024ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_1 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_1 and not isNil(var_109_0) then
				if arg_106_1.var_.characterEffect10024ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_1)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_1 and arg_106_1.time_ < 0 + var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10024ui_story then
				arg_106_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_109_2 = arg_106_1.actors_["10025ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect10025ui_story == nil then
				arg_106_1.var_.characterEffect10025ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect10025ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect10025ui_story then
				arg_106_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_109_5 = arg_106_1.actors_["10024ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10024ui_story = var_109_5.localPosition
			end

			local var_109_6 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_6 then
				var_109_5.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_106_1.time_ - 0) / var_109_6)
				var_109_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_5.position).x, (manager.ui.mainCamera.transform.position - var_109_5.position).y, (manager.ui.mainCamera.transform.position - var_109_5.position).z)
				var_109_5.localEulerAngles.z = 0
				var_109_5.localEulerAngles.x = 0
				var_109_5.localEulerAngles = var_109_5.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_6 and arg_106_1.time_ < 0 + var_109_6 + arg_109_0 then
				var_109_5.localPosition = Vector3.New(-0.7, -1, -6)
				var_109_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_5.position).x, (manager.ui.mainCamera.transform.position - var_109_5.position).y, (manager.ui.mainCamera.transform.position - var_109_5.position).z)
				var_109_5.localEulerAngles.z = 0
				var_109_5.localEulerAngles.x = 0
				var_109_5.localEulerAngles = var_109_5.localEulerAngles
			end

			local var_109_7 = arg_106_1.actors_["10025ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10025ui_story = var_109_7.localPosition
			end

			local var_109_8 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_8 then
				var_109_7.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_106_1.time_ - 0) / var_109_8)
				var_109_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_7.position).x, (manager.ui.mainCamera.transform.position - var_109_7.position).y, (manager.ui.mainCamera.transform.position - var_109_7.position).z)
				var_109_7.localEulerAngles.z = 0
				var_109_7.localEulerAngles.x = 0
				var_109_7.localEulerAngles = var_109_7.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_8 and arg_106_1.time_ < 0 + var_109_8 + arg_109_0 then
				var_109_7.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_109_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_7.position).x, (manager.ui.mainCamera.transform.position - var_109_7.position).y, (manager.ui.mainCamera.transform.position - var_109_7.position).z)
				var_109_7.localEulerAngles.z = 0
				var_109_7.localEulerAngles.x = 0
				var_109_7.localEulerAngles = var_109_7.localEulerAngles
			end

			local var_109_9 = 0
			local var_109_10 = 0.175

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_9 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_11 = arg_106_1:GetWordFromCfg(116391025)
				local var_109_12 = arg_106_1:FormatText(var_109_11.content)

				arg_106_1.text_.text = var_109_12

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_14 = 7 <= 0 and var_109_10 or var_109_10 * (utf8.len(var_109_12) / 7)

				if (7 <= 0 and var_109_10 or var_109_10 * (utf8.len(var_109_12) / 7)) > 0 and var_109_10 < var_109_14 then
					arg_106_1.talkMaxDuration = var_109_14

					if var_109_14 + var_109_9 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_9
					end
				end

				arg_106_1.text_.text = var_109_12
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391025", "story_v_out_116391.awb") ~= 0 then
					local var_109_15 = manager.audio:GetVoiceLength("story_v_out_116391", "116391025", "story_v_out_116391.awb") / 1000

					if var_109_15 + var_109_9 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_15 + var_109_9
					end

					if var_109_11.prefab_name ~= "" and arg_106_1.actors_[var_109_11.prefab_name] ~= nil then
						local var_109_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_11.prefab_name].transform, "story_v_out_116391", "116391025", "story_v_out_116391.awb")

						arg_106_1:RecordAudio("116391025", var_109_16)
						arg_106_1:RecordAudio("116391025", var_109_16)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_116391", "116391025", "story_v_out_116391.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_116391", "116391025", "story_v_out_116391.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_17 = math.max(var_109_10, arg_106_1.talkMaxDuration)

			if var_109_9 <= arg_106_1.time_ and arg_106_1.time_ < var_109_9 + var_109_17 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_9) / var_109_17

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_9 + var_109_17 and arg_106_1.time_ < var_109_9 + var_109_17 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play116391026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116391026
		arg_110_1.duration_ = 14.83

		local var_110_0 = {
			zh = 14.833,
			ja = 14.1
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play116391027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10024ui_story = arg_110_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10024ui_story"].transform.position).z)
				arg_110_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10024ui_story"].transform.localEulerAngles = arg_110_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_110_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10024ui_story"].transform.position).z)
				arg_110_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10024ui_story"].transform.localEulerAngles = arg_110_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_113_1 = arg_110_1.actors_["10025ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10025ui_story = var_113_1.localPosition
			end

			local var_113_2 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 then
				var_113_1.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_110_1.time_ - 0) / var_113_2)
				var_113_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_1.position).x, (manager.ui.mainCamera.transform.position - var_113_1.position).y, (manager.ui.mainCamera.transform.position - var_113_1.position).z)
				var_113_1.localEulerAngles.z = 0
				var_113_1.localEulerAngles.x = 0
				var_113_1.localEulerAngles = var_113_1.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 then
				var_113_1.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_113_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_1.position).x, (manager.ui.mainCamera.transform.position - var_113_1.position).y, (manager.ui.mainCamera.transform.position - var_113_1.position).z)
				var_113_1.localEulerAngles.z = 0
				var_113_1.localEulerAngles.x = 0
				var_113_1.localEulerAngles = var_113_1.localEulerAngles
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_113_3 = arg_110_1.actors_["10024ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_3) and arg_110_1.var_.characterEffect10024ui_story == nil then
				arg_110_1.var_.characterEffect10024ui_story = var_113_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_4 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 and not isNil(var_113_3) then
				if arg_110_1.var_.characterEffect10024ui_story and not isNil(var_113_3) then
					arg_110_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 and not isNil(var_113_3) and arg_110_1.var_.characterEffect10024ui_story then
				arg_110_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_113_6 = arg_110_1.actors_["10025ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect10025ui_story == nil then
				arg_110_1.var_.characterEffect10025ui_story = var_113_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_7 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 and not isNil(var_113_6) then
				if arg_110_1.var_.characterEffect10025ui_story and not isNil(var_113_6) then
					arg_110_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_7)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect10025ui_story then
				arg_110_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_113_8 = 0
			local var_113_9 = 1.25

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_10 = arg_110_1:GetWordFromCfg(116391026)
				local var_113_11 = arg_110_1:FormatText(var_113_10.content)

				arg_110_1.text_.text = var_113_11

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_13 = 50 <= 0 and var_113_9 or var_113_9 * (utf8.len(var_113_11) / 50)

				if (50 <= 0 and var_113_9 or var_113_9 * (utf8.len(var_113_11) / 50)) > 0 and var_113_9 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_8
					end
				end

				arg_110_1.text_.text = var_113_11
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391026", "story_v_out_116391.awb") ~= 0 then
					local var_113_14 = manager.audio:GetVoiceLength("story_v_out_116391", "116391026", "story_v_out_116391.awb") / 1000

					if var_113_14 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_14 + var_113_8
					end

					if var_113_10.prefab_name ~= "" and arg_110_1.actors_[var_113_10.prefab_name] ~= nil then
						local var_113_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_10.prefab_name].transform, "story_v_out_116391", "116391026", "story_v_out_116391.awb")

						arg_110_1:RecordAudio("116391026", var_113_15)
						arg_110_1:RecordAudio("116391026", var_113_15)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_116391", "116391026", "story_v_out_116391.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_116391", "116391026", "story_v_out_116391.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_9, arg_110_1.talkMaxDuration)

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_8) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_8 + var_113_16 and arg_110_1.time_ < var_113_8 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play116391027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116391027
		arg_114_1.duration_ = 10.53

		local var_114_0 = {
			zh = 10.533,
			ja = 8.533
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116391028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_117_0 = 0
			local var_117_1 = 1.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(116391027)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 53 <= 0 and var_117_1 or var_117_1 * (utf8.len(var_117_3) / 53)

				if (53 <= 0 and var_117_1 or var_117_1 * (utf8.len(var_117_3) / 53)) > 0 and var_117_1 < var_117_5 then
					arg_114_1.talkMaxDuration = var_117_5

					if var_117_5 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391027", "story_v_out_116391.awb") ~= 0 then
					local var_117_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391027", "story_v_out_116391.awb") / 1000

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end

					if var_117_2.prefab_name ~= "" and arg_114_1.actors_[var_117_2.prefab_name] ~= nil then
						local var_117_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_2.prefab_name].transform, "story_v_out_116391", "116391027", "story_v_out_116391.awb")

						arg_114_1:RecordAudio("116391027", var_117_7)
						arg_114_1:RecordAudio("116391027", var_117_7)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_116391", "116391027", "story_v_out_116391.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_116391", "116391027", "story_v_out_116391.awb")
				end

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
	Play116391028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116391028
		arg_118_1.duration_ = 12.4

		local var_118_0 = {
			zh = 12.4,
			ja = 10.466
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play116391029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_121_0 = 0
			local var_121_1 = 1.2

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_2 = arg_118_1:GetWordFromCfg(116391028)
				local var_121_3 = arg_118_1:FormatText(var_121_2.content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 48 <= 0 and var_121_1 or var_121_1 * (utf8.len(var_121_3) / 48)

				if (48 <= 0 and var_121_1 or var_121_1 * (utf8.len(var_121_3) / 48)) > 0 and var_121_1 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391028", "story_v_out_116391.awb") ~= 0 then
					local var_121_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391028", "story_v_out_116391.awb") / 1000

					if var_121_6 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_0
					end

					if var_121_2.prefab_name ~= "" and arg_118_1.actors_[var_121_2.prefab_name] ~= nil then
						local var_121_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_2.prefab_name].transform, "story_v_out_116391", "116391028", "story_v_out_116391.awb")

						arg_118_1:RecordAudio("116391028", var_121_7)
						arg_118_1:RecordAudio("116391028", var_121_7)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_116391", "116391028", "story_v_out_116391.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_116391", "116391028", "story_v_out_116391.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_8 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_8 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_8

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_8 and arg_118_1.time_ < var_121_0 + var_121_8 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play116391029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116391029
		arg_122_1.duration_ = 4.87

		local var_122_0 = {
			zh = 4.866,
			ja = 4.733
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116391030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_125_0 = arg_122_1.actors_["10024ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10024ui_story == nil then
				arg_122_1.var_.characterEffect10024ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_1 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_1 and not isNil(var_125_0) then
				if arg_122_1.var_.characterEffect10024ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_122_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_1)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_1 and arg_122_1.time_ < 0 + var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect10024ui_story then
				arg_122_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_122_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_125_2 = arg_122_1.actors_["10025ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect10025ui_story == nil then
				arg_122_1.var_.characterEffect10025ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect10025ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect10025ui_story then
				arg_122_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_125_5 = arg_122_1.actors_["10024ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos10024ui_story = var_125_5.localPosition
			end

			local var_125_6 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_6 then
				var_125_5.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_122_1.time_ - 0) / var_125_6)
				var_125_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_5.position).x, (manager.ui.mainCamera.transform.position - var_125_5.position).y, (manager.ui.mainCamera.transform.position - var_125_5.position).z)
				var_125_5.localEulerAngles.z = 0
				var_125_5.localEulerAngles.x = 0
				var_125_5.localEulerAngles = var_125_5.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_6 and arg_122_1.time_ < 0 + var_125_6 + arg_125_0 then
				var_125_5.localPosition = Vector3.New(-0.7, -1, -6)
				var_125_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_5.position).x, (manager.ui.mainCamera.transform.position - var_125_5.position).y, (manager.ui.mainCamera.transform.position - var_125_5.position).z)
				var_125_5.localEulerAngles.z = 0
				var_125_5.localEulerAngles.x = 0
				var_125_5.localEulerAngles = var_125_5.localEulerAngles
			end

			local var_125_7 = arg_122_1.actors_["10025ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos10025ui_story = var_125_7.localPosition
			end

			local var_125_8 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_8 then
				var_125_7.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_122_1.time_ - 0) / var_125_8)
				var_125_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_7.position).x, (manager.ui.mainCamera.transform.position - var_125_7.position).y, (manager.ui.mainCamera.transform.position - var_125_7.position).z)
				var_125_7.localEulerAngles.z = 0
				var_125_7.localEulerAngles.x = 0
				var_125_7.localEulerAngles = var_125_7.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_8 and arg_122_1.time_ < 0 + var_125_8 + arg_125_0 then
				var_125_7.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_125_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_7.position).x, (manager.ui.mainCamera.transform.position - var_125_7.position).y, (manager.ui.mainCamera.transform.position - var_125_7.position).z)
				var_125_7.localEulerAngles.z = 0
				var_125_7.localEulerAngles.x = 0
				var_125_7.localEulerAngles = var_125_7.localEulerAngles
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_2")
			end

			local var_125_9 = 0
			local var_125_10 = 0.4

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_11 = arg_122_1:GetWordFromCfg(116391029)
				local var_125_12 = arg_122_1:FormatText(var_125_11.content)

				arg_122_1.text_.text = var_125_12

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_14 = 16 <= 0 and var_125_10 or var_125_10 * (utf8.len(var_125_12) / 16)

				if (16 <= 0 and var_125_10 or var_125_10 * (utf8.len(var_125_12) / 16)) > 0 and var_125_10 < var_125_14 then
					arg_122_1.talkMaxDuration = var_125_14

					if var_125_14 + var_125_9 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_9
					end
				end

				arg_122_1.text_.text = var_125_12
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391029", "story_v_out_116391.awb") ~= 0 then
					local var_125_15 = manager.audio:GetVoiceLength("story_v_out_116391", "116391029", "story_v_out_116391.awb") / 1000

					if var_125_15 + var_125_9 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_9
					end

					if var_125_11.prefab_name ~= "" and arg_122_1.actors_[var_125_11.prefab_name] ~= nil then
						local var_125_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_11.prefab_name].transform, "story_v_out_116391", "116391029", "story_v_out_116391.awb")

						arg_122_1:RecordAudio("116391029", var_125_16)
						arg_122_1:RecordAudio("116391029", var_125_16)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_116391", "116391029", "story_v_out_116391.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_116391", "116391029", "story_v_out_116391.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_17 = math.max(var_125_10, arg_122_1.talkMaxDuration)

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_17 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_9) / var_125_17

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_9 + var_125_17 and arg_122_1.time_ < var_125_9 + var_125_17 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play116391030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116391030
		arg_126_1.duration_ = 6.4

		local var_126_0 = {
			zh = 6.4,
			ja = 6.166
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play116391031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_129_0 = 0
			local var_129_1 = 0.675

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_2 = arg_126_1:GetWordFromCfg(116391030)
				local var_129_3 = arg_126_1:FormatText(var_129_2.content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 27 <= 0 and var_129_1 or var_129_1 * (utf8.len(var_129_3) / 27)

				if (27 <= 0 and var_129_1 or var_129_1 * (utf8.len(var_129_3) / 27)) > 0 and var_129_1 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391030", "story_v_out_116391.awb") ~= 0 then
					local var_129_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391030", "story_v_out_116391.awb") / 1000

					if var_129_6 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_0
					end

					if var_129_2.prefab_name ~= "" and arg_126_1.actors_[var_129_2.prefab_name] ~= nil then
						local var_129_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_2.prefab_name].transform, "story_v_out_116391", "116391030", "story_v_out_116391.awb")

						arg_126_1:RecordAudio("116391030", var_129_7)
						arg_126_1:RecordAudio("116391030", var_129_7)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_116391", "116391030", "story_v_out_116391.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_116391", "116391030", "story_v_out_116391.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_8 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_8 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_8

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_8 and arg_126_1.time_ < var_129_0 + var_129_8 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play116391031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 116391031
		arg_130_1.duration_ = 9.6

		local var_130_0 = {
			zh = 9.6,
			ja = 7.933
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
				arg_130_0:Play116391032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_2")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_133_0 = arg_130_1.actors_["10024ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10024ui_story == nil then
				arg_130_1.var_.characterEffect10024ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_1 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_1 and not isNil(var_133_0) then
				if arg_130_1.var_.characterEffect10024ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_1 and arg_130_1.time_ < 0 + var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect10024ui_story then
				arg_130_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_133_3 = arg_130_1.actors_["10025ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect10025ui_story == nil then
				arg_130_1.var_.characterEffect10025ui_story = var_133_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_4 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 and not isNil(var_133_3) then
				if arg_130_1.var_.characterEffect10025ui_story and not isNil(var_133_3) then
					arg_130_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_130_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_4)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect10025ui_story then
				arg_130_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_130_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_133_5 = arg_130_1.actors_["10024ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10024ui_story = var_133_5.localPosition
			end

			local var_133_6 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_6 then
				var_133_5.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_130_1.time_ - 0) / var_133_6)
				var_133_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_5.position).x, (manager.ui.mainCamera.transform.position - var_133_5.position).y, (manager.ui.mainCamera.transform.position - var_133_5.position).z)
				var_133_5.localEulerAngles.z = 0
				var_133_5.localEulerAngles.x = 0
				var_133_5.localEulerAngles = var_133_5.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_6 and arg_130_1.time_ < 0 + var_133_6 + arg_133_0 then
				var_133_5.localPosition = Vector3.New(-0.7, -1, -6)
				var_133_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_5.position).x, (manager.ui.mainCamera.transform.position - var_133_5.position).y, (manager.ui.mainCamera.transform.position - var_133_5.position).z)
				var_133_5.localEulerAngles.z = 0
				var_133_5.localEulerAngles.x = 0
				var_133_5.localEulerAngles = var_133_5.localEulerAngles
			end

			local var_133_7 = arg_130_1.actors_["10025ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10025ui_story = var_133_7.localPosition
			end

			local var_133_8 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_8 then
				var_133_7.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_130_1.time_ - 0) / var_133_8)
				var_133_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_7.position).x, (manager.ui.mainCamera.transform.position - var_133_7.position).y, (manager.ui.mainCamera.transform.position - var_133_7.position).z)
				var_133_7.localEulerAngles.z = 0
				var_133_7.localEulerAngles.x = 0
				var_133_7.localEulerAngles = var_133_7.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_8 and arg_130_1.time_ < 0 + var_133_8 + arg_133_0 then
				var_133_7.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_133_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_7.position).x, (manager.ui.mainCamera.transform.position - var_133_7.position).y, (manager.ui.mainCamera.transform.position - var_133_7.position).z)
				var_133_7.localEulerAngles.z = 0
				var_133_7.localEulerAngles.x = 0
				var_133_7.localEulerAngles = var_133_7.localEulerAngles
			end

			local var_133_9 = 0
			local var_133_10 = 0.4

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_11 = arg_130_1:GetWordFromCfg(116391031)
				local var_133_12 = arg_130_1:FormatText(var_133_11.content)

				arg_130_1.text_.text = var_133_12

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_14 = 16 <= 0 and var_133_10 or var_133_10 * (utf8.len(var_133_12) / 16)

				if (16 <= 0 and var_133_10 or var_133_10 * (utf8.len(var_133_12) / 16)) > 0 and var_133_10 < var_133_14 then
					arg_130_1.talkMaxDuration = var_133_14

					if var_133_14 + var_133_9 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_14 + var_133_9
					end
				end

				arg_130_1.text_.text = var_133_12
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391031", "story_v_out_116391.awb") ~= 0 then
					local var_133_15 = manager.audio:GetVoiceLength("story_v_out_116391", "116391031", "story_v_out_116391.awb") / 1000

					if var_133_15 + var_133_9 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_15 + var_133_9
					end

					if var_133_11.prefab_name ~= "" and arg_130_1.actors_[var_133_11.prefab_name] ~= nil then
						local var_133_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_11.prefab_name].transform, "story_v_out_116391", "116391031", "story_v_out_116391.awb")

						arg_130_1:RecordAudio("116391031", var_133_16)
						arg_130_1:RecordAudio("116391031", var_133_16)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_116391", "116391031", "story_v_out_116391.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_116391", "116391031", "story_v_out_116391.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_17 = math.max(var_133_10, arg_130_1.talkMaxDuration)

			if var_133_9 <= arg_130_1.time_ and arg_130_1.time_ < var_133_9 + var_133_17 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_9) / var_133_17

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_9 + var_133_17 and arg_130_1.time_ < var_133_9 + var_133_17 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play116391032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 116391032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play116391033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["10024ui_story"]) and arg_134_1.var_.characterEffect10024ui_story == nil then
				arg_134_1.var_.characterEffect10024ui_story = arg_134_1.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["10024ui_story"]) then
				if arg_134_1.var_.characterEffect10024ui_story and not isNil(arg_134_1.actors_["10024ui_story"]) then
					arg_134_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_134_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["10024ui_story"]) and arg_134_1.var_.characterEffect10024ui_story then
				arg_134_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_134_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.9

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(116391032).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 36 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 36)

				if (36 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 36)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play116391033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 116391033
		arg_138_1.duration_ = 7.23

		local var_138_0 = {
			zh = 7.233,
			ja = 4.466
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
				arg_138_0:Play116391034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10024ui_story = arg_138_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10024ui_story"].transform.position).z)
				arg_138_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10024ui_story"].transform.localEulerAngles = arg_138_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_138_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10024ui_story"].transform.position).z)
				arg_138_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10024ui_story"].transform.localEulerAngles = arg_138_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["10025ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10025ui_story = var_141_1.localPosition
			end

			local var_141_2 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 then
				var_141_1.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_138_1.time_ - 0) / var_141_2)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 then
				var_141_1.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action2_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_141_3 = arg_138_1.actors_["10024ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect10024ui_story == nil then
				arg_138_1.var_.characterEffect10024ui_story = var_141_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 and not isNil(var_141_3) then
				if arg_138_1.var_.characterEffect10024ui_story and not isNil(var_141_3) then
					arg_138_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect10024ui_story then
				arg_138_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_141_6 = 0
			local var_141_7 = 0.625

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(116391033)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 25 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 25)

				if (25 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 25)) > 0 and var_141_7 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391033", "story_v_out_116391.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_116391", "116391033", "story_v_out_116391.awb") / 1000

					if var_141_12 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_6
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_116391", "116391033", "story_v_out_116391.awb")

						arg_138_1:RecordAudio("116391033", var_141_13)
						arg_138_1:RecordAudio("116391033", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_116391", "116391033", "story_v_out_116391.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_116391", "116391033", "story_v_out_116391.awb")
				end

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

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play116391034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 116391034
		arg_142_1.duration_ = 8.63

		local var_142_0 = {
			zh = 8.633,
			ja = 8.233
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
				arg_142_0:Play116391035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action2_2")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_145_0 = 0
			local var_145_1 = 0.725

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(116391034)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 29 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 29)

				if (29 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 29)) > 0 and var_145_1 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391034", "story_v_out_116391.awb") ~= 0 then
					local var_145_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391034", "story_v_out_116391.awb") / 1000

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end

					if var_145_2.prefab_name ~= "" and arg_142_1.actors_[var_145_2.prefab_name] ~= nil then
						local var_145_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_2.prefab_name].transform, "story_v_out_116391", "116391034", "story_v_out_116391.awb")

						arg_142_1:RecordAudio("116391034", var_145_7)
						arg_142_1:RecordAudio("116391034", var_145_7)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_116391", "116391034", "story_v_out_116391.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_116391", "116391034", "story_v_out_116391.awb")
				end

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
	Play116391035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116391035
		arg_146_1.duration_ = 9

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play116391036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if arg_146_1.bgs_.I05f == nil then
				local var_149_0 = Object.Instantiate(arg_146_1.paintGo_)

				var_149_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05f")
				var_149_0.name = "I05f"
				var_149_0.transform.parent = arg_146_1.stage_.transform
				var_149_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.bgs_.I05f = var_149_0
			end

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= 2 + arg_149_0 then
				local var_149_1 = arg_146_1.bgs_.I05f

				arg_146_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_149_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_149_2 = var_149_1:GetComponent("SpriteRenderer")

				if var_149_2 and var_149_2.sprite then
					local var_149_3 = 2 * (var_149_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_149_1.transform.localScale = Vector3.New(var_149_3 / var_149_2.sprite.bounds.size.y < var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x and var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x or var_149_3 / var_149_2.sprite.bounds.size.y, var_149_3 / var_149_2.sprite.bounds.size.y < var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x and var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x or var_149_3 / var_149_2.sprite.bounds.size.y, 0)
				end

				for iter_149_0, iter_149_1 in pairs(arg_146_1.bgs_) do
					if iter_149_0 ~= "I05f" then
						iter_149_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_149_4 = arg_146_1.actors_["10024ui_story"].transform

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= 2 + arg_149_0 then
				arg_146_1.var_.moveOldPos10024ui_story = var_149_4.localPosition
			end

			local var_149_5 = 0.001

			if 2 <= arg_146_1.time_ and arg_146_1.time_ < 2 + var_149_5 then
				var_149_4.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 2) / var_149_5)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			if arg_146_1.time_ >= 2 + var_149_5 and arg_146_1.time_ < 2 + var_149_5 + arg_149_0 then
				var_149_4.localPosition = Vector3.New(0, 100, 0)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			local var_149_6 = arg_146_1.actors_["10025ui_story"].transform

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= 2 + arg_149_0 then
				arg_146_1.var_.moveOldPos10025ui_story = var_149_6.localPosition
			end

			local var_149_7 = 0.001

			if 2 <= arg_146_1.time_ and arg_146_1.time_ < 2 + var_149_7 then
				var_149_6.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 2) / var_149_7)
				var_149_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_6.position).x, (manager.ui.mainCamera.transform.position - var_149_6.position).y, (manager.ui.mainCamera.transform.position - var_149_6.position).z)
				var_149_6.localEulerAngles.z = 0
				var_149_6.localEulerAngles.x = 0
				var_149_6.localEulerAngles = var_149_6.localEulerAngles
			end

			if arg_146_1.time_ >= 2 + var_149_7 and arg_146_1.time_ < 2 + var_149_7 + arg_149_0 then
				var_149_6.localPosition = Vector3.New(0, 100, 0)
				var_149_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_6.position).x, (manager.ui.mainCamera.transform.position - var_149_6.position).y, (manager.ui.mainCamera.transform.position - var_149_6.position).z)
				var_149_6.localEulerAngles.z = 0
				var_149_6.localEulerAngles.x = 0
				var_149_6.localEulerAngles = var_149_6.localEulerAngles
			end

			local var_149_8 = 0

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_9 = 2

			if var_149_8 <= arg_146_1.time_ and arg_146_1.time_ < var_149_8 + var_149_9 then
				local var_149_10 = Color.New(0, 0, 0)

				var_149_10.a = Mathf.Lerp(0, 1, (arg_146_1.time_ - var_149_8) / var_149_9)
				arg_146_1.mask_.color = var_149_10
			end

			if arg_146_1.time_ >= var_149_8 + var_149_9 and arg_146_1.time_ < var_149_8 + var_149_9 + arg_149_0 then
				local var_149_11 = Color.New(0, 0, 0)

				var_149_11.a = 1
				arg_146_1.mask_.color = var_149_11
			end

			local var_149_12 = 2

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= var_149_12 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_13 = 2

			if var_149_12 <= arg_146_1.time_ and arg_146_1.time_ < var_149_12 + var_149_13 then
				local var_149_14 = Color.New(0, 0, 0)

				var_149_14.a = Mathf.Lerp(1, 0, (arg_146_1.time_ - var_149_12) / var_149_13)
				arg_146_1.mask_.color = var_149_14
			end

			if arg_146_1.time_ >= var_149_12 + var_149_13 and arg_146_1.time_ < var_149_12 + var_149_13 + arg_149_0 then
				local var_149_15 = Color.New(0, 0, 0)

				arg_146_1.mask_.enabled = false
				var_149_15.a = 0
				arg_146_1.mask_.color = var_149_15
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_16 = 4
			local var_149_17 = 1.15

			if 4 < arg_146_1.time_ and arg_146_1.time_ <= var_149_16 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_18 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_18:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_19 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(116391035).content)

				arg_146_1.text_.text = var_149_19

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_21 = 46 <= 0 and var_149_17 or var_149_17 * (utf8.len(var_149_19) / 46)

				if (46 <= 0 and var_149_17 or var_149_17 * (utf8.len(var_149_19) / 46)) > 0 and var_149_17 < var_149_21 then
					arg_146_1.talkMaxDuration = var_149_21
					var_149_16 = var_149_16 + 0.3

					if var_149_21 + var_149_16 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_21 + var_149_16
					end
				end

				arg_146_1.text_.text = var_149_19
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_22 = var_149_16 + 0.3
			local var_149_23 = math.max(var_149_17, arg_146_1.talkMaxDuration)

			if var_149_16 + 0.3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_22 + var_149_23 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_22) / var_149_23

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_22 + var_149_23 and arg_146_1.time_ < var_149_22 + var_149_23 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play116391036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 116391036
		arg_152_1.duration_ = 7.53

		local var_152_0 = {
			zh = 7.533,
			ja = 7.297999999999
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
				arg_152_0:Play116391037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = manager.audio:GetVoiceLength("story_v_out_116391", "116391036", "story_v_out_116391.awb") / 1000

			if var_155_0 > 0 and 7.298 < var_155_0 and var_155_0 + 0 > arg_152_1.duration_ then
				arg_152_1.duration_ = var_155_0 + 0
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:AudioAction("play", "voice", "story_v_out_116391", "116391036", "story_v_out_116391.awb")
			end

			local var_155_2 = 0
			local var_155_3 = 0.625

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_4 = arg_152_1:GetWordFromCfg(116391036)
				local var_155_5 = arg_152_1:FormatText(var_155_4.content)

				arg_152_1.text_.text = var_155_5

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 25 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 25)

				if (25 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_5) / 25)) > 0 and var_155_3 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_5
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391036", "story_v_out_116391.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_116391", "116391036", "story_v_out_116391.awb") / 1000

					if var_155_8 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_2
					end

					if var_155_4.prefab_name ~= "" and arg_152_1.actors_[var_155_4.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_4.prefab_name].transform, "story_v_out_116391", "116391036", "story_v_out_116391.awb")

						arg_152_1:RecordAudio("116391036", var_155_9)
						arg_152_1:RecordAudio("116391036", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_116391", "116391036", "story_v_out_116391.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_116391", "116391036", "story_v_out_116391.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_10 and arg_152_1.time_ < var_155_2 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play116391037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 116391037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play116391038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.025

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(116391037).content)

				arg_156_1.text_.text = var_159_1

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_3 = 41 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 41)

				if (41 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 41)) > 0 and var_159_0 < var_159_3 then
					arg_156_1.talkMaxDuration = var_159_3

					if var_159_3 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_3 + 0
					end
				end

				arg_156_1.text_.text = var_159_1
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_4 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_4

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play116391038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 116391038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play116391039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.7

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(116391038).content)

				arg_160_1.text_.text = var_163_1

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_3 = 28 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 28)

				if (28 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 28)) > 0 and var_163_0 < var_163_3 then
					arg_160_1.talkMaxDuration = var_163_3

					if var_163_3 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_3 + 0
					end
				end

				arg_160_1.text_.text = var_163_1
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_4 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_4

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play116391039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 116391039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play116391040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 1.3

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(116391039).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 52 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 52)

				if (52 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 52)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play116391040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 116391040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play116391041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.875

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(116391040).content)

				arg_168_1.text_.text = var_171_1

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_3 = 35 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 35)

				if (35 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 35)) > 0 and var_171_0 < var_171_3 then
					arg_168_1.talkMaxDuration = var_171_3

					if var_171_3 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_3 + 0
					end
				end

				arg_168_1.text_.text = var_171_1
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_4 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_4

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play116391041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 116391041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play116391042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.775

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(116391041).content)

				arg_172_1.text_.text = var_175_1

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_3 = 31 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 31)

				if (31 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 31)) > 0 and var_175_0 < var_175_3 then
					arg_172_1.talkMaxDuration = var_175_3

					if var_175_3 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_3 + 0
					end
				end

				arg_172_1.text_.text = var_175_1
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_4 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_4

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play116391042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 116391042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play116391043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.975

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(116391042).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 39 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 39)

				if (39 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 39)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play116391043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116391043
		arg_180_1.duration_ = 12

		local var_180_0 = {
			zh = 12,
			ja = 10.566
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
				arg_180_0:Play116391044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 2 < arg_180_1.time_ and arg_180_1.time_ <= 2 + arg_183_0 then
				local var_183_0 = arg_180_1.bgs_.I05f

				arg_180_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_183_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_183_1 = var_183_0:GetComponent("SpriteRenderer")

				if var_183_1 and var_183_1.sprite then
					local var_183_2 = 2 * (var_183_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_183_0.transform.localScale = Vector3.New(var_183_2 / var_183_1.sprite.bounds.size.y < var_183_2 * manager.ui.mainCameraCom_.aspect / var_183_1.sprite.bounds.size.x and var_183_2 * manager.ui.mainCameraCom_.aspect / var_183_1.sprite.bounds.size.x or var_183_2 / var_183_1.sprite.bounds.size.y, var_183_2 / var_183_1.sprite.bounds.size.y < var_183_2 * manager.ui.mainCameraCom_.aspect / var_183_1.sprite.bounds.size.x and var_183_2 * manager.ui.mainCameraCom_.aspect / var_183_1.sprite.bounds.size.x or var_183_2 / var_183_1.sprite.bounds.size.y, 0)
				end

				for iter_183_0, iter_183_1 in pairs(arg_180_1.bgs_) do
					if iter_183_0 ~= "I05f" then
						iter_183_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_183_3 = arg_180_1.actors_["10024ui_story"].transform

			if 4 < arg_180_1.time_ and arg_180_1.time_ <= 4 + arg_183_0 then
				arg_180_1.var_.moveOldPos10024ui_story = var_183_3.localPosition
			end

			local var_183_4 = 0.001

			if 4 <= arg_180_1.time_ and arg_180_1.time_ < 4 + var_183_4 then
				var_183_3.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_180_1.time_ - 4) / var_183_4)
				var_183_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_3.position).x, (manager.ui.mainCamera.transform.position - var_183_3.position).y, (manager.ui.mainCamera.transform.position - var_183_3.position).z)
				var_183_3.localEulerAngles.z = 0
				var_183_3.localEulerAngles.x = 0
				var_183_3.localEulerAngles = var_183_3.localEulerAngles
			end

			if arg_180_1.time_ >= 4 + var_183_4 and arg_180_1.time_ < 4 + var_183_4 + arg_183_0 then
				var_183_3.localPosition = Vector3.New(0, -1, -6)
				var_183_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_3.position).x, (manager.ui.mainCamera.transform.position - var_183_3.position).y, (manager.ui.mainCamera.transform.position - var_183_3.position).z)
				var_183_3.localEulerAngles.z = 0
				var_183_3.localEulerAngles.x = 0
				var_183_3.localEulerAngles = var_183_3.localEulerAngles
			end

			if 4 < arg_180_1.time_ and arg_180_1.time_ <= 4 + arg_183_0 then
				arg_180_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 4 < arg_180_1.time_ and arg_180_1.time_ <= 4 + arg_183_0 then
				arg_180_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_183_5 = arg_180_1.actors_["10024ui_story"]

			if 4 < arg_180_1.time_ and arg_180_1.time_ <= 4 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.characterEffect10024ui_story == nil then
				arg_180_1.var_.characterEffect10024ui_story = var_183_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_6 = 0.2

			if 4 <= arg_180_1.time_ and arg_180_1.time_ < 4 + var_183_6 and not isNil(var_183_5) then
				if arg_180_1.var_.characterEffect10024ui_story and not isNil(var_183_5) then
					arg_180_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 4 + var_183_6 and arg_180_1.time_ < 4 + var_183_6 + arg_183_0 and not isNil(var_183_5) and arg_180_1.var_.characterEffect10024ui_story then
				arg_180_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_183_8 = 0

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_9 = 2

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_9 then
				local var_183_10 = Color.New(0, 0, 0)

				var_183_10.a = Mathf.Lerp(0, 1, (arg_180_1.time_ - var_183_8) / var_183_9)
				arg_180_1.mask_.color = var_183_10
			end

			if arg_180_1.time_ >= var_183_8 + var_183_9 and arg_180_1.time_ < var_183_8 + var_183_9 + arg_183_0 then
				local var_183_11 = Color.New(0, 0, 0)

				var_183_11.a = 1
				arg_180_1.mask_.color = var_183_11
			end

			local var_183_12 = 2

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_13 = 2

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_13 then
				local var_183_14 = Color.New(0, 0, 0)

				var_183_14.a = Mathf.Lerp(1, 0, (arg_180_1.time_ - var_183_12) / var_183_13)
				arg_180_1.mask_.color = var_183_14
			end

			if arg_180_1.time_ >= var_183_12 + var_183_13 and arg_180_1.time_ < var_183_12 + var_183_13 + arg_183_0 then
				local var_183_15 = Color.New(0, 0, 0)

				arg_180_1.mask_.enabled = false
				var_183_15.a = 0
				arg_180_1.mask_.color = var_183_15
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_16 = 4
			local var_183_17 = 0.875

			if 4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_18 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_18:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_19 = arg_180_1:GetWordFromCfg(116391043)
				local var_183_20 = arg_180_1:FormatText(var_183_19.content)

				arg_180_1.text_.text = var_183_20

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_22 = 35 <= 0 and var_183_17 or var_183_17 * (utf8.len(var_183_20) / 35)

				if (35 <= 0 and var_183_17 or var_183_17 * (utf8.len(var_183_20) / 35)) > 0 and var_183_17 < var_183_22 then
					arg_180_1.talkMaxDuration = var_183_22
					var_183_16 = var_183_16 + 0.3

					if var_183_22 + var_183_16 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_22 + var_183_16
					end
				end

				arg_180_1.text_.text = var_183_20
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391043", "story_v_out_116391.awb") ~= 0 then
					local var_183_23 = manager.audio:GetVoiceLength("story_v_out_116391", "116391043", "story_v_out_116391.awb") / 1000

					if var_183_23 + var_183_16 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_16
					end

					if var_183_19.prefab_name ~= "" and arg_180_1.actors_[var_183_19.prefab_name] ~= nil then
						local var_183_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_19.prefab_name].transform, "story_v_out_116391", "116391043", "story_v_out_116391.awb")

						arg_180_1:RecordAudio("116391043", var_183_24)
						arg_180_1:RecordAudio("116391043", var_183_24)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_116391", "116391043", "story_v_out_116391.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_116391", "116391043", "story_v_out_116391.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_25 = var_183_16 + 0.3
			local var_183_26 = math.max(var_183_17, arg_180_1.talkMaxDuration)

			if var_183_16 + 0.3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_25 + var_183_26 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_25) / var_183_26

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_25 + var_183_26 and arg_180_1.time_ < var_183_25 + var_183_26 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play116391044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 116391044
		arg_186_1.duration_ = 8.3

		local var_186_0 = {
			zh = 8.3,
			ja = 6.1
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
				arg_186_0:Play116391045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_189_0 = 0
			local var_189_1 = 0.775

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_2 = arg_186_1:GetWordFromCfg(116391044)
				local var_189_3 = arg_186_1:FormatText(var_189_2.content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 31 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 31)

				if (31 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 31)) > 0 and var_189_1 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5

					if var_189_5 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391044", "story_v_out_116391.awb") ~= 0 then
					local var_189_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391044", "story_v_out_116391.awb") / 1000

					if var_189_6 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_0
					end

					if var_189_2.prefab_name ~= "" and arg_186_1.actors_[var_189_2.prefab_name] ~= nil then
						local var_189_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_2.prefab_name].transform, "story_v_out_116391", "116391044", "story_v_out_116391.awb")

						arg_186_1:RecordAudio("116391044", var_189_7)
						arg_186_1:RecordAudio("116391044", var_189_7)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_116391", "116391044", "story_v_out_116391.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_116391", "116391044", "story_v_out_116391.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_8 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_8

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_8 and arg_186_1.time_ < var_189_0 + var_189_8 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play116391045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 116391045
		arg_190_1.duration_ = 16.7

		local var_190_0 = {
			zh = 10.4,
			ja = 16.7
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play116391046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_193_0 = 0
			local var_193_1 = 1.075

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_2 = arg_190_1:GetWordFromCfg(116391045)
				local var_193_3 = arg_190_1:FormatText(var_193_2.content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 43 <= 0 and var_193_1 or var_193_1 * (utf8.len(var_193_3) / 43)

				if (43 <= 0 and var_193_1 or var_193_1 * (utf8.len(var_193_3) / 43)) > 0 and var_193_1 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391045", "story_v_out_116391.awb") ~= 0 then
					local var_193_6 = manager.audio:GetVoiceLength("story_v_out_116391", "116391045", "story_v_out_116391.awb") / 1000

					if var_193_6 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_0
					end

					if var_193_2.prefab_name ~= "" and arg_190_1.actors_[var_193_2.prefab_name] ~= nil then
						local var_193_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_2.prefab_name].transform, "story_v_out_116391", "116391045", "story_v_out_116391.awb")

						arg_190_1:RecordAudio("116391045", var_193_7)
						arg_190_1:RecordAudio("116391045", var_193_7)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_116391", "116391045", "story_v_out_116391.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_116391", "116391045", "story_v_out_116391.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play116391046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 116391046
		arg_194_1.duration_ = 6

		local var_194_0 = {
			zh = 5.233,
			ja = 6
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
				arg_194_0:Play116391047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_197_0 = arg_194_1.actors_["10024ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect10024ui_story == nil then
				arg_194_1.var_.characterEffect10024ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_1 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_1 and not isNil(var_197_0) then
				if arg_194_1.var_.characterEffect10024ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect10024ui_story.fillFlat = true
					arg_194_1.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_1)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_1 and arg_194_1.time_ < 0 + var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect10024ui_story then
				arg_194_1.var_.characterEffect10024ui_story.fillFlat = true
				arg_194_1.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			local var_197_2 = arg_194_1.actors_["10025ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect10025ui_story == nil then
				arg_194_1.var_.characterEffect10025ui_story = var_197_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_3 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 and not isNil(var_197_2) then
				if arg_194_1.var_.characterEffect10025ui_story and not isNil(var_197_2) then
					arg_194_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect10025ui_story then
				arg_194_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_197_5 = arg_194_1.actors_["10024ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos10024ui_story = var_197_5.localPosition
			end

			local var_197_6 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_6 then
				var_197_5.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (arg_194_1.time_ - 0) / var_197_6)
				var_197_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_5.position).x, (manager.ui.mainCamera.transform.position - var_197_5.position).y, (manager.ui.mainCamera.transform.position - var_197_5.position).z)
				var_197_5.localEulerAngles.z = 0
				var_197_5.localEulerAngles.x = 0
				var_197_5.localEulerAngles = var_197_5.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_6 and arg_194_1.time_ < 0 + var_197_6 + arg_197_0 then
				var_197_5.localPosition = Vector3.New(-0.7, -1, -6)
				var_197_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_5.position).x, (manager.ui.mainCamera.transform.position - var_197_5.position).y, (manager.ui.mainCamera.transform.position - var_197_5.position).z)
				var_197_5.localEulerAngles.z = 0
				var_197_5.localEulerAngles.x = 0
				var_197_5.localEulerAngles = var_197_5.localEulerAngles
			end

			local var_197_7 = arg_194_1.actors_["10025ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos10025ui_story = var_197_7.localPosition
			end

			local var_197_8 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_8 then
				var_197_7.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (arg_194_1.time_ - 0) / var_197_8)
				var_197_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_7.position).x, (manager.ui.mainCamera.transform.position - var_197_7.position).y, (manager.ui.mainCamera.transform.position - var_197_7.position).z)
				var_197_7.localEulerAngles.z = 0
				var_197_7.localEulerAngles.x = 0
				var_197_7.localEulerAngles = var_197_7.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_8 and arg_194_1.time_ < 0 + var_197_8 + arg_197_0 then
				var_197_7.localPosition = Vector3.New(0.7, -1.1, -5.9)
				var_197_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_7.position).x, (manager.ui.mainCamera.transform.position - var_197_7.position).y, (manager.ui.mainCamera.transform.position - var_197_7.position).z)
				var_197_7.localEulerAngles.z = 0
				var_197_7.localEulerAngles.x = 0
				var_197_7.localEulerAngles = var_197_7.localEulerAngles
			end

			local var_197_9 = 0
			local var_197_10 = 0.525

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_9 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_11 = arg_194_1:GetWordFromCfg(116391046)
				local var_197_12 = arg_194_1:FormatText(var_197_11.content)

				arg_194_1.text_.text = var_197_12

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_14 = 21 <= 0 and var_197_10 or var_197_10 * (utf8.len(var_197_12) / 21)

				if (21 <= 0 and var_197_10 or var_197_10 * (utf8.len(var_197_12) / 21)) > 0 and var_197_10 < var_197_14 then
					arg_194_1.talkMaxDuration = var_197_14

					if var_197_14 + var_197_9 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_9
					end
				end

				arg_194_1.text_.text = var_197_12
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391046", "story_v_out_116391.awb") ~= 0 then
					local var_197_15 = manager.audio:GetVoiceLength("story_v_out_116391", "116391046", "story_v_out_116391.awb") / 1000

					if var_197_15 + var_197_9 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_15 + var_197_9
					end

					if var_197_11.prefab_name ~= "" and arg_194_1.actors_[var_197_11.prefab_name] ~= nil then
						local var_197_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_11.prefab_name].transform, "story_v_out_116391", "116391046", "story_v_out_116391.awb")

						arg_194_1:RecordAudio("116391046", var_197_16)
						arg_194_1:RecordAudio("116391046", var_197_16)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_116391", "116391046", "story_v_out_116391.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_116391", "116391046", "story_v_out_116391.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_17 = math.max(var_197_10, arg_194_1.talkMaxDuration)

			if var_197_9 <= arg_194_1.time_ and arg_194_1.time_ < var_197_9 + var_197_17 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_9) / var_197_17

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_9 + var_197_17 and arg_194_1.time_ < var_197_9 + var_197_17 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play116391047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 116391047
		arg_198_1.duration_ = 2.53

		local var_198_0 = {
			zh = 2.399999999999,
			ja = 2.533
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
				arg_198_0:Play116391048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_201_0 = arg_198_1.actors_["10024ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect10024ui_story == nil then
				arg_198_1.var_.characterEffect10024ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_1 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_1 and not isNil(var_201_0) then
				if arg_198_1.var_.characterEffect10024ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_1 and arg_198_1.time_ < 0 + var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect10024ui_story then
				arg_198_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_201_3 = arg_198_1.actors_["10025ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect10025ui_story == nil then
				arg_198_1.var_.characterEffect10025ui_story = var_201_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_4 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 and not isNil(var_201_3) then
				if arg_198_1.var_.characterEffect10025ui_story and not isNil(var_201_3) then
					arg_198_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_198_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_4)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect10025ui_story then
				arg_198_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_198_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_201_5 = 0
			local var_201_6 = 0.05

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:GetWordFromCfg(116391047)
				local var_201_8 = arg_198_1:FormatText(var_201_7.content)

				arg_198_1.text_.text = var_201_8

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_10 = 2 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 2)

				if (2 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 2)) > 0 and var_201_6 < var_201_10 then
					arg_198_1.talkMaxDuration = var_201_10

					if var_201_10 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_8
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391047", "story_v_out_116391.awb") ~= 0 then
					local var_201_11 = manager.audio:GetVoiceLength("story_v_out_116391", "116391047", "story_v_out_116391.awb") / 1000

					if var_201_11 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_11 + var_201_5
					end

					if var_201_7.prefab_name ~= "" and arg_198_1.actors_[var_201_7.prefab_name] ~= nil then
						local var_201_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_7.prefab_name].transform, "story_v_out_116391", "116391047", "story_v_out_116391.awb")

						arg_198_1:RecordAudio("116391047", var_201_12)
						arg_198_1:RecordAudio("116391047", var_201_12)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_116391", "116391047", "story_v_out_116391.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_116391", "116391047", "story_v_out_116391.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_13 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_13 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_13

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_13 and arg_198_1.time_ < var_201_5 + var_201_13 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play116391048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 116391048
		arg_202_1.duration_ = 14.67

		local var_202_0 = {
			zh = 14.666,
			ja = 14.2
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
				arg_202_0:Play116391049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if arg_202_1.bgs_.SK0209 == nil then
				local var_205_0 = Object.Instantiate(arg_202_1.paintGo_)

				var_205_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0209")
				var_205_0.name = "SK0209"
				var_205_0.transform.parent = arg_202_1.stage_.transform
				var_205_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.bgs_.SK0209 = var_205_0
			end

			if 2 < arg_202_1.time_ and arg_202_1.time_ <= 2 + arg_205_0 then
				local var_205_1 = arg_202_1.bgs_.SK0209

				arg_202_1.bgs_.SK0209.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_205_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_205_2 = var_205_1:GetComponent("SpriteRenderer")

				if var_205_2 and var_205_2.sprite then
					local var_205_3 = 2 * (var_205_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_205_1.transform.localScale = Vector3.New(var_205_3 / var_205_2.sprite.bounds.size.y < var_205_3 * manager.ui.mainCameraCom_.aspect / var_205_2.sprite.bounds.size.x and var_205_3 * manager.ui.mainCameraCom_.aspect / var_205_2.sprite.bounds.size.x or var_205_3 / var_205_2.sprite.bounds.size.y, var_205_3 / var_205_2.sprite.bounds.size.y < var_205_3 * manager.ui.mainCameraCom_.aspect / var_205_2.sprite.bounds.size.x and var_205_3 * manager.ui.mainCameraCom_.aspect / var_205_2.sprite.bounds.size.x or var_205_3 / var_205_2.sprite.bounds.size.y, 0)
				end

				for iter_205_0, iter_205_1 in pairs(arg_202_1.bgs_) do
					if iter_205_0 ~= "SK0209" then
						iter_205_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_205_4 = 0

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.mask_.enabled = true
				arg_202_1.mask_.raycastTarget = true

				arg_202_1:SetGaussion(false)
			end

			local var_205_5 = 2

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_5 then
				local var_205_6 = Color.New(0, 0, 0)

				var_205_6.a = Mathf.Lerp(0, 1, (arg_202_1.time_ - var_205_4) / var_205_5)
				arg_202_1.mask_.color = var_205_6
			end

			if arg_202_1.time_ >= var_205_4 + var_205_5 and arg_202_1.time_ < var_205_4 + var_205_5 + arg_205_0 then
				local var_205_7 = Color.New(0, 0, 0)

				var_205_7.a = 1
				arg_202_1.mask_.color = var_205_7
			end

			local var_205_8 = 2

			if 2 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.mask_.enabled = true
				arg_202_1.mask_.raycastTarget = true

				arg_202_1:SetGaussion(false)
			end

			local var_205_9 = 2

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_9 then
				local var_205_10 = Color.New(1, 1, 1)

				var_205_10.a = Mathf.Lerp(1, 0, (arg_202_1.time_ - var_205_8) / var_205_9)
				arg_202_1.mask_.color = var_205_10
			end

			if arg_202_1.time_ >= var_205_8 + var_205_9 and arg_202_1.time_ < var_205_8 + var_205_9 + arg_205_0 then
				local var_205_11 = Color.New(1, 1, 1)

				arg_202_1.mask_.enabled = false
				var_205_11.a = 0
				arg_202_1.mask_.color = var_205_11
			end

			local var_205_12 = arg_202_1.actors_["10024ui_story"].transform

			if 2 < arg_202_1.time_ and arg_202_1.time_ <= 2 + arg_205_0 then
				arg_202_1.var_.moveOldPos10024ui_story = var_205_12.localPosition
			end

			local var_205_13 = 0.001

			if 2 <= arg_202_1.time_ and arg_202_1.time_ < 2 + var_205_13 then
				var_205_12.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 2) / var_205_13)
				var_205_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_12.position).x, (manager.ui.mainCamera.transform.position - var_205_12.position).y, (manager.ui.mainCamera.transform.position - var_205_12.position).z)
				var_205_12.localEulerAngles.z = 0
				var_205_12.localEulerAngles.x = 0
				var_205_12.localEulerAngles = var_205_12.localEulerAngles
			end

			if arg_202_1.time_ >= 2 + var_205_13 and arg_202_1.time_ < 2 + var_205_13 + arg_205_0 then
				var_205_12.localPosition = Vector3.New(0, 100, 0)
				var_205_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_12.position).x, (manager.ui.mainCamera.transform.position - var_205_12.position).y, (manager.ui.mainCamera.transform.position - var_205_12.position).z)
				var_205_12.localEulerAngles.z = 0
				var_205_12.localEulerAngles.x = 0
				var_205_12.localEulerAngles = var_205_12.localEulerAngles
			end

			local var_205_14 = arg_202_1.actors_["10025ui_story"].transform

			if 2 < arg_202_1.time_ and arg_202_1.time_ <= 2 + arg_205_0 then
				arg_202_1.var_.moveOldPos10025ui_story = var_205_14.localPosition
			end

			local var_205_15 = 0.001

			if 2 <= arg_202_1.time_ and arg_202_1.time_ < 2 + var_205_15 then
				var_205_14.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 2) / var_205_15)
				var_205_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_14.position).x, (manager.ui.mainCamera.transform.position - var_205_14.position).y, (manager.ui.mainCamera.transform.position - var_205_14.position).z)
				var_205_14.localEulerAngles.z = 0
				var_205_14.localEulerAngles.x = 0
				var_205_14.localEulerAngles = var_205_14.localEulerAngles
			end

			if arg_202_1.time_ >= 2 + var_205_15 and arg_202_1.time_ < 2 + var_205_15 + arg_205_0 then
				var_205_14.localPosition = Vector3.New(0, 100, 0)
				var_205_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_14.position).x, (manager.ui.mainCamera.transform.position - var_205_14.position).y, (manager.ui.mainCamera.transform.position - var_205_14.position).z)
				var_205_14.localEulerAngles.z = 0
				var_205_14.localEulerAngles.x = 0
				var_205_14.localEulerAngles = var_205_14.localEulerAngles
			end

			local var_205_16 = arg_202_1.bgs_.SK0209.transform

			if 2 < arg_202_1.time_ and arg_202_1.time_ <= 2 + arg_205_0 then
				arg_202_1.var_.moveOldPosSK0209 = var_205_16.localPosition
			end

			local var_205_17 = 3

			if 2 <= arg_202_1.time_ and arg_202_1.time_ < 2 + var_205_17 then
				var_205_16.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPosSK0209, Vector3.New(0, 1, 9.5), (arg_202_1.time_ - 2) / var_205_17)
			end

			if arg_202_1.time_ >= 2 + var_205_17 and arg_202_1.time_ < 2 + var_205_17 + arg_205_0 then
				var_205_16.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_205_18 = 4

			if 4 < arg_202_1.time_ and arg_202_1.time_ <= var_205_18 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			if arg_202_1.time_ >= var_205_18 + 1 and arg_202_1.time_ < var_205_18 + 1 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			if arg_202_1.frameCnt_ <= 1 then
				arg_202_1.dialog_:SetActive(false)
			end

			local var_205_19 = 4
			local var_205_20 = 0.8

			if 4 < arg_202_1.time_ and arg_202_1.time_ <= var_205_19 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0

				arg_202_1.dialog_:SetActive(true)

				arg_202_1.dialogCg_.alpha = 0

				local var_205_21 = LeanTween.value(arg_202_1.dialog_, 0, 1, 0.3)

				var_205_21:setOnUpdate(LuaHelper.FloatAction(function(arg_206_0)
					arg_202_1.dialogCg_.alpha = arg_206_0
				end))
				var_205_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_202_1.dialog_)
					var_205_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_202_1.duration_ = arg_202_1.duration_ + 0.3

				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_22 = arg_202_1:GetWordFromCfg(116391048)
				local var_205_23 = arg_202_1:FormatText(var_205_22.content)

				arg_202_1.text_.text = var_205_23

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_25 = 32 <= 0 and var_205_20 or var_205_20 * (utf8.len(var_205_23) / 32)

				if (32 <= 0 and var_205_20 or var_205_20 * (utf8.len(var_205_23) / 32)) > 0 and var_205_20 < var_205_25 then
					arg_202_1.talkMaxDuration = var_205_25
					var_205_19 = var_205_19 + 0.3

					if var_205_25 + var_205_19 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_25 + var_205_19
					end
				end

				arg_202_1.text_.text = var_205_23
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391048", "story_v_out_116391.awb") ~= 0 then
					local var_205_26 = manager.audio:GetVoiceLength("story_v_out_116391", "116391048", "story_v_out_116391.awb") / 1000

					if var_205_26 + var_205_19 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_26 + var_205_19
					end

					if var_205_22.prefab_name ~= "" and arg_202_1.actors_[var_205_22.prefab_name] ~= nil then
						local var_205_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_22.prefab_name].transform, "story_v_out_116391", "116391048", "story_v_out_116391.awb")

						arg_202_1:RecordAudio("116391048", var_205_27)
						arg_202_1:RecordAudio("116391048", var_205_27)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_116391", "116391048", "story_v_out_116391.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_116391", "116391048", "story_v_out_116391.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_28 = var_205_19 + 0.3
			local var_205_29 = math.max(var_205_20, arg_202_1.talkMaxDuration)

			if var_205_19 + 0.3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_28 + var_205_29 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_28) / var_205_29

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_28 + var_205_29 and arg_202_1.time_ < var_205_28 + var_205_29 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "SK0209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play116391049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 116391049
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play116391050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_211_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_208_1.bgmTxt_.text ~= var_211_2 and arg_208_1.bgmTxt_.text ~= "" then
						if arg_208_1.bgmTxt2_.text ~= "" then
							arg_208_1.bgmTxt_.text = arg_208_1.bgmTxt2_.text
						end

						arg_208_1.bgmTxt2_.text = var_211_2

						arg_208_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_208_1.bgmTxt_.text = var_211_2
						arg_208_1.bgmTxt2_.text = var_211_2
					end

					if arg_208_1.bgmTimer then
						arg_208_1.bgmTimer:Stop()

						arg_208_1.bgmTimer = nil
					end

					if arg_208_1.settingData.show_music_name == 1 then
						arg_208_1.musicController:SetSelectedState("show")
						arg_208_1.musicAnimator_:Play("open", 0, 0)

						if arg_208_1.settingData.music_time ~= 0 then
							arg_208_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_208_1.settingData.music_time), function()
								if arg_208_1 == nil or isNil(arg_208_1.bgmTxt_) then
									return
								end

								arg_208_1.musicController:SetSelectedState("hide")
								arg_208_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_211_3 = 0
			local var_211_4 = 0.825

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_3 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_5 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(116391049).content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_7 = 33 <= 0 and var_211_4 or var_211_4 * (utf8.len(var_211_5) / 33)

				if (33 <= 0 and var_211_4 or var_211_4 * (utf8.len(var_211_5) / 33)) > 0 and var_211_4 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_3 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_3
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_8 = math.max(var_211_4, arg_208_1.talkMaxDuration)

			if var_211_3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_3 + var_211_8 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_3) / var_211_8

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_3 + var_211_8 and arg_208_1.time_ < var_211_3 + var_211_8 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play116391050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116391050
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play116391051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 1.7

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(116391050).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 68 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 68)

				if (68 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 68)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play116391051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116391051
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play116391052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.175

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(116391051).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 47 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 47)

				if (47 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 47)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play116391052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 116391052
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play116391053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.05

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(116391052).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 42 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 42)

				if (42 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 42)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play116391053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 116391053
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play116391054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.525

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(116391053).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 21 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 21)

				if (21 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 21)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play116391054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 116391054
		arg_229_1.duration_ = 20.63

		local var_229_0 = {
			zh = 17,
			ja = 20.633
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
				arg_229_0:Play116391055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if arg_229_1.bgs_.SK0209a == nil then
				local var_232_0 = Object.Instantiate(arg_229_1.paintGo_)

				var_232_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0209a")
				var_232_0.name = "SK0209a"
				var_232_0.transform.parent = arg_229_1.stage_.transform
				var_232_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.bgs_.SK0209a = var_232_0
			end

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= 2 + arg_232_0 then
				local var_232_1 = arg_229_1.bgs_.SK0209a

				arg_229_1.bgs_.SK0209a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_2 = var_232_1:GetComponent("SpriteRenderer")

				if var_232_2 and var_232_2.sprite then
					local var_232_3 = 2 * (var_232_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_1.transform.localScale = Vector3.New(var_232_3 / var_232_2.sprite.bounds.size.y < var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x and var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x or var_232_3 / var_232_2.sprite.bounds.size.y, var_232_3 / var_232_2.sprite.bounds.size.y < var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x and var_232_3 * manager.ui.mainCameraCom_.aspect / var_232_2.sprite.bounds.size.x or var_232_3 / var_232_2.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "SK0209a" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_4 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_5 = 2

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_5 then
				local var_232_6 = Color.New(0, 0, 0)

				var_232_6.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_4) / var_232_5)
				arg_229_1.mask_.color = var_232_6
			end

			if arg_229_1.time_ >= var_232_4 + var_232_5 and arg_229_1.time_ < var_232_4 + var_232_5 + arg_232_0 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = 1
				arg_229_1.mask_.color = var_232_7
			end

			local var_232_8 = 2

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_9 = 2

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 then
				local var_232_10 = Color.New(0, 0, 0)

				var_232_10.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_8) / var_232_9)
				arg_229_1.mask_.color = var_232_10
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 then
				local var_232_11 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_11.a = 0
				arg_229_1.mask_.color = var_232_11
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_12 = 4
			local var_232_13 = 1.125

			if 4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_14 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_14:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_15 = arg_229_1:GetWordFromCfg(116391054)
				local var_232_16 = arg_229_1:FormatText(var_232_15.content)

				arg_229_1.text_.text = var_232_16

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_18 = 45 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_16) / 45)

				if (45 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_16) / 45)) > 0 and var_232_13 < var_232_18 then
					arg_229_1.talkMaxDuration = var_232_18
					var_232_12 = var_232_12 + 0.3

					if var_232_18 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_16
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391054", "story_v_out_116391.awb") ~= 0 then
					local var_232_19 = manager.audio:GetVoiceLength("story_v_out_116391", "116391054", "story_v_out_116391.awb") / 1000

					if var_232_19 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_12
					end

					if var_232_15.prefab_name ~= "" and arg_229_1.actors_[var_232_15.prefab_name] ~= nil then
						local var_232_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_15.prefab_name].transform, "story_v_out_116391", "116391054", "story_v_out_116391.awb")

						arg_229_1:RecordAudio("116391054", var_232_20)
						arg_229_1:RecordAudio("116391054", var_232_20)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_116391", "116391054", "story_v_out_116391.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_116391", "116391054", "story_v_out_116391.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_21 = var_232_12 + 0.3
			local var_232_22 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_21 + var_232_22 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_21) / var_232_22

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_21 + var_232_22 and arg_229_1.time_ < var_232_21 + var_232_22 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play116391055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116391055
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play116391056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.325

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(116391055).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 13 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 13)

				if (13 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 13)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play116391056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116391056
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play116391057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.95

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(116391056).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 38 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 38)

				if (38 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 38)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play116391057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116391057
		arg_243_1.duration_ = 4.07

		local var_243_0 = {
			zh = 4.066,
			ja = 1.166
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play116391058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_246_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_243_1.bgmTxt_.text ~= var_246_2 and arg_243_1.bgmTxt_.text ~= "" then
						if arg_243_1.bgmTxt2_.text ~= "" then
							arg_243_1.bgmTxt_.text = arg_243_1.bgmTxt2_.text
						end

						arg_243_1.bgmTxt2_.text = var_246_2

						arg_243_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_243_1.bgmTxt_.text = var_246_2
						arg_243_1.bgmTxt2_.text = var_246_2
					end

					if arg_243_1.bgmTimer then
						arg_243_1.bgmTimer:Stop()

						arg_243_1.bgmTimer = nil
					end

					if arg_243_1.settingData.show_music_name == 1 then
						arg_243_1.musicController:SetSelectedState("show")
						arg_243_1.musicAnimator_:Play("open", 0, 0)

						if arg_243_1.settingData.music_time ~= 0 then
							arg_243_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_243_1.settingData.music_time), function()
								if arg_243_1 == nil or isNil(arg_243_1.bgmTxt_) then
									return
								end

								arg_243_1.musicController:SetSelectedState("hide")
								arg_243_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_243_1.time_ and arg_243_1.time_ <= 0.4 + arg_246_0 then
				arg_243_1:AudioAction("play", "music", "bgm_activity_1_6_ui", "bgm_activity_1_6_ui", "bgm_activity_1_6_ui.awb")

				local var_246_5 = manager.audio:GetAudioName("bgm_activity_1_6_ui", "bgm_activity_1_6_ui")

				if "" ~= "" then
					if arg_243_1.bgmTxt_.text ~= var_246_5 and arg_243_1.bgmTxt_.text ~= "" then
						if arg_243_1.bgmTxt2_.text ~= "" then
							arg_243_1.bgmTxt_.text = arg_243_1.bgmTxt2_.text
						end

						arg_243_1.bgmTxt2_.text = var_246_5

						arg_243_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_243_1.bgmTxt_.text = var_246_5
						arg_243_1.bgmTxt2_.text = var_246_5
					end

					if arg_243_1.bgmTimer then
						arg_243_1.bgmTimer:Stop()

						arg_243_1.bgmTimer = nil
					end

					if arg_243_1.settingData.show_music_name == 1 then
						arg_243_1.musicController:SetSelectedState("show")
						arg_243_1.musicAnimator_:Play("open", 0, 0)

						if arg_243_1.settingData.music_time ~= 0 then
							arg_243_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_243_1.settingData.music_time), function()
								if arg_243_1 == nil or isNil(arg_243_1.bgmTxt_) then
									return
								end

								arg_243_1.musicController:SetSelectedState("hide")
								arg_243_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_246_6 = 0
			local var_246_7 = 0.175

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_8 = arg_243_1:GetWordFromCfg(116391057)
				local var_246_9 = arg_243_1:FormatText(var_246_8.content)

				arg_243_1.text_.text = var_246_9

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 7 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 7)

				if (7 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 7)) > 0 and var_246_7 < var_246_11 then
					arg_243_1.talkMaxDuration = var_246_11

					if var_246_11 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_9
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391057", "story_v_out_116391.awb") ~= 0 then
					local var_246_12 = manager.audio:GetVoiceLength("story_v_out_116391", "116391057", "story_v_out_116391.awb") / 1000

					if var_246_12 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_6
					end

					if var_246_8.prefab_name ~= "" and arg_243_1.actors_[var_246_8.prefab_name] ~= nil then
						local var_246_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_8.prefab_name].transform, "story_v_out_116391", "116391057", "story_v_out_116391.awb")

						arg_243_1:RecordAudio("116391057", var_246_13)
						arg_243_1:RecordAudio("116391057", var_246_13)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_116391", "116391057", "story_v_out_116391.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_116391", "116391057", "story_v_out_116391.awb")
				end

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
	Play116391058 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 116391058
		arg_249_1.duration_ = 5.9

		local var_249_0 = {
			zh = 5.9,
			ja = 2.8
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play116391059(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.65

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(116391058)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 26 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 26)

				if (26 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 26)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391058", "story_v_out_116391.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_116391", "116391058", "story_v_out_116391.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_116391", "116391058", "story_v_out_116391.awb")

						arg_249_1:RecordAudio("116391058", var_252_6)
						arg_249_1:RecordAudio("116391058", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_116391", "116391058", "story_v_out_116391.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_116391", "116391058", "story_v_out_116391.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play116391059 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 116391059
		arg_253_1.duration_ = 5.73

		local var_253_0 = {
			zh = 5.733,
			ja = 5
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play116391060(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.6

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(116391059)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 24 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 24)

				if (24 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 24)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391059", "story_v_out_116391.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_116391", "116391059", "story_v_out_116391.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_116391", "116391059", "story_v_out_116391.awb")

						arg_253_1:RecordAudio("116391059", var_256_6)
						arg_253_1:RecordAudio("116391059", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_116391", "116391059", "story_v_out_116391.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_116391", "116391059", "story_v_out_116391.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play116391060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 116391060
		arg_257_1.duration_ = 8.9

		local var_257_0 = {
			zh = 7.7,
			ja = 8.9
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play116391061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_260_0 = 0.6

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				local var_260_1, var_260_2 = math.modf((arg_257_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_260_2 * 0.13, var_260_2 * 0.13, var_260_2 * 0.13) + arg_257_1.var_.shakeOldPos
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				manager.ui.mainCamera.transform.localPosition = arg_257_1.var_.shakeOldPos
			end

			local var_260_3 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_3 + arg_260_0 then
				arg_257_1.allBtn_.enabled = false
			end

			if arg_257_1.time_ >= var_260_3 + 0.6 and arg_257_1.time_ < var_260_3 + 0.6 + arg_260_0 then
				arg_257_1.allBtn_.enabled = true
			end

			local var_260_4 = 0
			local var_260_5 = 0.525

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(116391060)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 21 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 21)

				if (21 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 21)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391060", "story_v_out_116391.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_116391", "116391060", "story_v_out_116391.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_116391", "116391060", "story_v_out_116391.awb")

						arg_257_1:RecordAudio("116391060", var_260_11)
						arg_257_1:RecordAudio("116391060", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_116391", "116391060", "story_v_out_116391.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_116391", "116391060", "story_v_out_116391.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play116391061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 116391061
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play116391062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.925

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(116391061).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 37 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 37)

				if (37 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 37)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play116391062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 116391062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play116391063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPosSK0209a = arg_265_1.bgs_.SK0209a.transform.localPosition
			end

			local var_268_0 = 3

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.bgs_.SK0209a.transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPosSK0209a, Vector3.New(0, 1, 9.5), (arg_265_1.time_ - 0) / var_268_0)
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.bgs_.SK0209a.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_268_1 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_1 + 3 and arg_265_1.time_ < var_268_1 + 3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_2 = 0
			local var_268_3 = 1.225

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(116391062).content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_6 = 49 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 49)

				if (49 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 49)) > 0 and var_268_3 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_7 and arg_265_1.time_ < var_268_2 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0209a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play116391063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 116391063
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play116391064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.875

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(116391063).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 35 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 35)

				if (35 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 35)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play116391064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 116391064
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play116391065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.95

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(116391064).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 38 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 38)

				if (38 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 38)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play116391065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 116391065
		arg_277_1.duration_ = 152.3

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play116391074(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 2 < arg_277_1.time_ and arg_277_1.time_ <= 2 + arg_280_0 then
				SetActive(arg_277_1.dialog_, false)
				SetActive(arg_277_1.allBtn_.gameObject, false)
				arg_277_1.hideBtnsController_:SetSelectedIndex(1)
				manager.video:Play("SofdecAsset/story/101163901.usm", function(arg_281_0)
					if arg_277_1.state_ == "playing" then
						arg_277_1:JumpToEnd()
					end

					if arg_277_1.playNext_ and not arg_277_1.auto_ then
						arg_277_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_282_0)
					arg_277_1.state_ = arg_282_0 and "pause" or "playing"
				end, 101163901)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_280_0 = 150.3

			if 2 <= arg_277_1.time_ and arg_277_1.time_ < 2 + var_280_0 then
				-- block empty
			end

			if arg_277_1.time_ >= 2 + var_280_0 and arg_277_1.time_ < 2 + var_280_0 + arg_280_0 then
				-- block empty
			end

			local var_280_1 = 0

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_2 = 2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 then
				local var_280_3 = Color.New(0, 0, 0)

				var_280_3.a = Mathf.Lerp(0, 1, (arg_277_1.time_ - var_280_1) / var_280_2)
				arg_277_1.mask_.color = var_280_3
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 then
				local var_280_4 = Color.New(0, 0, 0)

				var_280_4.a = 1
				arg_277_1.mask_.color = var_280_4
			end

			local var_280_5 = 2

			if 2 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.mask_.enabled = true
				arg_277_1.mask_.raycastTarget = true

				arg_277_1:SetGaussion(false)
			end

			local var_280_6 = 0.0166666666666667

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_6 then
				local var_280_7 = Color.New(0, 0, 0)

				var_280_7.a = Mathf.Lerp(1, 0, (arg_277_1.time_ - var_280_5) / var_280_6)
				arg_277_1.mask_.color = var_280_7
			end

			if arg_277_1.time_ >= var_280_5 + var_280_6 and arg_277_1.time_ < var_280_5 + var_280_6 + arg_280_0 then
				local var_280_8 = Color.New(0, 0, 0)

				arg_277_1.mask_.enabled = false
				var_280_8.a = 0
				arg_277_1.mask_.color = var_280_8
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play116391074 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 116391074
		arg_283_1.duration_ = 10

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play116391075(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				local var_286_0 = arg_283_1.bgs_.I05f

				arg_283_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_286_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_286_1 = var_286_0:GetComponent("SpriteRenderer")

				if var_286_1 and var_286_1.sprite then
					local var_286_2 = 2 * (var_286_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_286_0.transform.localScale = Vector3.New(var_286_2 / var_286_1.sprite.bounds.size.y < var_286_2 * manager.ui.mainCameraCom_.aspect / var_286_1.sprite.bounds.size.x and var_286_2 * manager.ui.mainCameraCom_.aspect / var_286_1.sprite.bounds.size.x or var_286_2 / var_286_1.sprite.bounds.size.y, var_286_2 / var_286_1.sprite.bounds.size.y < var_286_2 * manager.ui.mainCameraCom_.aspect / var_286_1.sprite.bounds.size.x and var_286_2 * manager.ui.mainCameraCom_.aspect / var_286_1.sprite.bounds.size.x or var_286_2 / var_286_1.sprite.bounds.size.y, 0)
				end

				for iter_286_0, iter_286_1 in pairs(arg_283_1.bgs_) do
					if iter_286_0 ~= "I05f" then
						iter_286_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_286_3 = arg_283_1.actors_["10024ui_story"].transform

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= 2 + arg_286_0 then
				arg_283_1.var_.moveOldPos10024ui_story = var_286_3.localPosition
			end

			local var_286_4 = 0.001

			if 2 <= arg_283_1.time_ and arg_283_1.time_ < 2 + var_286_4 then
				var_286_3.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_283_1.time_ - 2) / var_286_4)
				var_286_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_3.position).x, (manager.ui.mainCamera.transform.position - var_286_3.position).y, (manager.ui.mainCamera.transform.position - var_286_3.position).z)
				var_286_3.localEulerAngles.z = 0
				var_286_3.localEulerAngles.x = 0
				var_286_3.localEulerAngles = var_286_3.localEulerAngles
			end

			if arg_283_1.time_ >= 2 + var_286_4 and arg_283_1.time_ < 2 + var_286_4 + arg_286_0 then
				var_286_3.localPosition = Vector3.New(0, -1, -6)
				var_286_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_3.position).x, (manager.ui.mainCamera.transform.position - var_286_3.position).y, (manager.ui.mainCamera.transform.position - var_286_3.position).z)
				var_286_3.localEulerAngles.z = 0
				var_286_3.localEulerAngles.x = 0
				var_286_3.localEulerAngles = var_286_3.localEulerAngles
			end

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= 2 + arg_286_0 then
				arg_283_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action4_1")
			end

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= 2 + arg_286_0 then
				arg_283_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_286_5 = arg_283_1.actors_["10024ui_story"]

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= 2 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.characterEffect10024ui_story == nil then
				arg_283_1.var_.characterEffect10024ui_story = var_286_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_6 = 0.2

			if 2 <= arg_283_1.time_ and arg_283_1.time_ < 2 + var_286_6 and not isNil(var_286_5) then
				if arg_283_1.var_.characterEffect10024ui_story and not isNil(var_286_5) then
					arg_283_1.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 2 + var_286_6 and arg_283_1.time_ < 2 + var_286_6 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.characterEffect10024ui_story then
				arg_283_1.var_.characterEffect10024ui_story.fillFlat = false
			end

			local var_286_8 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.mask_.enabled = true
				arg_283_1.mask_.raycastTarget = true

				arg_283_1:SetGaussion(false)
			end

			local var_286_9 = 2

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_9 then
				local var_286_10 = Color.New(0, 0, 0)

				var_286_10.a = Mathf.Lerp(1, 0, (arg_283_1.time_ - var_286_8) / var_286_9)
				arg_283_1.mask_.color = var_286_10
			end

			if arg_283_1.time_ >= var_286_8 + var_286_9 and arg_283_1.time_ < var_286_8 + var_286_9 + arg_286_0 then
				local var_286_11 = Color.New(0, 0, 0)

				arg_283_1.mask_.enabled = false
				var_286_11.a = 0
				arg_283_1.mask_.color = var_286_11
			end

			local var_286_12 = 0

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_12 + arg_286_0 then
				SetActive(arg_283_1.dialog_, false)
				SetActive(arg_283_1.allBtn_.gameObject, true)
				arg_283_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_283_1.isInLoopVideo = false
			end

			local var_286_13 = 0.0166666666666667

			if var_286_12 <= arg_283_1.time_ and arg_283_1.time_ < var_286_12 + var_286_13 then
				-- block empty
			end

			if arg_283_1.time_ >= var_286_12 + var_286_13 and arg_283_1.time_ < var_286_12 + var_286_13 + arg_286_0 then
				-- block empty
			end

			if arg_283_1.frameCnt_ <= 1 then
				arg_283_1.dialog_:SetActive(false)
			end

			local var_286_14 = 2
			local var_286_15 = 0.325

			if 2 < arg_283_1.time_ and arg_283_1.time_ <= var_286_14 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0

				arg_283_1.dialog_:SetActive(true)

				arg_283_1.dialogCg_.alpha = 0

				local var_286_16 = LeanTween.value(arg_283_1.dialog_, 0, 1, 0.3)

				var_286_16:setOnUpdate(LuaHelper.FloatAction(function(arg_287_0)
					arg_283_1.dialogCg_.alpha = arg_287_0
				end))
				var_286_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_283_1.dialog_)
					var_286_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_283_1.duration_ = arg_283_1.duration_ + 0.3

				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_17 = arg_283_1:GetWordFromCfg(116391074)
				local var_286_18 = arg_283_1:FormatText(var_286_17.content)

				arg_283_1.text_.text = var_286_18

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_20 = 13 <= 0 and var_286_15 or var_286_15 * (utf8.len(var_286_18) / 13)

				if (13 <= 0 and var_286_15 or var_286_15 * (utf8.len(var_286_18) / 13)) > 0 and var_286_15 < var_286_20 then
					arg_283_1.talkMaxDuration = var_286_20
					var_286_14 = var_286_14 + 0.3

					if var_286_20 + var_286_14 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_20 + var_286_14
					end
				end

				arg_283_1.text_.text = var_286_18
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391074", "story_v_out_116391.awb") ~= 0 then
					local var_286_21 = manager.audio:GetVoiceLength("story_v_out_116391", "116391074", "story_v_out_116391.awb") / 1000

					if var_286_21 + var_286_14 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_21 + var_286_14
					end

					if var_286_17.prefab_name ~= "" and arg_283_1.actors_[var_286_17.prefab_name] ~= nil then
						local var_286_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_17.prefab_name].transform, "story_v_out_116391", "116391074", "story_v_out_116391.awb")

						arg_283_1:RecordAudio("116391074", var_286_22)
						arg_283_1:RecordAudio("116391074", var_286_22)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_116391", "116391074", "story_v_out_116391.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_116391", "116391074", "story_v_out_116391.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_23 = var_286_14 + 0.3
			local var_286_24 = math.max(var_286_15, arg_283_1.talkMaxDuration)

			if var_286_14 + 0.3 <= arg_283_1.time_ and arg_283_1.time_ < var_286_23 + var_286_24 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_23) / var_286_24

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_23 + var_286_24 and arg_283_1.time_ < var_286_23 + var_286_24 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play116391075 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 116391075
		arg_289_1.duration_ = 15.93

		local var_289_0 = {
			zh = 9.466,
			ja = 15.933
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play116391076(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10024ui_story = arg_289_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10024ui_story"].transform.position).z)
				arg_289_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10024ui_story"].transform.localEulerAngles = arg_289_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_289_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10024ui_story"].transform.position).z)
				arg_289_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10024ui_story"].transform.localEulerAngles = arg_289_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_292_1 = 0
			local var_292_2 = 0.8

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:GetWordFromCfg(116391075)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_6 = 32 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_4) / 32)

				if (32 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_4) / 32)) > 0 and var_292_2 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391075", "story_v_out_116391.awb") ~= 0 then
					local var_292_7 = manager.audio:GetVoiceLength("story_v_out_116391", "116391075", "story_v_out_116391.awb") / 1000

					if var_292_7 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_1
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_out_116391", "116391075", "story_v_out_116391.awb")

						arg_289_1:RecordAudio("116391075", var_292_8)
						arg_289_1:RecordAudio("116391075", var_292_8)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_116391", "116391075", "story_v_out_116391.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_116391", "116391075", "story_v_out_116391.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_9 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_9 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_9

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_9 and arg_289_1.time_ < var_292_1 + var_292_9 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play116391076 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 116391076
		arg_293_1.duration_ = 11.1

		local var_293_0 = {
			zh = 4.7,
			ja = 11.1
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play116391077(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10024ui_story = arg_293_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10024ui_story"].transform.position).z)
				arg_293_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10024ui_story"].transform.localEulerAngles = arg_293_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, -1, -6)
				arg_293_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10024ui_story"].transform.position).z)
				arg_293_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10024ui_story"].transform.localEulerAngles = arg_293_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_296_1 = 0
			local var_296_2 = 0.4

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:GetWordFromCfg(116391076)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_6 = 16 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_4) / 16)

				if (16 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_4) / 16)) > 0 and var_296_2 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116391", "116391076", "story_v_out_116391.awb") ~= 0 then
					local var_296_7 = manager.audio:GetVoiceLength("story_v_out_116391", "116391076", "story_v_out_116391.awb") / 1000

					if var_296_7 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_1
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_116391", "116391076", "story_v_out_116391.awb")

						arg_293_1:RecordAudio("116391076", var_296_8)
						arg_293_1:RecordAudio("116391076", var_296_8)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_116391", "116391076", "story_v_out_116391.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_116391", "116391076", "story_v_out_116391.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_9 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_9 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_9

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_9 and arg_293_1.time_ < var_296_1 + var_296_9 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play116391077 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 116391077
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play116391078(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos10024ui_story = arg_297_1.actors_["10024ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["10024ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10024ui_story"].transform.position).z)
				arg_297_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10024ui_story"].transform.localEulerAngles = arg_297_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["10024ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.actors_["10024ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["10024ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10024ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["10024ui_story"].transform.position).z)
				arg_297_1.actors_["10024ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["10024ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["10024ui_story"].transform.localEulerAngles = arg_297_1.actors_["10024ui_story"].transform.localEulerAngles
			end

			local var_300_1 = 0
			local var_300_2 = 1.075

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(116391077).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 43 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 43)

				if (43 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 43)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play116391078 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 116391078
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play116391079(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.5

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(116391078).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 20 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 20)

				if (20 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 20)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play116391079 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 116391079
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play116391080(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.725

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(116391079).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 29 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 29)

				if (29 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 29)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play116391080 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 116391080
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
			arg_309_1.auto_ = false
		end

		function arg_309_1.playNext_(arg_311_0)
			arg_309_1.onStoryFinished_()
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 1.025

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(116391080).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 41 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 41)

				if (41 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 41)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST18_blur",
		"TextureConfig/Background/I05a",
		"TextureConfig/Background/I05f",
		"TextureConfig/Background/SK0209",
		"TextureConfig/Background/SK0209a",
		"SofdecAsset/story/101163901.usm"
	},
	voices = {
		"story_v_out_116391.awb"
	}
}
