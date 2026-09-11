return {
	Play110021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 110021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play110021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13a")
				var_4_0.name = "B13a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13a

				arg_1_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.B13a:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueB13a = var_4_4.color.a
					arg_1_1.var_.alphaMatValueB13a = var_4_4
				end

				arg_1_1.var_.alphaOldValueB13a = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueB13a then
					arg_1_1.var_.alphaMatValueB13a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB13a, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueB13a.color = arg_1_1.var_.alphaMatValueB13a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueB13a then
				arg_1_1.var_.alphaMatValueB13a.color.a = 1
				arg_1_1.var_.alphaMatValueB13a.color = arg_1_1.var_.alphaMatValueB13a.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 2 and arg_1_1.time_ < var_4_6 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_9 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_9 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_9

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_9
						arg_1_1.bgmTxt2_.text = var_4_9
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

			if 0.738461699336767 < arg_1_1.time_ and arg_1_1.time_ <= 0.738461699336767 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(110021001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 68 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 68)

				if (68 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 68)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play110021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 110021002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play110021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.625

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(110021002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 25 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 25)

				if (25 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 25)) > 0 and var_12_0 < var_12_3 then
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
	Play110021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 110021003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play110021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.7

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(110021003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 28 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 28)

				if (28 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 28)) > 0 and var_16_0 < var_16_3 then
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
	Play110021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 110021004
		arg_17_1.duration_ = 7

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play110021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_0 = arg_17_1.bgs_.B13a

				arg_17_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_1 = var_20_0:GetComponent("SpriteRenderer")

				if var_20_1 and var_20_1.sprite then
					local var_20_2 = 2 * (var_20_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_0.transform.localScale = Vector3.New(var_20_2 / var_20_1.sprite.bounds.size.y < var_20_2 * manager.ui.mainCameraCom_.aspect / var_20_1.sprite.bounds.size.x and var_20_2 * manager.ui.mainCameraCom_.aspect / var_20_1.sprite.bounds.size.x or var_20_2 / var_20_1.sprite.bounds.size.y, var_20_2 / var_20_1.sprite.bounds.size.y < var_20_2 * manager.ui.mainCameraCom_.aspect / var_20_1.sprite.bounds.size.x and var_20_2 * manager.ui.mainCameraCom_.aspect / var_20_1.sprite.bounds.size.x or var_20_2 / var_20_1.sprite.bounds.size.y, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "B13a" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_3 = "ST18"

			if arg_17_1.bgs_.ST18 == nil then
				local var_20_4 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_20_3)
				var_20_4.name = var_20_3
				var_20_4.transform.parent = arg_17_1.stage_.transform
				var_20_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_[var_20_3] = var_20_4
			end

			if 1 < arg_17_1.time_ and arg_17_1.time_ <= 1 + arg_20_0 then
				local var_20_5 = arg_17_1.bgs_.ST18

				arg_17_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_6 = var_20_5:GetComponent("SpriteRenderer")

				if var_20_6 and var_20_6.sprite then
					local var_20_7 = 2 * (var_20_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_5.transform.localScale = Vector3.New(var_20_7 / var_20_6.sprite.bounds.size.y < var_20_7 * manager.ui.mainCameraCom_.aspect / var_20_6.sprite.bounds.size.x and var_20_7 * manager.ui.mainCameraCom_.aspect / var_20_6.sprite.bounds.size.x or var_20_7 / var_20_6.sprite.bounds.size.y, var_20_7 / var_20_6.sprite.bounds.size.y < var_20_7 * manager.ui.mainCameraCom_.aspect / var_20_6.sprite.bounds.size.x and var_20_7 * manager.ui.mainCameraCom_.aspect / var_20_6.sprite.bounds.size.x or var_20_7 / var_20_6.sprite.bounds.size.y, 0)
				end

				for iter_20_2, iter_20_3 in pairs(arg_17_1.bgs_) do
					if iter_20_2 ~= "ST18" then
						iter_20_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_8 = arg_17_1.bgs_.B13a:GetComponent("SpriteRenderer")

				if var_20_8 then
					arg_17_1.var_.alphaOldValueB13a = var_20_8.color.a
					arg_17_1.var_.alphaMatValueB13a = var_20_8
				end

				arg_17_1.var_.alphaOldValueB13a = 1
			end

			local var_20_9 = 1

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				if arg_17_1.var_.alphaMatValueB13a then
					arg_17_1.var_.alphaMatValueB13a.color.a = Mathf.Lerp(arg_17_1.var_.alphaOldValueB13a, 0, (arg_17_1.time_ - 0) / var_20_9)
					arg_17_1.var_.alphaMatValueB13a.color = arg_17_1.var_.alphaMatValueB13a.color
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and arg_17_1.var_.alphaMatValueB13a then
				arg_17_1.var_.alphaMatValueB13a.color.a = 0
				arg_17_1.var_.alphaMatValueB13a.color = arg_17_1.var_.alphaMatValueB13a.color
			end

			if 1 < arg_17_1.time_ and arg_17_1.time_ <= 1 + arg_20_0 then
				local var_20_10 = arg_17_1.bgs_.ST18:GetComponent("SpriteRenderer")

				if var_20_10 then
					arg_17_1.var_.alphaOldValueST18 = var_20_10.color.a
					arg_17_1.var_.alphaMatValueST18 = var_20_10
				end

				arg_17_1.var_.alphaOldValueST18 = 0
			end

			local var_20_11 = 1

			if 1 <= arg_17_1.time_ and arg_17_1.time_ < 1 + var_20_11 then
				if arg_17_1.var_.alphaMatValueST18 then
					arg_17_1.var_.alphaMatValueST18.color.a = Mathf.Lerp(arg_17_1.var_.alphaOldValueST18, 1, (arg_17_1.time_ - 1) / var_20_11)
					arg_17_1.var_.alphaMatValueST18.color = arg_17_1.var_.alphaMatValueST18.color
				end
			end

			if arg_17_1.time_ >= 1 + var_20_11 and arg_17_1.time_ < 1 + var_20_11 + arg_20_0 and arg_17_1.var_.alphaMatValueST18 then
				arg_17_1.var_.alphaMatValueST18.color.a = 1
				arg_17_1.var_.alphaMatValueST18.color = arg_17_1.var_.alphaMatValueST18.color
			end

			local var_20_12 = manager.ui.mainCamera.transform

			if 1.8 < arg_17_1.time_ and arg_17_1.time_ <= 1.8 + arg_20_0 then
				arg_17_1.var_.shakeOldPos = var_20_12.localPosition
			end

			local var_20_13 = 0.6

			if 1.8 <= arg_17_1.time_ and arg_17_1.time_ < 1.8 + var_20_13 then
				local var_20_14, var_20_15 = math.modf((arg_17_1.time_ - 1.8) / 0.099)

				var_20_12.localPosition = Vector3.New(var_20_15 * 0.13, var_20_15 * 0.13, var_20_15 * 0.13) + arg_17_1.var_.shakeOldPos
			end

			if arg_17_1.time_ >= 1.8 + var_20_13 and arg_17_1.time_ < 1.8 + var_20_13 + arg_20_0 then
				var_20_12.localPosition = arg_17_1.var_.shakeOldPos
			end

			local var_20_16 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= var_20_16 + 2 and arg_17_1.time_ < var_20_16 + 2 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_17 = 2
			local var_20_18 = 0.1

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_17 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_19 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_19:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_20 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(110021004).content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_22 = 4 <= 0 and var_20_18 or var_20_18 * (utf8.len(var_20_20) / 4)

				if (4 <= 0 and var_20_18 or var_20_18 * (utf8.len(var_20_20) / 4)) > 0 and var_20_18 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22
					var_20_17 = var_20_17 + 0.3

					if var_20_22 + var_20_17 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_17
					end
				end

				arg_17_1.text_.text = var_20_20
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_23 = var_20_17 + 0.3
			local var_20_24 = math.max(var_20_18, arg_17_1.talkMaxDuration)

			if var_20_17 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_23) / var_20_24

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play110021005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 110021005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play110021006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.55

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(110021005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 62 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 62)

				if (62 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 62)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play110021006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 110021006
		arg_27_1.duration_ = 6.17

		local var_27_0 = {
			ja = 5.933,
			ko = 5.366,
			zh = 4.833,
			en = 6.166
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
				arg_27_0:Play110021007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.375

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:GetWordFromCfg(110021006)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 13 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 13)

				if (13 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 13)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021006", "story_v_out_110021.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021006", "story_v_out_110021.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_110021", "110021006", "story_v_out_110021.awb")

						arg_27_1:RecordAudio("110021006", var_30_6)
						arg_27_1:RecordAudio("110021006", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_110021", "110021006", "story_v_out_110021.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_110021", "110021006", "story_v_out_110021.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play110021007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 110021007
		arg_31_1.duration_ = 7.8

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play110021008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				local var_34_0 = arg_31_1.bgs_.ST18:GetComponent("SpriteRenderer")

				if var_34_0 then
					arg_31_1.var_.alphaOldValueST18 = var_34_0.color.a
					arg_31_1.var_.alphaMatValueST18 = var_34_0
				end

				arg_31_1.var_.alphaOldValueST18 = 1
			end

			local var_34_1 = 1.5

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				if arg_31_1.var_.alphaMatValueST18 then
					arg_31_1.var_.alphaMatValueST18.color.a = Mathf.Lerp(arg_31_1.var_.alphaOldValueST18, 0, (arg_31_1.time_ - 0) / var_34_1)
					arg_31_1.var_.alphaMatValueST18.color = arg_31_1.var_.alphaMatValueST18.color
				end
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 and arg_31_1.var_.alphaMatValueST18 then
				arg_31_1.var_.alphaMatValueST18.color.a = 0
				arg_31_1.var_.alphaMatValueST18.color = arg_31_1.var_.alphaMatValueST18.color
			end

			local var_34_2 = "OS0101"

			if arg_31_1.bgs_.OS0101 == nil then
				local var_34_3 = Object.Instantiate(arg_31_1.paintGo_)

				var_34_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_34_2)
				var_34_3.name = var_34_2
				var_34_3.transform.parent = arg_31_1.stage_.transform
				var_34_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.bgs_[var_34_2] = var_34_3
			end

			if 1.5 < arg_31_1.time_ and arg_31_1.time_ <= 1.5 + arg_34_0 then
				local var_34_4 = arg_31_1.bgs_.OS0101:GetComponent("SpriteRenderer")

				if var_34_4 then
					arg_31_1.var_.alphaOldValueOS0101 = var_34_4.color.a
					arg_31_1.var_.alphaMatValueOS0101 = var_34_4
				end

				arg_31_1.var_.alphaOldValueOS0101 = 0
			end

			local var_34_5 = 1.5

			if 1.5 <= arg_31_1.time_ and arg_31_1.time_ < 1.5 + var_34_5 then
				if arg_31_1.var_.alphaMatValueOS0101 then
					arg_31_1.var_.alphaMatValueOS0101.color.a = Mathf.Lerp(arg_31_1.var_.alphaOldValueOS0101, 1, (arg_31_1.time_ - 1.5) / var_34_5)
					arg_31_1.var_.alphaMatValueOS0101.color = arg_31_1.var_.alphaMatValueOS0101.color
				end
			end

			if arg_31_1.time_ >= 1.5 + var_34_5 and arg_31_1.time_ < 1.5 + var_34_5 + arg_34_0 and arg_31_1.var_.alphaMatValueOS0101 then
				arg_31_1.var_.alphaMatValueOS0101.color.a = 1
				arg_31_1.var_.alphaMatValueOS0101.color = arg_31_1.var_.alphaMatValueOS0101.color
			end

			local var_34_6 = arg_31_1.bgs_.OS0101.transform

			if 1.5 < arg_31_1.time_ and arg_31_1.time_ <= 1.5 + arg_34_0 then
				arg_31_1.var_.moveOldPosOS0101 = var_34_6.localPosition
			end

			local var_34_7 = 0.001

			if 1.5 <= arg_31_1.time_ and arg_31_1.time_ < 1.5 + var_34_7 then
				var_34_6.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPosOS0101, Vector3.New(0, 2, 8.5), (arg_31_1.time_ - 1.5) / var_34_7)
			end

			if arg_31_1.time_ >= 1.5 + var_34_7 and arg_31_1.time_ < 1.5 + var_34_7 + arg_34_0 then
				var_34_6.localPosition = Vector3.New(0, 2, 8.5)
			end

			local var_34_8 = arg_31_1.bgs_.OS0101.transform

			if 1.534 < arg_31_1.time_ and arg_31_1.time_ <= 1.534 + arg_34_0 then
				arg_31_1.var_.moveOldPosOS0101 = var_34_8.localPosition
			end

			local var_34_9 = 2.5

			if 1.534 <= arg_31_1.time_ and arg_31_1.time_ < 1.534 + var_34_9 then
				var_34_8.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPosOS0101, Vector3.New(0, 0.7, 8.5), (arg_31_1.time_ - 1.534) / var_34_9)
			end

			if arg_31_1.time_ >= 1.534 + var_34_9 and arg_31_1.time_ < 1.534 + var_34_9 + arg_34_0 then
				var_34_8.localPosition = Vector3.New(0, 0.7, 8.5)
			end

			local var_34_10 = 0

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.allBtn_.enabled = false
			end

			if arg_31_1.time_ >= var_34_10 + 3 and arg_31_1.time_ < var_34_10 + 3 + arg_34_0 then
				arg_31_1.allBtn_.enabled = true
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_11 = 2.8
			local var_34_12 = 0.6

			if 2.8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_13 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_13:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_14 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(110021007).content)

				arg_31_1.text_.text = var_34_14

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_16 = 24 <= 0 and var_34_12 or var_34_12 * (utf8.len(var_34_14) / 24)

				if (24 <= 0 and var_34_12 or var_34_12 * (utf8.len(var_34_14) / 24)) > 0 and var_34_12 < var_34_16 then
					arg_31_1.talkMaxDuration = var_34_16
					var_34_11 = var_34_11 + 0.3

					if var_34_16 + var_34_11 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_11
					end
				end

				arg_31_1.text_.text = var_34_14
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_17 = var_34_11 + 0.3
			local var_34_18 = math.max(var_34_12, arg_31_1.talkMaxDuration)

			if var_34_11 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_17 + var_34_18 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_17) / var_34_18

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_17 + var_34_18 and arg_31_1.time_ < var_34_17 + var_34_18 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OS0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OS0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 1.534,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play110021008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 110021008
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play110021009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.525

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(110021008).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 61 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 61)

				if (61 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 61)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play110021009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 110021009
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play110021010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.1

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

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

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(110021009).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 4 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 4)

				if (4 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 4)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play110021010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 110021010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play110021011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(110021010).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 54 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 54)

				if (54 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 54)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play110021011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 110021011
		arg_49_1.duration_ = 9.9

		local var_49_0 = {
			ja = 9.9,
			ko = 6.3,
			zh = 7.733,
			en = 8.866
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play110021012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.75

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(110021011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 30 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 30)

				if (30 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 30)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021011", "story_v_out_110021.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021011", "story_v_out_110021.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_110021", "110021011", "story_v_out_110021.awb")

						arg_49_1:RecordAudio("110021011", var_52_6)
						arg_49_1:RecordAudio("110021011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_110021", "110021011", "story_v_out_110021.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_110021", "110021011", "story_v_out_110021.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play110021012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 110021012
		arg_53_1.duration_ = 9.43

		local var_53_0 = {
			ja = 9.433,
			ko = 4.8,
			zh = 5.8,
			en = 6.033
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play110021013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.6

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(110021012)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 22 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 22)

				if (22 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 22)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021012", "story_v_out_110021.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021012", "story_v_out_110021.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_110021", "110021012", "story_v_out_110021.awb")

						arg_53_1:RecordAudio("110021012", var_56_6)
						arg_53_1:RecordAudio("110021012", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_110021", "110021012", "story_v_out_110021.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_110021", "110021012", "story_v_out_110021.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play110021013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 110021013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play110021014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.05

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(110021013).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 2 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 2)

				if (2 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 2)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play110021014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 110021014
		arg_61_1.duration_ = 7

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play110021015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.bgs_.A00 == nil then
				local var_64_0 = Object.Instantiate(arg_61_1.paintGo_)

				var_64_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_64_0.name = "A00"
				var_64_0.transform.parent = arg_61_1.stage_.transform
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.bgs_.A00 = var_64_0
			end

			if 1.5 < arg_61_1.time_ and arg_61_1.time_ <= 1.5 + arg_64_0 then
				local var_64_1 = arg_61_1.bgs_.A00

				arg_61_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_64_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_64_2 = var_64_1:GetComponent("SpriteRenderer")

				if var_64_2 and var_64_2.sprite then
					local var_64_3 = 2 * (var_64_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_64_1.transform.localScale = Vector3.New(var_64_3 / var_64_2.sprite.bounds.size.y < var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x and var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x or var_64_3 / var_64_2.sprite.bounds.size.y, var_64_3 / var_64_2.sprite.bounds.size.y < var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x and var_64_3 * manager.ui.mainCameraCom_.aspect / var_64_2.sprite.bounds.size.x or var_64_3 / var_64_2.sprite.bounds.size.y, 0)
				end

				for iter_64_0, iter_64_1 in pairs(arg_61_1.bgs_) do
					if iter_64_0 ~= "A00" then
						iter_64_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_4 = arg_61_1.bgs_.OS0101:GetComponent("SpriteRenderer")

				if var_64_4 then
					arg_61_1.var_.alphaOldValueOS0101 = var_64_4.color.a
					arg_61_1.var_.alphaMatValueOS0101 = var_64_4
				end

				arg_61_1.var_.alphaOldValueOS0101 = 1
			end

			local var_64_5 = 1.5

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 then
				if arg_61_1.var_.alphaMatValueOS0101 then
					arg_61_1.var_.alphaMatValueOS0101.color.a = Mathf.Lerp(arg_61_1.var_.alphaOldValueOS0101, 0, (arg_61_1.time_ - 0) / var_64_5)
					arg_61_1.var_.alphaMatValueOS0101.color = arg_61_1.var_.alphaMatValueOS0101.color
				end
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 and arg_61_1.var_.alphaMatValueOS0101 then
				arg_61_1.var_.alphaMatValueOS0101.color.a = 0
				arg_61_1.var_.alphaMatValueOS0101.color = arg_61_1.var_.alphaMatValueOS0101.color
			end

			if 1.5 < arg_61_1.time_ and arg_61_1.time_ <= 1.5 + arg_64_0 then
				local var_64_6 = arg_61_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_64_6 then
					arg_61_1.var_.alphaOldValueA00 = var_64_6.color.a
					arg_61_1.var_.alphaMatValueA00 = var_64_6
				end

				arg_61_1.var_.alphaOldValueA00 = 0
			end

			local var_64_7 = 1.5

			if 1.5 <= arg_61_1.time_ and arg_61_1.time_ < 1.5 + var_64_7 then
				if arg_61_1.var_.alphaMatValueA00 then
					arg_61_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_61_1.var_.alphaOldValueA00, 1, (arg_61_1.time_ - 1.5) / var_64_7)
					arg_61_1.var_.alphaMatValueA00.color = arg_61_1.var_.alphaMatValueA00.color
				end
			end

			if arg_61_1.time_ >= 1.5 + var_64_7 and arg_61_1.time_ < 1.5 + var_64_7 + arg_64_0 and arg_61_1.var_.alphaMatValueA00 then
				arg_61_1.var_.alphaMatValueA00.color.a = 1
				arg_61_1.var_.alphaMatValueA00.color = arg_61_1.var_.alphaMatValueA00.color
			end

			local var_64_8 = 1.5

			arg_61_1.isInRecall_ = false

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.screenFilterGo_:SetActive(true)

				arg_61_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_64_2, iter_64_3 in pairs(arg_61_1.actors_) do
					for iter_64_4, iter_64_5 in ipairs((iter_64_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_64_5.color = iter_64_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_64_9 = 0.2

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 then
				arg_61_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_8) / var_64_9)
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 then
				arg_61_1.screenFilterEffect_.weight = 1
			end

			local var_64_10 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			if arg_61_1.time_ >= var_64_10 + 2 and arg_61_1.time_ < var_64_10 + 2 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_11 = 2
			local var_64_12 = 0.325

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_13 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_13:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(110021014).content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 13 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_14) / 13)

				if (13 <= 0 and var_64_12 or var_64_12 * (utf8.len(var_64_14) / 13)) > 0 and var_64_12 < var_64_16 then
					arg_61_1.talkMaxDuration = var_64_16
					var_64_11 = var_64_11 + 0.3

					if var_64_16 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_17 = var_64_11 + 0.3
			local var_64_18 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_17) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_17 + var_64_18 and arg_61_1.time_ < var_64_17 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play110021015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 110021015
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play110021016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(110021015).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 12 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 12)

				if (12 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 12)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play110021016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 110021016
		arg_71_1.duration_ = 10

		local var_71_0 = {
			ja = 7.166,
			ko = 7.9,
			zh = 10,
			en = 8.7
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
				arg_71_0:Play110021017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if arg_71_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_74_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_71_1.stage_.transform)

				var_74_0.name = "1019ui_story"
				var_74_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1019ui_story"] = var_74_0

				local var_74_1 = var_74_0:GetComponentInChildren(typeof(CharacterEffect))

				var_74_1.enabled = true

				local var_74_2 = GameObjectTools.GetOrAddComponent(var_74_0, typeof(DynamicBoneHelper))

				if var_74_2 then
					var_74_2:EnableDynamicBone(false)
				end

				arg_71_1:ShowWeapon(var_74_1.transform, false)

				arg_71_1.var_["1019ui_story" .. "Animator"] = var_74_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_71_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_71_1.var_["1019ui_story" .. "LipSync"] = var_74_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_74_3 = arg_71_1.actors_["1019ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1019ui_story = var_74_3.localPosition
			end

			local var_74_4 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				var_74_3.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_71_1.time_ - 0) / var_74_4)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				var_74_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_74_5 = 0
			local var_74_6 = 0.925

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:GetWordFromCfg(110021016)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 37 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 37)

				if (37 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 37)) > 0 and var_74_6 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021016", "story_v_out_110021.awb") ~= 0 then
					local var_74_11 = manager.audio:GetVoiceLength("story_v_out_110021", "110021016", "story_v_out_110021.awb") / 1000

					if var_74_11 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_5
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_out_110021", "110021016", "story_v_out_110021.awb")

						arg_71_1:RecordAudio("110021016", var_74_12)
						arg_71_1:RecordAudio("110021016", var_74_12)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_110021", "110021016", "story_v_out_110021.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_110021", "110021016", "story_v_out_110021.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_13 and arg_71_1.time_ < var_74_5 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play110021017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 110021017
		arg_75_1.duration_ = 11.87

		local var_75_0 = {
			ja = 11.866,
			ko = 8.033,
			zh = 8.6,
			en = 8.3
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
				arg_75_0:Play110021018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.bgs_.B12a == nil then
				local var_78_0 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B12a")
				var_78_0.name = "B12a"
				var_78_0.transform.parent = arg_75_1.stage_.transform
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_.B12a = var_78_0
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_1 = arg_75_1.bgs_.B12a

				arg_75_1.bgs_.B12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_78_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_2 = var_78_1:GetComponent("SpriteRenderer")

				if var_78_2 and var_78_2.sprite then
					local var_78_3 = 2 * (var_78_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_78_1.transform.localScale = Vector3.New(var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "B12a" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_4 = arg_75_1.actors_["1019ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1019ui_story = var_78_4.localPosition
			end

			local var_78_5 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 then
				var_78_4.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_5)
				var_78_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_4.position).x, (manager.ui.mainCamera.transform.position - var_78_4.position).y, (manager.ui.mainCamera.transform.position - var_78_4.position).z)
				var_78_4.localEulerAngles.z = 0
				var_78_4.localEulerAngles.x = 0
				var_78_4.localEulerAngles = var_78_4.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 then
				var_78_4.localPosition = Vector3.New(0, 100, 0)
				var_78_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_4.position).x, (manager.ui.mainCamera.transform.position - var_78_4.position).y, (manager.ui.mainCamera.transform.position - var_78_4.position).z)
				var_78_4.localEulerAngles.z = 0
				var_78_4.localEulerAngles.x = 0
				var_78_4.localEulerAngles = var_78_4.localEulerAngles
			end

			local var_78_6 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_7 = 1.5

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_7 then
				local var_78_8 = Color.New(1, 1, 1)

				var_78_8.a = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_6) / var_78_7)
				arg_75_1.mask_.color = var_78_8
			end

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 then
				local var_78_9 = Color.New(1, 1, 1)

				arg_75_1.mask_.enabled = false
				var_78_9.a = 0
				arg_75_1.mask_.color = var_78_9
			end

			local var_78_10 = "1111ui_story"

			if arg_75_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_78_11 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_75_1.stage_.transform)

				var_78_11.name = var_78_10
				var_78_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_[var_78_10] = var_78_11

				local var_78_12 = var_78_11:GetComponentInChildren(typeof(CharacterEffect))

				var_78_12.enabled = true

				local var_78_13 = GameObjectTools.GetOrAddComponent(var_78_11, typeof(DynamicBoneHelper))

				if var_78_13 then
					var_78_13:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_12.transform, false)

				arg_75_1.var_[var_78_10 .. "Animator"] = var_78_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_[var_78_10 .. "Animator"].applyRootMotion = true
				arg_75_1.var_[var_78_10 .. "LipSync"] = var_78_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_14 = arg_75_1.actors_["1111ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_14) and arg_75_1.var_.characterEffect1111ui_story == nil then
				arg_75_1.var_.characterEffect1111ui_story = var_78_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_15 = 0.034

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_15 and not isNil(var_78_14) then
				if arg_75_1.var_.characterEffect1111ui_story and not isNil(var_78_14) then
					arg_75_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_15)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_15 and arg_75_1.time_ < 0 + var_78_15 + arg_78_0 and not isNil(var_78_14) and arg_75_1.var_.characterEffect1111ui_story then
				arg_75_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_78_16 = arg_75_1.actors_["1111ui_story"].transform

			if 0.034 < arg_75_1.time_ and arg_75_1.time_ <= 0.034 + arg_78_0 then
				arg_75_1.var_.moveOldPos1111ui_story = var_78_16.localPosition
			end

			local var_78_17 = 0.001

			if 0.034 <= arg_75_1.time_ and arg_75_1.time_ < 0.034 + var_78_17 then
				var_78_16.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_75_1.time_ - 0.034) / var_78_17)
				var_78_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_16.position).x, (manager.ui.mainCamera.transform.position - var_78_16.position).y, (manager.ui.mainCamera.transform.position - var_78_16.position).z)
				var_78_16.localEulerAngles.z = 0
				var_78_16.localEulerAngles.x = 0
				var_78_16.localEulerAngles = var_78_16.localEulerAngles
			end

			if arg_75_1.time_ >= 0.034 + var_78_17 and arg_75_1.time_ < 0.034 + var_78_17 + arg_78_0 then
				var_78_16.localPosition = Vector3.New(0, -0.87, -5.7)
				var_78_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_16.position).x, (manager.ui.mainCamera.transform.position - var_78_16.position).y, (manager.ui.mainCamera.transform.position - var_78_16.position).z)
				var_78_16.localEulerAngles.z = 0
				var_78_16.localEulerAngles.x = 0
				var_78_16.localEulerAngles = var_78_16.localEulerAngles
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_18 = 2
			local var_78_19 = 0.65

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_18 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_20 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_20:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_21 = arg_75_1:GetWordFromCfg(110021017)
				local var_78_22 = arg_75_1:FormatText(var_78_21.content)

				arg_75_1.text_.text = var_78_22

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_24 = 26 <= 0 and var_78_19 or var_78_19 * (utf8.len(var_78_22) / 26)

				if (26 <= 0 and var_78_19 or var_78_19 * (utf8.len(var_78_22) / 26)) > 0 and var_78_19 < var_78_24 then
					arg_75_1.talkMaxDuration = var_78_24
					var_78_18 = var_78_18 + 0.3

					if var_78_24 + var_78_18 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_24 + var_78_18
					end
				end

				arg_75_1.text_.text = var_78_22
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021017", "story_v_out_110021.awb") ~= 0 then
					local var_78_25 = manager.audio:GetVoiceLength("story_v_out_110021", "110021017", "story_v_out_110021.awb") / 1000

					if var_78_25 + var_78_18 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_25 + var_78_18
					end

					if var_78_21.prefab_name ~= "" and arg_75_1.actors_[var_78_21.prefab_name] ~= nil then
						local var_78_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_21.prefab_name].transform, "story_v_out_110021", "110021017", "story_v_out_110021.awb")

						arg_75_1:RecordAudio("110021017", var_78_26)
						arg_75_1:RecordAudio("110021017", var_78_26)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_110021", "110021017", "story_v_out_110021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_110021", "110021017", "story_v_out_110021.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_27 = var_78_18 + 0.3
			local var_78_28 = math.max(var_78_19, arg_75_1.talkMaxDuration)

			if var_78_18 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_27 + var_78_28 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_27) / var_78_28

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_27 + var_78_28 and arg_75_1.time_ < var_78_27 + var_78_28 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play110021018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 110021018
		arg_81_1.duration_ = 8.47

		local var_81_0 = {
			ja = 8.466,
			ko = 6.066,
			zh = 6.5,
			en = 4.566
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play110021019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1111ui_story"]) and arg_81_1.var_.characterEffect1111ui_story == nil then
				arg_81_1.var_.characterEffect1111ui_story = arg_81_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1111ui_story"]) then
				if arg_81_1.var_.characterEffect1111ui_story and not isNil(arg_81_1.actors_["1111ui_story"]) then
					arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1111ui_story"]) and arg_81_1.var_.characterEffect1111ui_story then
				arg_81_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_84_2 = 0
			local var_84_3 = 0.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(110021018)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 20 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 20)

				if (20 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 20)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021018", "story_v_out_110021.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_110021", "110021018", "story_v_out_110021.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_110021", "110021018", "story_v_out_110021.awb")

						arg_81_1:RecordAudio("110021018", var_84_9)
						arg_81_1:RecordAudio("110021018", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_110021", "110021018", "story_v_out_110021.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_110021", "110021018", "story_v_out_110021.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play110021019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 110021019
		arg_85_1.duration_ = 7

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play110021020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_0 = arg_85_1.bgs_.A00

				arg_85_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_1 = var_88_0:GetComponent("SpriteRenderer")

				if var_88_1 and var_88_1.sprite then
					local var_88_2 = 2 * (var_88_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_0.transform.localScale = Vector3.New(var_88_2 / var_88_1.sprite.bounds.size.y < var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x and var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x or var_88_2 / var_88_1.sprite.bounds.size.y, var_88_2 / var_88_1.sprite.bounds.size.y < var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x and var_88_2 * manager.ui.mainCameraCom_.aspect / var_88_1.sprite.bounds.size.x or var_88_2 / var_88_1.sprite.bounds.size.y, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "A00" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_3 = 0

			arg_85_1.isInRecall_ = false

			if var_88_3 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.screenFilterGo_:SetActive(true)

				arg_85_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_88_2, iter_88_3 in pairs(arg_85_1.actors_) do
					for iter_88_4, iter_88_5 in ipairs((iter_88_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_88_5.color = iter_88_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_88_4 = 0.2

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_4 then
				arg_85_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_3) / var_88_4)
			end

			if arg_85_1.time_ >= var_88_3 + var_88_4 and arg_85_1.time_ < var_88_3 + var_88_4 + arg_88_0 then
				arg_85_1.screenFilterEffect_.weight = 1
			end

			local var_88_5 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			if arg_85_1.time_ >= var_88_5 + 2 and arg_85_1.time_ < var_88_5 + 2 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_6 = arg_85_1.actors_["1111ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1111ui_story = var_88_6.localPosition
			end

			local var_88_7 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_6.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_7)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_6.localPosition = Vector3.New(0, 100, 0)
				var_88_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_6.position).x, (manager.ui.mainCamera.transform.position - var_88_6.position).y, (manager.ui.mainCamera.transform.position - var_88_6.position).z)
				var_88_6.localEulerAngles.z = 0
				var_88_6.localEulerAngles.x = 0
				var_88_6.localEulerAngles = var_88_6.localEulerAngles
			end

			local var_88_8 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = false

				arg_85_1:SetGaussion(false)
			end

			local var_88_9 = 1.5

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 then
				local var_88_10 = Color.New(1, 1, 1)

				var_88_10.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_8) / var_88_9)
				arg_85_1.mask_.color = var_88_10
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 then
				local var_88_11 = Color.New(1, 1, 1)

				arg_85_1.mask_.enabled = false
				var_88_11.a = 0
				arg_85_1.mask_.color = var_88_11
			end

			local var_88_12 = arg_85_1.actors_["1019ui_story"].transform

			if 1.8 < arg_85_1.time_ and arg_85_1.time_ <= 1.8 + arg_88_0 then
				arg_85_1.var_.moveOldPos1019ui_story = var_88_12.localPosition
			end

			local var_88_13 = 0.001

			if 1.8 <= arg_85_1.time_ and arg_85_1.time_ < 1.8 + var_88_13 then
				var_88_12.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_85_1.time_ - 1.8) / var_88_13)
				var_88_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_12.position).x, (manager.ui.mainCamera.transform.position - var_88_12.position).y, (manager.ui.mainCamera.transform.position - var_88_12.position).z)
				var_88_12.localEulerAngles.z = 0
				var_88_12.localEulerAngles.x = 0
				var_88_12.localEulerAngles = var_88_12.localEulerAngles
			end

			if arg_85_1.time_ >= 1.8 + var_88_13 and arg_85_1.time_ < 1.8 + var_88_13 + arg_88_0 then
				var_88_12.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_88_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_12.position).x, (manager.ui.mainCamera.transform.position - var_88_12.position).y, (manager.ui.mainCamera.transform.position - var_88_12.position).z)
				var_88_12.localEulerAngles.z = 0
				var_88_12.localEulerAngles.x = 0
				var_88_12.localEulerAngles = var_88_12.localEulerAngles
			end

			if 1.8 < arg_85_1.time_ and arg_85_1.time_ <= 1.8 + arg_88_0 then
				arg_85_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			local var_88_14 = arg_85_1.actors_["1019ui_story"]

			if 1.8 < arg_85_1.time_ and arg_85_1.time_ <= 1.8 + arg_88_0 and not isNil(var_88_14) and arg_85_1.var_.characterEffect1019ui_story == nil then
				arg_85_1.var_.characterEffect1019ui_story = var_88_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_15 = 0.2

			if 1.8 <= arg_85_1.time_ and arg_85_1.time_ < 1.8 + var_88_15 and not isNil(var_88_14) then
				if arg_85_1.var_.characterEffect1019ui_story and not isNil(var_88_14) then
					arg_85_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 1.8) / var_88_15)
				end
			end

			if arg_85_1.time_ >= 1.8 + var_88_15 and arg_85_1.time_ < 1.8 + var_88_15 + arg_88_0 and not isNil(var_88_14) and arg_85_1.var_.characterEffect1019ui_story then
				arg_85_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_16 = 2
			local var_88_17 = 0.975

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_18 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_18:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

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

				local var_88_19 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(110021019).content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_21 = 39 <= 0 and var_88_17 or var_88_17 * (utf8.len(var_88_19) / 39)

				if (39 <= 0 and var_88_17 or var_88_17 * (utf8.len(var_88_19) / 39)) > 0 and var_88_17 < var_88_21 then
					arg_85_1.talkMaxDuration = var_88_21
					var_88_16 = var_88_16 + 0.3

					if var_88_21 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_21 + var_88_16
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_22 = var_88_16 + 0.3
			local var_88_23 = math.max(var_88_17, arg_85_1.talkMaxDuration)

			if var_88_16 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_22 + var_88_23 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_22) / var_88_23

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_22 + var_88_23 and arg_85_1.time_ < var_88_22 + var_88_23 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play110021020 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 110021020
		arg_91_1.duration_ = 6.17

		local var_91_0 = {
			ja = 6.166,
			ko = 2.6,
			zh = 3.3,
			en = 2.466
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
				arg_91_0:Play110021021(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1019ui_story"]) and arg_91_1.var_.characterEffect1019ui_story == nil then
				arg_91_1.var_.characterEffect1019ui_story = arg_91_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1019ui_story"]) then
				if arg_91_1.var_.characterEffect1019ui_story and not isNil(arg_91_1.actors_["1019ui_story"]) then
					arg_91_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1019ui_story"]) and arg_91_1.var_.characterEffect1019ui_story then
				arg_91_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_94_2 = 0
			local var_94_3 = 0.175

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(110021020)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 7 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 7)

				if (7 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 7)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021020", "story_v_out_110021.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_110021", "110021020", "story_v_out_110021.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_out_110021", "110021020", "story_v_out_110021.awb")

						arg_91_1:RecordAudio("110021020", var_94_9)
						arg_91_1:RecordAudio("110021020", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_110021", "110021020", "story_v_out_110021.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_110021", "110021020", "story_v_out_110021.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play110021021 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 110021021
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play110021022(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1019ui_story"]) and arg_95_1.var_.characterEffect1019ui_story == nil then
				arg_95_1.var_.characterEffect1019ui_story = arg_95_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1019ui_story"]) then
				if arg_95_1.var_.characterEffect1019ui_story and not isNil(arg_95_1.actors_["1019ui_story"]) then
					arg_95_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1019ui_story"]) and arg_95_1.var_.characterEffect1019ui_story then
				arg_95_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_98_1 = 0
			local var_98_2 = 0.65

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(110021021).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 27 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 27)

				if (27 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 27)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play110021022 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 110021022
		arg_99_1.duration_ = 12.47

		local var_99_0 = {
			ja = 6.6,
			ko = 12.466,
			zh = 11.9,
			en = 12.233
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
				arg_99_0:Play110021023(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1019ui_story"]) and arg_99_1.var_.characterEffect1019ui_story == nil then
				arg_99_1.var_.characterEffect1019ui_story = arg_99_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1019ui_story"]) then
				if arg_99_1.var_.characterEffect1019ui_story and not isNil(arg_99_1.actors_["1019ui_story"]) then
					arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1019ui_story"]) and arg_99_1.var_.characterEffect1019ui_story then
				arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action475")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_102_2 = 0
			local var_102_3 = 1.325

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_4 = arg_99_1:GetWordFromCfg(110021022)
				local var_102_5 = arg_99_1:FormatText(var_102_4.content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 53 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 53)

				if (53 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 53)) > 0 and var_102_3 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_2
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021022", "story_v_out_110021.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_110021", "110021022", "story_v_out_110021.awb") / 1000

					if var_102_8 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_2
					end

					if var_102_4.prefab_name ~= "" and arg_99_1.actors_[var_102_4.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_4.prefab_name].transform, "story_v_out_110021", "110021022", "story_v_out_110021.awb")

						arg_99_1:RecordAudio("110021022", var_102_9)
						arg_99_1:RecordAudio("110021022", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_110021", "110021022", "story_v_out_110021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_110021", "110021022", "story_v_out_110021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_3, arg_99_1.talkMaxDuration)

			if var_102_2 <= arg_99_1.time_ and arg_99_1.time_ < var_102_2 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_2) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_2 + var_102_10 and arg_99_1.time_ < var_102_2 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play110021023 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 110021023
		arg_103_1.duration_ = 17.43

		local var_103_0 = {
			ja = 17.433,
			ko = 15.733,
			zh = 13.7,
			en = 11.633
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
				arg_103_0:Play110021024(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_106_0 = 0
			local var_106_1 = 1.5

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(110021023)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 60 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 60)

				if (60 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 60)) > 0 and var_106_1 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021023", "story_v_out_110021.awb") ~= 0 then
					local var_106_6 = manager.audio:GetVoiceLength("story_v_out_110021", "110021023", "story_v_out_110021.awb") / 1000

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end

					if var_106_2.prefab_name ~= "" and arg_103_1.actors_[var_106_2.prefab_name] ~= nil then
						local var_106_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_2.prefab_name].transform, "story_v_out_110021", "110021023", "story_v_out_110021.awb")

						arg_103_1:RecordAudio("110021023", var_106_7)
						arg_103_1:RecordAudio("110021023", var_106_7)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_110021", "110021023", "story_v_out_110021.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_110021", "110021023", "story_v_out_110021.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play110021024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 110021024
		arg_107_1.duration_ = 8.8

		local var_107_0 = {
			ja = 8.8,
			ko = 4.1,
			zh = 4.333,
			en = 4.266
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
				arg_107_0:Play110021025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_110_0 = 0
			local var_110_1 = 0.5

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_2 = arg_107_1:GetWordFromCfg(110021024)
				local var_110_3 = arg_107_1:FormatText(var_110_2.content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 19 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 19)

				if (19 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 19)) > 0 and var_110_1 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021024", "story_v_out_110021.awb") ~= 0 then
					local var_110_6 = manager.audio:GetVoiceLength("story_v_out_110021", "110021024", "story_v_out_110021.awb") / 1000

					if var_110_6 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_0
					end

					if var_110_2.prefab_name ~= "" and arg_107_1.actors_[var_110_2.prefab_name] ~= nil then
						local var_110_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_2.prefab_name].transform, "story_v_out_110021", "110021024", "story_v_out_110021.awb")

						arg_107_1:RecordAudio("110021024", var_110_7)
						arg_107_1:RecordAudio("110021024", var_110_7)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_110021", "110021024", "story_v_out_110021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_110021", "110021024", "story_v_out_110021.awb")
				end

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
	Play110021025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 110021025
		arg_111_1.duration_ = 6.63

		local var_111_0 = {
			ja = 6.333,
			ko = 6.633,
			zh = 6.233,
			en = 5.3
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
				arg_111_0:Play110021026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1019ui_story = arg_111_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1019ui_story"].transform.position).z)
				arg_111_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1019ui_story"].transform.localEulerAngles = arg_111_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1019ui_story"].transform.position).z)
				arg_111_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1019ui_story"].transform.localEulerAngles = arg_111_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				local var_114_1 = arg_111_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_114_1 then
					arg_111_1.var_.alphaOldValueA00 = var_114_1.color.a
					arg_111_1.var_.alphaMatValueA00 = var_114_1
				end

				arg_111_1.var_.alphaOldValueA00 = 1
			end

			local var_114_2 = 1.5

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 then
				if arg_111_1.var_.alphaMatValueA00 then
					arg_111_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_111_1.var_.alphaOldValueA00, 0, (arg_111_1.time_ - 0) / var_114_2)
					arg_111_1.var_.alphaMatValueA00.color = arg_111_1.var_.alphaMatValueA00.color
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and arg_111_1.var_.alphaMatValueA00 then
				arg_111_1.var_.alphaMatValueA00.color.a = 0
				arg_111_1.var_.alphaMatValueA00.color = arg_111_1.var_.alphaMatValueA00.color
			end

			if 1.5 < arg_111_1.time_ and arg_111_1.time_ <= 1.5 + arg_114_0 then
				local var_114_3 = arg_111_1.bgs_.OS0101:GetComponent("SpriteRenderer")

				if var_114_3 then
					arg_111_1.var_.alphaOldValueOS0101 = var_114_3.color.a
					arg_111_1.var_.alphaMatValueOS0101 = var_114_3
				end

				arg_111_1.var_.alphaOldValueOS0101 = 0
			end

			local var_114_4 = 1.5

			if 1.5 <= arg_111_1.time_ and arg_111_1.time_ < 1.5 + var_114_4 then
				if arg_111_1.var_.alphaMatValueOS0101 then
					arg_111_1.var_.alphaMatValueOS0101.color.a = Mathf.Lerp(arg_111_1.var_.alphaOldValueOS0101, 1, (arg_111_1.time_ - 1.5) / var_114_4)
					arg_111_1.var_.alphaMatValueOS0101.color = arg_111_1.var_.alphaMatValueOS0101.color
				end
			end

			if arg_111_1.time_ >= 1.5 + var_114_4 and arg_111_1.time_ < 1.5 + var_114_4 + arg_114_0 and arg_111_1.var_.alphaMatValueOS0101 then
				arg_111_1.var_.alphaMatValueOS0101.color.a = 1
				arg_111_1.var_.alphaMatValueOS0101.color = arg_111_1.var_.alphaMatValueOS0101.color
			end

			if 1.5 < arg_111_1.time_ and arg_111_1.time_ <= 1.5 + arg_114_0 then
				local var_114_5 = arg_111_1.bgs_.OS0101

				arg_111_1.bgs_.OS0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_114_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_114_6 = var_114_5:GetComponent("SpriteRenderer")

				if var_114_6 and var_114_6.sprite then
					local var_114_7 = 2 * (var_114_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_114_5.transform.localScale = Vector3.New(var_114_7 / var_114_6.sprite.bounds.size.y < var_114_7 * manager.ui.mainCameraCom_.aspect / var_114_6.sprite.bounds.size.x and var_114_7 * manager.ui.mainCameraCom_.aspect / var_114_6.sprite.bounds.size.x or var_114_7 / var_114_6.sprite.bounds.size.y, var_114_7 / var_114_6.sprite.bounds.size.y < var_114_7 * manager.ui.mainCameraCom_.aspect / var_114_6.sprite.bounds.size.x and var_114_7 * manager.ui.mainCameraCom_.aspect / var_114_6.sprite.bounds.size.x or var_114_7 / var_114_6.sprite.bounds.size.y, 0)
				end

				for iter_114_0, iter_114_1 in pairs(arg_111_1.bgs_) do
					if iter_114_0 ~= "OS0101" then
						iter_114_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_114_8 = 0

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			if arg_111_1.time_ >= var_114_8 + 2 and arg_111_1.time_ < var_114_8 + 2 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_9 = 1.5

			arg_111_1.isInRecall_ = false

			if var_114_9 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 then
				arg_111_1.screenFilterGo_:SetActive(false)

				for iter_114_2, iter_114_3 in pairs(arg_111_1.actors_) do
					for iter_114_4, iter_114_5 in ipairs((iter_114_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_114_5.color = iter_114_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_114_10 = 0.5

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_10 then
				arg_111_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_111_1.time_ - var_114_9) / var_114_10)
			end

			if arg_111_1.time_ >= var_114_9 + var_114_10 and arg_111_1.time_ < var_114_9 + var_114_10 + arg_114_0 then
				arg_111_1.screenFilterEffect_.weight = 0
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_11 = 2
			local var_114_12 = 0.375

			if 2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_13 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_13:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_14 = arg_111_1:GetWordFromCfg(110021025)
				local var_114_15 = arg_111_1:FormatText(var_114_14.content)

				arg_111_1.text_.text = var_114_15

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_17 = 15 <= 0 and var_114_12 or var_114_12 * (utf8.len(var_114_15) / 15)

				if (15 <= 0 and var_114_12 or var_114_12 * (utf8.len(var_114_15) / 15)) > 0 and var_114_12 < var_114_17 then
					arg_111_1.talkMaxDuration = var_114_17
					var_114_11 = var_114_11 + 0.3

					if var_114_17 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_17 + var_114_11
					end
				end

				arg_111_1.text_.text = var_114_15
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021025", "story_v_out_110021.awb") ~= 0 then
					local var_114_18 = manager.audio:GetVoiceLength("story_v_out_110021", "110021025", "story_v_out_110021.awb") / 1000

					if var_114_18 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_18 + var_114_11
					end

					if var_114_14.prefab_name ~= "" and arg_111_1.actors_[var_114_14.prefab_name] ~= nil then
						local var_114_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_14.prefab_name].transform, "story_v_out_110021", "110021025", "story_v_out_110021.awb")

						arg_111_1:RecordAudio("110021025", var_114_19)
						arg_111_1:RecordAudio("110021025", var_114_19)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_110021", "110021025", "story_v_out_110021.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_110021", "110021025", "story_v_out_110021.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_20 = var_114_11 + 0.3
			local var_114_21 = math.max(var_114_12, arg_111_1.talkMaxDuration)

			if var_114_11 + 0.3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_20 + var_114_21 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_20) / var_114_21

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_20 + var_114_21 and arg_111_1.time_ < var_114_20 + var_114_21 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play110021026 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 110021026
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play110021027(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1111ui_story"]) and arg_117_1.var_.characterEffect1111ui_story == nil then
				arg_117_1.var_.characterEffect1111ui_story = arg_117_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1111ui_story"]) then
				if arg_117_1.var_.characterEffect1111ui_story and not isNil(arg_117_1.actors_["1111ui_story"]) then
					arg_117_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1111ui_story"]) and arg_117_1.var_.characterEffect1111ui_story then
				arg_117_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 1.9

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(110021026).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 76 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 76)

				if (76 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 76)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play110021027 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 110021027
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play110021028(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(110021027).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 40 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 40)

				if (40 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 40)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play110021028 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 110021028
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play110021029(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.425

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(110021028).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 17 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 17)

				if (17 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 17)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play110021029 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 110021029
		arg_129_1.duration_ = 0.1

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"

			SetActive(arg_129_1.choicesGo_, true)

			for iter_130_0, iter_130_1 in ipairs(arg_129_1.choices_) do
				SetActive(iter_130_1.go, iter_130_0 <= 2)
			end

			arg_129_1.choices_[1].txt.text = arg_129_1:FormatText(StoryChoiceCfg[110].name)
			arg_129_1.choices_[2].txt.text = arg_129_1:FormatText(StoryChoiceCfg[111].name)
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play110021030(arg_129_1)
			end

			if arg_131_0 == 2 then
				arg_129_0:Play110021030(arg_129_1)
			end

			arg_129_1:RecordChoiceLog(110021029, 110, 111)
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			return
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play110021030 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 110021030
		arg_133_1.duration_ = 5.53

		local var_133_0 = {
			ja = 5.533,
			ko = 4.7,
			zh = 4.4,
			en = 4.133
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
				arg_133_0:Play110021031(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.4

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(110021030)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 16 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 16)

				if (16 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 16)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021030", "story_v_out_110021.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021030", "story_v_out_110021.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_110021", "110021030", "story_v_out_110021.awb")

						arg_133_1:RecordAudio("110021030", var_136_6)
						arg_133_1:RecordAudio("110021030", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_110021", "110021030", "story_v_out_110021.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_110021", "110021030", "story_v_out_110021.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play110021031 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 110021031
		arg_137_1.duration_ = 9.1

		local var_137_0 = {
			ja = 9.1,
			ko = 6.666,
			zh = 7.833,
			en = 8.466
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play110021032(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.775

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(110021031)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 29 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 29)

				if (29 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 29)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021031", "story_v_out_110021.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021031", "story_v_out_110021.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_110021", "110021031", "story_v_out_110021.awb")

						arg_137_1:RecordAudio("110021031", var_140_6)
						arg_137_1:RecordAudio("110021031", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_110021", "110021031", "story_v_out_110021.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_110021", "110021031", "story_v_out_110021.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play110021032 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 110021032
		arg_141_1.duration_ = 13.5

		local var_141_0 = {
			ja = 11.466,
			ko = 13.5,
			zh = 12.266,
			en = 11.366
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
				arg_141_0:Play110021033(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0.9 < arg_141_1.time_ and arg_141_1.time_ <= 0.9 + arg_144_0 then
				arg_141_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_144_0 = 0.6

			if 0.9 <= arg_141_1.time_ and arg_141_1.time_ < 0.9 + var_144_0 then
				local var_144_1, var_144_2 = math.modf((arg_141_1.time_ - 0.9) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_144_2 * 0.13, var_144_2 * 0.13, var_144_2 * 0.13) + arg_141_1.var_.shakeOldPos
			end

			if arg_141_1.time_ >= 0.9 + var_144_0 and arg_141_1.time_ < 0.9 + var_144_0 + arg_144_0 then
				manager.ui.mainCamera.transform.localPosition = arg_141_1.var_.shakeOldPos
			end

			local var_144_3 = 0
			local var_144_4 = 1.3

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_5 = arg_141_1:GetWordFromCfg(110021032)
				local var_144_6 = arg_141_1:FormatText(var_144_5.content)

				arg_141_1.text_.text = var_144_6

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_8 = 50 <= 0 and var_144_4 or var_144_4 * (utf8.len(var_144_6) / 50)

				if (50 <= 0 and var_144_4 or var_144_4 * (utf8.len(var_144_6) / 50)) > 0 and var_144_4 < var_144_8 then
					arg_141_1.talkMaxDuration = var_144_8

					if var_144_8 + var_144_3 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_3
					end
				end

				arg_141_1.text_.text = var_144_6
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021032", "story_v_out_110021.awb") ~= 0 then
					local var_144_9 = manager.audio:GetVoiceLength("story_v_out_110021", "110021032", "story_v_out_110021.awb") / 1000

					if var_144_9 + var_144_3 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_3
					end

					if var_144_5.prefab_name ~= "" and arg_141_1.actors_[var_144_5.prefab_name] ~= nil then
						local var_144_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_5.prefab_name].transform, "story_v_out_110021", "110021032", "story_v_out_110021.awb")

						arg_141_1:RecordAudio("110021032", var_144_10)
						arg_141_1:RecordAudio("110021032", var_144_10)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_110021", "110021032", "story_v_out_110021.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_110021", "110021032", "story_v_out_110021.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_11 = math.max(var_144_4, arg_141_1.talkMaxDuration)

			if var_144_3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_3 + var_144_11 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_3) / var_144_11

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_3 + var_144_11 and arg_141_1.time_ < var_144_3 + var_144_11 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play110021033 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 110021033
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play110021034(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.775

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(110021033).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 31 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 31)

				if (31 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 31)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play110021034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 110021034
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play110021035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.7

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(110021034).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 28 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 28)

				if (28 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 28)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play110021035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 110021035
		arg_153_1.duration_ = 2.93

		local var_153_0 = {
			ja = 2.7,
			ko = 2.166,
			zh = 2.933,
			en = 2.7
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play110021036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.25

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(110021035)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 10 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 10)

				if (10 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 10)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021035", "story_v_out_110021.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021035", "story_v_out_110021.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_110021", "110021035", "story_v_out_110021.awb")

						arg_153_1:RecordAudio("110021035", var_156_6)
						arg_153_1:RecordAudio("110021035", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_110021", "110021035", "story_v_out_110021.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_110021", "110021035", "story_v_out_110021.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play110021036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 110021036
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play110021037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.875

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(110021036).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 35 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 35)

				if (35 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 35)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play110021037 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 110021037
		arg_161_1.duration_ = 10.27

		local var_161_0 = {
			ja = 10.266,
			ko = 8.733,
			zh = 8,
			en = 8.066
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play110021038(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.9

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(110021037)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 34 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 34)

				if (34 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 34)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021037", "story_v_out_110021.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021037", "story_v_out_110021.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_110021", "110021037", "story_v_out_110021.awb")

						arg_161_1:RecordAudio("110021037", var_164_6)
						arg_161_1:RecordAudio("110021037", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_110021", "110021037", "story_v_out_110021.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_110021", "110021037", "story_v_out_110021.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play110021038 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 110021038
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play110021039(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.2

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(110021038).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 8 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 8)

				if (8 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 8)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play110021039 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 110021039
		arg_169_1.duration_ = 16.23

		local var_169_0 = {
			ja = 14.933,
			ko = 16.233,
			zh = 15.4,
			en = 13.6
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play110021040(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.5

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(110021039)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 60 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 60)

				if (60 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 60)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021039", "story_v_out_110021.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021039", "story_v_out_110021.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_110021", "110021039", "story_v_out_110021.awb")

						arg_169_1:RecordAudio("110021039", var_172_6)
						arg_169_1:RecordAudio("110021039", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_110021", "110021039", "story_v_out_110021.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_110021", "110021039", "story_v_out_110021.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play110021040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 110021040
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play110021041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.925

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(110021040).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 37 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 37)

				if (37 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 37)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play110021041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 110021041
		arg_177_1.duration_ = 6.97

		local var_177_0 = {
			ja = 5.733,
			ko = 6.133,
			zh = 6.933,
			en = 6.966
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
				arg_177_0:Play110021042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.775

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(110021041)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 31 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 31)

				if (31 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 31)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021041", "story_v_out_110021.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021041", "story_v_out_110021.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_110021", "110021041", "story_v_out_110021.awb")

						arg_177_1:RecordAudio("110021041", var_180_6)
						arg_177_1:RecordAudio("110021041", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_110021", "110021041", "story_v_out_110021.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_110021", "110021041", "story_v_out_110021.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play110021042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 110021042
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play110021043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.2

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(110021042).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 48 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 48)

				if (48 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 48)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play110021043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 110021043
		arg_185_1.duration_ = 9.33

		local var_185_0 = {
			ja = 7.9,
			ko = 9.333,
			zh = 7.933,
			en = 8.4
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
				arg_185_0:Play110021044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(110021043)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 40 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 40)

				if (40 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 40)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021043", "story_v_out_110021.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_110021", "110021043", "story_v_out_110021.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_110021", "110021043", "story_v_out_110021.awb")

						arg_185_1:RecordAudio("110021043", var_188_6)
						arg_185_1:RecordAudio("110021043", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_110021", "110021043", "story_v_out_110021.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_110021", "110021043", "story_v_out_110021.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play110021044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 110021044
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play110021045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.925

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(110021044).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 37 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 37)

				if (37 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 37)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play110021045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 110021045
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play110021046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 1.1

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(110021045).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 44 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 44)

				if (44 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 44)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play110021046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 110021046
		arg_197_1.duration_ = 5.54

		local var_197_0 = {
			ja = 5.541,
			ko = 4.941,
			zh = 5.041,
			en = 5.408
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play110021047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 1.5 < arg_197_1.time_ and arg_197_1.time_ <= 1.5 + arg_200_0 then
				local var_200_0 = arg_197_1.bgs_.ST18

				arg_197_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_1 = var_200_0:GetComponent("SpriteRenderer")

				if var_200_1 and var_200_1.sprite then
					local var_200_2 = 2 * (var_200_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_0.transform.localScale = Vector3.New(var_200_2 / var_200_1.sprite.bounds.size.y < var_200_2 * manager.ui.mainCameraCom_.aspect / var_200_1.sprite.bounds.size.x and var_200_2 * manager.ui.mainCameraCom_.aspect / var_200_1.sprite.bounds.size.x or var_200_2 / var_200_1.sprite.bounds.size.y, var_200_2 / var_200_1.sprite.bounds.size.y < var_200_2 * manager.ui.mainCameraCom_.aspect / var_200_1.sprite.bounds.size.x and var_200_2 * manager.ui.mainCameraCom_.aspect / var_200_1.sprite.bounds.size.x or var_200_2 / var_200_1.sprite.bounds.size.y, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "ST18" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_3 = arg_197_1.bgs_.OS0101:GetComponent("SpriteRenderer")

				if var_200_3 then
					arg_197_1.var_.alphaOldValueOS0101 = var_200_3.color.a
					arg_197_1.var_.alphaMatValueOS0101 = var_200_3
				end

				arg_197_1.var_.alphaOldValueOS0101 = 1
			end

			local var_200_4 = 1.5

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				if arg_197_1.var_.alphaMatValueOS0101 then
					arg_197_1.var_.alphaMatValueOS0101.color.a = Mathf.Lerp(arg_197_1.var_.alphaOldValueOS0101, 0, (arg_197_1.time_ - 0) / var_200_4)
					arg_197_1.var_.alphaMatValueOS0101.color = arg_197_1.var_.alphaMatValueOS0101.color
				end
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 and arg_197_1.var_.alphaMatValueOS0101 then
				arg_197_1.var_.alphaMatValueOS0101.color.a = 0
				arg_197_1.var_.alphaMatValueOS0101.color = arg_197_1.var_.alphaMatValueOS0101.color
			end

			if 1.5 < arg_197_1.time_ and arg_197_1.time_ <= 1.5 + arg_200_0 then
				local var_200_5 = arg_197_1.bgs_.ST18:GetComponent("SpriteRenderer")

				if var_200_5 then
					arg_197_1.var_.alphaOldValueST18 = var_200_5.color.a
					arg_197_1.var_.alphaMatValueST18 = var_200_5
				end

				arg_197_1.var_.alphaOldValueST18 = 0
			end

			local var_200_6 = 1.5

			if 1.5 <= arg_197_1.time_ and arg_197_1.time_ < 1.5 + var_200_6 then
				if arg_197_1.var_.alphaMatValueST18 then
					arg_197_1.var_.alphaMatValueST18.color.a = Mathf.Lerp(arg_197_1.var_.alphaOldValueST18, 1, (arg_197_1.time_ - 1.5) / var_200_6)
					arg_197_1.var_.alphaMatValueST18.color = arg_197_1.var_.alphaMatValueST18.color
				end
			end

			if arg_197_1.time_ >= 1.5 + var_200_6 and arg_197_1.time_ < 1.5 + var_200_6 + arg_200_0 and arg_197_1.var_.alphaMatValueST18 then
				arg_197_1.var_.alphaMatValueST18.color.a = 1
				arg_197_1.var_.alphaMatValueST18.color = arg_197_1.var_.alphaMatValueST18.color
			end

			local var_200_7 = arg_197_1.actors_["1111ui_story"].transform

			if 2.4 < arg_197_1.time_ and arg_197_1.time_ <= 2.4 + arg_200_0 then
				arg_197_1.var_.moveOldPos1111ui_story = var_200_7.localPosition
			end

			local var_200_8 = 0.001

			if 2.4 <= arg_197_1.time_ and arg_197_1.time_ < 2.4 + var_200_8 then
				var_200_7.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_197_1.time_ - 2.4) / var_200_8)
				var_200_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_7.position).x, (manager.ui.mainCamera.transform.position - var_200_7.position).y, (manager.ui.mainCamera.transform.position - var_200_7.position).z)
				var_200_7.localEulerAngles.z = 0
				var_200_7.localEulerAngles.x = 0
				var_200_7.localEulerAngles = var_200_7.localEulerAngles
			end

			if arg_197_1.time_ >= 2.4 + var_200_8 and arg_197_1.time_ < 2.4 + var_200_8 + arg_200_0 then
				var_200_7.localPosition = Vector3.New(0, -0.87, -5.7)
				var_200_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_7.position).x, (manager.ui.mainCamera.transform.position - var_200_7.position).y, (manager.ui.mainCamera.transform.position - var_200_7.position).z)
				var_200_7.localEulerAngles.z = 0
				var_200_7.localEulerAngles.x = 0
				var_200_7.localEulerAngles = var_200_7.localEulerAngles
			end

			if 2.4 < arg_197_1.time_ and arg_197_1.time_ <= 2.4 + arg_200_0 then
				arg_197_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 2.4 < arg_197_1.time_ and arg_197_1.time_ <= 2.4 + arg_200_0 then
				arg_197_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_200_9 = arg_197_1.actors_["1111ui_story"]

			if 2.4 < arg_197_1.time_ and arg_197_1.time_ <= 2.4 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1111ui_story == nil then
				arg_197_1.var_.characterEffect1111ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_10 = 0.2

			if 2.4 <= arg_197_1.time_ and arg_197_1.time_ < 2.4 + var_200_10 and not isNil(var_200_9) then
				if arg_197_1.var_.characterEffect1111ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 2.4 + var_200_10 and arg_197_1.time_ < 2.4 + var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1111ui_story then
				arg_197_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_12 = 2.675
			local var_200_13 = 0.325

			if 2.675 < arg_197_1.time_ and arg_197_1.time_ <= var_200_12 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_14 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_14:setOnUpdate(LuaHelper.FloatAction(function(arg_201_0)
					arg_197_1.dialogCg_.alpha = arg_201_0
				end))
				var_200_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_15 = arg_197_1:GetWordFromCfg(110021046)
				local var_200_16 = arg_197_1:FormatText(var_200_15.content)

				arg_197_1.text_.text = var_200_16

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_18 = 13 <= 0 and var_200_13 or var_200_13 * (utf8.len(var_200_16) / 13)

				if (13 <= 0 and var_200_13 or var_200_13 * (utf8.len(var_200_16) / 13)) > 0 and var_200_13 < var_200_18 then
					arg_197_1.talkMaxDuration = var_200_18
					var_200_12 = var_200_12 + 0.3

					if var_200_18 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_18 + var_200_12
					end
				end

				arg_197_1.text_.text = var_200_16
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021046", "story_v_out_110021.awb") ~= 0 then
					local var_200_19 = manager.audio:GetVoiceLength("story_v_out_110021", "110021046", "story_v_out_110021.awb") / 1000

					if var_200_19 + var_200_12 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_19 + var_200_12
					end

					if var_200_15.prefab_name ~= "" and arg_197_1.actors_[var_200_15.prefab_name] ~= nil then
						local var_200_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_15.prefab_name].transform, "story_v_out_110021", "110021046", "story_v_out_110021.awb")

						arg_197_1:RecordAudio("110021046", var_200_20)
						arg_197_1:RecordAudio("110021046", var_200_20)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_110021", "110021046", "story_v_out_110021.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_110021", "110021046", "story_v_out_110021.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_21 = var_200_12 + 0.3
			local var_200_22 = math.max(var_200_13, arg_197_1.talkMaxDuration)

			if var_200_12 + 0.3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_21 + var_200_22 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_21) / var_200_22

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_21 + var_200_22 and arg_197_1.time_ < var_200_21 + var_200_22 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play110021047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 110021047
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play110021048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1111ui_story"]) and arg_203_1.var_.characterEffect1111ui_story == nil then
				arg_203_1.var_.characterEffect1111ui_story = arg_203_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1111ui_story"]) then
				if arg_203_1.var_.characterEffect1111ui_story and not isNil(arg_203_1.actors_["1111ui_story"]) then
					arg_203_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1111ui_story"]) and arg_203_1.var_.characterEffect1111ui_story then
				arg_203_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.875

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(110021047).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 34 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 34)

				if (34 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 34)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play110021048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 110021048
		arg_207_1.duration_ = 5.53

		local var_207_0 = {
			ja = 1.999999999999,
			ko = 5.333,
			zh = 5.266,
			en = 5.533
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
				arg_207_0:Play110021049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1111ui_story = arg_207_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1111ui_story"].transform.position).z)
				arg_207_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1111ui_story"].transform.localEulerAngles = arg_207_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_207_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1111ui_story"].transform.position).z)
				arg_207_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1111ui_story"].transform.localEulerAngles = arg_207_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action454")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_210_1 = arg_207_1.actors_["1111ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1111ui_story == nil then
				arg_207_1.var_.characterEffect1111ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1111ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1111ui_story then
				arg_207_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_210_4 = 0
			local var_210_5 = 0.65

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(110021048)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 23 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 23)

				if (23 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 23)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021048", "story_v_out_110021.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_110021", "110021048", "story_v_out_110021.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_out_110021", "110021048", "story_v_out_110021.awb")

						arg_207_1:RecordAudio("110021048", var_210_11)
						arg_207_1:RecordAudio("110021048", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_110021", "110021048", "story_v_out_110021.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_110021", "110021048", "story_v_out_110021.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play110021049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 110021049
		arg_211_1.duration_ = 8.4

		local var_211_0 = {
			ja = 8.4,
			ko = 4.533,
			zh = 4.933,
			en = 2.7
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
				arg_211_0:Play110021050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_214_0 = 0
			local var_214_1 = 0.475

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(110021049)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 18 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 18)

				if (18 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 18)) > 0 and var_214_1 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021049", "story_v_out_110021.awb") ~= 0 then
					local var_214_6 = manager.audio:GetVoiceLength("story_v_out_110021", "110021049", "story_v_out_110021.awb") / 1000

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end

					if var_214_2.prefab_name ~= "" and arg_211_1.actors_[var_214_2.prefab_name] ~= nil then
						local var_214_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_2.prefab_name].transform, "story_v_out_110021", "110021049", "story_v_out_110021.awb")

						arg_211_1:RecordAudio("110021049", var_214_7)
						arg_211_1:RecordAudio("110021049", var_214_7)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_110021", "110021049", "story_v_out_110021.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_110021", "110021049", "story_v_out_110021.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play110021050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 110021050
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play110021051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1111ui_story"]) and arg_215_1.var_.characterEffect1111ui_story == nil then
				arg_215_1.var_.characterEffect1111ui_story = arg_215_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1111ui_story"]) then
				if arg_215_1.var_.characterEffect1111ui_story and not isNil(arg_215_1.actors_["1111ui_story"]) then
					arg_215_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1111ui_story"]) and arg_215_1.var_.characterEffect1111ui_story then
				arg_215_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.65

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

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

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(110021050).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 26 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 26)

				if (26 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 26)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play110021051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 110021051
		arg_219_1.duration_ = 13

		local var_219_0 = {
			ja = 13,
			ko = 3.766,
			zh = 4,
			en = 4.6
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
				arg_219_0:Play110021052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_222_0 = arg_219_1.actors_["1111ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1111ui_story == nil then
				arg_219_1.var_.characterEffect1111ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_1 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 and not isNil(var_222_0) then
				if arg_219_1.var_.characterEffect1111ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1111ui_story then
				arg_219_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action442")
			end

			local var_222_3 = 0
			local var_222_4 = 0.475

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_5 = arg_219_1:GetWordFromCfg(110021051)
				local var_222_6 = arg_219_1:FormatText(var_222_5.content)

				arg_219_1.text_.text = var_222_6

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_8 = 19 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_6) / 19)

				if (19 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_6) / 19)) > 0 and var_222_4 < var_222_8 then
					arg_219_1.talkMaxDuration = var_222_8

					if var_222_8 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_3
					end
				end

				arg_219_1.text_.text = var_222_6
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021051", "story_v_out_110021.awb") ~= 0 then
					local var_222_9 = manager.audio:GetVoiceLength("story_v_out_110021", "110021051", "story_v_out_110021.awb") / 1000

					if var_222_9 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_3
					end

					if var_222_5.prefab_name ~= "" and arg_219_1.actors_[var_222_5.prefab_name] ~= nil then
						local var_222_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_5.prefab_name].transform, "story_v_out_110021", "110021051", "story_v_out_110021.awb")

						arg_219_1:RecordAudio("110021051", var_222_10)
						arg_219_1:RecordAudio("110021051", var_222_10)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_110021", "110021051", "story_v_out_110021.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_110021", "110021051", "story_v_out_110021.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_11 = math.max(var_222_4, arg_219_1.talkMaxDuration)

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_11 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_3) / var_222_11

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_3 + var_222_11 and arg_219_1.time_ < var_222_3 + var_222_11 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play110021052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 110021052
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play110021053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0.533333333333333 < arg_223_1.time_ and arg_223_1.time_ <= 0.533333333333333 + arg_226_0 then
				arg_223_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_226_0 = 0.6

			if 0.533333333333333 <= arg_223_1.time_ and arg_223_1.time_ < 0.533333333333333 + var_226_0 then
				local var_226_1, var_226_2 = math.modf((arg_223_1.time_ - 0.533333333333333) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_226_2 * 0.13, var_226_2 * 0.13, var_226_2 * 0.13) + arg_223_1.var_.shakeOldPos
			end

			if arg_223_1.time_ >= 0.533333333333333 + var_226_0 and arg_223_1.time_ < 0.533333333333333 + var_226_0 + arg_226_0 then
				manager.ui.mainCamera.transform.localPosition = arg_223_1.var_.shakeOldPos
			end

			local var_226_3 = arg_223_1.actors_["1111ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1111ui_story = var_226_3.localPosition
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_3.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_4)
				var_226_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_3.position).x, (manager.ui.mainCamera.transform.position - var_226_3.position).y, (manager.ui.mainCamera.transform.position - var_226_3.position).z)
				var_226_3.localEulerAngles.z = 0
				var_226_3.localEulerAngles.x = 0
				var_226_3.localEulerAngles = var_226_3.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_3.localPosition = Vector3.New(0, 100, 0)
				var_226_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_3.position).x, (manager.ui.mainCamera.transform.position - var_226_3.position).y, (manager.ui.mainCamera.transform.position - var_226_3.position).z)
				var_226_3.localEulerAngles.z = 0
				var_226_3.localEulerAngles.x = 0
				var_226_3.localEulerAngles = var_226_3.localEulerAngles
			end

			local var_226_5 = 0
			local var_226_6 = 1

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(110021052).content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 40 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_7) / 40)

				if (40 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_7) / 40)) > 0 and var_226_6 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_6, arg_223_1.talkMaxDuration)

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_5) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_5 + var_226_10 and arg_223_1.time_ < var_226_5 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play110021053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 110021053
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play110021054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1.55

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(110021053).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 62 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 62)

				if (62 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 62)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play110021054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 110021054
		arg_231_1.duration_ = 6.57

		local var_231_0 = {
			ja = 2.866,
			ko = 6.566,
			zh = 5.4,
			en = 5.666
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play110021055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_234_0 = arg_231_1.actors_["1111ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1111ui_story == nil then
				arg_231_1.var_.characterEffect1111ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_1 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 and not isNil(var_234_0) then
				if arg_231_1.var_.characterEffect1111ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1111ui_story then
				arg_231_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_234_3 = arg_231_1.actors_["1111ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1111ui_story = var_234_3.localPosition
			end

			local var_234_4 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				var_234_3.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_231_1.time_ - 0) / var_234_4)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			local var_234_5 = 0
			local var_234_6 = 0.675

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(110021054)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 27 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 27)

				if (27 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 27)) > 0 and var_234_6 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021054", "story_v_out_110021.awb") ~= 0 then
					local var_234_11 = manager.audio:GetVoiceLength("story_v_out_110021", "110021054", "story_v_out_110021.awb") / 1000

					if var_234_11 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_5
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_out_110021", "110021054", "story_v_out_110021.awb")

						arg_231_1:RecordAudio("110021054", var_234_12)
						arg_231_1:RecordAudio("110021054", var_234_12)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_110021", "110021054", "story_v_out_110021.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_110021", "110021054", "story_v_out_110021.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_13 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_13 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_13

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_13 and arg_231_1.time_ < var_234_5 + var_234_13 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play110021055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 110021055
		arg_235_1.duration_ = 11.43

		local var_235_0 = {
			ja = 5.8,
			ko = 11.433,
			zh = 8.666,
			en = 8.4
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play110021056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_238_0 = 0
			local var_238_1 = 0.95

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(110021055)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 38 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 38)

				if (38 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 38)) > 0 and var_238_1 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021055", "story_v_out_110021.awb") ~= 0 then
					local var_238_6 = manager.audio:GetVoiceLength("story_v_out_110021", "110021055", "story_v_out_110021.awb") / 1000

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end

					if var_238_2.prefab_name ~= "" and arg_235_1.actors_[var_238_2.prefab_name] ~= nil then
						local var_238_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_2.prefab_name].transform, "story_v_out_110021", "110021055", "story_v_out_110021.awb")

						arg_235_1:RecordAudio("110021055", var_238_7)
						arg_235_1:RecordAudio("110021055", var_238_7)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_110021", "110021055", "story_v_out_110021.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_110021", "110021055", "story_v_out_110021.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play110021056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 110021056
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play110021057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1111ui_story"]) and arg_239_1.var_.characterEffect1111ui_story == nil then
				arg_239_1.var_.characterEffect1111ui_story = arg_239_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1111ui_story"]) then
				if arg_239_1.var_.characterEffect1111ui_story and not isNil(arg_239_1.actors_["1111ui_story"]) then
					arg_239_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1111ui_story"]) and arg_239_1.var_.characterEffect1111ui_story then
				arg_239_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.8

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(110021056).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 32 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 32)

				if (32 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 32)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play110021057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 110021057
		arg_243_1.duration_ = 11.57

		local var_243_0 = {
			ja = 11.566,
			ko = 7.6,
			zh = 8.766,
			en = 10.1
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
				arg_243_0:Play110021058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_246_0 = arg_243_1.actors_["1111ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1111ui_story == nil then
				arg_243_1.var_.characterEffect1111ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_1 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 and not isNil(var_246_0) then
				if arg_243_1.var_.characterEffect1111ui_story and not isNil(var_246_0) then
					arg_243_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1111ui_story then
				arg_243_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action454")
			end

			local var_246_3 = 0
			local var_246_4 = 1.225

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_3 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_5 = arg_243_1:GetWordFromCfg(110021057)
				local var_246_6 = arg_243_1:FormatText(var_246_5.content)

				arg_243_1.text_.text = var_246_6

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_8 = 29 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_6) / 29)

				if (29 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_6) / 29)) > 0 and var_246_4 < var_246_8 then
					arg_243_1.talkMaxDuration = var_246_8

					if var_246_8 + var_246_3 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_3
					end
				end

				arg_243_1.text_.text = var_246_6
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021057", "story_v_out_110021.awb") ~= 0 then
					local var_246_9 = manager.audio:GetVoiceLength("story_v_out_110021", "110021057", "story_v_out_110021.awb") / 1000

					if var_246_9 + var_246_3 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_3
					end

					if var_246_5.prefab_name ~= "" and arg_243_1.actors_[var_246_5.prefab_name] ~= nil then
						local var_246_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_5.prefab_name].transform, "story_v_out_110021", "110021057", "story_v_out_110021.awb")

						arg_243_1:RecordAudio("110021057", var_246_10)
						arg_243_1:RecordAudio("110021057", var_246_10)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_110021", "110021057", "story_v_out_110021.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_110021", "110021057", "story_v_out_110021.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_11 = math.max(var_246_4, arg_243_1.talkMaxDuration)

			if var_246_3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_3 + var_246_11 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_3) / var_246_11

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_3 + var_246_11 and arg_243_1.time_ < var_246_3 + var_246_11 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play110021058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 110021058
		arg_247_1.duration_ = 9.03

		local var_247_0 = {
			ja = 7.166,
			ko = 8.133,
			zh = 9.033,
			en = 8
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
				arg_247_0:Play110021059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_250_0 = 0
			local var_250_1 = 0.925

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(110021058)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 37 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_3) / 37)

				if (37 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_3) / 37)) > 0 and var_250_1 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021058", "story_v_out_110021.awb") ~= 0 then
					local var_250_6 = manager.audio:GetVoiceLength("story_v_out_110021", "110021058", "story_v_out_110021.awb") / 1000

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end

					if var_250_2.prefab_name ~= "" and arg_247_1.actors_[var_250_2.prefab_name] ~= nil then
						local var_250_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_2.prefab_name].transform, "story_v_out_110021", "110021058", "story_v_out_110021.awb")

						arg_247_1:RecordAudio("110021058", var_250_7)
						arg_247_1:RecordAudio("110021058", var_250_7)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_110021", "110021058", "story_v_out_110021.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_110021", "110021058", "story_v_out_110021.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_8 and arg_247_1.time_ < var_250_0 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play110021059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 110021059
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play110021060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1111ui_story"]) and arg_251_1.var_.characterEffect1111ui_story == nil then
				arg_251_1.var_.characterEffect1111ui_story = arg_251_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1111ui_story"]) then
				if arg_251_1.var_.characterEffect1111ui_story and not isNil(arg_251_1.actors_["1111ui_story"]) then
					arg_251_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1111ui_story"]) and arg_251_1.var_.characterEffect1111ui_story then
				arg_251_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.1

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

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

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(110021059).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 4 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 4)

				if (4 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 4)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play110021060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 110021060
		arg_255_1.duration_ = 11.1

		local var_255_0 = {
			ja = 8.8,
			ko = 11.1,
			zh = 10,
			en = 7.033
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
				arg_255_0:Play110021061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1111ui_story"]) and arg_255_1.var_.characterEffect1111ui_story == nil then
				arg_255_1.var_.characterEffect1111ui_story = arg_255_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1111ui_story"]) then
				if arg_255_1.var_.characterEffect1111ui_story and not isNil(arg_255_1.actors_["1111ui_story"]) then
					arg_255_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1111ui_story"]) and arg_255_1.var_.characterEffect1111ui_story then
				arg_255_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action446")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_258_2 = 0
			local var_258_3 = 1.15

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:GetWordFromCfg(110021060)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 44 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 44)

				if (44 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 44)) > 0 and var_258_3 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110021", "110021060", "story_v_out_110021.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_110021", "110021060", "story_v_out_110021.awb") / 1000

					if var_258_8 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_2
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_out_110021", "110021060", "story_v_out_110021.awb")

						arg_255_1:RecordAudio("110021060", var_258_9)
						arg_255_1:RecordAudio("110021060", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_110021", "110021060", "story_v_out_110021.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_110021", "110021060", "story_v_out_110021.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_10 and arg_255_1.time_ < var_258_2 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play110021061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 110021061
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
			arg_259_1.auto_ = false
		end

		function arg_259_1.playNext_(arg_261_0)
			arg_259_1.onStoryFinished_()
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1111ui_story"]) and arg_259_1.var_.characterEffect1111ui_story == nil then
				arg_259_1.var_.characterEffect1111ui_story = arg_259_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1111ui_story"]) then
				if arg_259_1.var_.characterEffect1111ui_story and not isNil(arg_259_1.actors_["1111ui_story"]) then
					arg_259_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1111ui_story"]) and arg_259_1.var_.characterEffect1111ui_story then
				arg_259_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.25

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

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

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(110021061).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 10 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 10)

				if (10 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 10)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/B12a",
		"TextureConfig/Background/OS0101"
	},
	voices = {
		"story_v_out_110021.awb"
	}
}
