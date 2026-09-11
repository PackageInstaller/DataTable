return {
	Play319001001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319001001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319001002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.ML0101 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0101")
				var_4_0.name = "ML0101"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ML0101 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ML0101

				arg_1_1.bgs_.ML0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ML0101" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_side_1055", "se_story_side_1055_rain", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_special_tallina", "bgm_activity_3_0_story_special_tallina")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = arg_1_1.bgs_.ML0101.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosML0101 = var_4_15.localPosition
			end

			local var_4_16 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_16 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosML0101, Vector3.New(0, 1, 3), (arg_1_1.time_ - 0) / var_4_16)
			end

			if arg_1_1.time_ >= 0 + var_4_16 and arg_1_1.time_ < 0 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, 1, 3)
			end

			local var_4_17 = arg_1_1.bgs_.ML0101.transform

			if 0.0166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.0166666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosML0101 = var_4_17.localPosition
			end

			local var_4_18 = 4

			if 0.0166666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.0166666666666667 + var_4_18 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosML0101, Vector3.New(-0.5, 1, 3), (arg_1_1.time_ - 0.0166666666666667) / var_4_18)
			end

			if arg_1_1.time_ >= 0.0166666666666667 + var_4_18 and arg_1_1.time_ < 0.0166666666666667 + var_4_18 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(-0.5, 1, 3)
			end

			local var_4_19 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_19 + 2.01666666666667 and arg_1_1.time_ < var_4_19 + 2.01666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_20 = arg_1_1.var_.effect桂花雨

				if not arg_1_1.var_.effect桂花雨 then
					var_4_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), manager.ui.mainCamera.transform)
					var_4_20.name = "桂花雨"
					arg_1_1.var_.effect桂花雨 = var_4_20
				else
					var_4_20.transform:SetParent(var_4_9000)
				end

				var_4_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 0.575

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

				local var_4_25 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319001001).content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 23 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 23)

				if (23 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 23)) > 0 and var_4_23 < var_4_27 then
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

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319001002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319001002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play319001003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.125

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(319001002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 45 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 45)

				if (45 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 45)) > 0 and var_12_0 < var_12_3 then
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
	Play319001003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319001003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319001004(arg_13_1)
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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(319001003).content)

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
	Play319001004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319001004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319001005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.6

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(319001004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 64 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 64)

				if (64 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 64)) > 0 and var_20_0 < var_20_3 then
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
	Play319001005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319001005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319001006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.875

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(319001005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 35 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 35)

				if (35 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 35)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319001006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319001006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319001007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.725

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(319001006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 29 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 29)

				if (29 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 29)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319001007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319001007
		arg_29_1.duration_ = 7

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319001008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.ST71 == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71")
				var_32_0.name = "ST71"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.ST71 = var_32_0
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.ST71

				arg_29_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST71" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				if arg_29_1.var_.effect桂花雨 then
					Object.Destroy(arg_29_1.var_.effect桂花雨)

					arg_29_1.var_.effect桂花雨 = nil
				end
			end

			local var_32_5 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_6 = 2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 then
				local var_32_7 = Color.New(1, 1, 1)

				var_32_7.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_5) / var_32_6)
				arg_29_1.mask_.color = var_32_7
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 then
				local var_32_8 = Color.New(1, 1, 1)

				arg_29_1.mask_.enabled = false
				var_32_8.a = 0
				arg_29_1.mask_.color = var_32_8
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_9 = 1.999999999999
			local var_32_10 = 1.2

			if 1.999999999999 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_11 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_11:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319001007).content)

				arg_29_1.text_.text = var_32_12

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_14 = 48 <= 0 and var_32_10 or var_32_10 * (utf8.len(var_32_12) / 48)

				if (48 <= 0 and var_32_10 or var_32_10 * (utf8.len(var_32_12) / 48)) > 0 and var_32_10 < var_32_14 then
					arg_29_1.talkMaxDuration = var_32_14
					var_32_9 = var_32_9 + 0.3

					if var_32_14 + var_32_9 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_9
					end
				end

				arg_29_1.text_.text = var_32_12
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = var_32_9 + 0.3
			local var_32_16 = math.max(var_32_10, arg_29_1.talkMaxDuration)

			if var_32_9 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_16 and arg_29_1.time_ < var_32_15 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319001008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319001008
		arg_35_1.duration_ = 4.4

		local var_35_0 = {
			zh = 2.2,
			ja = 4.4
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
				arg_35_0:Play319001009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.25

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10050")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_1 = arg_35_1:GetWordFromCfg(319001008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 10 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 10)

				if (10 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 10)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001008", "story_v_out_319001.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_319001", "319001008", "story_v_out_319001.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_319001", "319001008", "story_v_out_319001.awb")

						arg_35_1:RecordAudio("319001008", var_38_6)
						arg_35_1:RecordAudio("319001008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319001", "319001008", "story_v_out_319001.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319001", "319001008", "story_v_out_319001.awb")
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
	Play319001009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319001009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play319001010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1.125

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_2 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_2:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(319001009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 45 <= 0 and var_42_1 or var_42_1 * (utf8.len(var_42_3) / 45)

				if (45 <= 0 and var_42_1 or var_42_1 * (utf8.len(var_42_3) / 45)) > 0 and var_42_1 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5
					var_42_0 = var_42_0 + 0.3

					if var_42_5 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = var_42_0 + 0.3
			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_7 and arg_39_1.time_ < var_42_6 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play319001010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319001010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play319001011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			local var_48_1 = 0
			local var_48_2 = 1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(319001010).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 40 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 40)

				if (40 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 40)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319001011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319001011
		arg_49_1.duration_ = 4.4

		local var_49_0 = {
			zh = 2.533,
			ja = 4.4
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
				arg_49_0:Play319001012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.275

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(319001011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 11 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 11)

				if (11 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 11)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001011", "story_v_out_319001.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_319001", "319001011", "story_v_out_319001.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_319001", "319001011", "story_v_out_319001.awb")

						arg_49_1:RecordAudio("319001011", var_52_6)
						arg_49_1:RecordAudio("319001011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319001", "319001011", "story_v_out_319001.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319001", "319001011", "story_v_out_319001.awb")
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
	Play319001012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319001012
		arg_53_1.duration_ = 7.23

		local var_53_0 = {
			zh = 2.433,
			ja = 7.233
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
				arg_53_0:Play319001013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.actors_["10075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10075ui_story"))) then
				local var_56_0 = Object.Instantiate(Asset.Load("Char/" .. "10075ui_story"), arg_53_1.stage_.transform)

				var_56_0.name = "10075ui_story"
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["10075ui_story"] = var_56_0

				local var_56_1 = var_56_0:GetComponentInChildren(typeof(CharacterEffect))

				var_56_1.enabled = true

				local var_56_2 = GameObjectTools.GetOrAddComponent(var_56_0, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_1.transform, false)

				arg_53_1.var_["10075ui_story" .. "Animator"] = var_56_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_["10075ui_story" .. "Animator"].applyRootMotion = true
				arg_53_1.var_["10075ui_story" .. "LipSync"] = var_56_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_3 = arg_53_1.actors_["10075ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10075ui_story = var_56_3.localPosition
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_3.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_53_1.time_ - 0) / var_56_4)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = Vector3.New(0, -0.715, -6.15)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			local var_56_5 = arg_53_1.actors_["10075ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect10075ui_story == nil then
				arg_53_1.var_.characterEffect10075ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.characterEffect10075ui_story and not isNil(var_56_5) then
					arg_53_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect10075ui_story then
				arg_53_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_8 = 0
			local var_56_9 = 0.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(319001012)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 9 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 9)

				if (9 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 9)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001012", "story_v_out_319001.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_319001", "319001012", "story_v_out_319001.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_319001", "319001012", "story_v_out_319001.awb")

						arg_53_1:RecordAudio("319001012", var_56_15)
						arg_53_1:RecordAudio("319001012", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319001", "319001012", "story_v_out_319001.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319001", "319001012", "story_v_out_319001.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play319001013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319001013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play319001014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10075ui_story"]) and arg_57_1.var_.characterEffect10075ui_story == nil then
				arg_57_1.var_.characterEffect10075ui_story = arg_57_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10075ui_story"]) then
				if arg_57_1.var_.characterEffect10075ui_story and not isNil(arg_57_1.actors_["10075ui_story"]) then
					arg_57_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10075ui_story"]) and arg_57_1.var_.characterEffect10075ui_story then
				arg_57_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 1.25

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(319001013).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 50 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 50)

				if (50 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 50)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319001014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319001014
		arg_61_1.duration_ = 8.4

		local var_61_0 = {
			zh = 4.3,
			ja = 8.4
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
				arg_61_0:Play319001015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.actors_["10069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10069ui_story"))) then
				local var_64_0 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_61_1.stage_.transform)

				var_64_0.name = "10069ui_story"
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["10069ui_story"] = var_64_0

				local var_64_1 = var_64_0:GetComponentInChildren(typeof(CharacterEffect))

				var_64_1.enabled = true

				local var_64_2 = GameObjectTools.GetOrAddComponent(var_64_0, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(false)
				end

				arg_61_1:ShowWeapon(var_64_1.transform, false)

				arg_61_1.var_["10069ui_story" .. "Animator"] = var_64_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_61_1.var_["10069ui_story" .. "Animator"].applyRootMotion = true
				arg_61_1.var_["10069ui_story" .. "LipSync"] = var_64_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_64_3 = arg_61_1.actors_["10069ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10069ui_story = var_64_3.localPosition
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10069ui_story, Vector3.New(0.7, -1.08, -6.33), (arg_61_1.time_ - 0) / var_64_4)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(0.7, -1.08, -6.33)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			local var_64_5 = arg_61_1.actors_["10069ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect10069ui_story == nil then
				arg_61_1.var_.characterEffect10069ui_story = var_64_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.characterEffect10069ui_story and not isNil(var_64_5) then
					arg_61_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.characterEffect10069ui_story then
				arg_61_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_8 = arg_61_1.actors_["10075ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10075ui_story = var_64_8.localPosition
			end

			local var_64_9 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_9 then
				var_64_8.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_61_1.time_ - 0) / var_64_9)
				var_64_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_8.position).x, (manager.ui.mainCamera.transform.position - var_64_8.position).y, (manager.ui.mainCamera.transform.position - var_64_8.position).z)
				var_64_8.localEulerAngles.z = 0
				var_64_8.localEulerAngles.x = 0
				var_64_8.localEulerAngles = var_64_8.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_9 and arg_61_1.time_ < 0 + var_64_9 + arg_64_0 then
				var_64_8.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_64_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_8.position).x, (manager.ui.mainCamera.transform.position - var_64_8.position).y, (manager.ui.mainCamera.transform.position - var_64_8.position).z)
				var_64_8.localEulerAngles.z = 0
				var_64_8.localEulerAngles.x = 0
				var_64_8.localEulerAngles = var_64_8.localEulerAngles
			end

			local var_64_10 = arg_61_1.actors_["10075ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect10075ui_story == nil then
				arg_61_1.var_.characterEffect10075ui_story = var_64_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_11 and not isNil(var_64_10) then
				if arg_61_1.var_.characterEffect10075ui_story and not isNil(var_64_10) then
					arg_61_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_11)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_11 and arg_61_1.time_ < 0 + var_64_11 + arg_64_0 and not isNil(var_64_10) and arg_61_1.var_.characterEffect10075ui_story then
				arg_61_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_64_12 = 0
			local var_64_13 = 0.5

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(319001014)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 20 <= 0 and var_64_13 or var_64_13 * (utf8.len(var_64_15) / 20)

				if (20 <= 0 and var_64_13 or var_64_13 * (utf8.len(var_64_15) / 20)) > 0 and var_64_13 < var_64_17 then
					arg_61_1.talkMaxDuration = var_64_17

					if var_64_17 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_15
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001014", "story_v_out_319001.awb") ~= 0 then
					local var_64_18 = manager.audio:GetVoiceLength("story_v_out_319001", "319001014", "story_v_out_319001.awb") / 1000

					if var_64_18 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_12
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_out_319001", "319001014", "story_v_out_319001.awb")

						arg_61_1:RecordAudio("319001014", var_64_19)
						arg_61_1:RecordAudio("319001014", var_64_19)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319001", "319001014", "story_v_out_319001.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319001", "319001014", "story_v_out_319001.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_20 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_20 and arg_61_1.time_ < var_64_12 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319001015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319001015
		arg_65_1.duration_ = 10.1

		local var_65_0 = {
			zh = 2.2,
			ja = 10.1
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
				arg_65_0:Play319001016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10075ui_story = arg_65_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10075ui_story"].transform.position).z)
				arg_65_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10075ui_story"].transform.localEulerAngles = arg_65_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_65_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10075ui_story"].transform.position).z)
				arg_65_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10075ui_story"].transform.localEulerAngles = arg_65_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["10075ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10075ui_story == nil then
				arg_65_1.var_.characterEffect10075ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect10075ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10075ui_story then
				arg_65_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_68_4 = arg_65_1.actors_["10069ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect10069ui_story == nil then
				arg_65_1.var_.characterEffect10069ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_5 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 and not isNil(var_68_4) then
				if arg_65_1.var_.characterEffect10069ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_5)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect10069ui_story then
				arg_65_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_68_6 = 0
			local var_68_7 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(319001015)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 12 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 12)

				if (12 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 12)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001015", "story_v_out_319001.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_319001", "319001015", "story_v_out_319001.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_319001", "319001015", "story_v_out_319001.awb")

						arg_65_1:RecordAudio("319001015", var_68_13)
						arg_65_1:RecordAudio("319001015", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319001", "319001015", "story_v_out_319001.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319001", "319001015", "story_v_out_319001.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play319001016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319001016
		arg_69_1.duration_ = 10.1

		local var_69_0 = {
			zh = 5.5,
			ja = 10.1
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play319001017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10075ui_story"]) and arg_69_1.var_.characterEffect10075ui_story == nil then
				arg_69_1.var_.characterEffect10075ui_story = arg_69_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10075ui_story"]) then
				if arg_69_1.var_.characterEffect10075ui_story and not isNil(arg_69_1.actors_["10075ui_story"]) then
					arg_69_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10075ui_story"]) and arg_69_1.var_.characterEffect10075ui_story then
				arg_69_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_72_1 = arg_69_1.actors_["10069ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10069ui_story == nil then
				arg_69_1.var_.characterEffect10069ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10069ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10069ui_story then
				arg_69_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_72_4 = 0
			local var_72_5 = 0.525

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(319001016)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 21 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 21)

				if (21 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 21)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001016", "story_v_out_319001.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001016", "story_v_out_319001.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_319001", "319001016", "story_v_out_319001.awb")

						arg_69_1:RecordAudio("319001016", var_72_11)
						arg_69_1:RecordAudio("319001016", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319001", "319001016", "story_v_out_319001.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319001", "319001016", "story_v_out_319001.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319001017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319001017
		arg_73_1.duration_ = 9

		local var_73_0 = {
			zh = 4.6,
			ja = 9
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
				arg_73_0:Play319001018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10075ui_story"]) and arg_73_1.var_.characterEffect10075ui_story == nil then
				arg_73_1.var_.characterEffect10075ui_story = arg_73_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10075ui_story"]) then
				if arg_73_1.var_.characterEffect10075ui_story and not isNil(arg_73_1.actors_["10075ui_story"]) then
					arg_73_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10075ui_story"]) and arg_73_1.var_.characterEffect10075ui_story then
				arg_73_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_76_2 = arg_73_1.actors_["10069ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect10069ui_story == nil then
				arg_73_1.var_.characterEffect10069ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect10069ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect10069ui_story then
				arg_73_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_76_4 = 0
			local var_76_5 = 0.425

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(319001017)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 17 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 17)

				if (17 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 17)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001017", "story_v_out_319001.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001017", "story_v_out_319001.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_319001", "319001017", "story_v_out_319001.awb")

						arg_73_1:RecordAudio("319001017", var_76_11)
						arg_73_1:RecordAudio("319001017", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319001", "319001017", "story_v_out_319001.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319001", "319001017", "story_v_out_319001.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319001018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319001018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play319001019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10075ui_story"]) and arg_77_1.var_.characterEffect10075ui_story == nil then
				arg_77_1.var_.characterEffect10075ui_story = arg_77_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10075ui_story"]) then
				if arg_77_1.var_.characterEffect10075ui_story and not isNil(arg_77_1.actors_["10075ui_story"]) then
					arg_77_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10075ui_story"]) and arg_77_1.var_.characterEffect10075ui_story then
				arg_77_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 1.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(319001018).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 57 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 57)

				if (57 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 57)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319001019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319001019
		arg_81_1.duration_ = 10

		local var_81_0 = {
			zh = 3.8,
			ja = 10
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
				arg_81_0:Play319001020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10069ui_story"]) and arg_81_1.var_.characterEffect10069ui_story == nil then
				arg_81_1.var_.characterEffect10069ui_story = arg_81_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10069ui_story"]) then
				if arg_81_1.var_.characterEffect10069ui_story and not isNil(arg_81_1.actors_["10069ui_story"]) then
					arg_81_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10069ui_story"]) and arg_81_1.var_.characterEffect10069ui_story then
				arg_81_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_84_2 = 0
			local var_84_3 = 0.45

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(319001019)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 18 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 18)

				if (18 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 18)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001019", "story_v_out_319001.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_319001", "319001019", "story_v_out_319001.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_319001", "319001019", "story_v_out_319001.awb")

						arg_81_1:RecordAudio("319001019", var_84_9)
						arg_81_1:RecordAudio("319001019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319001", "319001019", "story_v_out_319001.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319001", "319001019", "story_v_out_319001.awb")
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
	Play319001020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319001020
		arg_85_1.duration_ = 7.53

		local var_85_0 = {
			zh = 5.333,
			ja = 7.533
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play319001021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10075ui_story = arg_85_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10075ui_story"].transform.position).z)
				arg_85_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10075ui_story"].transform.localEulerAngles = arg_85_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_85_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10075ui_story"].transform.position).z)
				arg_85_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10075ui_story"].transform.localEulerAngles = arg_85_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10075ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10075ui_story == nil then
				arg_85_1.var_.characterEffect10075ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10075ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10075ui_story then
				arg_85_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = arg_85_1.actors_["10069ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect10069ui_story == nil then
				arg_85_1.var_.characterEffect10069ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_5 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 and not isNil(var_88_4) then
				if arg_85_1.var_.characterEffect10069ui_story and not isNil(var_88_4) then
					arg_85_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_5)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect10069ui_story then
				arg_85_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_88_6 = 0
			local var_88_7 = 0.55

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(319001020)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 22 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 22)

				if (22 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 22)) > 0 and var_88_7 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001020", "story_v_out_319001.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_319001", "319001020", "story_v_out_319001.awb") / 1000

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_out_319001", "319001020", "story_v_out_319001.awb")

						arg_85_1:RecordAudio("319001020", var_88_13)
						arg_85_1:RecordAudio("319001020", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319001", "319001020", "story_v_out_319001.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319001", "319001020", "story_v_out_319001.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play319001021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319001021
		arg_89_1.duration_ = 14.07

		local var_89_0 = {
			zh = 5.566,
			ja = 14.066
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319001022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10069ui_story = arg_89_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10069ui_story, Vector3.New(0.7, -1.08, -6.33), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10069ui_story"].transform.position).z)
				arg_89_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10069ui_story"].transform.localEulerAngles = arg_89_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6.33)
				arg_89_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["10069ui_story"].transform.position).z)
				arg_89_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["10069ui_story"].transform.localEulerAngles = arg_89_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["10069ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10069ui_story == nil then
				arg_89_1.var_.characterEffect10069ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect10069ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect10069ui_story then
				arg_89_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action6_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_4 = arg_89_1.actors_["10075ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect10075ui_story == nil then
				arg_89_1.var_.characterEffect10075ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect10075ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect10075ui_story then
				arg_89_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_92_6 = 0
			local var_92_7 = 0.625

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(319001021)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 25 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 25)

				if (25 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 25)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001021", "story_v_out_319001.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_319001", "319001021", "story_v_out_319001.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_319001", "319001021", "story_v_out_319001.awb")

						arg_89_1:RecordAudio("319001021", var_92_13)
						arg_89_1:RecordAudio("319001021", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319001", "319001021", "story_v_out_319001.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319001", "319001021", "story_v_out_319001.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play319001022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319001022
		arg_93_1.duration_ = 13.67

		local var_93_0 = {
			zh = 3.433,
			ja = 13.666
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319001023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10069ui_story"]) and arg_93_1.var_.characterEffect10069ui_story == nil then
				arg_93_1.var_.characterEffect10069ui_story = arg_93_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10069ui_story"]) then
				if arg_93_1.var_.characterEffect10069ui_story and not isNil(arg_93_1.actors_["10069ui_story"]) then
					arg_93_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10069ui_story"]) and arg_93_1.var_.characterEffect10069ui_story then
				arg_93_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_96_1 = arg_93_1.actors_["10075ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10075ui_story == nil then
				arg_93_1.var_.characterEffect10075ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect10075ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect10075ui_story then
				arg_93_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_96_4 = 0
			local var_96_5 = 0.45

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(319001022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 18 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 18)

				if (18 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 18)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001022", "story_v_out_319001.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001022", "story_v_out_319001.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_319001", "319001022", "story_v_out_319001.awb")

						arg_93_1:RecordAudio("319001022", var_96_11)
						arg_93_1:RecordAudio("319001022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319001", "319001022", "story_v_out_319001.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319001", "319001022", "story_v_out_319001.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319001023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319001023
		arg_97_1.duration_ = 11.83

		local var_97_0 = {
			zh = 9.8,
			ja = 11.833
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319001024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10075ui_story"]) and arg_97_1.var_.characterEffect10075ui_story == nil then
				arg_97_1.var_.characterEffect10075ui_story = arg_97_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10075ui_story"]) then
				if arg_97_1.var_.characterEffect10075ui_story and not isNil(arg_97_1.actors_["10075ui_story"]) then
					arg_97_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10075ui_story"]) and arg_97_1.var_.characterEffect10075ui_story then
				arg_97_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_100_1 = arg_97_1.actors_["10069ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10069ui_story == nil then
				arg_97_1.var_.characterEffect10069ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10069ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10069ui_story then
				arg_97_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_100_4 = 0
			local var_100_5 = 1.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(319001023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 45 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 45)

				if (45 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 45)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001023", "story_v_out_319001.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001023", "story_v_out_319001.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_319001", "319001023", "story_v_out_319001.awb")

						arg_97_1:RecordAudio("319001023", var_100_11)
						arg_97_1:RecordAudio("319001023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319001", "319001023", "story_v_out_319001.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319001", "319001023", "story_v_out_319001.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319001024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319001024
		arg_101_1.duration_ = 10.4

		local var_101_0 = {
			zh = 4.433,
			ja = 10.4
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play319001025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10075ui_story = arg_101_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10075ui_story"].transform.position).z)
				arg_101_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10075ui_story"].transform.localEulerAngles = arg_101_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_101_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10075ui_story"].transform.position).z)
				arg_101_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10075ui_story"].transform.localEulerAngles = arg_101_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["10075ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10075ui_story == nil then
				arg_101_1.var_.characterEffect10075ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect10075ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect10075ui_story then
				arg_101_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = arg_101_1.actors_["10069ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10069ui_story == nil then
				arg_101_1.var_.characterEffect10069ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect10069ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10069ui_story then
				arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_104_6 = 0
			local var_104_7 = 0.5

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(319001024)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 20 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 20)

				if (20 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 20)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001024", "story_v_out_319001.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_319001", "319001024", "story_v_out_319001.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_319001", "319001024", "story_v_out_319001.awb")

						arg_101_1:RecordAudio("319001024", var_104_13)
						arg_101_1:RecordAudio("319001024", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319001", "319001024", "story_v_out_319001.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319001", "319001024", "story_v_out_319001.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play319001025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319001025
		arg_105_1.duration_ = 7.37

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play319001026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.bgs_.STblack == nil then
				local var_108_0 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_108_0.name = "STblack"
				var_108_0.transform.parent = arg_105_1.stage_.transform
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_.STblack = var_108_0
			end

			if 0.0166666666666666 < arg_105_1.time_ and arg_105_1.time_ <= 0.0166666666666666 + arg_108_0 then
				local var_108_1 = arg_105_1.bgs_.STblack

				arg_105_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_2 = var_108_1:GetComponent("SpriteRenderer")

				if var_108_2 and var_108_2.sprite then
					local var_108_3 = 2 * (var_108_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_1.transform.localScale = Vector3.New(var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "STblack" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_4 = arg_105_1.actors_["10075ui_story"].transform

			if 0.0166666666666666 < arg_105_1.time_ and arg_105_1.time_ <= 0.0166666666666666 + arg_108_0 then
				arg_105_1.var_.moveOldPos10075ui_story = var_108_4.localPosition
			end

			local var_108_5 = 0.001

			if 0.0166666666666666 <= arg_105_1.time_ and arg_105_1.time_ < 0.0166666666666666 + var_108_5 then
				var_108_4.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0.0166666666666666) / var_108_5)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			if arg_105_1.time_ >= 0.0166666666666666 + var_108_5 and arg_105_1.time_ < 0.0166666666666666 + var_108_5 + arg_108_0 then
				var_108_4.localPosition = Vector3.New(0, 100, 0)
				var_108_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_4.position).x, (manager.ui.mainCamera.transform.position - var_108_4.position).y, (manager.ui.mainCamera.transform.position - var_108_4.position).z)
				var_108_4.localEulerAngles.z = 0
				var_108_4.localEulerAngles.x = 0
				var_108_4.localEulerAngles = var_108_4.localEulerAngles
			end

			local var_108_6 = arg_105_1.actors_["10069ui_story"].transform

			if 0.0166666666666666 < arg_105_1.time_ and arg_105_1.time_ <= 0.0166666666666666 + arg_108_0 then
				arg_105_1.var_.moveOldPos10069ui_story = var_108_6.localPosition
			end

			local var_108_7 = 0.001

			if 0.0166666666666666 <= arg_105_1.time_ and arg_105_1.time_ < 0.0166666666666666 + var_108_7 then
				var_108_6.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0.0166666666666666) / var_108_7)
				var_108_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_6.position).x, (manager.ui.mainCamera.transform.position - var_108_6.position).y, (manager.ui.mainCamera.transform.position - var_108_6.position).z)
				var_108_6.localEulerAngles.z = 0
				var_108_6.localEulerAngles.x = 0
				var_108_6.localEulerAngles = var_108_6.localEulerAngles
			end

			if arg_105_1.time_ >= 0.0166666666666666 + var_108_7 and arg_105_1.time_ < 0.0166666666666666 + var_108_7 + arg_108_0 then
				var_108_6.localPosition = Vector3.New(0, 100, 0)
				var_108_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_6.position).x, (manager.ui.mainCamera.transform.position - var_108_6.position).y, (manager.ui.mainCamera.transform.position - var_108_6.position).z)
				var_108_6.localEulerAngles.z = 0
				var_108_6.localEulerAngles.x = 0
				var_108_6.localEulerAngles = var_108_6.localEulerAngles
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.fswbg_:SetActive(true)
				arg_105_1.dialog_:SetActive(false)

				arg_105_1.fswtw_.percent = 0
				arg_105_1.fswt_.text = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(319001025).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.fswt_)

				arg_105_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_105_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_105_1.fswtw_:SetDirty()

				arg_105_1.typewritterCharCountI18N = 0

				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_105_1:ShowNextGo(false)
			end

			local var_108_8 = 0.766666666666668

			if 0.766666666666668 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.var_.oldValueTypewriter = arg_105_1.fswtw_.percent

				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_105_1:ShowNextGo(false)
			end

			local var_108_9 = 28
			local var_108_10 = 1.86666666666667
			local var_108_11, var_108_12 = arg_105_1:GetPercentByPara(arg_105_1:FormatText(arg_105_1:GetWordFromCfg(319001025).content), 1)

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				local var_108_13 = var_108_9 <= 0 and var_108_10 or var_108_10 * ((var_108_12 - arg_105_1.typewritterCharCountI18N) / var_108_9)

				if (var_108_9 <= 0 and var_108_10 or var_108_10 * ((var_108_12 - arg_105_1.typewritterCharCountI18N) / var_108_9)) > 0 and var_108_10 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end
			end

			local var_108_14 = math.max(1.86666666666667, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_14 then
				arg_105_1.fswtw_.percent = Mathf.Lerp(arg_105_1.var_.oldValueTypewriter, var_108_11, (arg_105_1.time_ - var_108_8) / var_108_14)
				arg_105_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_105_1.fswtw_:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_14 and arg_105_1.time_ < var_108_8 + var_108_14 + arg_108_0 then
				arg_105_1.fswtw_.percent = var_108_11

				arg_105_1.fswtw_:SetDirty()
				arg_105_1:ShowNextGo(true)

				arg_105_1.typewritterCharCountI18N = var_108_12
			end

			if 0.750000000000001 < arg_105_1.time_ and arg_105_1.time_ <= 0.750000000000001 + arg_108_0 then
				local var_108_15 = arg_105_1.fswbg_.transform:Find("textbox/adapt/content") or arg_105_1.fswbg_.transform:Find("textbox/content")
				local var_108_16 = arg_105_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_108_17 = var_108_15:GetComponent("RectTransform")

				var_108_15:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_108_17.offsetMin = Vector2.New(0, 0)
				var_108_17.offsetMax = Vector2.New(0, 0)
			end

			local var_108_18 = 0.766666666666668
			local var_108_19 = manager.audio:GetVoiceLength("story_v_out_319001", "319001025", "story_v_out_319001.awb") / 1000

			if var_108_19 > 0 and 6.6 < var_108_19 and var_108_19 + var_108_18 > arg_105_1.duration_ then
				arg_105_1.duration_ = var_108_19 + var_108_18
			end

			if var_108_18 < arg_105_1.time_ and arg_105_1.time_ <= var_108_18 + arg_108_0 then
				arg_105_1:AudioAction("play", "voice", "story_v_out_319001", "319001025", "story_v_out_319001.awb")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.cswbg_:SetActive(false)

				local var_108_21 = arg_105_1.cswt_:GetComponent("RectTransform")

				arg_105_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_108_21.offsetMin = Vector2.New(400, 105)
				var_108_21.offsetMax = Vector2.New(-400, -200)
				arg_105_1.cswt_.text = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(419001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.cswt_)

				arg_105_1.cswt_.fontSize = 108
				arg_105_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_105_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_105_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_105_1.cswbg_:SetActive(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play319001026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319001026
		arg_109_1.duration_ = 4.23

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play319001027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.fswbg_:SetActive(true)
				arg_109_1.dialog_:SetActive(false)

				arg_109_1.fswtw_.percent = 0
				arg_109_1.fswt_.text = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(319001026).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.fswt_)

				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_109_1.fswtw_:SetDirty()

				arg_109_1.typewritterCharCountI18N = 0

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_0 = 0.0166666666666665

			if 0.0166666666666665 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.var_.oldValueTypewriter = arg_109_1.fswtw_.percent

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_1 = 17
			local var_112_2 = 1.13333333333333
			local var_112_3, var_112_4 = arg_109_1:GetPercentByPara(arg_109_1:FormatText(arg_109_1:GetWordFromCfg(319001026).content), 1)

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				local var_112_5 = var_112_1 <= 0 and var_112_2 or var_112_2 * ((var_112_4 - arg_109_1.typewritterCharCountI18N) / var_112_1)

				if (var_112_1 <= 0 and var_112_2 or var_112_2 * ((var_112_4 - arg_109_1.typewritterCharCountI18N) / var_112_1)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_0
					end
				end
			end

			local var_112_6 = math.max(1.13333333333333, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_6 then
				arg_109_1.fswtw_.percent = Mathf.Lerp(arg_109_1.var_.oldValueTypewriter, var_112_3, (arg_109_1.time_ - var_112_0) / var_112_6)
				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_109_1.fswtw_:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_6 and arg_109_1.time_ < var_112_0 + var_112_6 + arg_112_0 then
				arg_109_1.fswtw_.percent = var_112_3

				arg_109_1.fswtw_:SetDirty()
				arg_109_1:ShowNextGo(true)

				arg_109_1.typewritterCharCountI18N = var_112_4
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				local var_112_7 = arg_109_1.fswbg_.transform:Find("textbox/adapt/content") or arg_109_1.fswbg_.transform:Find("textbox/content")
				local var_112_8 = arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_112_9 = var_112_7:GetComponent("RectTransform")

				var_112_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_112_9.offsetMin = Vector2.New(0, 0)
				var_112_9.offsetMax = Vector2.New(0, 0)
			end

			local var_112_10 = 0
			local var_112_11 = manager.audio:GetVoiceLength("story_v_out_319001", "319001026", "story_v_out_319001.awb") / 1000

			if var_112_11 > 0 and 4.233 < var_112_11 and var_112_11 + var_112_10 > arg_109_1.duration_ then
				arg_109_1.duration_ = var_112_11 + var_112_10
			end

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1:AudioAction("play", "voice", "story_v_out_319001", "319001026", "story_v_out_319001.awb")
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319001027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319001027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319001028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				local var_116_0 = arg_113_1.bgs_.ST71

				arg_113_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_1 = var_116_0:GetComponent("SpriteRenderer")

				if var_116_1 and var_116_1.sprite then
					local var_116_2 = 2 * (var_116_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_0.transform.localScale = Vector3.New(var_116_2 / var_116_1.sprite.bounds.size.y < var_116_2 * manager.ui.mainCameraCom_.aspect / var_116_1.sprite.bounds.size.x and var_116_2 * manager.ui.mainCameraCom_.aspect / var_116_1.sprite.bounds.size.x or var_116_2 / var_116_1.sprite.bounds.size.y, var_116_2 / var_116_1.sprite.bounds.size.y < var_116_2 * manager.ui.mainCameraCom_.aspect / var_116_1.sprite.bounds.size.x and var_116_2 * manager.ui.mainCameraCom_.aspect / var_116_1.sprite.bounds.size.x or var_116_2 / var_116_1.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "ST71" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.fswbg_:SetActive(false)
				arg_113_1.dialog_:SetActive(false)
				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_113_1:ShowNextGo(false)
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.cswbg_:SetActive(false)
			end

			local var_116_3 = 0
			local var_116_4 = 1.275

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_5 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_5:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(319001027).content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_8 = 51 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_6) / 51)

				if (51 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_6) / 51)) > 0 and var_116_4 < var_116_8 then
					arg_113_1.talkMaxDuration = var_116_8
					var_116_3 = var_116_3 + 0.3

					if var_116_8 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = var_116_3 + 0.3
			local var_116_10 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_9) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319001028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319001028
		arg_119_1.duration_ = 1.5

		local var_119_0 = {
			zh = 1.5,
			ja = 1.433
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
				arg_119_0:Play319001029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10075ui_story"]) and arg_119_1.var_.characterEffect10075ui_story == nil then
				arg_119_1.var_.characterEffect10075ui_story = arg_119_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10075ui_story"]) then
				if arg_119_1.var_.characterEffect10075ui_story and not isNil(arg_119_1.actors_["10075ui_story"]) then
					arg_119_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10075ui_story"]) and arg_119_1.var_.characterEffect10075ui_story then
				arg_119_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_122_2 = arg_119_1.actors_["10075ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10075ui_story = var_122_2.localPosition
			end

			local var_122_3 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 then
				var_122_2.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_119_1.time_ - 0) / var_122_3)
				var_122_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_2.position).x, (manager.ui.mainCamera.transform.position - var_122_2.position).y, (manager.ui.mainCamera.transform.position - var_122_2.position).z)
				var_122_2.localEulerAngles.z = 0
				var_122_2.localEulerAngles.x = 0
				var_122_2.localEulerAngles = var_122_2.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 then
				var_122_2.localPosition = Vector3.New(0, -0.715, -6.15)
				var_122_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_2.position).x, (manager.ui.mainCamera.transform.position - var_122_2.position).y, (manager.ui.mainCamera.transform.position - var_122_2.position).z)
				var_122_2.localEulerAngles.z = 0
				var_122_2.localEulerAngles.x = 0
				var_122_2.localEulerAngles = var_122_2.localEulerAngles
			end

			local var_122_4 = 0
			local var_122_5 = 0.1

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(319001028)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 4 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 4)

				if (4 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 4)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001028", "story_v_out_319001.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001028", "story_v_out_319001.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_319001", "319001028", "story_v_out_319001.awb")

						arg_119_1:RecordAudio("319001028", var_122_11)
						arg_119_1:RecordAudio("319001028", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319001", "319001028", "story_v_out_319001.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319001", "319001028", "story_v_out_319001.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play319001029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319001029
		arg_123_1.duration_ = 7.63

		local var_123_0 = {
			zh = 6.133,
			ja = 7.633
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
				arg_123_0:Play319001030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10075ui_story"]) and arg_123_1.var_.characterEffect10075ui_story == nil then
				arg_123_1.var_.characterEffect10075ui_story = arg_123_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10075ui_story"]) then
				if arg_123_1.var_.characterEffect10075ui_story and not isNil(arg_123_1.actors_["10075ui_story"]) then
					arg_123_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10075ui_story"]) and arg_123_1.var_.characterEffect10075ui_story then
				arg_123_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_126_1 = arg_123_1.actors_["10069ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10069ui_story == nil then
				arg_123_1.var_.characterEffect10069ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect10069ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10069ui_story then
				arg_123_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_126_4 = arg_123_1.actors_["10069ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10069ui_story = var_126_4.localPosition
			end

			local var_126_5 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				var_126_4.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10069ui_story, Vector3.New(0.7, -1.08, -6.33), (arg_123_1.time_ - 0) / var_126_5)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = Vector3.New(0.7, -1.08, -6.33)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			local var_126_6 = arg_123_1.actors_["10075ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10075ui_story = var_126_6.localPosition
			end

			local var_126_7 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				var_126_6.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_123_1.time_ - 0) / var_126_7)
				var_126_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_6.position).x, (manager.ui.mainCamera.transform.position - var_126_6.position).y, (manager.ui.mainCamera.transform.position - var_126_6.position).z)
				var_126_6.localEulerAngles.z = 0
				var_126_6.localEulerAngles.x = 0
				var_126_6.localEulerAngles = var_126_6.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				var_126_6.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_126_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_6.position).x, (manager.ui.mainCamera.transform.position - var_126_6.position).y, (manager.ui.mainCamera.transform.position - var_126_6.position).z)
				var_126_6.localEulerAngles.z = 0
				var_126_6.localEulerAngles.x = 0
				var_126_6.localEulerAngles = var_126_6.localEulerAngles
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action6_2")
			end

			local var_126_8 = 0
			local var_126_9 = 0.625

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(319001029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 25 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 25)

				if (25 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 25)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001029", "story_v_out_319001.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_319001", "319001029", "story_v_out_319001.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_319001", "319001029", "story_v_out_319001.awb")

						arg_123_1:RecordAudio("319001029", var_126_15)
						arg_123_1:RecordAudio("319001029", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319001", "319001029", "story_v_out_319001.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319001", "319001029", "story_v_out_319001.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play319001030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319001030
		arg_127_1.duration_ = 9

		local var_127_0 = {
			zh = 4.8,
			ja = 9
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
				arg_127_0:Play319001031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10075ui_story"]) and arg_127_1.var_.characterEffect10075ui_story == nil then
				arg_127_1.var_.characterEffect10075ui_story = arg_127_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10075ui_story"]) then
				if arg_127_1.var_.characterEffect10075ui_story and not isNil(arg_127_1.actors_["10075ui_story"]) then
					arg_127_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10075ui_story"]) and arg_127_1.var_.characterEffect10075ui_story then
				arg_127_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_130_2 = arg_127_1.actors_["10069ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect10069ui_story == nil then
				arg_127_1.var_.characterEffect10069ui_story = var_130_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_3 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.characterEffect10069ui_story and not isNil(var_130_2) then
					arg_127_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_3)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.characterEffect10069ui_story then
				arg_127_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_130_4 = 0
			local var_130_5 = 0.45

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(319001030)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 18 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 18)

				if (18 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 18)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001030", "story_v_out_319001.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001030", "story_v_out_319001.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_319001", "319001030", "story_v_out_319001.awb")

						arg_127_1:RecordAudio("319001030", var_130_11)
						arg_127_1:RecordAudio("319001030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319001", "319001030", "story_v_out_319001.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319001", "319001030", "story_v_out_319001.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319001031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319001031
		arg_131_1.duration_ = 5.13

		local var_131_0 = {
			zh = 5.133,
			ja = 1.533
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play319001032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10075ui_story"]) and arg_131_1.var_.characterEffect10075ui_story == nil then
				arg_131_1.var_.characterEffect10075ui_story = arg_131_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10075ui_story"]) then
				if arg_131_1.var_.characterEffect10075ui_story and not isNil(arg_131_1.actors_["10075ui_story"]) then
					arg_131_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10075ui_story"]) and arg_131_1.var_.characterEffect10075ui_story then
				arg_131_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_134_1 = arg_131_1.actors_["10069ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10069ui_story == nil then
				arg_131_1.var_.characterEffect10069ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect10069ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10069ui_story then
				arg_131_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_134_4 = 0
			local var_134_5 = 0.625

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(319001031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 25 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 25)

				if (25 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 25)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001031", "story_v_out_319001.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001031", "story_v_out_319001.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_319001", "319001031", "story_v_out_319001.awb")

						arg_131_1:RecordAudio("319001031", var_134_11)
						arg_131_1:RecordAudio("319001031", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319001", "319001031", "story_v_out_319001.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319001", "319001031", "story_v_out_319001.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319001032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319001032
		arg_135_1.duration_ = 3.6

		local var_135_0 = {
			zh = 2.3,
			ja = 3.6
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
				arg_135_0:Play319001033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10075ui_story"]) and arg_135_1.var_.characterEffect10075ui_story == nil then
				arg_135_1.var_.characterEffect10075ui_story = arg_135_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10075ui_story"]) then
				if arg_135_1.var_.characterEffect10075ui_story and not isNil(arg_135_1.actors_["10075ui_story"]) then
					arg_135_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10075ui_story"]) and arg_135_1.var_.characterEffect10075ui_story then
				arg_135_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_138_2 = arg_135_1.actors_["10069ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.characterEffect10069ui_story == nil then
				arg_135_1.var_.characterEffect10069ui_story = var_138_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_3 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.characterEffect10069ui_story and not isNil(var_138_2) then
					arg_135_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_3)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.characterEffect10069ui_story then
				arg_135_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_138_4 = 0
			local var_138_5 = 0.225

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(319001032)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 9 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 9)

				if (9 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 9)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001032", "story_v_out_319001.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001032", "story_v_out_319001.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_319001", "319001032", "story_v_out_319001.awb")

						arg_135_1:RecordAudio("319001032", var_138_11)
						arg_135_1:RecordAudio("319001032", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319001", "319001032", "story_v_out_319001.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319001", "319001032", "story_v_out_319001.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319001033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319001033
		arg_139_1.duration_ = 4.03

		local var_139_0 = {
			zh = 1.999999999999,
			ja = 4.033
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
				arg_139_0:Play319001034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10069ui_story = arg_139_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10069ui_story, Vector3.New(0.7, -1.08, -6.33), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).z)
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles = arg_139_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6.33)
				arg_139_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).z)
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles = arg_139_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10069ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10069ui_story == nil then
				arg_139_1.var_.characterEffect10069ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10069ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10069ui_story then
				arg_139_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = arg_139_1.actors_["10075ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect10075ui_story == nil then
				arg_139_1.var_.characterEffect10075ui_story = var_142_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_5 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 and not isNil(var_142_4) then
				if arg_139_1.var_.characterEffect10075ui_story and not isNil(var_142_4) then
					arg_139_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_5)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 and not isNil(var_142_4) and arg_139_1.var_.characterEffect10075ui_story then
				arg_139_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_142_6 = 0
			local var_142_7 = 0.2

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(319001033)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 8 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 8)

				if (8 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 8)) > 0 and var_142_7 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001033", "story_v_out_319001.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_319001", "319001033", "story_v_out_319001.awb") / 1000

					if var_142_12 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_6
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_out_319001", "319001033", "story_v_out_319001.awb")

						arg_139_1:RecordAudio("319001033", var_142_13)
						arg_139_1:RecordAudio("319001033", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319001", "319001033", "story_v_out_319001.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319001", "319001033", "story_v_out_319001.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play319001034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319001034
		arg_143_1.duration_ = 8.9

		local var_143_0 = {
			zh = 4.966,
			ja = 8.9
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
				arg_143_0:Play319001035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10075ui_story = arg_143_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10075ui_story"].transform.position).z)
				arg_143_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10075ui_story"].transform.localEulerAngles = arg_143_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_143_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10075ui_story"].transform.position).z)
				arg_143_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10075ui_story"].transform.localEulerAngles = arg_143_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["10075ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10075ui_story == nil then
				arg_143_1.var_.characterEffect10075ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10075ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10075ui_story then
				arg_143_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_4 = arg_143_1.actors_["10069ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect10069ui_story == nil then
				arg_143_1.var_.characterEffect10069ui_story = var_146_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_5 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 and not isNil(var_146_4) then
				if arg_143_1.var_.characterEffect10069ui_story and not isNil(var_146_4) then
					arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_5)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect10069ui_story then
				arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_146_6 = 0
			local var_146_7 = 0.45

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(319001034)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 18 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 18)

				if (18 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 18)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001034", "story_v_out_319001.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_319001", "319001034", "story_v_out_319001.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_out_319001", "319001034", "story_v_out_319001.awb")

						arg_143_1:RecordAudio("319001034", var_146_13)
						arg_143_1:RecordAudio("319001034", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319001", "319001034", "story_v_out_319001.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319001", "319001034", "story_v_out_319001.awb")
				end

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

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play319001035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319001035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319001036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10075ui_story"]) and arg_147_1.var_.characterEffect10075ui_story == nil then
				arg_147_1.var_.characterEffect10075ui_story = arg_147_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10075ui_story"]) then
				if arg_147_1.var_.characterEffect10075ui_story and not isNil(arg_147_1.actors_["10075ui_story"]) then
					arg_147_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10075ui_story"]) and arg_147_1.var_.characterEffect10075ui_story then
				arg_147_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 1.1

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(319001035).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 44 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 44)

				if (44 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 44)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319001036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319001036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play319001037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 1.55

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(319001036).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 62 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 62)

				if (62 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 62)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319001037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319001037
		arg_155_1.duration_ = 3.67

		local var_155_0 = {
			zh = 3.666,
			ja = 3.6
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
				arg_155_0:Play319001038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10075ui_story"]) and arg_155_1.var_.characterEffect10075ui_story == nil then
				arg_155_1.var_.characterEffect10075ui_story = arg_155_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10075ui_story"]) then
				if arg_155_1.var_.characterEffect10075ui_story and not isNil(arg_155_1.actors_["10075ui_story"]) then
					arg_155_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10075ui_story"]) and arg_155_1.var_.characterEffect10075ui_story then
				arg_155_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_158_2 = 0
			local var_158_3 = 0.325

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(319001037)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 13 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 13)

				if (13 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 13)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001037", "story_v_out_319001.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_319001", "319001037", "story_v_out_319001.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_319001", "319001037", "story_v_out_319001.awb")

						arg_155_1:RecordAudio("319001037", var_158_9)
						arg_155_1:RecordAudio("319001037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319001", "319001037", "story_v_out_319001.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319001", "319001037", "story_v_out_319001.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319001038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319001038
		arg_159_1.duration_ = 6.3

		local var_159_0 = {
			zh = 3.066,
			ja = 6.3
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
				arg_159_0:Play319001039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10075ui_story = arg_159_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10075ui_story"].transform.position).z)
				arg_159_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10075ui_story"].transform.localEulerAngles = arg_159_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_159_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["10075ui_story"].transform.position).z)
				arg_159_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["10075ui_story"].transform.localEulerAngles = arg_159_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_162_1 = 0
			local var_162_2 = 0.225

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(319001038)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 9 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_4) / 9)

				if (9 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_4) / 9)) > 0 and var_162_2 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001038", "story_v_out_319001.awb") ~= 0 then
					local var_162_7 = manager.audio:GetVoiceLength("story_v_out_319001", "319001038", "story_v_out_319001.awb") / 1000

					if var_162_7 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_1
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_319001", "319001038", "story_v_out_319001.awb")

						arg_159_1:RecordAudio("319001038", var_162_8)
						arg_159_1:RecordAudio("319001038", var_162_8)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319001", "319001038", "story_v_out_319001.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319001", "319001038", "story_v_out_319001.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_9 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_9 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_9

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_9 and arg_159_1.time_ < var_162_1 + var_162_9 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play319001039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319001039
		arg_163_1.duration_ = 8.97

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play319001040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 2 < arg_163_1.time_ and arg_163_1.time_ <= 2 + arg_166_0 then
				arg_163_1.var_.moveOldPos10069ui_story = arg_163_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 2 <= arg_163_1.time_ and arg_163_1.time_ < 2 + var_166_0 then
				arg_163_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 2) / var_166_0)
				arg_163_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10069ui_story"].transform.position).z)
				arg_163_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10069ui_story"].transform.localEulerAngles = arg_163_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 2 + var_166_0 and arg_163_1.time_ < 2 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10069ui_story"].transform.position).z)
				arg_163_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10069ui_story"].transform.localEulerAngles = arg_163_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["10075ui_story"].transform

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= 2 + arg_166_0 then
				arg_163_1.var_.moveOldPos10075ui_story = var_166_1.localPosition
			end

			local var_166_2 = 0.001

			if 2 <= arg_163_1.time_ and arg_163_1.time_ < 2 + var_166_2 then
				var_166_1.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 2) / var_166_2)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			if arg_163_1.time_ >= 2 + var_166_2 and arg_163_1.time_ < 2 + var_166_2 + arg_166_0 then
				var_166_1.localPosition = Vector3.New(0, 100, 0)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				local var_166_3 = arg_163_1.bgs_.ST71

				arg_163_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_166_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_4 = var_166_3:GetComponent("SpriteRenderer")

				if var_166_4 and var_166_4.sprite then
					local var_166_5 = 2 * (var_166_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_166_3.transform.localScale = Vector3.New(var_166_5 / var_166_4.sprite.bounds.size.y < var_166_5 * manager.ui.mainCameraCom_.aspect / var_166_4.sprite.bounds.size.x and var_166_5 * manager.ui.mainCameraCom_.aspect / var_166_4.sprite.bounds.size.x or var_166_5 / var_166_4.sprite.bounds.size.y, var_166_5 / var_166_4.sprite.bounds.size.y < var_166_5 * manager.ui.mainCameraCom_.aspect / var_166_4.sprite.bounds.size.x and var_166_5 * manager.ui.mainCameraCom_.aspect / var_166_4.sprite.bounds.size.x or var_166_5 / var_166_4.sprite.bounds.size.y, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "ST71" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= 2 + arg_166_0 then
				local var_166_6 = arg_163_1.bgs_.ST71

				arg_163_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_166_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_7 = var_166_6:GetComponent("SpriteRenderer")

				if var_166_7 and var_166_7.sprite then
					local var_166_8 = 2 * (var_166_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_166_6.transform.localScale = Vector3.New(var_166_8 / var_166_7.sprite.bounds.size.y < var_166_8 * manager.ui.mainCameraCom_.aspect / var_166_7.sprite.bounds.size.x and var_166_8 * manager.ui.mainCameraCom_.aspect / var_166_7.sprite.bounds.size.x or var_166_8 / var_166_7.sprite.bounds.size.y, var_166_8 / var_166_7.sprite.bounds.size.y < var_166_8 * manager.ui.mainCameraCom_.aspect / var_166_7.sprite.bounds.size.x and var_166_8 * manager.ui.mainCameraCom_.aspect / var_166_7.sprite.bounds.size.x or var_166_8 / var_166_7.sprite.bounds.size.y, 0)
				end

				for iter_166_2, iter_166_3 in pairs(arg_163_1.bgs_) do
					if iter_166_2 ~= "ST71" then
						iter_166_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_9 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_10 = 2

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_10 then
				local var_166_11 = Color.New(0, 0, 0)

				var_166_11.a = Mathf.Lerp(0, 1, (arg_163_1.time_ - var_166_9) / var_166_10)
				arg_163_1.mask_.color = var_166_11
			end

			if arg_163_1.time_ >= var_166_9 + var_166_10 and arg_163_1.time_ < var_166_9 + var_166_10 + arg_166_0 then
				local var_166_12 = Color.New(0, 0, 0)

				var_166_12.a = 1
				arg_163_1.mask_.color = var_166_12
			end

			local var_166_13 = 2

			if 2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_14 = 1.96666666666667

			if var_166_13 <= arg_163_1.time_ and arg_163_1.time_ < var_166_13 + var_166_14 then
				local var_166_15 = Color.New(0, 0, 0)

				var_166_15.a = Mathf.Lerp(1, 0, (arg_163_1.time_ - var_166_13) / var_166_14)
				arg_163_1.mask_.color = var_166_15
			end

			if arg_163_1.time_ >= var_166_13 + var_166_14 and arg_163_1.time_ < var_166_13 + var_166_14 + arg_166_0 then
				local var_166_16 = Color.New(0, 0, 0)

				arg_163_1.mask_.enabled = false
				var_166_16.a = 0
				arg_163_1.mask_.color = var_166_16
			end

			if arg_163_1.frameCnt_ <= 1 then
				arg_163_1.dialog_:SetActive(false)
			end

			local var_166_17 = 3.96666666666667
			local var_166_18 = 0.875

			if 3.96666666666667 < arg_163_1.time_ and arg_163_1.time_ <= var_166_17 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0

				arg_163_1.dialog_:SetActive(true)

				arg_163_1.dialogCg_.alpha = 0

				local var_166_19 = LeanTween.value(arg_163_1.dialog_, 0, 1, 0.3)

				var_166_19:setOnUpdate(LuaHelper.FloatAction(function(arg_167_0)
					arg_163_1.dialogCg_.alpha = arg_167_0
				end))
				var_166_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_163_1.dialog_)
					var_166_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_163_1.duration_ = arg_163_1.duration_ + 0.3

				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_20 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(319001039).content)

				arg_163_1.text_.text = var_166_20

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_22 = 35 <= 0 and var_166_18 or var_166_18 * (utf8.len(var_166_20) / 35)

				if (35 <= 0 and var_166_18 or var_166_18 * (utf8.len(var_166_20) / 35)) > 0 and var_166_18 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22
					var_166_17 = var_166_17 + 0.3

					if var_166_22 + var_166_17 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_17
					end
				end

				arg_163_1.text_.text = var_166_20
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_23 = var_166_17 + 0.3
			local var_166_24 = math.max(var_166_18, arg_163_1.talkMaxDuration)

			if var_166_17 + 0.3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_23 + var_166_24 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_23) / var_166_24

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_23 + var_166_24 and arg_163_1.time_ < var_166_23 + var_166_24 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play319001040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319001040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319001041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.975

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(319001040).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 39 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 39)

				if (39 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 39)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319001041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319001041
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319001042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10075ui_story"]) and arg_173_1.var_.characterEffect10075ui_story == nil then
				arg_173_1.var_.characterEffect10075ui_story = arg_173_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10075ui_story"]) then
				if arg_173_1.var_.characterEffect10075ui_story and not isNil(arg_173_1.actors_["10075ui_story"]) then
					arg_173_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10075ui_story"]) and arg_173_1.var_.characterEffect10075ui_story then
				arg_173_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_176_2 = arg_173_1.actors_["10075ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10075ui_story = var_176_2.localPosition
			end

			local var_176_3 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 then
				var_176_2.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_173_1.time_ - 0) / var_176_3)
				var_176_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_2.position).x, (manager.ui.mainCamera.transform.position - var_176_2.position).y, (manager.ui.mainCamera.transform.position - var_176_2.position).z)
				var_176_2.localEulerAngles.z = 0
				var_176_2.localEulerAngles.x = 0
				var_176_2.localEulerAngles = var_176_2.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 then
				var_176_2.localPosition = Vector3.New(0, -0.715, -6.15)
				var_176_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_2.position).x, (manager.ui.mainCamera.transform.position - var_176_2.position).y, (manager.ui.mainCamera.transform.position - var_176_2.position).z)
				var_176_2.localEulerAngles.z = 0
				var_176_2.localEulerAngles.x = 0
				var_176_2.localEulerAngles = var_176_2.localEulerAngles
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = 0
			local var_176_5 = 0.125

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(319001041)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 5 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 5)

				if (5 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 5)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319001", "319001041", "story_v_out_319001.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_319001", "319001041", "story_v_out_319001.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_319001", "319001041", "story_v_out_319001.awb")

						arg_173_1:RecordAudio("319001041", var_176_11)
						arg_173_1:RecordAudio("319001041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319001", "319001041", "story_v_out_319001.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319001", "319001041", "story_v_out_319001.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play319001042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319001042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319001043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10075ui_story"]) and arg_177_1.var_.characterEffect10075ui_story == nil then
				arg_177_1.var_.characterEffect10075ui_story = arg_177_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10075ui_story"]) then
				if arg_177_1.var_.characterEffect10075ui_story and not isNil(arg_177_1.actors_["10075ui_story"]) then
					arg_177_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10075ui_story"]) and arg_177_1.var_.characterEffect10075ui_story then
				arg_177_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(319001042).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 40 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 40)

				if (40 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 40)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play319001043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319001043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319001044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(319001043).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 40 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 40)

				if (40 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 40)) > 0 and var_184_0 < var_184_3 then
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
	Play319001044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319001044
		arg_185_1.duration_ = 4

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319001045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				local var_188_0 = arg_185_1.bgs_.STblack

				arg_185_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_1 = var_188_0:GetComponent("SpriteRenderer")

				if var_188_1 and var_188_1.sprite then
					local var_188_2 = 2 * (var_188_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_0.transform.localScale = Vector3.New(var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "STblack" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_3 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_4 = 2

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_4 then
				local var_188_5 = Color.New(0, 0, 0)

				var_188_5.a = Mathf.Lerp(0, 1, (arg_185_1.time_ - var_188_3) / var_188_4)
				arg_185_1.mask_.color = var_188_5
			end

			if arg_185_1.time_ >= var_188_3 + var_188_4 and arg_185_1.time_ < var_188_3 + var_188_4 + arg_188_0 then
				local var_188_6 = Color.New(0, 0, 0)

				var_188_6.a = 1
				arg_185_1.mask_.color = var_188_6
			end

			local var_188_7 = 2

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_8 = 2

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_8 then
				local var_188_9 = Color.New(0, 0, 0)

				var_188_9.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_7) / var_188_8)
				arg_185_1.mask_.color = var_188_9
			end

			if arg_185_1.time_ >= var_188_7 + var_188_8 and arg_185_1.time_ < var_188_7 + var_188_8 + arg_188_0 then
				local var_188_10 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_10.a = 0
				arg_185_1.mask_.color = var_188_10
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:AudioAction("stop", "effect", "se_story_side_1055", "se_story_side_1055_rain", "")
			end

			local var_188_12 = arg_185_1.actors_["10075ui_story"].transform

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				arg_185_1.var_.moveOldPos10075ui_story = var_188_12.localPosition
			end

			local var_188_13 = 0.001

			if 2 <= arg_185_1.time_ and arg_185_1.time_ < 2 + var_188_13 then
				var_188_12.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 2) / var_188_13)
				var_188_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_12.position).x, (manager.ui.mainCamera.transform.position - var_188_12.position).y, (manager.ui.mainCamera.transform.position - var_188_12.position).z)
				var_188_12.localEulerAngles.z = 0
				var_188_12.localEulerAngles.x = 0
				var_188_12.localEulerAngles = var_188_12.localEulerAngles
			end

			if arg_185_1.time_ >= 2 + var_188_13 and arg_185_1.time_ < 2 + var_188_13 + arg_188_0 then
				var_188_12.localPosition = Vector3.New(0, 100, 0)
				var_188_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_12.position).x, (manager.ui.mainCamera.transform.position - var_188_12.position).y, (manager.ui.mainCamera.transform.position - var_188_12.position).z)
				var_188_12.localEulerAngles.z = 0
				var_188_12.localEulerAngles.x = 0
				var_188_12.localEulerAngles = var_188_12.localEulerAngles
			end

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				arg_185_1.fswbg_:SetActive(true)
				arg_185_1.dialog_:SetActive(false)

				arg_185_1.fswtw_.percent = 0
				arg_185_1.fswt_.text = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(319001044).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.fswt_)

				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_185_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_185_1.fswtw_:SetDirty()

				arg_185_1.typewritterCharCountI18N = 0

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_14 = 2.33333333333333

			if 2.33333333333333 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1.var_.oldValueTypewriter = arg_185_1.fswtw_.percent

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_15 = 5
			local var_188_16 = 0.333333333333333
			local var_188_17, var_188_18 = arg_185_1:GetPercentByPara(arg_185_1:FormatText(arg_185_1:GetWordFromCfg(319001044).content), 1)

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				local var_188_19 = var_188_15 <= 0 and var_188_16 or var_188_16 * ((var_188_18 - arg_185_1.typewritterCharCountI18N) / var_188_15)

				if (var_188_15 <= 0 and var_188_16 or var_188_16 * ((var_188_18 - arg_185_1.typewritterCharCountI18N) / var_188_15)) > 0 and var_188_16 < var_188_19 then
					arg_185_1.talkMaxDuration = var_188_19

					if var_188_19 + var_188_14 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_19 + var_188_14
					end
				end
			end

			local var_188_20 = math.max(0.333333333333333, arg_185_1.talkMaxDuration)

			if var_188_14 <= arg_185_1.time_ and arg_185_1.time_ < var_188_14 + var_188_20 then
				arg_185_1.fswtw_.percent = Mathf.Lerp(arg_185_1.var_.oldValueTypewriter, var_188_17, (arg_185_1.time_ - var_188_14) / var_188_20)
				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_185_1.fswtw_:SetDirty()
			end

			if arg_185_1.time_ >= var_188_14 + var_188_20 and arg_185_1.time_ < var_188_14 + var_188_20 + arg_188_0 then
				arg_185_1.fswtw_.percent = var_188_17

				arg_185_1.fswtw_:SetDirty()
				arg_185_1:ShowNextGo(true)

				arg_185_1.typewritterCharCountI18N = var_188_18
			end

			if 2.33333333333333 < arg_185_1.time_ and arg_185_1.time_ <= 2.33333333333333 + arg_188_0 then
				local var_188_21 = arg_185_1.fswbg_.transform:Find("textbox/adapt/content") or arg_185_1.fswbg_.transform:Find("textbox/content")
				local var_188_22 = arg_185_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_188_23 = var_188_21:GetComponent("RectTransform")

				var_188_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_188_23.offsetMin = Vector2.New(0, 0)
				var_188_23.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play319001045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319001045
		arg_189_1.duration_ = 1

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319001046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.oldValueTypewriter = arg_189_1.fswtw_.percent

				SetActive(arg_189_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_189_1:ShowNextGo(false)
			end

			local var_192_0 = 6
			local var_192_1 = 0.4
			local var_192_2, var_192_3 = arg_189_1:GetPercentByPara(arg_189_1:FormatText(arg_189_1:GetWordFromCfg(319001044).content), 2)

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				local var_192_4 = var_192_0 <= 0 and var_192_1 or var_192_1 * ((var_192_3 - arg_189_1.typewritterCharCountI18N) / var_192_0)

				if (var_192_0 <= 0 and var_192_1 or var_192_1 * ((var_192_3 - arg_189_1.typewritterCharCountI18N) / var_192_0)) > 0 and var_192_1 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end
			end

			local var_192_5 = math.max(0.4, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_5 then
				arg_189_1.fswtw_.percent = Mathf.Lerp(arg_189_1.var_.oldValueTypewriter, var_192_2, (arg_189_1.time_ - 0) / var_192_5)
				arg_189_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_189_1.fswtw_:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_5 and arg_189_1.time_ < 0 + var_192_5 + arg_192_0 then
				arg_189_1.fswtw_.percent = var_192_2

				arg_189_1.fswtw_:SetDirty()
				arg_189_1:ShowNextGo(true)

				arg_189_1.typewritterCharCountI18N = var_192_3
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_6 = arg_189_1.fswbg_.transform:Find("textbox/adapt/content") or arg_189_1.fswbg_.transform:Find("textbox/content")
				local var_192_7 = arg_189_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_192_8 = var_192_6:GetComponent("RectTransform")

				var_192_6:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_192_8.offsetMin = Vector2.New(0, 0)
				var_192_8.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319001046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319001046
		arg_193_1.duration_ = 1

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play319001047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.oldValueTypewriter = arg_193_1.fswtw_.percent

				SetActive(arg_193_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_193_1:ShowNextGo(false)
			end

			local var_196_0 = 9
			local var_196_1 = 0.6
			local var_196_2, var_196_3 = arg_193_1:GetPercentByPara(arg_193_1:FormatText(arg_193_1:GetWordFromCfg(319001044).content), 3)

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				local var_196_4 = var_196_0 <= 0 and var_196_1 or var_196_1 * ((var_196_3 - arg_193_1.typewritterCharCountI18N) / var_196_0)

				if (var_196_0 <= 0 and var_196_1 or var_196_1 * ((var_196_3 - arg_193_1.typewritterCharCountI18N) / var_196_0)) > 0 and var_196_1 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end
			end

			local var_196_5 = math.max(0.6, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_5 then
				arg_193_1.fswtw_.percent = Mathf.Lerp(arg_193_1.var_.oldValueTypewriter, var_196_2, (arg_193_1.time_ - 0) / var_196_5)
				arg_193_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_193_1.fswtw_:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_5 and arg_193_1.time_ < 0 + var_196_5 + arg_196_0 then
				arg_193_1.fswtw_.percent = var_196_2

				arg_193_1.fswtw_:SetDirty()
				arg_193_1:ShowNextGo(true)

				arg_193_1.typewritterCharCountI18N = var_196_3
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_6 = arg_193_1.fswbg_.transform:Find("textbox/adapt/content") or arg_193_1.fswbg_.transform:Find("textbox/content")
				local var_196_7 = arg_193_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_196_8 = var_196_6:GetComponent("RectTransform")

				var_196_6:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_196_8.offsetMin = Vector2.New(0, 0)
				var_196_8.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319001047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319001047
		arg_197_1.duration_ = 7.03

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
			arg_197_1.auto_ = false
		end

		function arg_197_1.playNext_(arg_199_0)
			arg_197_1.onStoryFinished_()
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.fswbg_:SetActive(false)
				arg_197_1.dialog_:SetActive(false)
				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_0 = 0

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				SetActive(arg_197_1.dialog_, false)
				SetActive(arg_197_1.allBtn_.gameObject, false)
				arg_197_1.hideBtnsController_:SetSelectedIndex(1)
				arg_197_1:PlayOnlyBgm()

				arg_197_1.marker = "stop222"

				manager.video:Play("SofdecAsset/story/story_1031900.usm", function(arg_201_0)
					arg_197_1:Skip(arg_201_0)
					manager.video:Dispose()
				end, nil, nil, function(arg_202_0)
					arg_197_1.state_ = arg_202_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_200_1 = 7.03333333333333

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_1 then
				-- block empty
			end

			if arg_197_1.time_ >= var_200_0 + var_200_1 and arg_197_1.time_ < var_200_0 + var_200_1 + arg_200_0 then
				arg_197_1.marker = ""
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ML0101",
		"TextureConfig/Background/ST71",
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/story_1031900.usm"
	},
	voices = {
		"story_v_out_319001.awb"
	},
	skipMarkers = {
		319001047
	}
}
