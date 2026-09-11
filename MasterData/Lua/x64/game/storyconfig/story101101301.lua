return {
	Play110131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 110131001
		arg_1_1.duration_ = 7.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play110131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST19 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST19")
				var_4_0.name = "ST19"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST19 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST19

				arg_1_1.bgs_.ST19.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST19" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.ST19:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueST19 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueST19 = var_4_4
				end

				arg_1_1.var_.alphaOldValueST19 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueST19 then
					arg_1_1.var_.alphaMatValueST19.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueST19, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueST19.color = arg_1_1.var_.alphaMatValueST19.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueST19 then
				arg_1_1.var_.alphaMatValueST19.color.a = 1
				arg_1_1.var_.alphaMatValueST19.color = arg_1_1.var_.alphaMatValueST19.color
			end

			local var_4_6 = arg_1_1.bgs_.ST19.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosST19 = var_4_6.localPosition
			end

			local var_4_7 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				var_4_6.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosST19, Vector3.New(0, 1, 9), (arg_1_1.time_ - 0) / var_4_7)
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = Vector3.New(0, 1, 9)
			end

			local var_4_8 = arg_1_1.bgs_.ST19.transform

			if 0.0166666666666666 < arg_1_1.time_ and arg_1_1.time_ <= 0.0166666666666666 + arg_4_0 then
				arg_1_1.var_.moveOldPosST19 = var_4_8.localPosition
			end

			local var_4_9 = 2

			if 0.0166666666666666 <= arg_1_1.time_ and arg_1_1.time_ < 0.0166666666666666 + var_4_9 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosST19, Vector3.New(-0.5, 1, 9), (arg_1_1.time_ - 0.0166666666666666) / var_4_9)
			end

			if arg_1_1.time_ >= 0.0166666666666666 + var_4_9 and arg_1_1.time_ < 0.0166666666666666 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(-0.5, 1, 9)
			end

			local var_4_10 = arg_1_1.bgs_.ST19.transform

			if 2.01666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 2.01666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosST19 = var_4_10.localPosition
			end

			local var_4_11 = 2

			if 2.01666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 2.01666666666667 + var_4_11 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosST19, Vector3.New(0.5, 1, 9), (arg_1_1.time_ - 2.01666666666667) / var_4_11)
			end

			if arg_1_1.time_ >= 2.01666666666667 + var_4_11 and arg_1_1.time_ < 2.01666666666667 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(0.5, 1, 9)
			end

			local var_4_12 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_12 + 2.8 and arg_1_1.time_ < var_4_12 + 2.8 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

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

			local var_4_19 = 2.8
			local var_4_20 = 0.125

			if 2.8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

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

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(110131001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 5 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 5)

				if (5 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 5)) > 0 and var_4_20 < var_4_24 then
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

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST19",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST19",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0.0166666666666666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST19",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play110131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 110131002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play110131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPosST19 = arg_9_1.bgs_.ST19.transform.localPosition
			end

			local var_12_0 = 1

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.bgs_.ST19.transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPosST19, Vector3.New(0, 1, 10), (arg_9_1.time_ - 0) / var_12_0)
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.bgs_.ST19.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_12_1 = 0
			local var_12_2 = 0.75

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(110131002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 30 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 30)

				if (30 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 30)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST19",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play110131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 110131003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play110131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.25

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(110131003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 50 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 50)

				if (50 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 50)) > 0 and var_16_0 < var_16_3 then
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
	Play110131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 110131004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play110131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(110131004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)

				if (36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)) > 0 and var_20_0 < var_20_3 then
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
	Play110131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 110131005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play110131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.175

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(110131005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 7 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 7)

				if (7 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 7)) > 0 and var_24_0 < var_24_3 then
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
	Play110131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 110131006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play110131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.825

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(110131006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 33 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 33)

				if (33 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 33)) > 0 and var_28_0 < var_28_3 then
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
	Play110131007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 110131007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play110131008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(110131007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 53 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 53)

				if (53 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 53)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play110131008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 110131008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play110131009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.825

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(110131008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 33 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 33)

				if (33 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 33)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play110131009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 110131009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play110131010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.525

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(110131009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 21 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 21)

				if (21 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 21)) > 0 and var_40_0 < var_40_3 then
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
	Play110131010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 110131010
		arg_41_1.duration_ = 2.63

		local var_41_0 = {
			ja = 2.066,
			ko = 1.533,
			zh = 2.633,
			en = 1.366
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play110131011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.15

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(110131010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 6 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 6)

				if (6 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 6)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131010", "story_v_out_110131.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131010", "story_v_out_110131.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_110131", "110131010", "story_v_out_110131.awb")

						arg_41_1:RecordAudio("110131010", var_44_6)
						arg_41_1:RecordAudio("110131010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_110131", "110131010", "story_v_out_110131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_110131", "110131010", "story_v_out_110131.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play110131011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 110131011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play110131012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(110131011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 4 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 4)

				if (4 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 4)) > 0 and var_48_0 < var_48_3 then
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
	Play110131012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 110131012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play110131013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.925

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(110131012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 37 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 37)

				if (37 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 37)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play110131013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 110131013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play110131014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.175

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(110131013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 7 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 7)

				if (7 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 7)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play110131014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 110131014
		arg_57_1.duration_ = 5.63

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play110131015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPosST19 = arg_57_1.bgs_.ST19.transform.localPosition
			end

			local var_60_0 = 3.5

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.bgs_.ST19.transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPosST19, Vector3.New(3.2, 2.5, 2.5), (arg_57_1.time_ - 0) / var_60_0)
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.bgs_.ST19.transform.localPosition = Vector3.New(3.2, 2.5, 2.5)
			end

			local var_60_1 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_1 + 0.633333333333333 and arg_57_1.time_ < var_60_1 + 0.633333333333333 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_2 = 0.633333333333333
			local var_60_3 = 1.8

			if 0.633333333333333 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_4 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_4:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(110131014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 72 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 72)

				if (72 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 72)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7
					var_60_2 = var_60_2 + 0.3

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = var_60_2 + 0.3
			local var_60_9 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_9

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST19",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play110131015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 110131015
		arg_63_1.duration_ = 7

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play110131016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.mask_.enabled = true
				arg_63_1.mask_.raycastTarget = false

				arg_63_1:SetGaussion(false)
			end

			local var_66_0 = 1.5

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				local var_66_1 = Color.New(1, 1, 1)

				var_66_1.a = Mathf.Lerp(1, 0, (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.mask_.color = var_66_1
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				local var_66_2 = Color.New(1, 1, 1)

				arg_63_1.mask_.enabled = false
				var_66_2.a = 0
				arg_63_1.mask_.color = var_66_2
			end

			local var_66_3 = "OS0102"

			if arg_63_1.bgs_.OS0102 == nil then
				local var_66_4 = Object.Instantiate(arg_63_1.paintGo_)

				var_66_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_66_3)
				var_66_4.name = var_66_3
				var_66_4.transform.parent = arg_63_1.stage_.transform
				var_66_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.bgs_[var_66_3] = var_66_4
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_5 = arg_63_1.bgs_.OS0102

				arg_63_1.bgs_.OS0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_6 = var_66_5:GetComponent("SpriteRenderer")

				if var_66_6 and var_66_6.sprite then
					local var_66_7 = 2 * (var_66_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_5.transform.localScale = Vector3.New(var_66_7 / var_66_6.sprite.bounds.size.y < var_66_7 * manager.ui.mainCameraCom_.aspect / var_66_6.sprite.bounds.size.x and var_66_7 * manager.ui.mainCameraCom_.aspect / var_66_6.sprite.bounds.size.x or var_66_7 / var_66_6.sprite.bounds.size.y, var_66_7 / var_66_6.sprite.bounds.size.y < var_66_7 * manager.ui.mainCameraCom_.aspect / var_66_6.sprite.bounds.size.x and var_66_7 * manager.ui.mainCameraCom_.aspect / var_66_6.sprite.bounds.size.x or var_66_7 / var_66_6.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "OS0102" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_8 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_8 + 2 and arg_63_1.time_ < var_66_8 + 2 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_9 = 2
			local var_66_10 = 0.225

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_11 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_11:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

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

				local var_66_12 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(110131015).content)

				arg_63_1.text_.text = var_66_12

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_14 = 9 <= 0 and var_66_10 or var_66_10 * (utf8.len(var_66_12) / 9)

				if (9 <= 0 and var_66_10 or var_66_10 * (utf8.len(var_66_12) / 9)) > 0 and var_66_10 < var_66_14 then
					arg_63_1.talkMaxDuration = var_66_14
					var_66_9 = var_66_9 + 0.3

					if var_66_14 + var_66_9 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_9
					end
				end

				arg_63_1.text_.text = var_66_12
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_15 = var_66_9 + 0.3
			local var_66_16 = math.max(var_66_10, arg_63_1.talkMaxDuration)

			if var_66_9 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_15) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_15 + var_66_16 and arg_63_1.time_ < var_66_15 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play110131016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 110131016
		arg_69_1.duration_ = 5.1

		local var_69_0 = {
			ja = 5.1,
			ko = 2.7,
			zh = 3.533,
			en = 3.733
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
				arg_69_0:Play110131017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.35

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(110131016)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 14 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 14)

				if (14 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 14)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131016", "story_v_out_110131.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131016", "story_v_out_110131.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_110131", "110131016", "story_v_out_110131.awb")

						arg_69_1:RecordAudio("110131016", var_72_6)
						arg_69_1:RecordAudio("110131016", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_110131", "110131016", "story_v_out_110131.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_110131", "110131016", "story_v_out_110131.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play110131017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 110131017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play110131018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.875

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(110131017).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 34 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 34)

				if (34 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 34)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play110131018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 110131018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play110131019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.725

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(110131018).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 29 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 29)

				if (29 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 29)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play110131019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 110131019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play110131020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.675

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(110131019).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 27 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 27)

				if (27 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 27)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play110131020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 110131020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play110131021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.125

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
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

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(110131020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 5 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 5)

				if (5 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 5)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play110131021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 110131021
		arg_89_1.duration_ = 9

		local var_89_0 = {
			ja = 4.6,
			ko = 8.366,
			zh = 9,
			en = 7.566
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
				arg_89_0:Play110131022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.925

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(110131021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 37 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 37)

				if (37 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 37)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131021", "story_v_out_110131.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131021", "story_v_out_110131.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_110131", "110131021", "story_v_out_110131.awb")

						arg_89_1:RecordAudio("110131021", var_92_6)
						arg_89_1:RecordAudio("110131021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_110131", "110131021", "story_v_out_110131.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_110131", "110131021", "story_v_out_110131.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play110131022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 110131022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play110131023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.65

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(110131022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 26 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 26)

				if (26 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 26)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play110131023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 110131023
		arg_97_1.duration_ = 11.1

		local var_97_0 = {
			ja = 11.1,
			ko = 8.266,
			zh = 8.633,
			en = 7.4
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
				arg_97_0:Play110131024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.85

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(110131023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 34 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 34)

				if (34 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 34)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131023", "story_v_out_110131.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131023", "story_v_out_110131.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_110131", "110131023", "story_v_out_110131.awb")

						arg_97_1:RecordAudio("110131023", var_100_6)
						arg_97_1:RecordAudio("110131023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_110131", "110131023", "story_v_out_110131.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_110131", "110131023", "story_v_out_110131.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play110131024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 110131024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play110131025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.375

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(110131024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 15 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 15)

				if (15 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 15)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play110131025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 110131025
		arg_105_1.duration_ = 11.3

		local var_105_0 = {
			ja = 9.433,
			ko = 9.5,
			zh = 11.3,
			en = 8.7
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play110131026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.975

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(110131025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 37 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 37)

				if (37 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 37)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131025", "story_v_out_110131.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131025", "story_v_out_110131.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_110131", "110131025", "story_v_out_110131.awb")

						arg_105_1:RecordAudio("110131025", var_108_6)
						arg_105_1:RecordAudio("110131025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_110131", "110131025", "story_v_out_110131.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_110131", "110131025", "story_v_out_110131.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play110131026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 110131026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play110131027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(110131026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 45 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 45)

				if (45 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 45)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play110131027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 110131027
		arg_113_1.duration_ = 5.8

		local var_113_0 = {
			ja = 5.8,
			ko = 4.233,
			zh = 5.066,
			en = 5.566
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play110131028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.525

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(110131027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 21 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 21)

				if (21 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 21)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131027", "story_v_out_110131.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131027", "story_v_out_110131.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_110131", "110131027", "story_v_out_110131.awb")

						arg_113_1:RecordAudio("110131027", var_116_6)
						arg_113_1:RecordAudio("110131027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_110131", "110131027", "story_v_out_110131.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_110131", "110131027", "story_v_out_110131.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play110131028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 110131028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play110131029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.15

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(110131028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 6 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 6)

				if (6 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 6)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play110131029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 110131029
		arg_121_1.duration_ = 11.67

		local var_121_0 = {
			ja = 5.666,
			ko = 8.3,
			zh = 10.333,
			en = 11.666
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play110131030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.975

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(110131029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 39 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 39)

				if (39 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 39)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131029", "story_v_out_110131.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131029", "story_v_out_110131.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_110131", "110131029", "story_v_out_110131.awb")

						arg_121_1:RecordAudio("110131029", var_124_6)
						arg_121_1:RecordAudio("110131029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_110131", "110131029", "story_v_out_110131.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_110131", "110131029", "story_v_out_110131.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play110131030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 110131030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play110131031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.05

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(110131030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 2 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 2)

				if (2 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 2)) > 0 and var_128_0 < var_128_3 then
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
	Play110131031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 110131031
		arg_129_1.duration_ = 13.6

		local var_129_0 = {
			ja = 13.6,
			ko = 12.066,
			zh = 12.3,
			en = 12.466
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play110131032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 2

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(110131031)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 53 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 53)

				if (53 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 53)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131031", "story_v_out_110131.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131031", "story_v_out_110131.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_110131", "110131031", "story_v_out_110131.awb")

						arg_129_1:RecordAudio("110131031", var_132_6)
						arg_129_1:RecordAudio("110131031", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_110131", "110131031", "story_v_out_110131.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_110131", "110131031", "story_v_out_110131.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play110131032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 110131032
		arg_133_1.duration_ = 13.67

		local var_133_0 = {
			ja = 5.8,
			ko = 3.5,
			zh = 13.2,
			en = 13.666
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
				arg_133_0:Play110131033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				local var_136_0 = arg_133_1.bgs_.OS0102:GetComponent("SpriteRenderer")

				if var_136_0 then
					arg_133_1.var_.alphaOldValueOS0102 = var_136_0.color.a
					arg_133_1.var_.alphaMatValueOS0102 = var_136_0
				end

				arg_133_1.var_.alphaOldValueOS0102 = 1
			end

			local var_136_1 = 1.5

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				if arg_133_1.var_.alphaMatValueOS0102 then
					arg_133_1.var_.alphaMatValueOS0102.color.a = Mathf.Lerp(arg_133_1.var_.alphaOldValueOS0102, 0, (arg_133_1.time_ - 0) / var_136_1)
					arg_133_1.var_.alphaMatValueOS0102.color = arg_133_1.var_.alphaMatValueOS0102.color
				end
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 and arg_133_1.var_.alphaMatValueOS0102 then
				arg_133_1.var_.alphaMatValueOS0102.color.a = 0
				arg_133_1.var_.alphaMatValueOS0102.color = arg_133_1.var_.alphaMatValueOS0102.color
			end

			local var_136_2 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			if arg_133_1.time_ >= var_136_2 + 2 and arg_133_1.time_ < var_136_2 + 2 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_3 = 2
			local var_136_4 = 1.075

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_5 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_5:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(110131032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 42 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_7) / 42)

				if (42 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_7) / 42)) > 0 and var_136_4 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9
					var_136_3 = var_136_3 + 0.3

					if var_136_9 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131032", "story_v_out_110131.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_110131", "110131032", "story_v_out_110131.awb") / 1000

					if var_136_10 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_3
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_110131", "110131032", "story_v_out_110131.awb")

						arg_133_1:RecordAudio("110131032", var_136_11)
						arg_133_1:RecordAudio("110131032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_110131", "110131032", "story_v_out_110131.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_110131", "110131032", "story_v_out_110131.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = var_136_3 + 0.3
			local var_136_13 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_12 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_12) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_12 + var_136_13 and arg_133_1.time_ < var_136_12 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play110131033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 110131033
		arg_139_1.duration_ = 14.57

		local var_139_0 = {
			ja = 14.566,
			ko = 1.5,
			zh = 4.733,
			en = 6.466
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
				arg_139_0:Play110131034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.325

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:GetWordFromCfg(110131033)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 14 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 14)

				if (14 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 14)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131033", "story_v_out_110131.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131033", "story_v_out_110131.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_110131", "110131033", "story_v_out_110131.awb")

						arg_139_1:RecordAudio("110131033", var_142_6)
						arg_139_1:RecordAudio("110131033", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_110131", "110131033", "story_v_out_110131.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_110131", "110131033", "story_v_out_110131.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play110131034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 110131034
		arg_143_1.duration_ = 15.97

		local var_143_0 = {
			ja = 15.966,
			ko = 10.2,
			zh = 10.033,
			en = 11.566
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
				arg_143_0:Play110131035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if arg_143_1.bgs_.OS0102a == nil then
				local var_146_0 = Object.Instantiate(arg_143_1.paintGo_)

				var_146_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OS0102a")
				var_146_0.name = "OS0102a"
				var_146_0.transform.parent = arg_143_1.stage_.transform
				var_146_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.bgs_.OS0102a = var_146_0
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				local var_146_1 = arg_143_1.bgs_.OS0102a:GetComponent("SpriteRenderer")

				if var_146_1 then
					arg_143_1.var_.alphaOldValueOS0102a = var_146_1.color.a
					arg_143_1.var_.alphaMatValueOS0102a = var_146_1
				end

				arg_143_1.var_.alphaOldValueOS0102a = 0
			end

			local var_146_2 = 1.5

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 then
				if arg_143_1.var_.alphaMatValueOS0102a then
					arg_143_1.var_.alphaMatValueOS0102a.color.a = Mathf.Lerp(arg_143_1.var_.alphaOldValueOS0102a, 1, (arg_143_1.time_ - 0) / var_146_2)
					arg_143_1.var_.alphaMatValueOS0102a.color = arg_143_1.var_.alphaMatValueOS0102a.color
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and arg_143_1.var_.alphaMatValueOS0102a then
				arg_143_1.var_.alphaMatValueOS0102a.color.a = 1
				arg_143_1.var_.alphaMatValueOS0102a.color = arg_143_1.var_.alphaMatValueOS0102a.color
			end

			local var_146_3 = 0

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			if arg_143_1.time_ >= var_146_3 + 2 and arg_143_1.time_ < var_146_3 + 2 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				local var_146_4 = arg_143_1.bgs_.OS0102a

				arg_143_1.bgs_.OS0102a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_146_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_5 = var_146_4:GetComponent("SpriteRenderer")

				if var_146_5 and var_146_5.sprite then
					local var_146_6 = 2 * (var_146_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_146_4.transform.localScale = Vector3.New(var_146_6 / var_146_5.sprite.bounds.size.y < var_146_6 * manager.ui.mainCameraCom_.aspect / var_146_5.sprite.bounds.size.x and var_146_6 * manager.ui.mainCameraCom_.aspect / var_146_5.sprite.bounds.size.x or var_146_6 / var_146_5.sprite.bounds.size.y, var_146_6 / var_146_5.sprite.bounds.size.y < var_146_6 * manager.ui.mainCameraCom_.aspect / var_146_5.sprite.bounds.size.x and var_146_6 * manager.ui.mainCameraCom_.aspect / var_146_5.sprite.bounds.size.x or var_146_6 / var_146_5.sprite.bounds.size.y, 0)
				end

				for iter_146_0, iter_146_1 in pairs(arg_143_1.bgs_) do
					if iter_146_0 ~= "OS0102a" then
						iter_146_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_7 = 2
			local var_146_8 = 0.825

			if 2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_9 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_9:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(110131034)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 33 <= 0 and var_146_8 or var_146_8 * (utf8.len(var_146_11) / 33)

				if (33 <= 0 and var_146_8 or var_146_8 * (utf8.len(var_146_11) / 33)) > 0 and var_146_8 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13
					var_146_7 = var_146_7 + 0.3

					if var_146_13 + var_146_7 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_7
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131034", "story_v_out_110131.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_110131", "110131034", "story_v_out_110131.awb") / 1000

					if var_146_14 + var_146_7 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_7
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_110131", "110131034", "story_v_out_110131.awb")

						arg_143_1:RecordAudio("110131034", var_146_15)
						arg_143_1:RecordAudio("110131034", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_110131", "110131034", "story_v_out_110131.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_110131", "110131034", "story_v_out_110131.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = var_146_7 + 0.3
			local var_146_17 = math.max(var_146_8, arg_143_1.talkMaxDuration)

			if var_146_7 + 0.3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_16) / var_146_17

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play110131035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 110131035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play110131036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.45

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

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(110131035).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 18 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 18)

				if (18 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 18)) > 0 and var_152_0 < var_152_3 then
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
	Play110131036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 110131036
		arg_153_1.duration_ = 12.73

		local var_153_0 = {
			ja = 7.766,
			ko = 12.733,
			zh = 11.3,
			en = 10.566
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
				arg_153_0:Play110131037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(110131036)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 40 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 40)

				if (40 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 40)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131036", "story_v_out_110131.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131036", "story_v_out_110131.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_110131", "110131036", "story_v_out_110131.awb")

						arg_153_1:RecordAudio("110131036", var_156_6)
						arg_153_1:RecordAudio("110131036", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_110131", "110131036", "story_v_out_110131.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_110131", "110131036", "story_v_out_110131.awb")
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
	Play110131037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 110131037
		arg_157_1.duration_ = 13.67

		local var_157_0 = {
			ja = 13.666,
			ko = 12.2,
			zh = 12,
			en = 9.866
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play110131038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.275

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(110131037)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 51 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 51)

				if (51 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 51)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131037", "story_v_out_110131.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131037", "story_v_out_110131.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_110131", "110131037", "story_v_out_110131.awb")

						arg_157_1:RecordAudio("110131037", var_160_6)
						arg_157_1:RecordAudio("110131037", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_110131", "110131037", "story_v_out_110131.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_110131", "110131037", "story_v_out_110131.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play110131038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 110131038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play110131039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.3

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(110131038).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 52 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 52)

				if (52 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 52)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play110131039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 110131039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play110131040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.625

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(110131039).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 25 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 25)

				if (25 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 25)) > 0 and var_168_0 < var_168_3 then
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
	Play110131040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 110131040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play110131041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.225

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

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(110131040).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 49 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 49)

				if (49 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 49)) > 0 and var_172_0 < var_172_3 then
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
	Play110131041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 110131041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play110131042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.425

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

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(110131041).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 17 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 17)

				if (17 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 17)) > 0 and var_176_0 < var_176_3 then
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
	Play110131042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 110131042
		arg_177_1.duration_ = 2.43

		local var_177_0 = {
			ja = 2.433,
			ko = 1.133,
			zh = 1.4,
			en = 1
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
				arg_177_0:Play110131043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.1

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(110131042)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 4 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 4)

				if (4 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 4)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131042", "story_v_out_110131.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131042", "story_v_out_110131.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_110131", "110131042", "story_v_out_110131.awb")

						arg_177_1:RecordAudio("110131042", var_180_6)
						arg_177_1:RecordAudio("110131042", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_110131", "110131042", "story_v_out_110131.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_110131", "110131042", "story_v_out_110131.awb")
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
	Play110131043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 110131043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play110131044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0.25 < arg_181_1.time_ and arg_181_1.time_ <= 0.25 + arg_184_0 then
				arg_181_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_184_0 = 0.6

			if 0.25 <= arg_181_1.time_ and arg_181_1.time_ < 0.25 + var_184_0 then
				local var_184_1, var_184_2 = math.modf((arg_181_1.time_ - 0.25) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_184_2 * 0.13, var_184_2 * 0.13, var_184_2 * 0.13) + arg_181_1.var_.shakeOldPos
			end

			if arg_181_1.time_ >= 0.25 + var_184_0 and arg_181_1.time_ < 0.25 + var_184_0 + arg_184_0 then
				manager.ui.mainCamera.transform.localPosition = arg_181_1.var_.shakeOldPos
			end

			local var_184_3 = 0
			local var_184_4 = 0.525

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
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

				local var_184_5 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(110131043).content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 21 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 21)

				if (21 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 21)) > 0 and var_184_4 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_3
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_4, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_3) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_8 and arg_181_1.time_ < var_184_3 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play110131044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 110131044
		arg_185_1.duration_ = 5

		local var_185_0 = {
			ja = 4.3,
			ko = 4.533,
			zh = 5,
			en = 4.3
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
				arg_185_0:Play110131045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				local var_188_0 = arg_185_1.bgs_.OS0102a:GetComponent("SpriteRenderer")

				if var_188_0 then
					arg_185_1.var_.alphaOldValueOS0102a = var_188_0.color.a
					arg_185_1.var_.alphaMatValueOS0102a = var_188_0
				end

				arg_185_1.var_.alphaOldValueOS0102a = 1
			end

			local var_188_1 = 1

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				if arg_185_1.var_.alphaMatValueOS0102a then
					arg_185_1.var_.alphaMatValueOS0102a.color.a = Mathf.Lerp(arg_185_1.var_.alphaOldValueOS0102a, 0, (arg_185_1.time_ - 0) / var_188_1)
					arg_185_1.var_.alphaMatValueOS0102a.color = arg_185_1.var_.alphaMatValueOS0102a.color
				end
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 and arg_185_1.var_.alphaMatValueOS0102a then
				arg_185_1.var_.alphaMatValueOS0102a.color.a = 0
				arg_185_1.var_.alphaMatValueOS0102a.color = arg_185_1.var_.alphaMatValueOS0102a.color
			end

			if 1 < arg_185_1.time_ and arg_185_1.time_ <= 1 + arg_188_0 then
				local var_188_2 = arg_185_1.bgs_.ST19:GetComponent("SpriteRenderer")

				if var_188_2 then
					arg_185_1.var_.alphaOldValueST19 = var_188_2.color.a
					arg_185_1.var_.alphaMatValueST19 = var_188_2
				end

				arg_185_1.var_.alphaOldValueST19 = 0
			end

			local var_188_3 = 1

			if 1 <= arg_185_1.time_ and arg_185_1.time_ < 1 + var_188_3 then
				if arg_185_1.var_.alphaMatValueST19 then
					arg_185_1.var_.alphaMatValueST19.color.a = Mathf.Lerp(arg_185_1.var_.alphaOldValueST19, 1, (arg_185_1.time_ - 1) / var_188_3)
					arg_185_1.var_.alphaMatValueST19.color = arg_185_1.var_.alphaMatValueST19.color
				end
			end

			if arg_185_1.time_ >= 1 + var_188_3 and arg_185_1.time_ < 1 + var_188_3 + arg_188_0 and arg_185_1.var_.alphaMatValueST19 then
				arg_185_1.var_.alphaMatValueST19.color.a = 1
				arg_185_1.var_.alphaMatValueST19.color = arg_185_1.var_.alphaMatValueST19.color
			end

			if 1 < arg_185_1.time_ and arg_185_1.time_ <= 1 + arg_188_0 then
				local var_188_4 = arg_185_1.bgs_.ST19

				arg_185_1.bgs_.ST19.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_5 = var_188_4:GetComponent("SpriteRenderer")

				if var_188_5 and var_188_5.sprite then
					local var_188_6 = 2 * (var_188_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_4.transform.localScale = Vector3.New(var_188_6 / var_188_5.sprite.bounds.size.y < var_188_6 * manager.ui.mainCameraCom_.aspect / var_188_5.sprite.bounds.size.x and var_188_6 * manager.ui.mainCameraCom_.aspect / var_188_5.sprite.bounds.size.x or var_188_6 / var_188_5.sprite.bounds.size.y, var_188_6 / var_188_5.sprite.bounds.size.y < var_188_6 * manager.ui.mainCameraCom_.aspect / var_188_5.sprite.bounds.size.x and var_188_6 * manager.ui.mainCameraCom_.aspect / var_188_5.sprite.bounds.size.x or var_188_6 / var_188_5.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "ST19" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_7 = "1011ui_story"

			if arg_185_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_188_8 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_185_1.stage_.transform)

				var_188_8.name = var_188_7
				var_188_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_[var_188_7] = var_188_8

				local var_188_9 = var_188_8:GetComponentInChildren(typeof(CharacterEffect))

				var_188_9.enabled = true

				local var_188_10 = GameObjectTools.GetOrAddComponent(var_188_8, typeof(DynamicBoneHelper))

				if var_188_10 then
					var_188_10:EnableDynamicBone(false)
				end

				arg_185_1:ShowWeapon(var_188_9.transform, false)

				arg_185_1.var_[var_188_7 .. "Animator"] = var_188_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_185_1.var_[var_188_7 .. "Animator"].applyRootMotion = true
				arg_185_1.var_[var_188_7 .. "LipSync"] = var_188_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_188_11 = arg_185_1.actors_["1011ui_story"].transform

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				arg_185_1.var_.moveOldPos1011ui_story = var_188_11.localPosition
			end

			local var_188_12 = 0.001

			if 2 <= arg_185_1.time_ and arg_185_1.time_ < 2 + var_188_12 then
				var_188_11.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_185_1.time_ - 2) / var_188_12)
				var_188_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_11.position).x, (manager.ui.mainCamera.transform.position - var_188_11.position).y, (manager.ui.mainCamera.transform.position - var_188_11.position).z)
				var_188_11.localEulerAngles.z = 0
				var_188_11.localEulerAngles.x = 0
				var_188_11.localEulerAngles = var_188_11.localEulerAngles
			end

			if arg_185_1.time_ >= 2 + var_188_12 and arg_185_1.time_ < 2 + var_188_12 + arg_188_0 then
				var_188_11.localPosition = Vector3.New(0, -0.71, -6)
				var_188_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_11.position).x, (manager.ui.mainCamera.transform.position - var_188_11.position).y, (manager.ui.mainCamera.transform.position - var_188_11.position).z)
				var_188_11.localEulerAngles.z = 0
				var_188_11.localEulerAngles.x = 0
				var_188_11.localEulerAngles = var_188_11.localEulerAngles
			end

			local var_188_13 = arg_185_1.actors_["1011ui_story"]

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 and not isNil(var_188_13) and arg_185_1.var_.characterEffect1011ui_story == nil then
				arg_185_1.var_.characterEffect1011ui_story = var_188_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_14 = 0.2

			if 2 <= arg_185_1.time_ and arg_185_1.time_ < 2 + var_188_14 and not isNil(var_188_13) then
				if arg_185_1.var_.characterEffect1011ui_story and not isNil(var_188_13) then
					arg_185_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 2 + var_188_14 and arg_185_1.time_ < 2 + var_188_14 + arg_188_0 and not isNil(var_188_13) and arg_185_1.var_.characterEffect1011ui_story then
				arg_185_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				arg_185_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				arg_185_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_16 = 2.2
			local var_188_17 = 0.225

			if 2.2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_16 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_18 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_18:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_19 = arg_185_1:GetWordFromCfg(110131044)
				local var_188_20 = arg_185_1:FormatText(var_188_19.content)

				arg_185_1.text_.text = var_188_20

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_22 = 9 <= 0 and var_188_17 or var_188_17 * (utf8.len(var_188_20) / 9)

				if (9 <= 0 and var_188_17 or var_188_17 * (utf8.len(var_188_20) / 9)) > 0 and var_188_17 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22
					var_188_16 = var_188_16 + 0.3

					if var_188_22 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_16
					end
				end

				arg_185_1.text_.text = var_188_20
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131044", "story_v_out_110131.awb") ~= 0 then
					local var_188_23 = manager.audio:GetVoiceLength("story_v_out_110131", "110131044", "story_v_out_110131.awb") / 1000

					if var_188_23 + var_188_16 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_16
					end

					if var_188_19.prefab_name ~= "" and arg_185_1.actors_[var_188_19.prefab_name] ~= nil then
						local var_188_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_19.prefab_name].transform, "story_v_out_110131", "110131044", "story_v_out_110131.awb")

						arg_185_1:RecordAudio("110131044", var_188_24)
						arg_185_1:RecordAudio("110131044", var_188_24)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_110131", "110131044", "story_v_out_110131.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_110131", "110131044", "story_v_out_110131.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_25 = var_188_16 + 0.3
			local var_188_26 = math.max(var_188_17, arg_185_1.talkMaxDuration)

			if var_188_16 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_25 + var_188_26 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_25) / var_188_26

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_25 + var_188_26 and arg_185_1.time_ < var_188_25 + var_188_26 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play110131045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 110131045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play110131046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1011ui_story"]) and arg_191_1.var_.characterEffect1011ui_story == nil then
				arg_191_1.var_.characterEffect1011ui_story = arg_191_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1011ui_story"]) then
				if arg_191_1.var_.characterEffect1011ui_story and not isNil(arg_191_1.actors_["1011ui_story"]) then
					arg_191_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1011ui_story"]) and arg_191_1.var_.characterEffect1011ui_story then
				arg_191_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.7

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(110131045).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 28 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 28)

				if (28 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 28)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play110131046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 110131046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play110131047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.65

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(110131046).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 26 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 26)

				if (26 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 26)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play110131047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 110131047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play110131048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.925

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

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

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(110131047).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 37 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 37)

				if (37 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 37)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play110131048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 110131048
		arg_203_1.duration_ = 8.63

		local var_203_0 = {
			ja = 8.633,
			ko = 6.833,
			zh = 6.966,
			en = 6.7
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
				arg_203_0:Play110131049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if arg_203_1.bgs_.A00 == nil then
				local var_206_0 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_206_0.name = "A00"
				var_206_0.transform.parent = arg_203_1.stage_.transform
				var_206_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_.A00 = var_206_0
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				local var_206_1 = arg_203_1.bgs_.A00

				arg_203_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_2 = var_206_1:GetComponent("SpriteRenderer")

				if var_206_2 and var_206_2.sprite then
					local var_206_3 = 2 * (var_206_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_1.transform.localScale = Vector3.New(var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "A00" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_4 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_5 = 1.5

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_5 then
				local var_206_6 = Color.New(1, 1, 1)

				var_206_6.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_4) / var_206_5)
				arg_203_1.mask_.color = var_206_6
			end

			if arg_203_1.time_ >= var_206_4 + var_206_5 and arg_203_1.time_ < var_206_4 + var_206_5 + arg_206_0 then
				local var_206_7 = Color.New(1, 1, 1)

				arg_203_1.mask_.enabled = false
				var_206_7.a = 0
				arg_203_1.mask_.color = var_206_7
			end

			local var_206_8 = 0

			arg_203_1.isInRecall_ = false

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.screenFilterGo_:SetActive(true)

				arg_203_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_206_2, iter_206_3 in pairs(arg_203_1.actors_) do
					for iter_206_4, iter_206_5 in ipairs((iter_206_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_206_5.color = iter_206_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_206_9 = 0.5

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_9 then
				arg_203_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_8) / var_206_9)
			end

			if arg_203_1.time_ >= var_206_8 + var_206_9 and arg_203_1.time_ < var_206_8 + var_206_9 + arg_206_0 then
				arg_203_1.screenFilterEffect_.weight = 1
			end

			local var_206_10 = "1019ui_story"

			if arg_203_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_206_11 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_203_1.stage_.transform)

				var_206_11.name = var_206_10
				var_206_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_[var_206_10] = var_206_11

				local var_206_12 = var_206_11:GetComponentInChildren(typeof(CharacterEffect))

				var_206_12.enabled = true

				local var_206_13 = GameObjectTools.GetOrAddComponent(var_206_11, typeof(DynamicBoneHelper))

				if var_206_13 then
					var_206_13:EnableDynamicBone(false)
				end

				arg_203_1:ShowWeapon(var_206_12.transform, false)

				arg_203_1.var_[var_206_10 .. "Animator"] = var_206_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_203_1.var_[var_206_10 .. "Animator"].applyRootMotion = true
				arg_203_1.var_[var_206_10 .. "LipSync"] = var_206_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_206_14 = arg_203_1.actors_["1019ui_story"].transform

			if 1.8 < arg_203_1.time_ and arg_203_1.time_ <= 1.8 + arg_206_0 then
				arg_203_1.var_.moveOldPos1019ui_story = var_206_14.localPosition
			end

			local var_206_15 = 0.001

			if 1.8 <= arg_203_1.time_ and arg_203_1.time_ < 1.8 + var_206_15 then
				var_206_14.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_203_1.time_ - 1.8) / var_206_15)
				var_206_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_14.position).x, (manager.ui.mainCamera.transform.position - var_206_14.position).y, (manager.ui.mainCamera.transform.position - var_206_14.position).z)
				var_206_14.localEulerAngles.z = 0
				var_206_14.localEulerAngles.x = 0
				var_206_14.localEulerAngles = var_206_14.localEulerAngles
			end

			if arg_203_1.time_ >= 1.8 + var_206_15 and arg_203_1.time_ < 1.8 + var_206_15 + arg_206_0 then
				var_206_14.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_206_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_14.position).x, (manager.ui.mainCamera.transform.position - var_206_14.position).y, (manager.ui.mainCamera.transform.position - var_206_14.position).z)
				var_206_14.localEulerAngles.z = 0
				var_206_14.localEulerAngles.x = 0
				var_206_14.localEulerAngles = var_206_14.localEulerAngles
			end

			if 1.8 < arg_203_1.time_ and arg_203_1.time_ <= 1.8 + arg_206_0 then
				arg_203_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 1.8 < arg_203_1.time_ and arg_203_1.time_ <= 1.8 + arg_206_0 then
				arg_203_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_206_16 = arg_203_1.actors_["1019ui_story"]

			if 1.8 < arg_203_1.time_ and arg_203_1.time_ <= 1.8 + arg_206_0 and not isNil(var_206_16) and arg_203_1.var_.characterEffect1019ui_story == nil then
				arg_203_1.var_.characterEffect1019ui_story = var_206_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_17 = 0.2

			if 1.8 <= arg_203_1.time_ and arg_203_1.time_ < 1.8 + var_206_17 and not isNil(var_206_16) then
				if arg_203_1.var_.characterEffect1019ui_story and not isNil(var_206_16) then
					arg_203_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 1.8 + var_206_17 and arg_203_1.time_ < 1.8 + var_206_17 + arg_206_0 and not isNil(var_206_16) and arg_203_1.var_.characterEffect1019ui_story then
				arg_203_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_206_19 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_19 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_19 + 2 and arg_203_1.time_ < var_206_19 + 2 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_20 = arg_203_1.actors_["1011ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1011ui_story = var_206_20.localPosition
			end

			local var_206_21 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_21 then
				var_206_20.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_21)
				var_206_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_20.position).x, (manager.ui.mainCamera.transform.position - var_206_20.position).y, (manager.ui.mainCamera.transform.position - var_206_20.position).z)
				var_206_20.localEulerAngles.z = 0
				var_206_20.localEulerAngles.x = 0
				var_206_20.localEulerAngles = var_206_20.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_21 and arg_203_1.time_ < 0 + var_206_21 + arg_206_0 then
				var_206_20.localPosition = Vector3.New(0, 100, 0)
				var_206_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_20.position).x, (manager.ui.mainCamera.transform.position - var_206_20.position).y, (manager.ui.mainCamera.transform.position - var_206_20.position).z)
				var_206_20.localEulerAngles.z = 0
				var_206_20.localEulerAngles.x = 0
				var_206_20.localEulerAngles = var_206_20.localEulerAngles
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_22 = 2
			local var_206_23 = 0.575

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_22 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_24 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_24:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_25 = arg_203_1:GetWordFromCfg(110131048)
				local var_206_26 = arg_203_1:FormatText(var_206_25.content)

				arg_203_1.text_.text = var_206_26

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_28 = 23 <= 0 and var_206_23 or var_206_23 * (utf8.len(var_206_26) / 23)

				if (23 <= 0 and var_206_23 or var_206_23 * (utf8.len(var_206_26) / 23)) > 0 and var_206_23 < var_206_28 then
					arg_203_1.talkMaxDuration = var_206_28
					var_206_22 = var_206_22 + 0.3

					if var_206_28 + var_206_22 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_28 + var_206_22
					end
				end

				arg_203_1.text_.text = var_206_26
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131048", "story_v_out_110131.awb") ~= 0 then
					local var_206_29 = manager.audio:GetVoiceLength("story_v_out_110131", "110131048", "story_v_out_110131.awb") / 1000

					if var_206_29 + var_206_22 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_29 + var_206_22
					end

					if var_206_25.prefab_name ~= "" and arg_203_1.actors_[var_206_25.prefab_name] ~= nil then
						local var_206_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_25.prefab_name].transform, "story_v_out_110131", "110131048", "story_v_out_110131.awb")

						arg_203_1:RecordAudio("110131048", var_206_30)
						arg_203_1:RecordAudio("110131048", var_206_30)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_110131", "110131048", "story_v_out_110131.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_110131", "110131048", "story_v_out_110131.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_31 = var_206_22 + 0.3
			local var_206_32 = math.max(var_206_23, arg_203_1.talkMaxDuration)

			if var_206_22 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_31 + var_206_32 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_31) / var_206_32

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_31 + var_206_32 and arg_203_1.time_ < var_206_31 + var_206_32 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play110131049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 110131049
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play110131050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1019ui_story"]) and arg_209_1.var_.characterEffect1019ui_story == nil then
				arg_209_1.var_.characterEffect1019ui_story = arg_209_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1019ui_story"]) then
				if arg_209_1.var_.characterEffect1019ui_story and not isNil(arg_209_1.actors_["1019ui_story"]) then
					arg_209_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1019ui_story"]) and arg_209_1.var_.characterEffect1019ui_story then
				arg_209_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 0.075

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(110131049).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 3 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 3)

				if (3 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 3)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_6 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_6 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_6

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_6 and arg_209_1.time_ < var_212_1 + var_212_6 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play110131050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 110131050
		arg_213_1.duration_ = 12

		local var_213_0 = {
			ja = 12,
			ko = 10.333,
			zh = 9.8,
			en = 10.833
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play110131051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_216_0 = arg_213_1.actors_["1019ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1019ui_story == nil then
				arg_213_1.var_.characterEffect1019ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_1 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 and not isNil(var_216_0) then
				if arg_213_1.var_.characterEffect1019ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect1019ui_story then
				arg_213_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_216_3 = 0
			local var_216_4 = 1.05

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_3 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_5 = arg_213_1:GetWordFromCfg(110131050)
				local var_216_6 = arg_213_1:FormatText(var_216_5.content)

				arg_213_1.text_.text = var_216_6

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_8 = 42 <= 0 and var_216_4 or var_216_4 * (utf8.len(var_216_6) / 42)

				if (42 <= 0 and var_216_4 or var_216_4 * (utf8.len(var_216_6) / 42)) > 0 and var_216_4 < var_216_8 then
					arg_213_1.talkMaxDuration = var_216_8

					if var_216_8 + var_216_3 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_3
					end
				end

				arg_213_1.text_.text = var_216_6
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131050", "story_v_out_110131.awb") ~= 0 then
					local var_216_9 = manager.audio:GetVoiceLength("story_v_out_110131", "110131050", "story_v_out_110131.awb") / 1000

					if var_216_9 + var_216_3 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_3
					end

					if var_216_5.prefab_name ~= "" and arg_213_1.actors_[var_216_5.prefab_name] ~= nil then
						local var_216_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_5.prefab_name].transform, "story_v_out_110131", "110131050", "story_v_out_110131.awb")

						arg_213_1:RecordAudio("110131050", var_216_10)
						arg_213_1:RecordAudio("110131050", var_216_10)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_110131", "110131050", "story_v_out_110131.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_110131", "110131050", "story_v_out_110131.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_11 = math.max(var_216_4, arg_213_1.talkMaxDuration)

			if var_216_3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_3 + var_216_11 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_3) / var_216_11

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_3 + var_216_11 and arg_213_1.time_ < var_216_3 + var_216_11 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play110131051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 110131051
		arg_217_1.duration_ = 7.67

		local var_217_0 = {
			ja = 7.666,
			ko = 5.333,
			zh = 5.5,
			en = 4.5
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play110131052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_220_0 = 0
			local var_220_1 = 0.65

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(110131051)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 26 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 26)

				if (26 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 26)) > 0 and var_220_1 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131051", "story_v_out_110131.awb") ~= 0 then
					local var_220_6 = manager.audio:GetVoiceLength("story_v_out_110131", "110131051", "story_v_out_110131.awb") / 1000

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end

					if var_220_2.prefab_name ~= "" and arg_217_1.actors_[var_220_2.prefab_name] ~= nil then
						local var_220_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_2.prefab_name].transform, "story_v_out_110131", "110131051", "story_v_out_110131.awb")

						arg_217_1:RecordAudio("110131051", var_220_7)
						arg_217_1:RecordAudio("110131051", var_220_7)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_110131", "110131051", "story_v_out_110131.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_110131", "110131051", "story_v_out_110131.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play110131052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 110131052
		arg_221_1.duration_ = 13.57

		local var_221_0 = {
			ja = 8.033,
			ko = 11.766,
			zh = 13.566,
			en = 11.6
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play110131053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_224_0 = 0
			local var_224_1 = 1.425

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_2 = arg_221_1:GetWordFromCfg(110131052)
				local var_224_3 = arg_221_1:FormatText(var_224_2.content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 57 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_3) / 57)

				if (57 <= 0 and var_224_1 or var_224_1 * (utf8.len(var_224_3) / 57)) > 0 and var_224_1 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131052", "story_v_out_110131.awb") ~= 0 then
					local var_224_6 = manager.audio:GetVoiceLength("story_v_out_110131", "110131052", "story_v_out_110131.awb") / 1000

					if var_224_6 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_0
					end

					if var_224_2.prefab_name ~= "" and arg_221_1.actors_[var_224_2.prefab_name] ~= nil then
						local var_224_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_2.prefab_name].transform, "story_v_out_110131", "110131052", "story_v_out_110131.awb")

						arg_221_1:RecordAudio("110131052", var_224_7)
						arg_221_1:RecordAudio("110131052", var_224_7)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_110131", "110131052", "story_v_out_110131.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_110131", "110131052", "story_v_out_110131.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play110131053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 110131053
		arg_225_1.duration_ = 8.07

		local var_225_0 = {
			ja = 8.066,
			ko = 6.166,
			zh = 7.133,
			en = 6.666
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play110131054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_228_0 = 0
			local var_228_1 = 0.9

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(110131053)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 36 <= 0 and var_228_1 or var_228_1 * (utf8.len(var_228_3) / 36)

				if (36 <= 0 and var_228_1 or var_228_1 * (utf8.len(var_228_3) / 36)) > 0 and var_228_1 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131053", "story_v_out_110131.awb") ~= 0 then
					local var_228_6 = manager.audio:GetVoiceLength("story_v_out_110131", "110131053", "story_v_out_110131.awb") / 1000

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end

					if var_228_2.prefab_name ~= "" and arg_225_1.actors_[var_228_2.prefab_name] ~= nil then
						local var_228_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_2.prefab_name].transform, "story_v_out_110131", "110131053", "story_v_out_110131.awb")

						arg_225_1:RecordAudio("110131053", var_228_7)
						arg_225_1:RecordAudio("110131053", var_228_7)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_110131", "110131053", "story_v_out_110131.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_110131", "110131053", "story_v_out_110131.awb")
				end

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
	Play110131054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 110131054
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play110131055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1019ui_story"]) and arg_229_1.var_.characterEffect1019ui_story == nil then
				arg_229_1.var_.characterEffect1019ui_story = arg_229_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1019ui_story"]) then
				if arg_229_1.var_.characterEffect1019ui_story and not isNil(arg_229_1.actors_["1019ui_story"]) then
					arg_229_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1019ui_story"]) and arg_229_1.var_.characterEffect1019ui_story then
				arg_229_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(110131054).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 4 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 4)

				if (4 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 4)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play110131055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 110131055
		arg_233_1.duration_ = 13.43

		local var_233_0 = {
			ja = 11.7,
			ko = 8.233,
			zh = 10.933,
			en = 13.433
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play110131056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1019ui_story"]) and arg_233_1.var_.characterEffect1019ui_story == nil then
				arg_233_1.var_.characterEffect1019ui_story = arg_233_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1019ui_story"]) then
				if arg_233_1.var_.characterEffect1019ui_story and not isNil(arg_233_1.actors_["1019ui_story"]) then
					arg_233_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1019ui_story"]) and arg_233_1.var_.characterEffect1019ui_story then
				arg_233_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_236_2 = 0
			local var_236_3 = 1.375

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(110131055)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 55 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 55)

				if (55 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 55)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131055", "story_v_out_110131.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_110131", "110131055", "story_v_out_110131.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_110131", "110131055", "story_v_out_110131.awb")

						arg_233_1:RecordAudio("110131055", var_236_9)
						arg_233_1:RecordAudio("110131055", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_110131", "110131055", "story_v_out_110131.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_110131", "110131055", "story_v_out_110131.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play110131056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 110131056
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play110131057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1019ui_story"]) and arg_237_1.var_.characterEffect1019ui_story == nil then
				arg_237_1.var_.characterEffect1019ui_story = arg_237_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1019ui_story"]) then
				if arg_237_1.var_.characterEffect1019ui_story and not isNil(arg_237_1.actors_["1019ui_story"]) then
					arg_237_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1019ui_story"]) and arg_237_1.var_.characterEffect1019ui_story then
				arg_237_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.15

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(110131056).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 6 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 6)

				if (6 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 6)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play110131057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 110131057
		arg_241_1.duration_ = 9.97

		local var_241_0 = {
			ja = 6.766,
			ko = 8.666,
			zh = 7.3,
			en = 9.966
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
				arg_241_0:Play110131058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_244_0 = arg_241_1.actors_["1019ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1019ui_story == nil then
				arg_241_1.var_.characterEffect1019ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_1 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 and not isNil(var_244_0) then
				if arg_241_1.var_.characterEffect1019ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1019ui_story then
				arg_241_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_244_3 = 0
			local var_244_4 = 0.775

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_5 = arg_241_1:GetWordFromCfg(110131057)
				local var_244_6 = arg_241_1:FormatText(var_244_5.content)

				arg_241_1.text_.text = var_244_6

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_8 = 31 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_6) / 31)

				if (31 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_6) / 31)) > 0 and var_244_4 < var_244_8 then
					arg_241_1.talkMaxDuration = var_244_8

					if var_244_8 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_6
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131057", "story_v_out_110131.awb") ~= 0 then
					local var_244_9 = manager.audio:GetVoiceLength("story_v_out_110131", "110131057", "story_v_out_110131.awb") / 1000

					if var_244_9 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_3
					end

					if var_244_5.prefab_name ~= "" and arg_241_1.actors_[var_244_5.prefab_name] ~= nil then
						local var_244_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_5.prefab_name].transform, "story_v_out_110131", "110131057", "story_v_out_110131.awb")

						arg_241_1:RecordAudio("110131057", var_244_10)
						arg_241_1:RecordAudio("110131057", var_244_10)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_110131", "110131057", "story_v_out_110131.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_110131", "110131057", "story_v_out_110131.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_11 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_11 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_11

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_11 and arg_241_1.time_ < var_244_3 + var_244_11 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play110131058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 110131058
		arg_245_1.duration_ = 9.07

		local var_245_0 = {
			ja = 4.933,
			ko = 7.433,
			zh = 9.066,
			en = 7.333
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play110131059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_0 = 1.5

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				local var_248_1 = Color.New(1, 1, 1)

				var_248_1.a = Mathf.Lerp(1, 0, (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.mask_.color = var_248_1
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				local var_248_2 = Color.New(1, 1, 1)

				arg_245_1.mask_.enabled = false
				var_248_2.a = 0
				arg_245_1.mask_.color = var_248_2
			end

			local var_248_3 = arg_245_1.actors_["1019ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1019ui_story = var_248_3.localPosition
			end

			local var_248_4 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				var_248_3.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_4)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				var_248_3.localPosition = Vector3.New(0, 100, 0)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_5 = arg_245_1.bgs_.ST19

				arg_245_1.bgs_.ST19.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_248_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_6 = var_248_5:GetComponent("SpriteRenderer")

				if var_248_6 and var_248_6.sprite then
					local var_248_7 = 2 * (var_248_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_248_5.transform.localScale = Vector3.New(var_248_7 / var_248_6.sprite.bounds.size.y < var_248_7 * manager.ui.mainCameraCom_.aspect / var_248_6.sprite.bounds.size.x and var_248_7 * manager.ui.mainCameraCom_.aspect / var_248_6.sprite.bounds.size.x or var_248_7 / var_248_6.sprite.bounds.size.y, var_248_7 / var_248_6.sprite.bounds.size.y < var_248_7 * manager.ui.mainCameraCom_.aspect / var_248_6.sprite.bounds.size.x and var_248_7 * manager.ui.mainCameraCom_.aspect / var_248_6.sprite.bounds.size.x or var_248_7 / var_248_6.sprite.bounds.size.y, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "ST19" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_8 = arg_245_1.actors_["1011ui_story"].transform

			if 1.8 < arg_245_1.time_ and arg_245_1.time_ <= 1.8 + arg_248_0 then
				arg_245_1.var_.moveOldPos1011ui_story = var_248_8.localPosition
			end

			local var_248_9 = 0.001

			if 1.8 <= arg_245_1.time_ and arg_245_1.time_ < 1.8 + var_248_9 then
				var_248_8.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_245_1.time_ - 1.8) / var_248_9)
				var_248_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_8.position).x, (manager.ui.mainCamera.transform.position - var_248_8.position).y, (manager.ui.mainCamera.transform.position - var_248_8.position).z)
				var_248_8.localEulerAngles.z = 0
				var_248_8.localEulerAngles.x = 0
				var_248_8.localEulerAngles = var_248_8.localEulerAngles
			end

			if arg_245_1.time_ >= 1.8 + var_248_9 and arg_245_1.time_ < 1.8 + var_248_9 + arg_248_0 then
				var_248_8.localPosition = Vector3.New(0, -0.71, -6)
				var_248_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_8.position).x, (manager.ui.mainCamera.transform.position - var_248_8.position).y, (manager.ui.mainCamera.transform.position - var_248_8.position).z)
				var_248_8.localEulerAngles.z = 0
				var_248_8.localEulerAngles.x = 0
				var_248_8.localEulerAngles = var_248_8.localEulerAngles
			end

			if 1.8 < arg_245_1.time_ and arg_245_1.time_ <= 1.8 + arg_248_0 then
				arg_245_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 1.8 < arg_245_1.time_ and arg_245_1.time_ <= 1.8 + arg_248_0 then
				arg_245_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_248_10 = arg_245_1.actors_["1011ui_story"]

			if 1.8 < arg_245_1.time_ and arg_245_1.time_ <= 1.8 + arg_248_0 and not isNil(var_248_10) and arg_245_1.var_.characterEffect1011ui_story == nil then
				arg_245_1.var_.characterEffect1011ui_story = var_248_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_11 = 0.2

			if 1.8 <= arg_245_1.time_ and arg_245_1.time_ < 1.8 + var_248_11 and not isNil(var_248_10) then
				if arg_245_1.var_.characterEffect1011ui_story and not isNil(var_248_10) then
					arg_245_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 1.8 + var_248_11 and arg_245_1.time_ < 1.8 + var_248_11 + arg_248_0 and not isNil(var_248_10) and arg_245_1.var_.characterEffect1011ui_story then
				arg_245_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_248_13 = 0

			arg_245_1.isInRecall_ = false

			if var_248_13 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1.screenFilterGo_:SetActive(false)

				for iter_248_2, iter_248_3 in pairs(arg_245_1.actors_) do
					for iter_248_4, iter_248_5 in ipairs((iter_248_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_248_5.color = iter_248_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_248_14 = 1.5

			if var_248_13 <= arg_245_1.time_ and arg_245_1.time_ < var_248_13 + var_248_14 then
				arg_245_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_245_1.time_ - var_248_13) / var_248_14)
			end

			if arg_245_1.time_ >= var_248_13 + var_248_14 and arg_245_1.time_ < var_248_13 + var_248_14 + arg_248_0 then
				arg_245_1.screenFilterEffect_.weight = 0
			end

			local var_248_15 = 0

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_15 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			if arg_245_1.time_ >= var_248_15 + 2 and arg_245_1.time_ < var_248_15 + 2 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_16 = 2
			local var_248_17 = 0.525

			if 2 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_18 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_18:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_19 = arg_245_1:GetWordFromCfg(110131058)
				local var_248_20 = arg_245_1:FormatText(var_248_19.content)

				arg_245_1.text_.text = var_248_20

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_22 = 21 <= 0 and var_248_17 or var_248_17 * (utf8.len(var_248_20) / 21)

				if (21 <= 0 and var_248_17 or var_248_17 * (utf8.len(var_248_20) / 21)) > 0 and var_248_17 < var_248_22 then
					arg_245_1.talkMaxDuration = var_248_22
					var_248_16 = var_248_16 + 0.3

					if var_248_22 + var_248_16 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_22 + var_248_16
					end
				end

				arg_245_1.text_.text = var_248_20
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131058", "story_v_out_110131.awb") ~= 0 then
					local var_248_23 = manager.audio:GetVoiceLength("story_v_out_110131", "110131058", "story_v_out_110131.awb") / 1000

					if var_248_23 + var_248_16 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_23 + var_248_16
					end

					if var_248_19.prefab_name ~= "" and arg_245_1.actors_[var_248_19.prefab_name] ~= nil then
						local var_248_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_19.prefab_name].transform, "story_v_out_110131", "110131058", "story_v_out_110131.awb")

						arg_245_1:RecordAudio("110131058", var_248_24)
						arg_245_1:RecordAudio("110131058", var_248_24)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_110131", "110131058", "story_v_out_110131.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_110131", "110131058", "story_v_out_110131.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_25 = var_248_16 + 0.3
			local var_248_26 = math.max(var_248_17, arg_245_1.talkMaxDuration)

			if var_248_16 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_25 + var_248_26 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_25) / var_248_26

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_25 + var_248_26 and arg_245_1.time_ < var_248_25 + var_248_26 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play110131059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 110131059
		arg_251_1.duration_ = 4.13

		local var_251_0 = {
			ja = 4.133,
			ko = 3.7,
			zh = 3.266,
			en = 2.3
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play110131060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_254_0 = 0
			local var_254_1 = 0.375

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(110131059)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 14 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 14)

				if (14 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 14)) > 0 and var_254_1 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131059", "story_v_out_110131.awb") ~= 0 then
					local var_254_6 = manager.audio:GetVoiceLength("story_v_out_110131", "110131059", "story_v_out_110131.awb") / 1000

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end

					if var_254_2.prefab_name ~= "" and arg_251_1.actors_[var_254_2.prefab_name] ~= nil then
						local var_254_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_2.prefab_name].transform, "story_v_out_110131", "110131059", "story_v_out_110131.awb")

						arg_251_1:RecordAudio("110131059", var_254_7)
						arg_251_1:RecordAudio("110131059", var_254_7)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_110131", "110131059", "story_v_out_110131.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_110131", "110131059", "story_v_out_110131.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play110131060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 110131060
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play110131061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1011ui_story"]) and arg_255_1.var_.characterEffect1011ui_story == nil then
				arg_255_1.var_.characterEffect1011ui_story = arg_255_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1011ui_story"]) then
				if arg_255_1.var_.characterEffect1011ui_story and not isNil(arg_255_1.actors_["1011ui_story"]) then
					arg_255_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1011ui_story"]) and arg_255_1.var_.characterEffect1011ui_story then
				arg_255_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.775

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(110131060).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 31 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 31)

				if (31 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 31)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play110131061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 110131061
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play110131062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 1.425

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
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

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(110131061).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 57 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 57)

				if (57 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 57)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play110131062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 110131062
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play110131063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 1.25

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(110131062).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 50 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 50)

				if (50 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 50)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play110131063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 110131063
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play110131064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.925

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(110131063).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 36 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 36)

				if (36 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 36)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play110131064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 110131064
		arg_271_1.duration_ = 6.7

		local var_271_0 = {
			ja = 5.7,
			ko = 6.7,
			zh = 5.4,
			en = 3.766
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play110131065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1011ui_story"]) and arg_271_1.var_.characterEffect1011ui_story == nil then
				arg_271_1.var_.characterEffect1011ui_story = arg_271_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1011ui_story"]) then
				if arg_271_1.var_.characterEffect1011ui_story and not isNil(arg_271_1.actors_["1011ui_story"]) then
					arg_271_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1011ui_story"]) and arg_271_1.var_.characterEffect1011ui_story then
				arg_271_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_274_2 = 0
			local var_274_3 = 0.55

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_4 = arg_271_1:GetWordFromCfg(110131064)
				local var_274_5 = arg_271_1:FormatText(var_274_4.content)

				arg_271_1.text_.text = var_274_5

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_7 = 22 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 22)

				if (22 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 22)) > 0 and var_274_3 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_5
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131064", "story_v_out_110131.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_110131", "110131064", "story_v_out_110131.awb") / 1000

					if var_274_8 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_2
					end

					if var_274_4.prefab_name ~= "" and arg_271_1.actors_[var_274_4.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_4.prefab_name].transform, "story_v_out_110131", "110131064", "story_v_out_110131.awb")

						arg_271_1:RecordAudio("110131064", var_274_9)
						arg_271_1:RecordAudio("110131064", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_110131", "110131064", "story_v_out_110131.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_110131", "110131064", "story_v_out_110131.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_10 and arg_271_1.time_ < var_274_2 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play110131065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 110131065
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play110131066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_278_0 = arg_275_1.actors_["1011ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1011ui_story == nil then
				arg_275_1.var_.characterEffect1011ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_1 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_1 and not isNil(var_278_0) then
				if arg_275_1.var_.characterEffect1011ui_story and not isNil(var_278_0) then
					arg_275_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_1)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_1 and arg_275_1.time_ < 0 + var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1011ui_story then
				arg_275_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_278_2 = 0
			local var_278_3 = 0.95

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

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

				local var_278_4 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(110131065).content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_6 = 38 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 38)

				if (38 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_4) / 38)) > 0 and var_278_3 < var_278_6 then
					arg_275_1.talkMaxDuration = var_278_6

					if var_278_6 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_6 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_7 and arg_275_1.time_ < var_278_2 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play110131066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 110131066
		arg_279_1.duration_ = 2

		local var_279_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
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
				arg_279_0:Play110131067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1011ui_story"]) and arg_279_1.var_.characterEffect1011ui_story == nil then
				arg_279_1.var_.characterEffect1011ui_story = arg_279_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1011ui_story"]) then
				if arg_279_1.var_.characterEffect1011ui_story and not isNil(arg_279_1.actors_["1011ui_story"]) then
					arg_279_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1011ui_story"]) and arg_279_1.var_.characterEffect1011ui_story then
				arg_279_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_282_2 = 0
			local var_282_3 = 0.125

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:GetWordFromCfg(110131066)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 5 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 5)

				if (5 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 5)) > 0 and var_282_3 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131066", "story_v_out_110131.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_out_110131", "110131066", "story_v_out_110131.awb") / 1000

					if var_282_8 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_2
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_out_110131", "110131066", "story_v_out_110131.awb")

						arg_279_1:RecordAudio("110131066", var_282_9)
						arg_279_1:RecordAudio("110131066", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_110131", "110131066", "story_v_out_110131.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_110131", "110131066", "story_v_out_110131.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_10 and arg_279_1.time_ < var_282_2 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play110131067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 110131067
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play110131068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1011ui_story"]) and arg_283_1.var_.characterEffect1011ui_story == nil then
				arg_283_1.var_.characterEffect1011ui_story = arg_283_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1011ui_story"]) then
				if arg_283_1.var_.characterEffect1011ui_story and not isNil(arg_283_1.actors_["1011ui_story"]) then
					arg_283_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1011ui_story"]) and arg_283_1.var_.characterEffect1011ui_story then
				arg_283_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.375

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

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

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(110131067).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 15 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 15)

				if (15 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 15)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play110131068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 110131068
		arg_287_1.duration_ = 5.97

		local var_287_0 = {
			ja = 5.966,
			ko = 3.5,
			zh = 3.4,
			en = 3.866
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
				arg_287_0:Play110131069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1011ui_story"]) and arg_287_1.var_.characterEffect1011ui_story == nil then
				arg_287_1.var_.characterEffect1011ui_story = arg_287_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1011ui_story"]) then
				if arg_287_1.var_.characterEffect1011ui_story and not isNil(arg_287_1.actors_["1011ui_story"]) then
					arg_287_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1011ui_story"]) and arg_287_1.var_.characterEffect1011ui_story then
				arg_287_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action463")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_290_2 = 0
			local var_290_3 = 0.35

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(110131068)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 11 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 11)

				if (11 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 11)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131068", "story_v_out_110131.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_110131", "110131068", "story_v_out_110131.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_out_110131", "110131068", "story_v_out_110131.awb")

						arg_287_1:RecordAudio("110131068", var_290_9)
						arg_287_1:RecordAudio("110131068", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_110131", "110131068", "story_v_out_110131.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_110131", "110131068", "story_v_out_110131.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play110131069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 110131069
		arg_291_1.duration_ = 7.27

		local var_291_0 = {
			ja = 5.532999999999,
			ko = 7.265999999999,
			zh = 6.299999999999,
			en = 6.999999999999
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play110131070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if arg_291_1.bgs_.B12a == nil then
				local var_294_0 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B12a")
				var_294_0.name = "B12a"
				var_294_0.transform.parent = arg_291_1.stage_.transform
				var_294_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_.B12a = var_294_0
			end

			if 1.5 < arg_291_1.time_ and arg_291_1.time_ <= 1.5 + arg_294_0 then
				local var_294_1 = arg_291_1.bgs_.B12a

				arg_291_1.bgs_.B12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_294_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_2 = var_294_1:GetComponent("SpriteRenderer")

				if var_294_2 and var_294_2.sprite then
					local var_294_3 = 2 * (var_294_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_294_1.transform.localScale = Vector3.New(var_294_3 / var_294_2.sprite.bounds.size.y < var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x and var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x or var_294_3 / var_294_2.sprite.bounds.size.y, var_294_3 / var_294_2.sprite.bounds.size.y < var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x and var_294_3 * manager.ui.mainCameraCom_.aspect / var_294_2.sprite.bounds.size.x or var_294_3 / var_294_2.sprite.bounds.size.y, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "B12a" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				local var_294_4 = arg_291_1.bgs_.ST19:GetComponent("SpriteRenderer")

				if var_294_4 then
					arg_291_1.var_.alphaOldValueST19 = var_294_4.color.a
					arg_291_1.var_.alphaMatValueST19 = var_294_4
				end

				arg_291_1.var_.alphaOldValueST19 = 1
			end

			local var_294_5 = 1.5

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_5 then
				if arg_291_1.var_.alphaMatValueST19 then
					arg_291_1.var_.alphaMatValueST19.color.a = Mathf.Lerp(arg_291_1.var_.alphaOldValueST19, 0, (arg_291_1.time_ - 0) / var_294_5)
					arg_291_1.var_.alphaMatValueST19.color = arg_291_1.var_.alphaMatValueST19.color
				end
			end

			if arg_291_1.time_ >= 0 + var_294_5 and arg_291_1.time_ < 0 + var_294_5 + arg_294_0 and arg_291_1.var_.alphaMatValueST19 then
				arg_291_1.var_.alphaMatValueST19.color.a = 0
				arg_291_1.var_.alphaMatValueST19.color = arg_291_1.var_.alphaMatValueST19.color
			end

			if 1.5 < arg_291_1.time_ and arg_291_1.time_ <= 1.5 + arg_294_0 then
				local var_294_6 = arg_291_1.bgs_.B12a:GetComponent("SpriteRenderer")

				if var_294_6 then
					arg_291_1.var_.alphaOldValueB12a = var_294_6.color.a
					arg_291_1.var_.alphaMatValueB12a = var_294_6
				end

				arg_291_1.var_.alphaOldValueB12a = 0
			end

			local var_294_7 = 1.5

			if 1.5 <= arg_291_1.time_ and arg_291_1.time_ < 1.5 + var_294_7 then
				if arg_291_1.var_.alphaMatValueB12a then
					arg_291_1.var_.alphaMatValueB12a.color.a = Mathf.Lerp(arg_291_1.var_.alphaOldValueB12a, 1, (arg_291_1.time_ - 1.5) / var_294_7)
					arg_291_1.var_.alphaMatValueB12a.color = arg_291_1.var_.alphaMatValueB12a.color
				end
			end

			if arg_291_1.time_ >= 1.5 + var_294_7 and arg_291_1.time_ < 1.5 + var_294_7 + arg_294_0 and arg_291_1.var_.alphaMatValueB12a then
				arg_291_1.var_.alphaMatValueB12a.color.a = 1
				arg_291_1.var_.alphaMatValueB12a.color = arg_291_1.var_.alphaMatValueB12a.color
			end

			local var_294_8 = "1111ui_story"

			if arg_291_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_294_9 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_291_1.stage_.transform)

				var_294_9.name = var_294_8
				var_294_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.actors_[var_294_8] = var_294_9

				local var_294_10 = var_294_9:GetComponentInChildren(typeof(CharacterEffect))

				var_294_10.enabled = true

				local var_294_11 = GameObjectTools.GetOrAddComponent(var_294_9, typeof(DynamicBoneHelper))

				if var_294_11 then
					var_294_11:EnableDynamicBone(false)
				end

				arg_291_1:ShowWeapon(var_294_10.transform, false)

				arg_291_1.var_[var_294_8 .. "Animator"] = var_294_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_291_1.var_[var_294_8 .. "Animator"].applyRootMotion = true
				arg_291_1.var_[var_294_8 .. "LipSync"] = var_294_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_294_12 = arg_291_1.actors_["1111ui_story"].transform

			if 2.499999999999 < arg_291_1.time_ and arg_291_1.time_ <= 2.499999999999 + arg_294_0 then
				arg_291_1.var_.moveOldPos1111ui_story = var_294_12.localPosition
			end

			local var_294_13 = 0.001

			if 2.499999999999 <= arg_291_1.time_ and arg_291_1.time_ < 2.499999999999 + var_294_13 then
				var_294_12.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_291_1.time_ - 2.499999999999) / var_294_13)
				var_294_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_12.position).x, (manager.ui.mainCamera.transform.position - var_294_12.position).y, (manager.ui.mainCamera.transform.position - var_294_12.position).z)
				var_294_12.localEulerAngles.z = 0
				var_294_12.localEulerAngles.x = 0
				var_294_12.localEulerAngles = var_294_12.localEulerAngles
			end

			if arg_291_1.time_ >= 2.499999999999 + var_294_13 and arg_291_1.time_ < 2.499999999999 + var_294_13 + arg_294_0 then
				var_294_12.localPosition = Vector3.New(0, -0.87, -5.7)
				var_294_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_12.position).x, (manager.ui.mainCamera.transform.position - var_294_12.position).y, (manager.ui.mainCamera.transform.position - var_294_12.position).z)
				var_294_12.localEulerAngles.z = 0
				var_294_12.localEulerAngles.x = 0
				var_294_12.localEulerAngles = var_294_12.localEulerAngles
			end

			if 2.499999999999 < arg_291_1.time_ and arg_291_1.time_ <= 2.499999999999 + arg_294_0 then
				arg_291_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_1")
			end

			if 2.499999999999 < arg_291_1.time_ and arg_291_1.time_ <= 2.499999999999 + arg_294_0 then
				arg_291_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_294_14 = arg_291_1.actors_["1111ui_story"]

			if 2.499999999999 < arg_291_1.time_ and arg_291_1.time_ <= 2.499999999999 + arg_294_0 and not isNil(var_294_14) and arg_291_1.var_.characterEffect1111ui_story == nil then
				arg_291_1.var_.characterEffect1111ui_story = var_294_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_15 = 0.2

			if 2.499999999999 <= arg_291_1.time_ and arg_291_1.time_ < 2.499999999999 + var_294_15 and not isNil(var_294_14) then
				if arg_291_1.var_.characterEffect1111ui_story and not isNil(var_294_14) then
					arg_291_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 2.499999999999 + var_294_15 and arg_291_1.time_ < 2.499999999999 + var_294_15 + arg_294_0 and not isNil(var_294_14) and arg_291_1.var_.characterEffect1111ui_story then
				arg_291_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_294_17 = 0

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_17 + arg_294_0 then
				arg_291_1.allBtn_.enabled = false
			end

			if arg_291_1.time_ >= var_294_17 + 2.499999999999 and arg_291_1.time_ < var_294_17 + 2.499999999999 + arg_294_0 then
				arg_291_1.allBtn_.enabled = true
			end

			local var_294_18 = arg_291_1.actors_["1011ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1011ui_story = var_294_18.localPosition
			end

			local var_294_19 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_19 then
				var_294_18.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_19)
				var_294_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_18.position).x, (manager.ui.mainCamera.transform.position - var_294_18.position).y, (manager.ui.mainCamera.transform.position - var_294_18.position).z)
				var_294_18.localEulerAngles.z = 0
				var_294_18.localEulerAngles.x = 0
				var_294_18.localEulerAngles = var_294_18.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_19 and arg_291_1.time_ < 0 + var_294_19 + arg_294_0 then
				var_294_18.localPosition = Vector3.New(0, 100, 0)
				var_294_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_18.position).x, (manager.ui.mainCamera.transform.position - var_294_18.position).y, (manager.ui.mainCamera.transform.position - var_294_18.position).z)
				var_294_18.localEulerAngles.z = 0
				var_294_18.localEulerAngles.x = 0
				var_294_18.localEulerAngles = var_294_18.localEulerAngles
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_20 = 2.499999999999
			local var_294_21 = 1

			if 2.499999999999 < arg_291_1.time_ and arg_291_1.time_ <= var_294_20 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_22 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_22:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_23 = arg_291_1:GetWordFromCfg(110131069)
				local var_294_24 = arg_291_1:FormatText(var_294_23.content)

				arg_291_1.text_.text = var_294_24

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_26 = 16 <= 0 and var_294_21 or var_294_21 * (utf8.len(var_294_24) / 16)

				if (16 <= 0 and var_294_21 or var_294_21 * (utf8.len(var_294_24) / 16)) > 0 and var_294_21 < var_294_26 then
					arg_291_1.talkMaxDuration = var_294_26
					var_294_20 = var_294_20 + 0.3

					if var_294_26 + var_294_20 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_26 + var_294_20
					end
				end

				arg_291_1.text_.text = var_294_24
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131069", "story_v_out_110131.awb") ~= 0 then
					local var_294_27 = manager.audio:GetVoiceLength("story_v_out_110131", "110131069", "story_v_out_110131.awb") / 1000

					if var_294_27 + var_294_20 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_27 + var_294_20
					end

					if var_294_23.prefab_name ~= "" and arg_291_1.actors_[var_294_23.prefab_name] ~= nil then
						local var_294_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_23.prefab_name].transform, "story_v_out_110131", "110131069", "story_v_out_110131.awb")

						arg_291_1:RecordAudio("110131069", var_294_28)
						arg_291_1:RecordAudio("110131069", var_294_28)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_110131", "110131069", "story_v_out_110131.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_110131", "110131069", "story_v_out_110131.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_29 = var_294_20 + 0.3
			local var_294_30 = math.max(var_294_21, arg_291_1.talkMaxDuration)

			if var_294_20 + 0.3 <= arg_291_1.time_ and arg_291_1.time_ < var_294_29 + var_294_30 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_29) / var_294_30

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_29 + var_294_30 and arg_291_1.time_ < var_294_29 + var_294_30 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.499999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play110131070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 110131070
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play110131071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1111ui_story"]) and arg_297_1.var_.characterEffect1111ui_story == nil then
				arg_297_1.var_.characterEffect1111ui_story = arg_297_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1111ui_story"]) then
				if arg_297_1.var_.characterEffect1111ui_story and not isNil(arg_297_1.actors_["1111ui_story"]) then
					arg_297_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1111ui_story"]) and arg_297_1.var_.characterEffect1111ui_story then
				arg_297_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.325

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(110131070).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 13 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 13)

				if (13 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 13)) > 0 and var_300_2 < var_300_5 then
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

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play110131071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 110131071
		arg_301_1.duration_ = 5.73

		local var_301_0 = {
			ja = 4.333,
			ko = 5.466,
			zh = 4.6,
			en = 5.733
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play110131072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_304_0 = arg_301_1.actors_["1111ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1111ui_story == nil then
				arg_301_1.var_.characterEffect1111ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_1 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 and not isNil(var_304_0) then
				if arg_301_1.var_.characterEffect1111ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1111ui_story then
				arg_301_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_304_3 = 0
			local var_304_4 = 0.575

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_3 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_5 = arg_301_1:GetWordFromCfg(110131071)
				local var_304_6 = arg_301_1:FormatText(var_304_5.content)

				arg_301_1.text_.text = var_304_6

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_8 = 23 <= 0 and var_304_4 or var_304_4 * (utf8.len(var_304_6) / 23)

				if (23 <= 0 and var_304_4 or var_304_4 * (utf8.len(var_304_6) / 23)) > 0 and var_304_4 < var_304_8 then
					arg_301_1.talkMaxDuration = var_304_8

					if var_304_8 + var_304_3 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_3
					end
				end

				arg_301_1.text_.text = var_304_6
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131071", "story_v_out_110131.awb") ~= 0 then
					local var_304_9 = manager.audio:GetVoiceLength("story_v_out_110131", "110131071", "story_v_out_110131.awb") / 1000

					if var_304_9 + var_304_3 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_3
					end

					if var_304_5.prefab_name ~= "" and arg_301_1.actors_[var_304_5.prefab_name] ~= nil then
						local var_304_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_5.prefab_name].transform, "story_v_out_110131", "110131071", "story_v_out_110131.awb")

						arg_301_1:RecordAudio("110131071", var_304_10)
						arg_301_1:RecordAudio("110131071", var_304_10)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_110131", "110131071", "story_v_out_110131.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_110131", "110131071", "story_v_out_110131.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_11 = math.max(var_304_4, arg_301_1.talkMaxDuration)

			if var_304_3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_3 + var_304_11 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_3) / var_304_11

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_3 + var_304_11 and arg_301_1.time_ < var_304_3 + var_304_11 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play110131072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 110131072
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play110131073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1111ui_story"]) and arg_305_1.var_.characterEffect1111ui_story == nil then
				arg_305_1.var_.characterEffect1111ui_story = arg_305_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1111ui_story"]) then
				if arg_305_1.var_.characterEffect1111ui_story and not isNil(arg_305_1.actors_["1111ui_story"]) then
					arg_305_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1111ui_story"]) and arg_305_1.var_.characterEffect1111ui_story then
				arg_305_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.325

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(110131072).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 13 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 13)

				if (13 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 13)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play110131073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 110131073
		arg_309_1.duration_ = 10.87

		local var_309_0 = {
			ja = 10.866,
			ko = 7.166,
			zh = 8.3,
			en = 9.966
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play110131074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.9

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:GetWordFromCfg(110131073)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 36 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 36)

				if (36 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 36)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131073", "story_v_out_110131.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_110131", "110131073", "story_v_out_110131.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_110131", "110131073", "story_v_out_110131.awb")

						arg_309_1:RecordAudio("110131073", var_312_6)
						arg_309_1:RecordAudio("110131073", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_110131", "110131073", "story_v_out_110131.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_110131", "110131073", "story_v_out_110131.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play110131074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 110131074
		arg_313_1.duration_ = 6.77

		local var_313_0 = {
			ja = 6.766,
			ko = 2.266,
			zh = 3.5,
			en = 4.9
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play110131075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_316_0 = arg_313_1.actors_["1111ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1111ui_story == nil then
				arg_313_1.var_.characterEffect1111ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_1 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 and not isNil(var_316_0) then
				if arg_313_1.var_.characterEffect1111ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1111ui_story then
				arg_313_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_316_3 = 0
			local var_316_4 = 0.375

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_5 = arg_313_1:GetWordFromCfg(110131074)
				local var_316_6 = arg_313_1:FormatText(var_316_5.content)

				arg_313_1.text_.text = var_316_6

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_8 = 15 <= 0 and var_316_4 or var_316_4 * (utf8.len(var_316_6) / 15)

				if (15 <= 0 and var_316_4 or var_316_4 * (utf8.len(var_316_6) / 15)) > 0 and var_316_4 < var_316_8 then
					arg_313_1.talkMaxDuration = var_316_8

					if var_316_8 + var_316_3 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_3
					end
				end

				arg_313_1.text_.text = var_316_6
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131074", "story_v_out_110131.awb") ~= 0 then
					local var_316_9 = manager.audio:GetVoiceLength("story_v_out_110131", "110131074", "story_v_out_110131.awb") / 1000

					if var_316_9 + var_316_3 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_3
					end

					if var_316_5.prefab_name ~= "" and arg_313_1.actors_[var_316_5.prefab_name] ~= nil then
						local var_316_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_5.prefab_name].transform, "story_v_out_110131", "110131074", "story_v_out_110131.awb")

						arg_313_1:RecordAudio("110131074", var_316_10)
						arg_313_1:RecordAudio("110131074", var_316_10)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_110131", "110131074", "story_v_out_110131.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_110131", "110131074", "story_v_out_110131.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_11 = math.max(var_316_4, arg_313_1.talkMaxDuration)

			if var_316_3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_3 + var_316_11 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_3) / var_316_11

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_3 + var_316_11 and arg_313_1.time_ < var_316_3 + var_316_11 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play110131075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 110131075
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play110131076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1111ui_story"]) and arg_317_1.var_.characterEffect1111ui_story == nil then
				arg_317_1.var_.characterEffect1111ui_story = arg_317_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1111ui_story"]) then
				if arg_317_1.var_.characterEffect1111ui_story and not isNil(arg_317_1.actors_["1111ui_story"]) then
					arg_317_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1111ui_story"]) and arg_317_1.var_.characterEffect1111ui_story then
				arg_317_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_320_1 = arg_317_1.actors_["1111ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1111ui_story = var_320_1.localPosition
			end

			local var_320_2 = 0.1

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 then
				var_320_1.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_2)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 then
				var_320_1.localPosition = Vector3.New(0, 100, 0)
				var_320_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_1.position).x, (manager.ui.mainCamera.transform.position - var_320_1.position).y, (manager.ui.mainCamera.transform.position - var_320_1.position).z)
				var_320_1.localEulerAngles.z = 0
				var_320_1.localEulerAngles.x = 0
				var_320_1.localEulerAngles = var_320_1.localEulerAngles
			end

			local var_320_3 = 0
			local var_320_4 = 0.5

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_3 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_5 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(110131075).content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 20 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 20)

				if (20 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 20)) > 0 and var_320_4 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_3 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_3
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_4, arg_317_1.talkMaxDuration)

			if var_320_3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_3 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_3) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_3 + var_320_8 and arg_317_1.time_ < var_320_3 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play110131076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 110131076
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play110131077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.75

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(110131076).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 30 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 30)

				if (30 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 30)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play110131077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 110131077
		arg_325_1.duration_ = 2.47

		local var_325_0 = {
			ja = 2.1,
			ko = 2.466,
			zh = 1.999999999999,
			en = 2.2
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play110131078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if arg_325_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_328_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_325_1.stage_.transform)

				var_328_0.name = "1184ui_story"
				var_328_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.actors_["1184ui_story"] = var_328_0

				local var_328_1 = var_328_0:GetComponentInChildren(typeof(CharacterEffect))

				var_328_1.enabled = true

				local var_328_2 = GameObjectTools.GetOrAddComponent(var_328_0, typeof(DynamicBoneHelper))

				if var_328_2 then
					var_328_2:EnableDynamicBone(false)
				end

				arg_325_1:ShowWeapon(var_328_1.transform, false)

				arg_325_1.var_["1184ui_story" .. "Animator"] = var_328_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_325_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_325_1.var_["1184ui_story" .. "LipSync"] = var_328_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_328_3 = arg_325_1.actors_["1184ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1184ui_story = var_328_3.localPosition

				arg_325_1:ShowWeapon(arg_325_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_328_4 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				var_328_3.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_325_1.time_ - 0) / var_328_4)
				var_328_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_3.position).x, (manager.ui.mainCamera.transform.position - var_328_3.position).y, (manager.ui.mainCamera.transform.position - var_328_3.position).z)
				var_328_3.localEulerAngles.z = 0
				var_328_3.localEulerAngles.x = 0
				var_328_3.localEulerAngles = var_328_3.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				var_328_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_328_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_3.position).x, (manager.ui.mainCamera.transform.position - var_328_3.position).y, (manager.ui.mainCamera.transform.position - var_328_3.position).z)
				var_328_3.localEulerAngles.z = 0
				var_328_3.localEulerAngles.x = 0
				var_328_3.localEulerAngles = var_328_3.localEulerAngles
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_328_5 = "1084ui_story"

			if arg_325_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_328_6 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_325_1.stage_.transform)

				var_328_6.name = var_328_5
				var_328_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_325_1.actors_[var_328_5] = var_328_6

				local var_328_7 = var_328_6:GetComponentInChildren(typeof(CharacterEffect))

				var_328_7.enabled = true

				local var_328_8 = GameObjectTools.GetOrAddComponent(var_328_6, typeof(DynamicBoneHelper))

				if var_328_8 then
					var_328_8:EnableDynamicBone(false)
				end

				arg_325_1:ShowWeapon(var_328_7.transform, false)

				arg_325_1.var_[var_328_5 .. "Animator"] = var_328_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_325_1.var_[var_328_5 .. "Animator"].applyRootMotion = true
				arg_325_1.var_[var_328_5 .. "LipSync"] = var_328_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_328_9 = arg_325_1.actors_["1084ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1084ui_story == nil then
				arg_325_1.var_.characterEffect1084ui_story = var_328_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_10 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_10 and not isNil(var_328_9) then
				if arg_325_1.var_.characterEffect1084ui_story and not isNil(var_328_9) then
					arg_325_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_10 and arg_325_1.time_ < 0 + var_328_10 + arg_328_0 and not isNil(var_328_9) and arg_325_1.var_.characterEffect1084ui_story then
				arg_325_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_328_12 = 0
			local var_328_13 = 0.225

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_12 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:GetWordFromCfg(110131077)
				local var_328_15 = arg_325_1:FormatText(var_328_14.content)

				arg_325_1.text_.text = var_328_15

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_17 = 9 <= 0 and var_328_13 or var_328_13 * (utf8.len(var_328_15) / 9)

				if (9 <= 0 and var_328_13 or var_328_13 * (utf8.len(var_328_15) / 9)) > 0 and var_328_13 < var_328_17 then
					arg_325_1.talkMaxDuration = var_328_17

					if var_328_17 + var_328_12 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_17 + var_328_12
					end
				end

				arg_325_1.text_.text = var_328_15
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131077", "story_v_out_110131.awb") ~= 0 then
					local var_328_18 = manager.audio:GetVoiceLength("story_v_out_110131", "110131077", "story_v_out_110131.awb") / 1000

					if var_328_18 + var_328_12 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_12
					end

					if var_328_14.prefab_name ~= "" and arg_325_1.actors_[var_328_14.prefab_name] ~= nil then
						local var_328_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_14.prefab_name].transform, "story_v_out_110131", "110131077", "story_v_out_110131.awb")

						arg_325_1:RecordAudio("110131077", var_328_19)
						arg_325_1:RecordAudio("110131077", var_328_19)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_110131", "110131077", "story_v_out_110131.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_110131", "110131077", "story_v_out_110131.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_20 = math.max(var_328_13, arg_325_1.talkMaxDuration)

			if var_328_12 <= arg_325_1.time_ and arg_325_1.time_ < var_328_12 + var_328_20 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_12) / var_328_20

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_12 + var_328_20 and arg_325_1.time_ < var_328_12 + var_328_20 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play110131078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 110131078
		arg_329_1.duration_ = 5.3

		local var_329_0 = {
			ja = 3.966,
			ko = 5.3,
			zh = 4.133,
			en = 4.7
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play110131079(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1019ui_story = arg_329_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_332_0 = 0.1

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1019ui_story"].transform.position).z)
				arg_329_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1019ui_story"].transform.localEulerAngles = arg_329_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_329_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1019ui_story"].transform.position).z)
				arg_329_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1019ui_story"].transform.localEulerAngles = arg_329_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_332_1 = arg_329_1.actors_["1184ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1184ui_story == nil then
				arg_329_1.var_.characterEffect1184ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1184ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_2)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1184ui_story then
				arg_329_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_332_3 = arg_329_1.actors_["1019ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_3) and arg_329_1.var_.characterEffect1019ui_story == nil then
				arg_329_1.var_.characterEffect1019ui_story = var_332_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_4 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 and not isNil(var_332_3) then
				if arg_329_1.var_.characterEffect1019ui_story and not isNil(var_332_3) then
					arg_329_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 and not isNil(var_332_3) and arg_329_1.var_.characterEffect1019ui_story then
				arg_329_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_332_6 = 0
			local var_332_7 = 0.575

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_8 = arg_329_1:GetWordFromCfg(110131078)
				local var_332_9 = arg_329_1:FormatText(var_332_8.content)

				arg_329_1.text_.text = var_332_9

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 23 <= 0 and var_332_7 or var_332_7 * (utf8.len(var_332_9) / 23)

				if (23 <= 0 and var_332_7 or var_332_7 * (utf8.len(var_332_9) / 23)) > 0 and var_332_7 < var_332_11 then
					arg_329_1.talkMaxDuration = var_332_11

					if var_332_11 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_11 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_9
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131078", "story_v_out_110131.awb") ~= 0 then
					local var_332_12 = manager.audio:GetVoiceLength("story_v_out_110131", "110131078", "story_v_out_110131.awb") / 1000

					if var_332_12 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_12 + var_332_6
					end

					if var_332_8.prefab_name ~= "" and arg_329_1.actors_[var_332_8.prefab_name] ~= nil then
						local var_332_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_8.prefab_name].transform, "story_v_out_110131", "110131078", "story_v_out_110131.awb")

						arg_329_1:RecordAudio("110131078", var_332_13)
						arg_329_1:RecordAudio("110131078", var_332_13)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_110131", "110131078", "story_v_out_110131.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_110131", "110131078", "story_v_out_110131.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_14 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_14

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_14 and arg_329_1.time_ < var_332_6 + var_332_14 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play110131079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 110131079
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play110131080(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1019ui_story"]) and arg_333_1.var_.characterEffect1019ui_story == nil then
				arg_333_1.var_.characterEffect1019ui_story = arg_333_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1019ui_story"]) then
				if arg_333_1.var_.characterEffect1019ui_story and not isNil(arg_333_1.actors_["1019ui_story"]) then
					arg_333_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1019ui_story"]) and arg_333_1.var_.characterEffect1019ui_story then
				arg_333_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.4

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(110131079).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 16 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 16)

				if (16 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 16)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play110131080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 110131080
		arg_337_1.duration_ = 8.27

		local var_337_0 = {
			ja = 8.266,
			ko = 5,
			zh = 5.6,
			en = 5.566
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play110131081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1019ui_story"]) and arg_337_1.var_.characterEffect1019ui_story == nil then
				arg_337_1.var_.characterEffect1019ui_story = arg_337_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1019ui_story"]) then
				if arg_337_1.var_.characterEffect1019ui_story and not isNil(arg_337_1.actors_["1019ui_story"]) then
					arg_337_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1019ui_story"]) and arg_337_1.var_.characterEffect1019ui_story then
				arg_337_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_340_2 = 0
			local var_340_3 = 0.625

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(110131080)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 25 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 25)

				if (25 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 25)) > 0 and var_340_3 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131080", "story_v_out_110131.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_110131", "110131080", "story_v_out_110131.awb") / 1000

					if var_340_8 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_2
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_out_110131", "110131080", "story_v_out_110131.awb")

						arg_337_1:RecordAudio("110131080", var_340_9)
						arg_337_1:RecordAudio("110131080", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_110131", "110131080", "story_v_out_110131.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_110131", "110131080", "story_v_out_110131.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_10 and arg_337_1.time_ < var_340_2 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play110131081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 110131081
		arg_341_1.duration_ = 9.93

		local var_341_0 = {
			ja = 9.9,
			ko = 9.633,
			zh = 9.933,
			en = 9.266
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play110131082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1184ui_story = arg_341_1.actors_["1184ui_story"].transform.localPosition

				arg_341_1:ShowWeapon(arg_341_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1184ui_story"].transform.position).z)
				arg_341_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1184ui_story"].transform.localEulerAngles = arg_341_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_341_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1184ui_story"].transform.position).z)
				arg_341_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1184ui_story"].transform.localEulerAngles = arg_341_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1019ui_story"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1019ui_story = var_344_1.localPosition
			end

			local var_344_2 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 then
				var_344_1.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_2)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 then
				var_344_1.localPosition = Vector3.New(0, 100, 0)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			local var_344_3 = arg_341_1.actors_["1111ui_story"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1111ui_story = var_344_3.localPosition
			end

			local var_344_4 = 0.1

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				var_344_3.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_341_1.time_ - 0) / var_344_4)
				var_344_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_3.position).x, (manager.ui.mainCamera.transform.position - var_344_3.position).y, (manager.ui.mainCamera.transform.position - var_344_3.position).z)
				var_344_3.localEulerAngles.z = 0
				var_344_3.localEulerAngles.x = 0
				var_344_3.localEulerAngles = var_344_3.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				var_344_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_344_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_3.position).x, (manager.ui.mainCamera.transform.position - var_344_3.position).y, (manager.ui.mainCamera.transform.position - var_344_3.position).z)
				var_344_3.localEulerAngles.z = 0
				var_344_3.localEulerAngles.x = 0
				var_344_3.localEulerAngles = var_344_3.localEulerAngles
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_344_5 = arg_341_1.actors_["1111ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.characterEffect1111ui_story == nil then
				arg_341_1.var_.characterEffect1111ui_story = var_344_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_6 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_6 and not isNil(var_344_5) then
				if arg_341_1.var_.characterEffect1111ui_story and not isNil(var_344_5) then
					arg_341_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_6 and arg_341_1.time_ < 0 + var_344_6 + arg_344_0 and not isNil(var_344_5) and arg_341_1.var_.characterEffect1111ui_story then
				arg_341_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_344_8 = 0
			local var_344_9 = 0.975

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_10 = arg_341_1:GetWordFromCfg(110131081)
				local var_344_11 = arg_341_1:FormatText(var_344_10.content)

				arg_341_1.text_.text = var_344_11

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_13 = 39 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 39)

				if (39 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 39)) > 0 and var_344_9 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_8
					end
				end

				arg_341_1.text_.text = var_344_11
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131081", "story_v_out_110131.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_out_110131", "110131081", "story_v_out_110131.awb") / 1000

					if var_344_14 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_8
					end

					if var_344_10.prefab_name ~= "" and arg_341_1.actors_[var_344_10.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_10.prefab_name].transform, "story_v_out_110131", "110131081", "story_v_out_110131.awb")

						arg_341_1:RecordAudio("110131081", var_344_15)
						arg_341_1:RecordAudio("110131081", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_110131", "110131081", "story_v_out_110131.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_110131", "110131081", "story_v_out_110131.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_9, arg_341_1.talkMaxDuration)

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_8) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_8 + var_344_16 and arg_341_1.time_ < var_344_8 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play110131082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 110131082
		arg_345_1.duration_ = 2.17

		local var_345_0 = {
			ja = 2.066,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.166
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play110131083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1111ui_story = arg_345_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1111ui_story"].transform.position).z)
				arg_345_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1111ui_story"].transform.localEulerAngles = arg_345_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1111ui_story"].transform.position).z)
				arg_345_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1111ui_story"].transform.localEulerAngles = arg_345_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1019ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1019ui_story = var_348_1.localPosition
			end

			local var_348_2 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 then
				var_348_1.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_345_1.time_ - 0) / var_348_2)
				var_348_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_1.position).x, (manager.ui.mainCamera.transform.position - var_348_1.position).y, (manager.ui.mainCamera.transform.position - var_348_1.position).z)
				var_348_1.localEulerAngles.z = 0
				var_348_1.localEulerAngles.x = 0
				var_348_1.localEulerAngles = var_348_1.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 then
				var_348_1.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_348_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_1.position).x, (manager.ui.mainCamera.transform.position - var_348_1.position).y, (manager.ui.mainCamera.transform.position - var_348_1.position).z)
				var_348_1.localEulerAngles.z = 0
				var_348_1.localEulerAngles.x = 0
				var_348_1.localEulerAngles = var_348_1.localEulerAngles
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_348_3 = arg_345_1.actors_["1019ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_3) and arg_345_1.var_.characterEffect1019ui_story == nil then
				arg_345_1.var_.characterEffect1019ui_story = var_348_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_4 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 and not isNil(var_348_3) then
				if arg_345_1.var_.characterEffect1019ui_story and not isNil(var_348_3) then
					arg_345_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 and not isNil(var_348_3) and arg_345_1.var_.characterEffect1019ui_story then
				arg_345_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_348_6 = 0
			local var_348_7 = 0.15

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:GetWordFromCfg(110131082)
				local var_348_9 = arg_345_1:FormatText(var_348_8.content)

				arg_345_1.text_.text = var_348_9

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 6 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_9) / 6)

				if (6 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_9) / 6)) > 0 and var_348_7 < var_348_11 then
					arg_345_1.talkMaxDuration = var_348_11

					if var_348_11 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_11 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_9
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131082", "story_v_out_110131.awb") ~= 0 then
					local var_348_12 = manager.audio:GetVoiceLength("story_v_out_110131", "110131082", "story_v_out_110131.awb") / 1000

					if var_348_12 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_6
					end

					if var_348_8.prefab_name ~= "" and arg_345_1.actors_[var_348_8.prefab_name] ~= nil then
						local var_348_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_8.prefab_name].transform, "story_v_out_110131", "110131082", "story_v_out_110131.awb")

						arg_345_1:RecordAudio("110131082", var_348_13)
						arg_345_1:RecordAudio("110131082", var_348_13)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_110131", "110131082", "story_v_out_110131.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_110131", "110131082", "story_v_out_110131.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play110131083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 110131083
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play110131084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1019ui_story"]) and arg_349_1.var_.characterEffect1019ui_story == nil then
				arg_349_1.var_.characterEffect1019ui_story = arg_349_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1019ui_story"]) then
				if arg_349_1.var_.characterEffect1019ui_story and not isNil(arg_349_1.actors_["1019ui_story"]) then
					arg_349_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1019ui_story"]) and arg_349_1.var_.characterEffect1019ui_story then
				arg_349_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_352_1 = 0
			local var_352_2 = 0.8

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(110131083).content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 32 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 32)

				if (32 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 32)) > 0 and var_352_2 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_6 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_6 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_6

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_6 and arg_349_1.time_ < var_352_1 + var_352_6 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play110131084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 110131084
		arg_353_1.duration_ = 7.8

		local var_353_0 = {
			ja = 7.8,
			ko = 6.6,
			zh = 4.566,
			en = 5.5
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play110131085(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1019ui_story"]) and arg_353_1.var_.characterEffect1019ui_story == nil then
				arg_353_1.var_.characterEffect1019ui_story = arg_353_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1019ui_story"]) then
				if arg_353_1.var_.characterEffect1019ui_story and not isNil(arg_353_1.actors_["1019ui_story"]) then
					arg_353_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1019ui_story"]) and arg_353_1.var_.characterEffect1019ui_story then
				arg_353_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_356_2 = 0
			local var_356_3 = 0.575

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_4 = arg_353_1:GetWordFromCfg(110131084)
				local var_356_5 = arg_353_1:FormatText(var_356_4.content)

				arg_353_1.text_.text = var_356_5

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_7 = 23 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 23)

				if (23 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 23)) > 0 and var_356_3 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_2
					end
				end

				arg_353_1.text_.text = var_356_5
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131084", "story_v_out_110131.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_110131", "110131084", "story_v_out_110131.awb") / 1000

					if var_356_8 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_2
					end

					if var_356_4.prefab_name ~= "" and arg_353_1.actors_[var_356_4.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_4.prefab_name].transform, "story_v_out_110131", "110131084", "story_v_out_110131.awb")

						arg_353_1:RecordAudio("110131084", var_356_9)
						arg_353_1:RecordAudio("110131084", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_110131", "110131084", "story_v_out_110131.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_110131", "110131084", "story_v_out_110131.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_3, arg_353_1.talkMaxDuration)

			if var_356_2 <= arg_353_1.time_ and arg_353_1.time_ < var_356_2 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_2) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_2 + var_356_10 and arg_353_1.time_ < var_356_2 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play110131085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 110131085
		arg_357_1.duration_ = 9.67

		local var_357_0 = {
			ja = 9.666,
			ko = 8.833,
			zh = 7.466,
			en = 9.066
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play110131086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1019ui_story = arg_357_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1019ui_story"].transform.position).z)
				arg_357_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1019ui_story"].transform.localEulerAngles = arg_357_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_357_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1019ui_story"].transform.position).z)
				arg_357_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1019ui_story"].transform.localEulerAngles = arg_357_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1111ui_story"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1111ui_story = var_360_1.localPosition
			end

			local var_360_2 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 then
				var_360_1.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_357_1.time_ - 0) / var_360_2)
				var_360_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_1.position).x, (manager.ui.mainCamera.transform.position - var_360_1.position).y, (manager.ui.mainCamera.transform.position - var_360_1.position).z)
				var_360_1.localEulerAngles.z = 0
				var_360_1.localEulerAngles.x = 0
				var_360_1.localEulerAngles = var_360_1.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 then
				var_360_1.localPosition = Vector3.New(0, -0.87, -5.7)
				var_360_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_1.position).x, (manager.ui.mainCamera.transform.position - var_360_1.position).y, (manager.ui.mainCamera.transform.position - var_360_1.position).z)
				var_360_1.localEulerAngles.z = 0
				var_360_1.localEulerAngles.x = 0
				var_360_1.localEulerAngles = var_360_1.localEulerAngles
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_360_3 = arg_357_1.actors_["1111ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_3) and arg_357_1.var_.characterEffect1111ui_story == nil then
				arg_357_1.var_.characterEffect1111ui_story = var_360_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_4 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 and not isNil(var_360_3) then
				if arg_357_1.var_.characterEffect1111ui_story and not isNil(var_360_3) then
					arg_357_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 and not isNil(var_360_3) and arg_357_1.var_.characterEffect1111ui_story then
				arg_357_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_360_6 = 0
			local var_360_7 = 0.8

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_8 = arg_357_1:GetWordFromCfg(110131085)
				local var_360_9 = arg_357_1:FormatText(var_360_8.content)

				arg_357_1.text_.text = var_360_9

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_11 = 32 <= 0 and var_360_7 or var_360_7 * (utf8.len(var_360_9) / 32)

				if (32 <= 0 and var_360_7 or var_360_7 * (utf8.len(var_360_9) / 32)) > 0 and var_360_7 < var_360_11 then
					arg_357_1.talkMaxDuration = var_360_11

					if var_360_11 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_11 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_9
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131085", "story_v_out_110131.awb") ~= 0 then
					local var_360_12 = manager.audio:GetVoiceLength("story_v_out_110131", "110131085", "story_v_out_110131.awb") / 1000

					if var_360_12 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_12 + var_360_6
					end

					if var_360_8.prefab_name ~= "" and arg_357_1.actors_[var_360_8.prefab_name] ~= nil then
						local var_360_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_8.prefab_name].transform, "story_v_out_110131", "110131085", "story_v_out_110131.awb")

						arg_357_1:RecordAudio("110131085", var_360_13)
						arg_357_1:RecordAudio("110131085", var_360_13)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_110131", "110131085", "story_v_out_110131.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_110131", "110131085", "story_v_out_110131.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_14 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_14 and arg_357_1.time_ < var_360_6 + var_360_14 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play110131086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 110131086
		arg_361_1.duration_ = 8.57

		local var_361_0 = {
			ja = 8.566,
			ko = 3.566,
			zh = 4.3,
			en = 4.566
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
			arg_361_1.auto_ = false
		end

		function arg_361_1.playNext_(arg_363_0)
			arg_361_1.onStoryFinished_()
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action454")
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_364_0 = 0
			local var_364_1 = 0.35

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_2 = arg_361_1:GetWordFromCfg(110131086)
				local var_364_3 = arg_361_1:FormatText(var_364_2.content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 14 <= 0 and var_364_1 or var_364_1 * (utf8.len(var_364_3) / 14)

				if (14 <= 0 and var_364_1 or var_364_1 * (utf8.len(var_364_3) / 14)) > 0 and var_364_1 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_110131", "110131086", "story_v_out_110131.awb") ~= 0 then
					local var_364_6 = manager.audio:GetVoiceLength("story_v_out_110131", "110131086", "story_v_out_110131.awb") / 1000

					if var_364_6 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_0
					end

					if var_364_2.prefab_name ~= "" and arg_361_1.actors_[var_364_2.prefab_name] ~= nil then
						local var_364_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_2.prefab_name].transform, "story_v_out_110131", "110131086", "story_v_out_110131.awb")

						arg_361_1:RecordAudio("110131086", var_364_7)
						arg_361_1:RecordAudio("110131086", var_364_7)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_110131", "110131086", "story_v_out_110131.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_110131", "110131086", "story_v_out_110131.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST19",
		"TextureConfig/Background/OS0102",
		"TextureConfig/Background/OS0102a",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/B12a"
	},
	voices = {
		"story_v_out_110131.awb"
	}
}
