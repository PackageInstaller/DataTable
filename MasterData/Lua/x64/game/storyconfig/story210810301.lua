return {
	Play1108103001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108103001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108103002(arg_1_1)
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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
			local var_4_15 = 0.225

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1108103001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 9 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 9)

				if (9 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 9)) > 0 and var_4_15 < var_4_19 then
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
	Play1108103002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1108103002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1108103003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.225

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1108103002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 9 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 9)

				if (9 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 9)) > 0 and var_12_0 < var_12_3 then
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
	Play1108103003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1108103003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1108103004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.4

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1108103003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 16 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 16)

				if (16 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 16)) > 0 and var_16_0 < var_16_3 then
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
	Play1108103004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1108103004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1108103005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.525

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1108103004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 21 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 21)

				if (21 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 21)) > 0 and var_20_0 < var_20_3 then
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
	Play1108103005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1108103005
		arg_21_1.duration_ = 7.6

		local var_21_0 = {
			ja = 7.6,
			ko = 3.4,
			zh = 3.4
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
				arg_21_0:Play1108103006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1081ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1081ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1081ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1081ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1081ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1081ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1081ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1081ui_story == nil then
				arg_21_1.var_.characterEffect1081ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.0166666666666667

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1081ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1081ui_story then
				arg_21_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_8 = 0
			local var_24_9 = 0.475

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(1108103005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 19 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 19)

				if (19 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 19)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103005", "story_v_side_new_1108103.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103005", "story_v_side_new_1108103.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_side_new_1108103", "1108103005", "story_v_side_new_1108103.awb")

						arg_21_1:RecordAudio("1108103005", var_24_15)
						arg_21_1:RecordAudio("1108103005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103005", "story_v_side_new_1108103.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103005", "story_v_side_new_1108103.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play1108103006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1108103006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1108103007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1081ui_story = arg_25_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).z)
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles = arg_25_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_25_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1081ui_story"].transform.position).z)
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1081ui_story"].transform.localEulerAngles = arg_25_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1081ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1081ui_story == nil then
				arg_25_1.var_.characterEffect1081ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.0166666666666667

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1081ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1081ui_story then
				arg_25_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0
			local var_28_4 = 0.525

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1108103006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 21 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 21)

				if (21 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 21)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play1108103007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1108103007
		arg_29_1.duration_ = 6.87

		local var_29_0 = {
			ja = 6.866,
			ko = 5.866,
			zh = 5.866
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1108103008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1066ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1066ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1066ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1066ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1066ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1066ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1066ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1066ui_story == nil then
				arg_29_1.var_.characterEffect1066ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.0166666666666667

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1066ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1066ui_story then
				arg_29_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_8 = arg_29_1.actors_["1081ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1081ui_story = var_32_8.localPosition
			end

			local var_32_9 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_9 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_29_1.time_ - 0) / var_32_9)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_9 and arg_29_1.time_ < 0 + var_32_9 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_32_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_8.position).x, (manager.ui.mainCamera.transform.position - var_32_8.position).y, (manager.ui.mainCamera.transform.position - var_32_8.position).z)
				var_32_8.localEulerAngles.z = 0
				var_32_8.localEulerAngles.x = 0
				var_32_8.localEulerAngles = var_32_8.localEulerAngles
			end

			local var_32_10 = arg_29_1.actors_["1081ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1081ui_story == nil then
				arg_29_1.var_.characterEffect1081ui_story = var_32_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.0166666666666667

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_11 and not isNil(var_32_10) then
				if arg_29_1.var_.characterEffect1081ui_story and not isNil(var_32_10) then
					arg_29_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_11)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_11 and arg_29_1.time_ < 0 + var_32_11 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1081ui_story then
				arg_29_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_32_12 = 0
			local var_32_13 = 0.675

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(1108103007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 27 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 27)

				if (27 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 27)) > 0 and var_32_13 < var_32_17 then
					arg_29_1.talkMaxDuration = var_32_17

					if var_32_17 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103007", "story_v_side_new_1108103.awb") ~= 0 then
					local var_32_18 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103007", "story_v_side_new_1108103.awb") / 1000

					if var_32_18 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_12
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_side_new_1108103", "1108103007", "story_v_side_new_1108103.awb")

						arg_29_1:RecordAudio("1108103007", var_32_19)
						arg_29_1:RecordAudio("1108103007", var_32_19)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103007", "story_v_side_new_1108103.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103007", "story_v_side_new_1108103.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_20 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_20 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_20

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_20 and arg_29_1.time_ < var_32_12 + var_32_20 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play1108103008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1108103008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1108103009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1066ui_story"]) and arg_33_1.var_.characterEffect1066ui_story == nil then
				arg_33_1.var_.characterEffect1066ui_story = arg_33_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.0166666666666667

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1066ui_story"]) then
				if arg_33_1.var_.characterEffect1066ui_story and not isNil(arg_33_1.actors_["1066ui_story"]) then
					arg_33_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1066ui_story"]) and arg_33_1.var_.characterEffect1066ui_story then
				arg_33_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
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

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1108103008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 13 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 13)

				if (13 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 13)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1108103009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1108103009
		arg_37_1.duration_ = 6.03

		local var_37_0 = {
			ja = 5.533,
			ko = 6.033,
			zh = 6.033
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1108103010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1066ui_story = arg_37_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1066ui_story"].transform.position).z)
				arg_37_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1066ui_story"].transform.localEulerAngles = arg_37_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_37_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1066ui_story"].transform.position).z)
				arg_37_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1066ui_story"].transform.localEulerAngles = arg_37_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1066ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.0166666666666667

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1066ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1066ui_story then
				arg_37_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_4 = arg_37_1.actors_["1081ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1081ui_story = var_40_4.localPosition
			end

			local var_40_5 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 then
				var_40_4.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_37_1.time_ - 0) / var_40_5)
				var_40_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_4.position).x, (manager.ui.mainCamera.transform.position - var_40_4.position).y, (manager.ui.mainCamera.transform.position - var_40_4.position).z)
				var_40_4.localEulerAngles.z = 0
				var_40_4.localEulerAngles.x = 0
				var_40_4.localEulerAngles = var_40_4.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 then
				var_40_4.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_40_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_4.position).x, (manager.ui.mainCamera.transform.position - var_40_4.position).y, (manager.ui.mainCamera.transform.position - var_40_4.position).z)
				var_40_4.localEulerAngles.z = 0
				var_40_4.localEulerAngles.x = 0
				var_40_4.localEulerAngles = var_40_4.localEulerAngles
			end

			local var_40_6 = arg_37_1.actors_["1081ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect1081ui_story == nil then
				arg_37_1.var_.characterEffect1081ui_story = var_40_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_7 = 0.0166666666666667

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 and not isNil(var_40_6) then
				if arg_37_1.var_.characterEffect1081ui_story and not isNil(var_40_6) then
					arg_37_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_7)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect1081ui_story then
				arg_37_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_40_8 = 0
			local var_40_9 = 0.825

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_10 = arg_37_1:GetWordFromCfg(1108103009)
				local var_40_11 = arg_37_1:FormatText(var_40_10.content)

				arg_37_1.text_.text = var_40_11

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 33 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 33)

				if (33 <= 0 and var_40_9 or var_40_9 * (utf8.len(var_40_11) / 33)) > 0 and var_40_9 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_8
					end
				end

				arg_37_1.text_.text = var_40_11
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103009", "story_v_side_new_1108103.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103009", "story_v_side_new_1108103.awb") / 1000

					if var_40_14 + var_40_8 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_8
					end

					if var_40_10.prefab_name ~= "" and arg_37_1.actors_[var_40_10.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_10.prefab_name].transform, "story_v_side_new_1108103", "1108103009", "story_v_side_new_1108103.awb")

						arg_37_1:RecordAudio("1108103009", var_40_15)
						arg_37_1:RecordAudio("1108103009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103009", "story_v_side_new_1108103.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103009", "story_v_side_new_1108103.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_9, arg_37_1.talkMaxDuration)

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_8) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_8 + var_40_16 and arg_37_1.time_ < var_40_8 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1108103010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1108103010
		arg_41_1.duration_ = 8.67

		local var_41_0 = {
			ja = 8.666,
			ko = 5.033,
			zh = 5.033
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
				arg_41_0:Play1108103011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1066ui_story = arg_41_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).z)
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles = arg_41_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_41_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1066ui_story"].transform.position).z)
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1066ui_story"].transform.localEulerAngles = arg_41_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1066ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1066ui_story == nil then
				arg_41_1.var_.characterEffect1066ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.0166666666666667

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1066ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1066ui_story then
				arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = arg_41_1.actors_["1081ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1081ui_story = var_44_4.localPosition
			end

			local var_44_5 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 then
				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_41_1.time_ - 0) / var_44_5)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			local var_44_6 = arg_41_1.actors_["1081ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1081ui_story == nil then
				arg_41_1.var_.characterEffect1081ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_7 = 0.0166666666666667

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 and not isNil(var_44_6) then
				if arg_41_1.var_.characterEffect1081ui_story and not isNil(var_44_6) then
					arg_41_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_7)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1081ui_story then
				arg_41_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_44_8 = 0
			local var_44_9 = 0.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(1108103010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 26 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 26)

				if (26 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 26)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103010", "story_v_side_new_1108103.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103010", "story_v_side_new_1108103.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_side_new_1108103", "1108103010", "story_v_side_new_1108103.awb")

						arg_41_1:RecordAudio("1108103010", var_44_15)
						arg_41_1:RecordAudio("1108103010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103010", "story_v_side_new_1108103.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103010", "story_v_side_new_1108103.awb")
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
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108103011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1108103011
		arg_45_1.duration_ = 8.63

		local var_45_0 = {
			ja = 8.633,
			ko = 8.366,
			zh = 8.366
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1108103012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1081ui_story = arg_45_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).z)
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles = arg_45_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0.7, -0.92, -5.8)
				arg_45_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1081ui_story"].transform.position).z)
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1081ui_story"].transform.localEulerAngles = arg_45_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1081ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1081ui_story == nil then
				arg_45_1.var_.characterEffect1081ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.0166666666666667

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1081ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1081ui_story then
				arg_45_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_48_4 = arg_45_1.actors_["1066ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1066ui_story = var_48_4.localPosition
			end

			local var_48_5 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 then
				var_48_4.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_45_1.time_ - 0) / var_48_5)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 then
				var_48_4.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			local var_48_6 = arg_45_1.actors_["1066ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1066ui_story == nil then
				arg_45_1.var_.characterEffect1066ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.0166666666666667

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 and not isNil(var_48_6) then
				if arg_45_1.var_.characterEffect1066ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_7)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1066ui_story then
				arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_48_8 = 0
			local var_48_9 = 0.775

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(1108103011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 31 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 31)

				if (31 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 31)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103011", "story_v_side_new_1108103.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103011", "story_v_side_new_1108103.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_side_new_1108103", "1108103011", "story_v_side_new_1108103.awb")

						arg_45_1:RecordAudio("1108103011", var_48_15)
						arg_45_1:RecordAudio("1108103011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103011", "story_v_side_new_1108103.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103011", "story_v_side_new_1108103.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play1108103012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1108103012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1108103013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1081ui_story = arg_49_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1081ui_story"].transform.position).z)
				arg_49_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1081ui_story"].transform.localEulerAngles = arg_49_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1081ui_story"].transform.position).z)
				arg_49_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1081ui_story"].transform.localEulerAngles = arg_49_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1081ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1081ui_story == nil then
				arg_49_1.var_.characterEffect1081ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.0166666666666667

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1081ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_2)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1081ui_story then
				arg_49_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_52_3 = arg_49_1.actors_["1066ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1066ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0, 100, 0)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = 0
			local var_52_6 = 1.1

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1108103012).content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 44 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 44)

				if (44 <= 0 and var_52_6 or var_52_6 * (utf8.len(var_52_7) / 44)) > 0 and var_52_6 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_10 and arg_49_1.time_ < var_52_5 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play1108103013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1108103013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1108103014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1081ui_story = arg_53_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).z)
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles = arg_53_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_53_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1081ui_story"].transform.position).z)
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1081ui_story"].transform.localEulerAngles = arg_53_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1081ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1081ui_story == nil then
				arg_53_1.var_.characterEffect1081ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.0166666666666667

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1081ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_2)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1081ui_story then
				arg_53_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_56_3 = 0
			local var_56_4 = 0.1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
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

				local var_56_5 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1108103013).content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 4 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 4)

				if (4 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 4)) > 0 and var_56_4 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_8 and arg_53_1.time_ < var_56_3 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108103014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1108103014
		arg_57_1.duration_ = 2.93

		local var_57_0 = {
			ja = 1.999999999999,
			ko = 2.933,
			zh = 2.933
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
				arg_57_0:Play1108103015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1081ui_story = arg_57_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).z)
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles = arg_57_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_57_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1081ui_story"].transform.position).z)
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1081ui_story"].transform.localEulerAngles = arg_57_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1081ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1081ui_story == nil then
				arg_57_1.var_.characterEffect1081ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.0166666666666667

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1081ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1081ui_story then
				arg_57_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.275

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(1108103014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 11 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 11)

				if (11 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 11)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103014", "story_v_side_new_1108103.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103014", "story_v_side_new_1108103.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_new_1108103", "1108103014", "story_v_side_new_1108103.awb")

						arg_57_1:RecordAudio("1108103014", var_60_11)
						arg_57_1:RecordAudio("1108103014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103014", "story_v_side_new_1108103.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103014", "story_v_side_new_1108103.awb")
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
				actorName = "1081ui_story",
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
	Play1108103015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1108103015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1108103016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1081ui_story = arg_61_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).z)
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles = arg_61_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_61_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1081ui_story"].transform.position).z)
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1081ui_story"].transform.localEulerAngles = arg_61_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1081ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1081ui_story == nil then
				arg_61_1.var_.characterEffect1081ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.0166666666666667

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1081ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1081ui_story then
				arg_61_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_64_3 = 0
			local var_64_4 = 0.3

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1108103015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 12 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 12)

				if (12 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 12)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108103016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1108103016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1108103017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1081ui_story = arg_65_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).z)
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles = arg_65_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_65_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1081ui_story"].transform.position).z)
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1081ui_story"].transform.localEulerAngles = arg_65_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1081ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1081ui_story == nil then
				arg_65_1.var_.characterEffect1081ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.0166666666666667

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1081ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_2)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1081ui_story then
				arg_65_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_68_3 = 0
			local var_68_4 = 0.525

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1108103016).content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 21 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 21)

				if (21 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_5) / 21)) > 0 and var_68_4 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_3
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_4, arg_65_1.talkMaxDuration)

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_3) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_3 + var_68_8 and arg_65_1.time_ < var_68_3 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108103017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1108103017
		arg_69_1.duration_ = 8.37

		local var_69_0 = {
			ja = 7.1,
			ko = 8.366,
			zh = 8.366
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
				arg_69_0:Play1108103018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1081ui_story = arg_69_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).z)
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles = arg_69_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_69_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1081ui_story"].transform.position).z)
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1081ui_story"].transform.localEulerAngles = arg_69_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1081ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1081ui_story == nil then
				arg_69_1.var_.characterEffect1081ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.0166666666666667

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1081ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1081ui_story then
				arg_69_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.775

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(1108103017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 31 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 31)

				if (31 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 31)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103017", "story_v_side_new_1108103.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103017", "story_v_side_new_1108103.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_side_new_1108103", "1108103017", "story_v_side_new_1108103.awb")

						arg_69_1:RecordAudio("1108103017", var_72_11)
						arg_69_1:RecordAudio("1108103017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103017", "story_v_side_new_1108103.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103017", "story_v_side_new_1108103.awb")
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

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play1108103018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1108103018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1108103019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1081ui_story = arg_73_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).z)
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles = arg_73_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_73_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1081ui_story"].transform.position).z)
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1081ui_story"].transform.localEulerAngles = arg_73_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1081ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1081ui_story == nil then
				arg_73_1.var_.characterEffect1081ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.0166666666666667

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1081ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_2)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1081ui_story then
				arg_73_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_76_3 = 0
			local var_76_4 = 0.1

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_5 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1108103018).content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 4 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 4)

				if (4 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 4)) > 0 and var_76_4 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_8 and arg_73_1.time_ < var_76_3 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108103019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1108103019
		arg_77_1.duration_ = 5.8

		local var_77_0 = {
			ja = 5.8,
			ko = 2.833,
			zh = 2.833
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1108103020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1081ui_story = arg_77_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).z)
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles = arg_77_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_77_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1081ui_story"].transform.position).z)
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1081ui_story"].transform.localEulerAngles = arg_77_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1081ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1081ui_story == nil then
				arg_77_1.var_.characterEffect1081ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.0166666666666667

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1081ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1081ui_story then
				arg_77_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_80_4 = 0
			local var_80_5 = 0.3

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(1108103019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 12 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 12)

				if (12 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 12)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103019", "story_v_side_new_1108103.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103019", "story_v_side_new_1108103.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_side_new_1108103", "1108103019", "story_v_side_new_1108103.awb")

						arg_77_1:RecordAudio("1108103019", var_80_11)
						arg_77_1:RecordAudio("1108103019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103019", "story_v_side_new_1108103.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103019", "story_v_side_new_1108103.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play1108103020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1108103020
		arg_81_1.duration_ = 2.27

		local var_81_0 = {
			ja = 1.999999999999,
			ko = 2.266,
			zh = 2.266
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
				arg_81_0:Play1108103021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_84_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_81_1.stage_.transform)

				var_84_0.name = "1080ui_story"
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1080ui_story"] = var_84_0

				local var_84_1 = var_84_0:GetComponentInChildren(typeof(CharacterEffect))

				var_84_1.enabled = true

				local var_84_2 = GameObjectTools.GetOrAddComponent(var_84_0, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(false)
				end

				arg_81_1:ShowWeapon(var_84_1.transform, false)

				arg_81_1.var_["1080ui_story" .. "Animator"] = var_84_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_81_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_81_1.var_["1080ui_story" .. "LipSync"] = var_84_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_84_3 = arg_81_1.actors_["1080ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1080ui_story = var_84_3.localPosition
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_3.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_81_1.time_ - 0) / var_84_4)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_3.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			local var_84_5 = arg_81_1.actors_["1080ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1080ui_story == nil then
				arg_81_1.var_.characterEffect1080ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.0166666666666667

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.characterEffect1080ui_story and not isNil(var_84_5) then
					arg_81_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1080ui_story then
				arg_81_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_8 = "1027ui_story"

			if arg_81_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_84_9 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_81_1.stage_.transform)

				var_84_9.name = var_84_8
				var_84_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_[var_84_8] = var_84_9

				local var_84_10 = var_84_9:GetComponentInChildren(typeof(CharacterEffect))

				var_84_10.enabled = true

				local var_84_11 = GameObjectTools.GetOrAddComponent(var_84_9, typeof(DynamicBoneHelper))

				if var_84_11 then
					var_84_11:EnableDynamicBone(false)
				end

				arg_81_1:ShowWeapon(var_84_10.transform, false)

				arg_81_1.var_[var_84_8 .. "Animator"] = var_84_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_81_1.var_[var_84_8 .. "Animator"].applyRootMotion = true
				arg_81_1.var_[var_84_8 .. "LipSync"] = var_84_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_84_12 = arg_81_1.actors_["1027ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1027ui_story = var_84_12.localPosition
			end

			local var_84_13 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_13 then
				var_84_12.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_81_1.time_ - 0) / var_84_13)
				var_84_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_12.position).x, (manager.ui.mainCamera.transform.position - var_84_12.position).y, (manager.ui.mainCamera.transform.position - var_84_12.position).z)
				var_84_12.localEulerAngles.z = 0
				var_84_12.localEulerAngles.x = 0
				var_84_12.localEulerAngles = var_84_12.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_13 and arg_81_1.time_ < 0 + var_84_13 + arg_84_0 then
				var_84_12.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_84_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_12.position).x, (manager.ui.mainCamera.transform.position - var_84_12.position).y, (manager.ui.mainCamera.transform.position - var_84_12.position).z)
				var_84_12.localEulerAngles.z = 0
				var_84_12.localEulerAngles.x = 0
				var_84_12.localEulerAngles = var_84_12.localEulerAngles
			end

			local var_84_14 = arg_81_1.actors_["1027ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect1027ui_story == nil then
				arg_81_1.var_.characterEffect1027ui_story = var_84_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_15 = 0.0166666666666667

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_15 and not isNil(var_84_14) then
				if arg_81_1.var_.characterEffect1027ui_story and not isNil(var_84_14) then
					arg_81_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_15)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_15 and arg_81_1.time_ < 0 + var_84_15 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.characterEffect1027ui_story then
				arg_81_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_84_16 = arg_81_1.actors_["1081ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1081ui_story = var_84_16.localPosition
			end

			local var_84_17 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_17 then
				var_84_16.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_17)
				var_84_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_16.position).x, (manager.ui.mainCamera.transform.position - var_84_16.position).y, (manager.ui.mainCamera.transform.position - var_84_16.position).z)
				var_84_16.localEulerAngles.z = 0
				var_84_16.localEulerAngles.x = 0
				var_84_16.localEulerAngles = var_84_16.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_17 and arg_81_1.time_ < 0 + var_84_17 + arg_84_0 then
				var_84_16.localPosition = Vector3.New(0, 100, 0)
				var_84_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_16.position).x, (manager.ui.mainCamera.transform.position - var_84_16.position).y, (manager.ui.mainCamera.transform.position - var_84_16.position).z)
				var_84_16.localEulerAngles.z = 0
				var_84_16.localEulerAngles.x = 0
				var_84_16.localEulerAngles = var_84_16.localEulerAngles
			end

			local var_84_18 = arg_81_1.actors_["1081ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_18) and arg_81_1.var_.characterEffect1081ui_story == nil then
				arg_81_1.var_.characterEffect1081ui_story = var_84_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_19 = 0.0166666666666667

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_19 and not isNil(var_84_18) then
				if arg_81_1.var_.characterEffect1081ui_story and not isNil(var_84_18) then
					arg_81_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_19)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_19 and arg_81_1.time_ < 0 + var_84_19 + arg_84_0 and not isNil(var_84_18) and arg_81_1.var_.characterEffect1081ui_story then
				arg_81_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_84_20 = 0
			local var_84_21 = 0.175

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_20 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_22 = arg_81_1:GetWordFromCfg(1108103020)
				local var_84_23 = arg_81_1:FormatText(var_84_22.content)

				arg_81_1.text_.text = var_84_23

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_25 = 7 <= 0 and var_84_21 or var_84_21 * (utf8.len(var_84_23) / 7)

				if (7 <= 0 and var_84_21 or var_84_21 * (utf8.len(var_84_23) / 7)) > 0 and var_84_21 < var_84_25 then
					arg_81_1.talkMaxDuration = var_84_25

					if var_84_25 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_25 + var_84_20
					end
				end

				arg_81_1.text_.text = var_84_23
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103020", "story_v_side_new_1108103.awb") ~= 0 then
					local var_84_26 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103020", "story_v_side_new_1108103.awb") / 1000

					if var_84_26 + var_84_20 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_26 + var_84_20
					end

					if var_84_22.prefab_name ~= "" and arg_81_1.actors_[var_84_22.prefab_name] ~= nil then
						local var_84_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_22.prefab_name].transform, "story_v_side_new_1108103", "1108103020", "story_v_side_new_1108103.awb")

						arg_81_1:RecordAudio("1108103020", var_84_27)
						arg_81_1:RecordAudio("1108103020", var_84_27)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103020", "story_v_side_new_1108103.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103020", "story_v_side_new_1108103.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_28 = math.max(var_84_21, arg_81_1.talkMaxDuration)

			if var_84_20 <= arg_81_1.time_ and arg_81_1.time_ < var_84_20 + var_84_28 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_20) / var_84_28

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_20 + var_84_28 and arg_81_1.time_ < var_84_20 + var_84_28 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108103021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1108103021
		arg_85_1.duration_ = 3.37

		local var_85_0 = {
			ja = 2.666,
			ko = 3.366,
			zh = 3.366
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
				arg_85_0:Play1108103022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1080ui_story = arg_85_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1080ui_story"].transform.position).z)
				arg_85_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1080ui_story"].transform.localEulerAngles = arg_85_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_85_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1080ui_story"].transform.position).z)
				arg_85_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1080ui_story"].transform.localEulerAngles = arg_85_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1080ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1080ui_story == nil then
				arg_85_1.var_.characterEffect1080ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.0166666666666667

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1080ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1080ui_story then
				arg_85_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_88_3 = arg_85_1.actors_["1027ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1027ui_story = var_88_3.localPosition
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_3.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_85_1.time_ - 0) / var_88_4)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_3.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			local var_88_5 = arg_85_1.actors_["1027ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1027ui_story == nil then
				arg_85_1.var_.characterEffect1027ui_story = var_88_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.0166666666666667

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.characterEffect1027ui_story and not isNil(var_88_5) then
					arg_85_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1027ui_story then
				arg_85_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			local var_88_8 = 0
			local var_88_9 = 0.325

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(1108103021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 13 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 13)

				if (13 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 13)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103021", "story_v_side_new_1108103.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103021", "story_v_side_new_1108103.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_side_new_1108103", "1108103021", "story_v_side_new_1108103.awb")

						arg_85_1:RecordAudio("1108103021", var_88_15)
						arg_85_1:RecordAudio("1108103021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103021", "story_v_side_new_1108103.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103021", "story_v_side_new_1108103.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1108103022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1108103022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1108103023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1080ui_story = arg_89_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).z)
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles = arg_89_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_89_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1080ui_story"].transform.position).z)
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1080ui_story"].transform.localEulerAngles = arg_89_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1080ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1080ui_story == nil then
				arg_89_1.var_.characterEffect1080ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.0166666666666667

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1080ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_2)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1080ui_story then
				arg_89_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_92_3 = arg_89_1.actors_["1027ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1027ui_story = var_92_3.localPosition
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_3.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_89_1.time_ - 0) / var_92_4)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_3.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			local var_92_5 = arg_89_1.actors_["1027ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect1027ui_story == nil then
				arg_89_1.var_.characterEffect1027ui_story = var_92_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_6 = 0.0166666666666667

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.characterEffect1027ui_story and not isNil(var_92_5) then
					arg_89_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_6)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_6 and arg_89_1.time_ < 0 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect1027ui_story then
				arg_89_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_2")
			end

			local var_92_7 = 0
			local var_92_8 = 0.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_9 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1108103022).content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 19 <= 0 and var_92_8 or var_92_8 * (utf8.len(var_92_9) / 19)

				if (19 <= 0 and var_92_8 or var_92_8 * (utf8.len(var_92_9) / 19)) > 0 and var_92_8 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_7 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_7
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_8, arg_89_1.talkMaxDuration)

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_7) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_7 + var_92_12 and arg_89_1.time_ < var_92_7 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1108103023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1108103023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1108103024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.35

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

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1108103023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 14 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 14)

				if (14 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 14)) > 0 and var_96_0 < var_96_3 then
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
	Play1108103024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1108103024
		arg_97_1.duration_ = 8.03

		local var_97_0 = {
			ja = 8.033,
			ko = 6.4,
			zh = 6.4
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
				arg_97_0:Play1108103025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1080ui_story = arg_97_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1080ui_story"].transform.position).z)
				arg_97_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1080ui_story"].transform.localEulerAngles = arg_97_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_97_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1080ui_story"].transform.position).z)
				arg_97_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1080ui_story"].transform.localEulerAngles = arg_97_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1080ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1080ui_story == nil then
				arg_97_1.var_.characterEffect1080ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.0166666666666667

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1080ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_2)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1080ui_story then
				arg_97_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_100_3 = arg_97_1.actors_["1027ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1027ui_story = var_100_3.localPosition
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_97_1.time_ - 0) / var_100_4)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			local var_100_5 = arg_97_1.actors_["1027ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect1027ui_story == nil then
				arg_97_1.var_.characterEffect1027ui_story = var_100_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.0166666666666667

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.characterEffect1027ui_story and not isNil(var_100_5) then
					arg_97_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect1027ui_story then
				arg_97_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_100_8 = 0
			local var_100_9 = 0.8

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(1108103024)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 32 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 32)

				if (32 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 32)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103024", "story_v_side_new_1108103.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103024", "story_v_side_new_1108103.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_side_new_1108103", "1108103024", "story_v_side_new_1108103.awb")

						arg_97_1:RecordAudio("1108103024", var_100_15)
						arg_97_1:RecordAudio("1108103024", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103024", "story_v_side_new_1108103.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103024", "story_v_side_new_1108103.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1108103025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1108103025
		arg_101_1.duration_ = 4.7

		local var_101_0 = {
			ja = 4.7,
			ko = 3.166,
			zh = 3.166
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
				arg_101_0:Play1108103026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1080ui_story = arg_101_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).z)
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles = arg_101_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_101_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1080ui_story"].transform.position).z)
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1080ui_story"].transform.localEulerAngles = arg_101_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1080ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1080ui_story == nil then
				arg_101_1.var_.characterEffect1080ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.0166666666666667

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1080ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1080ui_story then
				arg_101_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = arg_101_1.actors_["1027ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1027ui_story = var_104_4.localPosition
			end

			local var_104_5 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 then
				var_104_4.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_101_1.time_ - 0) / var_104_5)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 then
				var_104_4.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_104_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_4.position).x, (manager.ui.mainCamera.transform.position - var_104_4.position).y, (manager.ui.mainCamera.transform.position - var_104_4.position).z)
				var_104_4.localEulerAngles.z = 0
				var_104_4.localEulerAngles.x = 0
				var_104_4.localEulerAngles = var_104_4.localEulerAngles
			end

			local var_104_6 = arg_101_1.actors_["1027ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1027ui_story == nil then
				arg_101_1.var_.characterEffect1027ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.0166666666666667

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_6) then
				if arg_101_1.var_.characterEffect1027ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_7)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1027ui_story then
				arg_101_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_104_8 = 0
			local var_104_9 = 0.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(1108103025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 11 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 11)

				if (11 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 11)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103025", "story_v_side_new_1108103.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103025", "story_v_side_new_1108103.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_side_new_1108103", "1108103025", "story_v_side_new_1108103.awb")

						arg_101_1:RecordAudio("1108103025", var_104_15)
						arg_101_1:RecordAudio("1108103025", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103025", "story_v_side_new_1108103.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103025", "story_v_side_new_1108103.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1108103026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1108103026
		arg_105_1.duration_ = 4.93

		local var_105_0 = {
			ja = 2.266,
			ko = 4.933,
			zh = 4.933
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
				arg_105_0:Play1108103027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1080ui_story = arg_105_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1080ui_story"].transform.position).z)
				arg_105_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1080ui_story"].transform.localEulerAngles = arg_105_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_105_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1080ui_story"].transform.position).z)
				arg_105_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1080ui_story"].transform.localEulerAngles = arg_105_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1080ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1080ui_story == nil then
				arg_105_1.var_.characterEffect1080ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.0166666666666667

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1080ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_2)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1080ui_story then
				arg_105_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_108_3 = arg_105_1.actors_["1027ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1027ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = arg_105_1.actors_["1027ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1027ui_story == nil then
				arg_105_1.var_.characterEffect1027ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.0166666666666667

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect1027ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1027ui_story then
				arg_105_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_108_8 = 0
			local var_108_9 = 0.525

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(1108103026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 21 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 21)

				if (21 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 21)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103026", "story_v_side_new_1108103.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103026", "story_v_side_new_1108103.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_side_new_1108103", "1108103026", "story_v_side_new_1108103.awb")

						arg_105_1:RecordAudio("1108103026", var_108_15)
						arg_105_1:RecordAudio("1108103026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103026", "story_v_side_new_1108103.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103026", "story_v_side_new_1108103.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1108103027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1108103027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1108103028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1080ui_story = arg_109_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1080ui_story"].transform.position).z)
				arg_109_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1080ui_story"].transform.localEulerAngles = arg_109_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_109_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1080ui_story"].transform.position).z)
				arg_109_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1080ui_story"].transform.localEulerAngles = arg_109_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1080ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1080ui_story == nil then
				arg_109_1.var_.characterEffect1080ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.0166666666666667

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1080ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1080ui_story then
				arg_109_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_112_3 = arg_109_1.actors_["1027ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1027ui_story = var_112_3.localPosition
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_3.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_109_1.time_ - 0) / var_112_4)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_3.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			local var_112_5 = arg_109_1.actors_["1027ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1027ui_story == nil then
				arg_109_1.var_.characterEffect1027ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.0166666666666667

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect1027ui_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_6)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1027ui_story then
				arg_109_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_112_7 = 0
			local var_112_8 = 0.425

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
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

				local var_112_9 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1108103027).content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 17 <= 0 and var_112_8 or var_112_8 * (utf8.len(var_112_9) / 17)

				if (17 <= 0 and var_112_8 or var_112_8 * (utf8.len(var_112_9) / 17)) > 0 and var_112_8 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_7 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_7
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_8, arg_109_1.talkMaxDuration)

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_7) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_7 + var_112_12 and arg_109_1.time_ < var_112_7 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1108103028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1108103028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1108103029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1080ui_story = arg_113_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).z)
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles = arg_113_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_113_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1080ui_story"].transform.position).z)
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1080ui_story"].transform.localEulerAngles = arg_113_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1080ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1080ui_story == nil then
				arg_113_1.var_.characterEffect1080ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.0166666666666667

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1080ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_2)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1080ui_story then
				arg_113_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_116_3 = arg_113_1.actors_["1027ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1027ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = arg_113_1.actors_["1027ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect1027ui_story == nil then
				arg_113_1.var_.characterEffect1027ui_story = var_116_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.0166666666666667

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.characterEffect1027ui_story and not isNil(var_116_5) then
					arg_113_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_6)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect1027ui_story then
				arg_113_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_116_7 = 0
			local var_116_8 = 0.775

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_9 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1108103028).content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 31 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_9) / 31)

				if (31 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_9) / 31)) > 0 and var_116_8 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_7 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_7
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_8, arg_113_1.talkMaxDuration)

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_7) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_7 + var_116_12 and arg_113_1.time_ < var_116_7 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play1108103029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1108103029
		arg_117_1.duration_ = 5.03

		local var_117_0 = {
			ja = 5.033,
			ko = 3.333,
			zh = 3.333
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1108103030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1080ui_story = arg_117_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).z)
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles = arg_117_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_117_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1080ui_story"].transform.position).z)
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1080ui_story"].transform.localEulerAngles = arg_117_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1080ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1080ui_story == nil then
				arg_117_1.var_.characterEffect1080ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.0166666666666667

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1080ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_2)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1080ui_story then
				arg_117_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_120_3 = arg_117_1.actors_["1027ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1027ui_story = var_120_3.localPosition
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_117_1.time_ - 0) / var_120_4)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			local var_120_5 = arg_117_1.actors_["1027ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1027ui_story == nil then
				arg_117_1.var_.characterEffect1027ui_story = var_120_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_6 = 0.0166666666666667

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.characterEffect1027ui_story and not isNil(var_120_5) then
					arg_117_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.characterEffect1027ui_story then
				arg_117_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_120_8 = 0
			local var_120_9 = 0.35

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:GetWordFromCfg(1108103029)
				local var_120_11 = arg_117_1:FormatText(var_120_10.content)

				arg_117_1.text_.text = var_120_11

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_13 = 14 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 14)

				if (14 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_11) / 14)) > 0 and var_120_9 < var_120_13 then
					arg_117_1.talkMaxDuration = var_120_13

					if var_120_13 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_13 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_11
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103029", "story_v_side_new_1108103.awb") ~= 0 then
					local var_120_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103029", "story_v_side_new_1108103.awb") / 1000

					if var_120_14 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_8
					end

					if var_120_10.prefab_name ~= "" and arg_117_1.actors_[var_120_10.prefab_name] ~= nil then
						local var_120_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_10.prefab_name].transform, "story_v_side_new_1108103", "1108103029", "story_v_side_new_1108103.awb")

						arg_117_1:RecordAudio("1108103029", var_120_15)
						arg_117_1:RecordAudio("1108103029", var_120_15)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103029", "story_v_side_new_1108103.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103029", "story_v_side_new_1108103.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_16 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_16 and arg_117_1.time_ < var_120_8 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play1108103030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1108103030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1108103031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1080ui_story = arg_121_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1080ui_story"].transform.position).z)
				arg_121_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1080ui_story"].transform.localEulerAngles = arg_121_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1080ui_story"].transform.position).z)
				arg_121_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1080ui_story"].transform.localEulerAngles = arg_121_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1080ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1080ui_story == nil then
				arg_121_1.var_.characterEffect1080ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.0166666666666667

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1080ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1080ui_story then
				arg_121_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_124_3 = arg_121_1.actors_["1027ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1027ui_story = var_124_3.localPosition
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_4)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, 100, 0)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			local var_124_5 = arg_121_1.actors_["1027ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1027ui_story == nil then
				arg_121_1.var_.characterEffect1027ui_story = var_124_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.0166666666666667

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.characterEffect1027ui_story and not isNil(var_124_5) then
					arg_121_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_6)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.characterEffect1027ui_story then
				arg_121_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_124_7 = 0
			local var_124_8 = 0.075

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_9 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1108103030).content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 3 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_9) / 3)

				if (3 <= 0 and var_124_8 or var_124_8 * (utf8.len(var_124_9) / 3)) > 0 and var_124_8 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_7 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_7
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_8, arg_121_1.talkMaxDuration)

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_7) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_7 + var_124_12 and arg_121_1.time_ < var_124_7 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1108103031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1108103031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1108103032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.125

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

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1108103031).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 5 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 5)

				if (5 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 5)) > 0 and var_128_0 < var_128_3 then
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
	Play1108103032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1108103032
		arg_129_1.duration_ = 2.97

		local var_129_0 = {
			ja = 2.966,
			ko = 2.8,
			zh = 2.8
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
				arg_129_0:Play1108103033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1081ui_story = arg_129_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).z)
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles = arg_129_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_129_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).z)
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles = arg_129_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1081ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1081ui_story == nil then
				arg_129_1.var_.characterEffect1081ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.0166666666666667

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1081ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1081ui_story then
				arg_129_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.225

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(1108103032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 9 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 9)

				if (9 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 9)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103032", "story_v_side_new_1108103.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103032", "story_v_side_new_1108103.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_new_1108103", "1108103032", "story_v_side_new_1108103.awb")

						arg_129_1:RecordAudio("1108103032", var_132_11)
						arg_129_1:RecordAudio("1108103032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103032", "story_v_side_new_1108103.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103032", "story_v_side_new_1108103.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play1108103033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1108103033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1108103034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1081ui_story = arg_133_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).z)
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles = arg_133_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_133_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).z)
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles = arg_133_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1081ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1081ui_story == nil then
				arg_133_1.var_.characterEffect1081ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1081ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_2)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1081ui_story then
				arg_133_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_136_3 = 0
			local var_136_4 = 0.225

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1108103033).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 9 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 9)

				if (9 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 9)) > 0 and var_136_4 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_8 and arg_133_1.time_ < var_136_3 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play1108103034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1108103034
		arg_137_1.duration_ = 9

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1108103035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 then
				arg_137_1.var_.moveOldPos1081ui_story = arg_137_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 2 <= arg_137_1.time_ and arg_137_1.time_ < 2 + var_140_0 then
				arg_137_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 2) / var_140_0)
				arg_137_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).z)
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles = arg_137_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 2 + var_140_0 and arg_137_1.time_ < 2 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).z)
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles = arg_137_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1081ui_story"]

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= 2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1081ui_story == nil then
				arg_137_1.var_.characterEffect1081ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.0166666666666667

			if 2 <= arg_137_1.time_ and arg_137_1.time_ < 2 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1081ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 2) / var_140_2)
				end
			end

			if arg_137_1.time_ >= 2 + var_140_2 and arg_137_1.time_ < 2 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1081ui_story then
				arg_137_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_140_3 = 0

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_4 = 2

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_4 then
				local var_140_5 = Color.New(0, 0, 0)

				var_140_5.a = Mathf.Lerp(0, 1, (arg_137_1.time_ - var_140_3) / var_140_4)
				arg_137_1.mask_.color = var_140_5
			end

			if arg_137_1.time_ >= var_140_3 + var_140_4 and arg_137_1.time_ < var_140_3 + var_140_4 + arg_140_0 then
				local var_140_6 = Color.New(0, 0, 0)

				var_140_6.a = 1
				arg_137_1.mask_.color = var_140_6
			end

			local var_140_7 = 2

			if 2 < arg_137_1.time_ and arg_137_1.time_ <= var_140_7 + arg_140_0 then
				arg_137_1.mask_.enabled = true
				arg_137_1.mask_.raycastTarget = true

				arg_137_1:SetGaussion(false)
			end

			local var_140_8 = 2

			if var_140_7 <= arg_137_1.time_ and arg_137_1.time_ < var_140_7 + var_140_8 then
				local var_140_9 = Color.New(0, 0, 0)

				var_140_9.a = Mathf.Lerp(1, 0, (arg_137_1.time_ - var_140_7) / var_140_8)
				arg_137_1.mask_.color = var_140_9
			end

			if arg_137_1.time_ >= var_140_7 + var_140_8 and arg_137_1.time_ < var_140_7 + var_140_8 + arg_140_0 then
				local var_140_10 = Color.New(0, 0, 0)

				arg_137_1.mask_.enabled = false
				var_140_10.a = 0
				arg_137_1.mask_.color = var_140_10
			end

			if arg_137_1.frameCnt_ <= 1 then
				arg_137_1.dialog_:SetActive(false)
			end

			local var_140_11 = 4
			local var_140_12 = 0.375

			if 4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				arg_137_1.dialog_:SetActive(true)

				arg_137_1.dialogCg_.alpha = 0

				local var_140_13 = LeanTween.value(arg_137_1.dialog_, 0, 1, 0.3)

				var_140_13:setOnUpdate(LuaHelper.FloatAction(function(arg_141_0)
					arg_137_1.dialogCg_.alpha = arg_141_0
				end))
				var_140_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_137_1.dialog_)
					var_140_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_137_1.duration_ = arg_137_1.duration_ + 0.3

				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_14 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1108103034).content)

				arg_137_1.text_.text = var_140_14

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_16 = 15 <= 0 and var_140_12 or var_140_12 * (utf8.len(var_140_14) / 15)

				if (15 <= 0 and var_140_12 or var_140_12 * (utf8.len(var_140_14) / 15)) > 0 and var_140_12 < var_140_16 then
					arg_137_1.talkMaxDuration = var_140_16
					var_140_11 = var_140_11 + 0.3

					if var_140_16 + var_140_11 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_11
					end
				end

				arg_137_1.text_.text = var_140_14
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_17 = var_140_11 + 0.3
			local var_140_18 = math.max(var_140_12, arg_137_1.talkMaxDuration)

			if var_140_11 + 0.3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_17 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_17) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_17 + var_140_18 and arg_137_1.time_ < var_140_17 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play1108103035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1108103035
		arg_143_1.duration_ = 6.4

		local var_143_0 = {
			ja = 6.4,
			ko = 5.7,
			zh = 5.7
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
				arg_143_0:Play1108103036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1066ui_story = arg_143_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).z)
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles = arg_143_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_143_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1066ui_story"].transform.position).z)
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1066ui_story"].transform.localEulerAngles = arg_143_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1066ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1066ui_story == nil then
				arg_143_1.var_.characterEffect1066ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.0166666666666667

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1066ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1066ui_story then
				arg_143_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_146_4 = 0
			local var_146_5 = 0.675

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(1108103035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 27 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 27)

				if (27 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 27)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103035", "story_v_side_new_1108103.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103035", "story_v_side_new_1108103.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_side_new_1108103", "1108103035", "story_v_side_new_1108103.awb")

						arg_143_1:RecordAudio("1108103035", var_146_11)
						arg_143_1:RecordAudio("1108103035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103035", "story_v_side_new_1108103.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103035", "story_v_side_new_1108103.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1108103036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1108103036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1108103037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1066ui_story = arg_147_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1066ui_story"].transform.position).z)
				arg_147_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1066ui_story"].transform.localEulerAngles = arg_147_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_147_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1066ui_story"].transform.position).z)
				arg_147_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1066ui_story"].transform.localEulerAngles = arg_147_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1066ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1066ui_story == nil then
				arg_147_1.var_.characterEffect1066ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.0166666666666667

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1066ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_2)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1066ui_story then
				arg_147_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_150_3 = 0
			local var_150_4 = 0.225

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_5 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1108103036).content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 9 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 9)

				if (9 <= 0 and var_150_4 or var_150_4 * (utf8.len(var_150_5) / 9)) > 0 and var_150_4 < var_150_7 then
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
				actorName = "1066ui_story",
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
	Play1108103037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1108103037
		arg_151_1.duration_ = 2.07

		local var_151_0 = {
			ja = 1.999999999999,
			ko = 2.066,
			zh = 2.066
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1108103038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1066ui_story = arg_151_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).z)
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles = arg_151_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_151_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1066ui_story"].transform.position).z)
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1066ui_story"].transform.localEulerAngles = arg_151_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1066ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1066ui_story == nil then
				arg_151_1.var_.characterEffect1066ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.0166666666666667

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1066ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1066ui_story then
				arg_151_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_2")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_4 = 0
			local var_154_5 = 0.15

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(1108103037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 6 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 6)

				if (6 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 6)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103037", "story_v_side_new_1108103.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103037", "story_v_side_new_1108103.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_side_new_1108103", "1108103037", "story_v_side_new_1108103.awb")

						arg_151_1:RecordAudio("1108103037", var_154_11)
						arg_151_1:RecordAudio("1108103037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103037", "story_v_side_new_1108103.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103037", "story_v_side_new_1108103.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play1108103038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1108103038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1108103039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1066ui_story = arg_155_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).z)
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles = arg_155_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1066ui_story"].transform.position).z)
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1066ui_story"].transform.localEulerAngles = arg_155_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1066ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1066ui_story == nil then
				arg_155_1.var_.characterEffect1066ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.0166666666666667

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1066ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_2)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1066ui_story then
				arg_155_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_158_3 = 0
			local var_158_4 = 1.275

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_5 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1108103038).content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 51 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 51)

				if (51 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 51)) > 0 and var_158_4 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_3
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_4, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_3) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_8 and arg_155_1.time_ < var_158_3 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
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
	Play1108103039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1108103039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1108103040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.3

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1108103039).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 52 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 52)

				if (52 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 52)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1108103040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1108103040
		arg_163_1.duration_ = 4.47

		local var_163_0 = {
			ja = 4.466,
			ko = 3.5,
			zh = 3.5
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
				arg_163_0:Play1108103041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.25

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:GetWordFromCfg(1108103040)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 10 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 10)

				if (10 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 10)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103040", "story_v_side_new_1108103.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103040", "story_v_side_new_1108103.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_side_new_1108103", "1108103040", "story_v_side_new_1108103.awb")

						arg_163_1:RecordAudio("1108103040", var_166_6)
						arg_163_1:RecordAudio("1108103040", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103040", "story_v_side_new_1108103.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103040", "story_v_side_new_1108103.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1108103041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1108103041
		arg_167_1.duration_ = 9

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1108103042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if arg_167_1.bgs_.ST17 == nil then
				local var_170_0 = Object.Instantiate(arg_167_1.paintGo_)

				var_170_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_170_0.name = "ST17"
				var_170_0.transform.parent = arg_167_1.stage_.transform
				var_170_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.bgs_.ST17 = var_170_0
			end

			if 2 < arg_167_1.time_ and arg_167_1.time_ <= 2 + arg_170_0 then
				local var_170_1 = arg_167_1.bgs_.ST17

				arg_167_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_170_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_170_2 = var_170_1:GetComponent("SpriteRenderer")

				if var_170_2 and var_170_2.sprite then
					local var_170_3 = 2 * (var_170_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_170_1.transform.localScale = Vector3.New(var_170_3 / var_170_2.sprite.bounds.size.y < var_170_3 * manager.ui.mainCameraCom_.aspect / var_170_2.sprite.bounds.size.x and var_170_3 * manager.ui.mainCameraCom_.aspect / var_170_2.sprite.bounds.size.x or var_170_3 / var_170_2.sprite.bounds.size.y, var_170_3 / var_170_2.sprite.bounds.size.y < var_170_3 * manager.ui.mainCameraCom_.aspect / var_170_2.sprite.bounds.size.x and var_170_3 * manager.ui.mainCameraCom_.aspect / var_170_2.sprite.bounds.size.x or var_170_3 / var_170_2.sprite.bounds.size.y, 0)
				end

				for iter_170_0, iter_170_1 in pairs(arg_167_1.bgs_) do
					if iter_170_0 ~= "ST17" then
						iter_170_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_170_4 = 0

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_5 = 2

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_5 then
				local var_170_6 = Color.New(0, 0, 0)

				var_170_6.a = Mathf.Lerp(0, 1, (arg_167_1.time_ - var_170_4) / var_170_5)
				arg_167_1.mask_.color = var_170_6
			end

			if arg_167_1.time_ >= var_170_4 + var_170_5 and arg_167_1.time_ < var_170_4 + var_170_5 + arg_170_0 then
				local var_170_7 = Color.New(0, 0, 0)

				var_170_7.a = 1
				arg_167_1.mask_.color = var_170_7
			end

			local var_170_8 = 2

			if 2 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_9 = 2

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_9 then
				local var_170_10 = Color.New(0, 0, 0)

				var_170_10.a = Mathf.Lerp(1, 0, (arg_167_1.time_ - var_170_8) / var_170_9)
				arg_167_1.mask_.color = var_170_10
			end

			if arg_167_1.time_ >= var_170_8 + var_170_9 and arg_167_1.time_ < var_170_8 + var_170_9 + arg_170_0 then
				local var_170_11 = Color.New(0, 0, 0)

				arg_167_1.mask_.enabled = false
				var_170_11.a = 0
				arg_167_1.mask_.color = var_170_11
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_12 = 4
			local var_170_13 = 0.2

			if 4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_14 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_14:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_15 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1108103041).content)

				arg_167_1.text_.text = var_170_15

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_17 = 8 <= 0 and var_170_13 or var_170_13 * (utf8.len(var_170_15) / 8)

				if (8 <= 0 and var_170_13 or var_170_13 * (utf8.len(var_170_15) / 8)) > 0 and var_170_13 < var_170_17 then
					arg_167_1.talkMaxDuration = var_170_17
					var_170_12 = var_170_12 + 0.3

					if var_170_17 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_17 + var_170_12
					end
				end

				arg_167_1.text_.text = var_170_15
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_18 = var_170_12 + 0.3
			local var_170_19 = math.max(var_170_13, arg_167_1.talkMaxDuration)

			if var_170_12 + 0.3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_18 + var_170_19 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_18) / var_170_19

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_18 + var_170_19 and arg_167_1.time_ < var_170_18 + var_170_19 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1108103042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1108103042
		arg_173_1.duration_ = 4.53

		local var_173_0 = {
			ja = 4.533,
			ko = 1,
			zh = 1
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1108103043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.075

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:GetWordFromCfg(1108103042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 3 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 3)

				if (3 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 3)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103042", "story_v_side_new_1108103.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103042", "story_v_side_new_1108103.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_side_new_1108103", "1108103042", "story_v_side_new_1108103.awb")

						arg_173_1:RecordAudio("1108103042", var_176_6)
						arg_173_1:RecordAudio("1108103042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103042", "story_v_side_new_1108103.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103042", "story_v_side_new_1108103.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1108103043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1108103043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1108103044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.125

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(1108103043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 5 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 5)

				if (5 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 5)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1108103044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1108103044
		arg_181_1.duration_ = 5.87

		local var_181_0 = {
			ja = 4.933,
			ko = 5.866,
			zh = 5.866
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1108103045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:GetWordFromCfg(1108103044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 18 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 18)

				if (18 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 18)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103044", "story_v_side_new_1108103.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103044", "story_v_side_new_1108103.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_side_new_1108103", "1108103044", "story_v_side_new_1108103.awb")

						arg_181_1:RecordAudio("1108103044", var_184_6)
						arg_181_1:RecordAudio("1108103044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103044", "story_v_side_new_1108103.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103044", "story_v_side_new_1108103.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play1108103045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1108103045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1108103046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.025

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(1108103045).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 41 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 41)

				if (41 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 41)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play1108103046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1108103046
		arg_189_1.duration_ = 8.5

		local var_189_0 = {
			ja = 8.5,
			ko = 5.1,
			zh = 5.1
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1108103047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.525

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(1108103046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 21 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 21)

				if (21 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 21)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103046", "story_v_side_new_1108103.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103046", "story_v_side_new_1108103.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_side_new_1108103", "1108103046", "story_v_side_new_1108103.awb")

						arg_189_1:RecordAudio("1108103046", var_192_6)
						arg_189_1:RecordAudio("1108103046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103046", "story_v_side_new_1108103.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103046", "story_v_side_new_1108103.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1108103047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1108103047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1108103048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.325

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(1108103047).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 13 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 13)

				if (13 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 13)) > 0 and var_196_0 < var_196_3 then
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
	Play1108103048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1108103048
		arg_197_1.duration_ = 2.3

		local var_197_0 = {
			ja = 2.3,
			ko = 1.3,
			zh = 1.3
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
				arg_197_0:Play1108103049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.075

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(1108103048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 3 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 3)

				if (3 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 3)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103048", "story_v_side_new_1108103.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103048", "story_v_side_new_1108103.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_side_new_1108103", "1108103048", "story_v_side_new_1108103.awb")

						arg_197_1:RecordAudio("1108103048", var_200_6)
						arg_197_1:RecordAudio("1108103048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103048", "story_v_side_new_1108103.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103048", "story_v_side_new_1108103.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1108103049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1108103049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1108103050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0.1 < arg_201_1.time_ and arg_201_1.time_ <= 0.1 + arg_204_0 then
				arg_201_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			local var_204_1 = 0
			local var_204_2 = 0.8

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1108103049).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 32 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 32)

				if (32 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_3) / 32)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_6 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_6

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_6 and arg_201_1.time_ < var_204_1 + var_204_6 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1108103050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1108103050
		arg_205_1.duration_ = 8.4

		local var_205_0 = {
			ja = 3.4,
			ko = 8.4,
			zh = 8.4
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1108103051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1081ui_story = arg_205_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).z)
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles = arg_205_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_205_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1081ui_story"].transform.position).z)
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1081ui_story"].transform.localEulerAngles = arg_205_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1081ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1081ui_story == nil then
				arg_205_1.var_.characterEffect1081ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.0166666666666667

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1081ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1081ui_story then
				arg_205_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_208_4 = 0
			local var_208_5 = 0.825

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(1108103050)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 33 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 33)

				if (33 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 33)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103050", "story_v_side_new_1108103.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103050", "story_v_side_new_1108103.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_side_new_1108103", "1108103050", "story_v_side_new_1108103.awb")

						arg_205_1:RecordAudio("1108103050", var_208_11)
						arg_205_1:RecordAudio("1108103050", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103050", "story_v_side_new_1108103.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103050", "story_v_side_new_1108103.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play1108103051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1108103051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1108103052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1081ui_story = arg_209_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).z)
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles = arg_209_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).z)
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles = arg_209_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1081ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1081ui_story == nil then
				arg_209_1.var_.characterEffect1081ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.0166666666666667

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1081ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_2)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1081ui_story then
				arg_209_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_212_3 = 0
			local var_212_4 = 0.15

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_3 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_5 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1108103051).content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 6 <= 0 and var_212_4 or var_212_4 * (utf8.len(var_212_5) / 6)

				if (6 <= 0 and var_212_4 or var_212_4 * (utf8.len(var_212_5) / 6)) > 0 and var_212_4 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_3 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_3
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_4, arg_209_1.talkMaxDuration)

			if var_212_3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_3 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_3) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_3 + var_212_8 and arg_209_1.time_ < var_212_3 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play1108103052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1108103052
		arg_213_1.duration_ = 3.13

		local var_213_0 = {
			ja = 3.133,
			ko = 2.666,
			zh = 2.666
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
				arg_213_0:Play1108103053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1027ui_story = arg_213_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1027ui_story"].transform.position).z)
				arg_213_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1027ui_story"].transform.localEulerAngles = arg_213_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_213_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1027ui_story"].transform.position).z)
				arg_213_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1027ui_story"].transform.localEulerAngles = arg_213_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1027ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1027ui_story == nil then
				arg_213_1.var_.characterEffect1027ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.0166666666666667

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1027ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1027ui_story then
				arg_213_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_216_4 = arg_213_1.actors_["1081ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1081ui_story = var_216_4.localPosition
			end

			local var_216_5 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 then
				var_216_4.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_213_1.time_ - 0) / var_216_5)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 then
				var_216_4.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_216_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_4.position).x, (manager.ui.mainCamera.transform.position - var_216_4.position).y, (manager.ui.mainCamera.transform.position - var_216_4.position).z)
				var_216_4.localEulerAngles.z = 0
				var_216_4.localEulerAngles.x = 0
				var_216_4.localEulerAngles = var_216_4.localEulerAngles
			end

			local var_216_6 = arg_213_1.actors_["1081ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1081ui_story == nil then
				arg_213_1.var_.characterEffect1081ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_7 = 0.0166666666666667

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 and not isNil(var_216_6) then
				if arg_213_1.var_.characterEffect1081ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_7)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1081ui_story then
				arg_213_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_216_8 = 0
			local var_216_9 = 0.325

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(1108103052)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 13 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 13)

				if (13 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 13)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103052", "story_v_side_new_1108103.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103052", "story_v_side_new_1108103.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_side_new_1108103", "1108103052", "story_v_side_new_1108103.awb")

						arg_213_1:RecordAudio("1108103052", var_216_15)
						arg_213_1:RecordAudio("1108103052", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103052", "story_v_side_new_1108103.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103052", "story_v_side_new_1108103.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play1108103053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1108103053
		arg_217_1.duration_ = 7.67

		local var_217_0 = {
			ja = 7.666,
			ko = 4.233,
			zh = 4.233
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
				arg_217_0:Play1108103054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1027ui_story = arg_217_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).z)
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles = arg_217_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_217_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1027ui_story"].transform.position).z)
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1027ui_story"].transform.localEulerAngles = arg_217_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1027ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1027ui_story == nil then
				arg_217_1.var_.characterEffect1027ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.0166666666666667

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1027ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_2)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1027ui_story then
				arg_217_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_220_3 = arg_217_1.actors_["1081ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1081ui_story = var_220_3.localPosition
			end

			local var_220_4 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				var_220_3.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_217_1.time_ - 0) / var_220_4)
				var_220_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_3.position).x, (manager.ui.mainCamera.transform.position - var_220_3.position).y, (manager.ui.mainCamera.transform.position - var_220_3.position).z)
				var_220_3.localEulerAngles.z = 0
				var_220_3.localEulerAngles.x = 0
				var_220_3.localEulerAngles = var_220_3.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				var_220_3.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_220_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_3.position).x, (manager.ui.mainCamera.transform.position - var_220_3.position).y, (manager.ui.mainCamera.transform.position - var_220_3.position).z)
				var_220_3.localEulerAngles.z = 0
				var_220_3.localEulerAngles.x = 0
				var_220_3.localEulerAngles = var_220_3.localEulerAngles
			end

			local var_220_5 = arg_217_1.actors_["1081ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_5) and arg_217_1.var_.characterEffect1081ui_story == nil then
				arg_217_1.var_.characterEffect1081ui_story = var_220_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_6 = 0.0166666666666667

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_6 and not isNil(var_220_5) then
				if arg_217_1.var_.characterEffect1081ui_story and not isNil(var_220_5) then
					arg_217_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_6 and arg_217_1.time_ < 0 + var_220_6 + arg_220_0 and not isNil(var_220_5) and arg_217_1.var_.characterEffect1081ui_story then
				arg_217_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_220_8 = 0
			local var_220_9 = 0.35

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(1108103053)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 14 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 14)

				if (14 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 14)) > 0 and var_220_9 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103053", "story_v_side_new_1108103.awb") ~= 0 then
					local var_220_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103053", "story_v_side_new_1108103.awb") / 1000

					if var_220_14 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_8
					end

					if var_220_10.prefab_name ~= "" and arg_217_1.actors_[var_220_10.prefab_name] ~= nil then
						local var_220_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_10.prefab_name].transform, "story_v_side_new_1108103", "1108103053", "story_v_side_new_1108103.awb")

						arg_217_1:RecordAudio("1108103053", var_220_15)
						arg_217_1:RecordAudio("1108103053", var_220_15)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103053", "story_v_side_new_1108103.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103053", "story_v_side_new_1108103.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play1108103054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1108103054
		arg_221_1.duration_ = 7.33

		local var_221_0 = {
			ja = 7.333,
			ko = 6.366,
			zh = 6.366
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
				arg_221_0:Play1108103055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1027ui_story = arg_221_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1027ui_story"].transform.position).z)
				arg_221_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1027ui_story"].transform.localEulerAngles = arg_221_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_221_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1027ui_story"].transform.position).z)
				arg_221_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1027ui_story"].transform.localEulerAngles = arg_221_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1027ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1027ui_story == nil then
				arg_221_1.var_.characterEffect1027ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.0166666666666667

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1027ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1027ui_story then
				arg_221_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_224_4 = arg_221_1.actors_["1081ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1081ui_story = var_224_4.localPosition
			end

			local var_224_5 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_5 then
				var_224_4.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_221_1.time_ - 0) / var_224_5)
				var_224_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_4.position).x, (manager.ui.mainCamera.transform.position - var_224_4.position).y, (manager.ui.mainCamera.transform.position - var_224_4.position).z)
				var_224_4.localEulerAngles.z = 0
				var_224_4.localEulerAngles.x = 0
				var_224_4.localEulerAngles = var_224_4.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_5 and arg_221_1.time_ < 0 + var_224_5 + arg_224_0 then
				var_224_4.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_224_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_4.position).x, (manager.ui.mainCamera.transform.position - var_224_4.position).y, (manager.ui.mainCamera.transform.position - var_224_4.position).z)
				var_224_4.localEulerAngles.z = 0
				var_224_4.localEulerAngles.x = 0
				var_224_4.localEulerAngles = var_224_4.localEulerAngles
			end

			local var_224_6 = arg_221_1.actors_["1081ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_6) and arg_221_1.var_.characterEffect1081ui_story == nil then
				arg_221_1.var_.characterEffect1081ui_story = var_224_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_7 = 0.0166666666666667

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 and not isNil(var_224_6) then
				if arg_221_1.var_.characterEffect1081ui_story and not isNil(var_224_6) then
					arg_221_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_7)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 and not isNil(var_224_6) and arg_221_1.var_.characterEffect1081ui_story then
				arg_221_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			local var_224_8 = 0
			local var_224_9 = 0.675

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(1108103054)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 27 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 27)

				if (27 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 27)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103054", "story_v_side_new_1108103.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103054", "story_v_side_new_1108103.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_side_new_1108103", "1108103054", "story_v_side_new_1108103.awb")

						arg_221_1:RecordAudio("1108103054", var_224_15)
						arg_221_1:RecordAudio("1108103054", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103054", "story_v_side_new_1108103.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103054", "story_v_side_new_1108103.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1108103055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1108103055
		arg_225_1.duration_ = 4.1

		local var_225_0 = {
			ja = 4.1,
			ko = 3.266,
			zh = 3.266
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
				arg_225_0:Play1108103056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1027ui_story = arg_225_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1027ui_story"].transform.position).z)
				arg_225_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1027ui_story"].transform.localEulerAngles = arg_225_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1027ui_story"].transform.position).z)
				arg_225_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1027ui_story"].transform.localEulerAngles = arg_225_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1027ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1027ui_story == nil then
				arg_225_1.var_.characterEffect1027ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.0166666666666667

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1027ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_2)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1027ui_story then
				arg_225_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_228_3 = arg_225_1.actors_["1081ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1081ui_story = var_228_3.localPosition
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_225_1.time_ - 0) / var_228_4)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			local var_228_5 = arg_225_1.actors_["1081ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect1081ui_story == nil then
				arg_225_1.var_.characterEffect1081ui_story = var_228_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_6 = 0.0166666666666667

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.characterEffect1081ui_story and not isNil(var_228_5) then
					arg_225_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_6)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect1081ui_story then
				arg_225_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_228_7 = arg_225_1.actors_["1080ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1080ui_story = var_228_7.localPosition
			end

			local var_228_8 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_8 then
				var_228_7.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_225_1.time_ - 0) / var_228_8)
				var_228_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_7.position).x, (manager.ui.mainCamera.transform.position - var_228_7.position).y, (manager.ui.mainCamera.transform.position - var_228_7.position).z)
				var_228_7.localEulerAngles.z = 0
				var_228_7.localEulerAngles.x = 0
				var_228_7.localEulerAngles = var_228_7.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_8 and arg_225_1.time_ < 0 + var_228_8 + arg_228_0 then
				var_228_7.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_228_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_7.position).x, (manager.ui.mainCamera.transform.position - var_228_7.position).y, (manager.ui.mainCamera.transform.position - var_228_7.position).z)
				var_228_7.localEulerAngles.z = 0
				var_228_7.localEulerAngles.x = 0
				var_228_7.localEulerAngles = var_228_7.localEulerAngles
			end

			local var_228_9 = arg_225_1.actors_["1080ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1080ui_story == nil then
				arg_225_1.var_.characterEffect1080ui_story = var_228_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_10 = 0.0166666666666667

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_10 and not isNil(var_228_9) then
				if arg_225_1.var_.characterEffect1080ui_story and not isNil(var_228_9) then
					arg_225_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_10 and arg_225_1.time_ < 0 + var_228_10 + arg_228_0 and not isNil(var_228_9) and arg_225_1.var_.characterEffect1080ui_story then
				arg_225_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action4_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_228_12 = 0
			local var_228_13 = 0.275

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_12 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_14 = arg_225_1:GetWordFromCfg(1108103055)
				local var_228_15 = arg_225_1:FormatText(var_228_14.content)

				arg_225_1.text_.text = var_228_15

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_17 = 11 <= 0 and var_228_13 or var_228_13 * (utf8.len(var_228_15) / 11)

				if (11 <= 0 and var_228_13 or var_228_13 * (utf8.len(var_228_15) / 11)) > 0 and var_228_13 < var_228_17 then
					arg_225_1.talkMaxDuration = var_228_17

					if var_228_17 + var_228_12 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_17 + var_228_12
					end
				end

				arg_225_1.text_.text = var_228_15
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103055", "story_v_side_new_1108103.awb") ~= 0 then
					local var_228_18 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103055", "story_v_side_new_1108103.awb") / 1000

					if var_228_18 + var_228_12 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_18 + var_228_12
					end

					if var_228_14.prefab_name ~= "" and arg_225_1.actors_[var_228_14.prefab_name] ~= nil then
						local var_228_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_14.prefab_name].transform, "story_v_side_new_1108103", "1108103055", "story_v_side_new_1108103.awb")

						arg_225_1:RecordAudio("1108103055", var_228_19)
						arg_225_1:RecordAudio("1108103055", var_228_19)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103055", "story_v_side_new_1108103.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103055", "story_v_side_new_1108103.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_20 = math.max(var_228_13, arg_225_1.talkMaxDuration)

			if var_228_12 <= arg_225_1.time_ and arg_225_1.time_ < var_228_12 + var_228_20 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_12) / var_228_20

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_12 + var_228_20 and arg_225_1.time_ < var_228_12 + var_228_20 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play1108103056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1108103056
		arg_229_1.duration_ = 8.53

		local var_229_0 = {
			ja = 3.9,
			ko = 8.533,
			zh = 8.533
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
				arg_229_0:Play1108103057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1081ui_story = arg_229_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).z)
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles = arg_229_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0.7, -0.92, -5.8)
				arg_229_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1081ui_story"].transform.position).z)
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1081ui_story"].transform.localEulerAngles = arg_229_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1081ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1081ui_story == nil then
				arg_229_1.var_.characterEffect1081ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.0166666666666667

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1081ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1081ui_story then
				arg_229_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_232_4 = arg_229_1.actors_["1080ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1080ui_story = var_232_4.localPosition
			end

			local var_232_5 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_5 then
				var_232_4.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_5)
				var_232_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_4.position).x, (manager.ui.mainCamera.transform.position - var_232_4.position).y, (manager.ui.mainCamera.transform.position - var_232_4.position).z)
				var_232_4.localEulerAngles.z = 0
				var_232_4.localEulerAngles.x = 0
				var_232_4.localEulerAngles = var_232_4.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_5 and arg_229_1.time_ < 0 + var_232_5 + arg_232_0 then
				var_232_4.localPosition = Vector3.New(0, 100, 0)
				var_232_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_4.position).x, (manager.ui.mainCamera.transform.position - var_232_4.position).y, (manager.ui.mainCamera.transform.position - var_232_4.position).z)
				var_232_4.localEulerAngles.z = 0
				var_232_4.localEulerAngles.x = 0
				var_232_4.localEulerAngles = var_232_4.localEulerAngles
			end

			local var_232_6 = arg_229_1.actors_["1080ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1080ui_story == nil then
				arg_229_1.var_.characterEffect1080ui_story = var_232_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_7 = 0.0166666666666667

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 and not isNil(var_232_6) then
				if arg_229_1.var_.characterEffect1080ui_story and not isNil(var_232_6) then
					arg_229_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_7)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 and not isNil(var_232_6) and arg_229_1.var_.characterEffect1080ui_story then
				arg_229_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_232_8 = arg_229_1.actors_["1027ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1027ui_story = var_232_8.localPosition
			end

			local var_232_9 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_9 then
				var_232_8.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_229_1.time_ - 0) / var_232_9)
				var_232_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_8.position).x, (manager.ui.mainCamera.transform.position - var_232_8.position).y, (manager.ui.mainCamera.transform.position - var_232_8.position).z)
				var_232_8.localEulerAngles.z = 0
				var_232_8.localEulerAngles.x = 0
				var_232_8.localEulerAngles = var_232_8.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_9 and arg_229_1.time_ < 0 + var_232_9 + arg_232_0 then
				var_232_8.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_232_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_8.position).x, (manager.ui.mainCamera.transform.position - var_232_8.position).y, (manager.ui.mainCamera.transform.position - var_232_8.position).z)
				var_232_8.localEulerAngles.z = 0
				var_232_8.localEulerAngles.x = 0
				var_232_8.localEulerAngles = var_232_8.localEulerAngles
			end

			local var_232_10 = arg_229_1.actors_["1027ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_10) and arg_229_1.var_.characterEffect1027ui_story == nil then
				arg_229_1.var_.characterEffect1027ui_story = var_232_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_11 = 0.0166666666666667

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_11 and not isNil(var_232_10) then
				if arg_229_1.var_.characterEffect1027ui_story and not isNil(var_232_10) then
					arg_229_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_11)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_11 and arg_229_1.time_ < 0 + var_232_11 + arg_232_0 and not isNil(var_232_10) and arg_229_1.var_.characterEffect1027ui_story then
				arg_229_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_232_12 = 0
			local var_232_13 = 0.8

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_12 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_14 = arg_229_1:GetWordFromCfg(1108103056)
				local var_232_15 = arg_229_1:FormatText(var_232_14.content)

				arg_229_1.text_.text = var_232_15

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_17 = 32 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 32)

				if (32 <= 0 and var_232_13 or var_232_13 * (utf8.len(var_232_15) / 32)) > 0 and var_232_13 < var_232_17 then
					arg_229_1.talkMaxDuration = var_232_17

					if var_232_17 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_17 + var_232_12
					end
				end

				arg_229_1.text_.text = var_232_15
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103056", "story_v_side_new_1108103.awb") ~= 0 then
					local var_232_18 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103056", "story_v_side_new_1108103.awb") / 1000

					if var_232_18 + var_232_12 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_12
					end

					if var_232_14.prefab_name ~= "" and arg_229_1.actors_[var_232_14.prefab_name] ~= nil then
						local var_232_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_14.prefab_name].transform, "story_v_side_new_1108103", "1108103056", "story_v_side_new_1108103.awb")

						arg_229_1:RecordAudio("1108103056", var_232_19)
						arg_229_1:RecordAudio("1108103056", var_232_19)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103056", "story_v_side_new_1108103.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103056", "story_v_side_new_1108103.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_20 = math.max(var_232_13, arg_229_1.talkMaxDuration)

			if var_232_12 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_20 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_20

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_20 and arg_229_1.time_ < var_232_12 + var_232_20 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play1108103057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1108103057
		arg_233_1.duration_ = 5.8

		local var_233_0 = {
			ja = 4.4,
			ko = 5.8,
			zh = 5.8
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
				arg_233_0:Play1108103058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1027ui_story = arg_233_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1027ui_story"].transform.position).z)
				arg_233_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1027ui_story"].transform.localEulerAngles = arg_233_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_233_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1027ui_story"].transform.position).z)
				arg_233_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1027ui_story"].transform.localEulerAngles = arg_233_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1027ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1027ui_story == nil then
				arg_233_1.var_.characterEffect1027ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.0166666666666667

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1027ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1027ui_story then
				arg_233_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_236_4 = arg_233_1.actors_["1081ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1081ui_story = var_236_4.localPosition
			end

			local var_236_5 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_5 then
				var_236_4.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_233_1.time_ - 0) / var_236_5)
				var_236_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_4.position).x, (manager.ui.mainCamera.transform.position - var_236_4.position).y, (manager.ui.mainCamera.transform.position - var_236_4.position).z)
				var_236_4.localEulerAngles.z = 0
				var_236_4.localEulerAngles.x = 0
				var_236_4.localEulerAngles = var_236_4.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_5 and arg_233_1.time_ < 0 + var_236_5 + arg_236_0 then
				var_236_4.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_236_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_4.position).x, (manager.ui.mainCamera.transform.position - var_236_4.position).y, (manager.ui.mainCamera.transform.position - var_236_4.position).z)
				var_236_4.localEulerAngles.z = 0
				var_236_4.localEulerAngles.x = 0
				var_236_4.localEulerAngles = var_236_4.localEulerAngles
			end

			local var_236_6 = arg_233_1.actors_["1081ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect1081ui_story == nil then
				arg_233_1.var_.characterEffect1081ui_story = var_236_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_7 = 0.0166666666666667

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 and not isNil(var_236_6) then
				if arg_233_1.var_.characterEffect1081ui_story and not isNil(var_236_6) then
					arg_233_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_7)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect1081ui_story then
				arg_233_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_236_8 = 0
			local var_236_9 = 0.575

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(1108103057)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 23 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 23)

				if (23 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 23)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103057", "story_v_side_new_1108103.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103057", "story_v_side_new_1108103.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_side_new_1108103", "1108103057", "story_v_side_new_1108103.awb")

						arg_233_1:RecordAudio("1108103057", var_236_15)
						arg_233_1:RecordAudio("1108103057", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103057", "story_v_side_new_1108103.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103057", "story_v_side_new_1108103.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play1108103058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1108103058
		arg_237_1.duration_ = 2

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1108103059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1027ui_story = arg_237_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1027ui_story"].transform.position).z)
				arg_237_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1027ui_story"].transform.localEulerAngles = arg_237_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_237_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1027ui_story"].transform.position).z)
				arg_237_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1027ui_story"].transform.localEulerAngles = arg_237_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1027ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1027ui_story == nil then
				arg_237_1.var_.characterEffect1027ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.0166666666666667

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1027ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_2)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1027ui_story then
				arg_237_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_240_3 = arg_237_1.actors_["1081ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1081ui_story = var_240_3.localPosition
			end

			local var_240_4 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				var_240_3.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_237_1.time_ - 0) / var_240_4)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				var_240_3.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_240_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_3.position).x, (manager.ui.mainCamera.transform.position - var_240_3.position).y, (manager.ui.mainCamera.transform.position - var_240_3.position).z)
				var_240_3.localEulerAngles.z = 0
				var_240_3.localEulerAngles.x = 0
				var_240_3.localEulerAngles = var_240_3.localEulerAngles
			end

			local var_240_5 = arg_237_1.actors_["1081ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect1081ui_story == nil then
				arg_237_1.var_.characterEffect1081ui_story = var_240_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_6 = 0.0166666666666667

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.characterEffect1081ui_story and not isNil(var_240_5) then
					arg_237_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.characterEffect1081ui_story then
				arg_237_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			local var_240_8 = 0
			local var_240_9 = 0.05

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(1108103058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 2 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 2)

				if (2 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 2)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103058", "story_v_side_new_1108103.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103058", "story_v_side_new_1108103.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_side_new_1108103", "1108103058", "story_v_side_new_1108103.awb")

						arg_237_1:RecordAudio("1108103058", var_240_15)
						arg_237_1:RecordAudio("1108103058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103058", "story_v_side_new_1108103.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103058", "story_v_side_new_1108103.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1108103059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1108103059
		arg_241_1.duration_ = 8.2

		local var_241_0 = {
			ja = 6.766,
			ko = 8.2,
			zh = 8.2
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
				arg_241_0:Play1108103060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1027ui_story = arg_241_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1027ui_story"].transform.position).z)
				arg_241_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1027ui_story"].transform.localEulerAngles = arg_241_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_241_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1027ui_story"].transform.position).z)
				arg_241_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1027ui_story"].transform.localEulerAngles = arg_241_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1027ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1027ui_story == nil then
				arg_241_1.var_.characterEffect1027ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.0166666666666667

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1027ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1027ui_story then
				arg_241_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_244_4 = arg_241_1.actors_["1081ui_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1081ui_story = var_244_4.localPosition
			end

			local var_244_5 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_5 then
				var_244_4.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1081ui_story, Vector3.New(0.7, -0.92, -5.8), (arg_241_1.time_ - 0) / var_244_5)
				var_244_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_4.position).x, (manager.ui.mainCamera.transform.position - var_244_4.position).y, (manager.ui.mainCamera.transform.position - var_244_4.position).z)
				var_244_4.localEulerAngles.z = 0
				var_244_4.localEulerAngles.x = 0
				var_244_4.localEulerAngles = var_244_4.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_5 and arg_241_1.time_ < 0 + var_244_5 + arg_244_0 then
				var_244_4.localPosition = Vector3.New(0.7, -0.92, -5.8)
				var_244_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_4.position).x, (manager.ui.mainCamera.transform.position - var_244_4.position).y, (manager.ui.mainCamera.transform.position - var_244_4.position).z)
				var_244_4.localEulerAngles.z = 0
				var_244_4.localEulerAngles.x = 0
				var_244_4.localEulerAngles = var_244_4.localEulerAngles
			end

			local var_244_6 = arg_241_1.actors_["1081ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1081ui_story == nil then
				arg_241_1.var_.characterEffect1081ui_story = var_244_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_7 = 0.0166666666666667

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 and not isNil(var_244_6) then
				if arg_241_1.var_.characterEffect1081ui_story and not isNil(var_244_6) then
					arg_241_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_7)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 and not isNil(var_244_6) and arg_241_1.var_.characterEffect1081ui_story then
				arg_241_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_244_8 = 0
			local var_244_9 = 0.875

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_8 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_10 = arg_241_1:GetWordFromCfg(1108103059)
				local var_244_11 = arg_241_1:FormatText(var_244_10.content)

				arg_241_1.text_.text = var_244_11

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_13 = 35 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 35)

				if (35 <= 0 and var_244_9 or var_244_9 * (utf8.len(var_244_11) / 35)) > 0 and var_244_9 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_8
					end
				end

				arg_241_1.text_.text = var_244_11
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103059", "story_v_side_new_1108103.awb") ~= 0 then
					local var_244_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103059", "story_v_side_new_1108103.awb") / 1000

					if var_244_14 + var_244_8 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_14 + var_244_8
					end

					if var_244_10.prefab_name ~= "" and arg_241_1.actors_[var_244_10.prefab_name] ~= nil then
						local var_244_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_10.prefab_name].transform, "story_v_side_new_1108103", "1108103059", "story_v_side_new_1108103.awb")

						arg_241_1:RecordAudio("1108103059", var_244_15)
						arg_241_1:RecordAudio("1108103059", var_244_15)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103059", "story_v_side_new_1108103.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103059", "story_v_side_new_1108103.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_16 = math.max(var_244_9, arg_241_1.talkMaxDuration)

			if var_244_8 <= arg_241_1.time_ and arg_241_1.time_ < var_244_8 + var_244_16 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_8) / var_244_16

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_8 + var_244_16 and arg_241_1.time_ < var_244_8 + var_244_16 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play1108103060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1108103060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1108103061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1027ui_story = arg_245_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1027ui_story"].transform.position).z)
				arg_245_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1027ui_story"].transform.localEulerAngles = arg_245_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1027ui_story"].transform.position).z)
				arg_245_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1027ui_story"].transform.localEulerAngles = arg_245_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1027ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1027ui_story == nil then
				arg_245_1.var_.characterEffect1027ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.0166666666666667

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1027ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_2)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1027ui_story then
				arg_245_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_248_3 = arg_245_1.actors_["1081ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1081ui_story = var_248_3.localPosition
			end

			local var_248_4 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				var_248_3.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_4)
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

			local var_248_5 = arg_245_1.actors_["1081ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect1081ui_story == nil then
				arg_245_1.var_.characterEffect1081ui_story = var_248_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_6 = 0.0166666666666667

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_6 and not isNil(var_248_5) then
				if arg_245_1.var_.characterEffect1081ui_story and not isNil(var_248_5) then
					arg_245_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_6)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_6 and arg_245_1.time_ < 0 + var_248_6 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect1081ui_story then
				arg_245_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_248_7 = 0
			local var_248_8 = 0.55

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_7 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_9 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(1108103060).content)

				arg_245_1.text_.text = var_248_9

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_11 = 22 <= 0 and var_248_8 or var_248_8 * (utf8.len(var_248_9) / 22)

				if (22 <= 0 and var_248_8 or var_248_8 * (utf8.len(var_248_9) / 22)) > 0 and var_248_8 < var_248_11 then
					arg_245_1.talkMaxDuration = var_248_11

					if var_248_11 + var_248_7 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_11 + var_248_7
					end
				end

				arg_245_1.text_.text = var_248_9
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_8, arg_245_1.talkMaxDuration)

			if var_248_7 <= arg_245_1.time_ and arg_245_1.time_ < var_248_7 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_7) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_7 + var_248_12 and arg_245_1.time_ < var_248_7 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play1108103061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1108103061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1108103062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1081ui_story"]) and arg_249_1.var_.characterEffect1081ui_story == nil then
				arg_249_1.var_.characterEffect1081ui_story = arg_249_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.0166666666666667

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1081ui_story"]) then
				if arg_249_1.var_.characterEffect1081ui_story and not isNil(arg_249_1.actors_["1081ui_story"]) then
					arg_249_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1081ui_story"]) and arg_249_1.var_.characterEffect1081ui_story then
				arg_249_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.325

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1108103061).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 13 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 13)

				if (13 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 13)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1108103062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1108103062
		arg_253_1.duration_ = 9.47

		local var_253_0 = {
			ja = 9.466,
			ko = 7.133,
			zh = 7.133
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
				arg_253_0:Play1108103063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1081ui_story = arg_253_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).z)
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles = arg_253_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_253_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1081ui_story"].transform.position).z)
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1081ui_story"].transform.localEulerAngles = arg_253_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1081ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1081ui_story == nil then
				arg_253_1.var_.characterEffect1081ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.0166666666666667

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1081ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1081ui_story then
				arg_253_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_256_4 = 0
			local var_256_5 = 0.675

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(1108103062)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 27 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 27)

				if (27 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 27)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103062", "story_v_side_new_1108103.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103062", "story_v_side_new_1108103.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_side_new_1108103", "1108103062", "story_v_side_new_1108103.awb")

						arg_253_1:RecordAudio("1108103062", var_256_11)
						arg_253_1:RecordAudio("1108103062", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103062", "story_v_side_new_1108103.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103062", "story_v_side_new_1108103.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play1108103063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1108103063
		arg_257_1.duration_ = 3.87

		local var_257_0 = {
			ja = 3.3,
			ko = 3.866,
			zh = 3.866
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
				arg_257_0:Play1108103064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1081ui_story = arg_257_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).z)
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles = arg_257_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_257_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1081ui_story"].transform.position).z)
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1081ui_story"].transform.localEulerAngles = arg_257_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1081ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1081ui_story == nil then
				arg_257_1.var_.characterEffect1081ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.0166666666666667

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1081ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1081ui_story then
				arg_257_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_260_4 = 0
			local var_260_5 = 0.4

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(1108103063)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 16 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 16)

				if (16 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 16)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103063", "story_v_side_new_1108103.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103063", "story_v_side_new_1108103.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_side_new_1108103", "1108103063", "story_v_side_new_1108103.awb")

						arg_257_1:RecordAudio("1108103063", var_260_11)
						arg_257_1:RecordAudio("1108103063", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103063", "story_v_side_new_1108103.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103063", "story_v_side_new_1108103.awb")
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

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play1108103064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1108103064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1108103065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1081ui_story = arg_261_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).z)
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles = arg_261_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_261_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1081ui_story"].transform.position).z)
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1081ui_story"].transform.localEulerAngles = arg_261_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1081ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1081ui_story == nil then
				arg_261_1.var_.characterEffect1081ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.0166666666666667

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1081ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_2)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1081ui_story then
				arg_261_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_264_3 = 0
			local var_264_4 = 0.3

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_3 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_5 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1108103064).content)

				arg_261_1.text_.text = var_264_5

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_7 = 12 <= 0 and var_264_4 or var_264_4 * (utf8.len(var_264_5) / 12)

				if (12 <= 0 and var_264_4 or var_264_4 * (utf8.len(var_264_5) / 12)) > 0 and var_264_4 < var_264_7 then
					arg_261_1.talkMaxDuration = var_264_7

					if var_264_7 + var_264_3 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_3
					end
				end

				arg_261_1.text_.text = var_264_5
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_4, arg_261_1.talkMaxDuration)

			if var_264_3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_3 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_3) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_3 + var_264_8 and arg_261_1.time_ < var_264_3 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play1108103065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1108103065
		arg_265_1.duration_ = 2.8

		local var_265_0 = {
			ja = 2.8,
			ko = 2,
			zh = 2
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1108103066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.15

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:GetWordFromCfg(1108103065)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 6 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 6)

				if (6 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 6)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103065", "story_v_side_new_1108103.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103065", "story_v_side_new_1108103.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_side_new_1108103", "1108103065", "story_v_side_new_1108103.awb")

						arg_265_1:RecordAudio("1108103065", var_268_6)
						arg_265_1:RecordAudio("1108103065", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103065", "story_v_side_new_1108103.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103065", "story_v_side_new_1108103.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1108103066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1108103066
		arg_269_1.duration_ = 3.2

		local var_269_0 = {
			ja = 3.2,
			ko = 2.866,
			zh = 2.866
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1108103067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1081ui_story = arg_269_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).z)
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles = arg_269_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_269_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1081ui_story"].transform.position).z)
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1081ui_story"].transform.localEulerAngles = arg_269_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1081ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1081ui_story == nil then
				arg_269_1.var_.characterEffect1081ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.0166666666666667

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1081ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1081ui_story then
				arg_269_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_272_4 = 0
			local var_272_5 = 0.3

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(1108103066)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 12 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 12)

				if (12 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 12)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103066", "story_v_side_new_1108103.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103066", "story_v_side_new_1108103.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_side_new_1108103", "1108103066", "story_v_side_new_1108103.awb")

						arg_269_1:RecordAudio("1108103066", var_272_11)
						arg_269_1:RecordAudio("1108103066", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103066", "story_v_side_new_1108103.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103066", "story_v_side_new_1108103.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play1108103067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1108103067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1108103068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1081ui_story = arg_273_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1081ui_story"].transform.position).z)
				arg_273_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1081ui_story"].transform.localEulerAngles = arg_273_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1081ui_story"].transform.position).z)
				arg_273_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1081ui_story"].transform.localEulerAngles = arg_273_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_276_1 = 0
			local var_276_2 = 0.6

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1108103067).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 24 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 24)

				if (24 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 24)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1108103068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1108103068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1108103069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.975

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1108103068).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 79 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 79)

				if (79 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 79)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1108103069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1108103069
		arg_281_1.duration_ = 3.13

		local var_281_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_281_0:Play1108103070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1081ui_story = arg_281_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1081ui_story"].transform.position).z)
				arg_281_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1081ui_story"].transform.localEulerAngles = arg_281_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_281_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1081ui_story"].transform.position).z)
				arg_281_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1081ui_story"].transform.localEulerAngles = arg_281_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1081ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1081ui_story == nil then
				arg_281_1.var_.characterEffect1081ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.0166666666666667

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect1081ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1081ui_story then
				arg_281_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_4 = 0
			local var_284_5 = 0.05

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(1108103069)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 2 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 2)

				if (2 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 2)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103069", "story_v_side_new_1108103.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103069", "story_v_side_new_1108103.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_side_new_1108103", "1108103069", "story_v_side_new_1108103.awb")

						arg_281_1:RecordAudio("1108103069", var_284_11)
						arg_281_1:RecordAudio("1108103069", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103069", "story_v_side_new_1108103.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103069", "story_v_side_new_1108103.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_12 and arg_281_1.time_ < var_284_4 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1108103070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1108103070
		arg_285_1.duration_ = 6.6

		local var_285_0 = {
			ja = 6.5,
			ko = 6.6,
			zh = 6.6
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1108103071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1081ui_story = arg_285_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1081ui_story"].transform.position).z)
				arg_285_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1081ui_story"].transform.localEulerAngles = arg_285_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1081ui_story"].transform.position).z)
				arg_285_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1081ui_story"].transform.localEulerAngles = arg_285_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1081ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1081ui_story == nil then
				arg_285_1.var_.characterEffect1081ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.0166666666666667

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1081ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_2)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1081ui_story then
				arg_285_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_288_3 = arg_285_1.actors_["1027ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1027ui_story = var_288_3.localPosition
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_3.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_285_1.time_ - 0) / var_288_4)
				var_288_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_3.position).x, (manager.ui.mainCamera.transform.position - var_288_3.position).y, (manager.ui.mainCamera.transform.position - var_288_3.position).z)
				var_288_3.localEulerAngles.z = 0
				var_288_3.localEulerAngles.x = 0
				var_288_3.localEulerAngles = var_288_3.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_3.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_288_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_3.position).x, (manager.ui.mainCamera.transform.position - var_288_3.position).y, (manager.ui.mainCamera.transform.position - var_288_3.position).z)
				var_288_3.localEulerAngles.z = 0
				var_288_3.localEulerAngles.x = 0
				var_288_3.localEulerAngles = var_288_3.localEulerAngles
			end

			local var_288_5 = arg_285_1.actors_["1027ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.characterEffect1027ui_story == nil then
				arg_285_1.var_.characterEffect1027ui_story = var_288_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.0166666666666667

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.characterEffect1027ui_story and not isNil(var_288_5) then
					arg_285_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.characterEffect1027ui_story then
				arg_285_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_8 = arg_285_1.actors_["1080ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1080ui_story = var_288_8.localPosition
			end

			local var_288_9 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_9 then
				var_288_8.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_285_1.time_ - 0) / var_288_9)
				var_288_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_8.position).x, (manager.ui.mainCamera.transform.position - var_288_8.position).y, (manager.ui.mainCamera.transform.position - var_288_8.position).z)
				var_288_8.localEulerAngles.z = 0
				var_288_8.localEulerAngles.x = 0
				var_288_8.localEulerAngles = var_288_8.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_9 and arg_285_1.time_ < 0 + var_288_9 + arg_288_0 then
				var_288_8.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_288_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_8.position).x, (manager.ui.mainCamera.transform.position - var_288_8.position).y, (manager.ui.mainCamera.transform.position - var_288_8.position).z)
				var_288_8.localEulerAngles.z = 0
				var_288_8.localEulerAngles.x = 0
				var_288_8.localEulerAngles = var_288_8.localEulerAngles
			end

			local var_288_10 = arg_285_1.actors_["1080ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_10) and arg_285_1.var_.characterEffect1080ui_story == nil then
				arg_285_1.var_.characterEffect1080ui_story = var_288_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_11 = 0.0166666666666667

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_11 and not isNil(var_288_10) then
				if arg_285_1.var_.characterEffect1080ui_story and not isNil(var_288_10) then
					arg_285_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_11)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_11 and arg_285_1.time_ < 0 + var_288_11 + arg_288_0 and not isNil(var_288_10) and arg_285_1.var_.characterEffect1080ui_story then
				arg_285_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			local var_288_12 = 0
			local var_288_13 = 0.55

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_12 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_14 = arg_285_1:GetWordFromCfg(1108103070)
				local var_288_15 = arg_285_1:FormatText(var_288_14.content)

				arg_285_1.text_.text = var_288_15

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_17 = 22 <= 0 and var_288_13 or var_288_13 * (utf8.len(var_288_15) / 22)

				if (22 <= 0 and var_288_13 or var_288_13 * (utf8.len(var_288_15) / 22)) > 0 and var_288_13 < var_288_17 then
					arg_285_1.talkMaxDuration = var_288_17

					if var_288_17 + var_288_12 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_17 + var_288_12
					end
				end

				arg_285_1.text_.text = var_288_15
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103070", "story_v_side_new_1108103.awb") ~= 0 then
					local var_288_18 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103070", "story_v_side_new_1108103.awb") / 1000

					if var_288_18 + var_288_12 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_18 + var_288_12
					end

					if var_288_14.prefab_name ~= "" and arg_285_1.actors_[var_288_14.prefab_name] ~= nil then
						local var_288_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_14.prefab_name].transform, "story_v_side_new_1108103", "1108103070", "story_v_side_new_1108103.awb")

						arg_285_1:RecordAudio("1108103070", var_288_19)
						arg_285_1:RecordAudio("1108103070", var_288_19)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103070", "story_v_side_new_1108103.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103070", "story_v_side_new_1108103.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_20 = math.max(var_288_13, arg_285_1.talkMaxDuration)

			if var_288_12 <= arg_285_1.time_ and arg_285_1.time_ < var_288_12 + var_288_20 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_12) / var_288_20

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_12 + var_288_20 and arg_285_1.time_ < var_288_12 + var_288_20 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play1108103071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1108103071
		arg_289_1.duration_ = 6.3

		local var_289_0 = {
			ja = 6.3,
			ko = 3.033,
			zh = 3.033
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
				arg_289_0:Play1108103072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1027ui_story = arg_289_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1027ui_story"].transform.position).z)
				arg_289_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1027ui_story"].transform.localEulerAngles = arg_289_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_289_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1027ui_story"].transform.position).z)
				arg_289_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1027ui_story"].transform.localEulerAngles = arg_289_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1027ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1027ui_story == nil then
				arg_289_1.var_.characterEffect1027ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.0166666666666667

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1027ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_2)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1027ui_story then
				arg_289_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_292_3 = arg_289_1.actors_["1080ui_story"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1080ui_story = var_292_3.localPosition
			end

			local var_292_4 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				var_292_3.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_289_1.time_ - 0) / var_292_4)
				var_292_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_3.position).x, (manager.ui.mainCamera.transform.position - var_292_3.position).y, (manager.ui.mainCamera.transform.position - var_292_3.position).z)
				var_292_3.localEulerAngles.z = 0
				var_292_3.localEulerAngles.x = 0
				var_292_3.localEulerAngles = var_292_3.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				var_292_3.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_292_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_3.position).x, (manager.ui.mainCamera.transform.position - var_292_3.position).y, (manager.ui.mainCamera.transform.position - var_292_3.position).z)
				var_292_3.localEulerAngles.z = 0
				var_292_3.localEulerAngles.x = 0
				var_292_3.localEulerAngles = var_292_3.localEulerAngles
			end

			local var_292_5 = arg_289_1.actors_["1080ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect1080ui_story == nil then
				arg_289_1.var_.characterEffect1080ui_story = var_292_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.0166666666666667

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.characterEffect1080ui_story and not isNil(var_292_5) then
					arg_289_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect1080ui_story then
				arg_289_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_292_8 = 0
			local var_292_9 = 0.25

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_10 = arg_289_1:GetWordFromCfg(1108103071)
				local var_292_11 = arg_289_1:FormatText(var_292_10.content)

				arg_289_1.text_.text = var_292_11

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_13 = 10 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 10)

				if (10 <= 0 and var_292_9 or var_292_9 * (utf8.len(var_292_11) / 10)) > 0 and var_292_9 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_8
					end
				end

				arg_289_1.text_.text = var_292_11
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103071", "story_v_side_new_1108103.awb") ~= 0 then
					local var_292_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103071", "story_v_side_new_1108103.awb") / 1000

					if var_292_14 + var_292_8 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_8
					end

					if var_292_10.prefab_name ~= "" and arg_289_1.actors_[var_292_10.prefab_name] ~= nil then
						local var_292_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_10.prefab_name].transform, "story_v_side_new_1108103", "1108103071", "story_v_side_new_1108103.awb")

						arg_289_1:RecordAudio("1108103071", var_292_15)
						arg_289_1:RecordAudio("1108103071", var_292_15)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103071", "story_v_side_new_1108103.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103071", "story_v_side_new_1108103.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_16 = math.max(var_292_9, arg_289_1.talkMaxDuration)

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_8) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_8 + var_292_16 and arg_289_1.time_ < var_292_8 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play1108103072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1108103072
		arg_293_1.duration_ = 5.93

		local var_293_0 = {
			ja = 5.933,
			ko = 4.266,
			zh = 4.266
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
				arg_293_0:Play1108103073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1027ui_story = arg_293_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1027ui_story"].transform.position).z)
				arg_293_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1027ui_story"].transform.localEulerAngles = arg_293_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_293_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1027ui_story"].transform.position).z)
				arg_293_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1027ui_story"].transform.localEulerAngles = arg_293_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1027ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1027ui_story == nil then
				arg_293_1.var_.characterEffect1027ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.0166666666666667

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect1027ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1027ui_story then
				arg_293_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_4 = arg_293_1.actors_["1080ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1080ui_story = var_296_4.localPosition
			end

			local var_296_5 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 then
				var_296_4.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_293_1.time_ - 0) / var_296_5)
				var_296_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_4.position).x, (manager.ui.mainCamera.transform.position - var_296_4.position).y, (manager.ui.mainCamera.transform.position - var_296_4.position).z)
				var_296_4.localEulerAngles.z = 0
				var_296_4.localEulerAngles.x = 0
				var_296_4.localEulerAngles = var_296_4.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 then
				var_296_4.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_296_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_4.position).x, (manager.ui.mainCamera.transform.position - var_296_4.position).y, (manager.ui.mainCamera.transform.position - var_296_4.position).z)
				var_296_4.localEulerAngles.z = 0
				var_296_4.localEulerAngles.x = 0
				var_296_4.localEulerAngles = var_296_4.localEulerAngles
			end

			local var_296_6 = arg_293_1.actors_["1080ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1080ui_story == nil then
				arg_293_1.var_.characterEffect1080ui_story = var_296_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_7 = 0.0166666666666667

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 and not isNil(var_296_6) then
				if arg_293_1.var_.characterEffect1080ui_story and not isNil(var_296_6) then
					arg_293_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_7)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1080ui_story then
				arg_293_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			local var_296_8 = 0
			local var_296_9 = 0.4

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_10 = arg_293_1:GetWordFromCfg(1108103072)
				local var_296_11 = arg_293_1:FormatText(var_296_10.content)

				arg_293_1.text_.text = var_296_11

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_13 = 16 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 16)

				if (16 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 16)) > 0 and var_296_9 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_8
					end
				end

				arg_293_1.text_.text = var_296_11
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103072", "story_v_side_new_1108103.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103072", "story_v_side_new_1108103.awb") / 1000

					if var_296_14 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_8
					end

					if var_296_10.prefab_name ~= "" and arg_293_1.actors_[var_296_10.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_10.prefab_name].transform, "story_v_side_new_1108103", "1108103072", "story_v_side_new_1108103.awb")

						arg_293_1:RecordAudio("1108103072", var_296_15)
						arg_293_1:RecordAudio("1108103072", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103072", "story_v_side_new_1108103.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103072", "story_v_side_new_1108103.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_9, arg_293_1.talkMaxDuration)

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_8) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_8 + var_296_16 and arg_293_1.time_ < var_296_8 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play1108103073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1108103073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1108103074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1027ui_story = arg_297_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_300_0 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 then
				arg_297_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_0)
				arg_297_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1027ui_story"].transform.position).z)
				arg_297_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1027ui_story"].transform.localEulerAngles = arg_297_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 then
				arg_297_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_297_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_297_1.actors_["1027ui_story"].transform.position).z)
				arg_297_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_297_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_297_1.actors_["1027ui_story"].transform.localEulerAngles = arg_297_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_300_1 = arg_297_1.actors_["1027ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1027ui_story == nil then
				arg_297_1.var_.characterEffect1027ui_story = var_300_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 and not isNil(var_300_1) then
				if arg_297_1.var_.characterEffect1027ui_story and not isNil(var_300_1) then
					arg_297_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_2)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 and not isNil(var_300_1) and arg_297_1.var_.characterEffect1027ui_story then
				arg_297_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_300_3 = arg_297_1.actors_["1080ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1080ui_story = var_300_3.localPosition
			end

			local var_300_4 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				var_300_3.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_4)
				var_300_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_3.position).x, (manager.ui.mainCamera.transform.position - var_300_3.position).y, (manager.ui.mainCamera.transform.position - var_300_3.position).z)
				var_300_3.localEulerAngles.z = 0
				var_300_3.localEulerAngles.x = 0
				var_300_3.localEulerAngles = var_300_3.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				var_300_3.localPosition = Vector3.New(0, 100, 0)
				var_300_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_3.position).x, (manager.ui.mainCamera.transform.position - var_300_3.position).y, (manager.ui.mainCamera.transform.position - var_300_3.position).z)
				var_300_3.localEulerAngles.z = 0
				var_300_3.localEulerAngles.x = 0
				var_300_3.localEulerAngles = var_300_3.localEulerAngles
			end

			local var_300_5 = arg_297_1.actors_["1080ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_5) and arg_297_1.var_.characterEffect1080ui_story == nil then
				arg_297_1.var_.characterEffect1080ui_story = var_300_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_6 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_6 and not isNil(var_300_5) then
				if arg_297_1.var_.characterEffect1080ui_story and not isNil(var_300_5) then
					arg_297_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_6)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_6 and arg_297_1.time_ < 0 + var_300_6 + arg_300_0 and not isNil(var_300_5) and arg_297_1.var_.characterEffect1080ui_story then
				arg_297_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_300_7 = 0
			local var_300_8 = 0.425

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_7 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_9 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1108103073).content)

				arg_297_1.text_.text = var_300_9

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 17 <= 0 and var_300_8 or var_300_8 * (utf8.len(var_300_9) / 17)

				if (17 <= 0 and var_300_8 or var_300_8 * (utf8.len(var_300_9) / 17)) > 0 and var_300_8 < var_300_11 then
					arg_297_1.talkMaxDuration = var_300_11

					if var_300_11 + var_300_7 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_7
					end
				end

				arg_297_1.text_.text = var_300_9
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_8, arg_297_1.talkMaxDuration)

			if var_300_7 <= arg_297_1.time_ and arg_297_1.time_ < var_300_7 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_7) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_7 + var_300_12 and arg_297_1.time_ < var_300_7 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play1108103074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1108103074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1108103075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.6

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1108103074).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 24 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 24)

				if (24 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 24)) > 0 and var_304_0 < var_304_3 then
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
	Play1108103075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1108103075
		arg_305_1.duration_ = 2.23

		local var_305_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1108103076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1081ui_story = arg_305_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_308_0 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 then
				arg_305_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_305_1.time_ - 0) / var_308_0)
				arg_305_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1081ui_story"].transform.position).z)
				arg_305_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1081ui_story"].transform.localEulerAngles = arg_305_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 then
				arg_305_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_305_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_305_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_305_1.actors_["1081ui_story"].transform.position).z)
				arg_305_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_305_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_305_1.actors_["1081ui_story"].transform.localEulerAngles = arg_305_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_308_1 = arg_305_1.actors_["1081ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1081ui_story == nil then
				arg_305_1.var_.characterEffect1081ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.0166666666666667

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1081ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1081ui_story then
				arg_305_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_308_4 = 0
			local var_308_5 = 0.1

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(1108103075)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 4 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 4)

				if (4 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 4)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103075", "story_v_side_new_1108103.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103075", "story_v_side_new_1108103.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_side_new_1108103", "1108103075", "story_v_side_new_1108103.awb")

						arg_305_1:RecordAudio("1108103075", var_308_11)
						arg_305_1:RecordAudio("1108103075", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103075", "story_v_side_new_1108103.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103075", "story_v_side_new_1108103.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_12 and arg_305_1.time_ < var_308_4 + var_308_12 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play1108103076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1108103076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1108103077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1081ui_story = arg_309_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1081ui_story"].transform.position).z)
				arg_309_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1081ui_story"].transform.localEulerAngles = arg_309_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_309_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1081ui_story"].transform.position).z)
				arg_309_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1081ui_story"].transform.localEulerAngles = arg_309_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1081ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1081ui_story == nil then
				arg_309_1.var_.characterEffect1081ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.0166666666666667

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1081ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_2)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1081ui_story then
				arg_309_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_312_3 = 0
			local var_312_4 = 0.3

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_3 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_5 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1108103076).content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 12 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 12)

				if (12 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 12)) > 0 and var_312_4 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_3 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_3
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_4, arg_309_1.talkMaxDuration)

			if var_312_3 <= arg_309_1.time_ and arg_309_1.time_ < var_312_3 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_3) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_3 + var_312_8 and arg_309_1.time_ < var_312_3 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play1108103077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1108103077
		arg_313_1.duration_ = 3.2

		local var_313_0 = {
			ja = 3.2,
			ko = 2.3,
			zh = 2.3
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
				arg_313_0:Play1108103078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1081ui_story = arg_313_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1081ui_story"].transform.position).z)
				arg_313_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1081ui_story"].transform.localEulerAngles = arg_313_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_313_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1081ui_story"].transform.position).z)
				arg_313_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1081ui_story"].transform.localEulerAngles = arg_313_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1081ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1081ui_story == nil then
				arg_313_1.var_.characterEffect1081ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.0166666666666667

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1081ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1081ui_story then
				arg_313_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_316_4 = 0
			local var_316_5 = 0.25

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(1108103077)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 10 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 10)

				if (10 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 10)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103077", "story_v_side_new_1108103.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103077", "story_v_side_new_1108103.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_new_1108103", "1108103077", "story_v_side_new_1108103.awb")

						arg_313_1:RecordAudio("1108103077", var_316_11)
						arg_313_1:RecordAudio("1108103077", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103077", "story_v_side_new_1108103.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103077", "story_v_side_new_1108103.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play1108103078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1108103078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1108103079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1081ui_story = arg_317_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1081ui_story"].transform.position).z)
				arg_317_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1081ui_story"].transform.localEulerAngles = arg_317_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_317_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1081ui_story"].transform.position).z)
				arg_317_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1081ui_story"].transform.localEulerAngles = arg_317_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1081ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1081ui_story == nil then
				arg_317_1.var_.characterEffect1081ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.0166666666666667

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1081ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_2)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1081ui_story then
				arg_317_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_320_3 = 0
			local var_320_4 = 0.05

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

				local var_320_5 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1108103078).content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 2 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 2)

				if (2 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 2)) > 0 and var_320_4 < var_320_7 then
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
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play1108103079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1108103079
		arg_321_1.duration_ = 4.2

		local var_321_0 = {
			ja = 2.6,
			ko = 4.2,
			zh = 4.2
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1108103080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1081ui_story = arg_321_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1081ui_story"].transform.position).z)
				arg_321_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1081ui_story"].transform.localEulerAngles = arg_321_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_321_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1081ui_story"].transform.position).z)
				arg_321_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1081ui_story"].transform.localEulerAngles = arg_321_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1081ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1081ui_story == nil then
				arg_321_1.var_.characterEffect1081ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.0166666666666667

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1081ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1081ui_story then
				arg_321_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_324_4 = 0
			local var_324_5 = 0.275

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(1108103079)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 11 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 11)

				if (11 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 11)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103079", "story_v_side_new_1108103.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103079", "story_v_side_new_1108103.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_side_new_1108103", "1108103079", "story_v_side_new_1108103.awb")

						arg_321_1:RecordAudio("1108103079", var_324_11)
						arg_321_1:RecordAudio("1108103079", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103079", "story_v_side_new_1108103.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103079", "story_v_side_new_1108103.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play1108103080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1108103080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1108103081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1081ui_story = arg_325_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1081ui_story"].transform.position).z)
				arg_325_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1081ui_story"].transform.localEulerAngles = arg_325_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_325_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1081ui_story"].transform.position).z)
				arg_325_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1081ui_story"].transform.localEulerAngles = arg_325_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1081ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1081ui_story == nil then
				arg_325_1.var_.characterEffect1081ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.0166666666666667

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1081ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_2)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1081ui_story then
				arg_325_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_328_3 = 0
			local var_328_4 = 0.225

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_5 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(1108103080).content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 9 <= 0 and var_328_4 or var_328_4 * (utf8.len(var_328_5) / 9)

				if (9 <= 0 and var_328_4 or var_328_4 * (utf8.len(var_328_5) / 9)) > 0 and var_328_4 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_3 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_3
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = math.max(var_328_4, arg_325_1.talkMaxDuration)

			if var_328_3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_3 + var_328_8 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_3) / var_328_8

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_3 + var_328_8 and arg_325_1.time_ < var_328_3 + var_328_8 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play1108103081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1108103081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1108103082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1081ui_story = arg_329_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).z)
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles = arg_329_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1081ui_story"].transform.position).z)
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1081ui_story"].transform.localEulerAngles = arg_329_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1081ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1081ui_story == nil then
				arg_329_1.var_.characterEffect1081ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.0166666666666667

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1081ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_2)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1081ui_story then
				arg_329_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_332_3 = 0
			local var_332_4 = 0.825

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_5 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(1108103081).content)

				arg_329_1.text_.text = var_332_5

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 33 <= 0 and var_332_4 or var_332_4 * (utf8.len(var_332_5) / 33)

				if (33 <= 0 and var_332_4 or var_332_4 * (utf8.len(var_332_5) / 33)) > 0 and var_332_4 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_3 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_3
					end
				end

				arg_329_1.text_.text = var_332_5
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_4, arg_329_1.talkMaxDuration)

			if var_332_3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_3 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_3) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_3 + var_332_8 and arg_329_1.time_ < var_332_3 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play1108103082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1108103082
		arg_333_1.duration_ = 7.57

		local var_333_0 = {
			ja = 7.566,
			ko = 4.466,
			zh = 4.466
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1108103083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1081ui_story = arg_333_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).z)
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles = arg_333_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_333_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1081ui_story"].transform.position).z)
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1081ui_story"].transform.localEulerAngles = arg_333_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1081ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1081ui_story == nil then
				arg_333_1.var_.characterEffect1081ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.0166666666666667

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1081ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1081ui_story then
				arg_333_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_336_4 = 0
			local var_336_5 = 0.425

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(1108103082)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 17 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 17)

				if (17 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 17)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103082", "story_v_side_new_1108103.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103082", "story_v_side_new_1108103.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_side_new_1108103", "1108103082", "story_v_side_new_1108103.awb")

						arg_333_1:RecordAudio("1108103082", var_336_11)
						arg_333_1:RecordAudio("1108103082", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103082", "story_v_side_new_1108103.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103082", "story_v_side_new_1108103.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play1108103083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1108103083
		arg_337_1.duration_ = 4.3

		local var_337_0 = {
			ja = 4.3,
			ko = 3.866,
			zh = 3.866
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
				arg_337_0:Play1108103084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1081ui_story = arg_337_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1081ui_story"].transform.position).z)
				arg_337_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1081ui_story"].transform.localEulerAngles = arg_337_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_337_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1081ui_story"].transform.position).z)
				arg_337_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1081ui_story"].transform.localEulerAngles = arg_337_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["1081ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1081ui_story == nil then
				arg_337_1.var_.characterEffect1081ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.0166666666666667

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect1081ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1081ui_story then
				arg_337_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_340_4 = 0
			local var_340_5 = 0.5

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(1108103083)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 20 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 20)

				if (20 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 20)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103083", "story_v_side_new_1108103.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103083", "story_v_side_new_1108103.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_side_new_1108103", "1108103083", "story_v_side_new_1108103.awb")

						arg_337_1:RecordAudio("1108103083", var_340_11)
						arg_337_1:RecordAudio("1108103083", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103083", "story_v_side_new_1108103.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103083", "story_v_side_new_1108103.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play1108103084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1108103084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1108103085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1081ui_story = arg_341_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1081ui_story"].transform.position).z)
				arg_341_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1081ui_story"].transform.localEulerAngles = arg_341_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_341_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1081ui_story"].transform.position).z)
				arg_341_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1081ui_story"].transform.localEulerAngles = arg_341_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1081ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1081ui_story == nil then
				arg_341_1.var_.characterEffect1081ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.0166666666666667

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1081ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_2)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1081ui_story then
				arg_341_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_344_3 = 0
			local var_344_4 = 0.35

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_5 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1108103084).content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 14 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 14)

				if (14 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 14)) > 0 and var_344_4 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_3
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_4, arg_341_1.talkMaxDuration)

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_3) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_3 + var_344_8 and arg_341_1.time_ < var_344_3 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play1108103085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1108103085
		arg_345_1.duration_ = 4.5

		local var_345_0 = {
			ja = 4.5,
			ko = 4.333,
			zh = 4.333
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
				arg_345_0:Play1108103086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1081ui_story = arg_345_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1081ui_story"].transform.position).z)
				arg_345_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1081ui_story"].transform.localEulerAngles = arg_345_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_345_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1081ui_story"].transform.position).z)
				arg_345_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1081ui_story"].transform.localEulerAngles = arg_345_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1081ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1081ui_story == nil then
				arg_345_1.var_.characterEffect1081ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.0166666666666667

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1081ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1081ui_story then
				arg_345_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_348_4 = 0
			local var_348_5 = 0.575

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(1108103085)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_9 = 23 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 23)

				if (23 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 23)) > 0 and var_348_5 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103085", "story_v_side_new_1108103.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103085", "story_v_side_new_1108103.awb") / 1000

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end

					if var_348_6.prefab_name ~= "" and arg_345_1.actors_[var_348_6.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_6.prefab_name].transform, "story_v_side_new_1108103", "1108103085", "story_v_side_new_1108103.awb")

						arg_345_1:RecordAudio("1108103085", var_348_11)
						arg_345_1:RecordAudio("1108103085", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103085", "story_v_side_new_1108103.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103085", "story_v_side_new_1108103.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_12 = math.max(var_348_5, arg_345_1.talkMaxDuration)

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_12 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_4) / var_348_12

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_4 + var_348_12 and arg_345_1.time_ < var_348_4 + var_348_12 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play1108103086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1108103086
		arg_349_1.duration_ = 9

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1108103087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if arg_349_1.bgs_.ST15 == nil then
				local var_352_0 = Object.Instantiate(arg_349_1.paintGo_)

				var_352_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15")
				var_352_0.name = "ST15"
				var_352_0.transform.parent = arg_349_1.stage_.transform
				var_352_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.bgs_.ST15 = var_352_0
			end

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= 2 + arg_352_0 then
				local var_352_1 = arg_349_1.bgs_.ST15

				arg_349_1.bgs_.ST15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_352_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_352_2 = var_352_1:GetComponent("SpriteRenderer")

				if var_352_2 and var_352_2.sprite then
					local var_352_3 = 2 * (var_352_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_352_1.transform.localScale = Vector3.New(var_352_3 / var_352_2.sprite.bounds.size.y < var_352_3 * manager.ui.mainCameraCom_.aspect / var_352_2.sprite.bounds.size.x and var_352_3 * manager.ui.mainCameraCom_.aspect / var_352_2.sprite.bounds.size.x or var_352_3 / var_352_2.sprite.bounds.size.y, var_352_3 / var_352_2.sprite.bounds.size.y < var_352_3 * manager.ui.mainCameraCom_.aspect / var_352_2.sprite.bounds.size.x and var_352_3 * manager.ui.mainCameraCom_.aspect / var_352_2.sprite.bounds.size.x or var_352_3 / var_352_2.sprite.bounds.size.y, 0)
				end

				for iter_352_0, iter_352_1 in pairs(arg_349_1.bgs_) do
					if iter_352_0 ~= "ST15" then
						iter_352_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_352_4 = 0

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.mask_.enabled = true
				arg_349_1.mask_.raycastTarget = true

				arg_349_1:SetGaussion(false)
			end

			local var_352_5 = 2

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_5 then
				local var_352_6 = Color.New(0, 0, 0)

				var_352_6.a = Mathf.Lerp(0, 1, (arg_349_1.time_ - var_352_4) / var_352_5)
				arg_349_1.mask_.color = var_352_6
			end

			if arg_349_1.time_ >= var_352_4 + var_352_5 and arg_349_1.time_ < var_352_4 + var_352_5 + arg_352_0 then
				local var_352_7 = Color.New(0, 0, 0)

				var_352_7.a = 1
				arg_349_1.mask_.color = var_352_7
			end

			local var_352_8 = 2

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.mask_.enabled = true
				arg_349_1.mask_.raycastTarget = true

				arg_349_1:SetGaussion(false)
			end

			local var_352_9 = 2

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_9 then
				local var_352_10 = Color.New(0, 0, 0)

				var_352_10.a = Mathf.Lerp(1, 0, (arg_349_1.time_ - var_352_8) / var_352_9)
				arg_349_1.mask_.color = var_352_10
			end

			if arg_349_1.time_ >= var_352_8 + var_352_9 and arg_349_1.time_ < var_352_8 + var_352_9 + arg_352_0 then
				local var_352_11 = Color.New(0, 0, 0)

				arg_349_1.mask_.enabled = false
				var_352_11.a = 0
				arg_349_1.mask_.color = var_352_11
			end

			local var_352_12 = arg_349_1.actors_["1081ui_story"].transform

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= 2 + arg_352_0 then
				arg_349_1.var_.moveOldPos1081ui_story = var_352_12.localPosition
			end

			local var_352_13 = 0.001

			if 2 <= arg_349_1.time_ and arg_349_1.time_ < 2 + var_352_13 then
				var_352_12.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 2) / var_352_13)
				var_352_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_12.position).x, (manager.ui.mainCamera.transform.position - var_352_12.position).y, (manager.ui.mainCamera.transform.position - var_352_12.position).z)
				var_352_12.localEulerAngles.z = 0
				var_352_12.localEulerAngles.x = 0
				var_352_12.localEulerAngles = var_352_12.localEulerAngles
			end

			if arg_349_1.time_ >= 2 + var_352_13 and arg_349_1.time_ < 2 + var_352_13 + arg_352_0 then
				var_352_12.localPosition = Vector3.New(0, 100, 0)
				var_352_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_12.position).x, (manager.ui.mainCamera.transform.position - var_352_12.position).y, (manager.ui.mainCamera.transform.position - var_352_12.position).z)
				var_352_12.localEulerAngles.z = 0
				var_352_12.localEulerAngles.x = 0
				var_352_12.localEulerAngles = var_352_12.localEulerAngles
			end

			local var_352_14 = arg_349_1.actors_["1081ui_story"]

			if 2 < arg_349_1.time_ and arg_349_1.time_ <= 2 + arg_352_0 and not isNil(var_352_14) and arg_349_1.var_.characterEffect1081ui_story == nil then
				arg_349_1.var_.characterEffect1081ui_story = var_352_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_15 = 0.0166666666666667

			if 2 <= arg_349_1.time_ and arg_349_1.time_ < 2 + var_352_15 and not isNil(var_352_14) then
				if arg_349_1.var_.characterEffect1081ui_story and not isNil(var_352_14) then
					arg_349_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 2) / var_352_15)
				end
			end

			if arg_349_1.time_ >= 2 + var_352_15 and arg_349_1.time_ < 2 + var_352_15 + arg_352_0 and not isNil(var_352_14) and arg_349_1.var_.characterEffect1081ui_story then
				arg_349_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if arg_349_1.frameCnt_ <= 1 then
				arg_349_1.dialog_:SetActive(false)
			end

			local var_352_16 = 4
			local var_352_17 = 0.125

			if 4 < arg_349_1.time_ and arg_349_1.time_ <= var_352_16 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				arg_349_1.dialog_:SetActive(true)

				arg_349_1.dialogCg_.alpha = 0

				local var_352_18 = LeanTween.value(arg_349_1.dialog_, 0, 1, 0.3)

				var_352_18:setOnUpdate(LuaHelper.FloatAction(function(arg_353_0)
					arg_349_1.dialogCg_.alpha = arg_353_0
				end))
				var_352_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_349_1.dialog_)
					var_352_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_349_1.duration_ = arg_349_1.duration_ + 0.3

				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_19 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1108103086).content)

				arg_349_1.text_.text = var_352_19

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_21 = 5 <= 0 and var_352_17 or var_352_17 * (utf8.len(var_352_19) / 5)

				if (5 <= 0 and var_352_17 or var_352_17 * (utf8.len(var_352_19) / 5)) > 0 and var_352_17 < var_352_21 then
					arg_349_1.talkMaxDuration = var_352_21
					var_352_16 = var_352_16 + 0.3

					if var_352_21 + var_352_16 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_21 + var_352_16
					end
				end

				arg_349_1.text_.text = var_352_19
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_22 = var_352_16 + 0.3
			local var_352_23 = math.max(var_352_17, arg_349_1.talkMaxDuration)

			if var_352_16 + 0.3 <= arg_349_1.time_ and arg_349_1.time_ < var_352_22 + var_352_23 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_22) / var_352_23

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_22 + var_352_23 and arg_349_1.time_ < var_352_22 + var_352_23 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1108103087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1108103087
		arg_355_1.duration_ = 5

		local var_355_0 = {
			ja = 5,
			ko = 3.3,
			zh = 3.3
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1108103088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1081ui_story = arg_355_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_358_0 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 then
				arg_355_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_355_1.time_ - 0) / var_358_0)
				arg_355_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1081ui_story"].transform.position).z)
				arg_355_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1081ui_story"].transform.localEulerAngles = arg_355_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 then
				arg_355_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_355_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1081ui_story"].transform.position).z)
				arg_355_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1081ui_story"].transform.localEulerAngles = arg_355_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_358_1 = arg_355_1.actors_["1081ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1081ui_story == nil then
				arg_355_1.var_.characterEffect1081ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.0166666666666667

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect1081ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect1081ui_story then
				arg_355_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_358_4 = 0
			local var_358_5 = 0.35

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(1108103087)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 14 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 14)

				if (14 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 14)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103087", "story_v_side_new_1108103.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103087", "story_v_side_new_1108103.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_side_new_1108103", "1108103087", "story_v_side_new_1108103.awb")

						arg_355_1:RecordAudio("1108103087", var_358_11)
						arg_355_1:RecordAudio("1108103087", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103087", "story_v_side_new_1108103.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103087", "story_v_side_new_1108103.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play1108103088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1108103088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1108103089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1081ui_story = arg_359_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1081ui_story"].transform.position).z)
				arg_359_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1081ui_story"].transform.localEulerAngles = arg_359_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_359_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1081ui_story"].transform.position).z)
				arg_359_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1081ui_story"].transform.localEulerAngles = arg_359_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_362_1 = arg_359_1.actors_["1081ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1081ui_story == nil then
				arg_359_1.var_.characterEffect1081ui_story = var_362_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.0166666666666667

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_2 and not isNil(var_362_1) then
				if arg_359_1.var_.characterEffect1081ui_story and not isNil(var_362_1) then
					arg_359_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_2)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_2 and arg_359_1.time_ < 0 + var_362_2 + arg_362_0 and not isNil(var_362_1) and arg_359_1.var_.characterEffect1081ui_story then
				arg_359_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_362_3 = 0
			local var_362_4 = 0.55

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_3 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_5 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1108103088).content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 22 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 22)

				if (22 <= 0 and var_362_4 or var_362_4 * (utf8.len(var_362_5) / 22)) > 0 and var_362_4 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_3 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_3
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_4, arg_359_1.talkMaxDuration)

			if var_362_3 <= arg_359_1.time_ and arg_359_1.time_ < var_362_3 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_3) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_3 + var_362_8 and arg_359_1.time_ < var_362_3 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play1108103089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1108103089
		arg_363_1.duration_ = 9.3

		local var_363_0 = {
			ja = 9.3,
			ko = 6.9,
			zh = 6.9
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1108103090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1081ui_story = arg_363_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1081ui_story"].transform.position).z)
				arg_363_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1081ui_story"].transform.localEulerAngles = arg_363_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_363_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1081ui_story"].transform.position).z)
				arg_363_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1081ui_story"].transform.localEulerAngles = arg_363_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_366_1 = arg_363_1.actors_["1081ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1081ui_story == nil then
				arg_363_1.var_.characterEffect1081ui_story = var_366_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.0166666666666667

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_2 and not isNil(var_366_1) then
				if arg_363_1.var_.characterEffect1081ui_story and not isNil(var_366_1) then
					arg_363_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_2 and arg_363_1.time_ < 0 + var_366_2 + arg_366_0 and not isNil(var_366_1) and arg_363_1.var_.characterEffect1081ui_story then
				arg_363_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_1")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_366_4 = 0
			local var_366_5 = 1.05

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_6 = arg_363_1:GetWordFromCfg(1108103089)
				local var_366_7 = arg_363_1:FormatText(var_366_6.content)

				arg_363_1.text_.text = var_366_7

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_9 = 42 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 42)

				if (42 <= 0 and var_366_5 or var_366_5 * (utf8.len(var_366_7) / 42)) > 0 and var_366_5 < var_366_9 then
					arg_363_1.talkMaxDuration = var_366_9

					if var_366_9 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_9 + var_366_4
					end
				end

				arg_363_1.text_.text = var_366_7
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103089", "story_v_side_new_1108103.awb") ~= 0 then
					local var_366_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103089", "story_v_side_new_1108103.awb") / 1000

					if var_366_10 + var_366_4 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_4
					end

					if var_366_6.prefab_name ~= "" and arg_363_1.actors_[var_366_6.prefab_name] ~= nil then
						local var_366_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_6.prefab_name].transform, "story_v_side_new_1108103", "1108103089", "story_v_side_new_1108103.awb")

						arg_363_1:RecordAudio("1108103089", var_366_11)
						arg_363_1:RecordAudio("1108103089", var_366_11)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103089", "story_v_side_new_1108103.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103089", "story_v_side_new_1108103.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_12 = math.max(var_366_5, arg_363_1.talkMaxDuration)

			if var_366_4 <= arg_363_1.time_ and arg_363_1.time_ < var_366_4 + var_366_12 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_4) / var_366_12

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_4 + var_366_12 and arg_363_1.time_ < var_366_4 + var_366_12 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play1108103090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1108103090
		arg_367_1.duration_ = 8.03

		local var_367_0 = {
			ja = 8.033,
			ko = 7.333,
			zh = 7.333
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1108103091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.975

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:GetWordFromCfg(1108103090)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 38 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 38)

				if (38 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 38)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103090", "story_v_side_new_1108103.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103090", "story_v_side_new_1108103.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_side_new_1108103", "1108103090", "story_v_side_new_1108103.awb")

						arg_367_1:RecordAudio("1108103090", var_370_6)
						arg_367_1:RecordAudio("1108103090", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103090", "story_v_side_new_1108103.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103090", "story_v_side_new_1108103.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1108103091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1108103091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1108103092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1081ui_story = arg_371_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1081ui_story"].transform.position).z)
				arg_371_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1081ui_story"].transform.localEulerAngles = arg_371_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_371_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1081ui_story"].transform.position).z)
				arg_371_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1081ui_story"].transform.localEulerAngles = arg_371_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1081ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1081ui_story == nil then
				arg_371_1.var_.characterEffect1081ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.0166666666666667

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1081ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_2)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1081ui_story then
				arg_371_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_374_3 = 0
			local var_374_4 = 0.575

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_3 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_5 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1108103091).content)

				arg_371_1.text_.text = var_374_5

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_7 = 23 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_5) / 23)

				if (23 <= 0 and var_374_4 or var_374_4 * (utf8.len(var_374_5) / 23)) > 0 and var_374_4 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_3 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_3
					end
				end

				arg_371_1.text_.text = var_374_5
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_8 = math.max(var_374_4, arg_371_1.talkMaxDuration)

			if var_374_3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_3 + var_374_8 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_3) / var_374_8

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_3 + var_374_8 and arg_371_1.time_ < var_374_3 + var_374_8 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play1108103092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1108103092
		arg_375_1.duration_ = 3.2

		local var_375_0 = {
			ja = 3.2,
			ko = 3.133,
			zh = 3.133
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1108103093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1081ui_story = arg_375_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1081ui_story"].transform.position).z)
				arg_375_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1081ui_story"].transform.localEulerAngles = arg_375_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_375_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1081ui_story"].transform.position).z)
				arg_375_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1081ui_story"].transform.localEulerAngles = arg_375_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1081ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1081ui_story == nil then
				arg_375_1.var_.characterEffect1081ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.0166666666666667

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1081ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1081ui_story then
				arg_375_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action427")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_378_4 = 0
			local var_378_5 = 0.35

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(1108103092)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 14 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 14)

				if (14 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 14)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103092", "story_v_side_new_1108103.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103092", "story_v_side_new_1108103.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_side_new_1108103", "1108103092", "story_v_side_new_1108103.awb")

						arg_375_1:RecordAudio("1108103092", var_378_11)
						arg_375_1:RecordAudio("1108103092", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103092", "story_v_side_new_1108103.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103092", "story_v_side_new_1108103.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1108103093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1108103093
		arg_379_1.duration_ = 10.37

		local var_379_0 = {
			ja = 8.133,
			ko = 10.366,
			zh = 10.366
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1108103094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1081ui_story = arg_379_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1081ui_story"].transform.position).z)
				arg_379_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1081ui_story"].transform.localEulerAngles = arg_379_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_379_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1081ui_story"].transform.position).z)
				arg_379_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1081ui_story"].transform.localEulerAngles = arg_379_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1081ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1081ui_story == nil then
				arg_379_1.var_.characterEffect1081ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.0166666666666667

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1081ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1081ui_story then
				arg_379_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_382_4 = 0
			local var_382_5 = 1.125

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_6 = arg_379_1:GetWordFromCfg(1108103093)
				local var_382_7 = arg_379_1:FormatText(var_382_6.content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 47 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 47)

				if (47 <= 0 and var_382_5 or var_382_5 * (utf8.len(var_382_7) / 47)) > 0 and var_382_5 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_4
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103093", "story_v_side_new_1108103.awb") ~= 0 then
					local var_382_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103093", "story_v_side_new_1108103.awb") / 1000

					if var_382_10 + var_382_4 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_4
					end

					if var_382_6.prefab_name ~= "" and arg_379_1.actors_[var_382_6.prefab_name] ~= nil then
						local var_382_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_6.prefab_name].transform, "story_v_side_new_1108103", "1108103093", "story_v_side_new_1108103.awb")

						arg_379_1:RecordAudio("1108103093", var_382_11)
						arg_379_1:RecordAudio("1108103093", var_382_11)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103093", "story_v_side_new_1108103.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103093", "story_v_side_new_1108103.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_12 = math.max(var_382_5, arg_379_1.talkMaxDuration)

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_4) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_4 + var_382_12 and arg_379_1.time_ < var_382_4 + var_382_12 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play1108103094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1108103094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1108103095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1081ui_story = arg_383_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1081ui_story"].transform.position).z)
				arg_383_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1081ui_story"].transform.localEulerAngles = arg_383_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_383_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1081ui_story"].transform.position).z)
				arg_383_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1081ui_story"].transform.localEulerAngles = arg_383_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["1081ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1081ui_story == nil then
				arg_383_1.var_.characterEffect1081ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.0166666666666667

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1081ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_2)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1081ui_story then
				arg_383_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_386_3 = 0
			local var_386_4 = 0.8

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_3 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_5 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1108103094).content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 32 <= 0 and var_386_4 or var_386_4 * (utf8.len(var_386_5) / 32)

				if (32 <= 0 and var_386_4 or var_386_4 * (utf8.len(var_386_5) / 32)) > 0 and var_386_4 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_3 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_3
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_8 = math.max(var_386_4, arg_383_1.talkMaxDuration)

			if var_386_3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_3 + var_386_8 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_3) / var_386_8

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_3 + var_386_8 and arg_383_1.time_ < var_386_3 + var_386_8 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play1108103095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1108103095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1108103096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1081ui_story = arg_387_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1081ui_story"].transform.position).z)
				arg_387_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1081ui_story"].transform.localEulerAngles = arg_387_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_387_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1081ui_story"].transform.position).z)
				arg_387_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1081ui_story"].transform.localEulerAngles = arg_387_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_390_1 = arg_387_1.actors_["1081ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1081ui_story == nil then
				arg_387_1.var_.characterEffect1081ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.0166666666666667

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect1081ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_2)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1081ui_story then
				arg_387_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_390_3 = 0
			local var_390_4 = 0.675

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_3 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_5 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(1108103095).content)

				arg_387_1.text_.text = var_390_5

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 27 <= 0 and var_390_4 or var_390_4 * (utf8.len(var_390_5) / 27)

				if (27 <= 0 and var_390_4 or var_390_4 * (utf8.len(var_390_5) / 27)) > 0 and var_390_4 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_3 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_3
					end
				end

				arg_387_1.text_.text = var_390_5
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_4, arg_387_1.talkMaxDuration)

			if var_390_3 <= arg_387_1.time_ and arg_387_1.time_ < var_390_3 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_3) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_3 + var_390_8 and arg_387_1.time_ < var_390_3 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play1108103096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1108103096
		arg_391_1.duration_ = 6.07

		local var_391_0 = {
			ja = 5.066,
			ko = 6.066,
			zh = 6.066
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1108103097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1081ui_story = arg_391_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1081ui_story"].transform.position).z)
				arg_391_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1081ui_story"].transform.localEulerAngles = arg_391_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_391_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1081ui_story"].transform.position).z)
				arg_391_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1081ui_story"].transform.localEulerAngles = arg_391_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_394_1 = arg_391_1.actors_["1081ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1081ui_story == nil then
				arg_391_1.var_.characterEffect1081ui_story = var_394_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 and not isNil(var_394_1) then
				if arg_391_1.var_.characterEffect1081ui_story and not isNil(var_394_1) then
					arg_391_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1081ui_story then
				arg_391_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_2")
			end

			local var_394_4 = 0
			local var_394_5 = 0.625

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_4 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_6 = arg_391_1:GetWordFromCfg(1108103096)
				local var_394_7 = arg_391_1:FormatText(var_394_6.content)

				arg_391_1.text_.text = var_394_7

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_9 = 25 <= 0 and var_394_5 or var_394_5 * (utf8.len(var_394_7) / 25)

				if (25 <= 0 and var_394_5 or var_394_5 * (utf8.len(var_394_7) / 25)) > 0 and var_394_5 < var_394_9 then
					arg_391_1.talkMaxDuration = var_394_9

					if var_394_9 + var_394_4 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_9 + var_394_4
					end
				end

				arg_391_1.text_.text = var_394_7
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103096", "story_v_side_new_1108103.awb") ~= 0 then
					local var_394_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103096", "story_v_side_new_1108103.awb") / 1000

					if var_394_10 + var_394_4 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_10 + var_394_4
					end

					if var_394_6.prefab_name ~= "" and arg_391_1.actors_[var_394_6.prefab_name] ~= nil then
						local var_394_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_6.prefab_name].transform, "story_v_side_new_1108103", "1108103096", "story_v_side_new_1108103.awb")

						arg_391_1:RecordAudio("1108103096", var_394_11)
						arg_391_1:RecordAudio("1108103096", var_394_11)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103096", "story_v_side_new_1108103.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103096", "story_v_side_new_1108103.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_12 = math.max(var_394_5, arg_391_1.talkMaxDuration)

			if var_394_4 <= arg_391_1.time_ and arg_391_1.time_ < var_394_4 + var_394_12 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_4) / var_394_12

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_4 + var_394_12 and arg_391_1.time_ < var_394_4 + var_394_12 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1108103097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1108103097
		arg_395_1.duration_ = 6.93

		local var_395_0 = {
			ja = 6.933,
			ko = 4.833,
			zh = 4.833
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1108103098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1081ui_story = arg_395_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1081ui_story"].transform.position).z)
				arg_395_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1081ui_story"].transform.localEulerAngles = arg_395_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_395_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1081ui_story"].transform.position).z)
				arg_395_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1081ui_story"].transform.localEulerAngles = arg_395_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1081ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1081ui_story == nil then
				arg_395_1.var_.characterEffect1081ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.0166666666666667

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1081ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1081ui_story then
				arg_395_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_398_4 = 0
			local var_398_5 = 0.675

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:GetWordFromCfg(1108103097)
				local var_398_7 = arg_395_1:FormatText(var_398_6.content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 27 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 27)

				if (27 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 27)) > 0 and var_398_5 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103097", "story_v_side_new_1108103.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103097", "story_v_side_new_1108103.awb") / 1000

					if var_398_10 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_4
					end

					if var_398_6.prefab_name ~= "" and arg_395_1.actors_[var_398_6.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_6.prefab_name].transform, "story_v_side_new_1108103", "1108103097", "story_v_side_new_1108103.awb")

						arg_395_1:RecordAudio("1108103097", var_398_11)
						arg_395_1:RecordAudio("1108103097", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103097", "story_v_side_new_1108103.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103097", "story_v_side_new_1108103.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_12 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_12 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_12

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_12 and arg_395_1.time_ < var_398_4 + var_398_12 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play1108103098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1108103098
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1108103099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1081ui_story = arg_399_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1081ui_story"].transform.position).z)
				arg_399_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1081ui_story"].transform.localEulerAngles = arg_399_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_399_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1081ui_story"].transform.position).z)
				arg_399_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1081ui_story"].transform.localEulerAngles = arg_399_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_402_1 = arg_399_1.actors_["1081ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1081ui_story == nil then
				arg_399_1.var_.characterEffect1081ui_story = var_402_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.0166666666666667

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_2 and not isNil(var_402_1) then
				if arg_399_1.var_.characterEffect1081ui_story and not isNil(var_402_1) then
					arg_399_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_2)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_2 and arg_399_1.time_ < 0 + var_402_2 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1081ui_story then
				arg_399_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_402_3 = 0
			local var_402_4 = 0.05

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_3 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_5 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1108103098).content)

				arg_399_1.text_.text = var_402_5

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_7 = 2 <= 0 and var_402_4 or var_402_4 * (utf8.len(var_402_5) / 2)

				if (2 <= 0 and var_402_4 or var_402_4 * (utf8.len(var_402_5) / 2)) > 0 and var_402_4 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_3 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_3
					end
				end

				arg_399_1.text_.text = var_402_5
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_8 = math.max(var_402_4, arg_399_1.talkMaxDuration)

			if var_402_3 <= arg_399_1.time_ and arg_399_1.time_ < var_402_3 + var_402_8 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_3) / var_402_8

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_3 + var_402_8 and arg_399_1.time_ < var_402_3 + var_402_8 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play1108103099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1108103099
		arg_403_1.duration_ = 7.1

		local var_403_0 = {
			ja = 7.1,
			ko = 2.433,
			zh = 2.433
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1108103100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1081ui_story = arg_403_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).z)
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles = arg_403_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_403_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1081ui_story"].transform.position).z)
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1081ui_story"].transform.localEulerAngles = arg_403_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1081ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1081ui_story == nil then
				arg_403_1.var_.characterEffect1081ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.0166666666666667

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1081ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1081ui_story then
				arg_403_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action4_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_406_4 = 0
			local var_406_5 = 0.25

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(1108103099)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 10 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 10)

				if (10 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 10)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103099", "story_v_side_new_1108103.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_side_new_1108103", "1108103099", "story_v_side_new_1108103.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_side_new_1108103", "1108103099", "story_v_side_new_1108103.awb")

						arg_403_1:RecordAudio("1108103099", var_406_11)
						arg_403_1:RecordAudio("1108103099", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1108103", "1108103099", "story_v_side_new_1108103.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1108103", "1108103099", "story_v_side_new_1108103.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1108103100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1108103100
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1108103101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1081ui_story = arg_407_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_410_0 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 then
				arg_407_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_407_1.time_ - 0) / var_410_0)
				arg_407_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).z)
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles = arg_407_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 then
				arg_407_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_407_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_407_1.actors_["1081ui_story"].transform.position).z)
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_407_1.actors_["1081ui_story"].transform.localEulerAngles = arg_407_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_410_1 = 0
			local var_410_2 = 0.85

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_3 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1108103100).content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 34 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 34)

				if (34 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 34)) > 0 and var_410_2 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_6 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_6 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_6

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_6 and arg_407_1.time_ < var_410_1 + var_410_6 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play1108103101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1108103101
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
			arg_411_1.auto_ = false
		end

		function arg_411_1.playNext_(arg_413_0)
			arg_411_1.onStoryFinished_()
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.2

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1108103101).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 8 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 8)

				if (8 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 8)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/ST15"
	},
	voices = {
		"story_v_side_new_1108103.awb"
	}
}
