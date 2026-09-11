return {
	Play111131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111131001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.D10_1 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10_1")
				var_4_0.name = "D10_1"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.D10_1 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.D10_1

				arg_1_1.bgs_.D10_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D10_1" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.D10_1:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueD10_1 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueD10_1 = var_4_4
				end

				arg_1_1.var_.alphaOldValueD10_1 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueD10_1 then
					arg_1_1.var_.alphaMatValueD10_1.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueD10_1, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueD10_1.color = arg_1_1.var_.alphaMatValueD10_1.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueD10_1 then
				arg_1_1.var_.alphaMatValueD10_1.color.a = 1
				arg_1_1.var_.alphaMatValueD10_1.color = arg_1_1.var_.alphaMatValueD10_1.color
			end

			local var_4_6 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_6 + 2 and arg_1_1.time_ < var_4_6 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_9 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_alarmloop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 1.2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(111131001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 48 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 48)

				if (48 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 48)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play111131002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111131002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111131003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.3

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(111131002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 52 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 52)

				if (52 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 52)) > 0 and var_11_0 < var_11_3 then
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
	Play111131003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111131003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111131004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 1.25 < arg_12_1.time_ and arg_12_1.time_ <= 1.25 + arg_15_0 then
				arg_12_1:AudioAction("stop", "effect", "se_story", "se_story_alarmloop", "")
			end

			if 1.43333333333333 < arg_12_1.time_ and arg_12_1.time_ <= 1.43333333333333 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_activity_1_1", "se_story_activity_1_1_dooropen", "")
			end

			local var_15_2 = 0
			local var_15_3 = 1.25

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(111131003).content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 46 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 46)

				if (46 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_4) / 46)) > 0 and var_15_3 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_7 and arg_12_1.time_ < var_15_2 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play111131004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111131004
		arg_16_1.duration_ = 8.72

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play111131005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.bgs_.AS0104 == nil then
				local var_19_0 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "AS0104")
				var_19_0.name = "AS0104"
				var_19_0.transform.parent = arg_16_1.stage_.transform
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_.AS0104 = var_19_0
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				local var_19_1 = arg_16_1.bgs_.AS0104

				arg_16_1.bgs_.AS0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_2 = var_19_1:GetComponent("SpriteRenderer")

				if var_19_2 and var_19_2.sprite then
					local var_19_3 = 2 * (var_19_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_1.transform.localScale = Vector3.New(var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "AS0104" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_4 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = false

				arg_16_1:SetGaussion(false)
			end

			local var_19_5 = 1

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_5 then
				local var_19_6 = Color.New(1, 1, 1)

				var_19_6.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_4) / var_19_5)
				arg_16_1.mask_.color = var_19_6
			end

			if arg_16_1.time_ >= var_19_4 + var_19_5 and arg_16_1.time_ < var_19_4 + var_19_5 + arg_19_0 then
				local var_19_7 = Color.New(1, 1, 1)

				arg_16_1.mask_.enabled = false
				var_19_7.a = 0
				arg_16_1.mask_.color = var_19_7
			end

			local var_19_8 = 1.4

			if 1.4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = false

				arg_16_1:SetGaussion(false)
			end

			local var_19_9 = 1

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_9 then
				local var_19_10 = Color.New(1, 1, 1)

				var_19_10.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_8) / var_19_9)
				arg_16_1.mask_.color = var_19_10
			end

			if arg_16_1.time_ >= var_19_8 + var_19_9 and arg_16_1.time_ < var_19_8 + var_19_9 + arg_19_0 then
				local var_19_11 = Color.New(1, 1, 1)

				arg_16_1.mask_.enabled = false
				var_19_11.a = 0
				arg_16_1.mask_.color = var_19_11
			end

			local var_19_12 = 2.8

			if 2.8 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = false

				arg_16_1:SetGaussion(false)
			end

			local var_19_13 = 1

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 then
				local var_19_14 = Color.New(1, 1, 1)

				var_19_14.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_12) / var_19_13)
				arg_16_1.mask_.color = var_19_14
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 then
				local var_19_15 = Color.New(1, 1, 1)

				arg_16_1.mask_.enabled = false
				var_19_15.a = 0
				arg_16_1.mask_.color = var_19_15
			end

			local var_19_16 = arg_16_1.bgs_.AS0104.transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPosAS0104 = var_19_16.localPosition
			end

			local var_19_17 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_17 then
				var_19_16.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPosAS0104, Vector3.New(6, -1.82, -3), (arg_16_1.time_ - 0) / var_19_17)
			end

			if arg_16_1.time_ >= 0 + var_19_17 and arg_16_1.time_ < 0 + var_19_17 + arg_19_0 then
				var_19_16.localPosition = Vector3.New(6, -1.82, -3)
			end

			local var_19_18 = arg_16_1.bgs_.AS0104.transform

			if 1.4 < arg_16_1.time_ and arg_16_1.time_ <= 1.4 + arg_19_0 then
				arg_16_1.var_.moveOldPosAS0104 = var_19_18.localPosition
			end

			local var_19_19 = 0.001

			if 1.4 <= arg_16_1.time_ and arg_16_1.time_ < 1.4 + var_19_19 then
				var_19_18.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPosAS0104, Vector3.New(-5, -1.45, -1), (arg_16_1.time_ - 1.4) / var_19_19)
			end

			if arg_16_1.time_ >= 1.4 + var_19_19 and arg_16_1.time_ < 1.4 + var_19_19 + arg_19_0 then
				var_19_18.localPosition = Vector3.New(-5, -1.45, -1)
			end

			local var_19_20 = arg_16_1.bgs_.AS0104.transform

			if 2.8 < arg_16_1.time_ and arg_16_1.time_ <= 2.8 + arg_19_0 then
				arg_16_1.var_.moveOldPosAS0104 = var_19_20.localPosition
			end

			local var_19_21 = 0.001

			if 2.8 <= arg_16_1.time_ and arg_16_1.time_ < 2.8 + var_19_21 then
				var_19_20.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPosAS0104, Vector3.New(0, 1, 8.5), (arg_16_1.time_ - 2.8) / var_19_21)
			end

			if arg_16_1.time_ >= 2.8 + var_19_21 and arg_16_1.time_ < 2.8 + var_19_21 + arg_19_0 then
				var_19_20.localPosition = Vector3.New(0, 1, 8.5)
			end

			local var_19_22 = arg_16_1.bgs_.AS0104.transform

			if 2.81666666666667 < arg_16_1.time_ and arg_16_1.time_ <= 2.81666666666667 + arg_19_0 then
				arg_16_1.var_.moveOldPosAS0104 = var_19_22.localPosition
			end

			local var_19_23 = 1.68333333333333

			if 2.81666666666667 <= arg_16_1.time_ and arg_16_1.time_ < 2.81666666666667 + var_19_23 then
				var_19_22.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPosAS0104, Vector3.New(0, 1, 10), (arg_16_1.time_ - 2.81666666666667) / var_19_23)
			end

			if arg_16_1.time_ >= 2.81666666666667 + var_19_23 and arg_16_1.time_ < 2.81666666666667 + var_19_23 + arg_19_0 then
				var_19_22.localPosition = Vector3.New(0, 1, 10)
			end

			local var_19_24 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_24 + 3.725 and arg_16_1.time_ < var_19_24 + 3.725 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_25 = manager.ui.mainCamera.transform

			if 3.725 < arg_16_1.time_ and arg_16_1.time_ <= 3.725 + arg_19_0 then
				arg_16_1.var_.shakeOldPos = var_19_25.localPosition
			end

			local var_19_26 = 0.6

			if 3.725 <= arg_16_1.time_ and arg_16_1.time_ < 3.725 + var_19_26 then
				local var_19_27, var_19_28 = math.modf((arg_16_1.time_ - 3.725) / 0.066)

				var_19_25.localPosition = Vector3.New(var_19_28 * 0.13, var_19_28 * 0.13, var_19_28 * 0.13) + arg_16_1.var_.shakeOldPos
			end

			if arg_16_1.time_ >= 3.725 + var_19_26 and arg_16_1.time_ < 3.725 + var_19_26 + arg_19_0 then
				var_19_25.localPosition = arg_16_1.var_.shakeOldPos
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_29 = 3.725
			local var_19_30 = 0.075

			if 3.725 < arg_16_1.time_ and arg_16_1.time_ <= var_19_29 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_31 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_31:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_32 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(111131004).content)

				arg_16_1.text_.text = var_19_32

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_34 = 3 <= 0 and var_19_30 or var_19_30 * (utf8.len(var_19_32) / 3)

				if (3 <= 0 and var_19_30 or var_19_30 * (utf8.len(var_19_32) / 3)) > 0 and var_19_30 < var_19_34 then
					arg_16_1.talkMaxDuration = var_19_34
					var_19_29 = var_19_29 + 0.3

					if var_19_34 + var_19_29 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_34 + var_19_29
					end
				end

				arg_16_1.text_.text = var_19_32
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_35 = var_19_29 + 0.3
			local var_19_36 = math.max(var_19_30, arg_16_1.talkMaxDuration)

			if var_19_29 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_35 + var_19_36 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_35) / var_19_36

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_35 + var_19_36 and arg_16_1.time_ < var_19_35 + var_19_36 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "AS0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "AS0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "AS0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "AS0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.68333333333333,
				className = "StoryMoveNode",
				startTime = 2.81666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play111131005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 111131005
		arg_22_1.duration_ = 1.43

		local var_22_0 = {
			ja = 1.433,
			ko = 0.999999999999,
			zh = 1.2,
			en = 1.2
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play111131006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.075

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(111131005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 3 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 3)

				if (3 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 3)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131005", "story_v_out_111131.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131005", "story_v_out_111131.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_111131", "111131005", "story_v_out_111131.awb")

						arg_22_1:RecordAudio("111131005", var_25_6)
						arg_22_1:RecordAudio("111131005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_111131", "111131005", "story_v_out_111131.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_111131", "111131005", "story_v_out_111131.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play111131006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 111131006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play111131007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 1.025

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(111131006).content)

				arg_26_1.text_.text = var_29_1

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_3 = 41 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 41)

				if (41 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 41)) > 0 and var_29_0 < var_29_3 then
					arg_26_1.talkMaxDuration = var_29_3

					if var_29_3 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_3 + 0
					end
				end

				arg_26_1.text_.text = var_29_1
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_4 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_4

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play111131007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 111131007
		arg_30_1.duration_ = 5.53

		local var_30_0 = {
			ja = 5.533,
			ko = 3.233,
			zh = 5.4,
			en = 2.966
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play111131008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.325

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[183].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:GetWordFromCfg(111131007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 13 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 13)

				if (13 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 13)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131007", "story_v_out_111131.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131007", "story_v_out_111131.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_111131", "111131007", "story_v_out_111131.awb")

						arg_30_1:RecordAudio("111131007", var_33_6)
						arg_30_1:RecordAudio("111131007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_111131", "111131007", "story_v_out_111131.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_111131", "111131007", "story_v_out_111131.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play111131008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 111131008
		arg_34_1.duration_ = 8.43

		local var_34_0 = {
			ja = 8.433,
			ko = 7.033,
			zh = 6,
			en = 5.833
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
				arg_34_0:Play111131009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.625

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[183].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_1 = arg_34_1:GetWordFromCfg(111131008)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 25 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 25)

				if (25 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 25)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131008", "story_v_out_111131.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131008", "story_v_out_111131.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_111131", "111131008", "story_v_out_111131.awb")

						arg_34_1:RecordAudio("111131008", var_37_6)
						arg_34_1:RecordAudio("111131008", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_111131", "111131008", "story_v_out_111131.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_111131", "111131008", "story_v_out_111131.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play111131009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 111131009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play111131010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.625

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(111131009).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 25 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 25)

				if (25 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 25)) > 0 and var_41_0 < var_41_3 then
					arg_38_1.talkMaxDuration = var_41_3

					if var_41_3 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_3 + 0
					end
				end

				arg_38_1.text_.text = var_41_1
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_4 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_4

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play111131010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 111131010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play111131011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.325

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(111131010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 13 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 13)

				if (13 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 13)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play111131011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 111131011
		arg_46_1.duration_ = 8.93

		local var_46_0 = {
			ja = 8.933,
			ko = 8.8,
			zh = 7.966,
			en = 5.333
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play111131012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.8

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[183].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_1 = arg_46_1:GetWordFromCfg(111131011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 22 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 22)

				if (22 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 22)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131011", "story_v_out_111131.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131011", "story_v_out_111131.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_111131", "111131011", "story_v_out_111131.awb")

						arg_46_1:RecordAudio("111131011", var_49_6)
						arg_46_1:RecordAudio("111131011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_111131", "111131011", "story_v_out_111131.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_111131", "111131011", "story_v_out_111131.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play111131012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 111131012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play111131013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.7

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(111131012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 28 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 28)

				if (28 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 28)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play111131013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 111131013
		arg_54_1.duration_ = 16.23

		local var_54_0 = {
			ja = 14.6,
			ko = 16.233,
			zh = 11.333,
			en = 7.3
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
				arg_54_0:Play111131014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 1.15

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[183].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:GetWordFromCfg(111131013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 42 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 42)

				if (42 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 42)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131013", "story_v_out_111131.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131013", "story_v_out_111131.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_111131", "111131013", "story_v_out_111131.awb")

						arg_54_1:RecordAudio("111131013", var_57_6)
						arg_54_1:RecordAudio("111131013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_111131", "111131013", "story_v_out_111131.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_111131", "111131013", "story_v_out_111131.awb")
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
	Play111131014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 111131014
		arg_58_1.duration_ = 8.9

		local var_58_0 = {
			ja = 7.9,
			ko = 6.866,
			zh = 6.266,
			en = 8.9
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
				arg_58_0:Play111131015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.625

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[183].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(111131014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 21 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 21)

				if (21 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 21)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131014", "story_v_out_111131.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131014", "story_v_out_111131.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_111131", "111131014", "story_v_out_111131.awb")

						arg_58_1:RecordAudio("111131014", var_61_6)
						arg_58_1:RecordAudio("111131014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_111131", "111131014", "story_v_out_111131.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_111131", "111131014", "story_v_out_111131.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play111131015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 111131015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play111131016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.0166666666666667

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(111131015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 16 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 16)

				if (16 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 16)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play111131016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 111131016
		arg_66_1.duration_ = 8.83

		local var_66_0 = {
			ja = 8.833,
			ko = 8.233,
			zh = 7.933,
			en = 6.966
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
				arg_66_0:Play111131017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.825

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[183].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_1 = arg_66_1:GetWordFromCfg(111131016)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 33 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 33)

				if (33 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 33)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131016", "story_v_out_111131.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131016", "story_v_out_111131.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_111131", "111131016", "story_v_out_111131.awb")

						arg_66_1:RecordAudio("111131016", var_69_6)
						arg_66_1:RecordAudio("111131016", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_111131", "111131016", "story_v_out_111131.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_111131", "111131016", "story_v_out_111131.awb")
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
	Play111131017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 111131017
		arg_70_1.duration_ = 7.1

		local var_70_0 = {
			ja = 6.866,
			ko = 6.066,
			zh = 7,
			en = 7.1
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
				arg_70_0:Play111131018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.8

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[183].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(111131017)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 32 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 32)

				if (32 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 32)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131017", "story_v_out_111131.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131017", "story_v_out_111131.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_111131", "111131017", "story_v_out_111131.awb")

						arg_70_1:RecordAudio("111131017", var_73_6)
						arg_70_1:RecordAudio("111131017", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_111131", "111131017", "story_v_out_111131.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_111131", "111131017", "story_v_out_111131.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play111131018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 111131018
		arg_74_1.duration_ = 17.6

		local var_74_0 = {
			ja = 17.6,
			ko = 15.6,
			zh = 14.966,
			en = 10.2
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
				arg_74_0:Play111131019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 1.225 < arg_74_1.time_ and arg_74_1.time_ <= 1.225 + arg_77_0 then
				arg_74_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_77_0 = 0.6

			if 1.225 <= arg_74_1.time_ and arg_74_1.time_ < 1.225 + var_77_0 then
				local var_77_1, var_77_2 = math.modf((arg_74_1.time_ - 1.225) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_77_2 * 0.13, var_77_2 * 0.13, var_77_2 * 0.13) + arg_74_1.var_.shakeOldPos
			end

			if arg_74_1.time_ >= 1.225 + var_77_0 and arg_74_1.time_ < 1.225 + var_77_0 + arg_77_0 then
				manager.ui.mainCamera.transform.localPosition = arg_74_1.var_.shakeOldPos
			end

			local var_77_3 = 0
			local var_77_4 = 1.225

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_3 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_5 = arg_74_1:GetWordFromCfg(111131018)
				local var_77_6 = arg_74_1:FormatText(var_77_5.content)

				arg_74_1.text_.text = var_77_6

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_8 = 50 <= 0 and var_77_4 or var_77_4 * (utf8.len(var_77_6) / 50)

				if (50 <= 0 and var_77_4 or var_77_4 * (utf8.len(var_77_6) / 50)) > 0 and var_77_4 < var_77_8 then
					arg_74_1.talkMaxDuration = var_77_8

					if var_77_8 + var_77_3 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_3
					end
				end

				arg_74_1.text_.text = var_77_6
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131018", "story_v_out_111131.awb") ~= 0 then
					local var_77_9 = manager.audio:GetVoiceLength("story_v_out_111131", "111131018", "story_v_out_111131.awb") / 1000

					if var_77_9 + var_77_3 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_3
					end

					if var_77_5.prefab_name ~= "" and arg_74_1.actors_[var_77_5.prefab_name] ~= nil then
						local var_77_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_5.prefab_name].transform, "story_v_out_111131", "111131018", "story_v_out_111131.awb")

						arg_74_1:RecordAudio("111131018", var_77_10)
						arg_74_1:RecordAudio("111131018", var_77_10)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_111131", "111131018", "story_v_out_111131.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_111131", "111131018", "story_v_out_111131.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_11 = math.max(var_77_4, arg_74_1.talkMaxDuration)

			if var_77_3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_3 + var_77_11 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_3) / var_77_11

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_3 + var_77_11 and arg_74_1.time_ < var_77_3 + var_77_11 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play111131019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 111131019
		arg_78_1.duration_ = 8.5

		local var_78_0 = {
			ja = 4.333,
			ko = 5.3,
			zh = 8.5,
			en = 5.566
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
				arg_78_0:Play111131020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.65

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(111131019)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 19 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 19)

				if (19 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 19)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131019", "story_v_out_111131.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131019", "story_v_out_111131.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_111131", "111131019", "story_v_out_111131.awb")

						arg_78_1:RecordAudio("111131019", var_81_6)
						arg_78_1:RecordAudio("111131019", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_111131", "111131019", "story_v_out_111131.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_111131", "111131019", "story_v_out_111131.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play111131020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 111131020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play111131021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.95

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(111131020).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 38 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 38)

				if (38 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 38)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play111131021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 111131021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play111131022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.475

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(111131021).content)

				arg_86_1.text_.text = var_89_1

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_3 = 59 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 59)

				if (59 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 59)) > 0 and var_89_0 < var_89_3 then
					arg_86_1.talkMaxDuration = var_89_3

					if var_89_3 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_3 + 0
					end
				end

				arg_86_1.text_.text = var_89_1
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_4 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_4

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play111131022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 111131022
		arg_90_1.duration_ = 8.57

		local var_90_0 = {
			ja = 8.566,
			ko = 7,
			zh = 7.233,
			en = 6.2
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
				arg_90_0:Play111131023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.65

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:GetWordFromCfg(111131022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 26 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 26)

				if (26 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 26)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131022", "story_v_out_111131.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131022", "story_v_out_111131.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_111131", "111131022", "story_v_out_111131.awb")

						arg_90_1:RecordAudio("111131022", var_93_6)
						arg_90_1:RecordAudio("111131022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_111131", "111131022", "story_v_out_111131.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_111131", "111131022", "story_v_out_111131.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play111131023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111131023
		arg_94_1.duration_ = 7.8

		local var_94_0 = {
			ja = 6.233,
			ko = 5.5,
			zh = 7.8,
			en = 5.833
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
				arg_94_0:Play111131024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.575

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:GetWordFromCfg(111131023)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 23 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 23)

				if (23 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 23)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131023", "story_v_out_111131.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131023", "story_v_out_111131.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_111131", "111131023", "story_v_out_111131.awb")

						arg_94_1:RecordAudio("111131023", var_97_6)
						arg_94_1:RecordAudio("111131023", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_111131", "111131023", "story_v_out_111131.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_111131", "111131023", "story_v_out_111131.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play111131024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111131024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play111131025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.55

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(111131024).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 22 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 22)

				if (22 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 22)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play111131025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111131025
		arg_102_1.duration_ = 6.53

		local var_102_0 = {
			ja = 3.733,
			ko = 6.533,
			zh = 3,
			en = 1.866
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
				arg_102_0:Play111131026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.275

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_1 = arg_102_1:GetWordFromCfg(111131025)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 11 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 11)

				if (11 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 11)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131025", "story_v_out_111131.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_111131", "111131025", "story_v_out_111131.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_111131", "111131025", "story_v_out_111131.awb")

						arg_102_1:RecordAudio("111131025", var_105_6)
						arg_102_1:RecordAudio("111131025", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_111131", "111131025", "story_v_out_111131.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_111131", "111131025", "story_v_out_111131.awb")
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
	Play111131026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 111131026
		arg_106_1.duration_ = 3.4

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
			arg_106_1.auto_ = false
		end

		function arg_106_1.playNext_(arg_108_0)
			arg_106_1.onStoryFinished_()
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_109_0 = 0.6

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				local var_109_1, var_109_2 = math.modf((arg_106_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_109_2 * 0.13, var_109_2 * 0.13, var_109_2 * 0.13) + arg_106_1.var_.shakeOldPos
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				manager.ui.mainCamera.transform.localPosition = arg_106_1.var_.shakeOldPos
			end

			local var_109_3 = 0
			local var_109_4 = 0.075

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_3 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2027")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_5 = arg_106_1:GetWordFromCfg(111131026)
				local var_109_6 = arg_106_1:FormatText(var_109_5.content)

				arg_106_1.text_.text = var_109_6

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_8 = 3 <= 0 and var_109_4 or var_109_4 * (utf8.len(var_109_6) / 3)

				if (3 <= 0 and var_109_4 or var_109_4 * (utf8.len(var_109_6) / 3)) > 0 and var_109_4 < var_109_8 then
					arg_106_1.talkMaxDuration = var_109_8

					if var_109_8 + var_109_3 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_3
					end
				end

				arg_106_1.text_.text = var_109_6
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111131", "111131026", "story_v_out_111131.awb") ~= 0 then
					local var_109_9 = manager.audio:GetVoiceLength("story_v_out_111131", "111131026", "story_v_out_111131.awb") / 1000

					if var_109_9 + var_109_3 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_3
					end

					if var_109_5.prefab_name ~= "" and arg_106_1.actors_[var_109_5.prefab_name] ~= nil then
						local var_109_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_5.prefab_name].transform, "story_v_out_111131", "111131026", "story_v_out_111131.awb")

						arg_106_1:RecordAudio("111131026", var_109_10)
						arg_106_1:RecordAudio("111131026", var_109_10)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_111131", "111131026", "story_v_out_111131.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_111131", "111131026", "story_v_out_111131.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_11 = math.max(var_109_4, arg_106_1.talkMaxDuration)

			if var_109_3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_3 + var_109_11 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_3) / var_109_11

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_3 + var_109_11 and arg_106_1.time_ < var_109_3 + var_109_11 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D10_1",
		"TextureConfig/Background/AS0104"
	},
	voices = {
		"story_v_out_111131.awb"
	}
}
