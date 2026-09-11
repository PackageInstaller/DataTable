return {
	Play122132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_1_battle_city", "bgm_activity_2_1_battle_city", "bgm_activity_2_1_battle_city.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_1_battle_city", "bgm_activity_2_1_battle_city")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 0.85

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(122132001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 34 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 34)

				if (34 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 34)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play122132002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122132002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play122132003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(122132002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 10 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 10)

				if (10 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 10)) > 0 and var_12_0 < var_12_3 then
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
	Play122132003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122132003
		arg_13_1.duration_ = 7

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play122132004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.bgs_.XH0507 == nil then
				local var_16_0 = Object.Instantiate(arg_13_1.paintGo_)

				var_16_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0507")
				var_16_0.name = "XH0507"
				var_16_0.transform.parent = arg_13_1.stage_.transform
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.bgs_.XH0507 = var_16_0
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_1 = arg_13_1.bgs_.XH0507

				arg_13_1.bgs_.XH0507.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_16_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_16_2 = var_16_1:GetComponent("SpriteRenderer")

				if var_16_2 and var_16_2.sprite then
					local var_16_3 = 2 * (var_16_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_16_1.transform.localScale = Vector3.New(var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, var_16_3 / var_16_2.sprite.bounds.size.y < var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x and var_16_3 * manager.ui.mainCameraCom_.aspect / var_16_2.sprite.bounds.size.x or var_16_3 / var_16_2.sprite.bounds.size.y, 0)
				end

				for iter_16_0, iter_16_1 in pairs(arg_13_1.bgs_) do
					if iter_16_0 ~= "XH0507" then
						iter_16_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_16_4 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.mask_.enabled = true
				arg_13_1.mask_.raycastTarget = true

				arg_13_1:SetGaussion(false)
			end

			local var_16_5 = 2

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_5 then
				local var_16_6 = Color.New(0, 0, 0)

				var_16_6.a = Mathf.Lerp(1, 0, (arg_13_1.time_ - var_16_4) / var_16_5)
				arg_13_1.mask_.color = var_16_6
			end

			if arg_13_1.time_ >= var_16_4 + var_16_5 and arg_13_1.time_ < var_16_4 + var_16_5 + arg_16_0 then
				local var_16_7 = Color.New(0, 0, 0)

				arg_13_1.mask_.enabled = false
				var_16_7.a = 0
				arg_13_1.mask_.color = var_16_7
			end

			local var_16_8 = arg_13_1.bgs_.XH0507.transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPosXH0507 = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPosXH0507, Vector3.New(0, 1, 9.5), (arg_13_1.time_ - 0) / var_16_9)
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_16_10 = arg_13_1.bgs_.XH0507.transform

			if 0.0166666666666667 < arg_13_1.time_ and arg_13_1.time_ <= 0.0166666666666667 + arg_16_0 then
				arg_13_1.var_.moveOldPosXH0507 = var_16_10.localPosition
			end

			local var_16_11 = 1.98333333333333

			if 0.0166666666666667 <= arg_13_1.time_ and arg_13_1.time_ < 0.0166666666666667 + var_16_11 then
				var_16_10.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPosXH0507, Vector3.New(0, 1, 10), (arg_13_1.time_ - 0.0166666666666667) / var_16_11)
			end

			if arg_13_1.time_ >= 0.0166666666666667 + var_16_11 and arg_13_1.time_ < 0.0166666666666667 + var_16_11 + arg_16_0 then
				var_16_10.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_12 = 2
			local var_16_13 = 0.75

			if 2 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_14 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_14:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(122132003).content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 30 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 30)

				if (30 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 30)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17
					var_16_12 = var_16_12 + 0.3

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = var_16_12 + 0.3
			local var_16_19 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_18 + var_16_19 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_18) / var_16_19

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_18 + var_16_19 and arg_13_1.time_ < var_16_18 + var_16_19 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0507",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0507",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play122132004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 122132004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play122132005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.8

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(122132004).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 32 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 32)

				if (32 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 32)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play122132005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 122132005
		arg_23_1.duration_ = 5

		local var_23_0 = {
			ja = 5,
			ko = 3.266,
			zh = 3.266
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play122132006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.275

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:GetWordFromCfg(122132005)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 11 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 11)

				if (11 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 11)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132005", "story_v_out_122132.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132005", "story_v_out_122132.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_122132", "122132005", "story_v_out_122132.awb")

						arg_23_1:RecordAudio("122132005", var_26_6)
						arg_23_1:RecordAudio("122132005", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_122132", "122132005", "story_v_out_122132.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_122132", "122132005", "story_v_out_122132.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play122132006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 122132006
		arg_27_1.duration_ = 7

		local var_27_0 = {
			ja = 6.9,
			ko = 7,
			zh = 7
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
				arg_27_0:Play122132007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.725

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_1 = arg_27_1:GetWordFromCfg(122132006)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 29 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 29)

				if (29 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 29)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132006", "story_v_out_122132.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132006", "story_v_out_122132.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_122132", "122132006", "story_v_out_122132.awb")

						arg_27_1:RecordAudio("122132006", var_30_6)
						arg_27_1:RecordAudio("122132006", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_122132", "122132006", "story_v_out_122132.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_122132", "122132006", "story_v_out_122132.awb")
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
	Play122132007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 122132007
		arg_31_1.duration_ = 7.27

		local var_31_0 = {
			ja = 7.266,
			ko = 4.633,
			zh = 4.633
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play122132008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.525

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:GetWordFromCfg(122132007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 21 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 21)

				if (21 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 21)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132007", "story_v_out_122132.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132007", "story_v_out_122132.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_122132", "122132007", "story_v_out_122132.awb")

						arg_31_1:RecordAudio("122132007", var_34_6)
						arg_31_1:RecordAudio("122132007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_122132", "122132007", "story_v_out_122132.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_122132", "122132007", "story_v_out_122132.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play122132008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122132008
		arg_35_1.duration_ = 4.2

		local var_35_0 = {
			ja = 3.333,
			ko = 4.2,
			zh = 4.2
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
				arg_35_0:Play122132009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.15

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(122132008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 6 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 6)

				if (6 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 6)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132008", "story_v_out_122132.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132008", "story_v_out_122132.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_122132", "122132008", "story_v_out_122132.awb")

						arg_35_1:RecordAudio("122132008", var_38_6)
						arg_35_1:RecordAudio("122132008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_122132", "122132008", "story_v_out_122132.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_122132", "122132008", "story_v_out_122132.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play122132009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 122132009
		arg_39_1.duration_ = 11.3

		local var_39_0 = {
			ja = 8.066,
			ko = 11.3,
			zh = 11.3
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play122132010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.225

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:GetWordFromCfg(122132009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 49 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 49)

				if (49 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 49)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132009", "story_v_out_122132.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132009", "story_v_out_122132.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_122132", "122132009", "story_v_out_122132.awb")

						arg_39_1:RecordAudio("122132009", var_42_6)
						arg_39_1:RecordAudio("122132009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_122132", "122132009", "story_v_out_122132.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_122132", "122132009", "story_v_out_122132.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play122132010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 122132010
		arg_43_1.duration_ = 5.1

		local var_43_0 = {
			ja = 4.466,
			ko = 5.1,
			zh = 5.1
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
				arg_43_0:Play122132011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.425

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(122132010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 17 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 17)

				if (17 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 17)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132010", "story_v_out_122132.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132010", "story_v_out_122132.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_122132", "122132010", "story_v_out_122132.awb")

						arg_43_1:RecordAudio("122132010", var_46_6)
						arg_43_1:RecordAudio("122132010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_122132", "122132010", "story_v_out_122132.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_122132", "122132010", "story_v_out_122132.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play122132011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 122132011
		arg_47_1.duration_ = 6

		local var_47_0 = {
			ja = 5.933,
			ko = 6,
			zh = 6
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play122132012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.675

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(122132011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 27 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 27)

				if (27 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 27)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132011", "story_v_out_122132.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132011", "story_v_out_122132.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_122132", "122132011", "story_v_out_122132.awb")

						arg_47_1:RecordAudio("122132011", var_50_6)
						arg_47_1:RecordAudio("122132011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_122132", "122132011", "story_v_out_122132.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_122132", "122132011", "story_v_out_122132.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play122132012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 122132012
		arg_51_1.duration_ = 5.1

		local var_51_0 = {
			ja = 4.433,
			ko = 5.1,
			zh = 5.1
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
				arg_51_0:Play122132013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.4

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(122132012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 16 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 16)

				if (16 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 16)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132012", "story_v_out_122132.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132012", "story_v_out_122132.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_122132", "122132012", "story_v_out_122132.awb")

						arg_51_1:RecordAudio("122132012", var_54_6)
						arg_51_1:RecordAudio("122132012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_122132", "122132012", "story_v_out_122132.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_122132", "122132012", "story_v_out_122132.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play122132013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 122132013
		arg_55_1.duration_ = 7.27

		local var_55_0 = {
			ja = 7.266,
			ko = 5.533,
			zh = 5.533
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play122132014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.6

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(122132013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 24 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 24)

				if (24 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 24)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132013", "story_v_out_122132.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132013", "story_v_out_122132.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_122132", "122132013", "story_v_out_122132.awb")

						arg_55_1:RecordAudio("122132013", var_58_6)
						arg_55_1:RecordAudio("122132013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_122132", "122132013", "story_v_out_122132.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_122132", "122132013", "story_v_out_122132.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play122132014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 122132014
		arg_59_1.duration_ = 7.47

		local var_59_0 = {
			ja = 7.466,
			ko = 4.366,
			zh = 4.366
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
				arg_59_0:Play122132015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.425

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(122132014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 17 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 17)

				if (17 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 17)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132014", "story_v_out_122132.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132014", "story_v_out_122132.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_122132", "122132014", "story_v_out_122132.awb")

						arg_59_1:RecordAudio("122132014", var_62_6)
						arg_59_1:RecordAudio("122132014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_122132", "122132014", "story_v_out_122132.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_122132", "122132014", "story_v_out_122132.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play122132015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 122132015
		arg_63_1.duration_ = 9

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play122132016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if arg_63_1.bgs_.J11 == nil then
				local var_66_0 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J11")
				var_66_0.name = "J11"
				var_66_0.transform.parent = arg_63_1.stage_.transform
				var_66_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_.J11 = var_66_0
			end

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				local var_66_1 = arg_63_1.bgs_.J11

				arg_63_1.bgs_.J11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_2 = var_66_1:GetComponent("SpriteRenderer")

				if var_66_2 and var_66_2.sprite then
					local var_66_3 = 2 * (var_66_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_1.transform.localScale = Vector3.New(var_66_3 / var_66_2.sprite.bounds.size.y < var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x and var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x or var_66_3 / var_66_2.sprite.bounds.size.y, var_66_3 / var_66_2.sprite.bounds.size.y < var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x and var_66_3 * manager.ui.mainCameraCom_.aspect / var_66_2.sprite.bounds.size.x or var_66_3 / var_66_2.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "J11" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_4 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_5 = 2

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_5 then
				local var_66_6 = Color.New(0, 0, 0)

				var_66_6.a = Mathf.Lerp(0, 1, (arg_63_1.time_ - var_66_4) / var_66_5)
				arg_63_1.mask_.color = var_66_6
			end

			if arg_63_1.time_ >= var_66_4 + var_66_5 and arg_63_1.time_ < var_66_4 + var_66_5 + arg_66_0 then
				local var_66_7 = Color.New(0, 0, 0)

				var_66_7.a = 1
				arg_63_1.mask_.color = var_66_7
			end

			local var_66_8 = 2

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = true

				arg_63_1:SetGaussion(false)
			end

			local var_66_9 = 2

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 then
				local var_66_10 = Color.New(0, 0, 0)

				var_66_10.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - var_66_8) / var_66_9)
				arg_63_1.mask_.color = var_66_10
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 then
				local var_66_11 = Color.New(0, 0, 0)

				arg_63_1.mask_.enabled = false
				var_66_11.a = 0
				arg_63_1.mask_.color = var_66_11
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_12 = 4
			local var_66_13 = 1.325

			if 4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_12 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_14 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_14:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_15 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(122132015).content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_17 = 53 <= 0 and var_66_13 or var_66_13 * (utf8.len(var_66_15) / 53)

				if (53 <= 0 and var_66_13 or var_66_13 * (utf8.len(var_66_15) / 53)) > 0 and var_66_13 < var_66_17 then
					arg_63_1.talkMaxDuration = var_66_17
					var_66_12 = var_66_12 + 0.3

					if var_66_17 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_17 + var_66_12
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_18 = var_66_12 + 0.3
			local var_66_19 = math.max(var_66_13, arg_63_1.talkMaxDuration)

			if var_66_12 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_18 + var_66_19 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_18) / var_66_19

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_18 + var_66_19 and arg_63_1.time_ < var_66_18 + var_66_19 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play122132016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122132016
		arg_69_1.duration_ = 5.92

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play122132017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_0 = 1

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				local var_72_1 = Color.New(1, 1, 1)

				var_72_1.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.mask_.color = var_72_1
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				local var_72_2 = Color.New(1, 1, 1)

				arg_69_1.mask_.enabled = false
				var_72_2.a = 0
				arg_69_1.mask_.color = var_72_2
			end

			local var_72_3 = manager.ui.mainCamera.transform

			if 0.8 < arg_69_1.time_ and arg_69_1.time_ <= 0.8 + arg_72_0 then
				arg_69_1.var_.shakeOldPos = var_72_3.localPosition
			end

			local var_72_4 = 0.4

			if 0.8 <= arg_69_1.time_ and arg_69_1.time_ < 0.8 + var_72_4 then
				local var_72_5, var_72_6 = math.modf((arg_69_1.time_ - 0.8) / 0.066)

				var_72_3.localPosition = Vector3.New(var_72_6 * 0.13, var_72_6 * 0.13, var_72_6 * 0.13) + arg_69_1.var_.shakeOldPos
			end

			if arg_69_1.time_ >= 0.8 + var_72_4 and arg_69_1.time_ < 0.8 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = arg_69_1.var_.shakeOldPos
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_gun02", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_8 = 0.924999999999
			local var_72_9 = 0.075

			if 0.924999999999 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_10 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_10:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_11 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(122132016).content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 3 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 3)

				if (3 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 3)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13
					var_72_8 = var_72_8 + 0.3

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = var_72_8 + 0.3
			local var_72_15 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_14) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_14 + var_72_15 and arg_69_1.time_ < var_72_14 + var_72_15 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play122132017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 122132017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play122132018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.4

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(122132017).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 56 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 56)

				if (56 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 56)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play122132018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 122132018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play122132019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_gunshot", "")
			end

			local var_82_1 = 0
			local var_82_2 = 1.525

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(122132018).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 61 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 61)

				if (61 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 61)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play122132019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 122132019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play122132020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.225

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(122132019).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 49 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 49)

				if (49 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 49)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play122132020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 122132020
		arg_87_1.duration_ = 3.7

		local var_87_0 = {
			ja = 3.7,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play122132021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.actors_["10037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10037ui_story"))) then
				local var_90_0 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_87_1.stage_.transform)

				var_90_0.name = "10037ui_story"
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["10037ui_story"] = var_90_0

				local var_90_1 = var_90_0:GetComponentInChildren(typeof(CharacterEffect))

				var_90_1.enabled = true

				local var_90_2 = GameObjectTools.GetOrAddComponent(var_90_0, typeof(DynamicBoneHelper))

				if var_90_2 then
					var_90_2:EnableDynamicBone(false)
				end

				arg_87_1:ShowWeapon(var_90_1.transform, false)

				arg_87_1.var_["10037ui_story" .. "Animator"] = var_90_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_87_1.var_["10037ui_story" .. "Animator"].applyRootMotion = true
				arg_87_1.var_["10037ui_story" .. "LipSync"] = var_90_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_90_3 = arg_87_1.actors_["10037ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10037ui_story = var_90_3.localPosition
			end

			local var_90_4 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				var_90_3.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_87_1.time_ - 0) / var_90_4)
				var_90_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_3.position).x, (manager.ui.mainCamera.transform.position - var_90_3.position).y, (manager.ui.mainCamera.transform.position - var_90_3.position).z)
				var_90_3.localEulerAngles.z = 0
				var_90_3.localEulerAngles.x = 0
				var_90_3.localEulerAngles = var_90_3.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				var_90_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_90_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_3.position).x, (manager.ui.mainCamera.transform.position - var_90_3.position).y, (manager.ui.mainCamera.transform.position - var_90_3.position).z)
				var_90_3.localEulerAngles.z = 0
				var_90_3.localEulerAngles.x = 0
				var_90_3.localEulerAngles = var_90_3.localEulerAngles
			end

			local var_90_5 = arg_87_1.actors_["10037ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.characterEffect10037ui_story == nil then
				arg_87_1.var_.characterEffect10037ui_story = var_90_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_6 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_6 and not isNil(var_90_5) then
				if arg_87_1.var_.characterEffect10037ui_story and not isNil(var_90_5) then
					arg_87_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_6 and arg_87_1.time_ < 0 + var_90_6 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.characterEffect10037ui_story then
				arg_87_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_90_8 = 0
			local var_90_9 = 0.125

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:GetWordFromCfg(122132020)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 5 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 5)

				if (5 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 5)) > 0 and var_90_9 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132020", "story_v_out_122132.awb") ~= 0 then
					local var_90_14 = manager.audio:GetVoiceLength("story_v_out_122132", "122132020", "story_v_out_122132.awb") / 1000

					if var_90_14 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_8
					end

					if var_90_10.prefab_name ~= "" and arg_87_1.actors_[var_90_10.prefab_name] ~= nil then
						local var_90_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_10.prefab_name].transform, "story_v_out_122132", "122132020", "story_v_out_122132.awb")

						arg_87_1:RecordAudio("122132020", var_90_15)
						arg_87_1:RecordAudio("122132020", var_90_15)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_122132", "122132020", "story_v_out_122132.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_122132", "122132020", "story_v_out_122132.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_16 and arg_87_1.time_ < var_90_8 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play122132021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 122132021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play122132022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10037ui_story = arg_91_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10037ui_story"].transform.position).z)
				arg_91_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10037ui_story"].transform.localEulerAngles = arg_91_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10037ui_story"].transform.position).z)
				arg_91_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10037ui_story"].transform.localEulerAngles = arg_91_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["10037ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10037ui_story == nil then
				arg_91_1.var_.characterEffect10037ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect10037ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_2)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10037ui_story then
				arg_91_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_94_3 = 0
			local var_94_4 = 1.125

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_5 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(122132021).content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 45 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 45)

				if (45 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 45)) > 0 and var_94_4 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_3 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_3
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_4, arg_91_1.talkMaxDuration)

			if var_94_3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_3 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_3) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_3 + var_94_8 and arg_91_1.time_ < var_94_3 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
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
	Play122132022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 122132022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play122132023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 1.475

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(122132022).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 59 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 59)

				if (59 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 59)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play122132023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 122132023
		arg_99_1.duration_ = 6.93

		local var_99_0 = {
			ja = 5.9,
			ko = 6.933,
			zh = 6.933
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
				arg_99_0:Play122132024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if arg_99_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_102_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_99_1.stage_.transform)

				var_102_0.name = "1184ui_story"
				var_102_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1184ui_story"] = var_102_0

				local var_102_1 = var_102_0:GetComponentInChildren(typeof(CharacterEffect))

				var_102_1.enabled = true

				local var_102_2 = GameObjectTools.GetOrAddComponent(var_102_0, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(false)
				end

				arg_99_1:ShowWeapon(var_102_1.transform, false)

				arg_99_1.var_["1184ui_story" .. "Animator"] = var_102_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_99_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_99_1.var_["1184ui_story" .. "LipSync"] = var_102_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_102_3 = arg_99_1.actors_["1184ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1184ui_story = var_102_3.localPosition
			end

			local var_102_4 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				var_102_3.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_99_1.time_ - 0) / var_102_4)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				var_102_3.localPosition = Vector3.New(0, -0.97, -6)
				var_102_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_3.position).x, (manager.ui.mainCamera.transform.position - var_102_3.position).y, (manager.ui.mainCamera.transform.position - var_102_3.position).z)
				var_102_3.localEulerAngles.z = 0
				var_102_3.localEulerAngles.x = 0
				var_102_3.localEulerAngles = var_102_3.localEulerAngles
			end

			local var_102_5 = arg_99_1.actors_["1184ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect1184ui_story == nil then
				arg_99_1.var_.characterEffect1184ui_story = var_102_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_6 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 and not isNil(var_102_5) then
				if arg_99_1.var_.characterEffect1184ui_story and not isNil(var_102_5) then
					arg_99_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 and not isNil(var_102_5) and arg_99_1.var_.characterEffect1184ui_story then
				arg_99_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_102_8 = 0
			local var_102_9 = 0.35

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_10 = arg_99_1:GetWordFromCfg(122132023)
				local var_102_11 = arg_99_1:FormatText(var_102_10.content)

				arg_99_1.text_.text = var_102_11

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_13 = 14 <= 0 and var_102_9 or var_102_9 * (utf8.len(var_102_11) / 14)

				if (14 <= 0 and var_102_9 or var_102_9 * (utf8.len(var_102_11) / 14)) > 0 and var_102_9 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_8
					end
				end

				arg_99_1.text_.text = var_102_11
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132023", "story_v_out_122132.awb") ~= 0 then
					local var_102_14 = manager.audio:GetVoiceLength("story_v_out_122132", "122132023", "story_v_out_122132.awb") / 1000

					if var_102_14 + var_102_8 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_8
					end

					if var_102_10.prefab_name ~= "" and arg_99_1.actors_[var_102_10.prefab_name] ~= nil then
						local var_102_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_10.prefab_name].transform, "story_v_out_122132", "122132023", "story_v_out_122132.awb")

						arg_99_1:RecordAudio("122132023", var_102_15)
						arg_99_1:RecordAudio("122132023", var_102_15)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_122132", "122132023", "story_v_out_122132.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_122132", "122132023", "story_v_out_122132.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_9, arg_99_1.talkMaxDuration)

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_8) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_8 + var_102_16 and arg_99_1.time_ < var_102_8 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play122132024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 122132024
		arg_103_1.duration_ = 2

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play122132025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10037ui_story = arg_103_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10037ui_story, Vector3.New(0, -1.13, -6.2), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["10037ui_story"].transform.position).z)
				arg_103_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["10037ui_story"].transform.localEulerAngles = arg_103_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_103_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["10037ui_story"].transform.position).z)
				arg_103_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["10037ui_story"].transform.localEulerAngles = arg_103_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["10037ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect10037ui_story == nil then
				arg_103_1.var_.characterEffect10037ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect10037ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect10037ui_story then
				arg_103_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_106_4 = arg_103_1.actors_["1184ui_story"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1184ui_story = var_106_4.localPosition
			end

			local var_106_5 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_5 then
				var_106_4.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_5)
				var_106_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_4.position).x, (manager.ui.mainCamera.transform.position - var_106_4.position).y, (manager.ui.mainCamera.transform.position - var_106_4.position).z)
				var_106_4.localEulerAngles.z = 0
				var_106_4.localEulerAngles.x = 0
				var_106_4.localEulerAngles = var_106_4.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_5 and arg_103_1.time_ < 0 + var_106_5 + arg_106_0 then
				var_106_4.localPosition = Vector3.New(0, 100, 0)
				var_106_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_4.position).x, (manager.ui.mainCamera.transform.position - var_106_4.position).y, (manager.ui.mainCamera.transform.position - var_106_4.position).z)
				var_106_4.localEulerAngles.z = 0
				var_106_4.localEulerAngles.x = 0
				var_106_4.localEulerAngles = var_106_4.localEulerAngles
			end

			local var_106_6 = arg_103_1.actors_["1184ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect1184ui_story == nil then
				arg_103_1.var_.characterEffect1184ui_story = var_106_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_7 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 and not isNil(var_106_6) then
				if arg_103_1.var_.characterEffect1184ui_story and not isNil(var_106_6) then
					arg_103_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_7)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 and not isNil(var_106_6) and arg_103_1.var_.characterEffect1184ui_story then
				arg_103_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_106_8 = 0
			local var_106_9 = 0.05

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_10 = arg_103_1:GetWordFromCfg(122132024)
				local var_106_11 = arg_103_1:FormatText(var_106_10.content)

				arg_103_1.text_.text = var_106_11

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_13 = 2 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 2)

				if (2 <= 0 and var_106_9 or var_106_9 * (utf8.len(var_106_11) / 2)) > 0 and var_106_9 < var_106_13 then
					arg_103_1.talkMaxDuration = var_106_13

					if var_106_13 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_13 + var_106_8
					end
				end

				arg_103_1.text_.text = var_106_11
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132024", "story_v_out_122132.awb") ~= 0 then
					local var_106_14 = manager.audio:GetVoiceLength("story_v_out_122132", "122132024", "story_v_out_122132.awb") / 1000

					if var_106_14 + var_106_8 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_14 + var_106_8
					end

					if var_106_10.prefab_name ~= "" and arg_103_1.actors_[var_106_10.prefab_name] ~= nil then
						local var_106_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_10.prefab_name].transform, "story_v_out_122132", "122132024", "story_v_out_122132.awb")

						arg_103_1:RecordAudio("122132024", var_106_15)
						arg_103_1:RecordAudio("122132024", var_106_15)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_122132", "122132024", "story_v_out_122132.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_122132", "122132024", "story_v_out_122132.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_16 = math.max(var_106_9, arg_103_1.talkMaxDuration)

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_16 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_8) / var_106_16

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_8 + var_106_16 and arg_103_1.time_ < var_106_8 + var_106_16 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_103_1:InitPlayNodeList()
	end,
	Play122132025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 122132025
		arg_107_1.duration_ = 9.87

		local var_107_0 = {
			ja = 9.866,
			ko = 8.4,
			zh = 8.4
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
				arg_107_0:Play122132026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if arg_107_1.bgs_.XH0509 == nil then
				local var_110_0 = Object.Instantiate(arg_107_1.paintGo_)

				var_110_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0509")
				var_110_0.name = "XH0509"
				var_110_0.transform.parent = arg_107_1.stage_.transform
				var_110_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.bgs_.XH0509 = var_110_0
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				local var_110_1 = arg_107_1.bgs_.XH0509

				arg_107_1.bgs_.XH0509.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_110_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_110_2 = var_110_1:GetComponent("SpriteRenderer")

				if var_110_2 and var_110_2.sprite then
					local var_110_3 = 2 * (var_110_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_110_1.transform.localScale = Vector3.New(var_110_3 / var_110_2.sprite.bounds.size.y < var_110_3 * manager.ui.mainCameraCom_.aspect / var_110_2.sprite.bounds.size.x and var_110_3 * manager.ui.mainCameraCom_.aspect / var_110_2.sprite.bounds.size.x or var_110_3 / var_110_2.sprite.bounds.size.y, var_110_3 / var_110_2.sprite.bounds.size.y < var_110_3 * manager.ui.mainCameraCom_.aspect / var_110_2.sprite.bounds.size.x and var_110_3 * manager.ui.mainCameraCom_.aspect / var_110_2.sprite.bounds.size.x or var_110_3 / var_110_2.sprite.bounds.size.y, 0)
				end

				for iter_110_0, iter_110_1 in pairs(arg_107_1.bgs_) do
					if iter_110_0 ~= "XH0509" then
						iter_110_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_110_4 = 0

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_5 = 3.5

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_5 then
				local var_110_6 = Color.New(1, 1, 1)

				var_110_6.a = Mathf.Lerp(1, 0, (arg_107_1.time_ - var_110_4) / var_110_5)
				arg_107_1.mask_.color = var_110_6
			end

			if arg_107_1.time_ >= var_110_4 + var_110_5 and arg_107_1.time_ < var_110_4 + var_110_5 + arg_110_0 then
				local var_110_7 = Color.New(1, 1, 1)

				arg_107_1.mask_.enabled = false
				var_110_7.a = 0
				arg_107_1.mask_.color = var_110_7
			end

			local var_110_8 = arg_107_1.actors_["10037ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10037ui_story = var_110_8.localPosition
			end

			local var_110_9 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_9 then
				var_110_8.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_9)
				var_110_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_8.position).x, (manager.ui.mainCamera.transform.position - var_110_8.position).y, (manager.ui.mainCamera.transform.position - var_110_8.position).z)
				var_110_8.localEulerAngles.z = 0
				var_110_8.localEulerAngles.x = 0
				var_110_8.localEulerAngles = var_110_8.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_9 and arg_107_1.time_ < 0 + var_110_9 + arg_110_0 then
				var_110_8.localPosition = Vector3.New(0, 100, 0)
				var_110_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_8.position).x, (manager.ui.mainCamera.transform.position - var_110_8.position).y, (manager.ui.mainCamera.transform.position - var_110_8.position).z)
				var_110_8.localEulerAngles.z = 0
				var_110_8.localEulerAngles.x = 0
				var_110_8.localEulerAngles = var_110_8.localEulerAngles
			end

			local var_110_10 = arg_107_1.bgs_.XH0509.transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPosXH0509 = var_110_10.localPosition
			end

			local var_110_11 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_11 then
				var_110_10.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPosXH0509, Vector3.New(-0.2, 1, 0), (arg_107_1.time_ - 0) / var_110_11)
			end

			if arg_107_1.time_ >= 0 + var_110_11 and arg_107_1.time_ < 0 + var_110_11 + arg_110_0 then
				var_110_10.localPosition = Vector3.New(-0.2, 1, 0)
			end

			local var_110_12 = arg_107_1.bgs_.XH0509.transform

			if 0.0166666666666667 < arg_107_1.time_ and arg_107_1.time_ <= 0.0166666666666667 + arg_110_0 then
				arg_107_1.var_.moveOldPosXH0509 = var_110_12.localPosition
			end

			local var_110_13 = 7.5

			if 0.0166666666666667 <= arg_107_1.time_ and arg_107_1.time_ < 0.0166666666666667 + var_110_13 then
				var_110_12.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPosXH0509, Vector3.New(-0.2, 0.7, 0), (arg_107_1.time_ - 0.0166666666666667) / var_110_13)
			end

			if arg_107_1.time_ >= 0.0166666666666667 + var_110_13 and arg_107_1.time_ < 0.0166666666666667 + var_110_13 + arg_110_0 then
				var_110_12.localPosition = Vector3.New(-0.2, 0.7, 0)
			end

			local var_110_14 = 3.5

			if 3.5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_14 + arg_110_0 then
				arg_107_1.allBtn_.enabled = false
			end

			if arg_107_1.time_ >= var_110_14 + 4.01666666666667 and arg_107_1.time_ < var_110_14 + 4.01666666666667 + arg_110_0 then
				arg_107_1.allBtn_.enabled = true
			end

			local var_110_15 = 3.5
			local var_110_16 = 0.45

			if 3.5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_17 = arg_107_1:GetWordFromCfg(122132025)
				local var_110_18 = arg_107_1:FormatText(var_110_17.content)

				arg_107_1.text_.text = var_110_18

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_20 = 18 <= 0 and var_110_16 or var_110_16 * (utf8.len(var_110_18) / 18)

				if (18 <= 0 and var_110_16 or var_110_16 * (utf8.len(var_110_18) / 18)) > 0 and var_110_16 < var_110_20 then
					arg_107_1.talkMaxDuration = var_110_20

					if var_110_20 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_20 + var_110_15
					end
				end

				arg_107_1.text_.text = var_110_18
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132025", "story_v_out_122132.awb") ~= 0 then
					local var_110_21 = manager.audio:GetVoiceLength("story_v_out_122132", "122132025", "story_v_out_122132.awb") / 1000

					if var_110_21 + var_110_15 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_21 + var_110_15
					end

					if var_110_17.prefab_name ~= "" and arg_107_1.actors_[var_110_17.prefab_name] ~= nil then
						local var_110_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_17.prefab_name].transform, "story_v_out_122132", "122132025", "story_v_out_122132.awb")

						arg_107_1:RecordAudio("122132025", var_110_22)
						arg_107_1:RecordAudio("122132025", var_110_22)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_122132", "122132025", "story_v_out_122132.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_122132", "122132025", "story_v_out_122132.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_23 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_23 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_15) / var_110_23

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_15 + var_110_23 and arg_107_1.time_ < var_110_15 + var_110_23 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "XH0509",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0509",
				changeDisplayLayer = false,
				needEase = false,
				duration = 7.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play122132026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 122132026
		arg_111_1.duration_ = 9.23

		local var_111_0 = {
			ja = 9.233,
			ko = 4.666,
			zh = 4.666
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
				arg_111_0:Play122132027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.525

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(122132026)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 21 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 21)

				if (21 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 21)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132026", "story_v_out_122132.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_122132", "122132026", "story_v_out_122132.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_122132", "122132026", "story_v_out_122132.awb")

						arg_111_1:RecordAudio("122132026", var_114_6)
						arg_111_1:RecordAudio("122132026", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_122132", "122132026", "story_v_out_122132.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_122132", "122132026", "story_v_out_122132.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play122132027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 122132027
		arg_115_1.duration_ = 9.03

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
			arg_115_1.auto_ = false
		end

		function arg_115_1.playNext_(arg_117_0)
			arg_115_1.onStoryFinished_()
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			if arg_115_1.time_ >= 0 + 8 and arg_115_1.time_ < 0 + 8 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			local var_118_0 = 0
			local var_118_1 = 0.35

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(122132027)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 14 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 14)

				if (14 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 14)) > 0 and var_118_1 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122132", "122132027", "story_v_out_122132.awb") ~= 0 then
					local var_118_6 = manager.audio:GetVoiceLength("story_v_out_122132", "122132027", "story_v_out_122132.awb") / 1000

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end

					if var_118_2.prefab_name ~= "" and arg_115_1.actors_[var_118_2.prefab_name] ~= nil then
						local var_118_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_2.prefab_name].transform, "story_v_out_122132", "122132027", "story_v_out_122132.awb")

						arg_115_1:RecordAudio("122132027", var_118_7)
						arg_115_1:RecordAudio("122132027", var_118_7)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_122132", "122132027", "story_v_out_122132.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_122132", "122132027", "story_v_out_122132.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0507",
		"TextureConfig/Background/J11",
		"TextureConfig/Background/XH0509"
	},
	voices = {
		"story_v_out_122132.awb"
	}
}
