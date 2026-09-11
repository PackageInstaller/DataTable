return {
	Play924021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 924021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play924021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_4_0.name = "ST12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST12

				arg_1_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST12" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			if 0.125 < arg_1_1.time_ and arg_1_1.time_ <= 0.125 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.6

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(924021001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 24 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 24)

				if (24 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 24)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play924021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 924021002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play924021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.15

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(924021002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 46 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 46)

				if (46 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 46)) > 0 and var_12_0 < var_12_3 then
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
	Play924021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 924021003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play924021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.3

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(924021003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 52 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 52)

				if (52 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 52)) > 0 and var_16_0 < var_16_3 then
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
	Play924021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 924021004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play924021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.125

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(924021004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 5 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 5)

				if (5 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 5)) > 0 and var_20_0 < var_20_3 then
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
	Play924021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 924021005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play924021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.075

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

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(924021005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 43 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 43)

				if (43 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 43)) > 0 and var_24_0 < var_24_3 then
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
	Play924021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 924021006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play924021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.3

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(924021006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 52 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 52)

				if (52 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 52)) > 0 and var_28_0 < var_28_3 then
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
	Play924021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 924021007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play924021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.0329999998211861

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

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(924021007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 1 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 1)

				if (1 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 1)) > 0 and var_32_0 < var_32_3 then
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
	Play924021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 924021008
		arg_33_1.duration_ = 4.3

		local var_33_0 = {
			zh = 4.3,
			ja = 3.633
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play924021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(924021008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 10 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 10)

				if (10 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 10)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021008", "story_v_side_old_924021.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021008", "story_v_side_old_924021.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_side_old_924021", "924021008", "story_v_side_old_924021.awb")

						arg_33_1:RecordAudio("924021008", var_36_6)
						arg_33_1:RecordAudio("924021008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021008", "story_v_side_old_924021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021008", "story_v_side_old_924021.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play924021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 924021009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play924021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.725

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

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(924021009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 29)

				if (29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 29)) > 0 and var_40_0 < var_40_3 then
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
	Play924021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 924021010
		arg_41_1.duration_ = 3.4

		local var_41_0 = {
			zh = 3.033,
			ja = 3.4
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
				arg_41_0:Play924021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.actors_["102003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102003ui_story"))) then
				local var_44_0 = Object.Instantiate(Asset.Load("Char/" .. "102003ui_story"), arg_41_1.stage_.transform)

				var_44_0.name = "102003ui_story"
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["102003ui_story"] = var_44_0

				local var_44_1 = var_44_0:GetComponentInChildren(typeof(CharacterEffect))

				var_44_1.enabled = true

				local var_44_2 = GameObjectTools.GetOrAddComponent(var_44_0, typeof(DynamicBoneHelper))

				if var_44_2 then
					var_44_2:EnableDynamicBone(false)
				end

				arg_41_1:ShowWeapon(var_44_1.transform, false)

				arg_41_1.var_["102003ui_story" .. "Animator"] = var_44_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_41_1.var_["102003ui_story" .. "Animator"].applyRootMotion = true
				arg_41_1.var_["102003ui_story" .. "LipSync"] = var_44_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_44_3 = arg_41_1.actors_["102003ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos102003ui_story = var_44_3.localPosition
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_3.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_41_1.time_ - 0) / var_44_4)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = Vector3.New(0, -0.85, -6.21)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			local var_44_5 = arg_41_1.actors_["102003ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect102003ui_story == nil then
				arg_41_1.var_.characterEffect102003ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.characterEffect102003ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect102003ui_story then
				arg_41_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_8 = 0
			local var_44_9 = 0.15

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(924021010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 6 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 6)

				if (6 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 6)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021010", "story_v_side_old_924021.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021010", "story_v_side_old_924021.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_side_old_924021", "924021010", "story_v_side_old_924021.awb")

						arg_41_1:RecordAudio("924021010", var_44_15)
						arg_41_1:RecordAudio("924021010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021010", "story_v_side_old_924021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021010", "story_v_side_old_924021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play924021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 924021011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play924021012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["102003ui_story"]) and arg_45_1.var_.characterEffect102003ui_story == nil then
				arg_45_1.var_.characterEffect102003ui_story = arg_45_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["102003ui_story"]) then
				if arg_45_1.var_.characterEffect102003ui_story and not isNil(arg_45_1.actors_["102003ui_story"]) then
					arg_45_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_45_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["102003ui_story"]) and arg_45_1.var_.characterEffect102003ui_story then
				arg_45_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_45_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 1.375

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

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(924021011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 55 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 55)

				if (55 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 55)) > 0 and var_48_2 < var_48_5 then
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
	Play924021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 924021012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play924021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.2

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(924021012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 8 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 8)

				if (8 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 8)) > 0 and var_52_0 < var_52_3 then
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
	Play924021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 924021013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play924021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos102003ui_story = arg_53_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["102003ui_story"].transform.position).z)
				arg_53_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["102003ui_story"].transform.localEulerAngles = arg_53_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["102003ui_story"].transform.position).z)
				arg_53_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["102003ui_story"].transform.localEulerAngles = arg_53_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_56_1 = 0
			local var_56_2 = 1.225

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(924021013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 49 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 49)

				if (49 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 49)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play924021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 924021014
		arg_57_1.duration_ = 4.8

		local var_57_0 = {
			zh = 4.8,
			ja = 4.4
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play924021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos102003ui_story = arg_57_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["102003ui_story"].transform.position).z)
				arg_57_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["102003ui_story"].transform.localEulerAngles = arg_57_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_57_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["102003ui_story"].transform.position).z)
				arg_57_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["102003ui_story"].transform.localEulerAngles = arg_57_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["102003ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect102003ui_story == nil then
				arg_57_1.var_.characterEffect102003ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect102003ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect102003ui_story then
				arg_57_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_60_4 = 0
			local var_60_5 = 0.325

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(924021014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 13 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 13)

				if (13 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 13)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021014", "story_v_side_old_924021.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021014", "story_v_side_old_924021.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_old_924021", "924021014", "story_v_side_old_924021.awb")

						arg_57_1:RecordAudio("924021014", var_60_11)
						arg_57_1:RecordAudio("924021014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021014", "story_v_side_old_924021.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021014", "story_v_side_old_924021.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play924021015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 924021015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play924021016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["102003ui_story"]) and arg_61_1.var_.characterEffect102003ui_story == nil then
				arg_61_1.var_.characterEffect102003ui_story = arg_61_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["102003ui_story"]) then
				if arg_61_1.var_.characterEffect102003ui_story and not isNil(arg_61_1.actors_["102003ui_story"]) then
					arg_61_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_61_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["102003ui_story"]) and arg_61_1.var_.characterEffect102003ui_story then
				arg_61_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_61_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0.125 < arg_61_1.time_ and arg_61_1.time_ <= 0.125 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_plastic", "")
			end

			local var_64_2 = 0
			local var_64_3 = 0.925

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(924021015).content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 37 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 37)

				if (37 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 37)) > 0 and var_64_3 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_7 and arg_61_1.time_ < var_64_2 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play924021016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 924021016
		arg_65_1.duration_ = 3.9

		local var_65_0 = {
			zh = 2.433,
			ja = 3.9
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
				arg_65_0:Play924021017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos102003ui_story = arg_65_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).z)
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles = arg_65_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_65_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["102003ui_story"].transform.position).z)
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["102003ui_story"].transform.localEulerAngles = arg_65_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["102003ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect102003ui_story == nil then
				arg_65_1.var_.characterEffect102003ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect102003ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect102003ui_story then
				arg_65_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action443")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_68_4 = 0
			local var_68_5 = 0.15

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(924021016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 6 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 6)

				if (6 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 6)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021016", "story_v_side_old_924021.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021016", "story_v_side_old_924021.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_old_924021", "924021016", "story_v_side_old_924021.awb")

						arg_65_1:RecordAudio("924021016", var_68_11)
						arg_65_1:RecordAudio("924021016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021016", "story_v_side_old_924021.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021016", "story_v_side_old_924021.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play924021017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 924021017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play924021018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["102003ui_story"]) and arg_69_1.var_.characterEffect102003ui_story == nil then
				arg_69_1.var_.characterEffect102003ui_story = arg_69_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["102003ui_story"]) then
				if arg_69_1.var_.characterEffect102003ui_story and not isNil(arg_69_1.actors_["102003ui_story"]) then
					arg_69_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_69_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["102003ui_story"]) and arg_69_1.var_.characterEffect102003ui_story then
				arg_69_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_69_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.6

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(924021017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 24 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 24)

				if (24 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 24)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play924021018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 924021018
		arg_73_1.duration_ = 3.33

		local var_73_0 = {
			zh = 3,
			ja = 3.333
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
				arg_73_0:Play924021019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos102003ui_story = arg_73_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["102003ui_story"].transform.position).z)
				arg_73_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["102003ui_story"].transform.localEulerAngles = arg_73_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_73_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["102003ui_story"].transform.position).z)
				arg_73_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["102003ui_story"].transform.localEulerAngles = arg_73_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["102003ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect102003ui_story == nil then
				arg_73_1.var_.characterEffect102003ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect102003ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect102003ui_story then
				arg_73_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action437")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_76_4 = 0
			local var_76_5 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(924021018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 8 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 8)

				if (8 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 8)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021018", "story_v_side_old_924021.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021018", "story_v_side_old_924021.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_side_old_924021", "924021018", "story_v_side_old_924021.awb")

						arg_73_1:RecordAudio("924021018", var_76_11)
						arg_73_1:RecordAudio("924021018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021018", "story_v_side_old_924021.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021018", "story_v_side_old_924021.awb")
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

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play924021019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 924021019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play924021020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["102003ui_story"]) and arg_77_1.var_.characterEffect102003ui_story == nil then
				arg_77_1.var_.characterEffect102003ui_story = arg_77_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["102003ui_story"]) then
				if arg_77_1.var_.characterEffect102003ui_story and not isNil(arg_77_1.actors_["102003ui_story"]) then
					arg_77_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_77_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["102003ui_story"]) and arg_77_1.var_.characterEffect102003ui_story then
				arg_77_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_77_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
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

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(924021019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 17 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 17)

				if (17 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 17)) > 0 and var_80_2 < var_80_5 then
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
	Play924021020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 924021020
		arg_81_1.duration_ = 2.87

		local var_81_0 = {
			zh = 2.2,
			ja = 2.866
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
				arg_81_0:Play924021021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos102003ui_story = arg_81_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).z)
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles = arg_81_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_81_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["102003ui_story"].transform.position).z)
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["102003ui_story"].transform.localEulerAngles = arg_81_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["102003ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect102003ui_story == nil then
				arg_81_1.var_.characterEffect102003ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect102003ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect102003ui_story then
				arg_81_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action7_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_84_4 = 0
			local var_84_5 = 0.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(924021020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 7 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 7)

				if (7 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 7)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021020", "story_v_side_old_924021.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021020", "story_v_side_old_924021.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_side_old_924021", "924021020", "story_v_side_old_924021.awb")

						arg_81_1:RecordAudio("924021020", var_84_11)
						arg_81_1:RecordAudio("924021020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021020", "story_v_side_old_924021.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021020", "story_v_side_old_924021.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play924021021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 924021021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play924021022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos102003ui_story = arg_85_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["102003ui_story"].transform.position).z)
				arg_85_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["102003ui_story"].transform.localEulerAngles = arg_85_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["102003ui_story"].transform.position).z)
				arg_85_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["102003ui_story"].transform.localEulerAngles = arg_85_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["102003ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect102003ui_story == nil then
				arg_85_1.var_.characterEffect102003ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect102003ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_85_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect102003ui_story then
				arg_85_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_85_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_88_3 = 0
			local var_88_4 = 1.225

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(924021021).content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 49 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 49)

				if (49 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 49)) > 0 and var_88_4 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_8 and arg_85_1.time_ < var_88_3 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924021022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 924021022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play924021023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_92_0 = 0.6

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				local var_92_1, var_92_2 = math.modf((arg_89_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_92_2 * 0.13, var_92_2 * 0.13, var_92_2 * 0.13) + arg_89_1.var_.shakeOldPos
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				manager.ui.mainCamera.transform.localPosition = arg_89_1.var_.shakeOldPos
			end

			local var_92_3 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_3 + 0.6 and arg_89_1.time_ < var_92_3 + 0.6 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_4 = 0
			local var_92_5 = 0.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_6 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(924021022).content)

				arg_89_1.text_.text = var_92_6

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_8 = 8 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 8)

				if (8 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 8)) > 0 and var_92_5 < var_92_8 then
					arg_89_1.talkMaxDuration = var_92_8

					if var_92_8 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_6
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_9 and arg_89_1.time_ < var_92_4 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play924021023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 924021023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play924021024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.1

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(924021023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 44 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 44)

				if (44 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 44)) > 0 and var_96_0 < var_96_3 then
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
	Play924021024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 924021024
		arg_97_1.duration_ = 2

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play924021025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos102003ui_story = arg_97_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).z)
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles = arg_97_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_97_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["102003ui_story"].transform.position).z)
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["102003ui_story"].transform.localEulerAngles = arg_97_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["102003ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect102003ui_story == nil then
				arg_97_1.var_.characterEffect102003ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect102003ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect102003ui_story then
				arg_97_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_100_4 = 0
			local var_100_5 = 0.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(924021024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 5 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 5)

				if (5 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 5)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021024", "story_v_side_old_924021.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021024", "story_v_side_old_924021.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_side_old_924021", "924021024", "story_v_side_old_924021.awb")

						arg_97_1:RecordAudio("924021024", var_100_11)
						arg_97_1:RecordAudio("924021024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021024", "story_v_side_old_924021.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021024", "story_v_side_old_924021.awb")
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

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play924021025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 924021025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play924021026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["102003ui_story"]) and arg_101_1.var_.characterEffect102003ui_story == nil then
				arg_101_1.var_.characterEffect102003ui_story = arg_101_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["102003ui_story"]) then
				if arg_101_1.var_.characterEffect102003ui_story and not isNil(arg_101_1.actors_["102003ui_story"]) then
					arg_101_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_101_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["102003ui_story"]) and arg_101_1.var_.characterEffect102003ui_story then
				arg_101_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_101_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
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

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(924021025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 19 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 19)

				if (19 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 19)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play924021026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 924021026
		arg_105_1.duration_ = 3.8

		local var_105_0 = {
			zh = 3.8,
			ja = 3.766
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
				arg_105_0:Play924021027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos102003ui_story = arg_105_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["102003ui_story"].transform.position).z)
				arg_105_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["102003ui_story"].transform.localEulerAngles = arg_105_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_105_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["102003ui_story"].transform.position).z)
				arg_105_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["102003ui_story"].transform.localEulerAngles = arg_105_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["102003ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect102003ui_story == nil then
				arg_105_1.var_.characterEffect102003ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect102003ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect102003ui_story then
				arg_105_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.3

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(924021026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 12 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 12)

				if (12 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 12)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021026", "story_v_side_old_924021.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021026", "story_v_side_old_924021.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_side_old_924021", "924021026", "story_v_side_old_924021.awb")

						arg_105_1:RecordAudio("924021026", var_108_11)
						arg_105_1:RecordAudio("924021026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021026", "story_v_side_old_924021.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021026", "story_v_side_old_924021.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play924021027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 924021027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play924021028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos102003ui_story = arg_109_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).z)
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles = arg_109_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["102003ui_story"].transform.position).z)
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["102003ui_story"].transform.localEulerAngles = arg_109_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["102003ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect102003ui_story == nil then
				arg_109_1.var_.characterEffect102003ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect102003ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_109_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect102003ui_story then
				arg_109_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_109_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_112_3 = 0
			local var_112_4 = 0.95

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(924021027).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 38 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 38)

				if (38 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 38)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play924021028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 924021028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play924021029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.725

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(924021028).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 29 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 29)

				if (29 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 29)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play924021029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 924021029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play924021030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.35

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

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(924021029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 14 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 14)

				if (14 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 14)) > 0 and var_120_0 < var_120_3 then
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
	Play924021030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 924021030
		arg_121_1.duration_ = 3.67

		local var_121_0 = {
			zh = 3.666,
			ja = 2.5
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
				arg_121_0:Play924021031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos102003ui_story = arg_121_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).z)
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles = arg_121_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_121_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["102003ui_story"].transform.position).z)
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["102003ui_story"].transform.localEulerAngles = arg_121_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["102003ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect102003ui_story == nil then
				arg_121_1.var_.characterEffect102003ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect102003ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect102003ui_story then
				arg_121_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_124_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_121_1.bgmTxt_.text ~= var_124_6 and arg_121_1.bgmTxt_.text ~= "" then
						if arg_121_1.bgmTxt2_.text ~= "" then
							arg_121_1.bgmTxt_.text = arg_121_1.bgmTxt2_.text
						end

						arg_121_1.bgmTxt2_.text = var_124_6

						arg_121_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_121_1.bgmTxt_.text = var_124_6
						arg_121_1.bgmTxt2_.text = var_124_6
					end

					if arg_121_1.bgmTimer then
						arg_121_1.bgmTimer:Stop()

						arg_121_1.bgmTimer = nil
					end

					if arg_121_1.settingData.show_music_name == 1 then
						arg_121_1.musicController:SetSelectedState("show")
						arg_121_1.musicAnimator_:Play("open", 0, 0)

						if arg_121_1.settingData.music_time ~= 0 then
							arg_121_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_121_1.settingData.music_time), function()
								if arg_121_1 == nil or isNil(arg_121_1.bgmTxt_) then
									return
								end

								arg_121_1.musicController:SetSelectedState("hide")
								arg_121_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_124_7 = 0
			local var_124_8 = 0.175

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_9 = arg_121_1:GetWordFromCfg(924021030)
				local var_124_10 = arg_121_1:FormatText(var_124_9.content)

				arg_121_1.text_.text = var_124_10

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_12 = 7 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_10) / 7)

				if (7 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_10) / 7)) > 0 and var_124_8 < var_124_12 then
					arg_121_1.talkMaxDuration = var_124_12

					if var_124_12 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_7
					end
				end

				arg_121_1.text_.text = var_124_10
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021030", "story_v_side_old_924021.awb") ~= 0 then
					local var_124_13 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021030", "story_v_side_old_924021.awb") / 1000

					if var_124_13 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_7
					end

					if var_124_9.prefab_name ~= "" and arg_121_1.actors_[var_124_9.prefab_name] ~= nil then
						local var_124_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_9.prefab_name].transform, "story_v_side_old_924021", "924021030", "story_v_side_old_924021.awb")

						arg_121_1:RecordAudio("924021030", var_124_14)
						arg_121_1:RecordAudio("924021030", var_124_14)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021030", "story_v_side_old_924021.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021030", "story_v_side_old_924021.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_15 = math.max(var_124_8, arg_121_1.talkMaxDuration)

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_15 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_7) / var_124_15

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_7 + var_124_15 and arg_121_1.time_ < var_124_7 + var_124_15 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play924021031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 924021031
		arg_126_1.duration_ = 9

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play924021032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 2 < arg_126_1.time_ and arg_126_1.time_ <= 2 + arg_129_0 then
				local var_129_0 = arg_126_1.bgs_.ST12

				arg_126_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_129_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_1 = var_129_0:GetComponent("SpriteRenderer")

				if var_129_1 and var_129_1.sprite then
					local var_129_2 = 2 * (var_129_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_129_0.transform.localScale = Vector3.New(var_129_2 / var_129_1.sprite.bounds.size.y < var_129_2 * manager.ui.mainCameraCom_.aspect / var_129_1.sprite.bounds.size.x and var_129_2 * manager.ui.mainCameraCom_.aspect / var_129_1.sprite.bounds.size.x or var_129_2 / var_129_1.sprite.bounds.size.y, var_129_2 / var_129_1.sprite.bounds.size.y < var_129_2 * manager.ui.mainCameraCom_.aspect / var_129_1.sprite.bounds.size.x and var_129_2 * manager.ui.mainCameraCom_.aspect / var_129_1.sprite.bounds.size.x or var_129_2 / var_129_1.sprite.bounds.size.y, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "ST12" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_3 = 3.999999999999

			if 3.999999999999 < arg_126_1.time_ and arg_126_1.time_ <= var_129_3 + arg_129_0 then
				arg_126_1.allBtn_.enabled = false
			end

			if arg_126_1.time_ >= var_129_3 + 0.3 and arg_126_1.time_ < var_129_3 + 0.3 + arg_129_0 then
				arg_126_1.allBtn_.enabled = true
			end

			local var_129_4 = 0

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_5 = 2

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_5 then
				local var_129_6 = Color.New(0, 0, 0)

				var_129_6.a = Mathf.Lerp(0, 1, (arg_126_1.time_ - var_129_4) / var_129_5)
				arg_126_1.mask_.color = var_129_6
			end

			if arg_126_1.time_ >= var_129_4 + var_129_5 and arg_126_1.time_ < var_129_4 + var_129_5 + arg_129_0 then
				local var_129_7 = Color.New(0, 0, 0)

				var_129_7.a = 1
				arg_126_1.mask_.color = var_129_7
			end

			local var_129_8 = 2

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_9 = 2

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_9 then
				local var_129_10 = Color.New(0, 0, 0)

				var_129_10.a = Mathf.Lerp(1, 0, (arg_126_1.time_ - var_129_8) / var_129_9)
				arg_126_1.mask_.color = var_129_10
			end

			if arg_126_1.time_ >= var_129_8 + var_129_9 and arg_126_1.time_ < var_129_8 + var_129_9 + arg_129_0 then
				local var_129_11 = Color.New(0, 0, 0)

				arg_126_1.mask_.enabled = false
				var_129_11.a = 0
				arg_126_1.mask_.color = var_129_11
			end

			local var_129_12 = arg_126_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_126_1.time_ and arg_126_1.time_ <= 1.96599999815226 + arg_129_0 then
				arg_126_1.var_.moveOldPos102003ui_story = var_129_12.localPosition
			end

			local var_129_13 = 0.001

			if 1.96599999815226 <= arg_126_1.time_ and arg_126_1.time_ < 1.96599999815226 + var_129_13 then
				var_129_12.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 1.96599999815226) / var_129_13)
				var_129_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_12.position).x, (manager.ui.mainCamera.transform.position - var_129_12.position).y, (manager.ui.mainCamera.transform.position - var_129_12.position).z)
				var_129_12.localEulerAngles.z = 0
				var_129_12.localEulerAngles.x = 0
				var_129_12.localEulerAngles = var_129_12.localEulerAngles
			end

			if arg_126_1.time_ >= 1.96599999815226 + var_129_13 and arg_126_1.time_ < 1.96599999815226 + var_129_13 + arg_129_0 then
				var_129_12.localPosition = Vector3.New(0, 100, 0)
				var_129_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_12.position).x, (manager.ui.mainCamera.transform.position - var_129_12.position).y, (manager.ui.mainCamera.transform.position - var_129_12.position).z)
				var_129_12.localEulerAngles.z = 0
				var_129_12.localEulerAngles.x = 0
				var_129_12.localEulerAngles = var_129_12.localEulerAngles
			end

			local var_129_14 = arg_126_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_126_1.time_ and arg_126_1.time_ <= 1.96599999815226 + arg_129_0 and not isNil(var_129_14) and arg_126_1.var_.characterEffect102003ui_story == nil then
				arg_126_1.var_.characterEffect102003ui_story = var_129_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_15 = 0.034000001847744

			if 1.96599999815226 <= arg_126_1.time_ and arg_126_1.time_ < 1.96599999815226 + var_129_15 and not isNil(var_129_14) then
				if arg_126_1.var_.characterEffect102003ui_story and not isNil(var_129_14) then
					arg_126_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_126_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 1.96599999815226) / var_129_15)
				end
			end

			if arg_126_1.time_ >= 1.96599999815226 + var_129_15 and arg_126_1.time_ < 1.96599999815226 + var_129_15 + arg_129_0 and not isNil(var_129_14) and arg_126_1.var_.characterEffect102003ui_story then
				arg_126_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_126_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_129_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_18 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_18

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_18
						arg_126_1.bgmTxt2_.text = var_129_18
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_126_1.time_ and arg_126_1.time_ <= 0.4 + arg_129_0 then
				arg_126_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_129_21 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_126_1.bgmTxt_.text ~= var_129_21 and arg_126_1.bgmTxt_.text ~= "" then
						if arg_126_1.bgmTxt2_.text ~= "" then
							arg_126_1.bgmTxt_.text = arg_126_1.bgmTxt2_.text
						end

						arg_126_1.bgmTxt2_.text = var_129_21

						arg_126_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_126_1.bgmTxt_.text = var_129_21
						arg_126_1.bgmTxt2_.text = var_129_21
					end

					if arg_126_1.bgmTimer then
						arg_126_1.bgmTimer:Stop()

						arg_126_1.bgmTimer = nil
					end

					if arg_126_1.settingData.show_music_name == 1 then
						arg_126_1.musicController:SetSelectedState("show")
						arg_126_1.musicAnimator_:Play("open", 0, 0)

						if arg_126_1.settingData.music_time ~= 0 then
							arg_126_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_126_1.settingData.music_time), function()
								if arg_126_1 == nil or isNil(arg_126_1.bgmTxt_) then
									return
								end

								arg_126_1.musicController:SetSelectedState("hide")
								arg_126_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_22 = 4
			local var_129_23 = 0.875

			if 4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_22 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_24 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_24:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_126_1.dialogCg_.alpha = arg_132_0
				end))
				var_129_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_25 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(924021031).content)

				arg_126_1.text_.text = var_129_25

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_27 = 35 <= 0 and var_129_23 or var_129_23 * (utf8.len(var_129_25) / 35)

				if (35 <= 0 and var_129_23 or var_129_23 * (utf8.len(var_129_25) / 35)) > 0 and var_129_23 < var_129_27 then
					arg_126_1.talkMaxDuration = var_129_27
					var_129_22 = var_129_22 + 0.3

					if var_129_27 + var_129_22 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_27 + var_129_22
					end
				end

				arg_126_1.text_.text = var_129_25
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_28 = var_129_22 + 0.3
			local var_129_29 = math.max(var_129_23, arg_126_1.talkMaxDuration)

			if var_129_22 + 0.3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_28 + var_129_29 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_28) / var_129_29

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_28 + var_129_29 and arg_126_1.time_ < var_129_28 + var_129_29 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play924021032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 924021032
		arg_134_1.duration_ = 5.83

		local var_134_0 = {
			zh = 4,
			ja = 5.833
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play924021033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos102003ui_story = arg_134_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["102003ui_story"].transform.position).z)
				arg_134_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["102003ui_story"].transform.localEulerAngles = arg_134_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_134_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["102003ui_story"].transform.position).z)
				arg_134_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["102003ui_story"].transform.localEulerAngles = arg_134_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["102003ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect102003ui_story == nil then
				arg_134_1.var_.characterEffect102003ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect102003ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect102003ui_story then
				arg_134_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_137_4 = 0
			local var_137_5 = 0.375

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(924021032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 15 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 15)

				if (15 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 15)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021032", "story_v_side_old_924021.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021032", "story_v_side_old_924021.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_side_old_924021", "924021032", "story_v_side_old_924021.awb")

						arg_134_1:RecordAudio("924021032", var_137_11)
						arg_134_1:RecordAudio("924021032", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021032", "story_v_side_old_924021.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021032", "story_v_side_old_924021.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play924021033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 924021033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play924021034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["102003ui_story"]) and arg_138_1.var_.characterEffect102003ui_story == nil then
				arg_138_1.var_.characterEffect102003ui_story = arg_138_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["102003ui_story"]) then
				if arg_138_1.var_.characterEffect102003ui_story and not isNil(arg_138_1.actors_["102003ui_story"]) then
					arg_138_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_138_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["102003ui_story"]) and arg_138_1.var_.characterEffect102003ui_story then
				arg_138_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_138_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 0.3

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(924021033).content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 12 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 12)

				if (12 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 12)) > 0 and var_141_2 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_6 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_6 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_6

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_6 and arg_138_1.time_ < var_141_1 + var_141_6 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play924021034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 924021034
		arg_142_1.duration_ = 8.4

		local var_142_0 = {
			zh = 7.133,
			ja = 8.4
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
				arg_142_0:Play924021035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["102003ui_story"]) and arg_142_1.var_.characterEffect102003ui_story == nil then
				arg_142_1.var_.characterEffect102003ui_story = arg_142_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["102003ui_story"]) then
				if arg_142_1.var_.characterEffect102003ui_story and not isNil(arg_142_1.actors_["102003ui_story"]) then
					arg_142_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["102003ui_story"]) and arg_142_1.var_.characterEffect102003ui_story then
				arg_142_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			local var_145_2 = 0
			local var_145_3 = 0.575

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(924021034)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 23 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 23)

				if (23 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 23)) > 0 and var_145_3 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021034", "story_v_side_old_924021.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021034", "story_v_side_old_924021.awb") / 1000

					if var_145_8 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_2
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_side_old_924021", "924021034", "story_v_side_old_924021.awb")

						arg_142_1:RecordAudio("924021034", var_145_9)
						arg_142_1:RecordAudio("924021034", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021034", "story_v_side_old_924021.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021034", "story_v_side_old_924021.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_10 and arg_142_1.time_ < var_145_2 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play924021035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 924021035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play924021036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos102003ui_story = arg_146_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["102003ui_story"].transform.position).z)
				arg_146_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["102003ui_story"].transform.localEulerAngles = arg_146_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["102003ui_story"].transform.position).z)
				arg_146_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["102003ui_story"].transform.localEulerAngles = arg_146_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["102003ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect102003ui_story == nil then
				arg_146_1.var_.characterEffect102003ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect102003ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_146_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_2)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect102003ui_story then
				arg_146_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_146_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0.666666666666667 < arg_146_1.time_ and arg_146_1.time_ <= 0.666666666666667 + arg_149_0 then
				arg_146_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_149_4 = 0
			local var_149_5 = 0.95

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(924021035).content)

				arg_146_1.text_.text = var_149_6

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_8 = 38 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_6) / 38)

				if (38 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_6) / 38)) > 0 and var_149_5 < var_149_8 then
					arg_146_1.talkMaxDuration = var_149_8

					if var_149_8 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_8 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_6
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_9 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_9 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_9

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_9 and arg_146_1.time_ < var_149_4 + var_149_9 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play924021036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 924021036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play924021037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 1.175

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(924021036).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 47 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 47)

				if (47 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 47)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play924021037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 924021037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play924021038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.525

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(924021037).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 21 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 21)

				if (21 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 21)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play924021038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 924021038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play924021039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 1.15

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(924021038).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 46 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 46)

				if (46 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 46)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play924021039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 924021039
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play924021040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.85

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(924021039).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 34 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 34)

				if (34 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 34)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play924021040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 924021040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play924021041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 1.05

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_1 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(924021040).content)

				arg_166_1.text_.text = var_169_1

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_3 = 42 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 42)

				if (42 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_1) / 42)) > 0 and var_169_0 < var_169_3 then
					arg_166_1.talkMaxDuration = var_169_3

					if var_169_3 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_3 + 0
					end
				end

				arg_166_1.text_.text = var_169_1
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_4 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_4

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play924021041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 924021041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play924021042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.4

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(924021041).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 16 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 16)

				if (16 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 16)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play924021042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 924021042
		arg_174_1.duration_ = 4

		local var_174_0 = {
			zh = 3.133,
			ja = 4
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
				arg_174_0:Play924021043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos102003ui_story = arg_174_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_177_0 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				arg_174_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["102003ui_story"].transform.position).z)
				arg_174_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["102003ui_story"].transform.localEulerAngles = arg_174_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				arg_174_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_174_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["102003ui_story"].transform.position).z)
				arg_174_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["102003ui_story"].transform.localEulerAngles = arg_174_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_177_1 = arg_174_1.actors_["102003ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect102003ui_story == nil then
				arg_174_1.var_.characterEffect102003ui_story = var_177_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 and not isNil(var_177_1) then
				if arg_174_1.var_.characterEffect102003ui_story and not isNil(var_177_1) then
					arg_174_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect102003ui_story then
				arg_174_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action10_1")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_177_4 = 0
			local var_177_5 = 0.175

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_6 = arg_174_1:GetWordFromCfg(924021042)
				local var_177_7 = arg_174_1:FormatText(var_177_6.content)

				arg_174_1.text_.text = var_177_7

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 7 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 7)

				if (7 <= 0 and var_177_5 or var_177_5 * (utf8.len(var_177_7) / 7)) > 0 and var_177_5 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_4
					end
				end

				arg_174_1.text_.text = var_177_7
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021042", "story_v_side_old_924021.awb") ~= 0 then
					local var_177_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021042", "story_v_side_old_924021.awb") / 1000

					if var_177_10 + var_177_4 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_10 + var_177_4
					end

					if var_177_6.prefab_name ~= "" and arg_174_1.actors_[var_177_6.prefab_name] ~= nil then
						local var_177_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_6.prefab_name].transform, "story_v_side_old_924021", "924021042", "story_v_side_old_924021.awb")

						arg_174_1:RecordAudio("924021042", var_177_11)
						arg_174_1:RecordAudio("924021042", var_177_11)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021042", "story_v_side_old_924021.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021042", "story_v_side_old_924021.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_12 = math.max(var_177_5, arg_174_1.talkMaxDuration)

			if var_177_4 <= arg_174_1.time_ and arg_174_1.time_ < var_177_4 + var_177_12 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_4) / var_177_12

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_4 + var_177_12 and arg_174_1.time_ < var_177_4 + var_177_12 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play924021043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 924021043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play924021044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["102003ui_story"]) and arg_178_1.var_.characterEffect102003ui_story == nil then
				arg_178_1.var_.characterEffect102003ui_story = arg_178_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["102003ui_story"]) then
				if arg_178_1.var_.characterEffect102003ui_story and not isNil(arg_178_1.actors_["102003ui_story"]) then
					arg_178_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_178_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["102003ui_story"]) and arg_178_1.var_.characterEffect102003ui_story then
				arg_178_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_178_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_181_1 = 0
			local var_181_2 = 0.425

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(924021043).content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 17 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 17)

				if (17 <= 0 and var_181_2 or var_181_2 * (utf8.len(var_181_3) / 17)) > 0 and var_181_2 < var_181_5 then
					arg_178_1.talkMaxDuration = var_181_5

					if var_181_5 + var_181_1 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + var_181_1
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_6 = math.max(var_181_2, arg_178_1.talkMaxDuration)

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_6 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_1) / var_181_6

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_1 + var_181_6 and arg_178_1.time_ < var_181_1 + var_181_6 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play924021044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 924021044
		arg_182_1.duration_ = 2

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play924021045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos102003ui_story = arg_182_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["102003ui_story"].transform.position).z)
				arg_182_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["102003ui_story"].transform.localEulerAngles = arg_182_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_182_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["102003ui_story"].transform.position).z)
				arg_182_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["102003ui_story"].transform.localEulerAngles = arg_182_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["102003ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect102003ui_story == nil then
				arg_182_1.var_.characterEffect102003ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect102003ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect102003ui_story then
				arg_182_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action10_2")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_185_4 = 0
			local var_185_5 = 0.075

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(924021044)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 3 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 3)

				if (3 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 3)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021044", "story_v_side_old_924021.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021044", "story_v_side_old_924021.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_side_old_924021", "924021044", "story_v_side_old_924021.awb")

						arg_182_1:RecordAudio("924021044", var_185_11)
						arg_182_1:RecordAudio("924021044", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021044", "story_v_side_old_924021.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021044", "story_v_side_old_924021.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play924021045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 924021045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play924021046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["102003ui_story"]) and arg_186_1.var_.characterEffect102003ui_story == nil then
				arg_186_1.var_.characterEffect102003ui_story = arg_186_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["102003ui_story"]) then
				if arg_186_1.var_.characterEffect102003ui_story and not isNil(arg_186_1.actors_["102003ui_story"]) then
					arg_186_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_186_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_0)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["102003ui_story"]) and arg_186_1.var_.characterEffect102003ui_story then
				arg_186_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_186_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_189_1 = 0
			local var_189_2 = 0.975

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_3 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(924021045).content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 39 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 39)

				if (39 <= 0 and var_189_2 or var_189_2 * (utf8.len(var_189_3) / 39)) > 0 and var_189_2 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5

					if var_189_5 + var_189_1 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_1
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_6 = math.max(var_189_2, arg_186_1.talkMaxDuration)

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_6 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_1) / var_189_6

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_1 + var_189_6 and arg_186_1.time_ < var_189_1 + var_189_6 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play924021046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 924021046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play924021047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.65

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(924021046).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 26 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 26)

				if (26 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 26)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play924021047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 924021047
		arg_194_1.duration_ = 5.13

		local var_194_0 = {
			zh = 3.2,
			ja = 5.133
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
				arg_194_0:Play924021048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos102003ui_story = arg_194_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_197_0 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				arg_194_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["102003ui_story"].transform.position).z)
				arg_194_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["102003ui_story"].transform.localEulerAngles = arg_194_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				arg_194_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_194_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["102003ui_story"].transform.position).z)
				arg_194_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["102003ui_story"].transform.localEulerAngles = arg_194_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_197_1 = arg_194_1.actors_["102003ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect102003ui_story == nil then
				arg_194_1.var_.characterEffect102003ui_story = var_197_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_2 and not isNil(var_197_1) then
				if arg_194_1.var_.characterEffect102003ui_story and not isNil(var_197_1) then
					arg_194_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_2 and arg_194_1.time_ < 0 + var_197_2 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect102003ui_story then
				arg_194_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_197_4 = 0
			local var_197_5 = 0.275

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_6 = arg_194_1:GetWordFromCfg(924021047)
				local var_197_7 = arg_194_1:FormatText(var_197_6.content)

				arg_194_1.text_.text = var_197_7

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 11 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 11)

				if (11 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 11)) > 0 and var_197_5 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_7
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021047", "story_v_side_old_924021.awb") ~= 0 then
					local var_197_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021047", "story_v_side_old_924021.awb") / 1000

					if var_197_10 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_4
					end

					if var_197_6.prefab_name ~= "" and arg_194_1.actors_[var_197_6.prefab_name] ~= nil then
						local var_197_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_6.prefab_name].transform, "story_v_side_old_924021", "924021047", "story_v_side_old_924021.awb")

						arg_194_1:RecordAudio("924021047", var_197_11)
						arg_194_1:RecordAudio("924021047", var_197_11)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021047", "story_v_side_old_924021.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021047", "story_v_side_old_924021.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_12 = math.max(var_197_5, arg_194_1.talkMaxDuration)

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_12 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_4) / var_197_12

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_4 + var_197_12 and arg_194_1.time_ < var_197_4 + var_197_12 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play924021048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 924021048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play924021049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["102003ui_story"]) and arg_198_1.var_.characterEffect102003ui_story == nil then
				arg_198_1.var_.characterEffect102003ui_story = arg_198_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["102003ui_story"]) then
				if arg_198_1.var_.characterEffect102003ui_story and not isNil(arg_198_1.actors_["102003ui_story"]) then
					arg_198_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_198_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["102003ui_story"]) and arg_198_1.var_.characterEffect102003ui_story then
				arg_198_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_198_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.425

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(924021048).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 17 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 17)

				if (17 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 17)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play924021049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 924021049
		arg_202_1.duration_ = 5.3

		local var_202_0 = {
			zh = 4.433,
			ja = 5.3
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
				arg_202_0:Play924021050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["102003ui_story"]) and arg_202_1.var_.characterEffect102003ui_story == nil then
				arg_202_1.var_.characterEffect102003ui_story = arg_202_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["102003ui_story"]) then
				if arg_202_1.var_.characterEffect102003ui_story and not isNil(arg_202_1.actors_["102003ui_story"]) then
					arg_202_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["102003ui_story"]) and arg_202_1.var_.characterEffect102003ui_story then
				arg_202_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_205_2 = 0
			local var_205_3 = 0.25

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_2 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_4 = arg_202_1:GetWordFromCfg(924021049)
				local var_205_5 = arg_202_1:FormatText(var_205_4.content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 10 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 10)

				if (10 <= 0 and var_205_3 or var_205_3 * (utf8.len(var_205_5) / 10)) > 0 and var_205_3 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_2
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021049", "story_v_side_old_924021.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021049", "story_v_side_old_924021.awb") / 1000

					if var_205_8 + var_205_2 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_2
					end

					if var_205_4.prefab_name ~= "" and arg_202_1.actors_[var_205_4.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_4.prefab_name].transform, "story_v_side_old_924021", "924021049", "story_v_side_old_924021.awb")

						arg_202_1:RecordAudio("924021049", var_205_9)
						arg_202_1:RecordAudio("924021049", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021049", "story_v_side_old_924021.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021049", "story_v_side_old_924021.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_3, arg_202_1.talkMaxDuration)

			if var_205_2 <= arg_202_1.time_ and arg_202_1.time_ < var_205_2 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_2) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_2 + var_205_10 and arg_202_1.time_ < var_205_2 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play924021050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 924021050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play924021051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["102003ui_story"]) and arg_206_1.var_.characterEffect102003ui_story == nil then
				arg_206_1.var_.characterEffect102003ui_story = arg_206_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["102003ui_story"]) then
				if arg_206_1.var_.characterEffect102003ui_story and not isNil(arg_206_1.actors_["102003ui_story"]) then
					arg_206_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_206_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_0)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["102003ui_story"]) and arg_206_1.var_.characterEffect102003ui_story then
				arg_206_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_206_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_209_1 = 0
			local var_209_2 = 0.575

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_3 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(924021050).content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 23 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 23)

				if (23 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 23)) > 0 and var_209_2 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_6 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_6 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_6

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_6 and arg_206_1.time_ < var_209_1 + var_209_6 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play924021051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 924021051
		arg_210_1.duration_ = 6.27

		local var_210_0 = {
			zh = 3.8,
			ja = 6.266
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
				arg_210_0:Play924021052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos102003ui_story = arg_210_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["102003ui_story"].transform.position).z)
				arg_210_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["102003ui_story"].transform.localEulerAngles = arg_210_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_210_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["102003ui_story"].transform.position).z)
				arg_210_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["102003ui_story"].transform.localEulerAngles = arg_210_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["102003ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect102003ui_story == nil then
				arg_210_1.var_.characterEffect102003ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect102003ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect102003ui_story then
				arg_210_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action4410")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_213_4 = 0
			local var_213_5 = 0.3

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(924021051)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 12 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 12)

				if (12 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 12)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021051", "story_v_side_old_924021.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021051", "story_v_side_old_924021.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_side_old_924021", "924021051", "story_v_side_old_924021.awb")

						arg_210_1:RecordAudio("924021051", var_213_11)
						arg_210_1:RecordAudio("924021051", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021051", "story_v_side_old_924021.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021051", "story_v_side_old_924021.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play924021052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 924021052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play924021053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["102003ui_story"]) and arg_214_1.var_.characterEffect102003ui_story == nil then
				arg_214_1.var_.characterEffect102003ui_story = arg_214_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["102003ui_story"]) then
				if arg_214_1.var_.characterEffect102003ui_story and not isNil(arg_214_1.actors_["102003ui_story"]) then
					arg_214_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_214_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["102003ui_story"]) and arg_214_1.var_.characterEffect102003ui_story then
				arg_214_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_214_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.275

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(924021052).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 11 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 11)

				if (11 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 11)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play924021053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 924021053
		arg_218_1.duration_ = 6.9

		local var_218_0 = {
			zh = 6.9,
			ja = 6.133
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
				arg_218_0:Play924021054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos102003ui_story = arg_218_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["102003ui_story"].transform.position).z)
				arg_218_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["102003ui_story"].transform.localEulerAngles = arg_218_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_218_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["102003ui_story"].transform.position).z)
				arg_218_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["102003ui_story"].transform.localEulerAngles = arg_218_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["102003ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect102003ui_story == nil then
				arg_218_1.var_.characterEffect102003ui_story = var_221_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_2 and not isNil(var_221_1) then
				if arg_218_1.var_.characterEffect102003ui_story and not isNil(var_221_1) then
					arg_218_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_2 and arg_218_1.time_ < 0 + var_221_2 + arg_221_0 and not isNil(var_221_1) and arg_218_1.var_.characterEffect102003ui_story then
				arg_218_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action4103")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_221_4 = 0
			local var_221_5 = 0.4

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(924021053)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 16 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 16)

				if (16 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 16)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021053", "story_v_side_old_924021.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021053", "story_v_side_old_924021.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_side_old_924021", "924021053", "story_v_side_old_924021.awb")

						arg_218_1:RecordAudio("924021053", var_221_11)
						arg_218_1:RecordAudio("924021053", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021053", "story_v_side_old_924021.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021053", "story_v_side_old_924021.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play924021054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 924021054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play924021055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["102003ui_story"]) and arg_222_1.var_.characterEffect102003ui_story == nil then
				arg_222_1.var_.characterEffect102003ui_story = arg_222_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["102003ui_story"]) then
				if arg_222_1.var_.characterEffect102003ui_story and not isNil(arg_222_1.actors_["102003ui_story"]) then
					arg_222_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_222_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_0)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["102003ui_story"]) and arg_222_1.var_.characterEffect102003ui_story then
				arg_222_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_222_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_225_1 = 0
			local var_225_2 = 0.625

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(924021054).content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 25 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 25)

				if (25 <= 0 and var_225_2 or var_225_2 * (utf8.len(var_225_3) / 25)) > 0 and var_225_2 < var_225_5 then
					arg_222_1.talkMaxDuration = var_225_5

					if var_225_5 + var_225_1 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + var_225_1
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_6 = math.max(var_225_2, arg_222_1.talkMaxDuration)

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_6 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_1) / var_225_6

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_1 + var_225_6 and arg_222_1.time_ < var_225_1 + var_225_6 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play924021055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 924021055
		arg_226_1.duration_ = 4

		local var_226_0 = {
			zh = 3.233,
			ja = 4
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
				arg_226_0:Play924021056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos102003ui_story = arg_226_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["102003ui_story"].transform.position).z)
				arg_226_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["102003ui_story"].transform.localEulerAngles = arg_226_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_226_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["102003ui_story"].transform.position).z)
				arg_226_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["102003ui_story"].transform.localEulerAngles = arg_226_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["102003ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect102003ui_story == nil then
				arg_226_1.var_.characterEffect102003ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 and not isNil(var_229_1) then
				if arg_226_1.var_.characterEffect102003ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect102003ui_story then
				arg_226_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action432")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_229_4 = 0
			local var_229_5 = 0.275

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(924021055)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 11 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 11)

				if (11 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 11)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021055", "story_v_side_old_924021.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021055", "story_v_side_old_924021.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_side_old_924021", "924021055", "story_v_side_old_924021.awb")

						arg_226_1:RecordAudio("924021055", var_229_11)
						arg_226_1:RecordAudio("924021055", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021055", "story_v_side_old_924021.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021055", "story_v_side_old_924021.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_12 and arg_226_1.time_ < var_229_4 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play924021056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 924021056
		arg_230_1.duration_ = 4.1

		local var_230_0 = {
			zh = 3.4,
			ja = 4.1
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
				arg_230_0:Play924021057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action2_2")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_233_0 = 0
			local var_233_1 = 0.25

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_2 = arg_230_1:GetWordFromCfg(924021056)
				local var_233_3 = arg_230_1:FormatText(var_233_2.content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 10 <= 0 and var_233_1 or var_233_1 * (utf8.len(var_233_3) / 10)

				if (10 <= 0 and var_233_1 or var_233_1 * (utf8.len(var_233_3) / 10)) > 0 and var_233_1 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_0
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021056", "story_v_side_old_924021.awb") ~= 0 then
					local var_233_6 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021056", "story_v_side_old_924021.awb") / 1000

					if var_233_6 + var_233_0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_0
					end

					if var_233_2.prefab_name ~= "" and arg_230_1.actors_[var_233_2.prefab_name] ~= nil then
						local var_233_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_2.prefab_name].transform, "story_v_side_old_924021", "924021056", "story_v_side_old_924021.awb")

						arg_230_1:RecordAudio("924021056", var_233_7)
						arg_230_1:RecordAudio("924021056", var_233_7)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021056", "story_v_side_old_924021.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021056", "story_v_side_old_924021.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_8 = math.max(var_233_1, arg_230_1.talkMaxDuration)

			if var_233_0 <= arg_230_1.time_ and arg_230_1.time_ < var_233_0 + var_233_8 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_0) / var_233_8

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_0 + var_233_8 and arg_230_1.time_ < var_233_0 + var_233_8 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play924021057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 924021057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play924021058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos102003ui_story = arg_234_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["102003ui_story"].transform.position).z)
				arg_234_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["102003ui_story"].transform.localEulerAngles = arg_234_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_234_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["102003ui_story"].transform.position).z)
				arg_234_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["102003ui_story"].transform.localEulerAngles = arg_234_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["102003ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect102003ui_story == nil then
				arg_234_1.var_.characterEffect102003ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect102003ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_234_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_2)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect102003ui_story then
				arg_234_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_234_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_237_3 = 0
			local var_237_4 = 0.725

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_3 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_5 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(924021057).content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 29 <= 0 and var_237_4 or var_237_4 * (utf8.len(var_237_5) / 29)

				if (29 <= 0 and var_237_4 or var_237_4 * (utf8.len(var_237_5) / 29)) > 0 and var_237_4 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_3 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_3
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_8 = math.max(var_237_4, arg_234_1.talkMaxDuration)

			if var_237_3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_3 + var_237_8 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_3) / var_237_8

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_3 + var_237_8 and arg_234_1.time_ < var_237_3 + var_237_8 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play924021058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 924021058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play924021059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.25

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_1 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(924021058).content)

				arg_238_1.text_.text = var_241_1

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_3 = 10 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 10)

				if (10 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_1) / 10)) > 0 and var_241_0 < var_241_3 then
					arg_238_1.talkMaxDuration = var_241_3

					if var_241_3 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_3 + 0
					end
				end

				arg_238_1.text_.text = var_241_1
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_4 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_4

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play924021059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 924021059
		arg_242_1.duration_ = 2

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play924021060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos102003ui_story = arg_242_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["102003ui_story"].transform.position).z)
				arg_242_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["102003ui_story"].transform.localEulerAngles = arg_242_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_242_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["102003ui_story"].transform.position).z)
				arg_242_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["102003ui_story"].transform.localEulerAngles = arg_242_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["102003ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect102003ui_story == nil then
				arg_242_1.var_.characterEffect102003ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect102003ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect102003ui_story then
				arg_242_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_245_4 = 0
			local var_245_5 = 0.075

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(924021059)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 3 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 3)

				if (3 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 3)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021059", "story_v_side_old_924021.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021059", "story_v_side_old_924021.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_side_old_924021", "924021059", "story_v_side_old_924021.awb")

						arg_242_1:RecordAudio("924021059", var_245_11)
						arg_242_1:RecordAudio("924021059", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021059", "story_v_side_old_924021.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021059", "story_v_side_old_924021.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play924021060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 924021060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play924021061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["102003ui_story"]) and arg_246_1.var_.characterEffect102003ui_story == nil then
				arg_246_1.var_.characterEffect102003ui_story = arg_246_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["102003ui_story"]) then
				if arg_246_1.var_.characterEffect102003ui_story and not isNil(arg_246_1.actors_["102003ui_story"]) then
					arg_246_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_246_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["102003ui_story"]) and arg_246_1.var_.characterEffect102003ui_story then
				arg_246_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_246_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0
			local var_249_2 = 0.725

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(924021060).content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 29 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 29)

				if (29 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 29)) > 0 and var_249_2 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_6 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_6 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_6

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_6 and arg_246_1.time_ < var_249_1 + var_249_6 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play924021061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 924021061
		arg_250_1.duration_ = 9.67

		local var_250_0 = {
			zh = 8.999999999999,
			ja = 9.665999999999
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
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play924021062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if arg_250_1.bgs_.X204_f == nil then
				local var_253_0 = Object.Instantiate(arg_250_1.paintGo_)

				var_253_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X204_f")
				var_253_0.name = "X204_f"
				var_253_0.transform.parent = arg_250_1.stage_.transform
				var_253_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.bgs_.X204_f = var_253_0
			end

			if 2.00000000298023 < arg_250_1.time_ and arg_250_1.time_ <= 2.00000000298023 + arg_253_0 then
				local var_253_1 = arg_250_1.bgs_.X204_f

				arg_250_1.bgs_.X204_f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_253_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_2 = var_253_1:GetComponent("SpriteRenderer")

				if var_253_2 and var_253_2.sprite then
					local var_253_3 = 2 * (var_253_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_253_1.transform.localScale = Vector3.New(var_253_3 / var_253_2.sprite.bounds.size.y < var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x and var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x or var_253_3 / var_253_2.sprite.bounds.size.y, var_253_3 / var_253_2.sprite.bounds.size.y < var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x and var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x or var_253_3 / var_253_2.sprite.bounds.size.y, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "X204_f" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_4 = 3.999999999999

			if 3.999999999999 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.allBtn_.enabled = false
			end

			if arg_250_1.time_ >= var_253_4 + 0.3 and arg_250_1.time_ < var_253_4 + 0.3 + arg_253_0 then
				arg_250_1.allBtn_.enabled = true
			end

			local var_253_5 = 0

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_6 = 2

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_6 then
				local var_253_7 = Color.New(0, 0, 0)

				var_253_7.a = Mathf.Lerp(0, 1, (arg_250_1.time_ - var_253_5) / var_253_6)
				arg_250_1.mask_.color = var_253_7
			end

			if arg_250_1.time_ >= var_253_5 + var_253_6 and arg_250_1.time_ < var_253_5 + var_253_6 + arg_253_0 then
				local var_253_8 = Color.New(0, 0, 0)

				var_253_8.a = 1
				arg_250_1.mask_.color = var_253_8
			end

			local var_253_9 = 2

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_10 = 2

			if var_253_9 <= arg_250_1.time_ and arg_250_1.time_ < var_253_9 + var_253_10 then
				local var_253_11 = Color.New(0, 0, 0)

				var_253_11.a = Mathf.Lerp(1, 0, (arg_250_1.time_ - var_253_9) / var_253_10)
				arg_250_1.mask_.color = var_253_11
			end

			if arg_250_1.time_ >= var_253_9 + var_253_10 and arg_250_1.time_ < var_253_9 + var_253_10 + arg_253_0 then
				local var_253_12 = Color.New(0, 0, 0)

				arg_250_1.mask_.enabled = false
				var_253_12.a = 0
				arg_250_1.mask_.color = var_253_12
			end

			local var_253_13 = arg_250_1.actors_["102003ui_story"].transform

			if 3.8 < arg_250_1.time_ and arg_250_1.time_ <= 3.8 + arg_253_0 then
				arg_250_1.var_.moveOldPos102003ui_story = var_253_13.localPosition
			end

			local var_253_14 = 0.001

			if 3.8 <= arg_250_1.time_ and arg_250_1.time_ < 3.8 + var_253_14 then
				var_253_13.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_250_1.time_ - 3.8) / var_253_14)
				var_253_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_13.position).x, (manager.ui.mainCamera.transform.position - var_253_13.position).y, (manager.ui.mainCamera.transform.position - var_253_13.position).z)
				var_253_13.localEulerAngles.z = 0
				var_253_13.localEulerAngles.x = 0
				var_253_13.localEulerAngles = var_253_13.localEulerAngles
			end

			if arg_250_1.time_ >= 3.8 + var_253_14 and arg_250_1.time_ < 3.8 + var_253_14 + arg_253_0 then
				var_253_13.localPosition = Vector3.New(0, -0.85, -6.21)
				var_253_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_13.position).x, (manager.ui.mainCamera.transform.position - var_253_13.position).y, (manager.ui.mainCamera.transform.position - var_253_13.position).z)
				var_253_13.localEulerAngles.z = 0
				var_253_13.localEulerAngles.x = 0
				var_253_13.localEulerAngles = var_253_13.localEulerAngles
			end

			local var_253_15 = arg_250_1.actors_["102003ui_story"]

			if 3.8 < arg_250_1.time_ and arg_250_1.time_ <= 3.8 + arg_253_0 and not isNil(var_253_15) and arg_250_1.var_.characterEffect102003ui_story == nil then
				arg_250_1.var_.characterEffect102003ui_story = var_253_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_16 = 0.200000002980232

			if 3.8 <= arg_250_1.time_ and arg_250_1.time_ < 3.8 + var_253_16 and not isNil(var_253_15) then
				if arg_250_1.var_.characterEffect102003ui_story and not isNil(var_253_15) then
					arg_250_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 3.8 + var_253_16 and arg_250_1.time_ < 3.8 + var_253_16 + arg_253_0 and not isNil(var_253_15) and arg_250_1.var_.characterEffect102003ui_story then
				arg_250_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 3.8 < arg_250_1.time_ and arg_250_1.time_ <= 3.8 + arg_253_0 then
				arg_250_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 3.8 < arg_250_1.time_ and arg_250_1.time_ <= 3.8 + arg_253_0 then
				arg_250_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_253_18 = arg_250_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_250_1.time_ and arg_250_1.time_ <= 1.96599999815226 + arg_253_0 then
				arg_250_1.var_.moveOldPos102003ui_story = var_253_18.localPosition
			end

			local var_253_19 = 0.001

			if 1.96599999815226 <= arg_250_1.time_ and arg_250_1.time_ < 1.96599999815226 + var_253_19 then
				var_253_18.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 1.96599999815226) / var_253_19)
				var_253_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_18.position).x, (manager.ui.mainCamera.transform.position - var_253_18.position).y, (manager.ui.mainCamera.transform.position - var_253_18.position).z)
				var_253_18.localEulerAngles.z = 0
				var_253_18.localEulerAngles.x = 0
				var_253_18.localEulerAngles = var_253_18.localEulerAngles
			end

			if arg_250_1.time_ >= 1.96599999815226 + var_253_19 and arg_250_1.time_ < 1.96599999815226 + var_253_19 + arg_253_0 then
				var_253_18.localPosition = Vector3.New(0, 100, 0)
				var_253_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_18.position).x, (manager.ui.mainCamera.transform.position - var_253_18.position).y, (manager.ui.mainCamera.transform.position - var_253_18.position).z)
				var_253_18.localEulerAngles.z = 0
				var_253_18.localEulerAngles.x = 0
				var_253_18.localEulerAngles = var_253_18.localEulerAngles
			end

			if 0.125 < arg_250_1.time_ and arg_250_1.time_ <= 0.125 + arg_253_0 then
				arg_250_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 1.66666666666667 < arg_250_1.time_ and arg_250_1.time_ <= 1.66666666666667 + arg_253_0 then
				arg_250_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_22 = 3.999999999999
			local var_253_23 = 0.4

			if 3.999999999999 < arg_250_1.time_ and arg_250_1.time_ <= var_253_22 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_24 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_24:setOnUpdate(LuaHelper.FloatAction(function(arg_254_0)
					arg_250_1.dialogCg_.alpha = arg_254_0
				end))
				var_253_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_25 = arg_250_1:GetWordFromCfg(924021061)
				local var_253_26 = arg_250_1:FormatText(var_253_25.content)

				arg_250_1.text_.text = var_253_26

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_28 = 16 <= 0 and var_253_23 or var_253_23 * (utf8.len(var_253_26) / 16)

				if (16 <= 0 and var_253_23 or var_253_23 * (utf8.len(var_253_26) / 16)) > 0 and var_253_23 < var_253_28 then
					arg_250_1.talkMaxDuration = var_253_28
					var_253_22 = var_253_22 + 0.3

					if var_253_28 + var_253_22 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_28 + var_253_22
					end
				end

				arg_250_1.text_.text = var_253_26
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021061", "story_v_side_old_924021.awb") ~= 0 then
					local var_253_29 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021061", "story_v_side_old_924021.awb") / 1000

					if var_253_29 + var_253_22 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_29 + var_253_22
					end

					if var_253_25.prefab_name ~= "" and arg_250_1.actors_[var_253_25.prefab_name] ~= nil then
						local var_253_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_25.prefab_name].transform, "story_v_side_old_924021", "924021061", "story_v_side_old_924021.awb")

						arg_250_1:RecordAudio("924021061", var_253_30)
						arg_250_1:RecordAudio("924021061", var_253_30)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021061", "story_v_side_old_924021.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021061", "story_v_side_old_924021.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_31 = var_253_22 + 0.3
			local var_253_32 = math.max(var_253_23, arg_250_1.talkMaxDuration)

			if var_253_22 + 0.3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_31 + var_253_32 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_31) / var_253_32

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_31 + var_253_32 and arg_250_1.time_ < var_253_31 + var_253_32 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play924021062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 924021062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play924021063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["102003ui_story"]) and arg_256_1.var_.characterEffect102003ui_story == nil then
				arg_256_1.var_.characterEffect102003ui_story = arg_256_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["102003ui_story"]) then
				if arg_256_1.var_.characterEffect102003ui_story and not isNil(arg_256_1.actors_["102003ui_story"]) then
					arg_256_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_256_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_0)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["102003ui_story"]) and arg_256_1.var_.characterEffect102003ui_story then
				arg_256_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_256_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_259_1 = 0
			local var_259_2 = 0.775

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_3 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(924021062).content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 31 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 31)

				if (31 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 31)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_6 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_6 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_6

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_6 and arg_256_1.time_ < var_259_1 + var_259_6 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play924021063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 924021063
		arg_260_1.duration_ = 7.93

		local var_260_0 = {
			zh = 4.8,
			ja = 7.933
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play924021064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos102003ui_story = arg_260_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_263_0 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				arg_260_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_260_1.time_ - 0) / var_263_0)
				arg_260_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["102003ui_story"].transform.position).z)
				arg_260_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["102003ui_story"].transform.localEulerAngles = arg_260_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				arg_260_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_260_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["102003ui_story"].transform.position).z)
				arg_260_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["102003ui_story"].transform.localEulerAngles = arg_260_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_263_1 = arg_260_1.actors_["102003ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect102003ui_story == nil then
				arg_260_1.var_.characterEffect102003ui_story = var_263_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_2 and not isNil(var_263_1) then
				if arg_260_1.var_.characterEffect102003ui_story and not isNil(var_263_1) then
					arg_260_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_2 and arg_260_1.time_ < 0 + var_263_2 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect102003ui_story then
				arg_260_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action436")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_263_4 = 0
			local var_263_5 = 0.325

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_6 = arg_260_1:GetWordFromCfg(924021063)
				local var_263_7 = arg_260_1:FormatText(var_263_6.content)

				arg_260_1.text_.text = var_263_7

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_9 = 13 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_7) / 13)

				if (13 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_7) / 13)) > 0 and var_263_5 < var_263_9 then
					arg_260_1.talkMaxDuration = var_263_9

					if var_263_9 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_9 + var_263_4
					end
				end

				arg_260_1.text_.text = var_263_7
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021063", "story_v_side_old_924021.awb") ~= 0 then
					local var_263_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021063", "story_v_side_old_924021.awb") / 1000

					if var_263_10 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_4
					end

					if var_263_6.prefab_name ~= "" and arg_260_1.actors_[var_263_6.prefab_name] ~= nil then
						local var_263_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_6.prefab_name].transform, "story_v_side_old_924021", "924021063", "story_v_side_old_924021.awb")

						arg_260_1:RecordAudio("924021063", var_263_11)
						arg_260_1:RecordAudio("924021063", var_263_11)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021063", "story_v_side_old_924021.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021063", "story_v_side_old_924021.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_12 = math.max(var_263_5, arg_260_1.talkMaxDuration)

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_12 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_4) / var_263_12

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_4 + var_263_12 and arg_260_1.time_ < var_263_4 + var_263_12 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play924021064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 924021064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play924021065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos102003ui_story = arg_264_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_267_0 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 then
				arg_264_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_264_1.time_ - 0) / var_267_0)
				arg_264_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["102003ui_story"].transform.position).z)
				arg_264_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["102003ui_story"].transform.localEulerAngles = arg_264_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_264_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["102003ui_story"].transform.position).z)
				arg_264_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["102003ui_story"].transform.localEulerAngles = arg_264_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_267_1 = arg_264_1.actors_["102003ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect102003ui_story == nil then
				arg_264_1.var_.characterEffect102003ui_story = var_267_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_2 and not isNil(var_267_1) then
				if arg_264_1.var_.characterEffect102003ui_story and not isNil(var_267_1) then
					arg_264_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_264_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_2)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_2 and arg_264_1.time_ < 0 + var_267_2 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect102003ui_story then
				arg_264_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_264_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_267_3 = 0
			local var_267_4 = 0.7

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_3 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_5 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(924021064).content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 28 <= 0 and var_267_4 or var_267_4 * (utf8.len(var_267_5) / 28)

				if (28 <= 0 and var_267_4 or var_267_4 * (utf8.len(var_267_5) / 28)) > 0 and var_267_4 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_3 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_3
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_8 = math.max(var_267_4, arg_264_1.talkMaxDuration)

			if var_267_3 <= arg_264_1.time_ and arg_264_1.time_ < var_267_3 + var_267_8 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_3) / var_267_8

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_3 + var_267_8 and arg_264_1.time_ < var_267_3 + var_267_8 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play924021065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 924021065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play924021066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.625

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(924021065).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 25 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 25)

				if (25 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 25)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play924021066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 924021066
		arg_272_1.duration_ = 4.7

		local var_272_0 = {
			zh = 3.666,
			ja = 4.7
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play924021067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos102003ui_story = arg_272_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["102003ui_story"].transform.position).z)
				arg_272_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["102003ui_story"].transform.localEulerAngles = arg_272_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_272_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["102003ui_story"].transform.position).z)
				arg_272_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["102003ui_story"].transform.localEulerAngles = arg_272_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_275_1 = arg_272_1.actors_["102003ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect102003ui_story == nil then
				arg_272_1.var_.characterEffect102003ui_story = var_275_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_2 and not isNil(var_275_1) then
				if arg_272_1.var_.characterEffect102003ui_story and not isNil(var_275_1) then
					arg_272_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_2 and arg_272_1.time_ < 0 + var_275_2 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect102003ui_story then
				arg_272_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_275_4 = 0
			local var_275_5 = 0.425

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_6 = arg_272_1:GetWordFromCfg(924021066)
				local var_275_7 = arg_272_1:FormatText(var_275_6.content)

				arg_272_1.text_.text = var_275_7

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_9 = 17 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 17)

				if (17 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 17)) > 0 and var_275_5 < var_275_9 then
					arg_272_1.talkMaxDuration = var_275_9

					if var_275_9 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_7
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021066", "story_v_side_old_924021.awb") ~= 0 then
					local var_275_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021066", "story_v_side_old_924021.awb") / 1000

					if var_275_10 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_4
					end

					if var_275_6.prefab_name ~= "" and arg_272_1.actors_[var_275_6.prefab_name] ~= nil then
						local var_275_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_6.prefab_name].transform, "story_v_side_old_924021", "924021066", "story_v_side_old_924021.awb")

						arg_272_1:RecordAudio("924021066", var_275_11)
						arg_272_1:RecordAudio("924021066", var_275_11)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021066", "story_v_side_old_924021.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021066", "story_v_side_old_924021.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_12 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_12 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_12

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_12 and arg_272_1.time_ < var_275_4 + var_275_12 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play924021067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 924021067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play924021068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["102003ui_story"]) and arg_276_1.var_.characterEffect102003ui_story == nil then
				arg_276_1.var_.characterEffect102003ui_story = arg_276_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["102003ui_story"]) then
				if arg_276_1.var_.characterEffect102003ui_story and not isNil(arg_276_1.actors_["102003ui_story"]) then
					arg_276_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_276_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_0)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["102003ui_story"]) and arg_276_1.var_.characterEffect102003ui_story then
				arg_276_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_276_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_279_1 = 0
			local var_279_2 = 0.725

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(924021067).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 29 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 29)

				if (29 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 29)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play924021068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 924021068
		arg_280_1.duration_ = 2.53

		local var_280_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play924021069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos102003ui_story = arg_280_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_283_0 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 then
				arg_280_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_280_1.time_ - 0) / var_283_0)
				arg_280_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).z)
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles = arg_280_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 then
				arg_280_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_280_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["102003ui_story"].transform.position).z)
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["102003ui_story"].transform.localEulerAngles = arg_280_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_283_1 = arg_280_1.actors_["102003ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect102003ui_story == nil then
				arg_280_1.var_.characterEffect102003ui_story = var_283_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_2 and not isNil(var_283_1) then
				if arg_280_1.var_.characterEffect102003ui_story and not isNil(var_283_1) then
					arg_280_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_2 and arg_280_1.time_ < 0 + var_283_2 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect102003ui_story then
				arg_280_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_283_4 = 0
			local var_283_5 = 0.125

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_6 = arg_280_1:GetWordFromCfg(924021068)
				local var_283_7 = arg_280_1:FormatText(var_283_6.content)

				arg_280_1.text_.text = var_283_7

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 5 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 5)

				if (5 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 5)) > 0 and var_283_5 < var_283_9 then
					arg_280_1.talkMaxDuration = var_283_9

					if var_283_9 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_9 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_7
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021068", "story_v_side_old_924021.awb") ~= 0 then
					local var_283_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021068", "story_v_side_old_924021.awb") / 1000

					if var_283_10 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_10 + var_283_4
					end

					if var_283_6.prefab_name ~= "" and arg_280_1.actors_[var_283_6.prefab_name] ~= nil then
						local var_283_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_6.prefab_name].transform, "story_v_side_old_924021", "924021068", "story_v_side_old_924021.awb")

						arg_280_1:RecordAudio("924021068", var_283_11)
						arg_280_1:RecordAudio("924021068", var_283_11)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021068", "story_v_side_old_924021.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021068", "story_v_side_old_924021.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_12 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_12

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_12 and arg_280_1.time_ < var_283_4 + var_283_12 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play924021069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 924021069
		arg_284_1.duration_ = 9

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play924021070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if arg_284_1.bgs_.STblack == nil then
				local var_287_0 = Object.Instantiate(arg_284_1.paintGo_)

				var_287_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_287_0.name = "STblack"
				var_287_0.transform.parent = arg_284_1.stage_.transform
				var_287_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_284_1.bgs_.STblack = var_287_0
			end

			if 2 < arg_284_1.time_ and arg_284_1.time_ <= 2 + arg_287_0 then
				local var_287_1 = arg_284_1.bgs_.STblack

				arg_284_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_287_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_287_2 = var_287_1:GetComponent("SpriteRenderer")

				if var_287_2 and var_287_2.sprite then
					local var_287_3 = 2 * (var_287_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_287_1.transform.localScale = Vector3.New(var_287_3 / var_287_2.sprite.bounds.size.y < var_287_3 * manager.ui.mainCameraCom_.aspect / var_287_2.sprite.bounds.size.x and var_287_3 * manager.ui.mainCameraCom_.aspect / var_287_2.sprite.bounds.size.x or var_287_3 / var_287_2.sprite.bounds.size.y, var_287_3 / var_287_2.sprite.bounds.size.y < var_287_3 * manager.ui.mainCameraCom_.aspect / var_287_2.sprite.bounds.size.x and var_287_3 * manager.ui.mainCameraCom_.aspect / var_287_2.sprite.bounds.size.x or var_287_3 / var_287_2.sprite.bounds.size.y, 0)
				end

				for iter_287_0, iter_287_1 in pairs(arg_284_1.bgs_) do
					if iter_287_0 ~= "STblack" then
						iter_287_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_287_4 = 4

			if 4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			if arg_284_1.time_ >= var_287_4 + 0.3 and arg_284_1.time_ < var_287_4 + 0.3 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			local var_287_5 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_6 = 2

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_6 then
				local var_287_7 = Color.New(0, 0, 0)

				var_287_7.a = Mathf.Lerp(0, 1, (arg_284_1.time_ - var_287_5) / var_287_6)
				arg_284_1.mask_.color = var_287_7
			end

			if arg_284_1.time_ >= var_287_5 + var_287_6 and arg_284_1.time_ < var_287_5 + var_287_6 + arg_287_0 then
				local var_287_8 = Color.New(0, 0, 0)

				var_287_8.a = 1
				arg_284_1.mask_.color = var_287_8
			end

			local var_287_9 = 2

			if 2 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_10 = 2

			if var_287_9 <= arg_284_1.time_ and arg_284_1.time_ < var_287_9 + var_287_10 then
				local var_287_11 = Color.New(0, 0, 0)

				var_287_11.a = Mathf.Lerp(1, 0, (arg_284_1.time_ - var_287_9) / var_287_10)
				arg_284_1.mask_.color = var_287_11
			end

			if arg_284_1.time_ >= var_287_9 + var_287_10 and arg_284_1.time_ < var_287_9 + var_287_10 + arg_287_0 then
				local var_287_12 = Color.New(0, 0, 0)

				arg_284_1.mask_.enabled = false
				var_287_12.a = 0
				arg_284_1.mask_.color = var_287_12
			end

			local var_287_13 = arg_284_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_284_1.time_ and arg_284_1.time_ <= 1.96599999815226 + arg_287_0 then
				arg_284_1.var_.moveOldPos102003ui_story = var_287_13.localPosition
			end

			local var_287_14 = 0.001

			if 1.96599999815226 <= arg_284_1.time_ and arg_284_1.time_ < 1.96599999815226 + var_287_14 then
				var_287_13.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_284_1.time_ - 1.96599999815226) / var_287_14)
				var_287_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_13.position).x, (manager.ui.mainCamera.transform.position - var_287_13.position).y, (manager.ui.mainCamera.transform.position - var_287_13.position).z)
				var_287_13.localEulerAngles.z = 0
				var_287_13.localEulerAngles.x = 0
				var_287_13.localEulerAngles = var_287_13.localEulerAngles
			end

			if arg_284_1.time_ >= 1.96599999815226 + var_287_14 and arg_284_1.time_ < 1.96599999815226 + var_287_14 + arg_287_0 then
				var_287_13.localPosition = Vector3.New(0, 100, 0)
				var_287_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_13.position).x, (manager.ui.mainCamera.transform.position - var_287_13.position).y, (manager.ui.mainCamera.transform.position - var_287_13.position).z)
				var_287_13.localEulerAngles.z = 0
				var_287_13.localEulerAngles.x = 0
				var_287_13.localEulerAngles = var_287_13.localEulerAngles
			end

			local var_287_15 = arg_284_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_284_1.time_ and arg_284_1.time_ <= 1.96599999815226 + arg_287_0 and not isNil(var_287_15) and arg_284_1.var_.characterEffect102003ui_story == nil then
				arg_284_1.var_.characterEffect102003ui_story = var_287_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_16 = 0.034000001847744

			if 1.96599999815226 <= arg_284_1.time_ and arg_284_1.time_ < 1.96599999815226 + var_287_16 and not isNil(var_287_15) then
				if arg_284_1.var_.characterEffect102003ui_story and not isNil(var_287_15) then
					arg_284_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_284_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 1.96599999815226) / var_287_16)
				end
			end

			if arg_284_1.time_ >= 1.96599999815226 + var_287_16 and arg_284_1.time_ < 1.96599999815226 + var_287_16 + arg_287_0 and not isNil(var_287_15) and arg_284_1.var_.characterEffect102003ui_story then
				arg_284_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_284_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_17 = 4
			local var_287_18 = 1.4

			if 4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_17 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_19 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_19:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_20 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(924021069).content)

				arg_284_1.text_.text = var_287_20

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_22 = 56 <= 0 and var_287_18 or var_287_18 * (utf8.len(var_287_20) / 56)

				if (56 <= 0 and var_287_18 or var_287_18 * (utf8.len(var_287_20) / 56)) > 0 and var_287_18 < var_287_22 then
					arg_284_1.talkMaxDuration = var_287_22
					var_287_17 = var_287_17 + 0.3

					if var_287_22 + var_287_17 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_22 + var_287_17
					end
				end

				arg_284_1.text_.text = var_287_20
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_23 = var_287_17 + 0.3
			local var_287_24 = math.max(var_287_18, arg_284_1.talkMaxDuration)

			if var_287_17 + 0.3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_23 + var_287_24 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_23) / var_287_24

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_23 + var_287_24 and arg_284_1.time_ < var_287_23 + var_287_24 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play924021070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 924021070
		arg_290_1.duration_ = 7

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play924021071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if arg_290_1.bgs_.X204_g == nil then
				local var_293_0 = Object.Instantiate(arg_290_1.paintGo_)

				var_293_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X204_g")
				var_293_0.name = "X204_g"
				var_293_0.transform.parent = arg_290_1.stage_.transform
				var_293_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_290_1.bgs_.X204_g = var_293_0
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				local var_293_1 = arg_290_1.bgs_.X204_g

				arg_290_1.bgs_.X204_g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_293_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_2 = var_293_1:GetComponent("SpriteRenderer")

				if var_293_2 and var_293_2.sprite then
					local var_293_3 = 2 * (var_293_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_293_1.transform.localScale = Vector3.New(var_293_3 / var_293_2.sprite.bounds.size.y < var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x and var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x or var_293_3 / var_293_2.sprite.bounds.size.y, var_293_3 / var_293_2.sprite.bounds.size.y < var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x and var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x or var_293_3 / var_293_2.sprite.bounds.size.y, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "X204_g" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_4 = 2

			if 2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			if arg_290_1.time_ >= var_293_4 + 0.3 and arg_290_1.time_ < var_293_4 + 0.3 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_5 = 0

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_6 = 2

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_6 then
				local var_293_7 = Color.New(0, 0, 0)

				var_293_7.a = Mathf.Lerp(1, 0, (arg_290_1.time_ - var_293_5) / var_293_6)
				arg_290_1.mask_.color = var_293_7
			end

			if arg_290_1.time_ >= var_293_5 + var_293_6 and arg_290_1.time_ < var_293_5 + var_293_6 + arg_293_0 then
				local var_293_8 = Color.New(0, 0, 0)

				arg_290_1.mask_.enabled = false
				var_293_8.a = 0
				arg_290_1.mask_.color = var_293_8
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_9 = 2
			local var_293_10 = 0.225

			if 2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_11 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_11:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_12 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(924021070).content)

				arg_290_1.text_.text = var_293_12

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_14 = 9 <= 0 and var_293_10 or var_293_10 * (utf8.len(var_293_12) / 9)

				if (9 <= 0 and var_293_10 or var_293_10 * (utf8.len(var_293_12) / 9)) > 0 and var_293_10 < var_293_14 then
					arg_290_1.talkMaxDuration = var_293_14
					var_293_9 = var_293_9 + 0.3

					if var_293_14 + var_293_9 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_14 + var_293_9
					end
				end

				arg_290_1.text_.text = var_293_12
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_15 = var_293_9 + 0.3
			local var_293_16 = math.max(var_293_10, arg_290_1.talkMaxDuration)

			if var_293_9 + 0.3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_15 + var_293_16 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_15) / var_293_16

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_15 + var_293_16 and arg_290_1.time_ < var_293_15 + var_293_16 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play924021071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 924021071
		arg_296_1.duration_ = 6.07

		local var_296_0 = {
			zh = 2.666,
			ja = 6.066
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play924021072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos102003ui_story = arg_296_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["102003ui_story"].transform.position).z)
				arg_296_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["102003ui_story"].transform.localEulerAngles = arg_296_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_296_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["102003ui_story"].transform.position).z)
				arg_296_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["102003ui_story"].transform.localEulerAngles = arg_296_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["102003ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect102003ui_story == nil then
				arg_296_1.var_.characterEffect102003ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect102003ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect102003ui_story then
				arg_296_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_299_4 = 0
			local var_299_5 = 0.35

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(924021071)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 14 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 14)

				if (14 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 14)) > 0 and var_299_5 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021071", "story_v_side_old_924021.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021071", "story_v_side_old_924021.awb") / 1000

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end

					if var_299_6.prefab_name ~= "" and arg_296_1.actors_[var_299_6.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_6.prefab_name].transform, "story_v_side_old_924021", "924021071", "story_v_side_old_924021.awb")

						arg_296_1:RecordAudio("924021071", var_299_11)
						arg_296_1:RecordAudio("924021071", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021071", "story_v_side_old_924021.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021071", "story_v_side_old_924021.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_12 and arg_296_1.time_ < var_299_4 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play924021072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 924021072
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play924021073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["102003ui_story"]) and arg_300_1.var_.characterEffect102003ui_story == nil then
				arg_300_1.var_.characterEffect102003ui_story = arg_300_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["102003ui_story"]) then
				if arg_300_1.var_.characterEffect102003ui_story and not isNil(arg_300_1.actors_["102003ui_story"]) then
					arg_300_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_300_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_0)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["102003ui_story"]) and arg_300_1.var_.characterEffect102003ui_story then
				arg_300_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_300_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_303_1 = 0
			local var_303_2 = 0.325

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(924021072).content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 13 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_3) / 13)

				if (13 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_3) / 13)) > 0 and var_303_2 < var_303_5 then
					arg_300_1.talkMaxDuration = var_303_5

					if var_303_5 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_6 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_6 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_6

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_6 and arg_300_1.time_ < var_303_1 + var_303_6 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play924021073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 924021073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play924021074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos102003ui_story = arg_304_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_307_0 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 then
				arg_304_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_304_1.time_ - 0) / var_307_0)
				arg_304_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["102003ui_story"].transform.position).z)
				arg_304_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["102003ui_story"].transform.localEulerAngles = arg_304_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 then
				arg_304_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["102003ui_story"].transform.position).z)
				arg_304_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["102003ui_story"].transform.localEulerAngles = arg_304_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_307_1 = 0
			local var_307_2 = 0.85

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(924021073).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 34 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 34)

				if (34 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 34)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play924021074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 924021074
		arg_308_1.duration_ = 3.75

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play924021075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_0 = 1

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				local var_311_1 = Color.New(0, 0, 0)

				var_311_1.a = Mathf.Lerp(0, 1, (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.mask_.color = var_311_1
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				local var_311_2 = Color.New(0, 0, 0)

				var_311_2.a = 1
				arg_308_1.mask_.color = var_311_2
			end

			local var_311_3 = 1

			if 1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_3 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_4 = 1

			if var_311_3 <= arg_308_1.time_ and arg_308_1.time_ < var_311_3 + var_311_4 then
				local var_311_5 = Color.New(0, 0, 0)

				var_311_5.a = Mathf.Lerp(1, 0, (arg_308_1.time_ - var_311_3) / var_311_4)
				arg_308_1.mask_.color = var_311_5
			end

			if arg_308_1.time_ >= var_311_3 + var_311_4 and arg_308_1.time_ < var_311_3 + var_311_4 + arg_311_0 then
				local var_311_6 = Color.New(0, 0, 0)

				arg_308_1.mask_.enabled = false
				var_311_6.a = 0
				arg_308_1.mask_.color = var_311_6
			end

			if 1 < arg_308_1.time_ and arg_308_1.time_ <= 1 + arg_311_0 then
				arg_308_1.fswbg_:SetActive(true)
				arg_308_1.dialog_:SetActive(false)

				arg_308_1.fswtw_.percent = 0
				arg_308_1.fswt_.text = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(924021074).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.fswt_)

				arg_308_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_308_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_308_1.fswtw_:SetDirty()

				arg_308_1.typewritterCharCountI18N = 0

				SetActive(arg_308_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_308_1:ShowNextGo(false)
			end

			local var_311_7 = 1.01666666666667

			if 1.01666666666667 < arg_308_1.time_ and arg_308_1.time_ <= var_311_7 + arg_311_0 then
				arg_308_1.var_.oldValueTypewriter = arg_308_1.fswtw_.percent

				SetActive(arg_308_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_308_1:ShowNextGo(false)
			end

			local var_311_8 = 41
			local var_311_9 = 2.73333333333333
			local var_311_10, var_311_11 = arg_308_1:GetPercentByPara(arg_308_1:FormatText(arg_308_1:GetWordFromCfg(924021074).content), 1)

			if var_311_7 < arg_308_1.time_ and arg_308_1.time_ <= var_311_7 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0

				local var_311_12 = var_311_8 <= 0 and var_311_9 or var_311_9 * ((var_311_11 - arg_308_1.typewritterCharCountI18N) / var_311_8)

				if (var_311_8 <= 0 and var_311_9 or var_311_9 * ((var_311_11 - arg_308_1.typewritterCharCountI18N) / var_311_8)) > 0 and var_311_9 < var_311_12 then
					arg_308_1.talkMaxDuration = var_311_12

					if var_311_12 + var_311_7 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_12 + var_311_7
					end
				end
			end

			local var_311_13 = math.max(2.73333333333333, arg_308_1.talkMaxDuration)

			if var_311_7 <= arg_308_1.time_ and arg_308_1.time_ < var_311_7 + var_311_13 then
				arg_308_1.fswtw_.percent = Mathf.Lerp(arg_308_1.var_.oldValueTypewriter, var_311_10, (arg_308_1.time_ - var_311_7) / var_311_13)
				arg_308_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_308_1.fswtw_:SetDirty()
			end

			if arg_308_1.time_ >= var_311_7 + var_311_13 and arg_308_1.time_ < var_311_7 + var_311_13 + arg_311_0 then
				arg_308_1.fswtw_.percent = var_311_10

				arg_308_1.fswtw_:SetDirty()
				arg_308_1:ShowNextGo(true)

				arg_308_1.typewritterCharCountI18N = var_311_11
			end

			if 1 < arg_308_1.time_ and arg_308_1.time_ <= 1 + arg_311_0 then
				local var_311_14 = arg_308_1.fswbg_.transform:Find("textbox/adapt/content") or arg_308_1.fswbg_.transform:Find("textbox/content")
				local var_311_15 = arg_308_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_311_16 = var_311_14:GetComponent("RectTransform")

				var_311_14:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_311_16.offsetMin = Vector2.New(0, 0)
				var_311_16.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play924021075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 924021075
		arg_312_1.duration_ = 5.8

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play924021076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.fswbg_:SetActive(false)
				arg_312_1.dialog_:SetActive(false)
				SetActive(arg_312_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_312_1:ShowNextGo(false)
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_0 = 0.8
			local var_315_1 = 0.2

			if 0.8 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_2 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_2:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(924021075).content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 8 <= 0 and var_315_1 or var_315_1 * (utf8.len(var_315_3) / 8)

				if (8 <= 0 and var_315_1 or var_315_1 * (utf8.len(var_315_3) / 8)) > 0 and var_315_1 < var_315_5 then
					arg_312_1.talkMaxDuration = var_315_5
					var_315_0 = var_315_0 + 0.3

					if var_315_5 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_6 = var_315_0 + 0.3
			local var_315_7 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 + 0.3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_6 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_6) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_6 + var_315_7 and arg_312_1.time_ < var_315_6 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play924021076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 924021076
		arg_318_1.duration_ = 10.37

		local var_318_0 = {
			zh = 4.666,
			ja = 10.366
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
				arg_318_0:Play924021077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos102003ui_story = arg_318_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_321_0 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				arg_318_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_318_1.time_ - 0) / var_321_0)
				arg_318_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["102003ui_story"].transform.position).z)
				arg_318_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["102003ui_story"].transform.localEulerAngles = arg_318_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				arg_318_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_318_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["102003ui_story"].transform.position).z)
				arg_318_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["102003ui_story"].transform.localEulerAngles = arg_318_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_321_1 = arg_318_1.actors_["102003ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect102003ui_story == nil then
				arg_318_1.var_.characterEffect102003ui_story = var_321_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_2 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_2 and not isNil(var_321_1) then
				if arg_318_1.var_.characterEffect102003ui_story and not isNil(var_321_1) then
					arg_318_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_2 and arg_318_1.time_ < 0 + var_321_2 + arg_321_0 and not isNil(var_321_1) and arg_318_1.var_.characterEffect102003ui_story then
				arg_318_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_321_4 = 0
			local var_321_5 = 0.625

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_6 = arg_318_1:GetWordFromCfg(924021076)
				local var_321_7 = arg_318_1:FormatText(var_321_6.content)

				arg_318_1.text_.text = var_321_7

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_9 = 25 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 25)

				if (25 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 25)) > 0 and var_321_5 < var_321_9 then
					arg_318_1.talkMaxDuration = var_321_9

					if var_321_9 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_9 + var_321_4
					end
				end

				arg_318_1.text_.text = var_321_7
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021076", "story_v_side_old_924021.awb") ~= 0 then
					local var_321_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021076", "story_v_side_old_924021.awb") / 1000

					if var_321_10 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_4
					end

					if var_321_6.prefab_name ~= "" and arg_318_1.actors_[var_321_6.prefab_name] ~= nil then
						local var_321_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_6.prefab_name].transform, "story_v_side_old_924021", "924021076", "story_v_side_old_924021.awb")

						arg_318_1:RecordAudio("924021076", var_321_11)
						arg_318_1:RecordAudio("924021076", var_321_11)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021076", "story_v_side_old_924021.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021076", "story_v_side_old_924021.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_12 = math.max(var_321_5, arg_318_1.talkMaxDuration)

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_12 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_4) / var_321_12

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_4 + var_321_12 and arg_318_1.time_ < var_321_4 + var_321_12 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924021077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 924021077
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play924021078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["102003ui_story"]) and arg_322_1.var_.characterEffect102003ui_story == nil then
				arg_322_1.var_.characterEffect102003ui_story = arg_322_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_0 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["102003ui_story"]) then
				if arg_322_1.var_.characterEffect102003ui_story and not isNil(arg_322_1.actors_["102003ui_story"]) then
					arg_322_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_322_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_0)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["102003ui_story"]) and arg_322_1.var_.characterEffect102003ui_story then
				arg_322_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_322_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_325_1 = 0
			local var_325_2 = 1

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_3 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(924021077).content)

				arg_322_1.text_.text = var_325_3

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_5 = 40 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 40)

				if (40 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_3) / 40)) > 0 and var_325_2 < var_325_5 then
					arg_322_1.talkMaxDuration = var_325_5

					if var_325_5 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_3
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_6 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_6 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_6

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_6 and arg_322_1.time_ < var_325_1 + var_325_6 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play924021078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 924021078
		arg_326_1.duration_ = 9.27

		local var_326_0 = {
			zh = 7.3,
			ja = 9.266
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
				arg_326_0:Play924021079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos102003ui_story = arg_326_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["102003ui_story"].transform.position).z)
				arg_326_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["102003ui_story"].transform.localEulerAngles = arg_326_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_326_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["102003ui_story"].transform.position).z)
				arg_326_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["102003ui_story"].transform.localEulerAngles = arg_326_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["102003ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect102003ui_story == nil then
				arg_326_1.var_.characterEffect102003ui_story = var_329_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_2 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_2 and not isNil(var_329_1) then
				if arg_326_1.var_.characterEffect102003ui_story and not isNil(var_329_1) then
					arg_326_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= 0 + var_329_2 and arg_326_1.time_ < 0 + var_329_2 + arg_329_0 and not isNil(var_329_1) and arg_326_1.var_.characterEffect102003ui_story then
				arg_326_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_2")
			end

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_329_4 = 0
			local var_329_5 = 0.6

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_4 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_6 = arg_326_1:GetWordFromCfg(924021078)
				local var_329_7 = arg_326_1:FormatText(var_329_6.content)

				arg_326_1.text_.text = var_329_7

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_9 = 24 <= 0 and var_329_5 or var_329_5 * (utf8.len(var_329_7) / 24)

				if (24 <= 0 and var_329_5 or var_329_5 * (utf8.len(var_329_7) / 24)) > 0 and var_329_5 < var_329_9 then
					arg_326_1.talkMaxDuration = var_329_9

					if var_329_9 + var_329_4 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_9 + var_329_4
					end
				end

				arg_326_1.text_.text = var_329_7
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021078", "story_v_side_old_924021.awb") ~= 0 then
					local var_329_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021078", "story_v_side_old_924021.awb") / 1000

					if var_329_10 + var_329_4 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_4
					end

					if var_329_6.prefab_name ~= "" and arg_326_1.actors_[var_329_6.prefab_name] ~= nil then
						local var_329_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_6.prefab_name].transform, "story_v_side_old_924021", "924021078", "story_v_side_old_924021.awb")

						arg_326_1:RecordAudio("924021078", var_329_11)
						arg_326_1:RecordAudio("924021078", var_329_11)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021078", "story_v_side_old_924021.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021078", "story_v_side_old_924021.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_12 = math.max(var_329_5, arg_326_1.talkMaxDuration)

			if var_329_4 <= arg_326_1.time_ and arg_326_1.time_ < var_329_4 + var_329_12 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_4) / var_329_12

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_4 + var_329_12 and arg_326_1.time_ < var_329_4 + var_329_12 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play924021079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 924021079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play924021080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["102003ui_story"]) and arg_330_1.var_.characterEffect102003ui_story == nil then
				arg_330_1.var_.characterEffect102003ui_story = arg_330_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_0 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["102003ui_story"]) then
				if arg_330_1.var_.characterEffect102003ui_story and not isNil(arg_330_1.actors_["102003ui_story"]) then
					arg_330_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_330_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_330_1.time_ - 0) / var_333_0)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["102003ui_story"]) and arg_330_1.var_.characterEffect102003ui_story then
				arg_330_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_330_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_333_1 = 0
			local var_333_2 = 0.85

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(924021079).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 34 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 34)

				if (34 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 34)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play924021080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 924021080
		arg_334_1.duration_ = 4.07

		local var_334_0 = {
			zh = 3.733,
			ja = 4.066
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
				arg_334_0:Play924021081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos102003ui_story = arg_334_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["102003ui_story"].transform.position).z)
				arg_334_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["102003ui_story"].transform.localEulerAngles = arg_334_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_334_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["102003ui_story"].transform.position).z)
				arg_334_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["102003ui_story"].transform.localEulerAngles = arg_334_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_337_1 = arg_334_1.actors_["102003ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect102003ui_story == nil then
				arg_334_1.var_.characterEffect102003ui_story = var_337_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_2 and not isNil(var_337_1) then
				if arg_334_1.var_.characterEffect102003ui_story and not isNil(var_337_1) then
					arg_334_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_2 and arg_334_1.time_ < 0 + var_337_2 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect102003ui_story then
				arg_334_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_1")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_337_4 = 0
			local var_337_5 = 0.25

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_6 = arg_334_1:GetWordFromCfg(924021080)
				local var_337_7 = arg_334_1:FormatText(var_337_6.content)

				arg_334_1.text_.text = var_337_7

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_9 = 10 <= 0 and var_337_5 or var_337_5 * (utf8.len(var_337_7) / 10)

				if (10 <= 0 and var_337_5 or var_337_5 * (utf8.len(var_337_7) / 10)) > 0 and var_337_5 < var_337_9 then
					arg_334_1.talkMaxDuration = var_337_9

					if var_337_9 + var_337_4 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_9 + var_337_4
					end
				end

				arg_334_1.text_.text = var_337_7
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021080", "story_v_side_old_924021.awb") ~= 0 then
					local var_337_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021080", "story_v_side_old_924021.awb") / 1000

					if var_337_10 + var_337_4 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_4
					end

					if var_337_6.prefab_name ~= "" and arg_334_1.actors_[var_337_6.prefab_name] ~= nil then
						local var_337_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_6.prefab_name].transform, "story_v_side_old_924021", "924021080", "story_v_side_old_924021.awb")

						arg_334_1:RecordAudio("924021080", var_337_11)
						arg_334_1:RecordAudio("924021080", var_337_11)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021080", "story_v_side_old_924021.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021080", "story_v_side_old_924021.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_12 = math.max(var_337_5, arg_334_1.talkMaxDuration)

			if var_337_4 <= arg_334_1.time_ and arg_334_1.time_ < var_337_4 + var_337_12 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_4) / var_337_12

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_4 + var_337_12 and arg_334_1.time_ < var_337_4 + var_337_12 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play924021081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 924021081
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play924021082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos102003ui_story = arg_338_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_341_0 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 then
				arg_338_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_338_1.time_ - 0) / var_341_0)
				arg_338_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["102003ui_story"].transform.position).z)
				arg_338_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["102003ui_story"].transform.localEulerAngles = arg_338_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 then
				arg_338_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_338_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["102003ui_story"].transform.position).z)
				arg_338_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["102003ui_story"].transform.localEulerAngles = arg_338_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_341_1 = arg_338_1.actors_["102003ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect102003ui_story == nil then
				arg_338_1.var_.characterEffect102003ui_story = var_341_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_2 and not isNil(var_341_1) then
				if arg_338_1.var_.characterEffect102003ui_story and not isNil(var_341_1) then
					arg_338_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_338_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_2)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_2 and arg_338_1.time_ < 0 + var_341_2 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect102003ui_story then
				arg_338_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_338_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_341_3 = 0
			local var_341_4 = 0.8

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_3 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_5 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(924021081).content)

				arg_338_1.text_.text = var_341_5

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 32 <= 0 and var_341_4 or var_341_4 * (utf8.len(var_341_5) / 32)

				if (32 <= 0 and var_341_4 or var_341_4 * (utf8.len(var_341_5) / 32)) > 0 and var_341_4 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_3 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_3
					end
				end

				arg_338_1.text_.text = var_341_5
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_8 = math.max(var_341_4, arg_338_1.talkMaxDuration)

			if var_341_3 <= arg_338_1.time_ and arg_338_1.time_ < var_341_3 + var_341_8 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_3) / var_341_8

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_3 + var_341_8 and arg_338_1.time_ < var_341_3 + var_341_8 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924021082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 924021082
		arg_342_1.duration_ = 9

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play924021083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if arg_342_1.bgs_["ST01 "] == nil then
				local var_345_0 = Object.Instantiate(arg_342_1.paintGo_)

				var_345_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01 ")
				var_345_0.name = "ST01 "
				var_345_0.transform.parent = arg_342_1.stage_.transform
				var_345_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_342_1.bgs_["ST01 "] = var_345_0
			end

			if 1.999999999999 < arg_342_1.time_ and arg_342_1.time_ <= 1.999999999999 + arg_345_0 then
				local var_345_1 = arg_342_1.bgs_["ST01 "]

				arg_342_1.bgs_["ST01 "].transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_345_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_345_2 = var_345_1:GetComponent("SpriteRenderer")

				if var_345_2 and var_345_2.sprite then
					local var_345_3 = 2 * (var_345_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_345_1.transform.localScale = Vector3.New(var_345_3 / var_345_2.sprite.bounds.size.y < var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x and var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x or var_345_3 / var_345_2.sprite.bounds.size.y, var_345_3 / var_345_2.sprite.bounds.size.y < var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x and var_345_3 * manager.ui.mainCameraCom_.aspect / var_345_2.sprite.bounds.size.x or var_345_3 / var_345_2.sprite.bounds.size.y, 0)
				end

				for iter_345_0, iter_345_1 in pairs(arg_342_1.bgs_) do
					if iter_345_0 ~= "ST01 " then
						iter_345_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_345_4 = 3.999999999999

			if 3.999999999999 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.allBtn_.enabled = false
			end

			if arg_342_1.time_ >= var_345_4 + 0.3 and arg_342_1.time_ < var_345_4 + 0.3 + arg_345_0 then
				arg_342_1.allBtn_.enabled = true
			end

			local var_345_5 = 0

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_5 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_6 = 2

			if var_345_5 <= arg_342_1.time_ and arg_342_1.time_ < var_345_5 + var_345_6 then
				local var_345_7 = Color.New(0, 0, 0)

				var_345_7.a = Mathf.Lerp(0, 1, (arg_342_1.time_ - var_345_5) / var_345_6)
				arg_342_1.mask_.color = var_345_7
			end

			if arg_342_1.time_ >= var_345_5 + var_345_6 and arg_342_1.time_ < var_345_5 + var_345_6 + arg_345_0 then
				local var_345_8 = Color.New(0, 0, 0)

				var_345_8.a = 1
				arg_342_1.mask_.color = var_345_8
			end

			local var_345_9 = 2

			if 2 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_10 = 2

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_10 then
				local var_345_11 = Color.New(0, 0, 0)

				var_345_11.a = Mathf.Lerp(1, 0, (arg_342_1.time_ - var_345_9) / var_345_10)
				arg_342_1.mask_.color = var_345_11
			end

			if arg_342_1.time_ >= var_345_9 + var_345_10 and arg_342_1.time_ < var_345_9 + var_345_10 + arg_345_0 then
				local var_345_12 = Color.New(0, 0, 0)

				arg_342_1.mask_.enabled = false
				var_345_12.a = 0
				arg_342_1.mask_.color = var_345_12
			end

			local var_345_13 = 2

			arg_342_1.isInRecall_ = false

			if var_345_13 < arg_342_1.time_ and arg_342_1.time_ <= var_345_13 + arg_345_0 then
				arg_342_1.screenFilterGo_:SetActive(true)

				arg_342_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_345_2, iter_345_3 in pairs(arg_342_1.actors_) do
					for iter_345_4, iter_345_5 in ipairs((iter_345_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_345_5.color = iter_345_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_345_14 = 0.1

			if var_345_13 <= arg_342_1.time_ and arg_342_1.time_ < var_345_13 + var_345_14 then
				arg_342_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_342_1.time_ - var_345_13) / var_345_14)
			end

			if arg_342_1.time_ >= var_345_13 + var_345_14 and arg_342_1.time_ < var_345_13 + var_345_14 + arg_345_0 then
				arg_342_1.screenFilterEffect_.weight = 1
			end

			if 0.125 < arg_342_1.time_ and arg_342_1.time_ <= 0.125 + arg_345_0 then
				arg_342_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if 1.7 < arg_342_1.time_ and arg_342_1.time_ <= 1.7 + arg_345_0 then
				arg_342_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_342_1.frameCnt_ <= 1 then
				arg_342_1.dialog_:SetActive(false)
			end

			local var_345_17 = 3.999999999999
			local var_345_18 = 1

			if 3.999999999999 < arg_342_1.time_ and arg_342_1.time_ <= var_345_17 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0

				arg_342_1.dialog_:SetActive(true)

				arg_342_1.dialogCg_.alpha = 0

				local var_345_19 = LeanTween.value(arg_342_1.dialog_, 0, 1, 0.3)

				var_345_19:setOnUpdate(LuaHelper.FloatAction(function(arg_346_0)
					arg_342_1.dialogCg_.alpha = arg_346_0
				end))
				var_345_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_342_1.dialog_)
					var_345_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_342_1.duration_ = arg_342_1.duration_ + 0.3

				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_342_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_345_20 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(924021082).content)

				arg_342_1.text_.text = var_345_20

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_22 = 40 <= 0 and var_345_18 or var_345_18 * (utf8.len(var_345_20) / 40)

				if (40 <= 0 and var_345_18 or var_345_18 * (utf8.len(var_345_20) / 40)) > 0 and var_345_18 < var_345_22 then
					arg_342_1.talkMaxDuration = var_345_22
					var_345_17 = var_345_17 + 0.3

					if var_345_22 + var_345_17 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_22 + var_345_17
					end
				end

				arg_342_1.text_.text = var_345_20
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_23 = var_345_17 + 0.3
			local var_345_24 = math.max(var_345_18, arg_342_1.talkMaxDuration)

			if var_345_17 + 0.3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_23 + var_345_24 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_23) / var_345_24

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_23 + var_345_24 and arg_342_1.time_ < var_345_23 + var_345_24 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play924021083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 924021083
		arg_348_1.duration_ = 5

		local var_348_0 = {
			zh = 3.2,
			ja = 5
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play924021084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if arg_348_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_351_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_348_1.stage_.transform)

				var_351_0.name = "1020ui_story"
				var_351_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.actors_["1020ui_story"] = var_351_0

				local var_351_1 = var_351_0:GetComponentInChildren(typeof(CharacterEffect))

				var_351_1.enabled = true

				local var_351_2 = GameObjectTools.GetOrAddComponent(var_351_0, typeof(DynamicBoneHelper))

				if var_351_2 then
					var_351_2:EnableDynamicBone(false)
				end

				arg_348_1:ShowWeapon(var_351_1.transform, false)

				arg_348_1.var_["1020ui_story" .. "Animator"] = var_351_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_348_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_348_1.var_["1020ui_story" .. "LipSync"] = var_351_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_351_3 = arg_348_1.actors_["1020ui_story"].transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1020ui_story = var_351_3.localPosition
			end

			local var_351_4 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_4 then
				var_351_3.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_348_1.time_ - 0) / var_351_4)
				var_351_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_3.position).x, (manager.ui.mainCamera.transform.position - var_351_3.position).y, (manager.ui.mainCamera.transform.position - var_351_3.position).z)
				var_351_3.localEulerAngles.z = 0
				var_351_3.localEulerAngles.x = 0
				var_351_3.localEulerAngles = var_351_3.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_4 and arg_348_1.time_ < 0 + var_351_4 + arg_351_0 then
				var_351_3.localPosition = Vector3.New(0, -0.85, -6.25)
				var_351_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_3.position).x, (manager.ui.mainCamera.transform.position - var_351_3.position).y, (manager.ui.mainCamera.transform.position - var_351_3.position).z)
				var_351_3.localEulerAngles.z = 0
				var_351_3.localEulerAngles.x = 0
				var_351_3.localEulerAngles = var_351_3.localEulerAngles
			end

			local var_351_5 = arg_348_1.actors_["1020ui_story"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_5) and arg_348_1.var_.characterEffect1020ui_story == nil then
				arg_348_1.var_.characterEffect1020ui_story = var_351_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_6 = 0.200000002980232

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_6 and not isNil(var_351_5) then
				if arg_348_1.var_.characterEffect1020ui_story and not isNil(var_351_5) then
					arg_348_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= 0 + var_351_6 and arg_348_1.time_ < 0 + var_351_6 + arg_351_0 and not isNil(var_351_5) and arg_348_1.var_.characterEffect1020ui_story then
				arg_348_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_351_8 = 0
			local var_351_9 = 0.275

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_8 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_10 = arg_348_1:GetWordFromCfg(924021083)
				local var_351_11 = arg_348_1:FormatText(var_351_10.content)

				arg_348_1.text_.text = var_351_11

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_13 = 11 <= 0 and var_351_9 or var_351_9 * (utf8.len(var_351_11) / 11)

				if (11 <= 0 and var_351_9 or var_351_9 * (utf8.len(var_351_11) / 11)) > 0 and var_351_9 < var_351_13 then
					arg_348_1.talkMaxDuration = var_351_13

					if var_351_13 + var_351_8 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_13 + var_351_8
					end
				end

				arg_348_1.text_.text = var_351_11
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021083", "story_v_side_old_924021.awb") ~= 0 then
					local var_351_14 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021083", "story_v_side_old_924021.awb") / 1000

					if var_351_14 + var_351_8 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_14 + var_351_8
					end

					if var_351_10.prefab_name ~= "" and arg_348_1.actors_[var_351_10.prefab_name] ~= nil then
						local var_351_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_10.prefab_name].transform, "story_v_side_old_924021", "924021083", "story_v_side_old_924021.awb")

						arg_348_1:RecordAudio("924021083", var_351_15)
						arg_348_1:RecordAudio("924021083", var_351_15)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021083", "story_v_side_old_924021.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021083", "story_v_side_old_924021.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_16 = math.max(var_351_9, arg_348_1.talkMaxDuration)

			if var_351_8 <= arg_348_1.time_ and arg_348_1.time_ < var_351_8 + var_351_16 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_8) / var_351_16

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_8 + var_351_16 and arg_348_1.time_ < var_351_8 + var_351_16 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play924021084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 924021084
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play924021085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1020ui_story"]) and arg_352_1.var_.characterEffect1020ui_story == nil then
				arg_352_1.var_.characterEffect1020ui_story = arg_352_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1020ui_story"]) then
				if arg_352_1.var_.characterEffect1020ui_story and not isNil(arg_352_1.actors_["1020ui_story"]) then
					arg_352_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1020ui_story"]) and arg_352_1.var_.characterEffect1020ui_story then
				arg_352_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.75

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_352_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_355_3 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(924021084).content)

				arg_352_1.text_.text = var_355_3

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 30 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 30)

				if (30 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 30)) > 0 and var_355_2 < var_355_5 then
					arg_352_1.talkMaxDuration = var_355_5

					if var_355_5 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_3
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_6 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_6 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_6

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_6 and arg_352_1.time_ < var_355_1 + var_355_6 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play924021085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 924021085
		arg_356_1.duration_ = 3.67

		local var_356_0 = {
			zh = 3.66633333333333,
			ja = 1.999999999999
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play924021086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1020ui_story"]) and arg_356_1.var_.characterEffect1020ui_story == nil then
				arg_356_1.var_.characterEffect1020ui_story = arg_356_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1020ui_story"]) then
				if arg_356_1.var_.characterEffect1020ui_story and not isNil(arg_356_1.actors_["1020ui_story"]) then
					arg_356_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1020ui_story"]) and arg_356_1.var_.characterEffect1020ui_story then
				arg_356_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_359_2 = 0

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.allBtn_.enabled = false
			end

			if arg_356_1.time_ >= var_359_2 + 0.908333333333333 and arg_356_1.time_ < var_359_2 + 0.908333333333333 + arg_359_0 then
				arg_356_1.allBtn_.enabled = true
			end

			if arg_356_1.frameCnt_ <= 1 then
				arg_356_1.dialog_:SetActive(false)
			end

			local var_359_3 = 0.733333333333333
			local var_359_4 = 0.175

			if 0.733333333333333 < arg_356_1.time_ and arg_356_1.time_ <= var_359_3 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0

				arg_356_1.dialog_:SetActive(true)

				arg_356_1.dialogCg_.alpha = 0

				local var_359_5 = LeanTween.value(arg_356_1.dialog_, 0, 1, 0.3)

				var_359_5:setOnUpdate(LuaHelper.FloatAction(function(arg_360_0)
					arg_356_1.dialogCg_.alpha = arg_360_0
				end))
				var_359_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_356_1.dialog_)
					var_359_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_356_1.duration_ = arg_356_1.duration_ + 0.3

				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_6 = arg_356_1:GetWordFromCfg(924021085)
				local var_359_7 = arg_356_1:FormatText(var_359_6.content)

				arg_356_1.text_.text = var_359_7

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_9 = 7 <= 0 and var_359_4 or var_359_4 * (utf8.len(var_359_7) / 7)

				if (7 <= 0 and var_359_4 or var_359_4 * (utf8.len(var_359_7) / 7)) > 0 and var_359_4 < var_359_9 then
					arg_356_1.talkMaxDuration = var_359_9
					var_359_3 = var_359_3 + 0.3

					if var_359_9 + var_359_3 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_9 + var_359_3
					end
				end

				arg_356_1.text_.text = var_359_7
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021085", "story_v_side_old_924021.awb") ~= 0 then
					local var_359_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021085", "story_v_side_old_924021.awb") / 1000

					if var_359_10 + var_359_3 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_10 + var_359_3
					end

					if var_359_6.prefab_name ~= "" and arg_356_1.actors_[var_359_6.prefab_name] ~= nil then
						local var_359_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_6.prefab_name].transform, "story_v_side_old_924021", "924021085", "story_v_side_old_924021.awb")

						arg_356_1:RecordAudio("924021085", var_359_11)
						arg_356_1:RecordAudio("924021085", var_359_11)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021085", "story_v_side_old_924021.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021085", "story_v_side_old_924021.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_12 = var_359_3 + 0.3
			local var_359_13 = math.max(var_359_4, arg_356_1.talkMaxDuration)

			if var_359_3 + 0.3 <= arg_356_1.time_ and arg_356_1.time_ < var_359_12 + var_359_13 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_12) / var_359_13

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_12 + var_359_13 and arg_356_1.time_ < var_359_12 + var_359_13 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play924021086 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 924021086
		arg_362_1.duration_ = 9

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play924021087(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 2 < arg_362_1.time_ and arg_362_1.time_ <= 2 + arg_365_0 then
				local var_365_0 = arg_362_1.bgs_.X204_g

				arg_362_1.bgs_.X204_g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_365_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_1 = var_365_0:GetComponent("SpriteRenderer")

				if var_365_1 and var_365_1.sprite then
					local var_365_2 = 2 * (var_365_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_365_0.transform.localScale = Vector3.New(var_365_2 / var_365_1.sprite.bounds.size.y < var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x and var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x or var_365_2 / var_365_1.sprite.bounds.size.y, var_365_2 / var_365_1.sprite.bounds.size.y < var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x and var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x or var_365_2 / var_365_1.sprite.bounds.size.y, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "X204_g" then
						iter_365_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_365_3 = 4

			if 4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_3 + arg_365_0 then
				arg_362_1.allBtn_.enabled = false
			end

			if arg_362_1.time_ >= var_365_3 + 0.3 and arg_362_1.time_ < var_365_3 + 0.3 + arg_365_0 then
				arg_362_1.allBtn_.enabled = true
			end

			local var_365_4 = 0

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_5 = 2

			if var_365_4 <= arg_362_1.time_ and arg_362_1.time_ < var_365_4 + var_365_5 then
				local var_365_6 = Color.New(0, 0, 0)

				var_365_6.a = Mathf.Lerp(0, 1, (arg_362_1.time_ - var_365_4) / var_365_5)
				arg_362_1.mask_.color = var_365_6
			end

			if arg_362_1.time_ >= var_365_4 + var_365_5 and arg_362_1.time_ < var_365_4 + var_365_5 + arg_365_0 then
				local var_365_7 = Color.New(0, 0, 0)

				var_365_7.a = 1
				arg_362_1.mask_.color = var_365_7
			end

			local var_365_8 = 2

			if 2 < arg_362_1.time_ and arg_362_1.time_ <= var_365_8 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_9 = 2

			if var_365_8 <= arg_362_1.time_ and arg_362_1.time_ < var_365_8 + var_365_9 then
				local var_365_10 = Color.New(0, 0, 0)

				var_365_10.a = Mathf.Lerp(1, 0, (arg_362_1.time_ - var_365_8) / var_365_9)
				arg_362_1.mask_.color = var_365_10
			end

			if arg_362_1.time_ >= var_365_8 + var_365_9 and arg_362_1.time_ < var_365_8 + var_365_9 + arg_365_0 then
				local var_365_11 = Color.New(0, 0, 0)

				arg_362_1.mask_.enabled = false
				var_365_11.a = 0
				arg_362_1.mask_.color = var_365_11
			end

			local var_365_12 = arg_362_1.actors_["1020ui_story"]

			if 2 < arg_362_1.time_ and arg_362_1.time_ <= 2 + arg_365_0 and not isNil(var_365_12) and arg_362_1.var_.characterEffect1020ui_story == nil then
				arg_362_1.var_.characterEffect1020ui_story = var_365_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_13 = 0.200000002980232

			if 2 <= arg_362_1.time_ and arg_362_1.time_ < 2 + var_365_13 and not isNil(var_365_12) then
				if arg_362_1.var_.characterEffect1020ui_story and not isNil(var_365_12) then
					arg_362_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_362_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_362_1.time_ - 2) / var_365_13)
				end
			end

			if arg_362_1.time_ >= 2 + var_365_13 and arg_362_1.time_ < 2 + var_365_13 + arg_365_0 and not isNil(var_365_12) and arg_362_1.var_.characterEffect1020ui_story then
				arg_362_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_362_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_365_14 = 2

			arg_362_1.isInRecall_ = false

			if var_365_14 < arg_362_1.time_ and arg_362_1.time_ <= var_365_14 + arg_365_0 then
				arg_362_1.screenFilterGo_:SetActive(false)

				for iter_365_2, iter_365_3 in pairs(arg_362_1.actors_) do
					for iter_365_4, iter_365_5 in ipairs((iter_365_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_365_5.color = iter_365_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_365_15 = 0.1

			if var_365_14 <= arg_362_1.time_ and arg_362_1.time_ < var_365_14 + var_365_15 then
				arg_362_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_362_1.time_ - var_365_14) / var_365_15)
			end

			if arg_362_1.time_ >= var_365_14 + var_365_15 and arg_362_1.time_ < var_365_14 + var_365_15 + arg_365_0 then
				arg_362_1.screenFilterEffect_.weight = 0
			end

			if 0.125 < arg_362_1.time_ and arg_362_1.time_ <= 0.125 + arg_365_0 then
				arg_362_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if 1.73333333333333 < arg_362_1.time_ and arg_362_1.time_ <= 1.73333333333333 + arg_365_0 then
				arg_362_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			local var_365_18 = arg_362_1.actors_["1020ui_story"].transform

			if 2 < arg_362_1.time_ and arg_362_1.time_ <= 2 + arg_365_0 then
				arg_362_1.var_.moveOldPos1020ui_story = var_365_18.localPosition
			end

			local var_365_19 = 0.001

			if 2 <= arg_362_1.time_ and arg_362_1.time_ < 2 + var_365_19 then
				var_365_18.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_362_1.time_ - 2) / var_365_19)
				var_365_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_18.position).x, (manager.ui.mainCamera.transform.position - var_365_18.position).y, (manager.ui.mainCamera.transform.position - var_365_18.position).z)
				var_365_18.localEulerAngles.z = 0
				var_365_18.localEulerAngles.x = 0
				var_365_18.localEulerAngles = var_365_18.localEulerAngles
			end

			if arg_362_1.time_ >= 2 + var_365_19 and arg_362_1.time_ < 2 + var_365_19 + arg_365_0 then
				var_365_18.localPosition = Vector3.New(0, 100, 0)
				var_365_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_18.position).x, (manager.ui.mainCamera.transform.position - var_365_18.position).y, (manager.ui.mainCamera.transform.position - var_365_18.position).z)
				var_365_18.localEulerAngles.z = 0
				var_365_18.localEulerAngles.x = 0
				var_365_18.localEulerAngles = var_365_18.localEulerAngles
			end

			if arg_362_1.frameCnt_ <= 1 then
				arg_362_1.dialog_:SetActive(false)
			end

			local var_365_20 = 4
			local var_365_21 = 0.15

			if 4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_20 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				arg_362_1.dialog_:SetActive(true)

				arg_362_1.dialogCg_.alpha = 0

				local var_365_22 = LeanTween.value(arg_362_1.dialog_, 0, 1, 0.3)

				var_365_22:setOnUpdate(LuaHelper.FloatAction(function(arg_366_0)
					arg_362_1.dialogCg_.alpha = arg_366_0
				end))
				var_365_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_362_1.dialog_)
					var_365_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_362_1.duration_ = arg_362_1.duration_ + 0.3

				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_23 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(924021086).content)

				arg_362_1.text_.text = var_365_23

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_25 = 6 <= 0 and var_365_21 or var_365_21 * (utf8.len(var_365_23) / 6)

				if (6 <= 0 and var_365_21 or var_365_21 * (utf8.len(var_365_23) / 6)) > 0 and var_365_21 < var_365_25 then
					arg_362_1.talkMaxDuration = var_365_25
					var_365_20 = var_365_20 + 0.3

					if var_365_25 + var_365_20 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_25 + var_365_20
					end
				end

				arg_362_1.text_.text = var_365_23
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_26 = var_365_20 + 0.3
			local var_365_27 = math.max(var_365_21, arg_362_1.talkMaxDuration)

			if var_365_20 + 0.3 <= arg_362_1.time_ and arg_362_1.time_ < var_365_26 + var_365_27 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_26) / var_365_27

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_26 + var_365_27 and arg_362_1.time_ < var_365_26 + var_365_27 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play924021087 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 924021087
		arg_368_1.duration_ = 7.07

		local var_368_0 = {
			zh = 5.966,
			ja = 7.066
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
				arg_368_0:Play924021088(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos102003ui_story = arg_368_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_371_0 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 then
				arg_368_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_368_1.time_ - 0) / var_371_0)
				arg_368_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["102003ui_story"].transform.position).z)
				arg_368_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["102003ui_story"].transform.localEulerAngles = arg_368_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 then
				arg_368_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_368_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["102003ui_story"].transform.position).z)
				arg_368_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["102003ui_story"].transform.localEulerAngles = arg_368_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_371_1 = arg_368_1.actors_["102003ui_story"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect102003ui_story == nil then
				arg_368_1.var_.characterEffect102003ui_story = var_371_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_2 and not isNil(var_371_1) then
				if arg_368_1.var_.characterEffect102003ui_story and not isNil(var_371_1) then
					arg_368_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 0 + var_371_2 and arg_368_1.time_ < 0 + var_371_2 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect102003ui_story then
				arg_368_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_371_4 = 0
			local var_371_5 = 0.775

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_6 = arg_368_1:GetWordFromCfg(924021087)
				local var_371_7 = arg_368_1:FormatText(var_371_6.content)

				arg_368_1.text_.text = var_371_7

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_9 = 31 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 31)

				if (31 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 31)) > 0 and var_371_5 < var_371_9 then
					arg_368_1.talkMaxDuration = var_371_9

					if var_371_9 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_9 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_7
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021087", "story_v_side_old_924021.awb") ~= 0 then
					local var_371_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021087", "story_v_side_old_924021.awb") / 1000

					if var_371_10 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_10 + var_371_4
					end

					if var_371_6.prefab_name ~= "" and arg_368_1.actors_[var_371_6.prefab_name] ~= nil then
						local var_371_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_6.prefab_name].transform, "story_v_side_old_924021", "924021087", "story_v_side_old_924021.awb")

						arg_368_1:RecordAudio("924021087", var_371_11)
						arg_368_1:RecordAudio("924021087", var_371_11)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021087", "story_v_side_old_924021.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021087", "story_v_side_old_924021.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_12 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_12 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_12

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_12 and arg_368_1.time_ < var_371_4 + var_371_12 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play924021088 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 924021088
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play924021089(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["102003ui_story"]) and arg_372_1.var_.characterEffect102003ui_story == nil then
				arg_372_1.var_.characterEffect102003ui_story = arg_372_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["102003ui_story"]) then
				if arg_372_1.var_.characterEffect102003ui_story and not isNil(arg_372_1.actors_["102003ui_story"]) then
					arg_372_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_372_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["102003ui_story"]) and arg_372_1.var_.characterEffect102003ui_story then
				arg_372_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_372_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.725

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(924021088).content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 29 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 29)

				if (29 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 29)) > 0 and var_375_2 < var_375_5 then
					arg_372_1.talkMaxDuration = var_375_5

					if var_375_5 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_6 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_6 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_6

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_6 and arg_372_1.time_ < var_375_1 + var_375_6 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play924021089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 924021089
		arg_376_1.duration_ = 6.13

		local var_376_0 = {
			zh = 4.333,
			ja = 6.133
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
				arg_376_0:Play924021090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["102003ui_story"]) and arg_376_1.var_.characterEffect102003ui_story == nil then
				arg_376_1.var_.characterEffect102003ui_story = arg_376_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["102003ui_story"]) then
				if arg_376_1.var_.characterEffect102003ui_story and not isNil(arg_376_1.actors_["102003ui_story"]) then
					arg_376_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["102003ui_story"]) and arg_376_1.var_.characterEffect102003ui_story then
				arg_376_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_2")
			end

			local var_379_2 = 0
			local var_379_3 = 0.475

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_2 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_4 = arg_376_1:GetWordFromCfg(924021089)
				local var_379_5 = arg_376_1:FormatText(var_379_4.content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 19 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 19)

				if (19 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 19)) > 0 and var_379_3 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_2
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021089", "story_v_side_old_924021.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021089", "story_v_side_old_924021.awb") / 1000

					if var_379_8 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_2
					end

					if var_379_4.prefab_name ~= "" and arg_376_1.actors_[var_379_4.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_4.prefab_name].transform, "story_v_side_old_924021", "924021089", "story_v_side_old_924021.awb")

						arg_376_1:RecordAudio("924021089", var_379_9)
						arg_376_1:RecordAudio("924021089", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021089", "story_v_side_old_924021.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021089", "story_v_side_old_924021.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_3, arg_376_1.talkMaxDuration)

			if var_379_2 <= arg_376_1.time_ and arg_376_1.time_ < var_379_2 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_2) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_2 + var_379_10 and arg_376_1.time_ < var_379_2 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play924021090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 924021090
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play924021091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["102003ui_story"]) and arg_380_1.var_.characterEffect102003ui_story == nil then
				arg_380_1.var_.characterEffect102003ui_story = arg_380_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["102003ui_story"]) then
				if arg_380_1.var_.characterEffect102003ui_story and not isNil(arg_380_1.actors_["102003ui_story"]) then
					arg_380_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_380_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["102003ui_story"]) and arg_380_1.var_.characterEffect102003ui_story then
				arg_380_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_380_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_383_1 = 0
			local var_383_2 = 0.7

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(924021090).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 28 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 28)

				if (28 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 28)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play924021091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 924021091
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play924021092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos102003ui_story = arg_384_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["102003ui_story"].transform.position).z)
				arg_384_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["102003ui_story"].transform.localEulerAngles = arg_384_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_384_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["102003ui_story"].transform.position).z)
				arg_384_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["102003ui_story"].transform.localEulerAngles = arg_384_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_387_1 = 0
			local var_387_2 = 0.575

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_3 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(924021091).content)

				arg_384_1.text_.text = var_387_3

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 23 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 23)

				if (23 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 23)) > 0 and var_387_2 < var_387_5 then
					arg_384_1.talkMaxDuration = var_387_5

					if var_387_5 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + var_387_1
					end
				end

				arg_384_1.text_.text = var_387_3
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_6 = math.max(var_387_2, arg_384_1.talkMaxDuration)

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_6 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_1) / var_387_6

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_1 + var_387_6 and arg_384_1.time_ < var_387_1 + var_387_6 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play924021092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 924021092
		arg_388_1.duration_ = 4.93

		local var_388_0 = {
			zh = 3.6,
			ja = 4.933
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play924021093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos102003ui_story = arg_388_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_391_0 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				arg_388_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_388_1.time_ - 0) / var_391_0)
				arg_388_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["102003ui_story"].transform.position).z)
				arg_388_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["102003ui_story"].transform.localEulerAngles = arg_388_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				arg_388_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_388_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["102003ui_story"].transform.position).z)
				arg_388_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["102003ui_story"].transform.localEulerAngles = arg_388_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_391_1 = arg_388_1.actors_["102003ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect102003ui_story == nil then
				arg_388_1.var_.characterEffect102003ui_story = var_391_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_2 and not isNil(var_391_1) then
				if arg_388_1.var_.characterEffect102003ui_story and not isNil(var_391_1) then
					arg_388_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_2 and arg_388_1.time_ < 0 + var_391_2 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect102003ui_story then
				arg_388_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_391_4 = 0
			local var_391_5 = 0.325

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_4 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_6 = arg_388_1:GetWordFromCfg(924021092)
				local var_391_7 = arg_388_1:FormatText(var_391_6.content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_9 = 13 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 13)

				if (13 <= 0 and var_391_5 or var_391_5 * (utf8.len(var_391_7) / 13)) > 0 and var_391_5 < var_391_9 then
					arg_388_1.talkMaxDuration = var_391_9

					if var_391_9 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_9 + var_391_4
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021092", "story_v_side_old_924021.awb") ~= 0 then
					local var_391_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021092", "story_v_side_old_924021.awb") / 1000

					if var_391_10 + var_391_4 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_4
					end

					if var_391_6.prefab_name ~= "" and arg_388_1.actors_[var_391_6.prefab_name] ~= nil then
						local var_391_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_6.prefab_name].transform, "story_v_side_old_924021", "924021092", "story_v_side_old_924021.awb")

						arg_388_1:RecordAudio("924021092", var_391_11)
						arg_388_1:RecordAudio("924021092", var_391_11)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021092", "story_v_side_old_924021.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021092", "story_v_side_old_924021.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_12 = math.max(var_391_5, arg_388_1.talkMaxDuration)

			if var_391_4 <= arg_388_1.time_ and arg_388_1.time_ < var_391_4 + var_391_12 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_4) / var_391_12

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_4 + var_391_12 and arg_388_1.time_ < var_391_4 + var_391_12 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play924021093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 924021093
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play924021094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["102003ui_story"]) and arg_392_1.var_.characterEffect102003ui_story == nil then
				arg_392_1.var_.characterEffect102003ui_story = arg_392_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_0 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["102003ui_story"]) then
				if arg_392_1.var_.characterEffect102003ui_story and not isNil(arg_392_1.actors_["102003ui_story"]) then
					arg_392_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_392_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_392_1.time_ - 0) / var_395_0)
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["102003ui_story"]) and arg_392_1.var_.characterEffect102003ui_story then
				arg_392_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_392_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_395_1 = 0
			local var_395_2 = 0.275

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_3 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(924021093).content)

				arg_392_1.text_.text = var_395_3

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 11 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_3) / 11)

				if (11 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_3) / 11)) > 0 and var_395_2 < var_395_5 then
					arg_392_1.talkMaxDuration = var_395_5

					if var_395_5 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_5 + var_395_1
					end
				end

				arg_392_1.text_.text = var_395_3
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_6 = math.max(var_395_2, arg_392_1.talkMaxDuration)

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_6 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_1) / var_395_6

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_1 + var_395_6 and arg_392_1.time_ < var_395_1 + var_395_6 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play924021094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 924021094
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play924021095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0.95

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_1 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(924021094).content)

				arg_396_1.text_.text = var_399_1

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_3 = 38 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 38)

				if (38 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 38)) > 0 and var_399_0 < var_399_3 then
					arg_396_1.talkMaxDuration = var_399_3

					if var_399_3 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_3 + 0
					end
				end

				arg_396_1.text_.text = var_399_1
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_4 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_4 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_4

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_4 and arg_396_1.time_ < 0 + var_399_4 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play924021095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 924021095
		arg_400_1.duration_ = 1

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"

			SetActive(arg_400_1.choicesGo_, true)

			for iter_401_0, iter_401_1 in ipairs(arg_400_1.choices_) do
				SetActive(iter_401_1.go, iter_401_0 <= 1)
			end

			arg_400_1.choices_[1].txt.text = arg_400_1:FormatText(StoryChoiceCfg[1202].name)
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play924021096(arg_400_1)
			end

			arg_400_1:RecordChoiceLog(924021095, 1202)
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			if arg_400_1.time_ >= 0 + 0.6 and arg_400_1.time_ < 0 + 0.6 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play924021096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 924021096
		arg_404_1.duration_ = 7.23

		local var_404_0 = {
			zh = 7.233,
			ja = 6.5
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play924021097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos102003ui_story = arg_404_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["102003ui_story"].transform.position).z)
				arg_404_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["102003ui_story"].transform.localEulerAngles = arg_404_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_404_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["102003ui_story"].transform.position).z)
				arg_404_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["102003ui_story"].transform.localEulerAngles = arg_404_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["102003ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect102003ui_story == nil then
				arg_404_1.var_.characterEffect102003ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect102003ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect102003ui_story then
				arg_404_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action2_1")
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_407_4 = 0
			local var_407_5 = 0.475

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_6 = arg_404_1:GetWordFromCfg(924021096)
				local var_407_7 = arg_404_1:FormatText(var_407_6.content)

				arg_404_1.text_.text = var_407_7

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_9 = 19 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 19)

				if (19 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 19)) > 0 and var_407_5 < var_407_9 then
					arg_404_1.talkMaxDuration = var_407_9

					if var_407_9 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_9 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_7
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021096", "story_v_side_old_924021.awb") ~= 0 then
					local var_407_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021096", "story_v_side_old_924021.awb") / 1000

					if var_407_10 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_10 + var_407_4
					end

					if var_407_6.prefab_name ~= "" and arg_404_1.actors_[var_407_6.prefab_name] ~= nil then
						local var_407_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_6.prefab_name].transform, "story_v_side_old_924021", "924021096", "story_v_side_old_924021.awb")

						arg_404_1:RecordAudio("924021096", var_407_11)
						arg_404_1:RecordAudio("924021096", var_407_11)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021096", "story_v_side_old_924021.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021096", "story_v_side_old_924021.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_12 = math.max(var_407_5, arg_404_1.talkMaxDuration)

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_12 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_4) / var_407_12

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_4 + var_407_12 and arg_404_1.time_ < var_407_4 + var_407_12 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play924021097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 924021097
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play924021098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos102003ui_story = arg_408_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_411_0 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 then
				arg_408_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_408_1.time_ - 0) / var_411_0)
				arg_408_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["102003ui_story"].transform.position).z)
				arg_408_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["102003ui_story"].transform.localEulerAngles = arg_408_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 then
				arg_408_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_408_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_408_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_408_1.actors_["102003ui_story"].transform.position).z)
				arg_408_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_408_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_408_1.actors_["102003ui_story"].transform.localEulerAngles = arg_408_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_411_1 = arg_408_1.actors_["102003ui_story"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect102003ui_story == nil then
				arg_408_1.var_.characterEffect102003ui_story = var_411_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_2 and not isNil(var_411_1) then
				if arg_408_1.var_.characterEffect102003ui_story and not isNil(var_411_1) then
					arg_408_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_408_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_2)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_2 and arg_408_1.time_ < 0 + var_411_2 + arg_411_0 and not isNil(var_411_1) and arg_408_1.var_.characterEffect102003ui_story then
				arg_408_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_408_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_408_1.time_ and arg_408_1.time_ <= 0.034000001847744 + arg_411_0 then
				arg_408_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_hug", "")
			end

			local var_411_4 = 0
			local var_411_5 = 0.825

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_6 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(924021097).content)

				arg_408_1.text_.text = var_411_6

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_8 = 33 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_6) / 33)

				if (33 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_6) / 33)) > 0 and var_411_5 < var_411_8 then
					arg_408_1.talkMaxDuration = var_411_8

					if var_411_8 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_8 + var_411_4
					end
				end

				arg_408_1.text_.text = var_411_6
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_9 = math.max(var_411_5, arg_408_1.talkMaxDuration)

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_9 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_4) / var_411_9

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_4 + var_411_9 and arg_408_1.time_ < var_411_4 + var_411_9 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play924021098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 924021098
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play924021099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_415_0 = 0.6

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				local var_415_1, var_415_2 = math.modf((arg_412_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_415_2 * 0.13, var_415_2 * 0.13, var_415_2 * 0.13) + arg_412_1.var_.shakeOldPos
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				manager.ui.mainCamera.transform.localPosition = arg_412_1.var_.shakeOldPos
			end

			local var_415_3 = 0

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_3 + arg_415_0 then
				arg_412_1.allBtn_.enabled = false
			end

			if arg_412_1.time_ >= var_415_3 + 0.6 and arg_412_1.time_ < var_415_3 + 0.6 + arg_415_0 then
				arg_412_1.allBtn_.enabled = true
			end

			local var_415_4 = 0
			local var_415_5 = 0.2

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_4 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_6 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(924021098).content)

				arg_412_1.text_.text = var_415_6

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_8 = 8 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_6) / 8)

				if (8 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_6) / 8)) > 0 and var_415_5 < var_415_8 then
					arg_412_1.talkMaxDuration = var_415_8

					if var_415_8 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_4
					end
				end

				arg_412_1.text_.text = var_415_6
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_9 = math.max(var_415_5, arg_412_1.talkMaxDuration)

			if var_415_4 <= arg_412_1.time_ and arg_412_1.time_ < var_415_4 + var_415_9 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_4) / var_415_9

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_4 + var_415_9 and arg_412_1.time_ < var_415_4 + var_415_9 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play924021099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 924021099
		arg_416_1.duration_ = 2.83

		local var_416_0 = {
			zh = 2.066,
			ja = 2.833
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play924021100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos102003ui_story = arg_416_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_419_0 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 then
				arg_416_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_416_1.time_ - 0) / var_419_0)
				arg_416_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["102003ui_story"].transform.position).z)
				arg_416_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["102003ui_story"].transform.localEulerAngles = arg_416_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 then
				arg_416_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_416_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["102003ui_story"].transform.position).z)
				arg_416_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["102003ui_story"].transform.localEulerAngles = arg_416_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_419_1 = arg_416_1.actors_["102003ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect102003ui_story == nil then
				arg_416_1.var_.characterEffect102003ui_story = var_419_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_2 and not isNil(var_419_1) then
				if arg_416_1.var_.characterEffect102003ui_story and not isNil(var_419_1) then
					arg_416_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= 0 + var_419_2 and arg_416_1.time_ < 0 + var_419_2 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect102003ui_story then
				arg_416_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action2_2")
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_419_4 = 0
			local var_419_5 = 0.25

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_4 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_6 = arg_416_1:GetWordFromCfg(924021099)
				local var_419_7 = arg_416_1:FormatText(var_419_6.content)

				arg_416_1.text_.text = var_419_7

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_9 = 10 <= 0 and var_419_5 or var_419_5 * (utf8.len(var_419_7) / 10)

				if (10 <= 0 and var_419_5 or var_419_5 * (utf8.len(var_419_7) / 10)) > 0 and var_419_5 < var_419_9 then
					arg_416_1.talkMaxDuration = var_419_9

					if var_419_9 + var_419_4 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_9 + var_419_4
					end
				end

				arg_416_1.text_.text = var_419_7
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021099", "story_v_side_old_924021.awb") ~= 0 then
					local var_419_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021099", "story_v_side_old_924021.awb") / 1000

					if var_419_10 + var_419_4 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_10 + var_419_4
					end

					if var_419_6.prefab_name ~= "" and arg_416_1.actors_[var_419_6.prefab_name] ~= nil then
						local var_419_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_6.prefab_name].transform, "story_v_side_old_924021", "924021099", "story_v_side_old_924021.awb")

						arg_416_1:RecordAudio("924021099", var_419_11)
						arg_416_1:RecordAudio("924021099", var_419_11)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021099", "story_v_side_old_924021.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021099", "story_v_side_old_924021.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_12 = math.max(var_419_5, arg_416_1.talkMaxDuration)

			if var_419_4 <= arg_416_1.time_ and arg_416_1.time_ < var_419_4 + var_419_12 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_4) / var_419_12

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_4 + var_419_12 and arg_416_1.time_ < var_419_4 + var_419_12 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play924021100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 924021100
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play924021101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos102003ui_story = arg_420_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_423_0 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 then
				arg_420_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_420_1.time_ - 0) / var_423_0)
				arg_420_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["102003ui_story"].transform.position).z)
				arg_420_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["102003ui_story"].transform.localEulerAngles = arg_420_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 then
				arg_420_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_420_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["102003ui_story"].transform.position).z)
				arg_420_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["102003ui_story"].transform.localEulerAngles = arg_420_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_423_1 = arg_420_1.actors_["102003ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect102003ui_story == nil then
				arg_420_1.var_.characterEffect102003ui_story = var_423_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_2 and not isNil(var_423_1) then
				if arg_420_1.var_.characterEffect102003ui_story and not isNil(var_423_1) then
					arg_420_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_420_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_420_1.time_ - 0) / var_423_2)
				end
			end

			if arg_420_1.time_ >= 0 + var_423_2 and arg_420_1.time_ < 0 + var_423_2 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect102003ui_story then
				arg_420_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_420_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_423_3 = 0
			local var_423_4 = 1.05

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_3 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_5 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(924021100).content)

				arg_420_1.text_.text = var_423_5

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_7 = 42 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_5) / 42)

				if (42 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_5) / 42)) > 0 and var_423_4 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_3 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_3
					end
				end

				arg_420_1.text_.text = var_423_5
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_8 = math.max(var_423_4, arg_420_1.talkMaxDuration)

			if var_423_3 <= arg_420_1.time_ and arg_420_1.time_ < var_423_3 + var_423_8 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_3) / var_423_8

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_3 + var_423_8 and arg_420_1.time_ < var_423_3 + var_423_8 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play924021101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 924021101
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play924021102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0.4

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_1 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(924021101).content)

				arg_424_1.text_.text = var_427_1

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_3 = 16 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 16)

				if (16 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 16)) > 0 and var_427_0 < var_427_3 then
					arg_424_1.talkMaxDuration = var_427_3

					if var_427_3 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_3 + 0
					end
				end

				arg_424_1.text_.text = var_427_1
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_4 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_4

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play924021102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 924021102
		arg_428_1.duration_ = 2.1

		local var_428_0 = {
			zh = 2.1,
			ja = 1.999999999999
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play924021103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos102003ui_story = arg_428_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_431_0 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 then
				arg_428_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_428_1.time_ - 0) / var_431_0)
				arg_428_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["102003ui_story"].transform.position).z)
				arg_428_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["102003ui_story"].transform.localEulerAngles = arg_428_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 then
				arg_428_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_428_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["102003ui_story"].transform.position).z)
				arg_428_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["102003ui_story"].transform.localEulerAngles = arg_428_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_431_1 = arg_428_1.actors_["102003ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect102003ui_story == nil then
				arg_428_1.var_.characterEffect102003ui_story = var_431_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_2 and not isNil(var_431_1) then
				if arg_428_1.var_.characterEffect102003ui_story and not isNil(var_431_1) then
					arg_428_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_2 and arg_428_1.time_ < 0 + var_431_2 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect102003ui_story then
				arg_428_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_431_4 = 0
			local var_431_5 = 0.125

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_6 = arg_428_1:GetWordFromCfg(924021102)
				local var_431_7 = arg_428_1:FormatText(var_431_6.content)

				arg_428_1.text_.text = var_431_7

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_9 = 5 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_7) / 5)

				if (5 <= 0 and var_431_5 or var_431_5 * (utf8.len(var_431_7) / 5)) > 0 and var_431_5 < var_431_9 then
					arg_428_1.talkMaxDuration = var_431_9

					if var_431_9 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_9 + var_431_4
					end
				end

				arg_428_1.text_.text = var_431_7
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021102", "story_v_side_old_924021.awb") ~= 0 then
					local var_431_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021102", "story_v_side_old_924021.awb") / 1000

					if var_431_10 + var_431_4 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_10 + var_431_4
					end

					if var_431_6.prefab_name ~= "" and arg_428_1.actors_[var_431_6.prefab_name] ~= nil then
						local var_431_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_6.prefab_name].transform, "story_v_side_old_924021", "924021102", "story_v_side_old_924021.awb")

						arg_428_1:RecordAudio("924021102", var_431_11)
						arg_428_1:RecordAudio("924021102", var_431_11)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021102", "story_v_side_old_924021.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021102", "story_v_side_old_924021.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_12 = math.max(var_431_5, arg_428_1.talkMaxDuration)

			if var_431_4 <= arg_428_1.time_ and arg_428_1.time_ < var_431_4 + var_431_12 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_4) / var_431_12

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_4 + var_431_12 and arg_428_1.time_ < var_431_4 + var_431_12 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play924021103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 924021103
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play924021104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["102003ui_story"]) and arg_432_1.var_.characterEffect102003ui_story == nil then
				arg_432_1.var_.characterEffect102003ui_story = arg_432_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["102003ui_story"]) then
				if arg_432_1.var_.characterEffect102003ui_story and not isNil(arg_432_1.actors_["102003ui_story"]) then
					arg_432_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_432_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_0)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["102003ui_story"]) and arg_432_1.var_.characterEffect102003ui_story then
				arg_432_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_432_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_435_1 = 0
			local var_435_2 = 0.175

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(924021103).content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 7 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 7)

				if (7 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 7)) > 0 and var_435_2 < var_435_5 then
					arg_432_1.talkMaxDuration = var_435_5

					if var_435_5 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + var_435_1
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_6 = math.max(var_435_2, arg_432_1.talkMaxDuration)

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_6 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_1) / var_435_6

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_1 + var_435_6 and arg_432_1.time_ < var_435_1 + var_435_6 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play924021104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 924021104
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play924021105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos102003ui_story = arg_436_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_439_0 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 then
				arg_436_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_436_1.time_ - 0) / var_439_0)
				arg_436_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["102003ui_story"].transform.position).z)
				arg_436_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["102003ui_story"].transform.localEulerAngles = arg_436_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 then
				arg_436_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_436_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["102003ui_story"].transform.position).z)
				arg_436_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["102003ui_story"].transform.localEulerAngles = arg_436_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_439_1 = 0
			local var_439_2 = 1.175

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_3 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(924021104).content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 47 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 47)

				if (47 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 47)) > 0 and var_439_2 < var_439_5 then
					arg_436_1.talkMaxDuration = var_439_5

					if var_439_5 + var_439_1 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + var_439_1
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_6 = math.max(var_439_2, arg_436_1.talkMaxDuration)

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_6 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_1) / var_439_6

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_1 + var_439_6 and arg_436_1.time_ < var_439_1 + var_439_6 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924021105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 924021105
		arg_440_1.duration_ = 6.9

		local var_440_0 = {
			zh = 5.233,
			ja = 6.9
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play924021106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos102003ui_story = arg_440_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_443_0 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 then
				arg_440_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_440_1.time_ - 0) / var_443_0)
				arg_440_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["102003ui_story"].transform.position).z)
				arg_440_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["102003ui_story"].transform.localEulerAngles = arg_440_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 then
				arg_440_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_440_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["102003ui_story"].transform.position).z)
				arg_440_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["102003ui_story"].transform.localEulerAngles = arg_440_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_443_1 = arg_440_1.actors_["102003ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect102003ui_story == nil then
				arg_440_1.var_.characterEffect102003ui_story = var_443_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_2 and not isNil(var_443_1) then
				if arg_440_1.var_.characterEffect102003ui_story and not isNil(var_443_1) then
					arg_440_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_2 and arg_440_1.time_ < 0 + var_443_2 + arg_443_0 and not isNil(var_443_1) and arg_440_1.var_.characterEffect102003ui_story then
				arg_440_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			local var_443_4 = 0
			local var_443_5 = 0.6

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_6 = arg_440_1:GetWordFromCfg(924021105)
				local var_443_7 = arg_440_1:FormatText(var_443_6.content)

				arg_440_1.text_.text = var_443_7

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_9 = 24 <= 0 and var_443_5 or var_443_5 * (utf8.len(var_443_7) / 24)

				if (24 <= 0 and var_443_5 or var_443_5 * (utf8.len(var_443_7) / 24)) > 0 and var_443_5 < var_443_9 then
					arg_440_1.talkMaxDuration = var_443_9

					if var_443_9 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_9 + var_443_4
					end
				end

				arg_440_1.text_.text = var_443_7
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021105", "story_v_side_old_924021.awb") ~= 0 then
					local var_443_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021105", "story_v_side_old_924021.awb") / 1000

					if var_443_10 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_10 + var_443_4
					end

					if var_443_6.prefab_name ~= "" and arg_440_1.actors_[var_443_6.prefab_name] ~= nil then
						local var_443_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_6.prefab_name].transform, "story_v_side_old_924021", "924021105", "story_v_side_old_924021.awb")

						arg_440_1:RecordAudio("924021105", var_443_11)
						arg_440_1:RecordAudio("924021105", var_443_11)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021105", "story_v_side_old_924021.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021105", "story_v_side_old_924021.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_12 = math.max(var_443_5, arg_440_1.talkMaxDuration)

			if var_443_4 <= arg_440_1.time_ and arg_440_1.time_ < var_443_4 + var_443_12 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_4) / var_443_12

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_4 + var_443_12 and arg_440_1.time_ < var_443_4 + var_443_12 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play924021106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 924021106
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play924021107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["102003ui_story"]) and arg_444_1.var_.characterEffect102003ui_story == nil then
				arg_444_1.var_.characterEffect102003ui_story = arg_444_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_0 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["102003ui_story"]) then
				if arg_444_1.var_.characterEffect102003ui_story and not isNil(arg_444_1.actors_["102003ui_story"]) then
					arg_444_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_444_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_0)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["102003ui_story"]) and arg_444_1.var_.characterEffect102003ui_story then
				arg_444_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_444_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_447_1 = 0
			local var_447_2 = 0.475

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_3 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(924021106).content)

				arg_444_1.text_.text = var_447_3

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 19 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_3) / 19)

				if (19 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_3) / 19)) > 0 and var_447_2 < var_447_5 then
					arg_444_1.talkMaxDuration = var_447_5

					if var_447_5 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_5 + var_447_1
					end
				end

				arg_444_1.text_.text = var_447_3
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_6 = math.max(var_447_2, arg_444_1.talkMaxDuration)

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_6 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_1) / var_447_6

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_1 + var_447_6 and arg_444_1.time_ < var_447_1 + var_447_6 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play924021107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 924021107
		arg_448_1.duration_ = 6.13

		local var_448_0 = {
			zh = 4.3,
			ja = 6.133
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
				arg_448_0:Play924021108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["102003ui_story"]) and arg_448_1.var_.characterEffect102003ui_story == nil then
				arg_448_1.var_.characterEffect102003ui_story = arg_448_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["102003ui_story"]) then
				if arg_448_1.var_.characterEffect102003ui_story and not isNil(arg_448_1.actors_["102003ui_story"]) then
					arg_448_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["102003ui_story"]) and arg_448_1.var_.characterEffect102003ui_story then
				arg_448_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action4812")
			end

			local var_451_2 = 0
			local var_451_3 = 0.575

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_2 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_4 = arg_448_1:GetWordFromCfg(924021107)
				local var_451_5 = arg_448_1:FormatText(var_451_4.content)

				arg_448_1.text_.text = var_451_5

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_7 = 23 <= 0 and var_451_3 or var_451_3 * (utf8.len(var_451_5) / 23)

				if (23 <= 0 and var_451_3 or var_451_3 * (utf8.len(var_451_5) / 23)) > 0 and var_451_3 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_2
					end
				end

				arg_448_1.text_.text = var_451_5
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021107", "story_v_side_old_924021.awb") ~= 0 then
					local var_451_8 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021107", "story_v_side_old_924021.awb") / 1000

					if var_451_8 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_8 + var_451_2
					end

					if var_451_4.prefab_name ~= "" and arg_448_1.actors_[var_451_4.prefab_name] ~= nil then
						local var_451_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_4.prefab_name].transform, "story_v_side_old_924021", "924021107", "story_v_side_old_924021.awb")

						arg_448_1:RecordAudio("924021107", var_451_9)
						arg_448_1:RecordAudio("924021107", var_451_9)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021107", "story_v_side_old_924021.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021107", "story_v_side_old_924021.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_10 = math.max(var_451_3, arg_448_1.talkMaxDuration)

			if var_451_2 <= arg_448_1.time_ and arg_448_1.time_ < var_451_2 + var_451_10 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_2) / var_451_10

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_2 + var_451_10 and arg_448_1.time_ < var_451_2 + var_451_10 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play924021108 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 924021108
		arg_452_1.duration_ = 9

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play924021109(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 2 < arg_452_1.time_ and arg_452_1.time_ <= 2 + arg_455_0 then
				local var_455_0 = arg_452_1.bgs_.STblack

				arg_452_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_455_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_455_1 = var_455_0:GetComponent("SpriteRenderer")

				if var_455_1 and var_455_1.sprite then
					local var_455_2 = 2 * (var_455_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_455_0.transform.localScale = Vector3.New(var_455_2 / var_455_1.sprite.bounds.size.y < var_455_2 * manager.ui.mainCameraCom_.aspect / var_455_1.sprite.bounds.size.x and var_455_2 * manager.ui.mainCameraCom_.aspect / var_455_1.sprite.bounds.size.x or var_455_2 / var_455_1.sprite.bounds.size.y, var_455_2 / var_455_1.sprite.bounds.size.y < var_455_2 * manager.ui.mainCameraCom_.aspect / var_455_1.sprite.bounds.size.x and var_455_2 * manager.ui.mainCameraCom_.aspect / var_455_1.sprite.bounds.size.x or var_455_2 / var_455_1.sprite.bounds.size.y, 0)
				end

				for iter_455_0, iter_455_1 in pairs(arg_452_1.bgs_) do
					if iter_455_0 ~= "STblack" then
						iter_455_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_455_3 = 4

			if 4 < arg_452_1.time_ and arg_452_1.time_ <= var_455_3 + arg_455_0 then
				arg_452_1.allBtn_.enabled = false
			end

			if arg_452_1.time_ >= var_455_3 + 0.3 and arg_452_1.time_ < var_455_3 + 0.3 + arg_455_0 then
				arg_452_1.allBtn_.enabled = true
			end

			local var_455_4 = 0

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_4 + arg_455_0 then
				arg_452_1.mask_.enabled = true
				arg_452_1.mask_.raycastTarget = true

				arg_452_1:SetGaussion(false)
			end

			local var_455_5 = 2

			if var_455_4 <= arg_452_1.time_ and arg_452_1.time_ < var_455_4 + var_455_5 then
				local var_455_6 = Color.New(0, 0, 0)

				var_455_6.a = Mathf.Lerp(0, 1, (arg_452_1.time_ - var_455_4) / var_455_5)
				arg_452_1.mask_.color = var_455_6
			end

			if arg_452_1.time_ >= var_455_4 + var_455_5 and arg_452_1.time_ < var_455_4 + var_455_5 + arg_455_0 then
				local var_455_7 = Color.New(0, 0, 0)

				var_455_7.a = 1
				arg_452_1.mask_.color = var_455_7
			end

			local var_455_8 = 2

			if 2 < arg_452_1.time_ and arg_452_1.time_ <= var_455_8 + arg_455_0 then
				arg_452_1.mask_.enabled = true
				arg_452_1.mask_.raycastTarget = true

				arg_452_1:SetGaussion(false)
			end

			local var_455_9 = 2

			if var_455_8 <= arg_452_1.time_ and arg_452_1.time_ < var_455_8 + var_455_9 then
				local var_455_10 = Color.New(0, 0, 0)

				var_455_10.a = Mathf.Lerp(1, 0, (arg_452_1.time_ - var_455_8) / var_455_9)
				arg_452_1.mask_.color = var_455_10
			end

			if arg_452_1.time_ >= var_455_8 + var_455_9 and arg_452_1.time_ < var_455_8 + var_455_9 + arg_455_0 then
				local var_455_11 = Color.New(0, 0, 0)

				arg_452_1.mask_.enabled = false
				var_455_11.a = 0
				arg_452_1.mask_.color = var_455_11
			end

			local var_455_12 = arg_452_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_452_1.time_ and arg_452_1.time_ <= 1.96599999815226 + arg_455_0 then
				arg_452_1.var_.moveOldPos102003ui_story = var_455_12.localPosition
			end

			local var_455_13 = 0.001

			if 1.96599999815226 <= arg_452_1.time_ and arg_452_1.time_ < 1.96599999815226 + var_455_13 then
				var_455_12.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_452_1.time_ - 1.96599999815226) / var_455_13)
				var_455_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_455_12.position).x, (manager.ui.mainCamera.transform.position - var_455_12.position).y, (manager.ui.mainCamera.transform.position - var_455_12.position).z)
				var_455_12.localEulerAngles.z = 0
				var_455_12.localEulerAngles.x = 0
				var_455_12.localEulerAngles = var_455_12.localEulerAngles
			end

			if arg_452_1.time_ >= 1.96599999815226 + var_455_13 and arg_452_1.time_ < 1.96599999815226 + var_455_13 + arg_455_0 then
				var_455_12.localPosition = Vector3.New(0, 100, 0)
				var_455_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_455_12.position).x, (manager.ui.mainCamera.transform.position - var_455_12.position).y, (manager.ui.mainCamera.transform.position - var_455_12.position).z)
				var_455_12.localEulerAngles.z = 0
				var_455_12.localEulerAngles.x = 0
				var_455_12.localEulerAngles = var_455_12.localEulerAngles
			end

			local var_455_14 = arg_452_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_452_1.time_ and arg_452_1.time_ <= 1.96599999815226 + arg_455_0 and not isNil(var_455_14) and arg_452_1.var_.characterEffect102003ui_story == nil then
				arg_452_1.var_.characterEffect102003ui_story = var_455_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_15 = 0.034000001847744

			if 1.96599999815226 <= arg_452_1.time_ and arg_452_1.time_ < 1.96599999815226 + var_455_15 and not isNil(var_455_14) then
				if arg_452_1.var_.characterEffect102003ui_story and not isNil(var_455_14) then
					arg_452_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_452_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 1.96599999815226) / var_455_15)
				end
			end

			if arg_452_1.time_ >= 1.96599999815226 + var_455_15 and arg_452_1.time_ < 1.96599999815226 + var_455_15 + arg_455_0 and not isNil(var_455_14) and arg_452_1.var_.characterEffect102003ui_story then
				arg_452_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_452_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if arg_452_1.frameCnt_ <= 1 then
				arg_452_1.dialog_:SetActive(false)
			end

			local var_455_16 = 4
			local var_455_17 = 1.15

			if 4 < arg_452_1.time_ and arg_452_1.time_ <= var_455_16 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0

				arg_452_1.dialog_:SetActive(true)

				arg_452_1.dialogCg_.alpha = 0

				local var_455_18 = LeanTween.value(arg_452_1.dialog_, 0, 1, 0.3)

				var_455_18:setOnUpdate(LuaHelper.FloatAction(function(arg_456_0)
					arg_452_1.dialogCg_.alpha = arg_456_0
				end))
				var_455_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_452_1.dialog_)
					var_455_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_452_1.duration_ = arg_452_1.duration_ + 0.3

				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_19 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(924021108).content)

				arg_452_1.text_.text = var_455_19

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_21 = 46 <= 0 and var_455_17 or var_455_17 * (utf8.len(var_455_19) / 46)

				if (46 <= 0 and var_455_17 or var_455_17 * (utf8.len(var_455_19) / 46)) > 0 and var_455_17 < var_455_21 then
					arg_452_1.talkMaxDuration = var_455_21
					var_455_16 = var_455_16 + 0.3

					if var_455_21 + var_455_16 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_21 + var_455_16
					end
				end

				arg_452_1.text_.text = var_455_19
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_22 = var_455_16 + 0.3
			local var_455_23 = math.max(var_455_17, arg_452_1.talkMaxDuration)

			if var_455_16 + 0.3 <= arg_452_1.time_ and arg_452_1.time_ < var_455_22 + var_455_23 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_22) / var_455_23

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_22 + var_455_23 and arg_452_1.time_ < var_455_22 + var_455_23 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play924021109 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 924021109
		arg_458_1.duration_ = 6.97

		local var_458_0 = {
			zh = 5.4,
			ja = 6.966
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play924021110(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				local var_461_0 = arg_458_1.bgs_.X204_g

				arg_458_1.bgs_.X204_g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_461_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_461_1 = var_461_0:GetComponent("SpriteRenderer")

				if var_461_1 and var_461_1.sprite then
					local var_461_2 = 2 * (var_461_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_461_0.transform.localScale = Vector3.New(var_461_2 / var_461_1.sprite.bounds.size.y < var_461_2 * manager.ui.mainCameraCom_.aspect / var_461_1.sprite.bounds.size.x and var_461_2 * manager.ui.mainCameraCom_.aspect / var_461_1.sprite.bounds.size.x or var_461_2 / var_461_1.sprite.bounds.size.y, var_461_2 / var_461_1.sprite.bounds.size.y < var_461_2 * manager.ui.mainCameraCom_.aspect / var_461_1.sprite.bounds.size.x and var_461_2 * manager.ui.mainCameraCom_.aspect / var_461_1.sprite.bounds.size.x or var_461_2 / var_461_1.sprite.bounds.size.y, 0)
				end

				for iter_461_0, iter_461_1 in pairs(arg_458_1.bgs_) do
					if iter_461_0 ~= "X204_g" then
						iter_461_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_461_3 = 2

			if 2 < arg_458_1.time_ and arg_458_1.time_ <= var_461_3 + arg_461_0 then
				arg_458_1.allBtn_.enabled = false
			end

			if arg_458_1.time_ >= var_461_3 + 0.3 and arg_458_1.time_ < var_461_3 + 0.3 + arg_461_0 then
				arg_458_1.allBtn_.enabled = true
			end

			local var_461_4 = 0

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1.mask_.enabled = true
				arg_458_1.mask_.raycastTarget = true

				arg_458_1:SetGaussion(false)
			end

			local var_461_5 = 2

			if var_461_4 <= arg_458_1.time_ and arg_458_1.time_ < var_461_4 + var_461_5 then
				local var_461_6 = Color.New(0, 0, 0)

				var_461_6.a = Mathf.Lerp(1, 0, (arg_458_1.time_ - var_461_4) / var_461_5)
				arg_458_1.mask_.color = var_461_6
			end

			if arg_458_1.time_ >= var_461_4 + var_461_5 and arg_458_1.time_ < var_461_4 + var_461_5 + arg_461_0 then
				local var_461_7 = Color.New(0, 0, 0)

				arg_458_1.mask_.enabled = false
				var_461_7.a = 0
				arg_458_1.mask_.color = var_461_7
			end

			local var_461_8 = arg_458_1.actors_["102003ui_story"].transform

			if 1.8 < arg_458_1.time_ and arg_458_1.time_ <= 1.8 + arg_461_0 then
				arg_458_1.var_.moveOldPos102003ui_story = var_461_8.localPosition
			end

			local var_461_9 = 0.001

			if 1.8 <= arg_458_1.time_ and arg_458_1.time_ < 1.8 + var_461_9 then
				var_461_8.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_458_1.time_ - 1.8) / var_461_9)
				var_461_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_461_8.position).x, (manager.ui.mainCamera.transform.position - var_461_8.position).y, (manager.ui.mainCamera.transform.position - var_461_8.position).z)
				var_461_8.localEulerAngles.z = 0
				var_461_8.localEulerAngles.x = 0
				var_461_8.localEulerAngles = var_461_8.localEulerAngles
			end

			if arg_458_1.time_ >= 1.8 + var_461_9 and arg_458_1.time_ < 1.8 + var_461_9 + arg_461_0 then
				var_461_8.localPosition = Vector3.New(0, -0.85, -6.21)
				var_461_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_461_8.position).x, (manager.ui.mainCamera.transform.position - var_461_8.position).y, (manager.ui.mainCamera.transform.position - var_461_8.position).z)
				var_461_8.localEulerAngles.z = 0
				var_461_8.localEulerAngles.x = 0
				var_461_8.localEulerAngles = var_461_8.localEulerAngles
			end

			local var_461_10 = arg_458_1.actors_["102003ui_story"]

			if 1.8 < arg_458_1.time_ and arg_458_1.time_ <= 1.8 + arg_461_0 and not isNil(var_461_10) and arg_458_1.var_.characterEffect102003ui_story == nil then
				arg_458_1.var_.characterEffect102003ui_story = var_461_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_11 = 0.200000002980232

			if 1.8 <= arg_458_1.time_ and arg_458_1.time_ < 1.8 + var_461_11 and not isNil(var_461_10) then
				if arg_458_1.var_.characterEffect102003ui_story and not isNil(var_461_10) then
					arg_458_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_458_1.time_ >= 1.8 + var_461_11 and arg_458_1.time_ < 1.8 + var_461_11 + arg_461_0 and not isNil(var_461_10) and arg_458_1.var_.characterEffect102003ui_story then
				arg_458_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 1.8 < arg_458_1.time_ and arg_458_1.time_ <= 1.8 + arg_461_0 then
				arg_458_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action9_1")
			end

			if 1.8 < arg_458_1.time_ and arg_458_1.time_ <= 1.8 + arg_461_0 then
				arg_458_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if arg_458_1.frameCnt_ <= 1 then
				arg_458_1.dialog_:SetActive(false)
			end

			local var_461_13 = 2
			local var_461_14 = 0.375

			if 2 < arg_458_1.time_ and arg_458_1.time_ <= var_461_13 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0

				arg_458_1.dialog_:SetActive(true)

				arg_458_1.dialogCg_.alpha = 0

				local var_461_15 = LeanTween.value(arg_458_1.dialog_, 0, 1, 0.3)

				var_461_15:setOnUpdate(LuaHelper.FloatAction(function(arg_462_0)
					arg_458_1.dialogCg_.alpha = arg_462_0
				end))
				var_461_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_458_1.dialog_)
					var_461_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_458_1.duration_ = arg_458_1.duration_ + 0.3

				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_16 = arg_458_1:GetWordFromCfg(924021109)
				local var_461_17 = arg_458_1:FormatText(var_461_16.content)

				arg_458_1.text_.text = var_461_17

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_19 = 15 <= 0 and var_461_14 or var_461_14 * (utf8.len(var_461_17) / 15)

				if (15 <= 0 and var_461_14 or var_461_14 * (utf8.len(var_461_17) / 15)) > 0 and var_461_14 < var_461_19 then
					arg_458_1.talkMaxDuration = var_461_19
					var_461_13 = var_461_13 + 0.3

					if var_461_19 + var_461_13 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_19 + var_461_13
					end
				end

				arg_458_1.text_.text = var_461_17
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021109", "story_v_side_old_924021.awb") ~= 0 then
					local var_461_20 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021109", "story_v_side_old_924021.awb") / 1000

					if var_461_20 + var_461_13 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_20 + var_461_13
					end

					if var_461_16.prefab_name ~= "" and arg_458_1.actors_[var_461_16.prefab_name] ~= nil then
						local var_461_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_16.prefab_name].transform, "story_v_side_old_924021", "924021109", "story_v_side_old_924021.awb")

						arg_458_1:RecordAudio("924021109", var_461_21)
						arg_458_1:RecordAudio("924021109", var_461_21)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021109", "story_v_side_old_924021.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021109", "story_v_side_old_924021.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_22 = var_461_13 + 0.3
			local var_461_23 = math.max(var_461_14, arg_458_1.talkMaxDuration)

			if var_461_13 + 0.3 <= arg_458_1.time_ and arg_458_1.time_ < var_461_22 + var_461_23 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_22) / var_461_23

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_22 + var_461_23 and arg_458_1.time_ < var_461_22 + var_461_23 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play924021110 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 924021110
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play924021111(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["102003ui_story"]) and arg_464_1.var_.characterEffect102003ui_story == nil then
				arg_464_1.var_.characterEffect102003ui_story = arg_464_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["102003ui_story"]) then
				if arg_464_1.var_.characterEffect102003ui_story and not isNil(arg_464_1.actors_["102003ui_story"]) then
					arg_464_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_464_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_0)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["102003ui_story"]) and arg_464_1.var_.characterEffect102003ui_story then
				arg_464_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_464_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_467_1 = 0
			local var_467_2 = 0.425

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(924021110).content)

				arg_464_1.text_.text = var_467_3

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 17 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 17)

				if (17 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 17)) > 0 and var_467_2 < var_467_5 then
					arg_464_1.talkMaxDuration = var_467_5

					if var_467_5 + var_467_1 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + var_467_1
					end
				end

				arg_464_1.text_.text = var_467_3
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_6 = math.max(var_467_2, arg_464_1.talkMaxDuration)

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_6 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_1) / var_467_6

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_1 + var_467_6 and arg_464_1.time_ < var_467_1 + var_467_6 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play924021111 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 924021111
		arg_468_1.duration_ = 4.3

		local var_468_0 = {
			zh = 2.633,
			ja = 4.3
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
				arg_468_0:Play924021112(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.var_.moveOldPos102003ui_story = arg_468_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_471_0 = 0.001

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 then
				arg_468_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_468_1.time_ - 0) / var_471_0)
				arg_468_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["102003ui_story"].transform.position).z)
				arg_468_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["102003ui_story"].transform.localEulerAngles = arg_468_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 then
				arg_468_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_468_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["102003ui_story"].transform.position).z)
				arg_468_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["102003ui_story"].transform.localEulerAngles = arg_468_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_471_1 = arg_468_1.actors_["102003ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect102003ui_story == nil then
				arg_468_1.var_.characterEffect102003ui_story = var_471_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_2 and not isNil(var_471_1) then
				if arg_468_1.var_.characterEffect102003ui_story and not isNil(var_471_1) then
					arg_468_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= 0 + var_471_2 and arg_468_1.time_ < 0 + var_471_2 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect102003ui_story then
				arg_468_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action9_2")
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_471_4 = 0
			local var_471_5 = 0.275

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_4 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_6 = arg_468_1:GetWordFromCfg(924021111)
				local var_471_7 = arg_468_1:FormatText(var_471_6.content)

				arg_468_1.text_.text = var_471_7

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_9 = 11 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 11)

				if (11 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 11)) > 0 and var_471_5 < var_471_9 then
					arg_468_1.talkMaxDuration = var_471_9

					if var_471_9 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_9 + var_471_4
					end
				end

				arg_468_1.text_.text = var_471_7
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021111", "story_v_side_old_924021.awb") ~= 0 then
					local var_471_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021111", "story_v_side_old_924021.awb") / 1000

					if var_471_10 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_10 + var_471_4
					end

					if var_471_6.prefab_name ~= "" and arg_468_1.actors_[var_471_6.prefab_name] ~= nil then
						local var_471_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_6.prefab_name].transform, "story_v_side_old_924021", "924021111", "story_v_side_old_924021.awb")

						arg_468_1:RecordAudio("924021111", var_471_11)
						arg_468_1:RecordAudio("924021111", var_471_11)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021111", "story_v_side_old_924021.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021111", "story_v_side_old_924021.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_12 = math.max(var_471_5, arg_468_1.talkMaxDuration)

			if var_471_4 <= arg_468_1.time_ and arg_468_1.time_ < var_471_4 + var_471_12 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_4) / var_471_12

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_4 + var_471_12 and arg_468_1.time_ < var_471_4 + var_471_12 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_468_1:InitPlayNodeList()
	end,
	Play924021112 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 924021112
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play924021113(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(arg_472_1.actors_["102003ui_story"]) and arg_472_1.var_.characterEffect102003ui_story == nil then
				arg_472_1.var_.characterEffect102003ui_story = arg_472_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_0 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 and not isNil(arg_472_1.actors_["102003ui_story"]) then
				if arg_472_1.var_.characterEffect102003ui_story and not isNil(arg_472_1.actors_["102003ui_story"]) then
					arg_472_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_472_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_472_1.time_ - 0) / var_475_0)
				end
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 and not isNil(arg_472_1.actors_["102003ui_story"]) and arg_472_1.var_.characterEffect102003ui_story then
				arg_472_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_472_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_475_1 = 0
			local var_475_2 = 0.15

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_3 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(924021112).content)

				arg_472_1.text_.text = var_475_3

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 6 <= 0 and var_475_2 or var_475_2 * (utf8.len(var_475_3) / 6)

				if (6 <= 0 and var_475_2 or var_475_2 * (utf8.len(var_475_3) / 6)) > 0 and var_475_2 < var_475_5 then
					arg_472_1.talkMaxDuration = var_475_5

					if var_475_5 + var_475_1 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + var_475_1
					end
				end

				arg_472_1.text_.text = var_475_3
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_6 = math.max(var_475_2, arg_472_1.talkMaxDuration)

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_6 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_1) / var_475_6

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_1 + var_475_6 and arg_472_1.time_ < var_475_1 + var_475_6 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play924021113 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 924021113
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play924021114(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.var_.moveOldPos102003ui_story = arg_476_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_479_0 = 0.001

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 then
				arg_476_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_476_1.time_ - 0) / var_479_0)
				arg_476_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_476_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_476_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_476_1.actors_["102003ui_story"].transform.position).z)
				arg_476_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_476_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_476_1.actors_["102003ui_story"].transform.localEulerAngles = arg_476_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 then
				arg_476_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_476_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_476_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_476_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_476_1.actors_["102003ui_story"].transform.position).z)
				arg_476_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_476_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_476_1.actors_["102003ui_story"].transform.localEulerAngles = arg_476_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_479_1 = 0
			local var_479_2 = 1.025

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_3 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(924021113).content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 41 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 41)

				if (41 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 41)) > 0 and var_479_2 < var_479_5 then
					arg_476_1.talkMaxDuration = var_479_5

					if var_479_5 + var_479_1 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + var_479_1
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_6 = math.max(var_479_2, arg_476_1.talkMaxDuration)

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_6 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_1) / var_479_6

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_1 + var_479_6 and arg_476_1.time_ < var_479_1 + var_479_6 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_476_1:InitPlayNodeList()
	end,
	Play924021114 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 924021114
		arg_480_1.duration_ = 3.63

		local var_480_0 = {
			zh = 3.066,
			ja = 3.633
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
				arg_480_0:Play924021115(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos102003ui_story = arg_480_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_483_0 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 then
				arg_480_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_480_1.time_ - 0) / var_483_0)
				arg_480_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["102003ui_story"].transform.position).z)
				arg_480_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["102003ui_story"].transform.localEulerAngles = arg_480_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 then
				arg_480_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_480_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["102003ui_story"].transform.position).z)
				arg_480_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["102003ui_story"].transform.localEulerAngles = arg_480_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_483_1 = arg_480_1.actors_["102003ui_story"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_1) and arg_480_1.var_.characterEffect102003ui_story == nil then
				arg_480_1.var_.characterEffect102003ui_story = var_483_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_2 = 0.200000002980232

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_2 and not isNil(var_483_1) then
				if arg_480_1.var_.characterEffect102003ui_story and not isNil(var_483_1) then
					arg_480_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= 0 + var_483_2 and arg_480_1.time_ < 0 + var_483_2 + arg_483_0 and not isNil(var_483_1) and arg_480_1.var_.characterEffect102003ui_story then
				arg_480_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_483_4 = 0
			local var_483_5 = 0.125

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_4 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_6 = arg_480_1:GetWordFromCfg(924021114)
				local var_483_7 = arg_480_1:FormatText(var_483_6.content)

				arg_480_1.text_.text = var_483_7

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_9 = 5 <= 0 and var_483_5 or var_483_5 * (utf8.len(var_483_7) / 5)

				if (5 <= 0 and var_483_5 or var_483_5 * (utf8.len(var_483_7) / 5)) > 0 and var_483_5 < var_483_9 then
					arg_480_1.talkMaxDuration = var_483_9

					if var_483_9 + var_483_4 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_9 + var_483_4
					end
				end

				arg_480_1.text_.text = var_483_7
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021114", "story_v_side_old_924021.awb") ~= 0 then
					local var_483_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021114", "story_v_side_old_924021.awb") / 1000

					if var_483_10 + var_483_4 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_10 + var_483_4
					end

					if var_483_6.prefab_name ~= "" and arg_480_1.actors_[var_483_6.prefab_name] ~= nil then
						local var_483_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_6.prefab_name].transform, "story_v_side_old_924021", "924021114", "story_v_side_old_924021.awb")

						arg_480_1:RecordAudio("924021114", var_483_11)
						arg_480_1:RecordAudio("924021114", var_483_11)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021114", "story_v_side_old_924021.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021114", "story_v_side_old_924021.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_12 = math.max(var_483_5, arg_480_1.talkMaxDuration)

			if var_483_4 <= arg_480_1.time_ and arg_480_1.time_ < var_483_4 + var_483_12 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_4) / var_483_12

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_4 + var_483_12 and arg_480_1.time_ < var_483_4 + var_483_12 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924021115 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 924021115
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play924021116(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(arg_484_1.actors_["102003ui_story"]) and arg_484_1.var_.characterEffect102003ui_story == nil then
				arg_484_1.var_.characterEffect102003ui_story = arg_484_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_0 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 and not isNil(arg_484_1.actors_["102003ui_story"]) then
				if arg_484_1.var_.characterEffect102003ui_story and not isNil(arg_484_1.actors_["102003ui_story"]) then
					arg_484_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_484_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_484_1.time_ - 0) / var_487_0)
				end
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 and not isNil(arg_484_1.actors_["102003ui_story"]) and arg_484_1.var_.characterEffect102003ui_story then
				arg_484_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_484_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_487_1 = 0
			local var_487_2 = 0.075

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_3 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(924021115).content)

				arg_484_1.text_.text = var_487_3

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 3 <= 0 and var_487_2 or var_487_2 * (utf8.len(var_487_3) / 3)

				if (3 <= 0 and var_487_2 or var_487_2 * (utf8.len(var_487_3) / 3)) > 0 and var_487_2 < var_487_5 then
					arg_484_1.talkMaxDuration = var_487_5

					if var_487_5 + var_487_1 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + var_487_1
					end
				end

				arg_484_1.text_.text = var_487_3
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_6 = math.max(var_487_2, arg_484_1.talkMaxDuration)

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_6 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_1) / var_487_6

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_1 + var_487_6 and arg_484_1.time_ < var_487_1 + var_487_6 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play924021116 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 924021116
		arg_488_1.duration_ = 6.9

		local var_488_0 = {
			zh = 4.466,
			ja = 6.9
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
				arg_488_0:Play924021117(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["102003ui_story"]) and arg_488_1.var_.characterEffect102003ui_story == nil then
				arg_488_1.var_.characterEffect102003ui_story = arg_488_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_0 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["102003ui_story"]) then
				if arg_488_1.var_.characterEffect102003ui_story and not isNil(arg_488_1.actors_["102003ui_story"]) then
					arg_488_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["102003ui_story"]) and arg_488_1.var_.characterEffect102003ui_story then
				arg_488_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_2")
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_491_2 = 0
			local var_491_3 = 0.525

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_2 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_4 = arg_488_1:GetWordFromCfg(924021116)
				local var_491_5 = arg_488_1:FormatText(var_491_4.content)

				arg_488_1.text_.text = var_491_5

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_7 = 21 <= 0 and var_491_3 or var_491_3 * (utf8.len(var_491_5) / 21)

				if (21 <= 0 and var_491_3 or var_491_3 * (utf8.len(var_491_5) / 21)) > 0 and var_491_3 < var_491_7 then
					arg_488_1.talkMaxDuration = var_491_7

					if var_491_7 + var_491_2 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_2
					end
				end

				arg_488_1.text_.text = var_491_5
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021116", "story_v_side_old_924021.awb") ~= 0 then
					local var_491_8 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021116", "story_v_side_old_924021.awb") / 1000

					if var_491_8 + var_491_2 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_8 + var_491_2
					end

					if var_491_4.prefab_name ~= "" and arg_488_1.actors_[var_491_4.prefab_name] ~= nil then
						local var_491_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_4.prefab_name].transform, "story_v_side_old_924021", "924021116", "story_v_side_old_924021.awb")

						arg_488_1:RecordAudio("924021116", var_491_9)
						arg_488_1:RecordAudio("924021116", var_491_9)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021116", "story_v_side_old_924021.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021116", "story_v_side_old_924021.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_10 = math.max(var_491_3, arg_488_1.talkMaxDuration)

			if var_491_2 <= arg_488_1.time_ and arg_488_1.time_ < var_491_2 + var_491_10 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_2) / var_491_10

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_2 + var_491_10 and arg_488_1.time_ < var_491_2 + var_491_10 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play924021117 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 924021117
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play924021118(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(arg_492_1.actors_["102003ui_story"]) and arg_492_1.var_.characterEffect102003ui_story == nil then
				arg_492_1.var_.characterEffect102003ui_story = arg_492_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_0 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 and not isNil(arg_492_1.actors_["102003ui_story"]) then
				if arg_492_1.var_.characterEffect102003ui_story and not isNil(arg_492_1.actors_["102003ui_story"]) then
					arg_492_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_492_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_492_1.time_ - 0) / var_495_0)
				end
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 and not isNil(arg_492_1.actors_["102003ui_story"]) and arg_492_1.var_.characterEffect102003ui_story then
				arg_492_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_492_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_495_1 = 0
			local var_495_2 = 0.75

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, true)
				arg_492_1.iconController_:SetSelectedState("hero")

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_3 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(924021117).content)

				arg_492_1.text_.text = var_495_3

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 30 <= 0 and var_495_2 or var_495_2 * (utf8.len(var_495_3) / 30)

				if (30 <= 0 and var_495_2 or var_495_2 * (utf8.len(var_495_3) / 30)) > 0 and var_495_2 < var_495_5 then
					arg_492_1.talkMaxDuration = var_495_5

					if var_495_5 + var_495_1 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_5 + var_495_1
					end
				end

				arg_492_1.text_.text = var_495_3
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_6 = math.max(var_495_2, arg_492_1.talkMaxDuration)

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_6 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_1) / var_495_6

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_1 + var_495_6 and arg_492_1.time_ < var_495_1 + var_495_6 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play924021118 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 924021118
		arg_496_1.duration_ = 5.7

		local var_496_0 = {
			zh = 3.366,
			ja = 5.7
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play924021119(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.var_.moveOldPos102003ui_story = arg_496_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_499_0 = 0.001

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_0 then
				arg_496_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_496_1.time_ - 0) / var_499_0)
				arg_496_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["102003ui_story"].transform.position).z)
				arg_496_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["102003ui_story"].transform.localEulerAngles = arg_496_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_496_1.time_ >= 0 + var_499_0 and arg_496_1.time_ < 0 + var_499_0 + arg_499_0 then
				arg_496_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_496_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_496_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_496_1.actors_["102003ui_story"].transform.position).z)
				arg_496_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_496_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_496_1.actors_["102003ui_story"].transform.localEulerAngles = arg_496_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_499_1 = arg_496_1.actors_["102003ui_story"]

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(var_499_1) and arg_496_1.var_.characterEffect102003ui_story == nil then
				arg_496_1.var_.characterEffect102003ui_story = var_499_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_2 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_2 and not isNil(var_499_1) then
				if arg_496_1.var_.characterEffect102003ui_story and not isNil(var_499_1) then
					arg_496_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_496_1.time_ >= 0 + var_499_2 and arg_496_1.time_ < 0 + var_499_2 + arg_499_0 and not isNil(var_499_1) and arg_496_1.var_.characterEffect102003ui_story then
				arg_496_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_499_4 = 0
			local var_499_5 = 0.4

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_4 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_6 = arg_496_1:GetWordFromCfg(924021118)
				local var_499_7 = arg_496_1:FormatText(var_499_6.content)

				arg_496_1.text_.text = var_499_7

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_9 = 16 <= 0 and var_499_5 or var_499_5 * (utf8.len(var_499_7) / 16)

				if (16 <= 0 and var_499_5 or var_499_5 * (utf8.len(var_499_7) / 16)) > 0 and var_499_5 < var_499_9 then
					arg_496_1.talkMaxDuration = var_499_9

					if var_499_9 + var_499_4 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_9 + var_499_4
					end
				end

				arg_496_1.text_.text = var_499_7
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021118", "story_v_side_old_924021.awb") ~= 0 then
					local var_499_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021118", "story_v_side_old_924021.awb") / 1000

					if var_499_10 + var_499_4 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_10 + var_499_4
					end

					if var_499_6.prefab_name ~= "" and arg_496_1.actors_[var_499_6.prefab_name] ~= nil then
						local var_499_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_6.prefab_name].transform, "story_v_side_old_924021", "924021118", "story_v_side_old_924021.awb")

						arg_496_1:RecordAudio("924021118", var_499_11)
						arg_496_1:RecordAudio("924021118", var_499_11)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021118", "story_v_side_old_924021.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021118", "story_v_side_old_924021.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_12 = math.max(var_499_5, arg_496_1.talkMaxDuration)

			if var_499_4 <= arg_496_1.time_ and arg_496_1.time_ < var_499_4 + var_499_12 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_4) / var_499_12

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_4 + var_499_12 and arg_496_1.time_ < var_499_4 + var_499_12 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play924021119 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 924021119
		arg_500_1.duration_ = 9

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play924021120(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 1.96599999815226 < arg_500_1.time_ and arg_500_1.time_ <= 1.96599999815226 + arg_503_0 then
				arg_500_1.var_.moveOldPos102003ui_story = arg_500_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_503_0 = 0.001

			if 1.96599999815226 <= arg_500_1.time_ and arg_500_1.time_ < 1.96599999815226 + var_503_0 then
				arg_500_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_500_1.time_ - 1.96599999815226) / var_503_0)
				arg_500_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_500_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_500_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_500_1.actors_["102003ui_story"].transform.position).z)
				arg_500_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_500_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_500_1.actors_["102003ui_story"].transform.localEulerAngles = arg_500_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_500_1.time_ >= 1.96599999815226 + var_503_0 and arg_500_1.time_ < 1.96599999815226 + var_503_0 + arg_503_0 then
				arg_500_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_500_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_500_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_500_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_500_1.actors_["102003ui_story"].transform.position).z)
				arg_500_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_500_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_500_1.actors_["102003ui_story"].transform.localEulerAngles = arg_500_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_503_1 = arg_500_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_500_1.time_ and arg_500_1.time_ <= 1.96599999815226 + arg_503_0 and not isNil(var_503_1) and arg_500_1.var_.characterEffect102003ui_story == nil then
				arg_500_1.var_.characterEffect102003ui_story = var_503_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_503_2 = 0.034000001847744

			if 1.96599999815226 <= arg_500_1.time_ and arg_500_1.time_ < 1.96599999815226 + var_503_2 and not isNil(var_503_1) then
				if arg_500_1.var_.characterEffect102003ui_story and not isNil(var_503_1) then
					arg_500_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_500_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_500_1.time_ - 1.96599999815226) / var_503_2)
				end
			end

			if arg_500_1.time_ >= 1.96599999815226 + var_503_2 and arg_500_1.time_ < 1.96599999815226 + var_503_2 + arg_503_0 and not isNil(var_503_1) and arg_500_1.var_.characterEffect102003ui_story then
				arg_500_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_500_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_503_3 = 0

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_3 + arg_503_0 then
				arg_500_1.mask_.enabled = true
				arg_500_1.mask_.raycastTarget = true

				arg_500_1:SetGaussion(false)
			end

			local var_503_4 = 2

			if var_503_3 <= arg_500_1.time_ and arg_500_1.time_ < var_503_3 + var_503_4 then
				local var_503_5 = Color.New(0, 0, 0)

				var_503_5.a = Mathf.Lerp(0, 1, (arg_500_1.time_ - var_503_3) / var_503_4)
				arg_500_1.mask_.color = var_503_5
			end

			if arg_500_1.time_ >= var_503_3 + var_503_4 and arg_500_1.time_ < var_503_3 + var_503_4 + arg_503_0 then
				local var_503_6 = Color.New(0, 0, 0)

				var_503_6.a = 1
				arg_500_1.mask_.color = var_503_6
			end

			local var_503_7 = 2

			if 2 < arg_500_1.time_ and arg_500_1.time_ <= var_503_7 + arg_503_0 then
				arg_500_1.mask_.enabled = true
				arg_500_1.mask_.raycastTarget = true

				arg_500_1:SetGaussion(false)
			end

			local var_503_8 = 2

			if var_503_7 <= arg_500_1.time_ and arg_500_1.time_ < var_503_7 + var_503_8 then
				local var_503_9 = Color.New(0, 0, 0)

				var_503_9.a = Mathf.Lerp(1, 0, (arg_500_1.time_ - var_503_7) / var_503_8)
				arg_500_1.mask_.color = var_503_9
			end

			if arg_500_1.time_ >= var_503_7 + var_503_8 and arg_500_1.time_ < var_503_7 + var_503_8 + arg_503_0 then
				local var_503_10 = Color.New(0, 0, 0)

				arg_500_1.mask_.enabled = false
				var_503_10.a = 0
				arg_500_1.mask_.color = var_503_10
			end

			local var_503_11 = 3.999999999999
			local var_503_12 = 0.725

			if 3.999999999999 < arg_500_1.time_ and arg_500_1.time_ <= var_503_11 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_13 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(924021119).content)

				arg_500_1.text_.text = var_503_13

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_15 = 29 <= 0 and var_503_12 or var_503_12 * (utf8.len(var_503_13) / 29)

				if (29 <= 0 and var_503_12 or var_503_12 * (utf8.len(var_503_13) / 29)) > 0 and var_503_12 < var_503_15 then
					arg_500_1.talkMaxDuration = var_503_15

					if var_503_15 + var_503_11 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_15 + var_503_11
					end
				end

				arg_500_1.text_.text = var_503_13
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_16 = math.max(var_503_12, arg_500_1.talkMaxDuration)

			if var_503_11 <= arg_500_1.time_ and arg_500_1.time_ < var_503_11 + var_503_16 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_11) / var_503_16

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_11 + var_503_16 and arg_500_1.time_ < var_503_11 + var_503_16 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	Play924021120 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 924021120
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play924021121(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0.25

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_1 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(924021120).content)

				arg_504_1.text_.text = var_507_1

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_3 = 10 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 10)

				if (10 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 10)) > 0 and var_507_0 < var_507_3 then
					arg_504_1.talkMaxDuration = var_507_3

					if var_507_3 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_3 + 0
					end
				end

				arg_504_1.text_.text = var_507_1
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_4 = math.max(var_507_0, arg_504_1.talkMaxDuration)

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - 0) / var_507_4

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play924021121 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 924021121
		arg_508_1.duration_ = 4.2

		local var_508_0 = {
			zh = 3.933,
			ja = 4.2
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play924021122(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPos102003ui_story = arg_508_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_511_0 = 0.001

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 then
				arg_508_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_508_1.time_ - 0) / var_511_0)
				arg_508_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).z)
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles = arg_508_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 then
				arg_508_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_508_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).z)
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles = arg_508_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_511_1 = arg_508_1.actors_["102003ui_story"]

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(var_511_1) and arg_508_1.var_.characterEffect102003ui_story == nil then
				arg_508_1.var_.characterEffect102003ui_story = var_511_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_2 = 0.200000002980232

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_2 and not isNil(var_511_1) then
				if arg_508_1.var_.characterEffect102003ui_story and not isNil(var_511_1) then
					arg_508_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= 0 + var_511_2 and arg_508_1.time_ < 0 + var_511_2 + arg_511_0 and not isNil(var_511_1) and arg_508_1.var_.characterEffect102003ui_story then
				arg_508_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action10_1")
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_511_4 = 0
			local var_511_5 = 0.15

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_4 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_6 = arg_508_1:GetWordFromCfg(924021121)
				local var_511_7 = arg_508_1:FormatText(var_511_6.content)

				arg_508_1.text_.text = var_511_7

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_9 = 6 <= 0 and var_511_5 or var_511_5 * (utf8.len(var_511_7) / 6)

				if (6 <= 0 and var_511_5 or var_511_5 * (utf8.len(var_511_7) / 6)) > 0 and var_511_5 < var_511_9 then
					arg_508_1.talkMaxDuration = var_511_9

					if var_511_9 + var_511_4 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_9 + var_511_4
					end
				end

				arg_508_1.text_.text = var_511_7
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021121", "story_v_side_old_924021.awb") ~= 0 then
					local var_511_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021121", "story_v_side_old_924021.awb") / 1000

					if var_511_10 + var_511_4 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_10 + var_511_4
					end

					if var_511_6.prefab_name ~= "" and arg_508_1.actors_[var_511_6.prefab_name] ~= nil then
						local var_511_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_6.prefab_name].transform, "story_v_side_old_924021", "924021121", "story_v_side_old_924021.awb")

						arg_508_1:RecordAudio("924021121", var_511_11)
						arg_508_1:RecordAudio("924021121", var_511_11)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021121", "story_v_side_old_924021.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021121", "story_v_side_old_924021.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_12 = math.max(var_511_5, arg_508_1.talkMaxDuration)

			if var_511_4 <= arg_508_1.time_ and arg_508_1.time_ < var_511_4 + var_511_12 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_4) / var_511_12

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_4 + var_511_12 and arg_508_1.time_ < var_511_4 + var_511_12 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play924021122 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 924021122
		arg_512_1.duration_ = 8.8

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play924021123(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if arg_512_1.bgs_.STbalck == nil then
				local var_515_0 = Object.Instantiate(arg_512_1.paintGo_)

				var_515_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STbalck")
				var_515_0.name = "STbalck"
				var_515_0.transform.parent = arg_512_1.stage_.transform
				var_515_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_512_1.bgs_.STbalck = var_515_0
			end

			if 2 < arg_512_1.time_ and arg_512_1.time_ <= 2 + arg_515_0 then
				local var_515_1 = arg_512_1.bgs_.STbalck

				arg_512_1.bgs_.STbalck.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_515_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_515_2 = var_515_1:GetComponent("SpriteRenderer")

				if var_515_2 and var_515_2.sprite then
					local var_515_3 = 2 * (var_515_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_515_1.transform.localScale = Vector3.New(var_515_3 / var_515_2.sprite.bounds.size.y < var_515_3 * manager.ui.mainCameraCom_.aspect / var_515_2.sprite.bounds.size.x and var_515_3 * manager.ui.mainCameraCom_.aspect / var_515_2.sprite.bounds.size.x or var_515_3 / var_515_2.sprite.bounds.size.y, var_515_3 / var_515_2.sprite.bounds.size.y < var_515_3 * manager.ui.mainCameraCom_.aspect / var_515_2.sprite.bounds.size.x and var_515_3 * manager.ui.mainCameraCom_.aspect / var_515_2.sprite.bounds.size.x or var_515_3 / var_515_2.sprite.bounds.size.y, 0)
				end

				for iter_515_0, iter_515_1 in pairs(arg_512_1.bgs_) do
					if iter_515_0 ~= "STbalck" then
						iter_515_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_515_4 = 3.999999999999

			if 3.999999999999 < arg_512_1.time_ and arg_512_1.time_ <= var_515_4 + arg_515_0 then
				arg_512_1.allBtn_.enabled = false
			end

			if arg_512_1.time_ >= var_515_4 + 0.3 and arg_512_1.time_ < var_515_4 + 0.3 + arg_515_0 then
				arg_512_1.allBtn_.enabled = true
			end

			local var_515_5 = 0

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_5 + arg_515_0 then
				arg_512_1.mask_.enabled = true
				arg_512_1.mask_.raycastTarget = true

				arg_512_1:SetGaussion(false)
			end

			local var_515_6 = 2

			if var_515_5 <= arg_512_1.time_ and arg_512_1.time_ < var_515_5 + var_515_6 then
				local var_515_7 = Color.New(0, 0, 0)

				var_515_7.a = Mathf.Lerp(0, 1, (arg_512_1.time_ - var_515_5) / var_515_6)
				arg_512_1.mask_.color = var_515_7
			end

			if arg_512_1.time_ >= var_515_5 + var_515_6 and arg_512_1.time_ < var_515_5 + var_515_6 + arg_515_0 then
				local var_515_8 = Color.New(0, 0, 0)

				var_515_8.a = 1
				arg_512_1.mask_.color = var_515_8
			end

			local var_515_9 = 1.999999999999

			if 1.999999999999 < arg_512_1.time_ and arg_512_1.time_ <= var_515_9 + arg_515_0 then
				arg_512_1.mask_.enabled = true
				arg_512_1.mask_.raycastTarget = true

				arg_512_1:SetGaussion(false)
			end

			local var_515_10 = 2

			if var_515_9 <= arg_512_1.time_ and arg_512_1.time_ < var_515_9 + var_515_10 then
				local var_515_11 = Color.New(0, 0, 0)

				var_515_11.a = Mathf.Lerp(1, 0, (arg_512_1.time_ - var_515_9) / var_515_10)
				arg_512_1.mask_.color = var_515_11
			end

			if arg_512_1.time_ >= var_515_9 + var_515_10 and arg_512_1.time_ < var_515_9 + var_515_10 + arg_515_0 then
				local var_515_12 = Color.New(0, 0, 0)

				arg_512_1.mask_.enabled = false
				var_515_12.a = 0
				arg_512_1.mask_.color = var_515_12
			end

			local var_515_13 = arg_512_1.actors_["102003ui_story"].transform

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos102003ui_story = var_515_13.localPosition
			end

			local var_515_14 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_14 then
				var_515_13.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_512_1.time_ - 0) / var_515_14)
				var_515_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_515_13.position).x, (manager.ui.mainCamera.transform.position - var_515_13.position).y, (manager.ui.mainCamera.transform.position - var_515_13.position).z)
				var_515_13.localEulerAngles.z = 0
				var_515_13.localEulerAngles.x = 0
				var_515_13.localEulerAngles = var_515_13.localEulerAngles
			end

			if arg_512_1.time_ >= 0 + var_515_14 and arg_512_1.time_ < 0 + var_515_14 + arg_515_0 then
				var_515_13.localPosition = Vector3.New(0, 100, 0)
				var_515_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_515_13.position).x, (manager.ui.mainCamera.transform.position - var_515_13.position).y, (manager.ui.mainCamera.transform.position - var_515_13.position).z)
				var_515_13.localEulerAngles.z = 0
				var_515_13.localEulerAngles.x = 0
				var_515_13.localEulerAngles = var_515_13.localEulerAngles
			end

			local var_515_15 = arg_512_1.actors_["102003ui_story"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_15) and arg_512_1.var_.characterEffect102003ui_story == nil then
				arg_512_1.var_.characterEffect102003ui_story = var_515_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_16 = 0.034000001847744

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_16 and not isNil(var_515_15) then
				if arg_512_1.var_.characterEffect102003ui_story and not isNil(var_515_15) then
					arg_512_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_512_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_512_1.time_ - 0) / var_515_16)
				end
			end

			if arg_512_1.time_ >= 0 + var_515_16 and arg_512_1.time_ < 0 + var_515_16 + arg_515_0 and not isNil(var_515_15) and arg_512_1.var_.characterEffect102003ui_story then
				arg_512_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_512_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_515_17 = manager.ui.mainCamera.transform

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.shakeOldPos = var_515_17.localPosition
			end

			local var_515_18 = 0.6

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_18 then
				local var_515_19, var_515_20 = math.modf((arg_512_1.time_ - 0) / 0.066)

				var_515_17.localPosition = Vector3.New(var_515_20 * 0.13, var_515_20 * 0.13, var_515_20 * 0.13) + arg_512_1.var_.shakeOldPos
			end

			if arg_512_1.time_ >= 0 + var_515_18 and arg_512_1.time_ < 0 + var_515_18 + arg_515_0 then
				var_515_17.localPosition = arg_512_1.var_.shakeOldPos
			end

			if arg_512_1.frameCnt_ <= 1 then
				arg_512_1.dialog_:SetActive(false)
			end

			local var_515_21 = 3.8
			local var_515_22 = 1.025

			if 3.8 < arg_512_1.time_ and arg_512_1.time_ <= var_515_21 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0

				arg_512_1.dialog_:SetActive(true)

				arg_512_1.dialogCg_.alpha = 0

				local var_515_23 = LeanTween.value(arg_512_1.dialog_, 0, 1, 0.3)

				var_515_23:setOnUpdate(LuaHelper.FloatAction(function(arg_516_0)
					arg_512_1.dialogCg_.alpha = arg_516_0
				end))
				var_515_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_512_1.dialog_)
					var_515_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_512_1.duration_ = arg_512_1.duration_ + 0.3

				SetActive(arg_512_1.leftNameGo_, false)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_24 = arg_512_1:FormatText(arg_512_1:GetWordFromCfg(924021122).content)

				arg_512_1.text_.text = var_515_24

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_26 = 41 <= 0 and var_515_22 or var_515_22 * (utf8.len(var_515_24) / 41)

				if (41 <= 0 and var_515_22 or var_515_22 * (utf8.len(var_515_24) / 41)) > 0 and var_515_22 < var_515_26 then
					arg_512_1.talkMaxDuration = var_515_26
					var_515_21 = var_515_21 + 0.3

					if var_515_26 + var_515_21 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_26 + var_515_21
					end
				end

				arg_512_1.text_.text = var_515_24
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_27 = var_515_21 + 0.3
			local var_515_28 = math.max(var_515_22, arg_512_1.talkMaxDuration)

			if var_515_21 + 0.3 <= arg_512_1.time_ and arg_512_1.time_ < var_515_27 + var_515_28 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_27) / var_515_28

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_27 + var_515_28 and arg_512_1.time_ < var_515_27 + var_515_28 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924021123 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 924021123
		arg_518_1.duration_ = 7

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play924021124(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if arg_518_1.bgs_.X204_l == nil then
				local var_521_0 = Object.Instantiate(arg_518_1.paintGo_)

				var_521_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X204_l")
				var_521_0.name = "X204_l"
				var_521_0.transform.parent = arg_518_1.stage_.transform
				var_521_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_518_1.bgs_.X204_l = var_521_0
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				local var_521_1 = arg_518_1.bgs_.X204_l

				arg_518_1.bgs_.X204_l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_521_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_521_2 = var_521_1:GetComponent("SpriteRenderer")

				if var_521_2 and var_521_2.sprite then
					local var_521_3 = 2 * (var_521_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_521_1.transform.localScale = Vector3.New(var_521_3 / var_521_2.sprite.bounds.size.y < var_521_3 * manager.ui.mainCameraCom_.aspect / var_521_2.sprite.bounds.size.x and var_521_3 * manager.ui.mainCameraCom_.aspect / var_521_2.sprite.bounds.size.x or var_521_3 / var_521_2.sprite.bounds.size.y, var_521_3 / var_521_2.sprite.bounds.size.y < var_521_3 * manager.ui.mainCameraCom_.aspect / var_521_2.sprite.bounds.size.x and var_521_3 * manager.ui.mainCameraCom_.aspect / var_521_2.sprite.bounds.size.x or var_521_3 / var_521_2.sprite.bounds.size.y, 0)
				end

				for iter_521_0, iter_521_1 in pairs(arg_518_1.bgs_) do
					if iter_521_0 ~= "X204_l" then
						iter_521_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_521_4 = 1.999999999999

			if 1.999999999999 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.allBtn_.enabled = false
			end

			if arg_518_1.time_ >= var_521_4 + 0.3 and arg_518_1.time_ < var_521_4 + 0.3 + arg_521_0 then
				arg_518_1.allBtn_.enabled = true
			end

			local var_521_5 = 0

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_5 + arg_521_0 then
				arg_518_1.mask_.enabled = true
				arg_518_1.mask_.raycastTarget = true

				arg_518_1:SetGaussion(false)
			end

			local var_521_6 = 2

			if var_521_5 <= arg_518_1.time_ and arg_518_1.time_ < var_521_5 + var_521_6 then
				local var_521_7 = Color.New(0, 0, 0)

				var_521_7.a = Mathf.Lerp(1, 0, (arg_518_1.time_ - var_521_5) / var_521_6)
				arg_518_1.mask_.color = var_521_7
			end

			if arg_518_1.time_ >= var_521_5 + var_521_6 and arg_518_1.time_ < var_521_5 + var_521_6 + arg_521_0 then
				local var_521_8 = Color.New(0, 0, 0)

				arg_518_1.mask_.enabled = false
				var_521_8.a = 0
				arg_518_1.mask_.color = var_521_8
			end

			if arg_518_1.frameCnt_ <= 1 then
				arg_518_1.dialog_:SetActive(false)
			end

			local var_521_9 = 2
			local var_521_10 = 1.125

			if 2 < arg_518_1.time_ and arg_518_1.time_ <= var_521_9 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0

				arg_518_1.dialog_:SetActive(true)

				arg_518_1.dialogCg_.alpha = 0

				local var_521_11 = LeanTween.value(arg_518_1.dialog_, 0, 1, 0.3)

				var_521_11:setOnUpdate(LuaHelper.FloatAction(function(arg_522_0)
					arg_518_1.dialogCg_.alpha = arg_522_0
				end))
				var_521_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_518_1.dialog_)
					var_521_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_518_1.duration_ = arg_518_1.duration_ + 0.3

				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_12 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(924021123).content)

				arg_518_1.text_.text = var_521_12

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_14 = 45 <= 0 and var_521_10 or var_521_10 * (utf8.len(var_521_12) / 45)

				if (45 <= 0 and var_521_10 or var_521_10 * (utf8.len(var_521_12) / 45)) > 0 and var_521_10 < var_521_14 then
					arg_518_1.talkMaxDuration = var_521_14
					var_521_9 = var_521_9 + 0.3

					if var_521_14 + var_521_9 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_14 + var_521_9
					end
				end

				arg_518_1.text_.text = var_521_12
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_15 = var_521_9 + 0.3
			local var_521_16 = math.max(var_521_10, arg_518_1.talkMaxDuration)

			if var_521_9 + 0.3 <= arg_518_1.time_ and arg_518_1.time_ < var_521_15 + var_521_16 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_15) / var_521_16

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_15 + var_521_16 and arg_518_1.time_ < var_521_15 + var_521_16 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play924021124 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 924021124
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play924021125(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0.575

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_1 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(924021124).content)

				arg_524_1.text_.text = var_527_1

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_3 = 23 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 23)

				if (23 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 23)) > 0 and var_527_0 < var_527_3 then
					arg_524_1.talkMaxDuration = var_527_3

					if var_527_3 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_3 + 0
					end
				end

				arg_524_1.text_.text = var_527_1
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_4 = math.max(var_527_0, arg_524_1.talkMaxDuration)

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_4 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - 0) / var_527_4

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= 0 + var_527_4 and arg_524_1.time_ < 0 + var_527_4 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play924021125 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 924021125
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play924021126(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0.125

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(924021125).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 5 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 5)

				if (5 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 5)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play924021126 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 924021126
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play924021127(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.35

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(924021126).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 14 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 14)

				if (14 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 14)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play924021127 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 924021127
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play924021128(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0.725

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_1 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(924021127).content)

				arg_536_1.text_.text = var_539_1

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_3 = 29 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_1) / 29)

				if (29 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_1) / 29)) > 0 and var_539_0 < var_539_3 then
					arg_536_1.talkMaxDuration = var_539_3

					if var_539_3 + 0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_3 + 0
					end
				end

				arg_536_1.text_.text = var_539_1
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_4 = math.max(var_539_0, arg_536_1.talkMaxDuration)

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_4 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - 0) / var_539_4

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= 0 + var_539_4 and arg_536_1.time_ < 0 + var_539_4 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play924021128 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 924021128
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play924021129(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_543_0 = 0
			local var_543_1 = 0.45

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_2 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(924021128).content)

				arg_540_1.text_.text = var_543_2

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 18 <= 0 and var_543_1 or var_543_1 * (utf8.len(var_543_2) / 18)

				if (18 <= 0 and var_543_1 or var_543_1 * (utf8.len(var_543_2) / 18)) > 0 and var_543_1 < var_543_4 then
					arg_540_1.talkMaxDuration = var_543_4

					if var_543_4 + var_543_0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_4 + var_543_0
					end
				end

				arg_540_1.text_.text = var_543_2
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_5 = math.max(var_543_1, arg_540_1.talkMaxDuration)

			if var_543_0 <= arg_540_1.time_ and arg_540_1.time_ < var_543_0 + var_543_5 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_0) / var_543_5

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_0 + var_543_5 and arg_540_1.time_ < var_543_0 + var_543_5 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play924021129 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 924021129
		arg_544_1.duration_ = 7.03

		local var_544_0 = {
			zh = 6.766,
			ja = 7.033
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play924021130(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.var_.moveOldPos102003ui_story = arg_544_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_547_0 = 0.001

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 then
				arg_544_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_544_1.time_ - 0) / var_547_0)
				arg_544_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["102003ui_story"].transform.position).z)
				arg_544_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["102003ui_story"].transform.localEulerAngles = arg_544_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 then
				arg_544_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_544_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_544_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_544_1.actors_["102003ui_story"].transform.position).z)
				arg_544_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_544_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_544_1.actors_["102003ui_story"].transform.localEulerAngles = arg_544_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_547_1 = arg_544_1.actors_["102003ui_story"]

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(var_547_1) and arg_544_1.var_.characterEffect102003ui_story == nil then
				arg_544_1.var_.characterEffect102003ui_story = var_547_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_2 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_2 and not isNil(var_547_1) then
				if arg_544_1.var_.characterEffect102003ui_story and not isNil(var_547_1) then
					arg_544_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_544_1.time_ >= 0 + var_547_2 and arg_544_1.time_ < 0 + var_547_2 + arg_547_0 and not isNil(var_547_1) and arg_544_1.var_.characterEffect102003ui_story then
				arg_544_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action9_1")
			end

			local var_547_4 = 0
			local var_547_5 = 0.475

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_4 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_6 = arg_544_1:GetWordFromCfg(924021129)
				local var_547_7 = arg_544_1:FormatText(var_547_6.content)

				arg_544_1.text_.text = var_547_7

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_9 = 19 <= 0 and var_547_5 or var_547_5 * (utf8.len(var_547_7) / 19)

				if (19 <= 0 and var_547_5 or var_547_5 * (utf8.len(var_547_7) / 19)) > 0 and var_547_5 < var_547_9 then
					arg_544_1.talkMaxDuration = var_547_9

					if var_547_9 + var_547_4 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_9 + var_547_4
					end
				end

				arg_544_1.text_.text = var_547_7
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021129", "story_v_side_old_924021.awb") ~= 0 then
					local var_547_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021129", "story_v_side_old_924021.awb") / 1000

					if var_547_10 + var_547_4 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_10 + var_547_4
					end

					if var_547_6.prefab_name ~= "" and arg_544_1.actors_[var_547_6.prefab_name] ~= nil then
						local var_547_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_6.prefab_name].transform, "story_v_side_old_924021", "924021129", "story_v_side_old_924021.awb")

						arg_544_1:RecordAudio("924021129", var_547_11)
						arg_544_1:RecordAudio("924021129", var_547_11)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021129", "story_v_side_old_924021.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021129", "story_v_side_old_924021.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_12 = math.max(var_547_5, arg_544_1.talkMaxDuration)

			if var_547_4 <= arg_544_1.time_ and arg_544_1.time_ < var_547_4 + var_547_12 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_4) / var_547_12

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_4 + var_547_12 and arg_544_1.time_ < var_547_4 + var_547_12 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_544_1:InitPlayNodeList()
	end,
	Play924021130 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 924021130
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play924021131(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(arg_548_1.actors_["102003ui_story"]) and arg_548_1.var_.characterEffect102003ui_story == nil then
				arg_548_1.var_.characterEffect102003ui_story = arg_548_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_0 = 0.200000002980232

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_0 and not isNil(arg_548_1.actors_["102003ui_story"]) then
				if arg_548_1.var_.characterEffect102003ui_story and not isNil(arg_548_1.actors_["102003ui_story"]) then
					arg_548_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_548_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_548_1.time_ - 0) / var_551_0)
				end
			end

			if arg_548_1.time_ >= 0 + var_551_0 and arg_548_1.time_ < 0 + var_551_0 + arg_551_0 and not isNil(arg_548_1.actors_["102003ui_story"]) and arg_548_1.var_.characterEffect102003ui_story then
				arg_548_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_548_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_551_1 = 0
			local var_551_2 = 0.425

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_3 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(924021130).content)

				arg_548_1.text_.text = var_551_3

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_5 = 17 <= 0 and var_551_2 or var_551_2 * (utf8.len(var_551_3) / 17)

				if (17 <= 0 and var_551_2 or var_551_2 * (utf8.len(var_551_3) / 17)) > 0 and var_551_2 < var_551_5 then
					arg_548_1.talkMaxDuration = var_551_5

					if var_551_5 + var_551_1 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_5 + var_551_1
					end
				end

				arg_548_1.text_.text = var_551_3
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_6 = math.max(var_551_2, arg_548_1.talkMaxDuration)

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_6 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_1) / var_551_6

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_1 + var_551_6 and arg_548_1.time_ < var_551_1 + var_551_6 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play924021131 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 924021131
		arg_552_1.duration_ = 2

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play924021132(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 and not isNil(arg_552_1.actors_["102003ui_story"]) and arg_552_1.var_.characterEffect102003ui_story == nil then
				arg_552_1.var_.characterEffect102003ui_story = arg_552_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_0 = 0.200000002980232

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_0 and not isNil(arg_552_1.actors_["102003ui_story"]) then
				if arg_552_1.var_.characterEffect102003ui_story and not isNil(arg_552_1.actors_["102003ui_story"]) then
					arg_552_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_552_1.time_ >= 0 + var_555_0 and arg_552_1.time_ < 0 + var_555_0 + arg_555_0 and not isNil(arg_552_1.actors_["102003ui_story"]) and arg_552_1.var_.characterEffect102003ui_story then
				arg_552_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action492")
			end

			local var_555_2 = 0
			local var_555_3 = 0.075

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_2 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_4 = arg_552_1:GetWordFromCfg(924021131)
				local var_555_5 = arg_552_1:FormatText(var_555_4.content)

				arg_552_1.text_.text = var_555_5

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_7 = 3 <= 0 and var_555_3 or var_555_3 * (utf8.len(var_555_5) / 3)

				if (3 <= 0 and var_555_3 or var_555_3 * (utf8.len(var_555_5) / 3)) > 0 and var_555_3 < var_555_7 then
					arg_552_1.talkMaxDuration = var_555_7

					if var_555_7 + var_555_2 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_7 + var_555_2
					end
				end

				arg_552_1.text_.text = var_555_5
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021131", "story_v_side_old_924021.awb") ~= 0 then
					local var_555_8 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021131", "story_v_side_old_924021.awb") / 1000

					if var_555_8 + var_555_2 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_8 + var_555_2
					end

					if var_555_4.prefab_name ~= "" and arg_552_1.actors_[var_555_4.prefab_name] ~= nil then
						local var_555_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_4.prefab_name].transform, "story_v_side_old_924021", "924021131", "story_v_side_old_924021.awb")

						arg_552_1:RecordAudio("924021131", var_555_9)
						arg_552_1:RecordAudio("924021131", var_555_9)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021131", "story_v_side_old_924021.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021131", "story_v_side_old_924021.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_10 = math.max(var_555_3, arg_552_1.talkMaxDuration)

			if var_555_2 <= arg_552_1.time_ and arg_552_1.time_ < var_555_2 + var_555_10 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_2) / var_555_10

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_2 + var_555_10 and arg_552_1.time_ < var_555_2 + var_555_10 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play924021132 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 924021132
		arg_556_1.duration_ = 2.93

		local var_556_0 = {
			zh = 2.033,
			ja = 2.933
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play924021133(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.15

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_1 = arg_556_1:GetWordFromCfg(924021132)
				local var_559_2 = arg_556_1:FormatText(var_559_1.content)

				arg_556_1.text_.text = var_559_2

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_4 = 6 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 6)

				if (6 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 6)) > 0 and var_559_0 < var_559_4 then
					arg_556_1.talkMaxDuration = var_559_4

					if var_559_4 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_4 + 0
					end
				end

				arg_556_1.text_.text = var_559_2
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021132", "story_v_side_old_924021.awb") ~= 0 then
					local var_559_5 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021132", "story_v_side_old_924021.awb") / 1000

					if var_559_5 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + 0
					end

					if var_559_1.prefab_name ~= "" and arg_556_1.actors_[var_559_1.prefab_name] ~= nil then
						local var_559_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_1.prefab_name].transform, "story_v_side_old_924021", "924021132", "story_v_side_old_924021.awb")

						arg_556_1:RecordAudio("924021132", var_559_6)
						arg_556_1:RecordAudio("924021132", var_559_6)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021132", "story_v_side_old_924021.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021132", "story_v_side_old_924021.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_7 = math.max(var_559_0, arg_556_1.talkMaxDuration)

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_7 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - 0) / var_559_7

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= 0 + var_559_7 and arg_556_1.time_ < 0 + var_559_7 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play924021133 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 924021133
		arg_560_1.duration_ = 5

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play924021134(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 and not isNil(arg_560_1.actors_["102003ui_story"]) and arg_560_1.var_.characterEffect102003ui_story == nil then
				arg_560_1.var_.characterEffect102003ui_story = arg_560_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_563_0 = 0.200000002980232

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_0 and not isNil(arg_560_1.actors_["102003ui_story"]) then
				if arg_560_1.var_.characterEffect102003ui_story and not isNil(arg_560_1.actors_["102003ui_story"]) then
					arg_560_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_560_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_560_1.time_ - 0) / var_563_0)
				end
			end

			if arg_560_1.time_ >= 0 + var_563_0 and arg_560_1.time_ < 0 + var_563_0 + arg_563_0 and not isNil(arg_560_1.actors_["102003ui_story"]) and arg_560_1.var_.characterEffect102003ui_story then
				arg_560_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_560_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_563_1 = 0
			local var_563_2 = 0.45

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_1 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_3 = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(924021133).content)

				arg_560_1.text_.text = var_563_3

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_5 = 18 <= 0 and var_563_2 or var_563_2 * (utf8.len(var_563_3) / 18)

				if (18 <= 0 and var_563_2 or var_563_2 * (utf8.len(var_563_3) / 18)) > 0 and var_563_2 < var_563_5 then
					arg_560_1.talkMaxDuration = var_563_5

					if var_563_5 + var_563_1 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + var_563_1
					end
				end

				arg_560_1.text_.text = var_563_3
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)
				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_6 = math.max(var_563_2, arg_560_1.talkMaxDuration)

			if var_563_1 <= arg_560_1.time_ and arg_560_1.time_ < var_563_1 + var_563_6 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - var_563_1) / var_563_6

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= var_563_1 + var_563_6 and arg_560_1.time_ < var_563_1 + var_563_6 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play924021134 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 924021134
		arg_564_1.duration_ = 9

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play924021135(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 2 < arg_564_1.time_ and arg_564_1.time_ <= 2 + arg_567_0 then
				local var_567_0 = arg_564_1.bgs_.X204_l

				arg_564_1.bgs_.X204_l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_567_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_567_1 = var_567_0:GetComponent("SpriteRenderer")

				if var_567_1 and var_567_1.sprite then
					local var_567_2 = 2 * (var_567_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_567_0.transform.localScale = Vector3.New(var_567_2 / var_567_1.sprite.bounds.size.y < var_567_2 * manager.ui.mainCameraCom_.aspect / var_567_1.sprite.bounds.size.x and var_567_2 * manager.ui.mainCameraCom_.aspect / var_567_1.sprite.bounds.size.x or var_567_2 / var_567_1.sprite.bounds.size.y, var_567_2 / var_567_1.sprite.bounds.size.y < var_567_2 * manager.ui.mainCameraCom_.aspect / var_567_1.sprite.bounds.size.x and var_567_2 * manager.ui.mainCameraCom_.aspect / var_567_1.sprite.bounds.size.x or var_567_2 / var_567_1.sprite.bounds.size.y, 0)
				end

				for iter_567_0, iter_567_1 in pairs(arg_564_1.bgs_) do
					if iter_567_0 ~= "X204_l" then
						iter_567_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_567_3 = 4

			if 4 < arg_564_1.time_ and arg_564_1.time_ <= var_567_3 + arg_567_0 then
				arg_564_1.allBtn_.enabled = false
			end

			if arg_564_1.time_ >= var_567_3 + 0.3 and arg_564_1.time_ < var_567_3 + 0.3 + arg_567_0 then
				arg_564_1.allBtn_.enabled = true
			end

			local var_567_4 = 0

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_4 + arg_567_0 then
				arg_564_1.mask_.enabled = true
				arg_564_1.mask_.raycastTarget = true

				arg_564_1:SetGaussion(false)
			end

			local var_567_5 = 2

			if var_567_4 <= arg_564_1.time_ and arg_564_1.time_ < var_567_4 + var_567_5 then
				local var_567_6 = Color.New(0, 0, 0)

				var_567_6.a = Mathf.Lerp(0, 1, (arg_564_1.time_ - var_567_4) / var_567_5)
				arg_564_1.mask_.color = var_567_6
			end

			if arg_564_1.time_ >= var_567_4 + var_567_5 and arg_564_1.time_ < var_567_4 + var_567_5 + arg_567_0 then
				local var_567_7 = Color.New(0, 0, 0)

				var_567_7.a = 1
				arg_564_1.mask_.color = var_567_7
			end

			local var_567_8 = 2

			if 2 < arg_564_1.time_ and arg_564_1.time_ <= var_567_8 + arg_567_0 then
				arg_564_1.mask_.enabled = true
				arg_564_1.mask_.raycastTarget = true

				arg_564_1:SetGaussion(false)
			end

			local var_567_9 = 2

			if var_567_8 <= arg_564_1.time_ and arg_564_1.time_ < var_567_8 + var_567_9 then
				local var_567_10 = Color.New(0, 0, 0)

				var_567_10.a = Mathf.Lerp(1, 0, (arg_564_1.time_ - var_567_8) / var_567_9)
				arg_564_1.mask_.color = var_567_10
			end

			if arg_564_1.time_ >= var_567_8 + var_567_9 and arg_564_1.time_ < var_567_8 + var_567_9 + arg_567_0 then
				local var_567_11 = Color.New(0, 0, 0)

				arg_564_1.mask_.enabled = false
				var_567_11.a = 0
				arg_564_1.mask_.color = var_567_11
			end

			local var_567_12 = arg_564_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_564_1.time_ and arg_564_1.time_ <= 1.96599999815226 + arg_567_0 then
				arg_564_1.var_.moveOldPos102003ui_story = var_567_12.localPosition
			end

			local var_567_13 = 0.001

			if 1.96599999815226 <= arg_564_1.time_ and arg_564_1.time_ < 1.96599999815226 + var_567_13 then
				var_567_12.localPosition = Vector3.Lerp(arg_564_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_564_1.time_ - 1.96599999815226) / var_567_13)
				var_567_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_567_12.position).x, (manager.ui.mainCamera.transform.position - var_567_12.position).y, (manager.ui.mainCamera.transform.position - var_567_12.position).z)
				var_567_12.localEulerAngles.z = 0
				var_567_12.localEulerAngles.x = 0
				var_567_12.localEulerAngles = var_567_12.localEulerAngles
			end

			if arg_564_1.time_ >= 1.96599999815226 + var_567_13 and arg_564_1.time_ < 1.96599999815226 + var_567_13 + arg_567_0 then
				var_567_12.localPosition = Vector3.New(0, 100, 0)
				var_567_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_567_12.position).x, (manager.ui.mainCamera.transform.position - var_567_12.position).y, (manager.ui.mainCamera.transform.position - var_567_12.position).z)
				var_567_12.localEulerAngles.z = 0
				var_567_12.localEulerAngles.x = 0
				var_567_12.localEulerAngles = var_567_12.localEulerAngles
			end

			if arg_564_1.frameCnt_ <= 1 then
				arg_564_1.dialog_:SetActive(false)
			end

			local var_567_14 = 4
			local var_567_15 = 0.575

			if 4 < arg_564_1.time_ and arg_564_1.time_ <= var_567_14 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0

				arg_564_1.dialog_:SetActive(true)

				arg_564_1.dialogCg_.alpha = 0

				local var_567_16 = LeanTween.value(arg_564_1.dialog_, 0, 1, 0.3)

				var_567_16:setOnUpdate(LuaHelper.FloatAction(function(arg_568_0)
					arg_564_1.dialogCg_.alpha = arg_568_0
				end))
				var_567_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_564_1.dialog_)
					var_567_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_564_1.duration_ = arg_564_1.duration_ + 0.3

				SetActive(arg_564_1.leftNameGo_, false)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_564_1.iconTrs_.gameObject, false)
				arg_564_1.callingController_:SetSelectedState("normal")

				local var_567_17 = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(924021134).content)

				arg_564_1.text_.text = var_567_17

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_19 = 23 <= 0 and var_567_15 or var_567_15 * (utf8.len(var_567_17) / 23)

				if (23 <= 0 and var_567_15 or var_567_15 * (utf8.len(var_567_17) / 23)) > 0 and var_567_15 < var_567_19 then
					arg_564_1.talkMaxDuration = var_567_19
					var_567_14 = var_567_14 + 0.3

					if var_567_19 + var_567_14 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_19 + var_567_14
					end
				end

				arg_564_1.text_.text = var_567_17
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)
				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_20 = var_567_14 + 0.3
			local var_567_21 = math.max(var_567_15, arg_564_1.talkMaxDuration)

			if var_567_14 + 0.3 <= arg_564_1.time_ and arg_564_1.time_ < var_567_20 + var_567_21 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - var_567_20) / var_567_21

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= var_567_20 + var_567_21 and arg_564_1.time_ < var_567_20 + var_567_21 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_564_1:InitPlayNodeList()
	end,
	Play924021135 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 924021135
		arg_570_1.duration_ = 7.53

		local var_570_0 = {
			zh = 6.4,
			ja = 7.533
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play924021136(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1.var_.moveOldPos102003ui_story = arg_570_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_573_0 = 0.001

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 then
				arg_570_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_570_1.time_ - 0) / var_573_0)
				arg_570_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_570_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["102003ui_story"].transform.position).z)
				arg_570_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_570_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_570_1.actors_["102003ui_story"].transform.localEulerAngles = arg_570_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 then
				arg_570_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_570_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_570_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_570_1.actors_["102003ui_story"].transform.position).z)
				arg_570_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_570_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_570_1.actors_["102003ui_story"].transform.localEulerAngles = arg_570_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_573_1 = arg_570_1.actors_["102003ui_story"]

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(var_573_1) and arg_570_1.var_.characterEffect102003ui_story == nil then
				arg_570_1.var_.characterEffect102003ui_story = var_573_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_2 and not isNil(var_573_1) then
				if arg_570_1.var_.characterEffect102003ui_story and not isNil(var_573_1) then
					arg_570_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= 0 + var_573_2 and arg_570_1.time_ < 0 + var_573_2 + arg_573_0 and not isNil(var_573_1) and arg_570_1.var_.characterEffect102003ui_story then
				arg_570_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action10_1")
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_573_4 = 0
			local var_573_5 = 0.325

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_4 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_6 = arg_570_1:GetWordFromCfg(924021135)
				local var_573_7 = arg_570_1:FormatText(var_573_6.content)

				arg_570_1.text_.text = var_573_7

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_9 = 13 <= 0 and var_573_5 or var_573_5 * (utf8.len(var_573_7) / 13)

				if (13 <= 0 and var_573_5 or var_573_5 * (utf8.len(var_573_7) / 13)) > 0 and var_573_5 < var_573_9 then
					arg_570_1.talkMaxDuration = var_573_9

					if var_573_9 + var_573_4 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_9 + var_573_4
					end
				end

				arg_570_1.text_.text = var_573_7
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021135", "story_v_side_old_924021.awb") ~= 0 then
					local var_573_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021135", "story_v_side_old_924021.awb") / 1000

					if var_573_10 + var_573_4 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_10 + var_573_4
					end

					if var_573_6.prefab_name ~= "" and arg_570_1.actors_[var_573_6.prefab_name] ~= nil then
						local var_573_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_6.prefab_name].transform, "story_v_side_old_924021", "924021135", "story_v_side_old_924021.awb")

						arg_570_1:RecordAudio("924021135", var_573_11)
						arg_570_1:RecordAudio("924021135", var_573_11)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021135", "story_v_side_old_924021.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021135", "story_v_side_old_924021.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_12 = math.max(var_573_5, arg_570_1.talkMaxDuration)

			if var_573_4 <= arg_570_1.time_ and arg_570_1.time_ < var_573_4 + var_573_12 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_4) / var_573_12

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_4 + var_573_12 and arg_570_1.time_ < var_573_4 + var_573_12 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_570_1:InitPlayNodeList()
	end,
	Play924021136 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 924021136
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play924021137(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["102003ui_story"]) and arg_574_1.var_.characterEffect102003ui_story == nil then
				arg_574_1.var_.characterEffect102003ui_story = arg_574_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_0 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["102003ui_story"]) then
				if arg_574_1.var_.characterEffect102003ui_story and not isNil(arg_574_1.actors_["102003ui_story"]) then
					arg_574_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_574_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_574_1.time_ - 0) / var_577_0)
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["102003ui_story"]) and arg_574_1.var_.characterEffect102003ui_story then
				arg_574_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_574_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_577_1 = 0
			local var_577_2 = 0.275

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_3 = arg_574_1:FormatText(arg_574_1:GetWordFromCfg(924021136).content)

				arg_574_1.text_.text = var_577_3

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_5 = 11 <= 0 and var_577_2 or var_577_2 * (utf8.len(var_577_3) / 11)

				if (11 <= 0 and var_577_2 or var_577_2 * (utf8.len(var_577_3) / 11)) > 0 and var_577_2 < var_577_5 then
					arg_574_1.talkMaxDuration = var_577_5

					if var_577_5 + var_577_1 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_5 + var_577_1
					end
				end

				arg_574_1.text_.text = var_577_3
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_6 = math.max(var_577_2, arg_574_1.talkMaxDuration)

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_6 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_1) / var_577_6

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_1 + var_577_6 and arg_574_1.time_ < var_577_1 + var_577_6 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play924021137 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 924021137
		arg_578_1.duration_ = 9.47

		local var_578_0 = {
			zh = 7.066,
			ja = 9.466
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play924021138(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos102003ui_story = arg_578_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_581_0 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 then
				arg_578_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_578_1.time_ - 0) / var_581_0)
				arg_578_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["102003ui_story"].transform.position).z)
				arg_578_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["102003ui_story"].transform.localEulerAngles = arg_578_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 then
				arg_578_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_578_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["102003ui_story"].transform.position).z)
				arg_578_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["102003ui_story"].transform.localEulerAngles = arg_578_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_581_1 = arg_578_1.actors_["102003ui_story"]

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(var_581_1) and arg_578_1.var_.characterEffect102003ui_story == nil then
				arg_578_1.var_.characterEffect102003ui_story = var_581_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_2 and not isNil(var_581_1) then
				if arg_578_1.var_.characterEffect102003ui_story and not isNil(var_581_1) then
					arg_578_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= 0 + var_581_2 and arg_578_1.time_ < 0 + var_581_2 + arg_581_0 and not isNil(var_581_1) and arg_578_1.var_.characterEffect102003ui_story then
				arg_578_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action4108")
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_581_4 = 0
			local var_581_5 = 0.625

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_4 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_6 = arg_578_1:GetWordFromCfg(924021137)
				local var_581_7 = arg_578_1:FormatText(var_581_6.content)

				arg_578_1.text_.text = var_581_7

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_9 = 25 <= 0 and var_581_5 or var_581_5 * (utf8.len(var_581_7) / 25)

				if (25 <= 0 and var_581_5 or var_581_5 * (utf8.len(var_581_7) / 25)) > 0 and var_581_5 < var_581_9 then
					arg_578_1.talkMaxDuration = var_581_9

					if var_581_9 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_9 + var_581_4
					end
				end

				arg_578_1.text_.text = var_581_7
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021137", "story_v_side_old_924021.awb") ~= 0 then
					local var_581_10 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021137", "story_v_side_old_924021.awb") / 1000

					if var_581_10 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_10 + var_581_4
					end

					if var_581_6.prefab_name ~= "" and arg_578_1.actors_[var_581_6.prefab_name] ~= nil then
						local var_581_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_6.prefab_name].transform, "story_v_side_old_924021", "924021137", "story_v_side_old_924021.awb")

						arg_578_1:RecordAudio("924021137", var_581_11)
						arg_578_1:RecordAudio("924021137", var_581_11)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021137", "story_v_side_old_924021.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021137", "story_v_side_old_924021.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_12 = math.max(var_581_5, arg_578_1.talkMaxDuration)

			if var_581_4 <= arg_578_1.time_ and arg_578_1.time_ < var_581_4 + var_581_12 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_4) / var_581_12

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_4 + var_581_12 and arg_578_1.time_ < var_581_4 + var_581_12 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play924021138 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 924021138
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play924021139(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(arg_582_1.actors_["102003ui_story"]) and arg_582_1.var_.characterEffect102003ui_story == nil then
				arg_582_1.var_.characterEffect102003ui_story = arg_582_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_0 = 0.200000002980232

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 and not isNil(arg_582_1.actors_["102003ui_story"]) then
				if arg_582_1.var_.characterEffect102003ui_story and not isNil(arg_582_1.actors_["102003ui_story"]) then
					arg_582_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_582_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_582_1.time_ - 0) / var_585_0)
				end
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 and not isNil(arg_582_1.actors_["102003ui_story"]) and arg_582_1.var_.characterEffect102003ui_story then
				arg_582_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_582_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_585_1 = 0
			local var_585_2 = 0.65

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_3 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(924021138).content)

				arg_582_1.text_.text = var_585_3

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_5 = 26 <= 0 and var_585_2 or var_585_2 * (utf8.len(var_585_3) / 26)

				if (26 <= 0 and var_585_2 or var_585_2 * (utf8.len(var_585_3) / 26)) > 0 and var_585_2 < var_585_5 then
					arg_582_1.talkMaxDuration = var_585_5

					if var_585_5 + var_585_1 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_5 + var_585_1
					end
				end

				arg_582_1.text_.text = var_585_3
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_6 = math.max(var_585_2, arg_582_1.talkMaxDuration)

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_6 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_1) / var_585_6

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_1 + var_585_6 and arg_582_1.time_ < var_585_1 + var_585_6 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play924021139 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 924021139
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play924021140(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.var_.moveOldPos102003ui_story = arg_586_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_589_0 = 0.001

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 then
				arg_586_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_586_1.time_ - 0) / var_589_0)
				arg_586_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_586_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["102003ui_story"].transform.position).z)
				arg_586_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_586_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_586_1.actors_["102003ui_story"].transform.localEulerAngles = arg_586_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 then
				arg_586_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_586_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_586_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["102003ui_story"].transform.position).z)
				arg_586_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_586_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_586_1.actors_["102003ui_story"].transform.localEulerAngles = arg_586_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_589_1 = 0
			local var_589_2 = 1.05

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_3 = arg_586_1:FormatText(arg_586_1:GetWordFromCfg(924021139).content)

				arg_586_1.text_.text = var_589_3

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_5 = 42 <= 0 and var_589_2 or var_589_2 * (utf8.len(var_589_3) / 42)

				if (42 <= 0 and var_589_2 or var_589_2 * (utf8.len(var_589_3) / 42)) > 0 and var_589_2 < var_589_5 then
					arg_586_1.talkMaxDuration = var_589_5

					if var_589_5 + var_589_1 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_5 + var_589_1
					end
				end

				arg_586_1.text_.text = var_589_3
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_6 = math.max(var_589_2, arg_586_1.talkMaxDuration)

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_6 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_1) / var_589_6

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_1 + var_589_6 and arg_586_1.time_ < var_589_1 + var_589_6 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play924021140 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 924021140
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play924021141(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = 0.45

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, true)
				arg_590_1.iconController_:SetSelectedState("hero")

				arg_590_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_590_1.callingController_:SetSelectedState("normal")

				arg_590_1.keyicon_.color = Color.New(1, 1, 1)
				arg_590_1.icon_.color = Color.New(1, 1, 1)

				local var_593_1 = arg_590_1:FormatText(arg_590_1:GetWordFromCfg(924021140).content)

				arg_590_1.text_.text = var_593_1

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_3 = 18 <= 0 and var_593_0 or var_593_0 * (utf8.len(var_593_1) / 18)

				if (18 <= 0 and var_593_0 or var_593_0 * (utf8.len(var_593_1) / 18)) > 0 and var_593_0 < var_593_3 then
					arg_590_1.talkMaxDuration = var_593_3

					if var_593_3 + 0 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_3 + 0
					end
				end

				arg_590_1.text_.text = var_593_1
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_4 = math.max(var_593_0, arg_590_1.talkMaxDuration)

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_4 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - 0) / var_593_4

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= 0 + var_593_4 and arg_590_1.time_ < 0 + var_593_4 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play924021141 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 924021141
		arg_594_1.duration_ = 5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play924021142(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = 0.35

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				arg_594_1.leftNameTxt_.text = arg_594_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, true)
				arg_594_1.iconController_:SetSelectedState("hero")

				arg_594_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_594_1.callingController_:SetSelectedState("normal")

				arg_594_1.keyicon_.color = Color.New(1, 1, 1)
				arg_594_1.icon_.color = Color.New(1, 1, 1)

				local var_597_1 = arg_594_1:FormatText(arg_594_1:GetWordFromCfg(924021141).content)

				arg_594_1.text_.text = var_597_1

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_3 = 14 <= 0 and var_597_0 or var_597_0 * (utf8.len(var_597_1) / 14)

				if (14 <= 0 and var_597_0 or var_597_0 * (utf8.len(var_597_1) / 14)) > 0 and var_597_0 < var_597_3 then
					arg_594_1.talkMaxDuration = var_597_3

					if var_597_3 + 0 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_3 + 0
					end
				end

				arg_594_1.text_.text = var_597_1
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)
				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_4 = math.max(var_597_0, arg_594_1.talkMaxDuration)

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_4 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - 0) / var_597_4

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= 0 + var_597_4 and arg_594_1.time_ < 0 + var_597_4 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play924021142 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 924021142
		arg_598_1.duration_ = 3.9

		local var_598_0 = {
			zh = 3.433,
			ja = 3.9
		}
		local var_598_1 = manager.audio:GetLocalizationFlag()

		if var_598_0[var_598_1] ~= nil then
			arg_598_1.duration_ = var_598_0[var_598_1]
		end

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play924021143(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1.var_.moveOldPos102003ui_story = arg_598_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_601_0 = 0.001

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_0 then
				arg_598_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_598_1.time_ - 0) / var_601_0)
				arg_598_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_598_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["102003ui_story"].transform.position).z)
				arg_598_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_598_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_598_1.actors_["102003ui_story"].transform.localEulerAngles = arg_598_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_598_1.time_ >= 0 + var_601_0 and arg_598_1.time_ < 0 + var_601_0 + arg_601_0 then
				arg_598_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_598_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_598_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_598_1.actors_["102003ui_story"].transform.position).z)
				arg_598_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_598_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_598_1.actors_["102003ui_story"].transform.localEulerAngles = arg_598_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_601_1 = arg_598_1.actors_["102003ui_story"]

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(var_601_1) and arg_598_1.var_.characterEffect102003ui_story == nil then
				arg_598_1.var_.characterEffect102003ui_story = var_601_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_2 = 0.200000002980232

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_2 and not isNil(var_601_1) then
				if arg_598_1.var_.characterEffect102003ui_story and not isNil(var_601_1) then
					arg_598_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_598_1.time_ >= 0 + var_601_2 and arg_598_1.time_ < 0 + var_601_2 + arg_601_0 and not isNil(var_601_1) and arg_598_1.var_.characterEffect102003ui_story then
				arg_598_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_2")
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_601_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_598_1.bgmTxt_.text ~= var_601_6 and arg_598_1.bgmTxt_.text ~= "" then
						if arg_598_1.bgmTxt2_.text ~= "" then
							arg_598_1.bgmTxt_.text = arg_598_1.bgmTxt2_.text
						end

						arg_598_1.bgmTxt2_.text = var_601_6

						arg_598_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_598_1.bgmTxt_.text = var_601_6
						arg_598_1.bgmTxt2_.text = var_601_6
					end

					if arg_598_1.bgmTimer then
						arg_598_1.bgmTimer:Stop()

						arg_598_1.bgmTimer = nil
					end

					if arg_598_1.settingData.show_music_name == 1 then
						arg_598_1.musicController:SetSelectedState("show")
						arg_598_1.musicAnimator_:Play("open", 0, 0)

						if arg_598_1.settingData.music_time ~= 0 then
							arg_598_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_598_1.settingData.music_time), function()
								if arg_598_1 == nil or isNil(arg_598_1.bgmTxt_) then
									return
								end

								arg_598_1.musicController:SetSelectedState("hide")
								arg_598_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_601_7 = 0
			local var_601_8 = 0.225

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_7 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_9 = arg_598_1:GetWordFromCfg(924021142)
				local var_601_10 = arg_598_1:FormatText(var_601_9.content)

				arg_598_1.text_.text = var_601_10

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_12 = 9 <= 0 and var_601_8 or var_601_8 * (utf8.len(var_601_10) / 9)

				if (9 <= 0 and var_601_8 or var_601_8 * (utf8.len(var_601_10) / 9)) > 0 and var_601_8 < var_601_12 then
					arg_598_1.talkMaxDuration = var_601_12

					if var_601_12 + var_601_7 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_12 + var_601_7
					end
				end

				arg_598_1.text_.text = var_601_10
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924021", "924021142", "story_v_side_old_924021.awb") ~= 0 then
					local var_601_13 = manager.audio:GetVoiceLength("story_v_side_old_924021", "924021142", "story_v_side_old_924021.awb") / 1000

					if var_601_13 + var_601_7 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_13 + var_601_7
					end

					if var_601_9.prefab_name ~= "" and arg_598_1.actors_[var_601_9.prefab_name] ~= nil then
						local var_601_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_9.prefab_name].transform, "story_v_side_old_924021", "924021142", "story_v_side_old_924021.awb")

						arg_598_1:RecordAudio("924021142", var_601_14)
						arg_598_1:RecordAudio("924021142", var_601_14)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_old_924021", "924021142", "story_v_side_old_924021.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_old_924021", "924021142", "story_v_side_old_924021.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_15 = math.max(var_601_8, arg_598_1.talkMaxDuration)

			if var_601_7 <= arg_598_1.time_ and arg_598_1.time_ < var_601_7 + var_601_15 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_7) / var_601_15

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_7 + var_601_15 and arg_598_1.time_ < var_601_7 + var_601_15 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_598_1:InitPlayNodeList()
	end,
	Play924021143 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 924021143
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
			arg_603_1.auto_ = false
		end

		function arg_603_1.playNext_(arg_605_0)
			arg_603_1.onStoryFinished_()
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.var_.moveOldPos102003ui_story = arg_603_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_606_0 = 0.001

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 then
				arg_603_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_603_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_603_1.time_ - 0) / var_606_0)
				arg_603_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_603_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_603_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_603_1.actors_["102003ui_story"].transform.position).z)
				arg_603_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_603_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_603_1.actors_["102003ui_story"].transform.localEulerAngles = arg_603_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 then
				arg_603_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_603_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_603_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_603_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_603_1.actors_["102003ui_story"].transform.position).z)
				arg_603_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_603_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_603_1.actors_["102003ui_story"].transform.localEulerAngles = arg_603_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_606_1 = arg_603_1.actors_["102003ui_story"]

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(var_606_1) and arg_603_1.var_.characterEffect102003ui_story == nil then
				arg_603_1.var_.characterEffect102003ui_story = var_606_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_606_2 = 0.200000002980232

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_2 and not isNil(var_606_1) then
				if arg_603_1.var_.characterEffect102003ui_story and not isNil(var_606_1) then
					arg_603_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_603_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_603_1.time_ - 0) / var_606_2)
				end
			end

			if arg_603_1.time_ >= 0 + var_606_2 and arg_603_1.time_ < 0 + var_606_2 + arg_606_0 and not isNil(var_606_1) and arg_603_1.var_.characterEffect102003ui_story then
				arg_603_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_603_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_606_3 = 0
			local var_606_4 = 0.15

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_3 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_5 = arg_603_1:FormatText(arg_603_1:GetWordFromCfg(924021143).content)

				arg_603_1.text_.text = var_606_5

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_7 = 6 <= 0 and var_606_4 or var_606_4 * (utf8.len(var_606_5) / 6)

				if (6 <= 0 and var_606_4 or var_606_4 * (utf8.len(var_606_5) / 6)) > 0 and var_606_4 < var_606_7 then
					arg_603_1.talkMaxDuration = var_606_7

					if var_606_7 + var_606_3 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_7 + var_606_3
					end
				end

				arg_603_1.text_.text = var_606_5
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_8 = math.max(var_606_4, arg_603_1.talkMaxDuration)

			if var_606_3 <= arg_603_1.time_ and arg_603_1.time_ < var_606_3 + var_606_8 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_3) / var_606_8

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_3 + var_606_8 and arg_603_1.time_ < var_606_3 + var_606_8 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_603_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/X204_f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/X204_g",
		"TextureConfig/Background/X204_l"
	},
	voices = {
		"story_v_side_old_924021.awb"
	}
}
