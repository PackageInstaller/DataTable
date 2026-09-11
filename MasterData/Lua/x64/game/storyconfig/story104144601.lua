return {
	Play414461001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 414461001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play414461002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H08f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H08f")
				var_4_0.name = "H08f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H08f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H08f

				arg_1_1.bgs_.H08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H08f" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_1_2_summer1_story_intense", "bgm_activity_1_2_summer1_story_intense")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 1.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(414461001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 55 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 55)

				if (55 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 55)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play414461002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 414461002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play414461003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.425

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(414461002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 17)

				if (17 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 17)) > 0 and var_12_0 < var_12_3 then
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
	Play414461003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 414461003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play414461004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.375

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(414461003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 15 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 15)

				if (15 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 15)) > 0 and var_16_0 < var_16_3 then
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
	Play414461004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 414461004
		arg_17_1.duration_ = 7.9

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play414461005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 1 < arg_17_1.time_ and arg_17_1.time_ <= 1 + arg_20_0 then
				local var_20_0 = arg_17_1.bgs_.H08f

				arg_17_1.bgs_.H08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_1 = var_20_0:GetComponent("SpriteRenderer")

				if var_20_1 and var_20_1.sprite then
					local var_20_2 = 2 * (var_20_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_0.transform.localScale = Vector3.New(var_20_2 / var_20_1.sprite.bounds.size.y < var_20_2 * manager.ui.mainCameraCom_.aspect / var_20_1.sprite.bounds.size.x and var_20_2 * manager.ui.mainCameraCom_.aspect / var_20_1.sprite.bounds.size.x or var_20_2 / var_20_1.sprite.bounds.size.y, var_20_2 / var_20_1.sprite.bounds.size.y < var_20_2 * manager.ui.mainCameraCom_.aspect / var_20_1.sprite.bounds.size.x and var_20_2 * manager.ui.mainCameraCom_.aspect / var_20_1.sprite.bounds.size.x or var_20_2 / var_20_1.sprite.bounds.size.y, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "H08f" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_3 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= var_20_3 + 0.3 and arg_17_1.time_ < var_20_3 + 0.3 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			local var_20_4 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_5 = 1

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_5 then
				local var_20_6 = Color.New(0, 0, 0)

				var_20_6.a = Mathf.Lerp(0, 1, (arg_17_1.time_ - var_20_4) / var_20_5)
				arg_17_1.mask_.color = var_20_6
			end

			if arg_17_1.time_ >= var_20_4 + var_20_5 and arg_17_1.time_ < var_20_4 + var_20_5 + arg_20_0 then
				local var_20_7 = Color.New(0, 0, 0)

				var_20_7.a = 1
				arg_17_1.mask_.color = var_20_7
			end

			local var_20_8 = 1

			if 1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_9 = 1.77500000596046

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 then
				local var_20_10 = Color.New(0, 0, 0)

				var_20_10.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_8) / var_20_9)
				arg_17_1.mask_.color = var_20_10
			end

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 then
				local var_20_11 = Color.New(0, 0, 0)

				arg_17_1.mask_.enabled = false
				var_20_11.a = 0
				arg_17_1.mask_.color = var_20_11
			end

			local var_20_12 = "4010ui_story"

			if arg_17_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_20_13 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_17_1.stage_.transform)

				var_20_13.name = var_20_12
				var_20_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_12] = var_20_13

				local var_20_14 = var_20_13:GetComponentInChildren(typeof(CharacterEffect))

				var_20_14.enabled = true

				local var_20_15 = GameObjectTools.GetOrAddComponent(var_20_13, typeof(DynamicBoneHelper))

				if var_20_15 then
					var_20_15:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_14.transform, false)

				arg_17_1.var_[var_20_12 .. "Animator"] = var_20_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_12 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_12 .. "LipSync"] = var_20_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_16 = arg_17_1.actors_["4010ui_story"].transform

			if 2.57500000298023 < arg_17_1.time_ and arg_17_1.time_ <= 2.57500000298023 + arg_20_0 then
				arg_17_1.var_.moveOldPos4010ui_story = var_20_16.localPosition
			end

			local var_20_17 = 0.001

			if 2.57500000298023 <= arg_17_1.time_ and arg_17_1.time_ < 2.57500000298023 + var_20_17 then
				var_20_16.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_17_1.time_ - 2.57500000298023) / var_20_17)
				var_20_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_16.position).x, (manager.ui.mainCamera.transform.position - var_20_16.position).y, (manager.ui.mainCamera.transform.position - var_20_16.position).z)
				var_20_16.localEulerAngles.z = 0
				var_20_16.localEulerAngles.x = 0
				var_20_16.localEulerAngles = var_20_16.localEulerAngles
			end

			if arg_17_1.time_ >= 2.57500000298023 + var_20_17 and arg_17_1.time_ < 2.57500000298023 + var_20_17 + arg_20_0 then
				var_20_16.localPosition = Vector3.New(0, -1.59, -5.2)
				var_20_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_16.position).x, (manager.ui.mainCamera.transform.position - var_20_16.position).y, (manager.ui.mainCamera.transform.position - var_20_16.position).z)
				var_20_16.localEulerAngles.z = 0
				var_20_16.localEulerAngles.x = 0
				var_20_16.localEulerAngles = var_20_16.localEulerAngles
			end

			local var_20_18 = arg_17_1.actors_["4010ui_story"]

			if 2.57500000298023 < arg_17_1.time_ and arg_17_1.time_ <= 2.57500000298023 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.characterEffect4010ui_story == nil then
				arg_17_1.var_.characterEffect4010ui_story = var_20_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_19 = 0.200000002980232

			if 2.57500000298023 <= arg_17_1.time_ and arg_17_1.time_ < 2.57500000298023 + var_20_19 and not isNil(var_20_18) then
				if arg_17_1.var_.characterEffect4010ui_story and not isNil(var_20_18) then
					arg_17_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 2.57500000298023 + var_20_19 and arg_17_1.time_ < 2.57500000298023 + var_20_19 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.characterEffect4010ui_story then
				arg_17_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 2.57500000298023 < arg_17_1.time_ and arg_17_1.time_ <= 2.57500000298023 + arg_20_0 then
				arg_17_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 2.57500000298023 < arg_17_1.time_ and arg_17_1.time_ <= 2.57500000298023 + arg_20_0 then
				arg_17_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_21 = 2.9
			local var_20_22 = 0.375

			if 2.9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_23 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_23:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_24 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(414461004).content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_26 = 15 <= 0 and var_20_22 or var_20_22 * (utf8.len(var_20_24) / 15)

				if (15 <= 0 and var_20_22 or var_20_22 * (utf8.len(var_20_24) / 15)) > 0 and var_20_22 < var_20_26 then
					arg_17_1.talkMaxDuration = var_20_26
					var_20_21 = var_20_21 + 0.3

					if var_20_26 + var_20_21 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_26 + var_20_21
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_27 = var_20_21 + 0.3
			local var_20_28 = math.max(var_20_22, arg_17_1.talkMaxDuration)

			if var_20_21 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_27 + var_20_28 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_27) / var_20_28

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_27 + var_20_28 and arg_17_1.time_ < var_20_27 + var_20_28 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.57500000298023,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play414461005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 414461005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play414461006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos4010ui_story = arg_23_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["4010ui_story"].transform.position).z)
				arg_23_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["4010ui_story"].transform.localEulerAngles = arg_23_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["4010ui_story"].transform.position).z)
				arg_23_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["4010ui_story"].transform.localEulerAngles = arg_23_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["4010ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect4010ui_story == nil then
				arg_23_1.var_.characterEffect4010ui_story = var_26_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and not isNil(var_26_1) then
				if arg_23_1.var_.characterEffect4010ui_story and not isNil(var_26_1) then
					arg_23_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_23_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_2)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect4010ui_story then
				arg_23_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_23_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_26_3 = "104902ui_story"

			if arg_23_1.actors_["104902ui_story"] == nil and not isNil((Asset.Load("Char/" .. "104902ui_story"))) then
				local var_26_4 = Object.Instantiate(Asset.Load("Char/" .. "104902ui_story"), arg_23_1.stage_.transform)

				var_26_4.name = var_26_3
				var_26_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_[var_26_3] = var_26_4

				local var_26_5 = var_26_4:GetComponentInChildren(typeof(CharacterEffect))

				var_26_5.enabled = true

				local var_26_6 = GameObjectTools.GetOrAddComponent(var_26_4, typeof(DynamicBoneHelper))

				if var_26_6 then
					var_26_6:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_5.transform, false)

				arg_23_1.var_[var_26_3 .. "Animator"] = var_26_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_[var_26_3 .. "Animator"].applyRootMotion = true
				arg_23_1.var_[var_26_3 .. "LipSync"] = var_26_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_7 = arg_23_1.actors_["104902ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos104902ui_story = var_26_7.localPosition
			end

			local var_26_8 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_8 then
				var_26_7.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_23_1.time_ - 0) / var_26_8)
				var_26_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_7.position).x, (manager.ui.mainCamera.transform.position - var_26_7.position).y, (manager.ui.mainCamera.transform.position - var_26_7.position).z)
				var_26_7.localEulerAngles.z = 0
				var_26_7.localEulerAngles.x = 0
				var_26_7.localEulerAngles = var_26_7.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_8 and arg_23_1.time_ < 0 + var_26_8 + arg_26_0 then
				var_26_7.localPosition = Vector3.New(0, -1.2, -6)
				var_26_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_7.position).x, (manager.ui.mainCamera.transform.position - var_26_7.position).y, (manager.ui.mainCamera.transform.position - var_26_7.position).z)
				var_26_7.localEulerAngles.z = 0
				var_26_7.localEulerAngles.x = 0
				var_26_7.localEulerAngles = var_26_7.localEulerAngles
			end

			local var_26_9 = arg_23_1.actors_["104902ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect104902ui_story == nil then
				arg_23_1.var_.characterEffect104902ui_story = var_26_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_10 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_10 and not isNil(var_26_9) then
				if arg_23_1.var_.characterEffect104902ui_story and not isNil(var_26_9) then
					arg_23_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_10 and arg_23_1.time_ < 0 + var_26_10 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect104902ui_story then
				arg_23_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action1_1")
			end

			local var_26_12 = 0
			local var_26_13 = 0.1

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_12 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_14 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(414461005).content)

				arg_23_1.text_.text = var_26_14

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_16 = 4 <= 0 and var_26_13 or var_26_13 * (utf8.len(var_26_14) / 4)

				if (4 <= 0 and var_26_13 or var_26_13 * (utf8.len(var_26_14) / 4)) > 0 and var_26_13 < var_26_16 then
					arg_23_1.talkMaxDuration = var_26_16

					if var_26_16 + var_26_12 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_16 + var_26_12
					end
				end

				arg_23_1.text_.text = var_26_14
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_17 = math.max(var_26_13, arg_23_1.talkMaxDuration)

			if var_26_12 <= arg_23_1.time_ and arg_23_1.time_ < var_26_12 + var_26_17 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_12) / var_26_17

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_12 + var_26_17 and arg_23_1.time_ < var_26_12 + var_26_17 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play414461006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 414461006
		arg_27_1.duration_ = 1

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"

			SetActive(arg_27_1.choicesGo_, true)

			for iter_28_0, iter_28_1 in ipairs(arg_27_1.choices_) do
				SetActive(iter_28_1.go, iter_28_0 <= 2)
			end

			arg_27_1.choices_[1].txt.text = arg_27_1:FormatText(StoryChoiceCfg[933].name)
			arg_27_1.choices_[2].txt.text = arg_27_1:FormatText(StoryChoiceCfg[934].name)
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play414461007(arg_27_1)
			end

			if arg_29_0 == 2 then
				arg_27_0:Play414461008(arg_27_1)
			end

			arg_27_1:RecordChoiceLog(414461006, 933, 934)
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["104902ui_story"]) and arg_27_1.var_.characterEffect104902ui_story == nil then
				arg_27_1.var_.characterEffect104902ui_story = arg_27_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["104902ui_story"]) then
				if arg_27_1.var_.characterEffect104902ui_story and not isNil(arg_27_1.actors_["104902ui_story"]) then
					arg_27_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_27_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_0)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["104902ui_story"]) and arg_27_1.var_.characterEffect104902ui_story then
				arg_27_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_27_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play414461007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 414461007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play414461009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos104902ui_story = arg_31_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).z)
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles = arg_31_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["104902ui_story"].transform.position).z)
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["104902ui_story"].transform.localEulerAngles = arg_31_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["104902ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect104902ui_story == nil then
				arg_31_1.var_.characterEffect104902ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect104902ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_31_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_2)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect104902ui_story then
				arg_31_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_31_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_34_3 = arg_31_1.actors_["4010ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos4010ui_story = var_34_3.localPosition
			end

			local var_34_4 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				var_34_3.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_31_1.time_ - 0) / var_34_4)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				var_34_3.localPosition = Vector3.New(0, -1.59, -5.2)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			local var_34_5 = arg_31_1.actors_["4010ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect4010ui_story == nil then
				arg_31_1.var_.characterEffect4010ui_story = var_34_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.characterEffect4010ui_story and not isNil(var_34_5) then
					arg_31_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect4010ui_story then
				arg_31_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_34_8 = 0
			local var_34_9 = 0.5

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(414461007).content)

				arg_31_1.text_.text = var_34_10

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_12 = 20 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_10) / 20)

				if (20 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_10) / 20)) > 0 and var_34_9 < var_34_12 then
					arg_31_1.talkMaxDuration = var_34_12

					if var_34_12 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_10
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_13 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_13 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_13

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_13 and arg_31_1.time_ < var_34_8 + var_34_13 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play414461009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 414461009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play414461010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos4010ui_story = arg_35_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["4010ui_story"].transform.position).z)
				arg_35_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["4010ui_story"].transform.localEulerAngles = arg_35_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["4010ui_story"].transform.position).z)
				arg_35_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["4010ui_story"].transform.localEulerAngles = arg_35_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["4010ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect4010ui_story == nil then
				arg_35_1.var_.characterEffect4010ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect4010ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_35_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_2)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect4010ui_story then
				arg_35_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_35_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_38_3 = "3045ui_story"

			if arg_35_1.actors_["3045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3045ui_story"))) then
				local var_38_4 = Object.Instantiate(Asset.Load("Char/" .. "3045ui_story"), arg_35_1.stage_.transform)

				var_38_4.name = var_38_3
				var_38_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_[var_38_3] = var_38_4

				local var_38_5 = var_38_4:GetComponentInChildren(typeof(CharacterEffect))

				var_38_5.enabled = true

				local var_38_6 = GameObjectTools.GetOrAddComponent(var_38_4, typeof(DynamicBoneHelper))

				if var_38_6 then
					var_38_6:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_5.transform, false)

				arg_35_1.var_[var_38_3 .. "Animator"] = var_38_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_[var_38_3 .. "Animator"].applyRootMotion = true
				arg_35_1.var_[var_38_3 .. "LipSync"] = var_38_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_38_7 = arg_35_1.actors_["3045ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos3045ui_story = var_38_7.localPosition

				arg_35_1:ShowWeapon(arg_35_1.var_["3045ui_story" .. "Animator"].transform, false)
			end

			local var_38_8 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_8 then
				var_38_7.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos3045ui_story, Vector3.New(0, -1.75, -4.8), (arg_35_1.time_ - 0) / var_38_8)
				var_38_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_7.position).x, (manager.ui.mainCamera.transform.position - var_38_7.position).y, (manager.ui.mainCamera.transform.position - var_38_7.position).z)
				var_38_7.localEulerAngles.z = 0
				var_38_7.localEulerAngles.x = 0
				var_38_7.localEulerAngles = var_38_7.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_8 and arg_35_1.time_ < 0 + var_38_8 + arg_38_0 then
				var_38_7.localPosition = Vector3.New(0, -1.75, -4.8)
				var_38_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_7.position).x, (manager.ui.mainCamera.transform.position - var_38_7.position).y, (manager.ui.mainCamera.transform.position - var_38_7.position).z)
				var_38_7.localEulerAngles.z = 0
				var_38_7.localEulerAngles.x = 0
				var_38_7.localEulerAngles = var_38_7.localEulerAngles
			end

			local var_38_9 = arg_35_1.actors_["3045ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect3045ui_story == nil then
				arg_35_1.var_.characterEffect3045ui_story = var_38_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_10 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_10 and not isNil(var_38_9) then
				if arg_35_1.var_.characterEffect3045ui_story and not isNil(var_38_9) then
					arg_35_1.var_.characterEffect3045ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_10 and arg_35_1.time_ < 0 + var_38_10 + arg_38_0 and not isNil(var_38_9) and arg_35_1.var_.characterEffect3045ui_story then
				arg_35_1.var_.characterEffect3045ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_38_12 = 0
			local var_38_13 = 0.525

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_14 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(414461009).content)

				arg_35_1.text_.text = var_38_14

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_16 = 21 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_14) / 21)

				if (21 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_14) / 21)) > 0 and var_38_13 < var_38_16 then
					arg_35_1.talkMaxDuration = var_38_16

					if var_38_16 + var_38_12 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_16 + var_38_12
					end
				end

				arg_35_1.text_.text = var_38_14
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_17 = math.max(var_38_13, arg_35_1.talkMaxDuration)

			if var_38_12 <= arg_35_1.time_ and arg_35_1.time_ < var_38_12 + var_38_17 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_12) / var_38_17

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_12 + var_38_17 and arg_35_1.time_ < var_38_12 + var_38_17 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play414461010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 414461010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play414461011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos3045ui_story = arg_39_1.actors_["3045ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["3045ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos3045ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["3045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["3045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["3045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["3045ui_story"].transform.position).z)
				arg_39_1.actors_["3045ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["3045ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["3045ui_story"].transform.localEulerAngles = arg_39_1.actors_["3045ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["3045ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["3045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["3045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["3045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["3045ui_story"].transform.position).z)
				arg_39_1.actors_["3045ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["3045ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["3045ui_story"].transform.localEulerAngles = arg_39_1.actors_["3045ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["3045ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect3045ui_story == nil then
				arg_39_1.var_.characterEffect3045ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect3045ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect3045ui_story.fillFlat = true
					arg_39_1.var_.characterEffect3045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_2)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect3045ui_story then
				arg_39_1.var_.characterEffect3045ui_story.fillFlat = true
				arg_39_1.var_.characterEffect3045ui_story.fillRatio = 0.5
			end

			local var_42_3 = arg_39_1.actors_["4010ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos4010ui_story = var_42_3.localPosition
			end

			local var_42_4 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				var_42_3.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_39_1.time_ - 0) / var_42_4)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				var_42_3.localPosition = Vector3.New(0, -1.59, -5.2)
				var_42_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_3.position).x, (manager.ui.mainCamera.transform.position - var_42_3.position).y, (manager.ui.mainCamera.transform.position - var_42_3.position).z)
				var_42_3.localEulerAngles.z = 0
				var_42_3.localEulerAngles.x = 0
				var_42_3.localEulerAngles = var_42_3.localEulerAngles
			end

			local var_42_5 = arg_39_1.actors_["4010ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect4010ui_story == nil then
				arg_39_1.var_.characterEffect4010ui_story = var_42_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_6 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_6 and not isNil(var_42_5) then
				if arg_39_1.var_.characterEffect4010ui_story and not isNil(var_42_5) then
					arg_39_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_6 and arg_39_1.time_ < 0 + var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.characterEffect4010ui_story then
				arg_39_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_8 = 0
			local var_42_9 = 0.75

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(414461010).content)

				arg_39_1.text_.text = var_42_10

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_12 = 30 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_10) / 30)

				if (30 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_10) / 30)) > 0 and var_42_9 < var_42_12 then
					arg_39_1.talkMaxDuration = var_42_12

					if var_42_12 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_10
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_13 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_13 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_13

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_13 and arg_39_1.time_ < var_42_8 + var_42_13 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play414461011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 414461011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play414461012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["4010ui_story"]) and arg_43_1.var_.characterEffect4010ui_story == nil then
				arg_43_1.var_.characterEffect4010ui_story = arg_43_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["4010ui_story"]) then
				if arg_43_1.var_.characterEffect4010ui_story and not isNil(arg_43_1.actors_["4010ui_story"]) then
					arg_43_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_43_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["4010ui_story"]) and arg_43_1.var_.characterEffect4010ui_story then
				arg_43_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_43_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.3

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(414461011).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 12 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 12)

				if (12 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 12)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play414461012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 414461012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play414461013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["4010ui_story"]) and arg_47_1.var_.characterEffect4010ui_story == nil then
				arg_47_1.var_.characterEffect4010ui_story = arg_47_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["4010ui_story"]) then
				if arg_47_1.var_.characterEffect4010ui_story and not isNil(arg_47_1.actors_["4010ui_story"]) then
					arg_47_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["4010ui_story"]) and arg_47_1.var_.characterEffect4010ui_story then
				arg_47_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010actionlink/4010action423")
			end

			local var_50_2 = 0
			local var_50_3 = 1.1

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_4 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(414461012).content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_6 = 43 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_4) / 43)

				if (43 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_4) / 43)) > 0 and var_50_3 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_7 and arg_47_1.time_ < var_50_2 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play414461013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 414461013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play414461014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos4010ui_story = arg_51_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["4010ui_story"].transform.position).z)
				arg_51_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["4010ui_story"].transform.localEulerAngles = arg_51_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["4010ui_story"].transform.position).z)
				arg_51_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["4010ui_story"].transform.localEulerAngles = arg_51_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["4010ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect4010ui_story == nil then
				arg_51_1.var_.characterEffect4010ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect4010ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_51_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_2)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect4010ui_story then
				arg_51_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_51_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_54_3 = 0
			local var_54_4 = 1.25

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[978].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_5 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(414461013).content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 50 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 50)

				if (50 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 50)) > 0 and var_54_4 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_3) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_3 + var_54_8 and arg_51_1.time_ < var_54_3 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play414461014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 414461014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play414461015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[978].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(414461014).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 40 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 40)

				if (40 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 40)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play414461015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 414461015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play414461016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.575

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[978].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(414461015).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 23 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 23)

				if (23 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 23)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play414461016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 414461016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play414461017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.075

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(414461016).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 43 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 43)

				if (43 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 43)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play414461017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 414461017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play414461018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos104902ui_story = arg_67_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["104902ui_story"].transform.position).z)
				arg_67_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["104902ui_story"].transform.localEulerAngles = arg_67_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_67_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["104902ui_story"].transform.position).z)
				arg_67_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["104902ui_story"].transform.localEulerAngles = arg_67_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["104902ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect104902ui_story == nil then
				arg_67_1.var_.characterEffect104902ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect104902ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect104902ui_story then
				arg_67_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_1")
			end

			local var_70_4 = 0
			local var_70_5 = 0.55

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(414461017).content)

				arg_67_1.text_.text = var_70_6

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_8 = 22 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_6) / 22)

				if (22 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_6) / 22)) > 0 and var_70_5 < var_70_8 then
					arg_67_1.talkMaxDuration = var_70_8

					if var_70_8 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_6
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_9 and arg_67_1.time_ < var_70_4 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play414461018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 414461018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play414461019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["104902ui_story"]) and arg_71_1.var_.characterEffect104902ui_story == nil then
				arg_71_1.var_.characterEffect104902ui_story = arg_71_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["104902ui_story"]) then
				if arg_71_1.var_.characterEffect104902ui_story and not isNil(arg_71_1.actors_["104902ui_story"]) then
					arg_71_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_71_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["104902ui_story"]) and arg_71_1.var_.characterEffect104902ui_story then
				arg_71_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_71_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.3

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(414461018).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 12 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 12)

				if (12 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 12)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play414461019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 414461019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play414461020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos104902ui_story = arg_75_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["104902ui_story"].transform.position).z)
				arg_75_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["104902ui_story"].transform.localEulerAngles = arg_75_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["104902ui_story"].transform.position).z)
				arg_75_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["104902ui_story"].transform.localEulerAngles = arg_75_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_78_1 = 0
			local var_78_2 = 0.3

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(414461019).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 12 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 12)

				if (12 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 12)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play414461020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 414461020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play414461021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_82_0 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_79_1.stage_.transform)

				var_82_0.name = "1035ui_story"
				var_82_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["1035ui_story"] = var_82_0

				local var_82_1 = var_82_0:GetComponentInChildren(typeof(CharacterEffect))

				var_82_1.enabled = true

				local var_82_2 = GameObjectTools.GetOrAddComponent(var_82_0, typeof(DynamicBoneHelper))

				if var_82_2 then
					var_82_2:EnableDynamicBone(false)
				end

				arg_79_1:ShowWeapon(var_82_1.transform, false)

				arg_79_1.var_["1035ui_story" .. "Animator"] = var_82_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_79_1.var_["1035ui_story" .. "Animator"].applyRootMotion = true
				arg_79_1.var_["1035ui_story" .. "LipSync"] = var_82_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_82_3 = arg_79_1.actors_["1035ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1035ui_story = var_82_3.localPosition
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_3.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_79_1.time_ - 0) / var_82_4)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_3.localPosition = Vector3.New(0, -1.05, -5.6)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			local var_82_5 = arg_79_1.actors_["1035ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect1035ui_story == nil then
				arg_79_1.var_.characterEffect1035ui_story = var_82_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 and not isNil(var_82_5) then
				if arg_79_1.var_.characterEffect1035ui_story and not isNil(var_82_5) then
					arg_79_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect1035ui_story then
				arg_79_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_8 = 0
			local var_82_9 = 0.8

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(414461020).content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 32 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_10) / 32)

				if (32 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_10) / 32)) > 0 and var_82_9 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_13 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_13 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_13

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_13 and arg_79_1.time_ < var_82_8 + var_82_13 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play414461021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 414461021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play414461022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1035ui_story = arg_83_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1035ui_story"].transform.position).z)
				arg_83_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1035ui_story"].transform.localEulerAngles = arg_83_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1035ui_story"].transform.position).z)
				arg_83_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1035ui_story"].transform.localEulerAngles = arg_83_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1035ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1035ui_story == nil then
				arg_83_1.var_.characterEffect1035ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1035ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_2)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1035ui_story then
				arg_83_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_86_3 = 0
			local var_86_4 = 0.25

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_5 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(414461021).content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 10 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_5) / 10)

				if (10 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_5) / 10)) > 0 and var_86_4 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_3
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_4, arg_83_1.talkMaxDuration)

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_3) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_3 + var_86_8 and arg_83_1.time_ < var_86_3 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play414461022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 414461022
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play414461023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.actors_["1016ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1016ui_story"))) then
				local var_90_0 = Object.Instantiate(Asset.Load("Char/" .. "1016ui_story"), arg_87_1.stage_.transform)

				var_90_0.name = "1016ui_story"
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1016ui_story"] = var_90_0

				local var_90_1 = var_90_0:GetComponentInChildren(typeof(CharacterEffect))

				var_90_1.enabled = true

				local var_90_2 = GameObjectTools.GetOrAddComponent(var_90_0, typeof(DynamicBoneHelper))

				if var_90_2 then
					var_90_2:EnableDynamicBone(false)
				end

				arg_87_1:ShowWeapon(var_90_1.transform, false)

				arg_87_1.var_["1016ui_story" .. "Animator"] = var_90_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_87_1.var_["1016ui_story" .. "Animator"].applyRootMotion = true
				arg_87_1.var_["1016ui_story" .. "LipSync"] = var_90_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_90_3 = arg_87_1.actors_["1016ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1016ui_story = var_90_3.localPosition

				arg_87_1:ShowWeapon(arg_87_1.var_["1016ui_story" .. "Animator"].transform, false)
			end

			local var_90_4 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				var_90_3.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_87_1.time_ - 0) / var_90_4)
				var_90_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_3.position).x, (manager.ui.mainCamera.transform.position - var_90_3.position).y, (manager.ui.mainCamera.transform.position - var_90_3.position).z)
				var_90_3.localEulerAngles.z = 0
				var_90_3.localEulerAngles.x = 0
				var_90_3.localEulerAngles = var_90_3.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				var_90_3.localPosition = Vector3.New(0, -18.66, -121.78)
				var_90_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_3.position).x, (manager.ui.mainCamera.transform.position - var_90_3.position).y, (manager.ui.mainCamera.transform.position - var_90_3.position).z)
				var_90_3.localEulerAngles.z = 0
				var_90_3.localEulerAngles.x = 0
				var_90_3.localEulerAngles = var_90_3.localEulerAngles
			end

			local var_90_5 = arg_87_1.actors_["1016ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.characterEffect1016ui_story == nil then
				arg_87_1.var_.characterEffect1016ui_story = var_90_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_6 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_6 and not isNil(var_90_5) then
				if arg_87_1.var_.characterEffect1016ui_story and not isNil(var_90_5) then
					arg_87_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_6 and arg_87_1.time_ < 0 + var_90_6 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.characterEffect1016ui_story then
				arg_87_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action3_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_90_8 = 0
			local var_90_9 = 0.675

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(414461022).content)

				arg_87_1.text_.text = var_90_10

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_12 = 27 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_10) / 27)

				if (27 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_10) / 27)) > 0 and var_90_9 < var_90_12 then
					arg_87_1.talkMaxDuration = var_90_12

					if var_90_12 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_10
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_13 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_13 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_13

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_13 and arg_87_1.time_ < var_90_8 + var_90_13 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play414461023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 414461023
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play414461024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1016ui_story = arg_91_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1016ui_story"].transform.position).z)
				arg_91_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1016ui_story"].transform.localEulerAngles = arg_91_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1016ui_story"].transform.position).z)
				arg_91_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1016ui_story"].transform.localEulerAngles = arg_91_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1016ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1016ui_story == nil then
				arg_91_1.var_.characterEffect1016ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1016ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_2)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1016ui_story then
				arg_91_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_94_3 = arg_91_1.actors_["4010ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos4010ui_story = var_94_3.localPosition
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_3.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_91_1.time_ - 0) / var_94_4)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_3.localPosition = Vector3.New(0, -1.59, -5.2)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			local var_94_5 = arg_91_1.actors_["4010ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.characterEffect4010ui_story == nil then
				arg_91_1.var_.characterEffect4010ui_story = var_94_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_6 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 and not isNil(var_94_5) then
				if arg_91_1.var_.characterEffect4010ui_story and not isNil(var_94_5) then
					arg_91_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.characterEffect4010ui_story then
				arg_91_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_8 = 0
			local var_94_9 = 0.425

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(414461023).content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_12 = 17 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_10) / 17)

				if (17 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_10) / 17)) > 0 and var_94_9 < var_94_12 then
					arg_91_1.talkMaxDuration = var_94_12

					if var_94_12 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_8
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_13 = math.max(var_94_9, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_13 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_8) / var_94_13

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_13 and arg_91_1.time_ < var_94_8 + var_94_13 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play414461024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 414461024
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play414461025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos4010ui_story = arg_95_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["4010ui_story"].transform.position).z)
				arg_95_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["4010ui_story"].transform.localEulerAngles = arg_95_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["4010ui_story"].transform.position).z)
				arg_95_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["4010ui_story"].transform.localEulerAngles = arg_95_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["4010ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect4010ui_story == nil then
				arg_95_1.var_.characterEffect4010ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect4010ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_95_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_2)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect4010ui_story then
				arg_95_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_95_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_98_3 = arg_95_1.actors_["1016ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1016ui_story = var_98_3.localPosition
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_3.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_95_1.time_ - 0) / var_98_4)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_3.localPosition = Vector3.New(0, -18.66, -121.78)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			local var_98_5 = arg_95_1.actors_["1016ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect1016ui_story == nil then
				arg_95_1.var_.characterEffect1016ui_story = var_98_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.characterEffect1016ui_story and not isNil(var_98_5) then
					arg_95_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect1016ui_story then
				arg_95_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016actionlink/1016action434")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_8 = 0
			local var_98_9 = 0.35

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_10 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(414461024).content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_12 = 14 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_10) / 14)

				if (14 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_10) / 14)) > 0 and var_98_9 < var_98_12 then
					arg_95_1.talkMaxDuration = var_98_12

					if var_98_12 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_12 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_13 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_13 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_13

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_13 and arg_95_1.time_ < var_98_8 + var_98_13 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play414461025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 414461025
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play414461026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1016ui_story = arg_99_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1016ui_story"].transform.position).z)
				arg_99_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1016ui_story"].transform.localEulerAngles = arg_99_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1016ui_story"].transform.position).z)
				arg_99_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1016ui_story"].transform.localEulerAngles = arg_99_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1016ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1016ui_story == nil then
				arg_99_1.var_.characterEffect1016ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1016ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_2)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1016ui_story then
				arg_99_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_102_3 = 0
			local var_102_4 = 0.675

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_5 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(414461025).content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 27 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 27)

				if (27 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 27)) > 0 and var_102_4 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_8 and arg_99_1.time_ < var_102_3 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play414461026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 414461026
		arg_103_1.duration_ = 1

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"

			SetActive(arg_103_1.choicesGo_, true)

			for iter_104_0, iter_104_1 in ipairs(arg_103_1.choices_) do
				SetActive(iter_104_1.go, iter_104_0 <= 2)
			end

			arg_103_1.choices_[1].txt.text = arg_103_1:FormatText(StoryChoiceCfg[935].name)
			arg_103_1.choices_[2].txt.text = arg_103_1:FormatText(StoryChoiceCfg[936].name)
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play414461027(arg_103_1)
			end

			if arg_105_0 == 2 then
				arg_103_0:Play414461030(arg_103_1)
			end

			arg_103_1:RecordChoiceLog(414461026, 935, 936)
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			return
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play414461027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 414461027
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play414461028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.275

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(414461027).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 11 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 11)

				if (11 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 11)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play414461028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 414461028
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play414461029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos3045ui_story = arg_111_1.actors_["3045ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["3045ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos3045ui_story, Vector3.New(0, -1.75, -4.8), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["3045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["3045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["3045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["3045ui_story"].transform.position).z)
				arg_111_1.actors_["3045ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["3045ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["3045ui_story"].transform.localEulerAngles = arg_111_1.actors_["3045ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["3045ui_story"].transform.localPosition = Vector3.New(0, -1.75, -4.8)
				arg_111_1.actors_["3045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["3045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["3045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["3045ui_story"].transform.position).z)
				arg_111_1.actors_["3045ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["3045ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["3045ui_story"].transform.localEulerAngles = arg_111_1.actors_["3045ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["3045ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect3045ui_story == nil then
				arg_111_1.var_.characterEffect3045ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect3045ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect3045ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect3045ui_story then
				arg_111_1.var_.characterEffect3045ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("3045ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_2")
			end

			local var_114_4 = 0
			local var_114_5 = 0.425

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(414461028).content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_8 = 17 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_6) / 17)

				if (17 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_6) / 17)) > 0 and var_114_5 < var_114_8 then
					arg_111_1.talkMaxDuration = var_114_8

					if var_114_8 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_9 and arg_111_1.time_ < var_114_4 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play414461029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 414461029
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play414461033(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos3045ui_story = arg_115_1.actors_["3045ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["3045ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos3045ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["3045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["3045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["3045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["3045ui_story"].transform.position).z)
				arg_115_1.actors_["3045ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["3045ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["3045ui_story"].transform.localEulerAngles = arg_115_1.actors_["3045ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["3045ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["3045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["3045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["3045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["3045ui_story"].transform.position).z)
				arg_115_1.actors_["3045ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["3045ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["3045ui_story"].transform.localEulerAngles = arg_115_1.actors_["3045ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["3045ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect3045ui_story == nil then
				arg_115_1.var_.characterEffect3045ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect3045ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect3045ui_story.fillFlat = true
					arg_115_1.var_.characterEffect3045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_2)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect3045ui_story then
				arg_115_1.var_.characterEffect3045ui_story.fillFlat = true
				arg_115_1.var_.characterEffect3045ui_story.fillRatio = 0.5
			end

			local var_118_3 = 0
			local var_118_4 = 0.325

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_5 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(414461029).content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 13 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 13)

				if (13 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 13)) > 0 and var_118_4 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_3
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_4, arg_115_1.talkMaxDuration)

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_3) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_3 + var_118_8 and arg_115_1.time_ < var_118_3 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play414461033 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 414461033
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play414461034(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.45

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(414461033).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 18 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 18)

				if (18 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 18)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play414461034 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 414461034
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play414461035(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1016ui_story = arg_123_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1016ui_story"].transform.position).z)
				arg_123_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1016ui_story"].transform.localEulerAngles = arg_123_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(0, -18.66, -121.78)
				arg_123_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1016ui_story"].transform.position).z)
				arg_123_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1016ui_story"].transform.localEulerAngles = arg_123_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1016ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1016ui_story == nil then
				arg_123_1.var_.characterEffect1016ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1016ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1016ui_story then
				arg_123_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action4_2")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = 0
			local var_126_5 = 0.625

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(414461034).content)

				arg_123_1.text_.text = var_126_6

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_8 = 25 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_6) / 25)

				if (25 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_6) / 25)) > 0 and var_126_5 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_6
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_9 and arg_123_1.time_ < var_126_4 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play414461035 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 414461035
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play414461036(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1035ui_story = arg_127_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1035ui_story"].transform.position).z)
				arg_127_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1035ui_story"].transform.localEulerAngles = arg_127_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.6)
				arg_127_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1035ui_story"].transform.position).z)
				arg_127_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1035ui_story"].transform.localEulerAngles = arg_127_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1035ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1035ui_story == nil then
				arg_127_1.var_.characterEffect1035ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1035ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1035ui_story then
				arg_127_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action3_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_4 = arg_127_1.actors_["1016ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1016ui_story = var_130_4.localPosition
			end

			local var_130_5 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 then
				var_130_4.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_5)
				var_130_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_4.position).x, (manager.ui.mainCamera.transform.position - var_130_4.position).y, (manager.ui.mainCamera.transform.position - var_130_4.position).z)
				var_130_4.localEulerAngles.z = 0
				var_130_4.localEulerAngles.x = 0
				var_130_4.localEulerAngles = var_130_4.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 then
				var_130_4.localPosition = Vector3.New(0, 100, 0)
				var_130_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_4.position).x, (manager.ui.mainCamera.transform.position - var_130_4.position).y, (manager.ui.mainCamera.transform.position - var_130_4.position).z)
				var_130_4.localEulerAngles.z = 0
				var_130_4.localEulerAngles.x = 0
				var_130_4.localEulerAngles = var_130_4.localEulerAngles
			end

			local var_130_6 = arg_127_1.actors_["1016ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1016ui_story == nil then
				arg_127_1.var_.characterEffect1016ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_7 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 and not isNil(var_130_6) then
				if arg_127_1.var_.characterEffect1016ui_story and not isNil(var_130_6) then
					arg_127_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_7)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1016ui_story then
				arg_127_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_130_8 = 0
			local var_130_9 = 0.5

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_10 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(414461035).content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_12 = 21 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_10) / 21)

				if (21 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_10) / 21)) > 0 and var_130_9 < var_130_12 then
					arg_127_1.talkMaxDuration = var_130_12

					if var_130_12 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_13 and arg_127_1.time_ < var_130_8 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play414461036 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 414461036
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play414461037(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1035ui_story = arg_131_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1035ui_story"].transform.position).z)
				arg_131_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1035ui_story"].transform.localEulerAngles = arg_131_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1035ui_story"].transform.position).z)
				arg_131_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1035ui_story"].transform.localEulerAngles = arg_131_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1035ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1035ui_story == nil then
				arg_131_1.var_.characterEffect1035ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1035ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_2)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1035ui_story then
				arg_131_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_134_3 = arg_131_1.actors_["4010ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos4010ui_story = var_134_3.localPosition
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_3.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_131_1.time_ - 0) / var_134_4)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_3.localPosition = Vector3.New(0, -1.59, -5.2)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			local var_134_5 = arg_131_1.actors_["4010ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect4010ui_story == nil then
				arg_131_1.var_.characterEffect4010ui_story = var_134_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.characterEffect4010ui_story and not isNil(var_134_5) then
					arg_131_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect4010ui_story then
				arg_131_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_134_8 = 0
			local var_134_9 = 0.525

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(414461036).content)

				arg_131_1.text_.text = var_134_10

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_12 = 21 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_10) / 21)

				if (21 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_10) / 21)) > 0 and var_134_9 < var_134_12 then
					arg_131_1.talkMaxDuration = var_134_12

					if var_134_12 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_10
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_13 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_13

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_13 and arg_131_1.time_ < var_134_8 + var_134_13 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play414461037 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 414461037
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play414461038(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos4010ui_story = arg_135_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["4010ui_story"].transform.position).z)
				arg_135_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["4010ui_story"].transform.localEulerAngles = arg_135_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["4010ui_story"].transform.position).z)
				arg_135_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["4010ui_story"].transform.localEulerAngles = arg_135_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["4010ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect4010ui_story == nil then
				arg_135_1.var_.characterEffect4010ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect4010ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_135_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_2)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect4010ui_story then
				arg_135_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_135_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_138_3 = 0
			local var_138_4 = 1.175

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_5 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(414461037).content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 47 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 47)

				if (47 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 47)) > 0 and var_138_4 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_3
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_4, arg_135_1.talkMaxDuration)

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_3) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_3 + var_138_8 and arg_135_1.time_ < var_138_3 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play414461038 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 414461038
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play414461039(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.4

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(414461038).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 16 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 16)

				if (16 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 16)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play414461039 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 414461039
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play414461040(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos104902ui_story = arg_143_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos104902ui_story, Vector3.New(0, -1.2, -6), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["104902ui_story"].transform.position).z)
				arg_143_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["104902ui_story"].transform.localEulerAngles = arg_143_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, -1.2, -6)
				arg_143_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["104902ui_story"].transform.position).z)
				arg_143_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["104902ui_story"].transform.localEulerAngles = arg_143_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["104902ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect104902ui_story == nil then
				arg_143_1.var_.characterEffect104902ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect104902ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect104902ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect104902ui_story then
				arg_143_1.var_.characterEffect104902ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("104902ui_story", "StoryTimeline/CharAction/story104902/story104902action/104902action5_2")
			end

			local var_146_4 = 0
			local var_146_5 = 0.35

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(414461039).content)

				arg_143_1.text_.text = var_146_6

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_8 = 14 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_6) / 14)

				if (14 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_6) / 14)) > 0 and var_146_5 < var_146_8 then
					arg_143_1.talkMaxDuration = var_146_8

					if var_146_8 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_6
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_9 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_9 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_9

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_9 and arg_143_1.time_ < var_146_4 + var_146_9 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play414461040 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 414461040
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
			arg_147_1.auto_ = false
		end

		function arg_147_1.playNext_(arg_149_0)
			arg_147_1.onStoryFinished_()
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["104902ui_story"]) and arg_147_1.var_.characterEffect104902ui_story == nil then
				arg_147_1.var_.characterEffect104902ui_story = arg_147_1.actors_["104902ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["104902ui_story"]) then
				if arg_147_1.var_.characterEffect104902ui_story and not isNil(arg_147_1.actors_["104902ui_story"]) then
					arg_147_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_147_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["104902ui_story"]) and arg_147_1.var_.characterEffect104902ui_story then
				arg_147_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_147_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_150_1 = arg_147_1.actors_["104902ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos104902ui_story = var_150_1.localPosition
			end

			local var_150_2 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 then
				var_150_1.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_2)
				var_150_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_1.position).x, (manager.ui.mainCamera.transform.position - var_150_1.position).y, (manager.ui.mainCamera.transform.position - var_150_1.position).z)
				var_150_1.localEulerAngles.z = 0
				var_150_1.localEulerAngles.x = 0
				var_150_1.localEulerAngles = var_150_1.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 then
				var_150_1.localPosition = Vector3.New(0, 100, 0)
				var_150_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_1.position).x, (manager.ui.mainCamera.transform.position - var_150_1.position).y, (manager.ui.mainCamera.transform.position - var_150_1.position).z)
				var_150_1.localEulerAngles.z = 0
				var_150_1.localEulerAngles.x = 0
				var_150_1.localEulerAngles = var_150_1.localEulerAngles
			end

			local var_150_3 = 0
			local var_150_4 = 1.3

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[978].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_5 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(414461040).content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 52 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 52)

				if (52 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 52)) > 0 and var_150_4 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_3 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_3
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_4, arg_147_1.talkMaxDuration)

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_3) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_3 + var_150_8 and arg_147_1.time_ < var_150_3 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play414461030 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 414461030
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play414461031(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.65

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

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(414461030).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 26 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 26)

				if (26 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 26)) > 0 and var_154_0 < var_154_3 then
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
	Play414461031 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 414461031
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play414461032(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1035ui_story = arg_155_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1035ui_story"].transform.position).z)
				arg_155_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1035ui_story"].transform.localEulerAngles = arg_155_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.6)
				arg_155_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1035ui_story"].transform.position).z)
				arg_155_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1035ui_story"].transform.localEulerAngles = arg_155_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1035ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1035ui_story == nil then
				arg_155_1.var_.characterEffect1035ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1035ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1035ui_story then
				arg_155_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_4 = 0
			local var_158_5 = 0.55

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(414461031).content)

				arg_155_1.text_.text = var_158_6

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_8 = 22 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_6) / 22)

				if (22 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_6) / 22)) > 0 and var_158_5 < var_158_8 then
					arg_155_1.talkMaxDuration = var_158_8

					if var_158_8 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_6
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_9 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_9 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_9

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_9 and arg_155_1.time_ < var_158_4 + var_158_9 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play414461032 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 414461032
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play414461033(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1035ui_story = arg_159_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1035ui_story"].transform.position).z)
				arg_159_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1035ui_story"].transform.localEulerAngles = arg_159_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1035ui_story"].transform.position).z)
				arg_159_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1035ui_story"].transform.localEulerAngles = arg_159_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1035ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1035ui_story == nil then
				arg_159_1.var_.characterEffect1035ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1035ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_2)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1035ui_story then
				arg_159_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_162_3 = 0
			local var_162_4 = 0.3

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_5 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(414461032).content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 12 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_5) / 12)

				if (12 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_5) / 12)) > 0 and var_162_4 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_3) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_3 + var_162_8 and arg_159_1.time_ < var_162_3 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play414461008 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 414461008
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play414461009(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos104902ui_story = arg_163_1.actors_["104902ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["104902ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos104902ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["104902ui_story"].transform.position).z)
				arg_163_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["104902ui_story"].transform.localEulerAngles = arg_163_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["104902ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["104902ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["104902ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["104902ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["104902ui_story"].transform.position).z)
				arg_163_1.actors_["104902ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["104902ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["104902ui_story"].transform.localEulerAngles = arg_163_1.actors_["104902ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["104902ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect104902ui_story == nil then
				arg_163_1.var_.characterEffect104902ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect104902ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect104902ui_story.fillFlat = true
					arg_163_1.var_.characterEffect104902ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_2)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect104902ui_story then
				arg_163_1.var_.characterEffect104902ui_story.fillFlat = true
				arg_163_1.var_.characterEffect104902ui_story.fillRatio = 0.5
			end

			local var_166_3 = arg_163_1.actors_["4010ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos4010ui_story = var_166_3.localPosition
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_3.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_163_1.time_ - 0) / var_166_4)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_3.localPosition = Vector3.New(0, -1.59, -5.2)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			local var_166_5 = arg_163_1.actors_["4010ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.characterEffect4010ui_story == nil then
				arg_163_1.var_.characterEffect4010ui_story = var_166_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_6 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 and not isNil(var_166_5) then
				if arg_163_1.var_.characterEffect4010ui_story and not isNil(var_166_5) then
					arg_163_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.characterEffect4010ui_story then
				arg_163_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_166_8 = "4010ui_story"

			if arg_163_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_166_9 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_163_1.stage_.transform)

				var_166_9.name = var_166_8
				var_166_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_[var_166_8] = var_166_9

				local var_166_10 = var_166_9:GetComponentInChildren(typeof(CharacterEffect))

				var_166_10.enabled = true

				local var_166_11 = GameObjectTools.GetOrAddComponent(var_166_9, typeof(DynamicBoneHelper))

				if var_166_11 then
					var_166_11:EnableDynamicBone(false)
				end

				arg_163_1:ShowWeapon(var_166_10.transform, false)

				arg_163_1.var_[var_166_8 .. "Animator"] = var_166_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_163_1.var_[var_166_8 .. "Animator"].applyRootMotion = true
				arg_163_1.var_[var_166_8 .. "LipSync"] = var_166_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			local var_166_12 = "4010ui_story"

			if arg_163_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_166_13 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_163_1.stage_.transform)

				var_166_13.name = var_166_12
				var_166_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_[var_166_12] = var_166_13

				local var_166_14 = var_166_13:GetComponentInChildren(typeof(CharacterEffect))

				var_166_14.enabled = true

				local var_166_15 = GameObjectTools.GetOrAddComponent(var_166_13, typeof(DynamicBoneHelper))

				if var_166_15 then
					var_166_15:EnableDynamicBone(false)
				end

				arg_163_1:ShowWeapon(var_166_14.transform, false)

				arg_163_1.var_[var_166_12 .. "Animator"] = var_166_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_163_1.var_[var_166_12 .. "Animator"].applyRootMotion = true
				arg_163_1.var_[var_166_12 .. "LipSync"] = var_166_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_16 = 0
			local var_166_17 = 0.325

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(414461008).content)

				arg_163_1.text_.text = var_166_18

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 13 <= 0 and var_166_17 or var_166_17 * (utf8.len(var_166_18) / 13)

				if (13 <= 0 and var_166_17 or var_166_17 * (utf8.len(var_166_18) / 13)) > 0 and var_166_17 < var_166_20 then
					arg_163_1.talkMaxDuration = var_166_20

					if var_166_20 + var_166_16 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_20 + var_166_16
					end
				end

				arg_163_1.text_.text = var_166_18
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_21 = math.max(var_166_17, arg_163_1.talkMaxDuration)

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_21 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_16) / var_166_21

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_16 + var_166_21 and arg_163_1.time_ < var_166_16 + var_166_21 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	assets = {
		"TextureConfig/Background/H08f"
	},
	voices = {}
}
