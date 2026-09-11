return {
	Play921041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 921041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play921041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.X203I == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X203I")
				var_4_0.name = "X203I"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.X203I = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_1 = arg_1_1.bgs_.X203I

				arg_1_1.bgs_.X203I.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "X203I" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 1.999999999999
			local var_4_13 = 0.225

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(921041001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 9 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 9)

				if (9 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 9)) > 0 and var_4_13 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_12 = var_4_12 + 0.3

					if var_4_17 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_18 = var_4_12 + 0.3
			local var_4_19 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_18) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play921041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 921041002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play921041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.925

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(921041002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 37 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 37)

				if (37 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 37)) > 0 and var_11_0 < var_11_3 then
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
	Play921041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 921041003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play921041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.4

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(921041003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 16 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 16)

				if (16 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 16)) > 0 and var_15_0 < var_15_3 then
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
	Play921041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 921041004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play921041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1

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

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(921041004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 40 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 40)

				if (40 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 40)) > 0 and var_19_0 < var_19_3 then
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
	Play921041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 921041005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play921041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0.133333333333333 < arg_20_1.time_ and arg_20_1.time_ <= 0.133333333333333 + arg_23_0 then
				arg_20_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_23_1 = 0
			local var_23_2 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(921041005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 17 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 17)

				if (17 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 17)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play921041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 921041006
		arg_24_1.duration_ = 1.97

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play921041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.bgs_.STblack == nil then
				local var_27_0 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_27_0.name = "STblack"
				var_27_0.transform.parent = arg_24_1.stage_.transform
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_.STblack = var_27_0
			end

			if 0.766666666666667 < arg_24_1.time_ and arg_24_1.time_ <= 0.766666666666667 + arg_27_0 then
				local var_27_1 = arg_24_1.bgs_.STblack

				arg_24_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_27_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_2 = var_27_1:GetComponent("SpriteRenderer")

				if var_27_2 and var_27_2.sprite then
					local var_27_3 = 2 * (var_27_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_27_1.transform.localScale = Vector3.New(var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "STblack" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_4 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_5 = 0.766666666666667

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_5 then
				local var_27_6 = Color.New(0, 0, 0)

				var_27_6.a = Mathf.Lerp(0, 1, (arg_24_1.time_ - var_27_4) / var_27_5)
				arg_24_1.mask_.color = var_27_6
			end

			if arg_24_1.time_ >= var_27_4 + var_27_5 and arg_24_1.time_ < var_27_4 + var_27_5 + arg_27_0 then
				local var_27_7 = Color.New(0, 0, 0)

				var_27_7.a = 1
				arg_24_1.mask_.color = var_27_7
			end

			local var_27_8 = 0.766666666666667

			if 0.766666666666667 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_9 = 0.766666666666667

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_9 then
				local var_27_10 = Color.New(0, 0, 0)

				var_27_10.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_8) / var_27_9)
				arg_24_1.mask_.color = var_27_10
			end

			if arg_24_1.time_ >= var_27_8 + var_27_9 and arg_24_1.time_ < var_27_8 + var_27_9 + arg_27_0 then
				local var_27_11 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_11.a = 0
				arg_24_1.mask_.color = var_27_11
			end

			if 0.766666666666667 < arg_24_1.time_ and arg_24_1.time_ <= 0.766666666666667 + arg_27_0 then
				arg_24_1.fswbg_:SetActive(true)
				arg_24_1.dialog_:SetActive(false)

				arg_24_1.fswtw_.percent = 0
				arg_24_1.fswt_.text = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(921041006).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.fswt_)

				arg_24_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_24_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_24_1.fswtw_:SetDirty()

				arg_24_1.typewritterCharCountI18N = 0

				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_12 = 0.933333333333333

			if 0.933333333333333 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.var_.oldValueTypewriter = arg_24_1.fswtw_.percent

				SetActive(arg_24_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_24_1:ShowNextGo(false)
			end

			local var_27_13 = 7
			local var_27_14 = 0.466666666666667
			local var_27_15, var_27_16 = arg_24_1:GetPercentByPara(arg_24_1:FormatText(arg_24_1:GetWordFromCfg(921041006).content), 1)

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				local var_27_17 = var_27_13 <= 0 and var_27_14 or var_27_14 * ((var_27_16 - arg_24_1.typewritterCharCountI18N) / var_27_13)

				if (var_27_13 <= 0 and var_27_14 or var_27_14 * ((var_27_16 - arg_24_1.typewritterCharCountI18N) / var_27_13)) > 0 and var_27_14 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_12 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_12
					end
				end
			end

			local var_27_18 = math.max(0.466666666666667, arg_24_1.talkMaxDuration)

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_18 then
				arg_24_1.fswtw_.percent = Mathf.Lerp(arg_24_1.var_.oldValueTypewriter, var_27_15, (arg_24_1.time_ - var_27_12) / var_27_18)
				arg_24_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_24_1.fswtw_:SetDirty()
			end

			if arg_24_1.time_ >= var_27_12 + var_27_18 and arg_24_1.time_ < var_27_12 + var_27_18 + arg_27_0 then
				arg_24_1.fswtw_.percent = var_27_15

				arg_24_1.fswtw_:SetDirty()
				arg_24_1:ShowNextGo(true)

				arg_24_1.typewritterCharCountI18N = var_27_16
			end

			if 0.766666666666667 < arg_24_1.time_ and arg_24_1.time_ <= 0.766666666666667 + arg_27_0 then
				local var_27_19 = arg_24_1.fswbg_.transform:Find("textbox/adapt/content") or arg_24_1.fswbg_.transform:Find("textbox/content")
				local var_27_20 = arg_24_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_27_21 = var_27_19:GetComponent("RectTransform")

				var_27_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_27_21.offsetMin = Vector2.New(0, 0)
				var_27_21.offsetMax = Vector2.New(0, -114.91)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play921041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 921041007
		arg_28_1.duration_ = 8

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play921041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.bgs_.SP910901 == nil then
				local var_31_0 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP910901")
				var_31_0.name = "SP910901"
				var_31_0.transform.parent = arg_28_1.stage_.transform
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_.SP910901 = var_31_0
			end

			if 1 < arg_28_1.time_ and arg_28_1.time_ <= 1 + arg_31_0 then
				local var_31_1 = arg_28_1.bgs_.SP910901

				arg_28_1.bgs_.SP910901.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_2 = var_31_1:GetComponent("SpriteRenderer")

				if var_31_2 and var_31_2.sprite then
					local var_31_3 = 2 * (var_31_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_1.transform.localScale = Vector3.New(var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "SP910901" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_4 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_4 + 0.3 and arg_28_1.time_ < var_31_4 + 0.3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_5 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_6 = 1

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 then
				local var_31_7 = Color.New(0, 0, 0)

				var_31_7.a = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_5) / var_31_6)
				arg_28_1.mask_.color = var_31_7
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 then
				local var_31_8 = Color.New(0, 0, 0)

				var_31_8.a = 1
				arg_28_1.mask_.color = var_31_8
			end

			local var_31_9 = 1

			if 1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_10 = 2

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 then
				local var_31_11 = Color.New(0, 0, 0)

				var_31_11.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - var_31_9) / var_31_10)
				arg_28_1.mask_.color = var_31_11
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 then
				local var_31_12 = Color.New(0, 0, 0)

				arg_28_1.mask_.enabled = false
				var_31_12.a = 0
				arg_28_1.mask_.color = var_31_12
			end

			if 1 < arg_28_1.time_ and arg_28_1.time_ <= 1 + arg_31_0 then
				arg_28_1.fswbg_:SetActive(false)
				arg_28_1.dialog_:SetActive(false)
				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_28_1:ShowNextGo(false)
			end

			if 1.01666666666667 < arg_28_1.time_ and arg_28_1.time_ <= 1.01666666666667 + arg_31_0 then
				arg_28_1.fswbg_:SetActive(false)
				arg_28_1.dialog_:SetActive(false)
				SetActive(arg_28_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_28_1:ShowNextGo(false)
			end

			if 0.233333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 0.233333333333333 + arg_31_0 then
				arg_28_1:AudioAction("play", "music", "bgm_activity_3_7_story_109502_star", "bgm_activity_3_7_story_109502_star", "bgm_activity_3_7_story_109502_star.awb")

				local var_31_15 = manager.audio:GetAudioName("bgm_activity_3_7_story_109502_star", "bgm_activity_3_7_story_109502_star")

				if "" ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_15 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_15

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_15
						arg_28_1.bgmTxt2_.text = var_31_15
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_16 = 3
			local var_31_17 = 0.2

			if 3 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_18 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_18:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_28_1.dialogCg_.alpha = arg_33_0
				end))
				var_31_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_19 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(921041007).content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_21 = 8 <= 0 and var_31_17 or var_31_17 * (utf8.len(var_31_19) / 8)

				if (8 <= 0 and var_31_17 or var_31_17 * (utf8.len(var_31_19) / 8)) > 0 and var_31_17 < var_31_21 then
					arg_28_1.talkMaxDuration = var_31_21
					var_31_16 = var_31_16 + 0.3

					if var_31_21 + var_31_16 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_21 + var_31_16
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_22 = var_31_16 + 0.3
			local var_31_23 = math.max(var_31_17, arg_28_1.talkMaxDuration)

			if var_31_16 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_22 + var_31_23 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_22) / var_31_23

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_22 + var_31_23 and arg_28_1.time_ < var_31_22 + var_31_23 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play921041008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 921041008
		arg_35_1.duration_ = 4.27

		local var_35_0 = {
			zh = 3,
			ja = 4.266
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
				arg_35_0:Play921041009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.375

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(921041008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 15 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 15)

				if (15 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 15)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041008", "story_v_side_old_921041.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041008", "story_v_side_old_921041.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_side_old_921041", "921041008", "story_v_side_old_921041.awb")

						arg_35_1:RecordAudio("921041008", var_38_6)
						arg_35_1:RecordAudio("921041008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041008", "story_v_side_old_921041.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041008", "story_v_side_old_921041.awb")
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
	Play921041009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 921041009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play921041010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.45

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(921041009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 18 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 18)

				if (18 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 18)) > 0 and var_42_0 < var_42_3 then
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
	Play921041010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 921041010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play921041011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.65

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(921041010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 26 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 26)

				if (26 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 26)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play921041011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 921041011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play921041012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.125

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(921041011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 5 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 5)

				if (5 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 5)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play921041012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 921041012
		arg_51_1.duration_ = 6.47

		local var_51_0 = {
			zh = 4.233,
			ja = 6.466
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
				arg_51_0:Play921041013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:GetWordFromCfg(921041012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 18 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 18)

				if (18 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 18)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041012", "story_v_side_old_921041.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041012", "story_v_side_old_921041.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_side_old_921041", "921041012", "story_v_side_old_921041.awb")

						arg_51_1:RecordAudio("921041012", var_54_6)
						arg_51_1:RecordAudio("921041012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041012", "story_v_side_old_921041.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041012", "story_v_side_old_921041.awb")
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
	Play921041013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 921041013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play921041014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.475

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(921041013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 19 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 19)

				if (19 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 19)) > 0 and var_58_0 < var_58_3 then
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
	Play921041014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 921041014
		arg_59_1.duration_ = 6.13

		local var_59_0 = {
			zh = 5.433,
			ja = 6.133
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
				arg_59_0:Play921041015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.4

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(921041014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 16 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 16)

				if (16 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 16)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041014", "story_v_side_old_921041.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041014", "story_v_side_old_921041.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_side_old_921041", "921041014", "story_v_side_old_921041.awb")

						arg_59_1:RecordAudio("921041014", var_62_6)
						arg_59_1:RecordAudio("921041014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041014", "story_v_side_old_921041.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041014", "story_v_side_old_921041.awb")
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
	Play921041015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 921041015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play921041016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.075

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
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

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(921041015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 3 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 3)

				if (3 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 3)) > 0 and var_66_0 < var_66_3 then
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
	Play921041016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 921041016
		arg_67_1.duration_ = 14.67

		local var_67_0 = {
			zh = 14.666,
			ja = 9.833
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play921041017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.175

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(921041016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 47 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 47)

				if (47 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 47)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041016", "story_v_side_old_921041.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041016", "story_v_side_old_921041.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_side_old_921041", "921041016", "story_v_side_old_921041.awb")

						arg_67_1:RecordAudio("921041016", var_70_6)
						arg_67_1:RecordAudio("921041016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041016", "story_v_side_old_921041.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041016", "story_v_side_old_921041.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play921041017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 921041017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play921041018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.275

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
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

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(921041017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 11 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 11)

				if (11 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 11)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play921041018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 921041018
		arg_75_1.duration_ = 5.7

		local var_75_0 = {
			zh = 3.2,
			ja = 5.7
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
				arg_75_0:Play921041019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.35

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(921041018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 14 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 14)

				if (14 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 14)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041018", "story_v_side_old_921041.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041018", "story_v_side_old_921041.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_side_old_921041", "921041018", "story_v_side_old_921041.awb")

						arg_75_1:RecordAudio("921041018", var_78_6)
						arg_75_1:RecordAudio("921041018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041018", "story_v_side_old_921041.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041018", "story_v_side_old_921041.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play921041019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 921041019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play921041020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.375

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(921041019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 15 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 15)

				if (15 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 15)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play921041020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 921041020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play921041021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.4

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(921041020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 16 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 16)

				if (16 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 16)) > 0 and var_86_0 < var_86_3 then
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
	Play921041021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 921041021
		arg_87_1.duration_ = 5.27

		local var_87_0 = {
			zh = 4.6,
			ja = 5.266
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
				arg_87_0:Play921041022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.525

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(921041021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 21 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 21)

				if (21 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 21)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041021", "story_v_side_old_921041.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041021", "story_v_side_old_921041.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_side_old_921041", "921041021", "story_v_side_old_921041.awb")

						arg_87_1:RecordAudio("921041021", var_90_6)
						arg_87_1:RecordAudio("921041021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041021", "story_v_side_old_921041.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041021", "story_v_side_old_921041.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play921041022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 921041022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play921041023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.475

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(921041022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 19 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 19)

				if (19 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 19)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play921041023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 921041023
		arg_95_1.duration_ = 11.97

		local var_95_0 = {
			zh = 11.4326666666667,
			ja = 11.9666666666667
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play921041024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 then
				local var_98_0 = arg_95_1.bgs_.STblack

				arg_95_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_1 = var_98_0:GetComponent("SpriteRenderer")

				if var_98_1 and var_98_1.sprite then
					local var_98_2 = 2 * (var_98_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_0.transform.localScale = Vector3.New(var_98_2 / var_98_1.sprite.bounds.size.y < var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x and var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x or var_98_2 / var_98_1.sprite.bounds.size.y, var_98_2 / var_98_1.sprite.bounds.size.y < var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x and var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x or var_98_2 / var_98_1.sprite.bounds.size.y, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "STblack" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(true)
				arg_95_1.dialog_:SetActive(false)

				arg_95_1.fswtw_.percent = 0
				arg_95_1.fswt_.text = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(921041125).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.fswt_)

				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_95_1.fswtw_:SetDirty()

				arg_95_1.typewritterCharCountI18N = 0

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_3 = 1.53333333333333

			if 1.53333333333333 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.var_.oldValueTypewriter = arg_95_1.fswtw_.percent

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_4 = 24
			local var_98_5 = 1.1
			local var_98_6, var_98_7 = arg_95_1:GetPercentByPara(arg_95_1:FormatText(arg_95_1:GetWordFromCfg(921041125).content), 1)

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				local var_98_8 = var_98_4 <= 0 and var_98_5 or var_98_5 * ((var_98_7 - arg_95_1.typewritterCharCountI18N) / var_98_4)

				if (var_98_4 <= 0 and var_98_5 or var_98_5 * ((var_98_7 - arg_95_1.typewritterCharCountI18N) / var_98_4)) > 0 and var_98_5 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_3
					end
				end
			end

			local var_98_9 = math.max(1.1, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_9 then
				arg_95_1.fswtw_.percent = Mathf.Lerp(arg_95_1.var_.oldValueTypewriter, var_98_6, (arg_95_1.time_ - var_98_3) / var_98_9)
				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_95_1.fswtw_:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_9 and arg_95_1.time_ < var_98_3 + var_98_9 + arg_98_0 then
				arg_95_1.fswtw_.percent = var_98_6

				arg_95_1.fswtw_:SetDirty()
				arg_95_1:ShowNextGo(true)

				arg_95_1.typewritterCharCountI18N = var_98_7
			end

			if 4.8 < arg_95_1.time_ and arg_95_1.time_ <= 4.8 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(false)
				arg_95_1.dialog_:SetActive(false)
				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			if 4.81666666666667 < arg_95_1.time_ and arg_95_1.time_ <= 4.81666666666667 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(false)
				arg_95_1.dialog_:SetActive(false)
				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= 1 + arg_98_0 then
				local var_98_10 = arg_95_1.fswbg_.transform:Find("textbox/adapt/content") or arg_95_1.fswbg_.transform:Find("textbox/content")
				local var_98_11 = arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_98_12 = var_98_10:GetComponent("RectTransform")

				var_98_10:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_98_12.offsetMin = Vector2.New(0, 0)
				var_98_12.offsetMax = Vector2.New(0, -114.91)
			end

			local var_98_13 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_14 = 1

			if var_98_13 <= arg_95_1.time_ and arg_95_1.time_ < var_98_13 + var_98_14 then
				local var_98_15 = Color.New(0, 0, 0)

				var_98_15.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_13) / var_98_14)
				arg_95_1.mask_.color = var_98_15
			end

			if arg_95_1.time_ >= var_98_13 + var_98_14 and arg_95_1.time_ < var_98_13 + var_98_14 + arg_98_0 then
				local var_98_16 = Color.New(0, 0, 0)

				var_98_16.a = 1
				arg_95_1.mask_.color = var_98_16
			end

			local var_98_17 = 1

			if 1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_17 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_18 = 0.333333333333333

			if var_98_17 <= arg_95_1.time_ and arg_95_1.time_ < var_98_17 + var_98_18 then
				local var_98_19 = Color.New(0, 0, 0)

				var_98_19.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_17) / var_98_18)
				arg_95_1.mask_.color = var_98_19
			end

			if arg_95_1.time_ >= var_98_17 + var_98_18 and arg_95_1.time_ < var_98_17 + var_98_18 + arg_98_0 then
				local var_98_20 = Color.New(0, 0, 0)

				arg_95_1.mask_.enabled = false
				var_98_20.a = 0
				arg_95_1.mask_.color = var_98_20
			end

			local var_98_21 = 3.4

			if 3.4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_21 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_22 = 1.4

			if var_98_21 <= arg_95_1.time_ and arg_95_1.time_ < var_98_21 + var_98_22 then
				local var_98_23 = Color.New(0, 0, 0)

				var_98_23.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_21) / var_98_22)
				arg_95_1.mask_.color = var_98_23
			end

			if arg_95_1.time_ >= var_98_21 + var_98_22 and arg_95_1.time_ < var_98_21 + var_98_22 + arg_98_0 then
				local var_98_24 = Color.New(0, 0, 0)

				var_98_24.a = 1
				arg_95_1.mask_.color = var_98_24
			end

			local var_98_25 = 4.8

			if 4.8 < arg_95_1.time_ and arg_95_1.time_ <= var_98_25 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_26 = 2.06666666666667

			if var_98_25 <= arg_95_1.time_ and arg_95_1.time_ < var_98_25 + var_98_26 then
				local var_98_27 = Color.New(0, 0, 0)

				var_98_27.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_25) / var_98_26)
				arg_95_1.mask_.color = var_98_27
			end

			if arg_95_1.time_ >= var_98_25 + var_98_26 and arg_95_1.time_ < var_98_25 + var_98_26 + arg_98_0 then
				local var_98_28 = Color.New(0, 0, 0)

				arg_95_1.mask_.enabled = false
				var_98_28.a = 0
				arg_95_1.mask_.color = var_98_28
			end

			if 4.8 < arg_95_1.time_ and arg_95_1.time_ <= 4.8 + arg_98_0 then
				local var_98_29 = arg_95_1.bgs_.SP910901

				arg_95_1.bgs_.SP910901.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_30 = var_98_29:GetComponent("SpriteRenderer")

				if var_98_30 and var_98_30.sprite then
					local var_98_31 = 2 * (var_98_29.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_29.transform.localScale = Vector3.New(var_98_31 / var_98_30.sprite.bounds.size.y < var_98_31 * manager.ui.mainCameraCom_.aspect / var_98_30.sprite.bounds.size.x and var_98_31 * manager.ui.mainCameraCom_.aspect / var_98_30.sprite.bounds.size.x or var_98_31 / var_98_30.sprite.bounds.size.y, var_98_31 / var_98_30.sprite.bounds.size.y < var_98_31 * manager.ui.mainCameraCom_.aspect / var_98_30.sprite.bounds.size.x and var_98_31 * manager.ui.mainCameraCom_.aspect / var_98_30.sprite.bounds.size.x or var_98_31 / var_98_30.sprite.bounds.size.y, 0)
				end

				for iter_98_2, iter_98_3 in pairs(arg_95_1.bgs_) do
					if iter_98_2 ~= "SP910901" then
						iter_98_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_32 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_32 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			if arg_95_1.time_ >= var_98_32 + 5.36666666666667 and arg_95_1.time_ < var_98_32 + 5.36666666666667 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_33 = 6.56666666666667
			local var_98_34 = 0.975

			if 6.56666666666667 < arg_95_1.time_ and arg_95_1.time_ <= var_98_33 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_35 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_35:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_36 = arg_95_1:GetWordFromCfg(921041023)
				local var_98_37 = arg_95_1:FormatText(var_98_36.content)

				arg_95_1.text_.text = var_98_37

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_39 = 19 <= 0 and var_98_34 or var_98_34 * (utf8.len(var_98_37) / 19)

				if (19 <= 0 and var_98_34 or var_98_34 * (utf8.len(var_98_37) / 19)) > 0 and var_98_34 < var_98_39 then
					arg_95_1.talkMaxDuration = var_98_39
					var_98_33 = var_98_33 + 0.3

					if var_98_39 + var_98_33 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_39 + var_98_33
					end
				end

				arg_95_1.text_.text = var_98_37
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041023", "story_v_side_old_921041.awb") ~= 0 then
					local var_98_40 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041023", "story_v_side_old_921041.awb") / 1000

					if var_98_40 + var_98_33 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_40 + var_98_33
					end

					if var_98_36.prefab_name ~= "" and arg_95_1.actors_[var_98_36.prefab_name] ~= nil then
						local var_98_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_36.prefab_name].transform, "story_v_side_old_921041", "921041023", "story_v_side_old_921041.awb")

						arg_95_1:RecordAudio("921041023", var_98_41)
						arg_95_1:RecordAudio("921041023", var_98_41)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041023", "story_v_side_old_921041.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041023", "story_v_side_old_921041.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_42 = var_98_33 + 0.3
			local var_98_43 = math.max(var_98_34, arg_95_1.talkMaxDuration)

			if var_98_33 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_42 + var_98_43 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_42) / var_98_43

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_42 + var_98_43 and arg_95_1.time_ < var_98_42 + var_98_43 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play921041024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 921041024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play921041025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.1

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

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(921041024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 4 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 4)

				if (4 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 4)) > 0 and var_104_0 < var_104_3 then
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
	Play921041025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 921041025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play921041026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 1.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(921041025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 60 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 60)

				if (60 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 60)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play921041026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 921041026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play921041027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.225

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

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(921041026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 9 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 9)

				if (9 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 9)) > 0 and var_112_0 < var_112_3 then
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
	Play921041027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 921041027
		arg_113_1.duration_ = 1.7

		local var_113_0 = {
			zh = 1.033,
			ja = 1.7
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
				arg_113_0:Play921041028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(921041027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 4 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 4)

				if (4 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 4)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041027", "story_v_side_old_921041.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041027", "story_v_side_old_921041.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_side_old_921041", "921041027", "story_v_side_old_921041.awb")

						arg_113_1:RecordAudio("921041027", var_116_6)
						arg_113_1:RecordAudio("921041027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041027", "story_v_side_old_921041.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041027", "story_v_side_old_921041.awb")
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
	Play921041028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 921041028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play921041029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.575

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

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(921041028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 23 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 23)

				if (23 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 23)) > 0 and var_120_0 < var_120_3 then
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
	Play921041029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 921041029
		arg_121_1.duration_ = 9.13

		local var_121_0 = {
			zh = 6.233,
			ja = 9.133
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
				arg_121_0:Play921041030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.7

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:GetWordFromCfg(921041029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 28 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 28)

				if (28 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 28)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041029", "story_v_side_old_921041.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041029", "story_v_side_old_921041.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_side_old_921041", "921041029", "story_v_side_old_921041.awb")

						arg_121_1:RecordAudio("921041029", var_124_6)
						arg_121_1:RecordAudio("921041029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041029", "story_v_side_old_921041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041029", "story_v_side_old_921041.awb")
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
	Play921041030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 921041030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play921041031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.35

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

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(921041030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 14 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 14)

				if (14 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 14)) > 0 and var_128_0 < var_128_3 then
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
	Play921041031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 921041031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play921041032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.7

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(921041031).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 28 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 28)

				if (28 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 28)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play921041032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 921041032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play921041033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.725

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(921041032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 29 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 29)

				if (29 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 29)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play921041033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 921041033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play921041034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.075

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(921041033).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 43 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 43)

				if (43 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 43)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play921041034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 921041034
		arg_141_1.duration_ = 3.53

		local var_141_0 = {
			zh = 3.4,
			ja = 3.533
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
				arg_141_0:Play921041035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.325

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(921041034)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 13 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 13)

				if (13 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 13)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041034", "story_v_side_old_921041.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041034", "story_v_side_old_921041.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_side_old_921041", "921041034", "story_v_side_old_921041.awb")

						arg_141_1:RecordAudio("921041034", var_144_6)
						arg_141_1:RecordAudio("921041034", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041034", "story_v_side_old_921041.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041034", "story_v_side_old_921041.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play921041035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 921041035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play921041036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.3

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

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(921041035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 12)

				if (12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 12)) > 0 and var_148_0 < var_148_3 then
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
	Play921041036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 921041036
		arg_149_1.duration_ = 8.17

		local var_149_0 = {
			zh = 7.033,
			ja = 8.166
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play921041037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.75

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(921041036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 30 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 30)

				if (30 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 30)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041036", "story_v_side_old_921041.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041036", "story_v_side_old_921041.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_side_old_921041", "921041036", "story_v_side_old_921041.awb")

						arg_149_1:RecordAudio("921041036", var_152_6)
						arg_149_1:RecordAudio("921041036", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041036", "story_v_side_old_921041.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041036", "story_v_side_old_921041.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play921041037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 921041037
		arg_153_1.duration_ = 4.67

		local var_153_0 = {
			zh = 2.5,
			ja = 4.666
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
				arg_153_0:Play921041038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.25

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(921041037)
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

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041037", "story_v_side_old_921041.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041037", "story_v_side_old_921041.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_side_old_921041", "921041037", "story_v_side_old_921041.awb")

						arg_153_1:RecordAudio("921041037", var_156_6)
						arg_153_1:RecordAudio("921041037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041037", "story_v_side_old_921041.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041037", "story_v_side_old_921041.awb")
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
	Play921041038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 921041038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play921041039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.625

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

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(921041038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 25 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 25)

				if (25 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 25)) > 0 and var_160_0 < var_160_3 then
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
	Play921041039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 921041039
		arg_161_1.duration_ = 3.8

		local var_161_0 = {
			zh = 1.366,
			ja = 3.8
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
				arg_161_0:Play921041040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.15

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(921041039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 6 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 6)

				if (6 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 6)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041039", "story_v_side_old_921041.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041039", "story_v_side_old_921041.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_side_old_921041", "921041039", "story_v_side_old_921041.awb")

						arg_161_1:RecordAudio("921041039", var_164_6)
						arg_161_1:RecordAudio("921041039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041039", "story_v_side_old_921041.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041039", "story_v_side_old_921041.awb")
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
	Play921041040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 921041040
		arg_165_1.duration_ = 6.93

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play921041041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPosSP910901 = arg_165_1.bgs_.SP910901.transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.bgs_.SP910901.transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosSP910901, Vector3.New(0, 1, 10), (arg_165_1.time_ - 0) / var_168_0)
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.bgs_.SP910901.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_168_1 = arg_165_1.bgs_.SP910901.transform

			if 0.0166666666666667 < arg_165_1.time_ and arg_165_1.time_ <= 0.0166666666666667 + arg_168_0 then
				arg_165_1.var_.moveOldPosSP910901 = var_168_1.localPosition
			end

			local var_168_2 = 2.69166666666667

			if 0.0166666666666667 <= arg_165_1.time_ and arg_165_1.time_ < 0.0166666666666667 + var_168_2 then
				var_168_1.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosSP910901, Vector3.New(0, 0.73, 8), (arg_165_1.time_ - 0.0166666666666667) / var_168_2)
			end

			if arg_165_1.time_ >= 0.0166666666666667 + var_168_2 and arg_165_1.time_ < 0.0166666666666667 + var_168_2 + arg_168_0 then
				var_168_1.localPosition = Vector3.New(0, 0.73, 8)
			end

			local var_168_3 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			if arg_165_1.time_ >= var_168_3 + 2.46666666666667 and arg_165_1.time_ < var_168_3 + 2.46666666666667 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_4 = 1.93333333333333
			local var_168_5 = 1.075

			if 1.93333333333333 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_6 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_6:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(921041040).content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 43 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 43)

				if (43 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 43)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9
					var_168_4 = var_168_4 + 0.3

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = var_168_4 + 0.3
			local var_168_11 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SP910901",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SP910901",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.69166666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play921041041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 921041041
		arg_171_1.duration_ = 6.63

		local var_171_0 = {
			zh = 6.633,
			ja = 5.133
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play921041042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.575

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(921041041)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 23 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 23)

				if (23 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 23)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041041", "story_v_side_old_921041.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041041", "story_v_side_old_921041.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_side_old_921041", "921041041", "story_v_side_old_921041.awb")

						arg_171_1:RecordAudio("921041041", var_174_6)
						arg_171_1:RecordAudio("921041041", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041041", "story_v_side_old_921041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041041", "story_v_side_old_921041.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play921041042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 921041042
		arg_175_1.duration_ = 6.33

		local var_175_0 = {
			zh = 6.333,
			ja = 6.166
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play921041043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.75

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(921041042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 30 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 30)

				if (30 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 30)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041042", "story_v_side_old_921041.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041042", "story_v_side_old_921041.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_side_old_921041", "921041042", "story_v_side_old_921041.awb")

						arg_175_1:RecordAudio("921041042", var_178_6)
						arg_175_1:RecordAudio("921041042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041042", "story_v_side_old_921041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041042", "story_v_side_old_921041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play921041043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 921041043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play921041044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.275

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(921041043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 51 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 51)

				if (51 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 51)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play921041044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 921041044
		arg_183_1.duration_ = 3.53

		local var_183_0 = {
			zh = 1.433,
			ja = 3.533
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play921041045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.15

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(921041044)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 6 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 6)

				if (6 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 6)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041044", "story_v_side_old_921041.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041044", "story_v_side_old_921041.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_side_old_921041", "921041044", "story_v_side_old_921041.awb")

						arg_183_1:RecordAudio("921041044", var_186_6)
						arg_183_1:RecordAudio("921041044", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041044", "story_v_side_old_921041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041044", "story_v_side_old_921041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play921041045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 921041045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play921041046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(921041045).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 11 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 11)

				if (11 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 11)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play921041046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 921041046
		arg_191_1.duration_ = 8.57

		local var_191_0 = {
			zh = 8.566,
			ja = 7.566
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play921041047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.725

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(921041046)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 29 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 29)

				if (29 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 29)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041046", "story_v_side_old_921041.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041046", "story_v_side_old_921041.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_side_old_921041", "921041046", "story_v_side_old_921041.awb")

						arg_191_1:RecordAudio("921041046", var_194_6)
						arg_191_1:RecordAudio("921041046", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041046", "story_v_side_old_921041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041046", "story_v_side_old_921041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play921041047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 921041047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play921041048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.55

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

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(921041047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 22 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 22)

				if (22 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 22)) > 0 and var_198_0 < var_198_3 then
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
	Play921041048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 921041048
		arg_199_1.duration_ = 8.93

		local var_199_0 = {
			zh = 3.2,
			ja = 8.933
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play921041049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.4

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(921041048)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 16 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 16)

				if (16 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 16)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041048", "story_v_side_old_921041.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041048", "story_v_side_old_921041.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_side_old_921041", "921041048", "story_v_side_old_921041.awb")

						arg_199_1:RecordAudio("921041048", var_202_6)
						arg_199_1:RecordAudio("921041048", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041048", "story_v_side_old_921041.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041048", "story_v_side_old_921041.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play921041049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 921041049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play921041050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.25

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
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

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(921041049).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 10 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 10)

				if (10 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 10)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play921041050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 921041050
		arg_207_1.duration_ = 8.27

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play921041051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if arg_207_1.bgs_.ST60 == nil then
				local var_210_0 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST60")
				var_210_0.name = "ST60"
				var_210_0.transform.parent = arg_207_1.stage_.transform
				var_210_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_.ST60 = var_210_0
			end

			if 1.46666666666667 < arg_207_1.time_ and arg_207_1.time_ <= 1.46666666666667 + arg_210_0 then
				local var_210_1 = arg_207_1.bgs_.ST60

				arg_207_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_2 = var_210_1:GetComponent("SpriteRenderer")

				if var_210_2 and var_210_2.sprite then
					local var_210_3 = 2 * (var_210_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_1.transform.localScale = Vector3.New(var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "ST60" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_4 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_5 = 1.46666666666667

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_5 then
				local var_210_6 = Color.New(0, 0, 0)

				var_210_6.a = Mathf.Lerp(0, 1, (arg_207_1.time_ - var_210_4) / var_210_5)
				arg_207_1.mask_.color = var_210_6
			end

			if arg_207_1.time_ >= var_210_4 + var_210_5 and arg_207_1.time_ < var_210_4 + var_210_5 + arg_210_0 then
				local var_210_7 = Color.New(0, 0, 0)

				var_210_7.a = 1
				arg_207_1.mask_.color = var_210_7
			end

			local var_210_8 = 1.46666666666667

			if 1.46666666666667 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_9 = 2

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 then
				local var_210_10 = Color.New(0, 0, 0)

				var_210_10.a = Mathf.Lerp(1, 0, (arg_207_1.time_ - var_210_8) / var_210_9)
				arg_207_1.mask_.color = var_210_10
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 then
				local var_210_11 = Color.New(0, 0, 0)

				arg_207_1.mask_.enabled = false
				var_210_11.a = 0
				arg_207_1.mask_.color = var_210_11
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_12 = 3.26666666666667
			local var_210_13 = 0.7

			if 3.26666666666667 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_14 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_14:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_15 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(921041050).content)

				arg_207_1.text_.text = var_210_15

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_17 = 28 <= 0 and var_210_13 or var_210_13 * (utf8.len(var_210_15) / 28)

				if (28 <= 0 and var_210_13 or var_210_13 * (utf8.len(var_210_15) / 28)) > 0 and var_210_13 < var_210_17 then
					arg_207_1.talkMaxDuration = var_210_17
					var_210_12 = var_210_12 + 0.3

					if var_210_17 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_17 + var_210_12
					end
				end

				arg_207_1.text_.text = var_210_15
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_18 = var_210_12 + 0.3
			local var_210_19 = math.max(var_210_13, arg_207_1.talkMaxDuration)

			if var_210_12 + 0.3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_18 + var_210_19 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_18) / var_210_19

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_18 + var_210_19 and arg_207_1.time_ < var_210_18 + var_210_19 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play921041051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 921041051
		arg_213_1.duration_ = 11.57

		local var_213_0 = {
			zh = 10.4,
			ja = 11.566
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
				arg_213_0:Play921041052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.actors_["10125ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10125ui_story"))) then
				local var_216_0 = Object.Instantiate(Asset.Load("Char/" .. "10125ui_story"), arg_213_1.stage_.transform)

				var_216_0.name = "10125ui_story"
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_["10125ui_story"] = var_216_0

				local var_216_1 = var_216_0:GetComponentInChildren(typeof(CharacterEffect))

				var_216_1.enabled = true

				local var_216_2 = GameObjectTools.GetOrAddComponent(var_216_0, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(false)
				end

				arg_213_1:ShowWeapon(var_216_1.transform, false)

				arg_213_1.var_["10125ui_story" .. "Animator"] = var_216_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_213_1.var_["10125ui_story" .. "Animator"].applyRootMotion = true
				arg_213_1.var_["10125ui_story" .. "LipSync"] = var_216_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_216_3 = arg_213_1.actors_["10125ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10125ui_story = var_216_3.localPosition
			end

			local var_216_4 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				var_216_3.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10125ui_story, Vector3.New(0, -0.98, -6.1), (arg_213_1.time_ - 0) / var_216_4)
				var_216_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_3.position).x, (manager.ui.mainCamera.transform.position - var_216_3.position).y, (manager.ui.mainCamera.transform.position - var_216_3.position).z)
				var_216_3.localEulerAngles.z = 0
				var_216_3.localEulerAngles.x = 0
				var_216_3.localEulerAngles = var_216_3.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				var_216_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_216_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_3.position).x, (manager.ui.mainCamera.transform.position - var_216_3.position).y, (manager.ui.mainCamera.transform.position - var_216_3.position).z)
				var_216_3.localEulerAngles.z = 0
				var_216_3.localEulerAngles.x = 0
				var_216_3.localEulerAngles = var_216_3.localEulerAngles
			end

			local var_216_5 = arg_213_1.actors_["10125ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.characterEffect10125ui_story == nil then
				arg_213_1.var_.characterEffect10125ui_story = var_216_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_6 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_6 and not isNil(var_216_5) then
				if arg_213_1.var_.characterEffect10125ui_story and not isNil(var_216_5) then
					arg_213_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_6 and arg_213_1.time_ < 0 + var_216_6 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.characterEffect10125ui_story then
				arg_213_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action3_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_216_8 = 0
			local var_216_9 = 0.925

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(921041051)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 37 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 37)

				if (37 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 37)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041051", "story_v_side_old_921041.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041051", "story_v_side_old_921041.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_side_old_921041", "921041051", "story_v_side_old_921041.awb")

						arg_213_1:RecordAudio("921041051", var_216_15)
						arg_213_1:RecordAudio("921041051", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041051", "story_v_side_old_921041.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041051", "story_v_side_old_921041.awb")
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
				actorName = "10125ui_story",
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
	Play921041052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 921041052
		arg_217_1.duration_ = 6.03

		local var_217_0 = {
			zh = 3.433,
			ja = 6.033
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
				arg_217_0:Play921041053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.3

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(921041052)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 12 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 12)

				if (12 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 12)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041052", "story_v_side_old_921041.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041052", "story_v_side_old_921041.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_side_old_921041", "921041052", "story_v_side_old_921041.awb")

						arg_217_1:RecordAudio("921041052", var_220_6)
						arg_217_1:RecordAudio("921041052", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041052", "story_v_side_old_921041.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041052", "story_v_side_old_921041.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play921041053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 921041053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play921041054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10125ui_story = arg_221_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10125ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10125ui_story"].transform.position).z)
				arg_221_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10125ui_story"].transform.localEulerAngles = arg_221_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10125ui_story"].transform.position).z)
				arg_221_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10125ui_story"].transform.localEulerAngles = arg_221_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["10125ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10125ui_story == nil then
				arg_221_1.var_.characterEffect10125ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect10125ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_2)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10125ui_story then
				arg_221_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_224_3 = 0
			local var_224_4 = 1.05

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_5 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(921041053).content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 44 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 44)

				if (44 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 44)) > 0 and var_224_4 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_3
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_4, arg_221_1.talkMaxDuration)

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_3) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_3 + var_224_8 and arg_221_1.time_ < var_224_3 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
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
	Play921041054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 921041054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play921041055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.8

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

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(921041054).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 32 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 32)

				if (32 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 32)) > 0 and var_228_0 < var_228_3 then
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
	Play921041055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 921041055
		arg_229_1.duration_ = 2.43

		local var_229_0 = {
			zh = 2.433,
			ja = 1.999999999999
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
				arg_229_0:Play921041056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10125ui_story = arg_229_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10125ui_story, Vector3.New(0, -0.98, -6.1), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10125ui_story"].transform.position).z)
				arg_229_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10125ui_story"].transform.localEulerAngles = arg_229_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_229_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10125ui_story"].transform.position).z)
				arg_229_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10125ui_story"].transform.localEulerAngles = arg_229_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["10125ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect10125ui_story == nil then
				arg_229_1.var_.characterEffect10125ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect10125ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect10125ui_story then
				arg_229_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action3_2")
			end

			local var_232_4 = 0
			local var_232_5 = 0.1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(921041055)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 4 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 4)

				if (4 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 4)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041055", "story_v_side_old_921041.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041055", "story_v_side_old_921041.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_side_old_921041", "921041055", "story_v_side_old_921041.awb")

						arg_229_1:RecordAudio("921041055", var_232_11)
						arg_229_1:RecordAudio("921041055", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041055", "story_v_side_old_921041.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041055", "story_v_side_old_921041.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
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
	Play921041056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 921041056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play921041057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10125ui_story"]) and arg_233_1.var_.characterEffect10125ui_story == nil then
				arg_233_1.var_.characterEffect10125ui_story = arg_233_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10125ui_story"]) then
				if arg_233_1.var_.characterEffect10125ui_story and not isNil(arg_233_1.actors_["10125ui_story"]) then
					arg_233_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10125ui_story"]) and arg_233_1.var_.characterEffect10125ui_story then
				arg_233_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.1

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(921041056).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 4 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 4)

				if (4 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 4)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play921041057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 921041057
		arg_237_1.duration_ = 3.8

		local var_237_0 = {
			zh = 1.999999999999,
			ja = 3.8
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play921041058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10125ui_story"]) and arg_237_1.var_.characterEffect10125ui_story == nil then
				arg_237_1.var_.characterEffect10125ui_story = arg_237_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10125ui_story"]) then
				if arg_237_1.var_.characterEffect10125ui_story and not isNil(arg_237_1.actors_["10125ui_story"]) then
					arg_237_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10125ui_story"]) and arg_237_1.var_.characterEffect10125ui_story then
				arg_237_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_240_2 = 0
			local var_240_3 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:GetWordFromCfg(921041057)
				local var_240_5 = arg_237_1:FormatText(var_240_4.content)

				arg_237_1.text_.text = var_240_5

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_7 = 5 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 5)

				if (5 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_5) / 5)) > 0 and var_240_3 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_5
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041057", "story_v_side_old_921041.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041057", "story_v_side_old_921041.awb") / 1000

					if var_240_8 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_2
					end

					if var_240_4.prefab_name ~= "" and arg_237_1.actors_[var_240_4.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_4.prefab_name].transform, "story_v_side_old_921041", "921041057", "story_v_side_old_921041.awb")

						arg_237_1:RecordAudio("921041057", var_240_9)
						arg_237_1:RecordAudio("921041057", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041057", "story_v_side_old_921041.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041057", "story_v_side_old_921041.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_10 and arg_237_1.time_ < var_240_2 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play921041058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 921041058
		arg_241_1.duration_ = 7.12

		local var_241_0 = {
			zh = 4.758,
			ja = 7.125
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
				arg_241_0:Play921041059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action1_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_0 = 0.525
			local var_244_1 = 0.475

			if 0.525 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_2 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_2:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(921041058)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 19 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_4) / 19)

				if (19 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_4) / 19)) > 0 and var_244_1 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6
					var_244_0 = var_244_0 + 0.3

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041058", "story_v_side_old_921041.awb") ~= 0 then
					local var_244_7 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041058", "story_v_side_old_921041.awb") / 1000

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_side_old_921041", "921041058", "story_v_side_old_921041.awb")

						arg_241_1:RecordAudio("921041058", var_244_8)
						arg_241_1:RecordAudio("921041058", var_244_8)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041058", "story_v_side_old_921041.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041058", "story_v_side_old_921041.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = var_244_0 + 0.3
			local var_244_10 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 + 0.3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_9) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_9 + var_244_10 and arg_241_1.time_ < var_244_9 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play921041059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 921041059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play921041060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10125ui_story"]) and arg_247_1.var_.characterEffect10125ui_story == nil then
				arg_247_1.var_.characterEffect10125ui_story = arg_247_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10125ui_story"]) then
				if arg_247_1.var_.characterEffect10125ui_story and not isNil(arg_247_1.actors_["10125ui_story"]) then
					arg_247_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10125ui_story"]) and arg_247_1.var_.characterEffect10125ui_story then
				arg_247_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.425

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(921041059).content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 17 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 17)

				if (17 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 17)) > 0 and var_250_2 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_6 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_6 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_6

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_6 and arg_247_1.time_ < var_250_1 + var_250_6 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play921041060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 921041060
		arg_251_1.duration_ = 7.8

		local var_251_0 = {
			zh = 3.1,
			ja = 7.8
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
				arg_251_0:Play921041061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10125ui_story"]) and arg_251_1.var_.characterEffect10125ui_story == nil then
				arg_251_1.var_.characterEffect10125ui_story = arg_251_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10125ui_story"]) then
				if arg_251_1.var_.characterEffect10125ui_story and not isNil(arg_251_1.actors_["10125ui_story"]) then
					arg_251_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10125ui_story"]) and arg_251_1.var_.characterEffect10125ui_story then
				arg_251_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			local var_254_2 = 0
			local var_254_3 = 0.3

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_4 = arg_251_1:GetWordFromCfg(921041060)
				local var_254_5 = arg_251_1:FormatText(var_254_4.content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 12 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 12)

				if (12 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 12)) > 0 and var_254_3 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041060", "story_v_side_old_921041.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041060", "story_v_side_old_921041.awb") / 1000

					if var_254_8 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_2
					end

					if var_254_4.prefab_name ~= "" and arg_251_1.actors_[var_254_4.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_4.prefab_name].transform, "story_v_side_old_921041", "921041060", "story_v_side_old_921041.awb")

						arg_251_1:RecordAudio("921041060", var_254_9)
						arg_251_1:RecordAudio("921041060", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041060", "story_v_side_old_921041.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041060", "story_v_side_old_921041.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_10 and arg_251_1.time_ < var_254_2 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play921041061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 921041061
		arg_255_1.duration_ = 11.1

		local var_255_0 = {
			zh = 7.265999999999,
			ja = 11.099999999999
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
				arg_255_0:Play921041062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 1 < arg_255_1.time_ and arg_255_1.time_ <= 1 + arg_258_0 then
				local var_258_0 = arg_255_1.bgs_.ST60

				arg_255_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_258_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_1 = var_258_0:GetComponent("SpriteRenderer")

				if var_258_1 and var_258_1.sprite then
					local var_258_2 = 2 * (var_258_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_258_0.transform.localScale = Vector3.New(var_258_2 / var_258_1.sprite.bounds.size.y < var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x and var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x or var_258_2 / var_258_1.sprite.bounds.size.y, var_258_2 / var_258_1.sprite.bounds.size.y < var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x and var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x or var_258_2 / var_258_1.sprite.bounds.size.y, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "ST60" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_3 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.allBtn_.enabled = false
			end

			if arg_255_1.time_ >= var_258_3 + 0.3 and arg_255_1.time_ < var_258_3 + 0.3 + arg_258_0 then
				arg_255_1.allBtn_.enabled = true
			end

			local var_258_4 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_5 = 1

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_5 then
				local var_258_6 = Color.New(0, 0, 0)

				var_258_6.a = Mathf.Lerp(0, 1, (arg_255_1.time_ - var_258_4) / var_258_5)
				arg_255_1.mask_.color = var_258_6
			end

			if arg_255_1.time_ >= var_258_4 + var_258_5 and arg_255_1.time_ < var_258_4 + var_258_5 + arg_258_0 then
				local var_258_7 = Color.New(0, 0, 0)

				var_258_7.a = 1
				arg_255_1.mask_.color = var_258_7
			end

			local var_258_8 = 1

			if 1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_9 = 1.999999999999

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_9 then
				local var_258_10 = Color.New(0, 0, 0)

				var_258_10.a = Mathf.Lerp(1, 0, (arg_255_1.time_ - var_258_8) / var_258_9)
				arg_255_1.mask_.color = var_258_10
			end

			if arg_255_1.time_ >= var_258_8 + var_258_9 and arg_255_1.time_ < var_258_8 + var_258_9 + arg_258_0 then
				local var_258_11 = Color.New(0, 0, 0)

				arg_255_1.mask_.enabled = false
				var_258_11.a = 0
				arg_255_1.mask_.color = var_258_11
			end

			local var_258_12 = arg_255_1.actors_["10125ui_story"].transform

			if 0.966666666666667 < arg_255_1.time_ and arg_255_1.time_ <= 0.966666666666667 + arg_258_0 then
				arg_255_1.var_.moveOldPos10125ui_story = var_258_12.localPosition
			end

			local var_258_13 = 0.001

			if 0.966666666666667 <= arg_255_1.time_ and arg_255_1.time_ < 0.966666666666667 + var_258_13 then
				var_258_12.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10125ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0.966666666666667) / var_258_13)
				var_258_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_12.position).x, (manager.ui.mainCamera.transform.position - var_258_12.position).y, (manager.ui.mainCamera.transform.position - var_258_12.position).z)
				var_258_12.localEulerAngles.z = 0
				var_258_12.localEulerAngles.x = 0
				var_258_12.localEulerAngles = var_258_12.localEulerAngles
			end

			if arg_255_1.time_ >= 0.966666666666667 + var_258_13 and arg_255_1.time_ < 0.966666666666667 + var_258_13 + arg_258_0 then
				var_258_12.localPosition = Vector3.New(0, 100, 0)
				var_258_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_12.position).x, (manager.ui.mainCamera.transform.position - var_258_12.position).y, (manager.ui.mainCamera.transform.position - var_258_12.position).z)
				var_258_12.localEulerAngles.z = 0
				var_258_12.localEulerAngles.x = 0
				var_258_12.localEulerAngles = var_258_12.localEulerAngles
			end

			local var_258_14 = 1

			arg_255_1.isInRecall_ = false

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 then
				arg_255_1.screenFilterGo_:SetActive(true)

				arg_255_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_258_2, iter_258_3 in pairs(arg_255_1.actors_) do
					for iter_258_4, iter_258_5 in ipairs((iter_258_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_258_5.color = iter_258_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_258_15 = 0.0166666666666667

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_15 then
				arg_255_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_255_1.time_ - var_258_14) / var_258_15)
			end

			if arg_255_1.time_ >= var_258_14 + var_258_15 and arg_255_1.time_ < var_258_14 + var_258_15 + arg_258_0 then
				arg_255_1.screenFilterEffect_.weight = 1
			end

			local var_258_16 = "10124ui_story"

			if arg_255_1.actors_["10124ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10124ui_story"))) then
				local var_258_17 = Object.Instantiate(Asset.Load("Char/" .. "10124ui_story"), arg_255_1.stage_.transform)

				var_258_17.name = var_258_16
				var_258_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.actors_[var_258_16] = var_258_17

				local var_258_18 = var_258_17:GetComponentInChildren(typeof(CharacterEffect))

				var_258_18.enabled = true

				local var_258_19 = GameObjectTools.GetOrAddComponent(var_258_17, typeof(DynamicBoneHelper))

				if var_258_19 then
					var_258_19:EnableDynamicBone(false)
				end

				arg_255_1:ShowWeapon(var_258_18.transform, false)

				arg_255_1.var_[var_258_16 .. "Animator"] = var_258_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_255_1.var_[var_258_16 .. "Animator"].applyRootMotion = true
				arg_255_1.var_[var_258_16 .. "LipSync"] = var_258_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_258_20 = arg_255_1.actors_["10124ui_story"].transform

			if 2.83400000184774 < arg_255_1.time_ and arg_255_1.time_ <= 2.83400000184774 + arg_258_0 then
				arg_255_1.var_.moveOldPos10124ui_story = var_258_20.localPosition
			end

			local var_258_21 = 0.001

			if 2.83400000184774 <= arg_255_1.time_ and arg_255_1.time_ < 2.83400000184774 + var_258_21 then
				var_258_20.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_255_1.time_ - 2.83400000184774) / var_258_21)
				var_258_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_20.position).x, (manager.ui.mainCamera.transform.position - var_258_20.position).y, (manager.ui.mainCamera.transform.position - var_258_20.position).z)
				var_258_20.localEulerAngles.z = 0
				var_258_20.localEulerAngles.x = 0
				var_258_20.localEulerAngles = var_258_20.localEulerAngles
			end

			if arg_255_1.time_ >= 2.83400000184774 + var_258_21 and arg_255_1.time_ < 2.83400000184774 + var_258_21 + arg_258_0 then
				var_258_20.localPosition = Vector3.New(0, -0.98, -6.08)
				var_258_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_20.position).x, (manager.ui.mainCamera.transform.position - var_258_20.position).y, (manager.ui.mainCamera.transform.position - var_258_20.position).z)
				var_258_20.localEulerAngles.z = 0
				var_258_20.localEulerAngles.x = 0
				var_258_20.localEulerAngles = var_258_20.localEulerAngles
			end

			local var_258_22 = arg_255_1.actors_["10124ui_story"]

			if 2.83400000184774 < arg_255_1.time_ and arg_255_1.time_ <= 2.83400000184774 + arg_258_0 and not isNil(var_258_22) and arg_255_1.var_.characterEffect10124ui_story == nil then
				arg_255_1.var_.characterEffect10124ui_story = var_258_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_23 = 0.200000002980232

			if 2.83400000184774 <= arg_255_1.time_ and arg_255_1.time_ < 2.83400000184774 + var_258_23 and not isNil(var_258_22) then
				if arg_255_1.var_.characterEffect10124ui_story and not isNil(var_258_22) then
					arg_255_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 2.83400000184774 + var_258_23 and arg_255_1.time_ < 2.83400000184774 + var_258_23 + arg_258_0 and not isNil(var_258_22) and arg_255_1.var_.characterEffect10124ui_story then
				arg_255_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 2.83400000184774 < arg_255_1.time_ and arg_255_1.time_ <= 2.83400000184774 + arg_258_0 then
				arg_255_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action1_1")
			end

			if 2.83400000184774 < arg_255_1.time_ and arg_255_1.time_ <= 2.83400000184774 + arg_258_0 then
				arg_255_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_25 = 2.999999999999
			local var_258_26 = 0.525

			if 2.999999999999 < arg_255_1.time_ and arg_255_1.time_ <= var_258_25 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_27 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_27:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_28 = arg_255_1:GetWordFromCfg(921041061)
				local var_258_29 = arg_255_1:FormatText(var_258_28.content)

				arg_255_1.text_.text = var_258_29

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_31 = 21 <= 0 and var_258_26 or var_258_26 * (utf8.len(var_258_29) / 21)

				if (21 <= 0 and var_258_26 or var_258_26 * (utf8.len(var_258_29) / 21)) > 0 and var_258_26 < var_258_31 then
					arg_255_1.talkMaxDuration = var_258_31
					var_258_25 = var_258_25 + 0.3

					if var_258_31 + var_258_25 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_31 + var_258_25
					end
				end

				arg_255_1.text_.text = var_258_29
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041061", "story_v_side_old_921041.awb") ~= 0 then
					local var_258_32 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041061", "story_v_side_old_921041.awb") / 1000

					if var_258_32 + var_258_25 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_32 + var_258_25
					end

					if var_258_28.prefab_name ~= "" and arg_255_1.actors_[var_258_28.prefab_name] ~= nil then
						local var_258_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_28.prefab_name].transform, "story_v_side_old_921041", "921041061", "story_v_side_old_921041.awb")

						arg_255_1:RecordAudio("921041061", var_258_33)
						arg_255_1:RecordAudio("921041061", var_258_33)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041061", "story_v_side_old_921041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041061", "story_v_side_old_921041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_34 = var_258_25 + 0.3
			local var_258_35 = math.max(var_258_26, arg_255_1.talkMaxDuration)

			if var_258_25 + 0.3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_34 + var_258_35 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_34) / var_258_35

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_34 + var_258_35 and arg_255_1.time_ < var_258_34 + var_258_35 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.83400000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play921041062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 921041062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play921041063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["10124ui_story"]) and arg_261_1.var_.characterEffect10124ui_story == nil then
				arg_261_1.var_.characterEffect10124ui_story = arg_261_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["10124ui_story"]) then
				if arg_261_1.var_.characterEffect10124ui_story and not isNil(arg_261_1.actors_["10124ui_story"]) then
					arg_261_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["10124ui_story"]) and arg_261_1.var_.characterEffect10124ui_story then
				arg_261_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.4

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
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

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(921041062).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 16 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 16)

				if (16 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 16)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play921041063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 921041063
		arg_265_1.duration_ = 5.77

		local var_265_0 = {
			zh = 5.76633333333333,
			ja = 5.36633333333333
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
				arg_265_0:Play921041064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["10125ui_story"]) and arg_265_1.var_.characterEffect10125ui_story == nil then
				arg_265_1.var_.characterEffect10125ui_story = arg_265_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["10125ui_story"]) then
				if arg_265_1.var_.characterEffect10125ui_story and not isNil(arg_265_1.actors_["10125ui_story"]) then
					arg_265_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["10125ui_story"]) and arg_265_1.var_.characterEffect10125ui_story then
				arg_265_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			local var_268_2 = "X203K"

			if arg_265_1.bgs_.X203K == nil then
				local var_268_3 = Object.Instantiate(arg_265_1.paintGo_)

				var_268_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_268_2)
				var_268_3.name = var_268_2
				var_268_3.transform.parent = arg_265_1.stage_.transform
				var_268_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.bgs_[var_268_2] = var_268_3
			end

			if 1 < arg_265_1.time_ and arg_265_1.time_ <= 1 + arg_268_0 then
				local var_268_4 = arg_265_1.bgs_.X203K

				arg_265_1.bgs_.X203K.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_5 = var_268_4:GetComponent("SpriteRenderer")

				if var_268_5 and var_268_5.sprite then
					local var_268_6 = 2 * (var_268_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_4.transform.localScale = Vector3.New(var_268_6 / var_268_5.sprite.bounds.size.y < var_268_6 * manager.ui.mainCameraCom_.aspect / var_268_5.sprite.bounds.size.x and var_268_6 * manager.ui.mainCameraCom_.aspect / var_268_5.sprite.bounds.size.x or var_268_6 / var_268_5.sprite.bounds.size.y, var_268_6 / var_268_5.sprite.bounds.size.y < var_268_6 * manager.ui.mainCameraCom_.aspect / var_268_5.sprite.bounds.size.x and var_268_6 * manager.ui.mainCameraCom_.aspect / var_268_5.sprite.bounds.size.x or var_268_6 / var_268_5.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "X203K" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_7 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_7 + 0.3 and arg_265_1.time_ < var_268_7 + 0.3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_8 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_9 = 1

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 then
				local var_268_10 = Color.New(0, 0, 0)

				var_268_10.a = Mathf.Lerp(0, 1, (arg_265_1.time_ - var_268_8) / var_268_9)
				arg_265_1.mask_.color = var_268_10
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 then
				local var_268_11 = Color.New(0, 0, 0)

				var_268_11.a = 1
				arg_265_1.mask_.color = var_268_11
			end

			local var_268_12 = 1

			if 1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_13 = 1.03333333333333

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_13 then
				local var_268_14 = Color.New(0, 0, 0)

				var_268_14.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_12) / var_268_13)
				arg_265_1.mask_.color = var_268_14
			end

			if arg_265_1.time_ >= var_268_12 + var_268_13 and arg_265_1.time_ < var_268_12 + var_268_13 + arg_268_0 then
				local var_268_15 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_15.a = 0
				arg_265_1.mask_.color = var_268_15
			end

			local var_268_16 = arg_265_1.actors_["10124ui_story"].transform

			if 1 < arg_265_1.time_ and arg_265_1.time_ <= 1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10124ui_story = var_268_16.localPosition
			end

			local var_268_17 = 0.001

			if 1 <= arg_265_1.time_ and arg_265_1.time_ < 1 + var_268_17 then
				var_268_16.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10124ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 1) / var_268_17)
				var_268_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_16.position).x, (manager.ui.mainCamera.transform.position - var_268_16.position).y, (manager.ui.mainCamera.transform.position - var_268_16.position).z)
				var_268_16.localEulerAngles.z = 0
				var_268_16.localEulerAngles.x = 0
				var_268_16.localEulerAngles = var_268_16.localEulerAngles
			end

			if arg_265_1.time_ >= 1 + var_268_17 and arg_265_1.time_ < 1 + var_268_17 + arg_268_0 then
				var_268_16.localPosition = Vector3.New(0, 100, 0)
				var_268_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_16.position).x, (manager.ui.mainCamera.transform.position - var_268_16.position).y, (manager.ui.mainCamera.transform.position - var_268_16.position).z)
				var_268_16.localEulerAngles.z = 0
				var_268_16.localEulerAngles.x = 0
				var_268_16.localEulerAngles = var_268_16.localEulerAngles
			end

			local var_268_18 = arg_265_1.actors_["10125ui_story"].transform

			if 1.9 < arg_265_1.time_ and arg_265_1.time_ <= 1.9 + arg_268_0 then
				arg_265_1.var_.moveOldPos10125ui_story = var_268_18.localPosition
			end

			local var_268_19 = 0.001

			if 1.9 <= arg_265_1.time_ and arg_265_1.time_ < 1.9 + var_268_19 then
				var_268_18.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10125ui_story, Vector3.New(0, -0.98, -6.1), (arg_265_1.time_ - 1.9) / var_268_19)
				var_268_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_18.position).x, (manager.ui.mainCamera.transform.position - var_268_18.position).y, (manager.ui.mainCamera.transform.position - var_268_18.position).z)
				var_268_18.localEulerAngles.z = 0
				var_268_18.localEulerAngles.x = 0
				var_268_18.localEulerAngles = var_268_18.localEulerAngles
			end

			if arg_265_1.time_ >= 1.9 + var_268_19 and arg_265_1.time_ < 1.9 + var_268_19 + arg_268_0 then
				var_268_18.localPosition = Vector3.New(0, -0.98, -6.1)
				var_268_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_18.position).x, (manager.ui.mainCamera.transform.position - var_268_18.position).y, (manager.ui.mainCamera.transform.position - var_268_18.position).z)
				var_268_18.localEulerAngles.z = 0
				var_268_18.localEulerAngles.x = 0
				var_268_18.localEulerAngles = var_268_18.localEulerAngles
			end

			local var_268_20 = arg_265_1.actors_["10125ui_story"]

			if 1.9 < arg_265_1.time_ and arg_265_1.time_ <= 1.9 + arg_268_0 and not isNil(var_268_20) and arg_265_1.var_.characterEffect10125ui_story == nil then
				arg_265_1.var_.characterEffect10125ui_story = var_268_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_21 = 0.200000002980232

			if 1.9 <= arg_265_1.time_ and arg_265_1.time_ < 1.9 + var_268_21 and not isNil(var_268_20) then
				if arg_265_1.var_.characterEffect10125ui_story and not isNil(var_268_20) then
					arg_265_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 1.9 + var_268_21 and arg_265_1.time_ < 1.9 + var_268_21 + arg_268_0 and not isNil(var_268_20) and arg_265_1.var_.characterEffect10125ui_story then
				arg_265_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 1.9 < arg_265_1.time_ and arg_265_1.time_ <= 1.9 + arg_268_0 then
				arg_265_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action2_1")
			end

			if 1.9 < arg_265_1.time_ and arg_265_1.time_ <= 1.9 + arg_268_0 then
				arg_265_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_23 = 2.03333333333333
			local var_268_24 = 0.325

			if 2.03333333333333 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_25 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_25:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:GetWordFromCfg(921041063)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_29 = 13 <= 0 and var_268_24 or var_268_24 * (utf8.len(var_268_27) / 13)

				if (13 <= 0 and var_268_24 or var_268_24 * (utf8.len(var_268_27) / 13)) > 0 and var_268_24 < var_268_29 then
					arg_265_1.talkMaxDuration = var_268_29
					var_268_23 = var_268_23 + 0.3

					if var_268_29 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_29 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_27
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041063", "story_v_side_old_921041.awb") ~= 0 then
					local var_268_30 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041063", "story_v_side_old_921041.awb") / 1000

					if var_268_30 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_side_old_921041", "921041063", "story_v_side_old_921041.awb")

						arg_265_1:RecordAudio("921041063", var_268_31)
						arg_265_1:RecordAudio("921041063", var_268_31)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041063", "story_v_side_old_921041.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041063", "story_v_side_old_921041.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_32 = var_268_23 + 0.3
			local var_268_33 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_32 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_32) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_32 + var_268_33 and arg_265_1.time_ < var_268_32 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play921041064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 921041064
		arg_271_1.duration_ = 7.73

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play921041065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 1.26666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 1.26666666666667 + arg_274_0 then
				arg_271_1.var_.moveOldPos10125ui_story = arg_271_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 1.26666666666667 <= arg_271_1.time_ and arg_271_1.time_ < 1.26666666666667 + var_274_0 then
				arg_271_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10125ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 1.26666666666667) / var_274_0)
				arg_271_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10125ui_story"].transform.position).z)
				arg_271_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["10125ui_story"].transform.localEulerAngles = arg_271_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 1.26666666666667 + var_274_0 and arg_271_1.time_ < 1.26666666666667 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["10125ui_story"].transform.position).z)
				arg_271_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["10125ui_story"].transform.localEulerAngles = arg_271_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_274_1 = 1.26666666666667

			arg_271_1.isInRecall_ = false

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.screenFilterGo_:SetActive(false)

				for iter_274_0, iter_274_1 in pairs(arg_271_1.actors_) do
					for iter_274_2, iter_274_3 in ipairs((iter_274_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_274_3.color = iter_274_3.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_274_2 = 0.0166666666666667

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 then
				arg_271_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_1) / var_274_2)
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 then
				arg_271_1.screenFilterEffect_.weight = 0
			end

			local var_274_3 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_3 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_4 = 1.26666666666667

			if var_274_3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_3 + var_274_4 then
				local var_274_5 = Color.New(0, 0, 0)

				var_274_5.a = Mathf.Lerp(0, 1, (arg_271_1.time_ - var_274_3) / var_274_4)
				arg_271_1.mask_.color = var_274_5
			end

			if arg_271_1.time_ >= var_274_3 + var_274_4 and arg_271_1.time_ < var_274_3 + var_274_4 + arg_274_0 then
				local var_274_6 = Color.New(0, 0, 0)

				var_274_6.a = 1
				arg_271_1.mask_.color = var_274_6
			end

			local var_274_7 = 1.26666666666667

			if 1.26666666666667 < arg_271_1.time_ and arg_271_1.time_ <= var_274_7 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_8 = 1.63333333333333

			if var_274_7 <= arg_271_1.time_ and arg_271_1.time_ < var_274_7 + var_274_8 then
				local var_274_9 = Color.New(0, 0, 0)

				var_274_9.a = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_7) / var_274_8)
				arg_271_1.mask_.color = var_274_9
			end

			if arg_271_1.time_ >= var_274_7 + var_274_8 and arg_271_1.time_ < var_274_7 + var_274_8 + arg_274_0 then
				local var_274_10 = Color.New(0, 0, 0)

				arg_271_1.mask_.enabled = false
				var_274_10.a = 0
				arg_271_1.mask_.color = var_274_10
			end

			if 1.26666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 1.26666666666667 + arg_274_0 then
				local var_274_11 = arg_271_1.bgs_.ST60

				arg_271_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_274_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_12 = var_274_11:GetComponent("SpriteRenderer")

				if var_274_12 and var_274_12.sprite then
					local var_274_13 = 2 * (var_274_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_274_11.transform.localScale = Vector3.New(var_274_13 / var_274_12.sprite.bounds.size.y < var_274_13 * manager.ui.mainCameraCom_.aspect / var_274_12.sprite.bounds.size.x and var_274_13 * manager.ui.mainCameraCom_.aspect / var_274_12.sprite.bounds.size.x or var_274_13 / var_274_12.sprite.bounds.size.y, var_274_13 / var_274_12.sprite.bounds.size.y < var_274_13 * manager.ui.mainCameraCom_.aspect / var_274_12.sprite.bounds.size.x and var_274_13 * manager.ui.mainCameraCom_.aspect / var_274_12.sprite.bounds.size.x or var_274_13 / var_274_12.sprite.bounds.size.y, 0)
				end

				for iter_274_4, iter_274_5 in pairs(arg_271_1.bgs_) do
					if iter_274_4 ~= "ST60" then
						iter_274_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_14 = 2.73333333333333
			local var_274_15 = 0.675

			if 2.73333333333333 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_16 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_16:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_17 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(921041064).content)

				arg_271_1.text_.text = var_274_17

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_19 = 36 <= 0 and var_274_15 or var_274_15 * (utf8.len(var_274_17) / 36)

				if (36 <= 0 and var_274_15 or var_274_15 * (utf8.len(var_274_17) / 36)) > 0 and var_274_15 < var_274_19 then
					arg_271_1.talkMaxDuration = var_274_19
					var_274_14 = var_274_14 + 0.3

					if var_274_19 + var_274_14 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_19 + var_274_14
					end
				end

				arg_271_1.text_.text = var_274_17
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_20 = var_274_14 + 0.3
			local var_274_21 = math.max(var_274_15, arg_271_1.talkMaxDuration)

			if var_274_14 + 0.3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_20 + var_274_21 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_20) / var_274_21

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_20 + var_274_21 and arg_271_1.time_ < var_274_20 + var_274_21 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.26666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play921041065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 921041065
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play921041066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.675

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

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(921041065).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 27 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 27)

				if (27 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 27)) > 0 and var_280_0 < var_280_3 then
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
	Play921041066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 921041066
		arg_281_1.duration_ = 4.27

		local var_281_0 = {
			zh = 3.666,
			ja = 4.266
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
				arg_281_0:Play921041067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10125ui_story = arg_281_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10125ui_story, Vector3.New(0, -0.98, -6.1), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10125ui_story"].transform.position).z)
				arg_281_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10125ui_story"].transform.localEulerAngles = arg_281_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_281_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10125ui_story"].transform.position).z)
				arg_281_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10125ui_story"].transform.localEulerAngles = arg_281_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["10125ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect10125ui_story == nil then
				arg_281_1.var_.characterEffect10125ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect10125ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect10125ui_story then
				arg_281_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action4_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_284_4 = 0
			local var_284_5 = 0.425

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(921041066)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_9 = 17 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 17)

				if (17 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_7) / 17)) > 0 and var_284_5 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041066", "story_v_side_old_921041.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041066", "story_v_side_old_921041.awb") / 1000

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end

					if var_284_6.prefab_name ~= "" and arg_281_1.actors_[var_284_6.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_6.prefab_name].transform, "story_v_side_old_921041", "921041066", "story_v_side_old_921041.awb")

						arg_281_1:RecordAudio("921041066", var_284_11)
						arg_281_1:RecordAudio("921041066", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041066", "story_v_side_old_921041.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041066", "story_v_side_old_921041.awb")
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
				actorName = "10125ui_story",
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
	Play921041067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 921041067
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play921041068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10125ui_story"]) and arg_285_1.var_.characterEffect10125ui_story == nil then
				arg_285_1.var_.characterEffect10125ui_story = arg_285_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10125ui_story"]) then
				if arg_285_1.var_.characterEffect10125ui_story and not isNil(arg_285_1.actors_["10125ui_story"]) then
					arg_285_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10125ui_story"]) and arg_285_1.var_.characterEffect10125ui_story then
				arg_285_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.35

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(921041067).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 14 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 14)

				if (14 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 14)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play921041068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 921041068
		arg_289_1.duration_ = 6.43

		local var_289_0 = {
			zh = 4.2,
			ja = 6.433
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
				arg_289_0:Play921041069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10125ui_story"]) and arg_289_1.var_.characterEffect10125ui_story == nil then
				arg_289_1.var_.characterEffect10125ui_story = arg_289_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10125ui_story"]) then
				if arg_289_1.var_.characterEffect10125ui_story and not isNil(arg_289_1.actors_["10125ui_story"]) then
					arg_289_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10125ui_story"]) and arg_289_1.var_.characterEffect10125ui_story then
				arg_289_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_292_2 = 0
			local var_292_3 = 0.475

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(921041068)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 19 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 19)

				if (19 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 19)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041068", "story_v_side_old_921041.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041068", "story_v_side_old_921041.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_side_old_921041", "921041068", "story_v_side_old_921041.awb")

						arg_289_1:RecordAudio("921041068", var_292_9)
						arg_289_1:RecordAudio("921041068", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041068", "story_v_side_old_921041.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041068", "story_v_side_old_921041.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play921041069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 921041069
		arg_293_1.duration_ = 7.63

		local var_293_0 = {
			zh = 6.733,
			ja = 7.633
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
				arg_293_0:Play921041070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action4_2")
			end

			local var_296_0 = 0
			local var_296_1 = 0.625

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(921041069)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 25 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 25)

				if (25 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 25)) > 0 and var_296_1 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041069", "story_v_side_old_921041.awb") ~= 0 then
					local var_296_6 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041069", "story_v_side_old_921041.awb") / 1000

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end

					if var_296_2.prefab_name ~= "" and arg_293_1.actors_[var_296_2.prefab_name] ~= nil then
						local var_296_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_2.prefab_name].transform, "story_v_side_old_921041", "921041069", "story_v_side_old_921041.awb")

						arg_293_1:RecordAudio("921041069", var_296_7)
						arg_293_1:RecordAudio("921041069", var_296_7)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041069", "story_v_side_old_921041.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041069", "story_v_side_old_921041.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play921041070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 921041070
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play921041071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10125ui_story"]) and arg_297_1.var_.characterEffect10125ui_story == nil then
				arg_297_1.var_.characterEffect10125ui_story = arg_297_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10125ui_story"]) then
				if arg_297_1.var_.characterEffect10125ui_story and not isNil(arg_297_1.actors_["10125ui_story"]) then
					arg_297_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10125ui_story"]) and arg_297_1.var_.characterEffect10125ui_story then
				arg_297_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.25

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

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(921041070).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 10 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 10)

				if (10 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 10)) > 0 and var_300_2 < var_300_5 then
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
	Play921041071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 921041071
		arg_301_1.duration_ = 8.27

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play921041072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if arg_301_1.bgs_.X203F == nil then
				local var_304_0 = Object.Instantiate(arg_301_1.paintGo_)

				var_304_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X203F")
				var_304_0.name = "X203F"
				var_304_0.transform.parent = arg_301_1.stage_.transform
				var_304_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_301_1.bgs_.X203F = var_304_0
			end

			if 1.36666666666667 < arg_301_1.time_ and arg_301_1.time_ <= 1.36666666666667 + arg_304_0 then
				local var_304_1 = arg_301_1.bgs_.X203F

				arg_301_1.bgs_.X203F.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_304_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_304_2 = var_304_1:GetComponent("SpriteRenderer")

				if var_304_2 and var_304_2.sprite then
					local var_304_3 = 2 * (var_304_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_304_1.transform.localScale = Vector3.New(var_304_3 / var_304_2.sprite.bounds.size.y < var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x and var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x or var_304_3 / var_304_2.sprite.bounds.size.y, var_304_3 / var_304_2.sprite.bounds.size.y < var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x and var_304_3 * manager.ui.mainCameraCom_.aspect / var_304_2.sprite.bounds.size.x or var_304_3 / var_304_2.sprite.bounds.size.y, 0)
				end

				for iter_304_0, iter_304_1 in pairs(arg_301_1.bgs_) do
					if iter_304_0 ~= "X203F" then
						iter_304_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_304_4 = 0

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_5 = 1.36666666666667

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_5 then
				local var_304_6 = Color.New(0, 0, 0)

				var_304_6.a = Mathf.Lerp(0, 1, (arg_301_1.time_ - var_304_4) / var_304_5)
				arg_301_1.mask_.color = var_304_6
			end

			if arg_301_1.time_ >= var_304_4 + var_304_5 and arg_301_1.time_ < var_304_4 + var_304_5 + arg_304_0 then
				local var_304_7 = Color.New(0, 0, 0)

				var_304_7.a = 1
				arg_301_1.mask_.color = var_304_7
			end

			local var_304_8 = 1.36666666666667

			if 1.36666666666667 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 then
				arg_301_1.mask_.enabled = true
				arg_301_1.mask_.raycastTarget = true

				arg_301_1:SetGaussion(false)
			end

			local var_304_9 = 2

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 then
				local var_304_10 = Color.New(0, 0, 0)

				var_304_10.a = Mathf.Lerp(1, 0, (arg_301_1.time_ - var_304_8) / var_304_9)
				arg_301_1.mask_.color = var_304_10
			end

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 then
				local var_304_11 = Color.New(0, 0, 0)

				arg_301_1.mask_.enabled = false
				var_304_11.a = 0
				arg_301_1.mask_.color = var_304_11
			end

			local var_304_12 = arg_301_1.actors_["10125ui_story"].transform

			if 1.35066666851441 < arg_301_1.time_ and arg_301_1.time_ <= 1.35066666851441 + arg_304_0 then
				arg_301_1.var_.moveOldPos10125ui_story = var_304_12.localPosition
			end

			local var_304_13 = 0.001

			if 1.35066666851441 <= arg_301_1.time_ and arg_301_1.time_ < 1.35066666851441 + var_304_13 then
				var_304_12.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10125ui_story, Vector3.New(0, 100, 0), (arg_301_1.time_ - 1.35066666851441) / var_304_13)
				var_304_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_12.position).x, (manager.ui.mainCamera.transform.position - var_304_12.position).y, (manager.ui.mainCamera.transform.position - var_304_12.position).z)
				var_304_12.localEulerAngles.z = 0
				var_304_12.localEulerAngles.x = 0
				var_304_12.localEulerAngles = var_304_12.localEulerAngles
			end

			if arg_301_1.time_ >= 1.35066666851441 + var_304_13 and arg_301_1.time_ < 1.35066666851441 + var_304_13 + arg_304_0 then
				var_304_12.localPosition = Vector3.New(0, 100, 0)
				var_304_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_12.position).x, (manager.ui.mainCamera.transform.position - var_304_12.position).y, (manager.ui.mainCamera.transform.position - var_304_12.position).z)
				var_304_12.localEulerAngles.z = 0
				var_304_12.localEulerAngles.x = 0
				var_304_12.localEulerAngles = var_304_12.localEulerAngles
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_304_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_301_1.bgmTxt_.text ~= var_304_16 and arg_301_1.bgmTxt_.text ~= "" then
						if arg_301_1.bgmTxt2_.text ~= "" then
							arg_301_1.bgmTxt_.text = arg_301_1.bgmTxt2_.text
						end

						arg_301_1.bgmTxt2_.text = var_304_16

						arg_301_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_301_1.bgmTxt_.text = var_304_16
						arg_301_1.bgmTxt2_.text = var_304_16
					end

					if arg_301_1.bgmTimer then
						arg_301_1.bgmTimer:Stop()

						arg_301_1.bgmTimer = nil
					end

					if arg_301_1.settingData.show_music_name == 1 then
						arg_301_1.musicController:SetSelectedState("show")
						arg_301_1.musicAnimator_:Play("open", 0, 0)

						if arg_301_1.settingData.music_time ~= 0 then
							arg_301_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_301_1.settingData.music_time), function()
								if arg_301_1 == nil or isNil(arg_301_1.bgmTxt_) then
									return
								end

								arg_301_1.musicController:SetSelectedState("hide")
								arg_301_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.13333333333333 < arg_301_1.time_ and arg_301_1.time_ <= 1.13333333333333 + arg_304_0 then
				arg_301_1:AudioAction("play", "music", "bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night.awb")

				local var_304_19 = manager.audio:GetAudioName("bgm_activity_3_7_scene_109502_night", "bgm_activity_3_7_scene_109502_night")

				if "" ~= "" then
					if arg_301_1.bgmTxt_.text ~= var_304_19 and arg_301_1.bgmTxt_.text ~= "" then
						if arg_301_1.bgmTxt2_.text ~= "" then
							arg_301_1.bgmTxt_.text = arg_301_1.bgmTxt2_.text
						end

						arg_301_1.bgmTxt2_.text = var_304_19

						arg_301_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_301_1.bgmTxt_.text = var_304_19
						arg_301_1.bgmTxt2_.text = var_304_19
					end

					if arg_301_1.bgmTimer then
						arg_301_1.bgmTimer:Stop()

						arg_301_1.bgmTimer = nil
					end

					if arg_301_1.settingData.show_music_name == 1 then
						arg_301_1.musicController:SetSelectedState("show")
						arg_301_1.musicAnimator_:Play("open", 0, 0)

						if arg_301_1.settingData.music_time ~= 0 then
							arg_301_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_301_1.settingData.music_time), function()
								if arg_301_1 == nil or isNil(arg_301_1.bgmTxt_) then
									return
								end

								arg_301_1.musicController:SetSelectedState("hide")
								arg_301_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_301_1.frameCnt_ <= 1 then
				arg_301_1.dialog_:SetActive(false)
			end

			local var_304_20 = 3.26666666666667
			local var_304_21 = 0.55

			if 3.26666666666667 < arg_301_1.time_ and arg_301_1.time_ <= var_304_20 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0

				arg_301_1.dialog_:SetActive(true)

				arg_301_1.dialogCg_.alpha = 0

				local var_304_22 = LeanTween.value(arg_301_1.dialog_, 0, 1, 0.3)

				var_304_22:setOnUpdate(LuaHelper.FloatAction(function(arg_307_0)
					arg_301_1.dialogCg_.alpha = arg_307_0
				end))
				var_304_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_301_1.dialog_)
					var_304_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_301_1.duration_ = arg_301_1.duration_ + 0.3

				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_23 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(921041071).content)

				arg_301_1.text_.text = var_304_23

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_25 = 22 <= 0 and var_304_21 or var_304_21 * (utf8.len(var_304_23) / 22)

				if (22 <= 0 and var_304_21 or var_304_21 * (utf8.len(var_304_23) / 22)) > 0 and var_304_21 < var_304_25 then
					arg_301_1.talkMaxDuration = var_304_25
					var_304_20 = var_304_20 + 0.3

					if var_304_25 + var_304_20 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_25 + var_304_20
					end
				end

				arg_301_1.text_.text = var_304_23
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_26 = var_304_20 + 0.3
			local var_304_27 = math.max(var_304_21, arg_301_1.talkMaxDuration)

			if var_304_20 + 0.3 <= arg_301_1.time_ and arg_301_1.time_ < var_304_26 + var_304_27 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_26) / var_304_27

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_26 + var_304_27 and arg_301_1.time_ < var_304_26 + var_304_27 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.35066666851441,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play921041072 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 921041072
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play921041073(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.9

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

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(921041072).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 36 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 36)

				if (36 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 36)) > 0 and var_312_0 < var_312_3 then
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
	Play921041073 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 921041073
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play921041074(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.7

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(921041073).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 28 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 28)

				if (28 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 28)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play921041074 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 921041074
		arg_317_1.duration_ = 2

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play921041075(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10125ui_story = arg_317_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10125ui_story, Vector3.New(0, -0.98, -6.1), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10125ui_story"].transform.position).z)
				arg_317_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["10125ui_story"].transform.localEulerAngles = arg_317_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_317_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10125ui_story"].transform.position).z)
				arg_317_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["10125ui_story"].transform.localEulerAngles = arg_317_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["10125ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect10125ui_story == nil then
				arg_317_1.var_.characterEffect10125ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect10125ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect10125ui_story then
				arg_317_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action1_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_320_4 = 0
			local var_320_5 = 0.075

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(921041074)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 3 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 3)

				if (3 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 3)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041074", "story_v_side_old_921041.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041074", "story_v_side_old_921041.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_side_old_921041", "921041074", "story_v_side_old_921041.awb")

						arg_317_1:RecordAudio("921041074", var_320_11)
						arg_317_1:RecordAudio("921041074", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041074", "story_v_side_old_921041.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041074", "story_v_side_old_921041.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
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
	Play921041075 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 921041075
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play921041076(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10125ui_story"]) and arg_321_1.var_.characterEffect10125ui_story == nil then
				arg_321_1.var_.characterEffect10125ui_story = arg_321_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10125ui_story"]) then
				if arg_321_1.var_.characterEffect10125ui_story and not isNil(arg_321_1.actors_["10125ui_story"]) then
					arg_321_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_321_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10125ui_story"]) and arg_321_1.var_.characterEffect10125ui_story then
				arg_321_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_321_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 0.2

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(921041075).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 8 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 8)

				if (8 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 8)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play921041076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 921041076
		arg_325_1.duration_ = 4.6

		local var_325_0 = {
			zh = 2.6,
			ja = 4.6
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
				arg_325_0:Play921041077(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10125ui_story"]) and arg_325_1.var_.characterEffect10125ui_story == nil then
				arg_325_1.var_.characterEffect10125ui_story = arg_325_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10125ui_story"]) then
				if arg_325_1.var_.characterEffect10125ui_story and not isNil(arg_325_1.actors_["10125ui_story"]) then
					arg_325_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10125ui_story"]) and arg_325_1.var_.characterEffect10125ui_story then
				arg_325_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			local var_328_2 = 0
			local var_328_3 = 0.375

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(921041076)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 15 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 15)

				if (15 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 15)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041076", "story_v_side_old_921041.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041076", "story_v_side_old_921041.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_side_old_921041", "921041076", "story_v_side_old_921041.awb")

						arg_325_1:RecordAudio("921041076", var_328_9)
						arg_325_1:RecordAudio("921041076", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041076", "story_v_side_old_921041.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041076", "story_v_side_old_921041.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_10 and arg_325_1.time_ < var_328_2 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play921041077 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 921041077
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play921041078(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["10125ui_story"]) and arg_329_1.var_.characterEffect10125ui_story == nil then
				arg_329_1.var_.characterEffect10125ui_story = arg_329_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["10125ui_story"]) then
				if arg_329_1.var_.characterEffect10125ui_story and not isNil(arg_329_1.actors_["10125ui_story"]) then
					arg_329_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10125ui_story"]) and arg_329_1.var_.characterEffect10125ui_story then
				arg_329_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 0.25

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(921041077).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 10 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 10)

				if (10 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 10)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play921041078 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 921041078
		arg_333_1.duration_ = 3.57

		local var_333_0 = {
			zh = 1.999999999999,
			ja = 3.566
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
				arg_333_0:Play921041079(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["10125ui_story"]) and arg_333_1.var_.characterEffect10125ui_story == nil then
				arg_333_1.var_.characterEffect10125ui_story = arg_333_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["10125ui_story"]) then
				if arg_333_1.var_.characterEffect10125ui_story and not isNil(arg_333_1.actors_["10125ui_story"]) then
					arg_333_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["10125ui_story"]) and arg_333_1.var_.characterEffect10125ui_story then
				arg_333_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action7_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_336_2 = 0
			local var_336_3 = 0.175

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_4 = arg_333_1:GetWordFromCfg(921041078)
				local var_336_5 = arg_333_1:FormatText(var_336_4.content)

				arg_333_1.text_.text = var_336_5

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 7 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 7)

				if (7 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 7)) > 0 and var_336_3 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_5
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041078", "story_v_side_old_921041.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041078", "story_v_side_old_921041.awb") / 1000

					if var_336_8 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_2
					end

					if var_336_4.prefab_name ~= "" and arg_333_1.actors_[var_336_4.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_4.prefab_name].transform, "story_v_side_old_921041", "921041078", "story_v_side_old_921041.awb")

						arg_333_1:RecordAudio("921041078", var_336_9)
						arg_333_1:RecordAudio("921041078", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041078", "story_v_side_old_921041.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041078", "story_v_side_old_921041.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_10 and arg_333_1.time_ < var_336_2 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play921041079 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 921041079
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play921041080(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["10125ui_story"]) and arg_337_1.var_.characterEffect10125ui_story == nil then
				arg_337_1.var_.characterEffect10125ui_story = arg_337_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["10125ui_story"]) then
				if arg_337_1.var_.characterEffect10125ui_story and not isNil(arg_337_1.actors_["10125ui_story"]) then
					arg_337_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_337_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["10125ui_story"]) and arg_337_1.var_.characterEffect10125ui_story then
				arg_337_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_337_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.575

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(921041079).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 23 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 23)

				if (23 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 23)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play921041080 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 921041080
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play921041081(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 1.05

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(921041080).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 42 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 42)

				if (42 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 42)) > 0 and var_344_0 < var_344_3 then
					arg_341_1.talkMaxDuration = var_344_3

					if var_344_3 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_3 + 0
					end
				end

				arg_341_1.text_.text = var_344_1
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_4 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_4

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play921041081 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 921041081
		arg_345_1.duration_ = 4.93

		local var_345_0 = {
			zh = 4.033,
			ja = 4.933
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
				arg_345_0:Play921041082(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["10125ui_story"]) and arg_345_1.var_.characterEffect10125ui_story == nil then
				arg_345_1.var_.characterEffect10125ui_story = arg_345_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["10125ui_story"]) then
				if arg_345_1.var_.characterEffect10125ui_story and not isNil(arg_345_1.actors_["10125ui_story"]) then
					arg_345_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["10125ui_story"]) and arg_345_1.var_.characterEffect10125ui_story then
				arg_345_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502actionlink/109502action472")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_348_2 = 0
			local var_348_3 = 0.4

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:GetWordFromCfg(921041081)
				local var_348_5 = arg_345_1:FormatText(var_348_4.content)

				arg_345_1.text_.text = var_348_5

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_7 = 16 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_5) / 16)

				if (16 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_5) / 16)) > 0 and var_348_3 < var_348_7 then
					arg_345_1.talkMaxDuration = var_348_7

					if var_348_7 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_7 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_5
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041081", "story_v_side_old_921041.awb") ~= 0 then
					local var_348_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041081", "story_v_side_old_921041.awb") / 1000

					if var_348_8 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_8 + var_348_2
					end

					if var_348_4.prefab_name ~= "" and arg_345_1.actors_[var_348_4.prefab_name] ~= nil then
						local var_348_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_4.prefab_name].transform, "story_v_side_old_921041", "921041081", "story_v_side_old_921041.awb")

						arg_345_1:RecordAudio("921041081", var_348_9)
						arg_345_1:RecordAudio("921041081", var_348_9)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041081", "story_v_side_old_921041.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041081", "story_v_side_old_921041.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_10 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_10 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_10

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_10 and arg_345_1.time_ < var_348_2 + var_348_10 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play921041082 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 921041082
		arg_349_1.duration_ = 7.77

		local var_349_0 = {
			zh = 4.1,
			ja = 7.766
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play921041083(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.5

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:GetWordFromCfg(921041082)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 20 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 20)

				if (20 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 20)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041082", "story_v_side_old_921041.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041082", "story_v_side_old_921041.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_side_old_921041", "921041082", "story_v_side_old_921041.awb")

						arg_349_1:RecordAudio("921041082", var_352_6)
						arg_349_1:RecordAudio("921041082", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041082", "story_v_side_old_921041.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041082", "story_v_side_old_921041.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play921041083 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 921041083
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play921041084(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["10125ui_story"]) and arg_353_1.var_.characterEffect10125ui_story == nil then
				arg_353_1.var_.characterEffect10125ui_story = arg_353_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["10125ui_story"]) then
				if arg_353_1.var_.characterEffect10125ui_story and not isNil(arg_353_1.actors_["10125ui_story"]) then
					arg_353_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_353_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["10125ui_story"]) and arg_353_1.var_.characterEffect10125ui_story then
				arg_353_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_353_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 0.725

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(921041083).content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 29 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 29)

				if (29 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 29)) > 0 and var_356_2 < var_356_5 then
					arg_353_1.talkMaxDuration = var_356_5

					if var_356_5 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + var_356_1
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_6 = math.max(var_356_2, arg_353_1.talkMaxDuration)

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_6 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_1) / var_356_6

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_1 + var_356_6 and arg_353_1.time_ < var_356_1 + var_356_6 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play921041084 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 921041084
		arg_357_1.duration_ = 4.2

		local var_357_0 = {
			zh = 3.033,
			ja = 4.2
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
				arg_357_0:Play921041085(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["10125ui_story"]) and arg_357_1.var_.characterEffect10125ui_story == nil then
				arg_357_1.var_.characterEffect10125ui_story = arg_357_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["10125ui_story"]) then
				if arg_357_1.var_.characterEffect10125ui_story and not isNil(arg_357_1.actors_["10125ui_story"]) then
					arg_357_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["10125ui_story"]) and arg_357_1.var_.characterEffect10125ui_story then
				arg_357_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			local var_360_2 = 0
			local var_360_3 = 0.375

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:GetWordFromCfg(921041084)
				local var_360_5 = arg_357_1:FormatText(var_360_4.content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 13 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 13)

				if (13 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 13)) > 0 and var_360_3 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041084", "story_v_side_old_921041.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041084", "story_v_side_old_921041.awb") / 1000

					if var_360_8 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_2
					end

					if var_360_4.prefab_name ~= "" and arg_357_1.actors_[var_360_4.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_4.prefab_name].transform, "story_v_side_old_921041", "921041084", "story_v_side_old_921041.awb")

						arg_357_1:RecordAudio("921041084", var_360_9)
						arg_357_1:RecordAudio("921041084", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041084", "story_v_side_old_921041.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041084", "story_v_side_old_921041.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_10 and arg_357_1.time_ < var_360_2 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play921041085 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 921041085
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play921041086(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["10125ui_story"]) and arg_361_1.var_.characterEffect10125ui_story == nil then
				arg_361_1.var_.characterEffect10125ui_story = arg_361_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["10125ui_story"]) then
				if arg_361_1.var_.characterEffect10125ui_story and not isNil(arg_361_1.actors_["10125ui_story"]) then
					arg_361_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_361_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["10125ui_story"]) and arg_361_1.var_.characterEffect10125ui_story then
				arg_361_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_361_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.525

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(921041085).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 21 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 21)

				if (21 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 21)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play921041086 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 921041086
		arg_365_1.duration_ = 4.27

		local var_365_0 = {
			zh = 2.366,
			ja = 4.266
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play921041087(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["10125ui_story"]) and arg_365_1.var_.characterEffect10125ui_story == nil then
				arg_365_1.var_.characterEffect10125ui_story = arg_365_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["10125ui_story"]) then
				if arg_365_1.var_.characterEffect10125ui_story and not isNil(arg_365_1.actors_["10125ui_story"]) then
					arg_365_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["10125ui_story"]) and arg_365_1.var_.characterEffect10125ui_story then
				arg_365_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action2_2")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_368_2 = 0
			local var_368_3 = 0.3

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(921041086)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_7 = 12 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 12)

				if (12 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 12)) > 0 and var_368_3 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041086", "story_v_side_old_921041.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041086", "story_v_side_old_921041.awb") / 1000

					if var_368_8 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_2
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_side_old_921041", "921041086", "story_v_side_old_921041.awb")

						arg_365_1:RecordAudio("921041086", var_368_9)
						arg_365_1:RecordAudio("921041086", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041086", "story_v_side_old_921041.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041086", "story_v_side_old_921041.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_10 and arg_365_1.time_ < var_368_2 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play921041087 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 921041087
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play921041088(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["10125ui_story"]) and arg_369_1.var_.characterEffect10125ui_story == nil then
				arg_369_1.var_.characterEffect10125ui_story = arg_369_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["10125ui_story"]) then
				if arg_369_1.var_.characterEffect10125ui_story and not isNil(arg_369_1.actors_["10125ui_story"]) then
					arg_369_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_369_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["10125ui_story"]) and arg_369_1.var_.characterEffect10125ui_story then
				arg_369_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_369_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.1

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(921041087).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 4 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 4)

				if (4 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 4)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play921041088 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 921041088
		arg_373_1.duration_ = 7.1

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play921041089(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10125ui_story = arg_373_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10125ui_story, Vector3.New(0, 100, 0), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10125ui_story"].transform.position).z)
				arg_373_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10125ui_story"].transform.localEulerAngles = arg_373_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_373_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["10125ui_story"].transform.position).z)
				arg_373_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["10125ui_story"].transform.localEulerAngles = arg_373_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["10125ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10125ui_story == nil then
				arg_373_1.var_.characterEffect10125ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect10125ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_2)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect10125ui_story then
				arg_373_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_376_3 = 0

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_4 = 1.2

			if var_376_3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_3 + var_376_4 then
				local var_376_5 = Color.New(1, 1, 1)

				var_376_5.a = Mathf.Lerp(0, 1, (arg_373_1.time_ - var_376_3) / var_376_4)
				arg_373_1.mask_.color = var_376_5
			end

			if arg_373_1.time_ >= var_376_3 + var_376_4 and arg_373_1.time_ < var_376_3 + var_376_4 + arg_376_0 then
				local var_376_6 = Color.New(1, 1, 1)

				var_376_6.a = 1
				arg_373_1.mask_.color = var_376_6
			end

			local var_376_7 = 1.2

			if 1.2 < arg_373_1.time_ and arg_373_1.time_ <= var_376_7 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_8 = 0.9

			if var_376_7 <= arg_373_1.time_ and arg_373_1.time_ < var_376_7 + var_376_8 then
				local var_376_9 = Color.New(1, 1, 1)

				var_376_9.a = Mathf.Lerp(1, 0, (arg_373_1.time_ - var_376_7) / var_376_8)
				arg_373_1.mask_.color = var_376_9
			end

			if arg_373_1.time_ >= var_376_7 + var_376_8 and arg_373_1.time_ < var_376_7 + var_376_8 + arg_376_0 then
				local var_376_10 = Color.New(1, 1, 1)

				arg_373_1.mask_.enabled = false
				var_376_10.a = 0
				arg_373_1.mask_.color = var_376_10
			end

			local var_376_11 = "STwhite"

			if arg_373_1.bgs_.STwhite == nil then
				local var_376_12 = Object.Instantiate(arg_373_1.paintGo_)

				var_376_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_376_11)
				var_376_12.name = var_376_11
				var_376_12.transform.parent = arg_373_1.stage_.transform
				var_376_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_373_1.bgs_[var_376_11] = var_376_12
			end

			if 1.2 < arg_373_1.time_ and arg_373_1.time_ <= 1.2 + arg_376_0 then
				local var_376_13 = arg_373_1.bgs_.STwhite

				arg_373_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_376_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_376_14 = var_376_13:GetComponent("SpriteRenderer")

				if var_376_14 and var_376_14.sprite then
					local var_376_15 = 2 * (var_376_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_376_13.transform.localScale = Vector3.New(var_376_15 / var_376_14.sprite.bounds.size.y < var_376_15 * manager.ui.mainCameraCom_.aspect / var_376_14.sprite.bounds.size.x and var_376_15 * manager.ui.mainCameraCom_.aspect / var_376_14.sprite.bounds.size.x or var_376_15 / var_376_14.sprite.bounds.size.y, var_376_15 / var_376_14.sprite.bounds.size.y < var_376_15 * manager.ui.mainCameraCom_.aspect / var_376_14.sprite.bounds.size.x and var_376_15 * manager.ui.mainCameraCom_.aspect / var_376_14.sprite.bounds.size.x or var_376_15 / var_376_14.sprite.bounds.size.y, 0)
				end

				for iter_376_0, iter_376_1 in pairs(arg_373_1.bgs_) do
					if iter_376_0 ~= "STwhite" then
						iter_376_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_373_1.frameCnt_ <= 1 then
				arg_373_1.dialog_:SetActive(false)
			end

			local var_376_16 = 2.099999999999
			local var_376_17 = 0.3

			if 2.099999999999 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				arg_373_1.dialog_:SetActive(true)

				arg_373_1.dialogCg_.alpha = 0

				local var_376_18 = LeanTween.value(arg_373_1.dialog_, 0, 1, 0.3)

				var_376_18:setOnUpdate(LuaHelper.FloatAction(function(arg_377_0)
					arg_373_1.dialogCg_.alpha = arg_377_0
				end))
				var_376_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_373_1.dialog_)
					var_376_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_373_1.duration_ = arg_373_1.duration_ + 0.3

				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_19 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(921041088).content)

				arg_373_1.text_.text = var_376_19

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_21 = 12 <= 0 and var_376_17 or var_376_17 * (utf8.len(var_376_19) / 12)

				if (12 <= 0 and var_376_17 or var_376_17 * (utf8.len(var_376_19) / 12)) > 0 and var_376_17 < var_376_21 then
					arg_373_1.talkMaxDuration = var_376_21
					var_376_16 = var_376_16 + 0.3

					if var_376_21 + var_376_16 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_21 + var_376_16
					end
				end

				arg_373_1.text_.text = var_376_19
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_22 = var_376_16 + 0.3
			local var_376_23 = math.max(var_376_17, arg_373_1.talkMaxDuration)

			if var_376_16 + 0.3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_22 + var_376_23 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_22) / var_376_23

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_22 + var_376_23 and arg_373_1.time_ < var_376_22 + var_376_23 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play921041089 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 921041089
		arg_379_1.duration_ = 6.13

		local var_379_0 = {
			zh = 6.13266667262713,
			ja = 4.56666667262713
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
				arg_379_0:Play921041090(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 1.3666666696469 < arg_379_1.time_ and arg_379_1.time_ <= 1.3666666696469 + arg_382_0 then
				arg_379_1.var_.moveOldPos10125ui_story = arg_379_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 1.3666666696469 <= arg_379_1.time_ and arg_379_1.time_ < 1.3666666696469 + var_382_0 then
				arg_379_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10125ui_story, Vector3.New(0, -0.98, -6.1), (arg_379_1.time_ - 1.3666666696469) / var_382_0)
				arg_379_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["10125ui_story"].transform.position).z)
				arg_379_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["10125ui_story"].transform.localEulerAngles = arg_379_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 1.3666666696469 + var_382_0 and arg_379_1.time_ < 1.3666666696469 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_379_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["10125ui_story"].transform.position).z)
				arg_379_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["10125ui_story"].transform.localEulerAngles = arg_379_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["10125ui_story"]

			if 1.3666666696469 < arg_379_1.time_ and arg_379_1.time_ <= 1.3666666696469 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect10125ui_story == nil then
				arg_379_1.var_.characterEffect10125ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 1.3666666696469 <= arg_379_1.time_ and arg_379_1.time_ < 1.3666666696469 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect10125ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 1.3666666696469 + var_382_2 and arg_379_1.time_ < 1.3666666696469 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect10125ui_story then
				arg_379_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 1.3666666696469 < arg_379_1.time_ and arg_379_1.time_ <= 1.3666666696469 + arg_382_0 then
				arg_379_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action4_1")
			end

			if 1.3666666696469 < arg_379_1.time_ and arg_379_1.time_ <= 1.3666666696469 + arg_382_0 then
				arg_379_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_382_4 = 0

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1.mask_.enabled = true
				arg_379_1.mask_.raycastTarget = true

				arg_379_1:SetGaussion(false)
			end

			local var_382_5 = 1.56666667262713

			if var_382_4 <= arg_379_1.time_ and arg_379_1.time_ < var_382_4 + var_382_5 then
				local var_382_6 = Color.New(1, 1, 1)

				var_382_6.a = Mathf.Lerp(1, 0, (arg_379_1.time_ - var_382_4) / var_382_5)
				arg_379_1.mask_.color = var_382_6
			end

			if arg_379_1.time_ >= var_382_4 + var_382_5 and arg_379_1.time_ < var_382_4 + var_382_5 + arg_382_0 then
				local var_382_7 = Color.New(1, 1, 1)

				arg_379_1.mask_.enabled = false
				var_382_7.a = 0
				arg_379_1.mask_.color = var_382_7
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				local var_382_8 = arg_379_1.bgs_.X203F

				arg_379_1.bgs_.X203F.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_382_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_382_9 = var_382_8:GetComponent("SpriteRenderer")

				if var_382_9 and var_382_9.sprite then
					local var_382_10 = 2 * (var_382_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_382_8.transform.localScale = Vector3.New(var_382_10 / var_382_9.sprite.bounds.size.y < var_382_10 * manager.ui.mainCameraCom_.aspect / var_382_9.sprite.bounds.size.x and var_382_10 * manager.ui.mainCameraCom_.aspect / var_382_9.sprite.bounds.size.x or var_382_10 / var_382_9.sprite.bounds.size.y, var_382_10 / var_382_9.sprite.bounds.size.y < var_382_10 * manager.ui.mainCameraCom_.aspect / var_382_9.sprite.bounds.size.x and var_382_10 * manager.ui.mainCameraCom_.aspect / var_382_9.sprite.bounds.size.x or var_382_10 / var_382_9.sprite.bounds.size.y, 0)
				end

				for iter_382_0, iter_382_1 in pairs(arg_379_1.bgs_) do
					if iter_382_0 ~= "X203F" then
						iter_382_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_379_1.frameCnt_ <= 1 then
				arg_379_1.dialog_:SetActive(false)
			end

			local var_382_11 = 1.56666667262713
			local var_382_12 = 0.675

			if 1.56666667262713 < arg_379_1.time_ and arg_379_1.time_ <= var_382_11 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				arg_379_1.dialog_:SetActive(true)

				arg_379_1.dialogCg_.alpha = 0

				local var_382_13 = LeanTween.value(arg_379_1.dialog_, 0, 1, 0.3)

				var_382_13:setOnUpdate(LuaHelper.FloatAction(function(arg_383_0)
					arg_379_1.dialogCg_.alpha = arg_383_0
				end))
				var_382_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_379_1.dialog_)
					var_382_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_379_1.duration_ = arg_379_1.duration_ + 0.3

				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_14 = arg_379_1:GetWordFromCfg(921041089)
				local var_382_15 = arg_379_1:FormatText(var_382_14.content)

				arg_379_1.text_.text = var_382_15

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_17 = 27 <= 0 and var_382_12 or var_382_12 * (utf8.len(var_382_15) / 27)

				if (27 <= 0 and var_382_12 or var_382_12 * (utf8.len(var_382_15) / 27)) > 0 and var_382_12 < var_382_17 then
					arg_379_1.talkMaxDuration = var_382_17
					var_382_11 = var_382_11 + 0.3

					if var_382_17 + var_382_11 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_17 + var_382_11
					end
				end

				arg_379_1.text_.text = var_382_15
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041089", "story_v_side_old_921041.awb") ~= 0 then
					local var_382_18 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041089", "story_v_side_old_921041.awb") / 1000

					if var_382_18 + var_382_11 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_18 + var_382_11
					end

					if var_382_14.prefab_name ~= "" and arg_379_1.actors_[var_382_14.prefab_name] ~= nil then
						local var_382_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_14.prefab_name].transform, "story_v_side_old_921041", "921041089", "story_v_side_old_921041.awb")

						arg_379_1:RecordAudio("921041089", var_382_19)
						arg_379_1:RecordAudio("921041089", var_382_19)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041089", "story_v_side_old_921041.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041089", "story_v_side_old_921041.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_20 = var_382_11 + 0.3
			local var_382_21 = math.max(var_382_12, arg_379_1.talkMaxDuration)

			if var_382_11 + 0.3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_20 + var_382_21 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_20) / var_382_21

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_20 + var_382_21 and arg_379_1.time_ < var_382_20 + var_382_21 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.3666666696469,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play921041090 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 921041090
		arg_385_1.duration_ = 6.03

		local var_385_0 = {
			zh = 6.033,
			ja = 5.833
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play921041091(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.6

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(921041090)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 24 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 24)

				if (24 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 24)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041090", "story_v_side_old_921041.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041090", "story_v_side_old_921041.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_side_old_921041", "921041090", "story_v_side_old_921041.awb")

						arg_385_1:RecordAudio("921041090", var_388_6)
						arg_385_1:RecordAudio("921041090", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041090", "story_v_side_old_921041.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041090", "story_v_side_old_921041.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play921041091 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 921041091
		arg_389_1.duration_ = 10.13

		local var_389_0 = {
			zh = 7.766,
			ja = 10.133
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play921041092(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_392_0 = 0
			local var_392_1 = 0.8

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_2 = arg_389_1:GetWordFromCfg(921041091)
				local var_392_3 = arg_389_1:FormatText(var_392_2.content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 32 <= 0 and var_392_1 or var_392_1 * (utf8.len(var_392_3) / 32)

				if (32 <= 0 and var_392_1 or var_392_1 * (utf8.len(var_392_3) / 32)) > 0 and var_392_1 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_0
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041091", "story_v_side_old_921041.awb") ~= 0 then
					local var_392_6 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041091", "story_v_side_old_921041.awb") / 1000

					if var_392_6 + var_392_0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_0
					end

					if var_392_2.prefab_name ~= "" and arg_389_1.actors_[var_392_2.prefab_name] ~= nil then
						local var_392_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_2.prefab_name].transform, "story_v_side_old_921041", "921041091", "story_v_side_old_921041.awb")

						arg_389_1:RecordAudio("921041091", var_392_7)
						arg_389_1:RecordAudio("921041091", var_392_7)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041091", "story_v_side_old_921041.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041091", "story_v_side_old_921041.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_8 = math.max(var_392_1, arg_389_1.talkMaxDuration)

			if var_392_0 <= arg_389_1.time_ and arg_389_1.time_ < var_392_0 + var_392_8 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_0) / var_392_8

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_0 + var_392_8 and arg_389_1.time_ < var_392_0 + var_392_8 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play921041092 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 921041092
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play921041093(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["10125ui_story"]) and arg_393_1.var_.characterEffect10125ui_story == nil then
				arg_393_1.var_.characterEffect10125ui_story = arg_393_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["10125ui_story"]) then
				if arg_393_1.var_.characterEffect10125ui_story and not isNil(arg_393_1.actors_["10125ui_story"]) then
					arg_393_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_393_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["10125ui_story"]) and arg_393_1.var_.characterEffect10125ui_story then
				arg_393_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_393_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 0.725

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(921041092).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 29 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 29)

				if (29 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 29)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play921041093 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 921041093
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play921041094(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.3

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(921041093).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 12 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 12)

				if (12 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 12)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play921041094 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 921041094
		arg_401_1.duration_ = 7.37

		local var_401_0 = {
			zh = 6.733,
			ja = 7.366
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play921041095(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10125ui_story"]) and arg_401_1.var_.characterEffect10125ui_story == nil then
				arg_401_1.var_.characterEffect10125ui_story = arg_401_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10125ui_story"]) then
				if arg_401_1.var_.characterEffect10125ui_story and not isNil(arg_401_1.actors_["10125ui_story"]) then
					arg_401_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10125ui_story"]) and arg_401_1.var_.characterEffect10125ui_story then
				arg_401_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action4_2")
			end

			local var_404_2 = 0
			local var_404_3 = 0.7

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_4 = arg_401_1:GetWordFromCfg(921041094)
				local var_404_5 = arg_401_1:FormatText(var_404_4.content)

				arg_401_1.text_.text = var_404_5

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_7 = 28 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 28)

				if (28 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 28)) > 0 and var_404_3 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_5
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041094", "story_v_side_old_921041.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041094", "story_v_side_old_921041.awb") / 1000

					if var_404_8 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_2
					end

					if var_404_4.prefab_name ~= "" and arg_401_1.actors_[var_404_4.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_4.prefab_name].transform, "story_v_side_old_921041", "921041094", "story_v_side_old_921041.awb")

						arg_401_1:RecordAudio("921041094", var_404_9)
						arg_401_1:RecordAudio("921041094", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041094", "story_v_side_old_921041.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041094", "story_v_side_old_921041.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_10 and arg_401_1.time_ < var_404_2 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play921041095 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 921041095
		arg_405_1.duration_ = 7.37

		local var_405_0 = {
			zh = 3.933,
			ja = 7.366
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play921041096(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.5

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:GetWordFromCfg(921041095)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 20 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 20)

				if (20 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 20)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041095", "story_v_side_old_921041.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041095", "story_v_side_old_921041.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_side_old_921041", "921041095", "story_v_side_old_921041.awb")

						arg_405_1:RecordAudio("921041095", var_408_6)
						arg_405_1:RecordAudio("921041095", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041095", "story_v_side_old_921041.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041095", "story_v_side_old_921041.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play921041096 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 921041096
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play921041097(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10125ui_story"]) and arg_409_1.var_.characterEffect10125ui_story == nil then
				arg_409_1.var_.characterEffect10125ui_story = arg_409_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10125ui_story"]) then
				if arg_409_1.var_.characterEffect10125ui_story and not isNil(arg_409_1.actors_["10125ui_story"]) then
					arg_409_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_409_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10125ui_story"]) and arg_409_1.var_.characterEffect10125ui_story then
				arg_409_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_409_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.45

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(921041096).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 18 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 18)

				if (18 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 18)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play921041097 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 921041097
		arg_413_1.duration_ = 4.03

		local var_413_0 = {
			zh = 4.033,
			ja = 3.666
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play921041098(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["10125ui_story"]) and arg_413_1.var_.characterEffect10125ui_story == nil then
				arg_413_1.var_.characterEffect10125ui_story = arg_413_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["10125ui_story"]) then
				if arg_413_1.var_.characterEffect10125ui_story and not isNil(arg_413_1.actors_["10125ui_story"]) then
					arg_413_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["10125ui_story"]) and arg_413_1.var_.characterEffect10125ui_story then
				arg_413_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action3_1")
			end

			local var_416_2 = 0
			local var_416_3 = 0.45

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_2 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_4 = arg_413_1:GetWordFromCfg(921041097)
				local var_416_5 = arg_413_1:FormatText(var_416_4.content)

				arg_413_1.text_.text = var_416_5

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_7 = 18 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_5) / 18)

				if (18 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_5) / 18)) > 0 and var_416_3 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_2
					end
				end

				arg_413_1.text_.text = var_416_5
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041097", "story_v_side_old_921041.awb") ~= 0 then
					local var_416_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041097", "story_v_side_old_921041.awb") / 1000

					if var_416_8 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_8 + var_416_2
					end

					if var_416_4.prefab_name ~= "" and arg_413_1.actors_[var_416_4.prefab_name] ~= nil then
						local var_416_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_4.prefab_name].transform, "story_v_side_old_921041", "921041097", "story_v_side_old_921041.awb")

						arg_413_1:RecordAudio("921041097", var_416_9)
						arg_413_1:RecordAudio("921041097", var_416_9)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041097", "story_v_side_old_921041.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041097", "story_v_side_old_921041.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_10 = math.max(var_416_3, arg_413_1.talkMaxDuration)

			if var_416_2 <= arg_413_1.time_ and arg_413_1.time_ < var_416_2 + var_416_10 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_2) / var_416_10

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_2 + var_416_10 and arg_413_1.time_ < var_416_2 + var_416_10 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play921041098 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 921041098
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play921041099(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos10125ui_story = arg_417_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10125ui_story, Vector3.New(0, 100, 0), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10125ui_story"].transform.position).z)
				arg_417_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["10125ui_story"].transform.localEulerAngles = arg_417_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_417_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10125ui_story"].transform.position).z)
				arg_417_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["10125ui_story"].transform.localEulerAngles = arg_417_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["10125ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect10125ui_story == nil then
				arg_417_1.var_.characterEffect10125ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect10125ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_417_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_2)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect10125ui_story then
				arg_417_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_417_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_420_3 = 0
			local var_420_4 = 0.825

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_3 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_5 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(921041098).content)

				arg_417_1.text_.text = var_420_5

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_7 = 33 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 33)

				if (33 <= 0 and var_420_4 or var_420_4 * (utf8.len(var_420_5) / 33)) > 0 and var_420_4 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_3 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_3
					end
				end

				arg_417_1.text_.text = var_420_5
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_4, arg_417_1.talkMaxDuration)

			if var_420_3 <= arg_417_1.time_ and arg_417_1.time_ < var_420_3 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_3) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_3 + var_420_8 and arg_417_1.time_ < var_420_3 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play921041099 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 921041099
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play921041100(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.45

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_1 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(921041099).content)

				arg_421_1.text_.text = var_424_1

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_3 = 18 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 18)

				if (18 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 18)) > 0 and var_424_0 < var_424_3 then
					arg_421_1.talkMaxDuration = var_424_3

					if var_424_3 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_3 + 0
					end
				end

				arg_421_1.text_.text = var_424_1
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_4 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_4 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_4

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_4 and arg_421_1.time_ < 0 + var_424_4 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play921041100 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 921041100
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play921041101(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.1

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(921041100).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 4 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 4)

				if (4 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 4)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play921041101 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 921041101
		arg_429_1.duration_ = 5.33

		local var_429_0 = {
			zh = 4.433,
			ja = 5.333
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play921041102(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10125ui_story = arg_429_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10125ui_story, Vector3.New(0, -0.98, -6.1), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10125ui_story"].transform.position).z)
				arg_429_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["10125ui_story"].transform.localEulerAngles = arg_429_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_429_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["10125ui_story"].transform.position).z)
				arg_429_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["10125ui_story"].transform.localEulerAngles = arg_429_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["10125ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect10125ui_story == nil then
				arg_429_1.var_.characterEffect10125ui_story = var_432_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 and not isNil(var_432_1) then
				if arg_429_1.var_.characterEffect10125ui_story and not isNil(var_432_1) then
					arg_429_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect10125ui_story then
				arg_429_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action3_2")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_432_4 = 0
			local var_432_5 = 0.45

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_6 = arg_429_1:GetWordFromCfg(921041101)
				local var_432_7 = arg_429_1:FormatText(var_432_6.content)

				arg_429_1.text_.text = var_432_7

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_9 = 18 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 18)

				if (18 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 18)) > 0 and var_432_5 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9

					if var_432_9 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_4
					end
				end

				arg_429_1.text_.text = var_432_7
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041101", "story_v_side_old_921041.awb") ~= 0 then
					local var_432_10 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041101", "story_v_side_old_921041.awb") / 1000

					if var_432_10 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_4
					end

					if var_432_6.prefab_name ~= "" and arg_429_1.actors_[var_432_6.prefab_name] ~= nil then
						local var_432_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_6.prefab_name].transform, "story_v_side_old_921041", "921041101", "story_v_side_old_921041.awb")

						arg_429_1:RecordAudio("921041101", var_432_11)
						arg_429_1:RecordAudio("921041101", var_432_11)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041101", "story_v_side_old_921041.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041101", "story_v_side_old_921041.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_12 = math.max(var_432_5, arg_429_1.talkMaxDuration)

			if var_432_4 <= arg_429_1.time_ and arg_429_1.time_ < var_432_4 + var_432_12 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_4) / var_432_12

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_4 + var_432_12 and arg_429_1.time_ < var_432_4 + var_432_12 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play921041102 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 921041102
		arg_433_1.duration_ = 5.8

		local var_433_0 = {
			zh = 4.2,
			ja = 5.8
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play921041103(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.7

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_1 = arg_433_1:GetWordFromCfg(921041102)
				local var_436_2 = arg_433_1:FormatText(var_436_1.content)

				arg_433_1.text_.text = var_436_2

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_4 = 28 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 28)

				if (28 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 28)) > 0 and var_436_0 < var_436_4 then
					arg_433_1.talkMaxDuration = var_436_4

					if var_436_4 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_4 + 0
					end
				end

				arg_433_1.text_.text = var_436_2
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041102", "story_v_side_old_921041.awb") ~= 0 then
					local var_436_5 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041102", "story_v_side_old_921041.awb") / 1000

					if var_436_5 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + 0
					end

					if var_436_1.prefab_name ~= "" and arg_433_1.actors_[var_436_1.prefab_name] ~= nil then
						local var_436_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_1.prefab_name].transform, "story_v_side_old_921041", "921041102", "story_v_side_old_921041.awb")

						arg_433_1:RecordAudio("921041102", var_436_6)
						arg_433_1:RecordAudio("921041102", var_436_6)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041102", "story_v_side_old_921041.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041102", "story_v_side_old_921041.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_7 and arg_433_1.time_ < 0 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play921041103 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 921041103
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play921041104(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["10125ui_story"]) and arg_437_1.var_.characterEffect10125ui_story == nil then
				arg_437_1.var_.characterEffect10125ui_story = arg_437_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["10125ui_story"]) then
				if arg_437_1.var_.characterEffect10125ui_story and not isNil(arg_437_1.actors_["10125ui_story"]) then
					arg_437_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_437_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["10125ui_story"]) and arg_437_1.var_.characterEffect10125ui_story then
				arg_437_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_437_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_440_1 = 0
			local var_440_2 = 0.575

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(921041103).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 23 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 23)

				if (23 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 23)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play921041104 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 921041104
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play921041105(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.45

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_1 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(921041104).content)

				arg_441_1.text_.text = var_444_1

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_3 = 18 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 18)

				if (18 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_1) / 18)) > 0 and var_444_0 < var_444_3 then
					arg_441_1.talkMaxDuration = var_444_3

					if var_444_3 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_3 + 0
					end
				end

				arg_441_1.text_.text = var_444_1
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_4 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_4 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_4

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_4 and arg_441_1.time_ < 0 + var_444_4 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play921041105 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 921041105
		arg_445_1.duration_ = 6.5

		local var_445_0 = {
			zh = 5.2,
			ja = 6.5
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play921041106(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["10125ui_story"]) and arg_445_1.var_.characterEffect10125ui_story == nil then
				arg_445_1.var_.characterEffect10125ui_story = arg_445_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["10125ui_story"]) then
				if arg_445_1.var_.characterEffect10125ui_story and not isNil(arg_445_1.actors_["10125ui_story"]) then
					arg_445_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["10125ui_story"]) and arg_445_1.var_.characterEffect10125ui_story then
				arg_445_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action9_1")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_448_2 = 0
			local var_448_3 = 0.425

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_4 = arg_445_1:GetWordFromCfg(921041105)
				local var_448_5 = arg_445_1:FormatText(var_448_4.content)

				arg_445_1.text_.text = var_448_5

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 17 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 17)

				if (17 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 17)) > 0 and var_448_3 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_2
					end
				end

				arg_445_1.text_.text = var_448_5
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041105", "story_v_side_old_921041.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041105", "story_v_side_old_921041.awb") / 1000

					if var_448_8 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_2
					end

					if var_448_4.prefab_name ~= "" and arg_445_1.actors_[var_448_4.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_4.prefab_name].transform, "story_v_side_old_921041", "921041105", "story_v_side_old_921041.awb")

						arg_445_1:RecordAudio("921041105", var_448_9)
						arg_445_1:RecordAudio("921041105", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041105", "story_v_side_old_921041.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041105", "story_v_side_old_921041.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_3, arg_445_1.talkMaxDuration)

			if var_448_2 <= arg_445_1.time_ and arg_445_1.time_ < var_448_2 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_2) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_2 + var_448_10 and arg_445_1.time_ < var_448_2 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play921041106 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 921041106
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play921041107(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["10125ui_story"]) and arg_449_1.var_.characterEffect10125ui_story == nil then
				arg_449_1.var_.characterEffect10125ui_story = arg_449_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["10125ui_story"]) then
				if arg_449_1.var_.characterEffect10125ui_story and not isNil(arg_449_1.actors_["10125ui_story"]) then
					arg_449_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_449_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_0)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["10125ui_story"]) and arg_449_1.var_.characterEffect10125ui_story then
				arg_449_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_449_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_452_1 = 0
			local var_452_2 = 0.35

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_3 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(921041106).content)

				arg_449_1.text_.text = var_452_3

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_5 = 14 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 14)

				if (14 <= 0 and var_452_2 or var_452_2 * (utf8.len(var_452_3) / 14)) > 0 and var_452_2 < var_452_5 then
					arg_449_1.talkMaxDuration = var_452_5

					if var_452_5 + var_452_1 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + var_452_1
					end
				end

				arg_449_1.text_.text = var_452_3
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_6 = math.max(var_452_2, arg_449_1.talkMaxDuration)

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_6 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_1) / var_452_6

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_1 + var_452_6 and arg_449_1.time_ < var_452_1 + var_452_6 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play921041107 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 921041107
		arg_453_1.duration_ = 5.23

		local var_453_0 = {
			zh = 5.233,
			ja = 4.233
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play921041108(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10125ui_story"]) and arg_453_1.var_.characterEffect10125ui_story == nil then
				arg_453_1.var_.characterEffect10125ui_story = arg_453_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_0 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10125ui_story"]) then
				if arg_453_1.var_.characterEffect10125ui_story and not isNil(arg_453_1.actors_["10125ui_story"]) then
					arg_453_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10125ui_story"]) and arg_453_1.var_.characterEffect10125ui_story then
				arg_453_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_456_2 = 0
			local var_456_3 = 0.525

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_4 = arg_453_1:GetWordFromCfg(921041107)
				local var_456_5 = arg_453_1:FormatText(var_456_4.content)

				arg_453_1.text_.text = var_456_5

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_7 = 21 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_5) / 21)

				if (21 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_5) / 21)) > 0 and var_456_3 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_2
					end
				end

				arg_453_1.text_.text = var_456_5
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041107", "story_v_side_old_921041.awb") ~= 0 then
					local var_456_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041107", "story_v_side_old_921041.awb") / 1000

					if var_456_8 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_2
					end

					if var_456_4.prefab_name ~= "" and arg_453_1.actors_[var_456_4.prefab_name] ~= nil then
						local var_456_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_4.prefab_name].transform, "story_v_side_old_921041", "921041107", "story_v_side_old_921041.awb")

						arg_453_1:RecordAudio("921041107", var_456_9)
						arg_453_1:RecordAudio("921041107", var_456_9)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041107", "story_v_side_old_921041.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041107", "story_v_side_old_921041.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_3, arg_453_1.talkMaxDuration)

			if var_456_2 <= arg_453_1.time_ and arg_453_1.time_ < var_456_2 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_2) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_2 + var_456_10 and arg_453_1.time_ < var_456_2 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play921041108 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 921041108
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play921041109(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["10125ui_story"]) and arg_457_1.var_.characterEffect10125ui_story == nil then
				arg_457_1.var_.characterEffect10125ui_story = arg_457_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["10125ui_story"]) then
				if arg_457_1.var_.characterEffect10125ui_story and not isNil(arg_457_1.actors_["10125ui_story"]) then
					arg_457_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_457_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_0)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["10125ui_story"]) and arg_457_1.var_.characterEffect10125ui_story then
				arg_457_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_457_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_460_1 = 0
			local var_460_2 = 0.05

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(921041108).content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 2 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 2)

				if (2 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 2)) > 0 and var_460_2 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_6 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_6 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_6

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_6 and arg_457_1.time_ < var_460_1 + var_460_6 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play921041109 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 921041109
		arg_461_1.duration_ = 6.67

		local var_461_0 = {
			zh = 5.666,
			ja = 6.666
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play921041110(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10125ui_story"]) and arg_461_1.var_.characterEffect10125ui_story == nil then
				arg_461_1.var_.characterEffect10125ui_story = arg_461_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10125ui_story"]) then
				if arg_461_1.var_.characterEffect10125ui_story and not isNil(arg_461_1.actors_["10125ui_story"]) then
					arg_461_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10125ui_story"]) and arg_461_1.var_.characterEffect10125ui_story then
				arg_461_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action9_2")
			end

			local var_464_2 = 0
			local var_464_3 = 0.525

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_2 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_4 = arg_461_1:GetWordFromCfg(921041109)
				local var_464_5 = arg_461_1:FormatText(var_464_4.content)

				arg_461_1.text_.text = var_464_5

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_7 = 21 <= 0 and var_464_3 or var_464_3 * (utf8.len(var_464_5) / 21)

				if (21 <= 0 and var_464_3 or var_464_3 * (utf8.len(var_464_5) / 21)) > 0 and var_464_3 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_2 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_2
					end
				end

				arg_461_1.text_.text = var_464_5
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041109", "story_v_side_old_921041.awb") ~= 0 then
					local var_464_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041109", "story_v_side_old_921041.awb") / 1000

					if var_464_8 + var_464_2 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_2
					end

					if var_464_4.prefab_name ~= "" and arg_461_1.actors_[var_464_4.prefab_name] ~= nil then
						local var_464_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_4.prefab_name].transform, "story_v_side_old_921041", "921041109", "story_v_side_old_921041.awb")

						arg_461_1:RecordAudio("921041109", var_464_9)
						arg_461_1:RecordAudio("921041109", var_464_9)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041109", "story_v_side_old_921041.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041109", "story_v_side_old_921041.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_3, arg_461_1.talkMaxDuration)

			if var_464_2 <= arg_461_1.time_ and arg_461_1.time_ < var_464_2 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_2) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_2 + var_464_10 and arg_461_1.time_ < var_464_2 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play921041110 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 921041110
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play921041111(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["10125ui_story"]) and arg_465_1.var_.characterEffect10125ui_story == nil then
				arg_465_1.var_.characterEffect10125ui_story = arg_465_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["10125ui_story"]) then
				if arg_465_1.var_.characterEffect10125ui_story and not isNil(arg_465_1.actors_["10125ui_story"]) then
					arg_465_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_465_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_0)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["10125ui_story"]) and arg_465_1.var_.characterEffect10125ui_story then
				arg_465_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_465_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_468_1 = 0
			local var_468_2 = 0.5

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_3 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(921041110).content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 20 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 20)

				if (20 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 20)) > 0 and var_468_2 < var_468_5 then
					arg_465_1.talkMaxDuration = var_468_5

					if var_468_5 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + var_468_1
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_6 = math.max(var_468_2, arg_465_1.talkMaxDuration)

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_6 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_1) / var_468_6

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_1 + var_468_6 and arg_465_1.time_ < var_468_1 + var_468_6 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play921041111 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 921041111
		arg_469_1.duration_ = 12.5

		local var_469_0 = {
			zh = 7.133,
			ja = 12.5
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play921041112(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["10125ui_story"]) and arg_469_1.var_.characterEffect10125ui_story == nil then
				arg_469_1.var_.characterEffect10125ui_story = arg_469_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["10125ui_story"]) then
				if arg_469_1.var_.characterEffect10125ui_story and not isNil(arg_469_1.actors_["10125ui_story"]) then
					arg_469_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["10125ui_story"]) and arg_469_1.var_.characterEffect10125ui_story then
				arg_469_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			local var_472_2 = 0
			local var_472_3 = 0.7

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_4 = arg_469_1:GetWordFromCfg(921041111)
				local var_472_5 = arg_469_1:FormatText(var_472_4.content)

				arg_469_1.text_.text = var_472_5

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 28 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 28)

				if (28 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 28)) > 0 and var_472_3 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_2
					end
				end

				arg_469_1.text_.text = var_472_5
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041111", "story_v_side_old_921041.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041111", "story_v_side_old_921041.awb") / 1000

					if var_472_8 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_2
					end

					if var_472_4.prefab_name ~= "" and arg_469_1.actors_[var_472_4.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_4.prefab_name].transform, "story_v_side_old_921041", "921041111", "story_v_side_old_921041.awb")

						arg_469_1:RecordAudio("921041111", var_472_9)
						arg_469_1:RecordAudio("921041111", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041111", "story_v_side_old_921041.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041111", "story_v_side_old_921041.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_3, arg_469_1.talkMaxDuration)

			if var_472_2 <= arg_469_1.time_ and arg_469_1.time_ < var_472_2 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_2) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_2 + var_472_10 and arg_469_1.time_ < var_472_2 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play921041112 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 921041112
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play921041113(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["10125ui_story"]) and arg_473_1.var_.characterEffect10125ui_story == nil then
				arg_473_1.var_.characterEffect10125ui_story = arg_473_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["10125ui_story"]) then
				if arg_473_1.var_.characterEffect10125ui_story and not isNil(arg_473_1.actors_["10125ui_story"]) then
					arg_473_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_473_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_0)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["10125ui_story"]) and arg_473_1.var_.characterEffect10125ui_story then
				arg_473_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_473_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_476_1 = 0
			local var_476_2 = 0.1

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(921041112).content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 4 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_3) / 4)

				if (4 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_3) / 4)) > 0 and var_476_2 < var_476_5 then
					arg_473_1.talkMaxDuration = var_476_5

					if var_476_5 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + var_476_1
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_6 = math.max(var_476_2, arg_473_1.talkMaxDuration)

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_6 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_1) / var_476_6

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_1 + var_476_6 and arg_473_1.time_ < var_476_1 + var_476_6 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play921041113 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 921041113
		arg_477_1.duration_ = 2

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play921041114(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["10125ui_story"]) and arg_477_1.var_.characterEffect10125ui_story == nil then
				arg_477_1.var_.characterEffect10125ui_story = arg_477_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["10125ui_story"]) then
				if arg_477_1.var_.characterEffect10125ui_story and not isNil(arg_477_1.actors_["10125ui_story"]) then
					arg_477_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["10125ui_story"]) and arg_477_1.var_.characterEffect10125ui_story then
				arg_477_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_480_2 = 0
			local var_480_3 = 0.075

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_4 = arg_477_1:GetWordFromCfg(921041113)
				local var_480_5 = arg_477_1:FormatText(var_480_4.content)

				arg_477_1.text_.text = var_480_5

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 3 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 3)

				if (3 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 3)) > 0 and var_480_3 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_2
					end
				end

				arg_477_1.text_.text = var_480_5
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041113", "story_v_side_old_921041.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041113", "story_v_side_old_921041.awb") / 1000

					if var_480_8 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_2
					end

					if var_480_4.prefab_name ~= "" and arg_477_1.actors_[var_480_4.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_4.prefab_name].transform, "story_v_side_old_921041", "921041113", "story_v_side_old_921041.awb")

						arg_477_1:RecordAudio("921041113", var_480_9)
						arg_477_1:RecordAudio("921041113", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041113", "story_v_side_old_921041.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041113", "story_v_side_old_921041.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_3, arg_477_1.talkMaxDuration)

			if var_480_2 <= arg_477_1.time_ and arg_477_1.time_ < var_480_2 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_2) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_2 + var_480_10 and arg_477_1.time_ < var_480_2 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play921041114 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 921041114
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play921041115(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["10125ui_story"]) and arg_481_1.var_.characterEffect10125ui_story == nil then
				arg_481_1.var_.characterEffect10125ui_story = arg_481_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["10125ui_story"]) then
				if arg_481_1.var_.characterEffect10125ui_story and not isNil(arg_481_1.actors_["10125ui_story"]) then
					arg_481_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_481_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_0)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["10125ui_story"]) and arg_481_1.var_.characterEffect10125ui_story then
				arg_481_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_481_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_484_1 = 0
			local var_484_2 = 0.375

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(921041114).content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 15 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 15)

				if (15 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 15)) > 0 and var_484_2 < var_484_5 then
					arg_481_1.talkMaxDuration = var_484_5

					if var_484_5 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + var_484_1
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_6 = math.max(var_484_2, arg_481_1.talkMaxDuration)

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_6 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_1) / var_484_6

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_1 + var_484_6 and arg_481_1.time_ < var_484_1 + var_484_6 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play921041115 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 921041115
		arg_485_1.duration_ = 9.93

		local var_485_0 = {
			zh = 8.166,
			ja = 9.933
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play921041116(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["10125ui_story"]) and arg_485_1.var_.characterEffect10125ui_story == nil then
				arg_485_1.var_.characterEffect10125ui_story = arg_485_1.actors_["10125ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["10125ui_story"]) then
				if arg_485_1.var_.characterEffect10125ui_story and not isNil(arg_485_1.actors_["10125ui_story"]) then
					arg_485_1.var_.characterEffect10125ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["10125ui_story"]) and arg_485_1.var_.characterEffect10125ui_story then
				arg_485_1.var_.characterEffect10125ui_story.fillFlat = false
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action4_1")
			end

			local var_488_2 = 0
			local var_488_3 = 0.925

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_4 = arg_485_1:GetWordFromCfg(921041115)
				local var_488_5 = arg_485_1:FormatText(var_488_4.content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 36 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 36)

				if (36 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 36)) > 0 and var_488_3 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041115", "story_v_side_old_921041.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041115", "story_v_side_old_921041.awb") / 1000

					if var_488_8 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_2
					end

					if var_488_4.prefab_name ~= "" and arg_485_1.actors_[var_488_4.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_4.prefab_name].transform, "story_v_side_old_921041", "921041115", "story_v_side_old_921041.awb")

						arg_485_1:RecordAudio("921041115", var_488_9)
						arg_485_1:RecordAudio("921041115", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041115", "story_v_side_old_921041.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041115", "story_v_side_old_921041.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_10 and arg_485_1.time_ < var_488_2 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play921041116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 921041116
		arg_489_1.duration_ = 8.7

		local var_489_0 = {
			zh = 8.7,
			ja = 7.633
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play921041117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("10125ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_492_0 = 0
			local var_492_1 = 0.7

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_2 = arg_489_1:GetWordFromCfg(921041116)
				local var_492_3 = arg_489_1:FormatText(var_492_2.content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 28 <= 0 and var_492_1 or var_492_1 * (utf8.len(var_492_3) / 28)

				if (28 <= 0 and var_492_1 or var_492_1 * (utf8.len(var_492_3) / 28)) > 0 and var_492_1 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041116", "story_v_side_old_921041.awb") ~= 0 then
					local var_492_6 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041116", "story_v_side_old_921041.awb") / 1000

					if var_492_6 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_6 + var_492_0
					end

					if var_492_2.prefab_name ~= "" and arg_489_1.actors_[var_492_2.prefab_name] ~= nil then
						local var_492_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_2.prefab_name].transform, "story_v_side_old_921041", "921041116", "story_v_side_old_921041.awb")

						arg_489_1:RecordAudio("921041116", var_492_7)
						arg_489_1:RecordAudio("921041116", var_492_7)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041116", "story_v_side_old_921041.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041116", "story_v_side_old_921041.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_8 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_8 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_8

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_8 and arg_489_1.time_ < var_492_0 + var_492_8 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play921041117 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 921041117
		arg_493_1.duration_ = 6.5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play921041118(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos10125ui_story = arg_493_1.actors_["10125ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["10125ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos10125ui_story, Vector3.New(0, 100, 0), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["10125ui_story"].transform.position).z)
				arg_493_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["10125ui_story"].transform.localEulerAngles = arg_493_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["10125ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.actors_["10125ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["10125ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["10125ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["10125ui_story"].transform.position).z)
				arg_493_1.actors_["10125ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["10125ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["10125ui_story"].transform.localEulerAngles = arg_493_1.actors_["10125ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["10125ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect10125ui_story == nil then
				arg_493_1.var_.characterEffect10125ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect10125ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect10125ui_story.fillFlat = true
					arg_493_1.var_.characterEffect10125ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_2)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect10125ui_story then
				arg_493_1.var_.characterEffect10125ui_story.fillFlat = true
				arg_493_1.var_.characterEffect10125ui_story.fillRatio = 0.5
			end

			local var_496_3

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				local var_496_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_496_4 then
					var_496_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_496_4.radialBlurScale = 0
					var_496_4.radialBlurGradient = 1
					var_496_4.radialBlurIntensity = 1

					if var_496_3 then
						var_496_4.radialBlurTarget = var_496_3.transform
					end
				end
			end

			local var_496_5 = 1.4

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_5 then
				local var_496_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_496_6 then
					var_496_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_496_6.radialBlurScale = Mathf.Lerp(0, 0, (arg_493_1.time_ - 0) / var_496_5)
					var_496_6.radialBlurGradient = Mathf.Lerp(1, 1, (arg_493_1.time_ - 0) / var_496_5)
					var_496_6.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_493_1.time_ - 0) / var_496_5)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_5 and arg_493_1.time_ < 0 + var_496_5 + arg_496_0 then
				local var_496_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_496_7 then
					var_496_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_496_7.radialBlurScale = 0
					var_496_7.radialBlurGradient = 1
					var_496_7.radialBlurIntensity = 1
				end
			end

			local var_496_8 = 0

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_8 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_9 = 1.599999999999

			if var_496_8 <= arg_493_1.time_ and arg_493_1.time_ < var_496_8 + var_496_9 then
				local var_496_10 = Color.New(0, 0, 0)

				var_496_10.a = Mathf.Lerp(1, 0, (arg_493_1.time_ - var_496_8) / var_496_9)
				arg_493_1.mask_.color = var_496_10
			end

			if arg_493_1.time_ >= var_496_8 + var_496_9 and arg_493_1.time_ < var_496_8 + var_496_9 + arg_496_0 then
				local var_496_11 = Color.New(0, 0, 0)

				arg_493_1.mask_.enabled = false
				var_496_11.a = 0
				arg_493_1.mask_.color = var_496_11
			end

			local var_496_12 = 0

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_12 + arg_496_0 then
				arg_493_1.allBtn_.enabled = false
			end

			if arg_493_1.time_ >= var_496_12 + 1.73333333333333 and arg_493_1.time_ < var_496_12 + 1.73333333333333 + arg_496_0 then
				arg_493_1.allBtn_.enabled = true
			end

			if arg_493_1.frameCnt_ <= 1 then
				arg_493_1.dialog_:SetActive(false)
			end

			local var_496_13 = 1.5
			local var_496_14 = 0.65

			if 1.5 < arg_493_1.time_ and arg_493_1.time_ <= var_496_13 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0

				arg_493_1.dialog_:SetActive(true)

				arg_493_1.dialogCg_.alpha = 0

				local var_496_15 = LeanTween.value(arg_493_1.dialog_, 0, 1, 0.3)

				var_496_15:setOnUpdate(LuaHelper.FloatAction(function(arg_497_0)
					arg_493_1.dialogCg_.alpha = arg_497_0
				end))
				var_496_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_493_1.dialog_)
					var_496_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_493_1.duration_ = arg_493_1.duration_ + 0.3

				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_16 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(921041117).content)

				arg_493_1.text_.text = var_496_16

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_18 = 26 <= 0 and var_496_14 or var_496_14 * (utf8.len(var_496_16) / 26)

				if (26 <= 0 and var_496_14 or var_496_14 * (utf8.len(var_496_16) / 26)) > 0 and var_496_14 < var_496_18 then
					arg_493_1.talkMaxDuration = var_496_18
					var_496_13 = var_496_13 + 0.3

					if var_496_18 + var_496_13 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_18 + var_496_13
					end
				end

				arg_493_1.text_.text = var_496_16
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_19 = var_496_13 + 0.3
			local var_496_20 = math.max(var_496_14, arg_493_1.talkMaxDuration)

			if var_496_13 + 0.3 <= arg_493_1.time_ and arg_493_1.time_ < var_496_19 + var_496_20 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_19) / var_496_20

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_19 + var_496_20 and arg_493_1.time_ < var_496_19 + var_496_20 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play921041118 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 921041118
		arg_499_1.duration_ = 7.87

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play921041119(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 1.26666666666667 < arg_499_1.time_ and arg_499_1.time_ <= 1.26666666666667 + arg_502_0 then
				local var_502_0 = arg_499_1.bgs_.STblack

				arg_499_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_502_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_502_1 = var_502_0:GetComponent("SpriteRenderer")

				if var_502_1 and var_502_1.sprite then
					local var_502_2 = 2 * (var_502_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_502_0.transform.localScale = Vector3.New(var_502_2 / var_502_1.sprite.bounds.size.y < var_502_2 * manager.ui.mainCameraCom_.aspect / var_502_1.sprite.bounds.size.x and var_502_2 * manager.ui.mainCameraCom_.aspect / var_502_1.sprite.bounds.size.x or var_502_2 / var_502_1.sprite.bounds.size.y, var_502_2 / var_502_1.sprite.bounds.size.y < var_502_2 * manager.ui.mainCameraCom_.aspect / var_502_1.sprite.bounds.size.x and var_502_2 * manager.ui.mainCameraCom_.aspect / var_502_1.sprite.bounds.size.x or var_502_2 / var_502_1.sprite.bounds.size.y, 0)
				end

				for iter_502_0, iter_502_1 in pairs(arg_499_1.bgs_) do
					if iter_502_0 ~= "STblack" then
						iter_502_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_502_3 = 0

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_3 + arg_502_0 then
				arg_499_1.mask_.enabled = true
				arg_499_1.mask_.raycastTarget = true

				arg_499_1:SetGaussion(false)
			end

			local var_502_4 = 1.26666666666667

			if var_502_3 <= arg_499_1.time_ and arg_499_1.time_ < var_502_3 + var_502_4 then
				local var_502_5 = Color.New(1, 1, 1)

				var_502_5.a = Mathf.Lerp(0, 1, (arg_499_1.time_ - var_502_3) / var_502_4)
				arg_499_1.mask_.color = var_502_5
			end

			if arg_499_1.time_ >= var_502_3 + var_502_4 and arg_499_1.time_ < var_502_3 + var_502_4 + arg_502_0 then
				local var_502_6 = Color.New(1, 1, 1)

				var_502_6.a = 1
				arg_499_1.mask_.color = var_502_6
			end

			local var_502_7 = 1.26666666666667

			if 1.26666666666667 < arg_499_1.time_ and arg_499_1.time_ <= var_502_7 + arg_502_0 then
				arg_499_1.mask_.enabled = true
				arg_499_1.mask_.raycastTarget = true

				arg_499_1:SetGaussion(false)
			end

			local var_502_8 = 1.6

			if var_502_7 <= arg_499_1.time_ and arg_499_1.time_ < var_502_7 + var_502_8 then
				local var_502_9 = Color.New(1, 1, 1)

				var_502_9.a = Mathf.Lerp(1, 0, (arg_499_1.time_ - var_502_7) / var_502_8)
				arg_499_1.mask_.color = var_502_9
			end

			if arg_499_1.time_ >= var_502_7 + var_502_8 and arg_499_1.time_ < var_502_7 + var_502_8 + arg_502_0 then
				local var_502_10 = Color.New(1, 1, 1)

				arg_499_1.mask_.enabled = false
				var_502_10.a = 0
				arg_499_1.mask_.color = var_502_10
			end

			local var_502_11 = arg_499_1.actors_["10125ui_story"].transform

			if 1 < arg_499_1.time_ and arg_499_1.time_ <= 1 + arg_502_0 then
				arg_499_1.var_.moveOldPos10125ui_story = var_502_11.localPosition
			end

			local var_502_12 = 0.001

			if 1 <= arg_499_1.time_ and arg_499_1.time_ < 1 + var_502_12 then
				var_502_11.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10125ui_story, Vector3.New(0, 100, 0), (arg_499_1.time_ - 1) / var_502_12)
				var_502_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_11.position).x, (manager.ui.mainCamera.transform.position - var_502_11.position).y, (manager.ui.mainCamera.transform.position - var_502_11.position).z)
				var_502_11.localEulerAngles.z = 0
				var_502_11.localEulerAngles.x = 0
				var_502_11.localEulerAngles = var_502_11.localEulerAngles
			end

			if arg_499_1.time_ >= 1 + var_502_12 and arg_499_1.time_ < 1 + var_502_12 + arg_502_0 then
				var_502_11.localPosition = Vector3.New(0, 100, 0)
				var_502_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_502_11.position).x, (manager.ui.mainCamera.transform.position - var_502_11.position).y, (manager.ui.mainCamera.transform.position - var_502_11.position).z)
				var_502_11.localEulerAngles.z = 0
				var_502_11.localEulerAngles.x = 0
				var_502_11.localEulerAngles = var_502_11.localEulerAngles
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_502_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_499_1.bgmTxt_.text ~= var_502_15 and arg_499_1.bgmTxt_.text ~= "" then
						if arg_499_1.bgmTxt2_.text ~= "" then
							arg_499_1.bgmTxt_.text = arg_499_1.bgmTxt2_.text
						end

						arg_499_1.bgmTxt2_.text = var_502_15

						arg_499_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_499_1.bgmTxt_.text = var_502_15
						arg_499_1.bgmTxt2_.text = var_502_15
					end

					if arg_499_1.bgmTimer then
						arg_499_1.bgmTimer:Stop()

						arg_499_1.bgmTimer = nil
					end

					if arg_499_1.settingData.show_music_name == 1 then
						arg_499_1.musicController:SetSelectedState("show")
						arg_499_1.musicAnimator_:Play("open", 0, 0)

						if arg_499_1.settingData.music_time ~= 0 then
							arg_499_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_499_1.settingData.music_time), function()
								if arg_499_1 == nil or isNil(arg_499_1.bgmTxt_) then
									return
								end

								arg_499_1.musicController:SetSelectedState("hide")
								arg_499_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_499_1.frameCnt_ <= 1 then
				arg_499_1.dialog_:SetActive(false)
			end

			local var_502_16 = 2.86666666666667
			local var_502_17 = 0.575

			if 2.86666666666667 < arg_499_1.time_ and arg_499_1.time_ <= var_502_16 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0

				arg_499_1.dialog_:SetActive(true)

				arg_499_1.dialogCg_.alpha = 0

				local var_502_18 = LeanTween.value(arg_499_1.dialog_, 0, 1, 0.3)

				var_502_18:setOnUpdate(LuaHelper.FloatAction(function(arg_504_0)
					arg_499_1.dialogCg_.alpha = arg_504_0
				end))
				var_502_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_499_1.dialog_)
					var_502_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_499_1.duration_ = arg_499_1.duration_ + 0.3

				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_19 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(921041118).content)

				arg_499_1.text_.text = var_502_19

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_21 = 23 <= 0 and var_502_17 or var_502_17 * (utf8.len(var_502_19) / 23)

				if (23 <= 0 and var_502_17 or var_502_17 * (utf8.len(var_502_19) / 23)) > 0 and var_502_17 < var_502_21 then
					arg_499_1.talkMaxDuration = var_502_21
					var_502_16 = var_502_16 + 0.3

					if var_502_21 + var_502_16 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_21 + var_502_16
					end
				end

				arg_499_1.text_.text = var_502_19
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_22 = var_502_16 + 0.3
			local var_502_23 = math.max(var_502_17, arg_499_1.talkMaxDuration)

			if var_502_16 + 0.3 <= arg_499_1.time_ and arg_499_1.time_ < var_502_22 + var_502_23 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_22) / var_502_23

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_22 + var_502_23 and arg_499_1.time_ < var_502_22 + var_502_23 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10125ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play921041119 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 921041119
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play921041120(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0.85

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(921041119).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 34 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 34)

				if (34 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 34)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play921041120 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 921041120
		arg_510_1.duration_ = 4.23

		local var_510_0 = {
			zh = 3.4,
			ja = 4.233
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play921041121(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if arg_510_1.bgs_.B13g == nil then
				local var_513_0 = Object.Instantiate(arg_510_1.paintGo_)

				var_513_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13g")
				var_513_0.name = "B13g"
				var_513_0.transform.parent = arg_510_1.stage_.transform
				var_513_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_510_1.bgs_.B13g = var_513_0
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				local var_513_1 = arg_510_1.bgs_.B13g

				arg_510_1.bgs_.B13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_513_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_513_2 = var_513_1:GetComponent("SpriteRenderer")

				if var_513_2 and var_513_2.sprite then
					local var_513_3 = 2 * (var_513_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_513_1.transform.localScale = Vector3.New(var_513_3 / var_513_2.sprite.bounds.size.y < var_513_3 * manager.ui.mainCameraCom_.aspect / var_513_2.sprite.bounds.size.x and var_513_3 * manager.ui.mainCameraCom_.aspect / var_513_2.sprite.bounds.size.x or var_513_3 / var_513_2.sprite.bounds.size.y, var_513_3 / var_513_2.sprite.bounds.size.y < var_513_3 * manager.ui.mainCameraCom_.aspect / var_513_2.sprite.bounds.size.x and var_513_3 * manager.ui.mainCameraCom_.aspect / var_513_2.sprite.bounds.size.x or var_513_3 / var_513_2.sprite.bounds.size.y, 0)
				end

				for iter_513_0, iter_513_1 in pairs(arg_510_1.bgs_) do
					if iter_513_0 ~= "B13g" then
						iter_513_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_513_4 = 0

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_4 + arg_513_0 then
				arg_510_1.allBtn_.enabled = false
			end

			if arg_510_1.time_ >= var_513_4 + 0.3 and arg_510_1.time_ < var_513_4 + 0.3 + arg_513_0 then
				arg_510_1.allBtn_.enabled = true
			end

			local var_513_5 = 0

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_5 + arg_513_0 then
				arg_510_1.mask_.enabled = true
				arg_510_1.mask_.raycastTarget = true

				arg_510_1:SetGaussion(false)
			end

			local var_513_6 = 2

			if var_513_5 <= arg_510_1.time_ and arg_510_1.time_ < var_513_5 + var_513_6 then
				local var_513_7 = Color.New(0, 0, 0)

				var_513_7.a = Mathf.Lerp(1, 0, (arg_510_1.time_ - var_513_5) / var_513_6)
				arg_510_1.mask_.color = var_513_7
			end

			if arg_510_1.time_ >= var_513_5 + var_513_6 and arg_510_1.time_ < var_513_5 + var_513_6 + arg_513_0 then
				local var_513_8 = Color.New(0, 0, 0)

				arg_510_1.mask_.enabled = false
				var_513_8.a = 0
				arg_510_1.mask_.color = var_513_8
			end

			local var_513_9

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				local var_513_10 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_513_10 then
					var_513_10.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_513_10.radialBlurScale = 0
					var_513_10.radialBlurGradient = 1
					var_513_10.radialBlurIntensity = 1

					if var_513_9 then
						var_513_10.radialBlurTarget = var_513_9.transform
					end
				end
			end

			local var_513_11 = 1.4

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_11 then
				local var_513_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_513_12 then
					var_513_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_513_12.radialBlurScale = Mathf.Lerp(0, 0, (arg_510_1.time_ - 0) / var_513_11)
					var_513_12.radialBlurGradient = Mathf.Lerp(1, 1, (arg_510_1.time_ - 0) / var_513_11)
					var_513_12.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_510_1.time_ - 0) / var_513_11)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_11 and arg_510_1.time_ < 0 + var_513_11 + arg_513_0 then
				local var_513_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_513_13 then
					var_513_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_513_13.radialBlurScale = 0
					var_513_13.radialBlurGradient = 1
					var_513_13.radialBlurIntensity = 1
				end
			end

			if arg_510_1.frameCnt_ <= 1 then
				arg_510_1.dialog_:SetActive(false)
			end

			local var_513_14 = 2
			local var_513_15 = 0.15

			if 2 < arg_510_1.time_ and arg_510_1.time_ <= var_513_14 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0

				arg_510_1.dialog_:SetActive(true)

				arg_510_1.dialogCg_.alpha = 0

				local var_513_16 = LeanTween.value(arg_510_1.dialog_, 0, 1, 0.3)

				var_513_16:setOnUpdate(LuaHelper.FloatAction(function(arg_514_0)
					arg_510_1.dialogCg_.alpha = arg_514_0
				end))
				var_513_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_510_1.dialog_)
					var_513_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_510_1.duration_ = arg_510_1.duration_ + 0.3

				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10058")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_17 = arg_510_1:GetWordFromCfg(921041120)
				local var_513_18 = arg_510_1:FormatText(var_513_17.content)

				arg_510_1.text_.text = var_513_18

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_20 = 6 <= 0 and var_513_15 or var_513_15 * (utf8.len(var_513_18) / 6)

				if (6 <= 0 and var_513_15 or var_513_15 * (utf8.len(var_513_18) / 6)) > 0 and var_513_15 < var_513_20 then
					arg_510_1.talkMaxDuration = var_513_20
					var_513_14 = var_513_14 + 0.3

					if var_513_20 + var_513_14 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_20 + var_513_14
					end
				end

				arg_510_1.text_.text = var_513_18
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041120", "story_v_side_old_921041.awb") ~= 0 then
					local var_513_21 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041120", "story_v_side_old_921041.awb") / 1000

					if var_513_21 + var_513_14 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_21 + var_513_14
					end

					if var_513_17.prefab_name ~= "" and arg_510_1.actors_[var_513_17.prefab_name] ~= nil then
						local var_513_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_17.prefab_name].transform, "story_v_side_old_921041", "921041120", "story_v_side_old_921041.awb")

						arg_510_1:RecordAudio("921041120", var_513_22)
						arg_510_1:RecordAudio("921041120", var_513_22)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041120", "story_v_side_old_921041.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041120", "story_v_side_old_921041.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_23 = var_513_14 + 0.3
			local var_513_24 = math.max(var_513_15, arg_510_1.talkMaxDuration)

			if var_513_14 + 0.3 <= arg_510_1.time_ and arg_510_1.time_ < var_513_23 + var_513_24 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_23) / var_513_24

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_23 + var_513_24 and arg_510_1.time_ < var_513_23 + var_513_24 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play921041121 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 921041121
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play921041122(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0.25

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_1 = arg_516_1:FormatText(arg_516_1:GetWordFromCfg(921041121).content)

				arg_516_1.text_.text = var_519_1

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_3 = 10 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_1) / 10)

				if (10 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_1) / 10)) > 0 and var_519_0 < var_519_3 then
					arg_516_1.talkMaxDuration = var_519_3

					if var_519_3 + 0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_3 + 0
					end
				end

				arg_516_1.text_.text = var_519_1
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_4 = math.max(var_519_0, arg_516_1.talkMaxDuration)

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_4 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - 0) / var_519_4

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= 0 + var_519_4 and arg_516_1.time_ < 0 + var_519_4 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play921041122 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 921041122
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play921041123(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0.85

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, false)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_1 = arg_520_1:FormatText(arg_520_1:GetWordFromCfg(921041122).content)

				arg_520_1.text_.text = var_523_1

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_3 = 34 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_1) / 34)

				if (34 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_1) / 34)) > 0 and var_523_0 < var_523_3 then
					arg_520_1.talkMaxDuration = var_523_3

					if var_523_3 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_3 + 0
					end
				end

				arg_520_1.text_.text = var_523_1
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_4 = math.max(var_523_0, arg_520_1.talkMaxDuration)

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_4 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - 0) / var_523_4

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= 0 + var_523_4 and arg_520_1.time_ < 0 + var_523_4 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play921041123 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 921041123
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play921041124(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0.1

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_1 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(921041123).content)

				arg_524_1.text_.text = var_527_1

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_3 = 4 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 4)

				if (4 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_1) / 4)) > 0 and var_527_0 < var_527_3 then
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
	Play921041124 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 921041124
		arg_528_1.duration_ = 5.1

		local var_528_0 = {
			zh = 5.1,
			ja = 4.933
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
			arg_528_1.auto_ = false
		end

		function arg_528_1.playNext_(arg_530_0)
			arg_528_1.onStoryFinished_()
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if arg_528_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_531_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_528_1.stage_.transform)

				var_531_0.name = "10058ui_story"
				var_531_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_528_1.actors_["10058ui_story"] = var_531_0

				local var_531_1 = var_531_0:GetComponentInChildren(typeof(CharacterEffect))

				var_531_1.enabled = true

				local var_531_2 = GameObjectTools.GetOrAddComponent(var_531_0, typeof(DynamicBoneHelper))

				if var_531_2 then
					var_531_2:EnableDynamicBone(false)
				end

				arg_528_1:ShowWeapon(var_531_1.transform, false)

				arg_528_1.var_["10058ui_story" .. "Animator"] = var_531_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_528_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_528_1.var_["10058ui_story" .. "LipSync"] = var_531_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_531_3 = arg_528_1.actors_["10058ui_story"].transform

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.var_.moveOldPos10058ui_story = var_531_3.localPosition
			end

			local var_531_4 = 0.001

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				var_531_3.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_528_1.time_ - 0) / var_531_4)
				var_531_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_531_3.position).x, (manager.ui.mainCamera.transform.position - var_531_3.position).y, (manager.ui.mainCamera.transform.position - var_531_3.position).z)
				var_531_3.localEulerAngles.z = 0
				var_531_3.localEulerAngles.x = 0
				var_531_3.localEulerAngles = var_531_3.localEulerAngles
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				var_531_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_531_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_531_3.position).x, (manager.ui.mainCamera.transform.position - var_531_3.position).y, (manager.ui.mainCamera.transform.position - var_531_3.position).z)
				var_531_3.localEulerAngles.z = 0
				var_531_3.localEulerAngles.x = 0
				var_531_3.localEulerAngles = var_531_3.localEulerAngles
			end

			local var_531_5 = arg_528_1.actors_["10058ui_story"]

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(var_531_5) and arg_528_1.var_.characterEffect10058ui_story == nil then
				arg_528_1.var_.characterEffect10058ui_story = var_531_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_6 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_6 and not isNil(var_531_5) then
				if arg_528_1.var_.characterEffect10058ui_story and not isNil(var_531_5) then
					arg_528_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= 0 + var_531_6 and arg_528_1.time_ < 0 + var_531_6 + arg_531_0 and not isNil(var_531_5) and arg_528_1.var_.characterEffect10058ui_story then
				arg_528_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_531_8 = 0
			local var_531_9 = 0.175

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_8 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_10 = arg_528_1:GetWordFromCfg(921041124)
				local var_531_11 = arg_528_1:FormatText(var_531_10.content)

				arg_528_1.text_.text = var_531_11

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_13 = 7 <= 0 and var_531_9 or var_531_9 * (utf8.len(var_531_11) / 7)

				if (7 <= 0 and var_531_9 or var_531_9 * (utf8.len(var_531_11) / 7)) > 0 and var_531_9 < var_531_13 then
					arg_528_1.talkMaxDuration = var_531_13

					if var_531_13 + var_531_8 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_13 + var_531_8
					end
				end

				arg_528_1.text_.text = var_531_11
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921041", "921041124", "story_v_side_old_921041.awb") ~= 0 then
					local var_531_14 = manager.audio:GetVoiceLength("story_v_side_old_921041", "921041124", "story_v_side_old_921041.awb") / 1000

					if var_531_14 + var_531_8 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_14 + var_531_8
					end

					if var_531_10.prefab_name ~= "" and arg_528_1.actors_[var_531_10.prefab_name] ~= nil then
						local var_531_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_10.prefab_name].transform, "story_v_side_old_921041", "921041124", "story_v_side_old_921041.awb")

						arg_528_1:RecordAudio("921041124", var_531_15)
						arg_528_1:RecordAudio("921041124", var_531_15)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_old_921041", "921041124", "story_v_side_old_921041.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_old_921041", "921041124", "story_v_side_old_921041.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_16 = math.max(var_531_9, arg_528_1.talkMaxDuration)

			if var_531_8 <= arg_528_1.time_ and arg_528_1.time_ < var_531_8 + var_531_16 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_8) / var_531_16

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_8 + var_531_16 and arg_528_1.time_ < var_531_8 + var_531_16 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/X203I",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SP910901",
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/X203K",
		"TextureConfig/Background/X203F",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/B13g"
	},
	voices = {
		"story_v_side_old_921041.awb"
	}
}
