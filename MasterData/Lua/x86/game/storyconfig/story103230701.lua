return {
	Play323071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323071001
		arg_1_1.duration_ = 6.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.J24f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J24f")
				var_4_0.name = "J24f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J24f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J24f

				arg_1_1.bgs_.J24f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J24f" then
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun")

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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_winter_mountain", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effect34342

				if not arg_1_1.var_.effect34342 then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snowfew_keep"), manager.ui.mainCamera.transform)
					var_4_16.name = "34342"
					arg_1_1.var_.effect34342 = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9000)
				end

				var_4_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_4_16.transform.localScale = Vector3.New(var_4_16.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_4_16.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_4_16.transform.localScale.z)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 1.8
			local var_4_19 = 1.15

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(323071001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 46 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 46)

				if (46 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 46)) > 0 and var_4_19 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_18 = var_4_18 + 0.3

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_18 + 0.3
			local var_4_25 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323071002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.2

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(323071002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 48 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 48)

				if (48 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 48)) > 0 and var_12_0 < var_12_3 then
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
	Play323071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323071003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play323071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.125

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

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(323071003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 5 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 5)

				if (5 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 5)) > 0 and var_16_0 < var_16_3 then
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
	Play323071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 323071004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play323071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.95

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(323071004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 38 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 38)

				if (38 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 38)) > 0 and var_20_0 < var_20_3 then
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
	Play323071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 323071005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play323071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.3

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

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(323071005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 12 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 12)

				if (12 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 12)) > 0 and var_24_0 < var_24_3 then
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
	Play323071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 323071006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play323071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.15

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(323071006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 46 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 46)

				if (46 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 46)) > 0 and var_28_0 < var_28_3 then
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
	Play323071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 323071007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play323071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0.533333333333333 < arg_29_1.time_ and arg_29_1.time_ <= 0.533333333333333 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_146", "se_story_146_gun_foley", "")
			end

			local var_32_1 = 0
			local var_32_2 = 1.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(323071007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 53 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 53)

				if (53 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 53)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play323071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323071008
		arg_33_1.duration_ = 3.4

		local var_33_0 = {
			zh = 3.333,
			ja = 3.4
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
				arg_33_0:Play323071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1034ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1034ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1034ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1034ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1034ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1034ui_story == nil then
				arg_33_1.var_.characterEffect1034ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect1034ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1034ui_story then
				arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_36_6 = 0
			local var_36_7 = 0.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
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

				local var_36_8 = arg_33_1:GetWordFromCfg(323071008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 14 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 14)

				if (14 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 14)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071008", "story_v_out_323071.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_323071", "323071008", "story_v_out_323071.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_323071", "323071008", "story_v_out_323071.awb")

						arg_33_1:RecordAudio("323071008", var_36_13)
						arg_33_1:RecordAudio("323071008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_323071", "323071008", "story_v_out_323071.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_323071", "323071008", "story_v_out_323071.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play323071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323071009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play323071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1034ui_story"]) and arg_37_1.var_.characterEffect1034ui_story == nil then
				arg_37_1.var_.characterEffect1034ui_story = arg_37_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1034ui_story"]) then
				if arg_37_1.var_.characterEffect1034ui_story and not isNil(arg_37_1.actors_["1034ui_story"]) then
					arg_37_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1034ui_story"]) and arg_37_1.var_.characterEffect1034ui_story then
				arg_37_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
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

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(323071009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 5 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 5)

				if (5 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 5)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play323071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323071010
		arg_41_1.duration_ = 4.47

		local var_41_0 = {
			zh = 3.966,
			ja = 4.466
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
				arg_41_0:Play323071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) and arg_41_1.var_.characterEffect1034ui_story == nil then
				arg_41_1.var_.characterEffect1034ui_story = arg_41_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) then
				if arg_41_1.var_.characterEffect1034ui_story and not isNil(arg_41_1.actors_["1034ui_story"]) then
					arg_41_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1034ui_story"]) and arg_41_1.var_.characterEffect1034ui_story then
				arg_41_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_44_2 = 0
			local var_44_3 = 0.45

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
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

				local var_44_4 = arg_41_1:GetWordFromCfg(323071010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 18 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 18)

				if (18 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 18)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071010", "story_v_out_323071.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071010", "story_v_out_323071.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_323071", "323071010", "story_v_out_323071.awb")

						arg_41_1:RecordAudio("323071010", var_44_9)
						arg_41_1:RecordAudio("323071010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323071", "323071010", "story_v_out_323071.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323071", "323071010", "story_v_out_323071.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play323071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323071011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play323071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1034ui_story"]) and arg_45_1.var_.characterEffect1034ui_story == nil then
				arg_45_1.var_.characterEffect1034ui_story = arg_45_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1034ui_story"]) then
				if arg_45_1.var_.characterEffect1034ui_story and not isNil(arg_45_1.actors_["1034ui_story"]) then
					arg_45_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1034ui_story"]) and arg_45_1.var_.characterEffect1034ui_story then
				arg_45_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0.525 < arg_45_1.time_ and arg_45_1.time_ <= 0.525 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_148", "se_story_148_foley_gun", "")
			end

			local var_48_2 = 0
			local var_48_3 = 1.525

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(323071011).content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 61 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 61)

				if (61 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 61)) > 0 and var_48_3 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_7 and arg_45_1.time_ < var_48_2 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play323071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323071012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play323071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.425

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

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(323071012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 17 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 17)

				if (17 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 17)) > 0 and var_52_0 < var_52_3 then
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
	Play323071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323071013
		arg_53_1.duration_ = 2.33

		local var_53_0 = {
			zh = 1.266,
			ja = 2.333
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
				arg_53_0:Play323071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1034ui_story"]) and arg_53_1.var_.characterEffect1034ui_story == nil then
				arg_53_1.var_.characterEffect1034ui_story = arg_53_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1034ui_story"]) then
				if arg_53_1.var_.characterEffect1034ui_story and not isNil(arg_53_1.actors_["1034ui_story"]) then
					arg_53_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1034ui_story"]) and arg_53_1.var_.characterEffect1034ui_story then
				arg_53_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_56_2 = 0
			local var_56_3 = 0.1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(323071013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 4 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 4)

				if (4 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 4)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071013", "story_v_out_323071.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071013", "story_v_out_323071.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_323071", "323071013", "story_v_out_323071.awb")

						arg_53_1:RecordAudio("323071013", var_56_9)
						arg_53_1:RecordAudio("323071013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_323071", "323071013", "story_v_out_323071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_323071", "323071013", "story_v_out_323071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323071014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play323071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) and arg_57_1.var_.characterEffect1034ui_story == nil then
				arg_57_1.var_.characterEffect1034ui_story = arg_57_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) then
				if arg_57_1.var_.characterEffect1034ui_story and not isNil(arg_57_1.actors_["1034ui_story"]) then
					arg_57_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1034ui_story"]) and arg_57_1.var_.characterEffect1034ui_story then
				arg_57_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0.166666666666667 < arg_57_1.time_ and arg_57_1.time_ <= 0.166666666666667 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep_snow01", "")
			end

			local var_60_2 = 0
			local var_60_3 = 0.85

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(323071014).content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 34 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_4) / 34)

				if (34 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_4) / 34)) > 0 and var_60_3 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_7 and arg_57_1.time_ < var_60_2 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323071015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play323071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.175

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
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

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(323071015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 7 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 7)

				if (7 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 7)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323071016
		arg_65_1.duration_ = 4.47

		local var_65_0 = {
			zh = 2.466,
			ja = 4.466
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
				arg_65_0:Play323071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.actors_["10171ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10171ui_story"))) then
				local var_68_0 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_65_1.stage_.transform)

				var_68_0.name = "10171ui_story"
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["10171ui_story"] = var_68_0

				local var_68_1 = var_68_0:GetComponentInChildren(typeof(CharacterEffect))

				var_68_1.enabled = true

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end

				arg_65_1:ShowWeapon(var_68_1.transform, false)

				arg_65_1.var_["10171ui_story" .. "Animator"] = var_68_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_65_1.var_["10171ui_story" .. "Animator"].applyRootMotion = true
				arg_65_1.var_["10171ui_story" .. "LipSync"] = var_68_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_68_3 = arg_65_1.actors_["10171ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10171ui_story = var_68_3.localPosition

				local var_68_4 = GameObjectTools.GetOrAddComponent(var_68_3.gameObject, typeof(DynamicBoneHelper))

				if var_68_4 then
					var_68_4:EnableDynamicBone(false)
				end
			end

			local var_68_5 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_65_1.time_ - 0) / var_68_5)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles

				local var_68_6 = GameObjectTools.GetOrAddComponent(var_68_3.gameObject, typeof(DynamicBoneHelper))

				if var_68_6 then
					var_68_6:EnableDynamicBone(true)
				end
			end

			local var_68_7 = arg_65_1.actors_["10171ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.characterEffect10171ui_story == nil then
				arg_65_1.var_.characterEffect10171ui_story = var_68_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_8 and not isNil(var_68_7) then
				if arg_65_1.var_.characterEffect10171ui_story and not isNil(var_68_7) then
					arg_65_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_8 and arg_65_1.time_ < 0 + var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.characterEffect10171ui_story then
				arg_65_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_68_10 = 0
			local var_68_11 = 0.25

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_12 = arg_65_1:GetWordFromCfg(323071016)
				local var_68_13 = arg_65_1:FormatText(var_68_12.content)

				arg_65_1.text_.text = var_68_13

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 10 <= 0 and var_68_11 or var_68_11 * (utf8.len(var_68_13) / 10)

				if (10 <= 0 and var_68_11 or var_68_11 * (utf8.len(var_68_13) / 10)) > 0 and var_68_11 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_13
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071016", "story_v_out_323071.awb") ~= 0 then
					local var_68_16 = manager.audio:GetVoiceLength("story_v_out_323071", "323071016", "story_v_out_323071.awb") / 1000

					if var_68_16 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_10
					end

					if var_68_12.prefab_name ~= "" and arg_65_1.actors_[var_68_12.prefab_name] ~= nil then
						local var_68_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_12.prefab_name].transform, "story_v_out_323071", "323071016", "story_v_out_323071.awb")

						arg_65_1:RecordAudio("323071016", var_68_17)
						arg_65_1:RecordAudio("323071016", var_68_17)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_323071", "323071016", "story_v_out_323071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_323071", "323071016", "story_v_out_323071.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_11, arg_65_1.talkMaxDuration)

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_10) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_10 + var_68_18 and arg_65_1.time_ < var_68_10 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
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
	Play323071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323071017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10171ui_story"]) and arg_69_1.var_.characterEffect10171ui_story == nil then
				arg_69_1.var_.characterEffect10171ui_story = arg_69_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10171ui_story"]) then
				if arg_69_1.var_.characterEffect10171ui_story and not isNil(arg_69_1.actors_["10171ui_story"]) then
					arg_69_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10171ui_story"]) and arg_69_1.var_.characterEffect10171ui_story then
				arg_69_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.9

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(323071017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 36 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 36)

				if (36 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 36)) > 0 and var_72_2 < var_72_5 then
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
	Play323071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323071018
		arg_73_1.duration_ = 3.1

		local var_73_0 = {
			zh = 1.466,
			ja = 3.1
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
				arg_73_0:Play323071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10171ui_story"]) and arg_73_1.var_.characterEffect10171ui_story == nil then
				arg_73_1.var_.characterEffect10171ui_story = arg_73_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10171ui_story"]) then
				if arg_73_1.var_.characterEffect10171ui_story and not isNil(arg_73_1.actors_["10171ui_story"]) then
					arg_73_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10171ui_story"]) and arg_73_1.var_.characterEffect10171ui_story then
				arg_73_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_76_2 = 0
			local var_76_3 = 0.175

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(323071018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 7 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 7)

				if (7 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 7)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071018", "story_v_out_323071.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071018", "story_v_out_323071.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_323071", "323071018", "story_v_out_323071.awb")

						arg_73_1:RecordAudio("323071018", var_76_9)
						arg_73_1:RecordAudio("323071018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323071", "323071018", "story_v_out_323071.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323071", "323071018", "story_v_out_323071.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play323071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323071019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play323071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10171ui_story"]) and arg_77_1.var_.characterEffect10171ui_story == nil then
				arg_77_1.var_.characterEffect10171ui_story = arg_77_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10171ui_story"]) then
				if arg_77_1.var_.characterEffect10171ui_story and not isNil(arg_77_1.actors_["10171ui_story"]) then
					arg_77_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10171ui_story"]) and arg_77_1.var_.characterEffect10171ui_story then
				arg_77_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.075

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

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(323071019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 3 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 3)

				if (3 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 3)) > 0 and var_80_2 < var_80_5 then
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
	Play323071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323071020
		arg_81_1.duration_ = 3.1

		local var_81_0 = {
			zh = 2.966,
			ja = 3.1
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
				arg_81_0:Play323071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10171ui_story"]) and arg_81_1.var_.characterEffect10171ui_story == nil then
				arg_81_1.var_.characterEffect10171ui_story = arg_81_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10171ui_story"]) then
				if arg_81_1.var_.characterEffect10171ui_story and not isNil(arg_81_1.actors_["10171ui_story"]) then
					arg_81_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10171ui_story"]) and arg_81_1.var_.characterEffect10171ui_story then
				arg_81_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action43130")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_84_2 = 0
			local var_84_3 = 0.4

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(323071020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 16 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 16)

				if (16 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 16)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071020", "story_v_out_323071.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071020", "story_v_out_323071.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_323071", "323071020", "story_v_out_323071.awb")

						arg_81_1:RecordAudio("323071020", var_84_9)
						arg_81_1:RecordAudio("323071020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323071", "323071020", "story_v_out_323071.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323071", "323071020", "story_v_out_323071.awb")
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
	Play323071021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323071021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play323071022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10171ui_story"]) and arg_85_1.var_.characterEffect10171ui_story == nil then
				arg_85_1.var_.characterEffect10171ui_story = arg_85_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10171ui_story"]) then
				if arg_85_1.var_.characterEffect10171ui_story and not isNil(arg_85_1.actors_["10171ui_story"]) then
					arg_85_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10171ui_story"]) and arg_85_1.var_.characterEffect10171ui_story then
				arg_85_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.7

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
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

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(323071021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 28 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 28)

				if (28 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 28)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play323071022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323071022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323071023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.625

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
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

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(323071022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 25 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 25)

				if (25 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 25)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323071023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323071023
		arg_93_1.duration_ = 5.6

		local var_93_0 = {
			zh = 2.1,
			ja = 5.6
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
				arg_93_0:Play323071024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10171ui_story"]) and arg_93_1.var_.characterEffect10171ui_story == nil then
				arg_93_1.var_.characterEffect10171ui_story = arg_93_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10171ui_story"]) then
				if arg_93_1.var_.characterEffect10171ui_story and not isNil(arg_93_1.actors_["10171ui_story"]) then
					arg_93_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10171ui_story"]) and arg_93_1.var_.characterEffect10171ui_story then
				arg_93_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_96_2 = 0
			local var_96_3 = 0.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_4 = arg_93_1:GetWordFromCfg(323071023)
				local var_96_5 = arg_93_1:FormatText(var_96_4.content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 8 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 8)

				if (8 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_5) / 8)) > 0 and var_96_3 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071023", "story_v_out_323071.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071023", "story_v_out_323071.awb") / 1000

					if var_96_8 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_2
					end

					if var_96_4.prefab_name ~= "" and arg_93_1.actors_[var_96_4.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_4.prefab_name].transform, "story_v_out_323071", "323071023", "story_v_out_323071.awb")

						arg_93_1:RecordAudio("323071023", var_96_9)
						arg_93_1:RecordAudio("323071023", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323071", "323071023", "story_v_out_323071.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323071", "323071023", "story_v_out_323071.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_10 and arg_93_1.time_ < var_96_2 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play323071024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323071024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play323071025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10171ui_story"]) and arg_97_1.var_.characterEffect10171ui_story == nil then
				arg_97_1.var_.characterEffect10171ui_story = arg_97_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10171ui_story"]) then
				if arg_97_1.var_.characterEffect10171ui_story and not isNil(arg_97_1.actors_["10171ui_story"]) then
					arg_97_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10171ui_story"]) and arg_97_1.var_.characterEffect10171ui_story then
				arg_97_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.075

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(323071024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 3 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 3)

				if (3 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 3)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play323071025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323071025
		arg_101_1.duration_ = 4

		local var_101_0 = {
			zh = 3,
			ja = 4
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
				arg_101_0:Play323071026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10171ui_story"]) and arg_101_1.var_.characterEffect10171ui_story == nil then
				arg_101_1.var_.characterEffect10171ui_story = arg_101_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10171ui_story"]) then
				if arg_101_1.var_.characterEffect10171ui_story and not isNil(arg_101_1.actors_["10171ui_story"]) then
					arg_101_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10171ui_story"]) and arg_101_1.var_.characterEffect10171ui_story then
				arg_101_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_104_2 = 0
			local var_104_3 = 0.35

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(323071025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 14 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 14)

				if (14 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 14)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071025", "story_v_out_323071.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071025", "story_v_out_323071.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_323071", "323071025", "story_v_out_323071.awb")

						arg_101_1:RecordAudio("323071025", var_104_9)
						arg_101_1:RecordAudio("323071025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_323071", "323071025", "story_v_out_323071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_323071", "323071025", "story_v_out_323071.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play323071026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323071026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play323071027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10171ui_story"]) and arg_105_1.var_.characterEffect10171ui_story == nil then
				arg_105_1.var_.characterEffect10171ui_story = arg_105_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10171ui_story"]) then
				if arg_105_1.var_.characterEffect10171ui_story and not isNil(arg_105_1.actors_["10171ui_story"]) then
					arg_105_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10171ui_story"]) and arg_105_1.var_.characterEffect10171ui_story then
				arg_105_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.9

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(323071026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 36 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 36)

				if (36 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 36)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play323071027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323071027
		arg_109_1.duration_ = 5.3

		local var_109_0 = {
			zh = 2.6,
			ja = 5.3
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play323071028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10171ui_story"]) and arg_109_1.var_.characterEffect10171ui_story == nil then
				arg_109_1.var_.characterEffect10171ui_story = arg_109_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10171ui_story"]) then
				if arg_109_1.var_.characterEffect10171ui_story and not isNil(arg_109_1.actors_["10171ui_story"]) then
					arg_109_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10171ui_story"]) and arg_109_1.var_.characterEffect10171ui_story then
				arg_109_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_112_2 = 0
			local var_112_3 = 0.3

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(323071027)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 12 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 12)

				if (12 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_5) / 12)) > 0 and var_112_3 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071027", "story_v_out_323071.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071027", "story_v_out_323071.awb") / 1000

					if var_112_8 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_2
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_323071", "323071027", "story_v_out_323071.awb")

						arg_109_1:RecordAudio("323071027", var_112_9)
						arg_109_1:RecordAudio("323071027", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_323071", "323071027", "story_v_out_323071.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_323071", "323071027", "story_v_out_323071.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play323071028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323071028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play323071029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10171ui_story"]) and arg_113_1.var_.characterEffect10171ui_story == nil then
				arg_113_1.var_.characterEffect10171ui_story = arg_113_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10171ui_story"]) then
				if arg_113_1.var_.characterEffect10171ui_story and not isNil(arg_113_1.actors_["10171ui_story"]) then
					arg_113_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10171ui_story"]) and arg_113_1.var_.characterEffect10171ui_story then
				arg_113_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.25

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
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

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(323071028).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 10 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 10)

				if (10 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 10)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play323071029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323071029
		arg_117_1.duration_ = 11.1

		local var_117_0 = {
			zh = 7.266,
			ja = 11.1
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
				arg_117_0:Play323071030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10171ui_story"]) and arg_117_1.var_.characterEffect10171ui_story == nil then
				arg_117_1.var_.characterEffect10171ui_story = arg_117_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10171ui_story"]) then
				if arg_117_1.var_.characterEffect10171ui_story and not isNil(arg_117_1.actors_["10171ui_story"]) then
					arg_117_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10171ui_story"]) and arg_117_1.var_.characterEffect10171ui_story then
				arg_117_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_120_2 = 0
			local var_120_3 = 1.125

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(323071029)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 45 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 45)

				if (45 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 45)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071029", "story_v_out_323071.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071029", "story_v_out_323071.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_323071", "323071029", "story_v_out_323071.awb")

						arg_117_1:RecordAudio("323071029", var_120_9)
						arg_117_1:RecordAudio("323071029", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_323071", "323071029", "story_v_out_323071.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_323071", "323071029", "story_v_out_323071.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play323071030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 323071030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play323071031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10171ui_story"]) and arg_121_1.var_.characterEffect10171ui_story == nil then
				arg_121_1.var_.characterEffect10171ui_story = arg_121_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10171ui_story"]) then
				if arg_121_1.var_.characterEffect10171ui_story and not isNil(arg_121_1.actors_["10171ui_story"]) then
					arg_121_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10171ui_story"]) and arg_121_1.var_.characterEffect10171ui_story then
				arg_121_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_124_1 = 0
			local var_124_2 = 0.25

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
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

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(323071030).content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 10 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 10)

				if (10 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_3) / 10)) > 0 and var_124_2 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_6 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_6 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_6

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_6 and arg_121_1.time_ < var_124_1 + var_124_6 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play323071031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 323071031
		arg_125_1.duration_ = 1.03

		local var_125_0 = {
			zh = 1,
			ja = 1.033
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play323071032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10171ui_story"]) and arg_125_1.var_.characterEffect10171ui_story == nil then
				arg_125_1.var_.characterEffect10171ui_story = arg_125_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10171ui_story"]) then
				if arg_125_1.var_.characterEffect10171ui_story and not isNil(arg_125_1.actors_["10171ui_story"]) then
					arg_125_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10171ui_story"]) and arg_125_1.var_.characterEffect10171ui_story then
				arg_125_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_128_2 = 0
			local var_128_3 = 0.075

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_2 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_4 = arg_125_1:GetWordFromCfg(323071031)
				local var_128_5 = arg_125_1:FormatText(var_128_4.content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 3 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 3)

				if (3 <= 0 and var_128_3 or var_128_3 * (utf8.len(var_128_5) / 3)) > 0 and var_128_3 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_2
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071031", "story_v_out_323071.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071031", "story_v_out_323071.awb") / 1000

					if var_128_8 + var_128_2 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_2
					end

					if var_128_4.prefab_name ~= "" and arg_125_1.actors_[var_128_4.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_4.prefab_name].transform, "story_v_out_323071", "323071031", "story_v_out_323071.awb")

						arg_125_1:RecordAudio("323071031", var_128_9)
						arg_125_1:RecordAudio("323071031", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_323071", "323071031", "story_v_out_323071.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_323071", "323071031", "story_v_out_323071.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_3, arg_125_1.talkMaxDuration)

			if var_128_2 <= arg_125_1.time_ and arg_125_1.time_ < var_128_2 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_2) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_2 + var_128_10 and arg_125_1.time_ < var_128_2 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play323071032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 323071032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play323071033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10171ui_story"]) and arg_129_1.var_.characterEffect10171ui_story == nil then
				arg_129_1.var_.characterEffect10171ui_story = arg_129_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10171ui_story"]) then
				if arg_129_1.var_.characterEffect10171ui_story and not isNil(arg_129_1.actors_["10171ui_story"]) then
					arg_129_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10171ui_story"]) and arg_129_1.var_.characterEffect10171ui_story then
				arg_129_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.75

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
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

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(323071032).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 30 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 30)

				if (30 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 30)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play323071033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 323071033
		arg_133_1.duration_ = 9.43

		local var_133_0 = {
			zh = 4.266,
			ja = 9.433
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
				arg_133_0:Play323071034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10171ui_story"]) and arg_133_1.var_.characterEffect10171ui_story == nil then
				arg_133_1.var_.characterEffect10171ui_story = arg_133_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10171ui_story"]) then
				if arg_133_1.var_.characterEffect10171ui_story and not isNil(arg_133_1.actors_["10171ui_story"]) then
					arg_133_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10171ui_story"]) and arg_133_1.var_.characterEffect10171ui_story then
				arg_133_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_136_2 = 0
			local var_136_3 = 0.575

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:GetWordFromCfg(323071033)
				local var_136_5 = arg_133_1:FormatText(var_136_4.content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 23 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 23)

				if (23 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_5) / 23)) > 0 and var_136_3 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071033", "story_v_out_323071.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071033", "story_v_out_323071.awb") / 1000

					if var_136_8 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_2
					end

					if var_136_4.prefab_name ~= "" and arg_133_1.actors_[var_136_4.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_4.prefab_name].transform, "story_v_out_323071", "323071033", "story_v_out_323071.awb")

						arg_133_1:RecordAudio("323071033", var_136_9)
						arg_133_1:RecordAudio("323071033", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_323071", "323071033", "story_v_out_323071.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_323071", "323071033", "story_v_out_323071.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_10 and arg_133_1.time_ < var_136_2 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play323071034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 323071034
		arg_137_1.duration_ = 1

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"

			SetActive(arg_137_1.choicesGo_, true)

			for iter_138_0, iter_138_1 in ipairs(arg_137_1.choices_) do
				SetActive(iter_138_1.go, iter_138_0 <= 2)
			end

			arg_137_1.choices_[1].txt.text = arg_137_1:FormatText(StoryChoiceCfg[1563].name)
			arg_137_1.choices_[2].txt.text = arg_137_1:FormatText(StoryChoiceCfg[1564].name)
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play323071035(arg_137_1)
			end

			if arg_139_0 == 2 then
				arg_137_0:Play323071035(arg_137_1)
			end

			arg_137_1:RecordChoiceLog(323071034, 1563, 1564)
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10171ui_story"]) and arg_137_1.var_.characterEffect10171ui_story == nil then
				arg_137_1.var_.characterEffect10171ui_story = arg_137_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10171ui_story"]) then
				if arg_137_1.var_.characterEffect10171ui_story and not isNil(arg_137_1.actors_["10171ui_story"]) then
					arg_137_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10171ui_story"]) and arg_137_1.var_.characterEffect10171ui_story then
				arg_137_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play323071035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 323071035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play323071036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10171ui_story = arg_141_1.actors_["10171ui_story"].transform.localPosition

				local var_144_0 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_0 then
					var_144_0:EnableDynamicBone(false)
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_1)
				arg_141_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10171ui_story"].transform.position).z)
				arg_141_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10171ui_story"].transform.localEulerAngles = arg_141_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10171ui_story"].transform.position).z)
				arg_141_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10171ui_story"].transform.localEulerAngles = arg_141_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_144_2 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(true)
				end
			end

			local var_144_3 = 0
			local var_144_4 = 1.6

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_5 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(323071035).content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 64 <= 0 and var_144_4 or var_144_4 * (utf8.len(var_144_5) / 64)

				if (64 <= 0 and var_144_4 or var_144_4 * (utf8.len(var_144_5) / 64)) > 0 and var_144_4 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_3 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_3
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_4, arg_141_1.talkMaxDuration)

			if var_144_3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_3 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_3) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_3 + var_144_8 and arg_141_1.time_ < var_144_3 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play323071036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 323071036
		arg_145_1.duration_ = 7.6

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play323071037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_9000

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				local var_148_0 = arg_145_1.var_.effect3213

				if not arg_145_1.var_.effect3213 then
					var_148_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_out"), manager.ui.mainCamera.transform)
					var_148_0.name = "3213"
					arg_145_1.var_.effect3213 = var_148_0
				else
					var_148_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_148_0.transform.localPosition = Vector3.New(0, 0, -2.79)
				var_148_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_148_2 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_148_0.transform.localScale = Vector3.New(var_148_0.transform.localScale.x * var_148_2, var_148_0.transform.localScale.y * var_148_2, var_148_0.transform.localScale.z * var_148_2)
			end

			if 3.775 < arg_145_1.time_ and arg_145_1.time_ <= 3.775 + arg_148_0 then
				if arg_145_1.var_.effect3213 then
					Object.Destroy(arg_145_1.var_.effect3213)

					arg_145_1.var_.effect3213 = nil
				end
			end

			if 0.533333333333333 < arg_145_1.time_ and arg_145_1.time_ <= 0.533333333333333 + arg_148_0 then
				local var_148_4 = arg_145_1.var_.effect6666

				if not arg_145_1.var_.effect6666 then
					var_148_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snowfast_out"), manager.ui.mainCamera.transform)
					var_148_4.name = "6666"
					arg_145_1.var_.effect6666 = var_148_4
				else
					var_148_4.transform:SetParent(var_148_9000)
				end

				var_148_4.transform.localPosition = Vector3.New(0, 0, -2.79)
				var_148_4.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_148_6 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_148_4.transform.localScale = Vector3.New(var_148_4.transform.localScale.x * var_148_6, var_148_4.transform.localScale.y * var_148_6, var_148_4.transform.localScale.z * var_148_6)
			end

			if 3.5 < arg_145_1.time_ and arg_145_1.time_ <= 3.5 + arg_148_0 then
				if arg_145_1.var_.effect6666 then
					Object.Destroy(arg_145_1.var_.effect6666)

					arg_145_1.var_.effect6666 = nil
				end
			end

			local var_148_8 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_8 + 3.2 and arg_145_1.time_ < var_148_8 + 3.2 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			local var_148_9 = 0.3

			if 0.3 < arg_145_1.time_ and arg_145_1.time_ <= var_148_9 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_10 = 0.7

			if var_148_9 <= arg_145_1.time_ and arg_145_1.time_ < var_148_9 + var_148_10 then
				local var_148_11 = Color.New(1, 1, 1)

				var_148_11.a = Mathf.Lerp(1, 0, (arg_145_1.time_ - var_148_9) / var_148_10)
				arg_145_1.mask_.color = var_148_11
			end

			if arg_145_1.time_ >= var_148_9 + var_148_10 and arg_145_1.time_ < var_148_9 + var_148_10 + arg_148_0 then
				local var_148_12 = Color.New(1, 1, 1)

				arg_145_1.mask_.enabled = false
				var_148_12.a = 0
				arg_145_1.mask_.color = var_148_12
			end

			if 0.166666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 0.166666666666667 + arg_148_0 then
				arg_145_1:AudioAction("play", "effect", "se_story_148", "se_story_148_wind", "")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				if arg_145_1.var_.effect34342 then
					Object.Destroy(arg_145_1.var_.effect34342)

					arg_145_1.var_.effect34342 = nil
				end
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_15 = 2.6
			local var_148_16 = 1.175

			if 2.6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_17 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_17:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(323071036).content)

				arg_145_1.text_.text = var_148_18

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 47 <= 0 and var_148_16 or var_148_16 * (utf8.len(var_148_18) / 47)

				if (47 <= 0 and var_148_16 or var_148_16 * (utf8.len(var_148_18) / 47)) > 0 and var_148_16 < var_148_20 then
					arg_145_1.talkMaxDuration = var_148_20
					var_148_15 = var_148_15 + 0.3

					if var_148_20 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_18
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_21 = var_148_15 + 0.3
			local var_148_22 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_21 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_21) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_21 + var_148_22 and arg_145_1.time_ < var_148_21 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play323071037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 323071037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play323071038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 1.1

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

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(323071037).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 44 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 44)

				if (44 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 44)) > 0 and var_154_0 < var_154_3 then
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
	Play323071038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 323071038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play323071039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.3

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(323071038).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 12 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 12)

				if (12 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 12)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play323071039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 323071039
		arg_159_1.duration_ = 1.77

		local var_159_0 = {
			zh = 1.766,
			ja = 1.133
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
				arg_159_0:Play323071040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if arg_159_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_162_0 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_159_1.stage_.transform)

				var_162_0.name = "1070ui_story"
				var_162_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_["1070ui_story"] = var_162_0

				local var_162_1 = var_162_0:GetComponentInChildren(typeof(CharacterEffect))

				var_162_1.enabled = true

				local var_162_2 = GameObjectTools.GetOrAddComponent(var_162_0, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(false)
				end

				arg_159_1:ShowWeapon(var_162_1.transform, false)

				arg_159_1.var_["1070ui_story" .. "Animator"] = var_162_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_159_1.var_["1070ui_story" .. "Animator"].applyRootMotion = true
				arg_159_1.var_["1070ui_story" .. "LipSync"] = var_162_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_162_3 = arg_159_1.actors_["1070ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect1070ui_story == nil then
				arg_159_1.var_.characterEffect1070ui_story = var_162_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_4 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 and not isNil(var_162_3) then
				if arg_159_1.var_.characterEffect1070ui_story and not isNil(var_162_3) then
					arg_159_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect1070ui_story then
				arg_159_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_162_6 = 0
			local var_162_7 = 0.075

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_5")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_8 = arg_159_1:GetWordFromCfg(323071039)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 3 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 3)

				if (3 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 3)) > 0 and var_162_7 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071039", "story_v_out_323071.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_323071", "323071039", "story_v_out_323071.awb") / 1000

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_323071", "323071039", "story_v_out_323071.awb")

						arg_159_1:RecordAudio("323071039", var_162_13)
						arg_159_1:RecordAudio("323071039", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_323071", "323071039", "story_v_out_323071.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_323071", "323071039", "story_v_out_323071.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play323071040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 323071040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play323071041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1070ui_story"]) and arg_163_1.var_.characterEffect1070ui_story == nil then
				arg_163_1.var_.characterEffect1070ui_story = arg_163_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1070ui_story"]) then
				if arg_163_1.var_.characterEffect1070ui_story and not isNil(arg_163_1.actors_["1070ui_story"]) then
					arg_163_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1070ui_story"]) and arg_163_1.var_.characterEffect1070ui_story then
				arg_163_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0.466666666666667 < arg_163_1.time_ and arg_163_1.time_ <= 0.466666666666667 + arg_166_0 then
				arg_163_1:AudioAction("play", "effect", "se_story_148", "se_story_148_snow", "")
			end

			local var_166_2 = 0
			local var_166_3 = 1.225

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(323071040).content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 49 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_4) / 49)

				if (49 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_4) / 49)) > 0 and var_166_3 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_7 and arg_163_1.time_ < var_166_2 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play323071041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 323071041
		arg_167_1.duration_ = 3.23

		local var_167_0 = {
			zh = 1.999999999999,
			ja = 3.233
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play323071042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10171ui_story = arg_167_1.actors_["10171ui_story"].transform.localPosition

				local var_170_0 = GameObjectTools.GetOrAddComponent(arg_167_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_170_0 then
					var_170_0:EnableDynamicBone(false)
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_167_1.time_ - 0) / var_170_1)
				arg_167_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10171ui_story"].transform.position).z)
				arg_167_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10171ui_story"].transform.localEulerAngles = arg_167_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_167_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10171ui_story"].transform.position).z)
				arg_167_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10171ui_story"].transform.localEulerAngles = arg_167_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_170_2 = GameObjectTools.GetOrAddComponent(arg_167_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(true)
				end
			end

			local var_170_3 = arg_167_1.actors_["10171ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect10171ui_story == nil then
				arg_167_1.var_.characterEffect10171ui_story = var_170_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_4 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 and not isNil(var_170_3) then
				if arg_167_1.var_.characterEffect10171ui_story and not isNil(var_170_3) then
					arg_167_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect10171ui_story then
				arg_167_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_170_6 = 0
			local var_170_7 = 0.2

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_8 = arg_167_1:GetWordFromCfg(323071041)
				local var_170_9 = arg_167_1:FormatText(var_170_8.content)

				arg_167_1.text_.text = var_170_9

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 8 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 8)

				if (8 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 8)) > 0 and var_170_7 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_9
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071041", "story_v_out_323071.awb") ~= 0 then
					local var_170_12 = manager.audio:GetVoiceLength("story_v_out_323071", "323071041", "story_v_out_323071.awb") / 1000

					if var_170_12 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_6
					end

					if var_170_8.prefab_name ~= "" and arg_167_1.actors_[var_170_8.prefab_name] ~= nil then
						local var_170_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_8.prefab_name].transform, "story_v_out_323071", "323071041", "story_v_out_323071.awb")

						arg_167_1:RecordAudio("323071041", var_170_13)
						arg_167_1:RecordAudio("323071041", var_170_13)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_323071", "323071041", "story_v_out_323071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_323071", "323071041", "story_v_out_323071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play323071042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 323071042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play323071043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10171ui_story"]) and arg_171_1.var_.characterEffect10171ui_story == nil then
				arg_171_1.var_.characterEffect10171ui_story = arg_171_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10171ui_story"]) then
				if arg_171_1.var_.characterEffect10171ui_story and not isNil(arg_171_1.actors_["10171ui_story"]) then
					arg_171_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10171ui_story"]) and arg_171_1.var_.characterEffect10171ui_story then
				arg_171_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.85

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(323071042).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 34 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 34)

				if (34 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 34)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play323071043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 323071043
		arg_175_1.duration_ = 3.97

		local var_175_0 = {
			zh = 3.966,
			ja = 3.366
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
				arg_175_0:Play323071044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1070ui_story"]) and arg_175_1.var_.characterEffect1070ui_story == nil then
				arg_175_1.var_.characterEffect1070ui_story = arg_175_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1070ui_story"]) then
				if arg_175_1.var_.characterEffect1070ui_story and not isNil(arg_175_1.actors_["1070ui_story"]) then
					arg_175_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1070ui_story"]) and arg_175_1.var_.characterEffect1070ui_story then
				arg_175_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_178_2 = 0
			local var_178_3 = 0.15

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_7")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_4 = arg_175_1:GetWordFromCfg(323071043)
				local var_178_5 = arg_175_1:FormatText(var_178_4.content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 6 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 6)

				if (6 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 6)) > 0 and var_178_3 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_2
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071043", "story_v_out_323071.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071043", "story_v_out_323071.awb") / 1000

					if var_178_8 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_2
					end

					if var_178_4.prefab_name ~= "" and arg_175_1.actors_[var_178_4.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_4.prefab_name].transform, "story_v_out_323071", "323071043", "story_v_out_323071.awb")

						arg_175_1:RecordAudio("323071043", var_178_9)
						arg_175_1:RecordAudio("323071043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_323071", "323071043", "story_v_out_323071.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_323071", "323071043", "story_v_out_323071.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_3, arg_175_1.talkMaxDuration)

			if var_178_2 <= arg_175_1.time_ and arg_175_1.time_ < var_178_2 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_2) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_2 + var_178_10 and arg_175_1.time_ < var_178_2 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play323071044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 323071044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play323071045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1070ui_story"]) and arg_179_1.var_.characterEffect1070ui_story == nil then
				arg_179_1.var_.characterEffect1070ui_story = arg_179_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1070ui_story"]) then
				if arg_179_1.var_.characterEffect1070ui_story and not isNil(arg_179_1.actors_["1070ui_story"]) then
					arg_179_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1070ui_story"]) and arg_179_1.var_.characterEffect1070ui_story then
				arg_179_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_182_1 = arg_179_1.actors_["10171ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10171ui_story = var_182_1.localPosition

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_1.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end
			end

			local var_182_3 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 then
				var_182_1.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_3)
				var_182_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_1.position).x, (manager.ui.mainCamera.transform.position - var_182_1.position).y, (manager.ui.mainCamera.transform.position - var_182_1.position).z)
				var_182_1.localEulerAngles.z = 0
				var_182_1.localEulerAngles.x = 0
				var_182_1.localEulerAngles = var_182_1.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 then
				var_182_1.localPosition = Vector3.New(0, 100, 0)
				var_182_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_1.position).x, (manager.ui.mainCamera.transform.position - var_182_1.position).y, (manager.ui.mainCamera.transform.position - var_182_1.position).z)
				var_182_1.localEulerAngles.z = 0
				var_182_1.localEulerAngles.x = 0
				var_182_1.localEulerAngles = var_182_1.localEulerAngles

				local var_182_4 = GameObjectTools.GetOrAddComponent(var_182_1.gameObject, typeof(DynamicBoneHelper))

				if var_182_4 then
					var_182_4:EnableDynamicBone(true)
				end
			end

			local var_182_5 = 0
			local var_182_6 = 0.925

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(323071044).content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 37 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_7) / 37)

				if (37 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_7) / 37)) > 0 and var_182_6 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_10 and arg_179_1.time_ < var_182_5 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play323071045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 323071045
		arg_183_1.duration_ = 7.7

		local var_183_0 = {
			zh = 7.366,
			ja = 7.7
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
				arg_183_0:Play323071046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10171ui_story = arg_183_1.actors_["10171ui_story"].transform.localPosition

				local var_186_0 = GameObjectTools.GetOrAddComponent(arg_183_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_186_0 then
					var_186_0:EnableDynamicBone(false)
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_1)
				arg_183_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10171ui_story"].transform.position).z)
				arg_183_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10171ui_story"].transform.localEulerAngles = arg_183_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10171ui_story"].transform.position).z)
				arg_183_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10171ui_story"].transform.localEulerAngles = arg_183_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_186_2 = GameObjectTools.GetOrAddComponent(arg_183_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(true)
				end
			end

			local var_186_3 = arg_183_1.actors_["1070ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1070ui_story = var_186_3.localPosition
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_3.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_183_1.time_ - 0) / var_186_4)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			local var_186_5 = arg_183_1.actors_["1070ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1070ui_story == nil then
				arg_183_1.var_.characterEffect1070ui_story = var_186_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_6 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 and not isNil(var_186_5) then
				if arg_183_1.var_.characterEffect1070ui_story and not isNil(var_186_5) then
					arg_183_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1070ui_story then
				arg_183_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_186_8 = 0
			local var_186_9 = 0.65

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(323071045)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 26 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 26)

				if (26 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 26)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071045", "story_v_out_323071.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_323071", "323071045", "story_v_out_323071.awb") / 1000

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end

					if var_186_10.prefab_name ~= "" and arg_183_1.actors_[var_186_10.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_10.prefab_name].transform, "story_v_out_323071", "323071045", "story_v_out_323071.awb")

						arg_183_1:RecordAudio("323071045", var_186_15)
						arg_183_1:RecordAudio("323071045", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_323071", "323071045", "story_v_out_323071.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_323071", "323071045", "story_v_out_323071.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_16 and arg_183_1.time_ < var_186_8 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play323071046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 323071046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play323071047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1070ui_story"]) and arg_187_1.var_.characterEffect1070ui_story == nil then
				arg_187_1.var_.characterEffect1070ui_story = arg_187_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1070ui_story"]) then
				if arg_187_1.var_.characterEffect1070ui_story and not isNil(arg_187_1.actors_["1070ui_story"]) then
					arg_187_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1070ui_story"]) and arg_187_1.var_.characterEffect1070ui_story then
				arg_187_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.5

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
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

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(323071046).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 20 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 20)

				if (20 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 20)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play323071047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 323071047
		arg_191_1.duration_ = 10.3

		local var_191_0 = {
			zh = 6.666,
			ja = 10.3
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
				arg_191_0:Play323071048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1070ui_story"]) and arg_191_1.var_.characterEffect1070ui_story == nil then
				arg_191_1.var_.characterEffect1070ui_story = arg_191_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1070ui_story"]) then
				if arg_191_1.var_.characterEffect1070ui_story and not isNil(arg_191_1.actors_["1070ui_story"]) then
					arg_191_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1070ui_story"]) and arg_191_1.var_.characterEffect1070ui_story then
				arg_191_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_194_2 = 0
			local var_194_3 = 0.75

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(323071047)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 30 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 30)

				if (30 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 30)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071047", "story_v_out_323071.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071047", "story_v_out_323071.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_323071", "323071047", "story_v_out_323071.awb")

						arg_191_1:RecordAudio("323071047", var_194_9)
						arg_191_1:RecordAudio("323071047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_323071", "323071047", "story_v_out_323071.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_323071", "323071047", "story_v_out_323071.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play323071048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 323071048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play323071049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1070ui_story"]) and arg_195_1.var_.characterEffect1070ui_story == nil then
				arg_195_1.var_.characterEffect1070ui_story = arg_195_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1070ui_story"]) then
				if arg_195_1.var_.characterEffect1070ui_story and not isNil(arg_195_1.actors_["1070ui_story"]) then
					arg_195_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1070ui_story"]) and arg_195_1.var_.characterEffect1070ui_story then
				arg_195_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.575

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
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

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(323071048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 23 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 23)

				if (23 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 23)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play323071049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 323071049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play323071050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.875

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

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(323071049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 35 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 35)

				if (35 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 35)) > 0 and var_202_0 < var_202_3 then
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
	Play323071050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 323071050
		arg_203_1.duration_ = 10.9

		local var_203_0 = {
			zh = 9.7,
			ja = 10.9
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
				arg_203_0:Play323071051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1070ui_story"]) and arg_203_1.var_.characterEffect1070ui_story == nil then
				arg_203_1.var_.characterEffect1070ui_story = arg_203_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1070ui_story"]) then
				if arg_203_1.var_.characterEffect1070ui_story and not isNil(arg_203_1.actors_["1070ui_story"]) then
					arg_203_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1070ui_story"]) and arg_203_1.var_.characterEffect1070ui_story then
				arg_203_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_206_2 = 0
			local var_206_3 = 1

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(323071050)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 40 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 40)

				if (40 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 40)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071050", "story_v_out_323071.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071050", "story_v_out_323071.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_out_323071", "323071050", "story_v_out_323071.awb")

						arg_203_1:RecordAudio("323071050", var_206_9)
						arg_203_1:RecordAudio("323071050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_323071", "323071050", "story_v_out_323071.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_323071", "323071050", "story_v_out_323071.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play323071051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 323071051
		arg_207_1.duration_ = 6.1

		local var_207_0 = {
			zh = 5.2,
			ja = 6.1
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
				arg_207_0:Play323071052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.475

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:GetWordFromCfg(323071051)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 19 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 19)

				if (19 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 19)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071051", "story_v_out_323071.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_323071", "323071051", "story_v_out_323071.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_323071", "323071051", "story_v_out_323071.awb")

						arg_207_1:RecordAudio("323071051", var_210_6)
						arg_207_1:RecordAudio("323071051", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_323071", "323071051", "story_v_out_323071.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_323071", "323071051", "story_v_out_323071.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play323071052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 323071052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play323071053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1070ui_story"]) and arg_211_1.var_.characterEffect1070ui_story == nil then
				arg_211_1.var_.characterEffect1070ui_story = arg_211_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1070ui_story"]) then
				if arg_211_1.var_.characterEffect1070ui_story and not isNil(arg_211_1.actors_["1070ui_story"]) then
					arg_211_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_0)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1070ui_story"]) and arg_211_1.var_.characterEffect1070ui_story then
				arg_211_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_214_1 = 0
			local var_214_2 = 0.45

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(323071052).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 18 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 18)

				if (18 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 18)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play323071053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 323071053
		arg_215_1.duration_ = 7.53

		local var_215_0 = {
			zh = 6.9,
			ja = 7.533
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play323071054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1070ui_story"]) and arg_215_1.var_.characterEffect1070ui_story == nil then
				arg_215_1.var_.characterEffect1070ui_story = arg_215_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1070ui_story"]) then
				if arg_215_1.var_.characterEffect1070ui_story and not isNil(arg_215_1.actors_["1070ui_story"]) then
					arg_215_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1070ui_story"]) and arg_215_1.var_.characterEffect1070ui_story then
				arg_215_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action474")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_218_2 = 0
			local var_218_3 = 0.575

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:GetWordFromCfg(323071053)
				local var_218_5 = arg_215_1:FormatText(var_218_4.content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_7 = 23 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 23)

				if (23 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 23)) > 0 and var_218_3 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_2
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071053", "story_v_out_323071.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071053", "story_v_out_323071.awb") / 1000

					if var_218_8 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_2
					end

					if var_218_4.prefab_name ~= "" and arg_215_1.actors_[var_218_4.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_4.prefab_name].transform, "story_v_out_323071", "323071053", "story_v_out_323071.awb")

						arg_215_1:RecordAudio("323071053", var_218_9)
						arg_215_1:RecordAudio("323071053", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_323071", "323071053", "story_v_out_323071.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_323071", "323071053", "story_v_out_323071.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_3, arg_215_1.talkMaxDuration)

			if var_218_2 <= arg_215_1.time_ and arg_215_1.time_ < var_218_2 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_2) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_2 + var_218_10 and arg_215_1.time_ < var_218_2 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play323071054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 323071054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play323071055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1070ui_story = arg_219_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1070ui_story"].transform.position).z)
				arg_219_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1070ui_story"].transform.localEulerAngles = arg_219_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1070ui_story"].transform.position).z)
				arg_219_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1070ui_story"].transform.localEulerAngles = arg_219_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1070ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1070ui_story == nil then
				arg_219_1.var_.characterEffect1070ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1070ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_2)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1070ui_story then
				arg_219_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_222_3 = 0
			local var_222_4 = 1.1

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_5 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(323071054).content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 44 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_5) / 44)

				if (44 <= 0 and var_222_4 or var_222_4 * (utf8.len(var_222_5) / 44)) > 0 and var_222_4 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_3 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_3
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_4, arg_219_1.talkMaxDuration)

			if var_222_3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_3 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_3) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_3 + var_222_8 and arg_219_1.time_ < var_222_3 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play323071055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 323071055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play323071056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0.366666666666667 < arg_223_1.time_ and arg_223_1.time_ <= 0.366666666666667 + arg_226_0 then
				arg_223_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun03", "")
			end

			local var_226_1 = 0
			local var_226_2 = 1.55

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(323071055).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 62 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 62)

				if (62 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 62)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play323071056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 323071056
		arg_227_1.duration_ = 10.7

		local var_227_0 = {
			zh = 7,
			ja = 10.7
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play323071057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10171ui_story = arg_227_1.actors_["10171ui_story"].transform.localPosition

				local var_230_0 = GameObjectTools.GetOrAddComponent(arg_227_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_230_0 then
					var_230_0:EnableDynamicBone(false)
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_227_1.time_ - 0) / var_230_1)
				arg_227_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10171ui_story"].transform.position).z)
				arg_227_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10171ui_story"].transform.localEulerAngles = arg_227_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_227_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["10171ui_story"].transform.position).z)
				arg_227_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["10171ui_story"].transform.localEulerAngles = arg_227_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_230_2 = GameObjectTools.GetOrAddComponent(arg_227_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_230_2 then
					var_230_2:EnableDynamicBone(true)
				end
			end

			local var_230_3 = arg_227_1.actors_["10171ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_3) and arg_227_1.var_.characterEffect10171ui_story == nil then
				arg_227_1.var_.characterEffect10171ui_story = var_230_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_4 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 and not isNil(var_230_3) then
				if arg_227_1.var_.characterEffect10171ui_story and not isNil(var_230_3) then
					arg_227_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 and not isNil(var_230_3) and arg_227_1.var_.characterEffect10171ui_story then
				arg_227_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_230_6 = 0
			local var_230_7 = 0.8

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_8 = arg_227_1:GetWordFromCfg(323071056)
				local var_230_9 = arg_227_1:FormatText(var_230_8.content)

				arg_227_1.text_.text = var_230_9

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 32 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 32)

				if (32 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 32)) > 0 and var_230_7 < var_230_11 then
					arg_227_1.talkMaxDuration = var_230_11

					if var_230_11 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_9
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071056", "story_v_out_323071.awb") ~= 0 then
					local var_230_12 = manager.audio:GetVoiceLength("story_v_out_323071", "323071056", "story_v_out_323071.awb") / 1000

					if var_230_12 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_12 + var_230_6
					end

					if var_230_8.prefab_name ~= "" and arg_227_1.actors_[var_230_8.prefab_name] ~= nil then
						local var_230_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_8.prefab_name].transform, "story_v_out_323071", "323071056", "story_v_out_323071.awb")

						arg_227_1:RecordAudio("323071056", var_230_13)
						arg_227_1:RecordAudio("323071056", var_230_13)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_323071", "323071056", "story_v_out_323071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_323071", "323071056", "story_v_out_323071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_14 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_14

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_14 and arg_227_1.time_ < var_230_6 + var_230_14 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play323071057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 323071057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play323071058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10171ui_story"]) and arg_231_1.var_.characterEffect10171ui_story == nil then
				arg_231_1.var_.characterEffect10171ui_story = arg_231_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10171ui_story"]) then
				if arg_231_1.var_.characterEffect10171ui_story and not isNil(arg_231_1.actors_["10171ui_story"]) then
					arg_231_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10171ui_story"]) and arg_231_1.var_.characterEffect10171ui_story then
				arg_231_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 0.675

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(323071057).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 27 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 27)

				if (27 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 27)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play323071058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 323071058
		arg_235_1.duration_ = 2.23

		local var_235_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_235_0:Play323071059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10171ui_story"]) and arg_235_1.var_.characterEffect10171ui_story == nil then
				arg_235_1.var_.characterEffect10171ui_story = arg_235_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10171ui_story"]) then
				if arg_235_1.var_.characterEffect10171ui_story and not isNil(arg_235_1.actors_["10171ui_story"]) then
					arg_235_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10171ui_story"]) and arg_235_1.var_.characterEffect10171ui_story then
				arg_235_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			local var_238_2 = 0
			local var_238_3 = 0.125

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:GetWordFromCfg(323071058)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 5 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 5)

				if (5 <= 0 and var_238_3 or var_238_3 * (utf8.len(var_238_5) / 5)) > 0 and var_238_3 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071058", "story_v_out_323071.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071058", "story_v_out_323071.awb") / 1000

					if var_238_8 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_2
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_323071", "323071058", "story_v_out_323071.awb")

						arg_235_1:RecordAudio("323071058", var_238_9)
						arg_235_1:RecordAudio("323071058", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_323071", "323071058", "story_v_out_323071.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_323071", "323071058", "story_v_out_323071.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_10 and arg_235_1.time_ < var_238_2 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play323071059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 323071059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play323071060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10171ui_story"]) and arg_239_1.var_.characterEffect10171ui_story == nil then
				arg_239_1.var_.characterEffect10171ui_story = arg_239_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10171ui_story"]) then
				if arg_239_1.var_.characterEffect10171ui_story and not isNil(arg_239_1.actors_["10171ui_story"]) then
					arg_239_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_239_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10171ui_story"]) and arg_239_1.var_.characterEffect10171ui_story then
				arg_239_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_239_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.475

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

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(323071059).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 19 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 19)

				if (19 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 19)) > 0 and var_242_2 < var_242_5 then
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
	Play323071060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 323071060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play323071061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10171ui_story = arg_243_1.actors_["10171ui_story"].transform.localPosition

				local var_246_0 = GameObjectTools.GetOrAddComponent(arg_243_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_246_0 then
					var_246_0:EnableDynamicBone(false)
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_1)
				arg_243_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10171ui_story"].transform.position).z)
				arg_243_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["10171ui_story"].transform.localEulerAngles = arg_243_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["10171ui_story"].transform.position).z)
				arg_243_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["10171ui_story"].transform.localEulerAngles = arg_243_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_246_2 = GameObjectTools.GetOrAddComponent(arg_243_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_246_2 then
					var_246_2:EnableDynamicBone(true)
				end
			end

			local var_246_3 = 0
			local var_246_4 = 1.6

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_3 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_5 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(323071060).content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 64 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_5) / 64)

				if (64 <= 0 and var_246_4 or var_246_4 * (utf8.len(var_246_5) / 64)) > 0 and var_246_4 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_3 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_3
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_8 = math.max(var_246_4, arg_243_1.talkMaxDuration)

			if var_246_3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_3 + var_246_8 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_3) / var_246_8

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_3 + var_246_8 and arg_243_1.time_ < var_246_3 + var_246_8 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play323071061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 323071061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play323071062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.175

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(323071061).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 47 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 47)

				if (47 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 47)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play323071062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 323071062
		arg_251_1.duration_ = 6.07

		local var_251_0 = {
			zh = 5.566,
			ja = 6.066
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
				arg_251_0:Play323071063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1070ui_story = arg_251_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1070ui_story"].transform.position).z)
				arg_251_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1070ui_story"].transform.localEulerAngles = arg_251_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_251_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1070ui_story"].transform.position).z)
				arg_251_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1070ui_story"].transform.localEulerAngles = arg_251_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1070ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1070ui_story == nil then
				arg_251_1.var_.characterEffect1070ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1070ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1070ui_story then
				arg_251_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_254_4 = 0
			local var_254_5 = 0.625

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(323071062)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 25 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 25)

				if (25 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 25)) > 0 and var_254_5 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071062", "story_v_out_323071.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_out_323071", "323071062", "story_v_out_323071.awb") / 1000

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end

					if var_254_6.prefab_name ~= "" and arg_251_1.actors_[var_254_6.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_6.prefab_name].transform, "story_v_out_323071", "323071062", "story_v_out_323071.awb")

						arg_251_1:RecordAudio("323071062", var_254_11)
						arg_251_1:RecordAudio("323071062", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_323071", "323071062", "story_v_out_323071.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_323071", "323071062", "story_v_out_323071.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_12 and arg_251_1.time_ < var_254_4 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play323071063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 323071063
		arg_255_1.duration_ = 7.77

		local var_255_0 = {
			zh = 6.3,
			ja = 7.766
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
				arg_255_0:Play323071064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10171ui_story = arg_255_1.actors_["10171ui_story"].transform.localPosition

				local var_258_0 = GameObjectTools.GetOrAddComponent(arg_255_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_258_0 then
					var_258_0:EnableDynamicBone(false)
				end
			end

			local var_258_1 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 then
				arg_255_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10171ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_255_1.time_ - 0) / var_258_1)
				arg_255_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10171ui_story"].transform.position).z)
				arg_255_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10171ui_story"].transform.localEulerAngles = arg_255_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 then
				arg_255_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_255_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["10171ui_story"].transform.position).z)
				arg_255_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["10171ui_story"].transform.localEulerAngles = arg_255_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_258_2 = GameObjectTools.GetOrAddComponent(arg_255_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_258_2 then
					var_258_2:EnableDynamicBone(true)
				end
			end

			local var_258_3 = arg_255_1.actors_["10171ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect10171ui_story == nil then
				arg_255_1.var_.characterEffect10171ui_story = var_258_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_4 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 and not isNil(var_258_3) then
				if arg_255_1.var_.characterEffect10171ui_story and not isNil(var_258_3) then
					arg_255_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect10171ui_story then
				arg_255_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_258_6 = arg_255_1.actors_["1070ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect1070ui_story == nil then
				arg_255_1.var_.characterEffect1070ui_story = var_258_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_7 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 and not isNil(var_258_6) then
				if arg_255_1.var_.characterEffect1070ui_story and not isNil(var_258_6) then
					arg_255_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_7)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect1070ui_story then
				arg_255_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_258_8 = 0
			local var_258_9 = 0.75

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_10 = arg_255_1:GetWordFromCfg(323071063)
				local var_258_11 = arg_255_1:FormatText(var_258_10.content)

				arg_255_1.text_.text = var_258_11

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 30 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 30)

				if (30 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 30)) > 0 and var_258_9 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_11
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071063", "story_v_out_323071.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_out_323071", "323071063", "story_v_out_323071.awb") / 1000

					if var_258_14 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_8
					end

					if var_258_10.prefab_name ~= "" and arg_255_1.actors_[var_258_10.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_10.prefab_name].transform, "story_v_out_323071", "323071063", "story_v_out_323071.awb")

						arg_255_1:RecordAudio("323071063", var_258_15)
						arg_255_1:RecordAudio("323071063", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_323071", "323071063", "story_v_out_323071.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_323071", "323071063", "story_v_out_323071.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_16 and arg_255_1.time_ < var_258_8 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play323071064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 323071064
		arg_259_1.duration_ = 4.2

		local var_259_0 = {
			zh = 4,
			ja = 4.2
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play323071065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_262_0 = 0
			local var_262_1 = 0.425

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_2 = arg_259_1:GetWordFromCfg(323071064)
				local var_262_3 = arg_259_1:FormatText(var_262_2.content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 17 <= 0 and var_262_1 or var_262_1 * (utf8.len(var_262_3) / 17)

				if (17 <= 0 and var_262_1 or var_262_1 * (utf8.len(var_262_3) / 17)) > 0 and var_262_1 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071064", "story_v_out_323071.awb") ~= 0 then
					local var_262_6 = manager.audio:GetVoiceLength("story_v_out_323071", "323071064", "story_v_out_323071.awb") / 1000

					if var_262_6 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_0
					end

					if var_262_2.prefab_name ~= "" and arg_259_1.actors_[var_262_2.prefab_name] ~= nil then
						local var_262_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_2.prefab_name].transform, "story_v_out_323071", "323071064", "story_v_out_323071.awb")

						arg_259_1:RecordAudio("323071064", var_262_7)
						arg_259_1:RecordAudio("323071064", var_262_7)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_323071", "323071064", "story_v_out_323071.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_323071", "323071064", "story_v_out_323071.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_8 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_8 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_8

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_8 and arg_259_1.time_ < var_262_0 + var_262_8 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play323071065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 323071065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play323071066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10171ui_story"]) and arg_263_1.var_.characterEffect10171ui_story == nil then
				arg_263_1.var_.characterEffect10171ui_story = arg_263_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["10171ui_story"]) then
				if arg_263_1.var_.characterEffect10171ui_story and not isNil(arg_263_1.actors_["10171ui_story"]) then
					arg_263_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_263_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["10171ui_story"]) and arg_263_1.var_.characterEffect10171ui_story then
				arg_263_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_263_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_266_1 = 0
			local var_266_2 = 1.175

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
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

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_3 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(323071065).content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 47 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 47)

				if (47 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_3) / 47)) > 0 and var_266_2 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_6 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_6 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_6

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_6 and arg_263_1.time_ < var_266_1 + var_266_6 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play323071066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 323071066
		arg_267_1.duration_ = 5.43

		local var_267_0 = {
			zh = 5.033,
			ja = 5.433
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play323071067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1070ui_story"]) and arg_267_1.var_.characterEffect1070ui_story == nil then
				arg_267_1.var_.characterEffect1070ui_story = arg_267_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1070ui_story"]) then
				if arg_267_1.var_.characterEffect1070ui_story and not isNil(arg_267_1.actors_["1070ui_story"]) then
					arg_267_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1070ui_story"]) and arg_267_1.var_.characterEffect1070ui_story then
				arg_267_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_270_2 = 0
			local var_270_3 = 0.525

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_2 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_4 = arg_267_1:GetWordFromCfg(323071066)
				local var_270_5 = arg_267_1:FormatText(var_270_4.content)

				arg_267_1.text_.text = var_270_5

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_7 = 21 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_5) / 21)

				if (21 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_5) / 21)) > 0 and var_270_3 < var_270_7 then
					arg_267_1.talkMaxDuration = var_270_7

					if var_270_7 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_7 + var_270_2
					end
				end

				arg_267_1.text_.text = var_270_5
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071066", "story_v_out_323071.awb") ~= 0 then
					local var_270_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071066", "story_v_out_323071.awb") / 1000

					if var_270_8 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_2
					end

					if var_270_4.prefab_name ~= "" and arg_267_1.actors_[var_270_4.prefab_name] ~= nil then
						local var_270_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_4.prefab_name].transform, "story_v_out_323071", "323071066", "story_v_out_323071.awb")

						arg_267_1:RecordAudio("323071066", var_270_9)
						arg_267_1:RecordAudio("323071066", var_270_9)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_323071", "323071066", "story_v_out_323071.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_323071", "323071066", "story_v_out_323071.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_3, arg_267_1.talkMaxDuration)

			if var_270_2 <= arg_267_1.time_ and arg_267_1.time_ < var_270_2 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_2) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_2 + var_270_10 and arg_267_1.time_ < var_270_2 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play323071067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 323071067
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play323071068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["10171ui_story"]) and arg_271_1.var_.characterEffect10171ui_story == nil then
				arg_271_1.var_.characterEffect10171ui_story = arg_271_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["10171ui_story"]) then
				if arg_271_1.var_.characterEffect10171ui_story and not isNil(arg_271_1.actors_["10171ui_story"]) then
					arg_271_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["10171ui_story"]) and arg_271_1.var_.characterEffect10171ui_story then
				arg_271_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_274_2 = arg_271_1.actors_["1070ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.characterEffect1070ui_story == nil then
				arg_271_1.var_.characterEffect1070ui_story = var_274_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_3 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_3 and not isNil(var_274_2) then
				if arg_271_1.var_.characterEffect1070ui_story and not isNil(var_274_2) then
					arg_271_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_3)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_3 and arg_271_1.time_ < 0 + var_274_3 + arg_274_0 and not isNil(var_274_2) and arg_271_1.var_.characterEffect1070ui_story then
				arg_271_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			local var_274_4 = 0
			local var_274_5 = 0.075

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(323071067)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 3 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 3)

				if (3 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 3)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071067", "story_v_out_323071.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_323071", "323071067", "story_v_out_323071.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_323071", "323071067", "story_v_out_323071.awb")

						arg_271_1:RecordAudio("323071067", var_274_11)
						arg_271_1:RecordAudio("323071067", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_323071", "323071067", "story_v_out_323071.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_323071", "323071067", "story_v_out_323071.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play323071068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 323071068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play323071069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10171ui_story"]) and arg_275_1.var_.characterEffect10171ui_story == nil then
				arg_275_1.var_.characterEffect10171ui_story = arg_275_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10171ui_story"]) then
				if arg_275_1.var_.characterEffect10171ui_story and not isNil(arg_275_1.actors_["10171ui_story"]) then
					arg_275_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10171ui_story"]) and arg_275_1.var_.characterEffect10171ui_story then
				arg_275_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.375

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
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

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(323071068).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 15 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 15)

				if (15 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 15)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play323071069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 323071069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play323071070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1070ui_story = arg_279_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1070ui_story"].transform.position).z)
				arg_279_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1070ui_story"].transform.localEulerAngles = arg_279_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1070ui_story"].transform.position).z)
				arg_279_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1070ui_story"].transform.localEulerAngles = arg_279_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["10171ui_story"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10171ui_story = var_282_1.localPosition

				local var_282_2 = GameObjectTools.GetOrAddComponent(var_282_1.gameObject, typeof(DynamicBoneHelper))

				if var_282_2 then
					var_282_2:EnableDynamicBone(false)
				end
			end

			local var_282_3 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_3 then
				var_282_1.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_3)
				var_282_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_1.position).x, (manager.ui.mainCamera.transform.position - var_282_1.position).y, (manager.ui.mainCamera.transform.position - var_282_1.position).z)
				var_282_1.localEulerAngles.z = 0
				var_282_1.localEulerAngles.x = 0
				var_282_1.localEulerAngles = var_282_1.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_3 and arg_279_1.time_ < 0 + var_282_3 + arg_282_0 then
				var_282_1.localPosition = Vector3.New(0, 100, 0)
				var_282_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_1.position).x, (manager.ui.mainCamera.transform.position - var_282_1.position).y, (manager.ui.mainCamera.transform.position - var_282_1.position).z)
				var_282_1.localEulerAngles.z = 0
				var_282_1.localEulerAngles.x = 0
				var_282_1.localEulerAngles = var_282_1.localEulerAngles

				local var_282_4 = GameObjectTools.GetOrAddComponent(var_282_1.gameObject, typeof(DynamicBoneHelper))

				if var_282_4 then
					var_282_4:EnableDynamicBone(true)
				end
			end

			local var_282_5 = 0
			local var_282_6 = 0.975

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(323071069).content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 39 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_7) / 39)

				if (39 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_7) / 39)) > 0 and var_282_6 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_6, arg_279_1.talkMaxDuration)

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_5) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_5 + var_282_10 and arg_279_1.time_ < var_282_5 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play323071070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 323071070
		arg_283_1.duration_ = 7.23

		local var_283_0 = {
			zh = 5.533,
			ja = 7.233
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play323071071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10171ui_story"]) and arg_283_1.var_.characterEffect10171ui_story == nil then
				arg_283_1.var_.characterEffect10171ui_story = arg_283_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10171ui_story"]) then
				if arg_283_1.var_.characterEffect10171ui_story and not isNil(arg_283_1.actors_["10171ui_story"]) then
					arg_283_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10171ui_story"]) and arg_283_1.var_.characterEffect10171ui_story then
				arg_283_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_286_2 = arg_283_1.actors_["10171ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10171ui_story = var_286_2.localPosition

				local var_286_3 = GameObjectTools.GetOrAddComponent(var_286_2.gameObject, typeof(DynamicBoneHelper))

				if var_286_3 then
					var_286_3:EnableDynamicBone(false)
				end
			end

			local var_286_4 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				var_286_2.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_283_1.time_ - 0) / var_286_4)
				var_286_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_2.position).x, (manager.ui.mainCamera.transform.position - var_286_2.position).y, (manager.ui.mainCamera.transform.position - var_286_2.position).z)
				var_286_2.localEulerAngles.z = 0
				var_286_2.localEulerAngles.x = 0
				var_286_2.localEulerAngles = var_286_2.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				var_286_2.localPosition = Vector3.New(0, -0.95, -6.05)
				var_286_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_2.position).x, (manager.ui.mainCamera.transform.position - var_286_2.position).y, (manager.ui.mainCamera.transform.position - var_286_2.position).z)
				var_286_2.localEulerAngles.z = 0
				var_286_2.localEulerAngles.x = 0
				var_286_2.localEulerAngles = var_286_2.localEulerAngles

				local var_286_5 = GameObjectTools.GetOrAddComponent(var_286_2.gameObject, typeof(DynamicBoneHelper))

				if var_286_5 then
					var_286_5:EnableDynamicBone(true)
				end
			end

			local var_286_6 = 0
			local var_286_7 = 0.525

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:GetWordFromCfg(323071070)
				local var_286_9 = arg_283_1:FormatText(var_286_8.content)

				arg_283_1.text_.text = var_286_9

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 21 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 21)

				if (21 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 21)) > 0 and var_286_7 < var_286_11 then
					arg_283_1.talkMaxDuration = var_286_11

					if var_286_11 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_9
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071070", "story_v_out_323071.awb") ~= 0 then
					local var_286_12 = manager.audio:GetVoiceLength("story_v_out_323071", "323071070", "story_v_out_323071.awb") / 1000

					if var_286_12 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_12 + var_286_6
					end

					if var_286_8.prefab_name ~= "" and arg_283_1.actors_[var_286_8.prefab_name] ~= nil then
						local var_286_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_8.prefab_name].transform, "story_v_out_323071", "323071070", "story_v_out_323071.awb")

						arg_283_1:RecordAudio("323071070", var_286_13)
						arg_283_1:RecordAudio("323071070", var_286_13)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_323071", "323071070", "story_v_out_323071.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_323071", "323071070", "story_v_out_323071.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play323071071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 323071071
		arg_287_1.duration_ = 8.1

		local var_287_0 = {
			zh = 7.4,
			ja = 8.1
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
				arg_287_0:Play323071072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 1.05

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(323071071)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 42 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 42)

				if (42 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 42)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071071", "story_v_out_323071.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_323071", "323071071", "story_v_out_323071.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_323071", "323071071", "story_v_out_323071.awb")

						arg_287_1:RecordAudio("323071071", var_290_6)
						arg_287_1:RecordAudio("323071071", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_323071", "323071071", "story_v_out_323071.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_323071", "323071071", "story_v_out_323071.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play323071072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 323071072
		arg_291_1.duration_ = 6.87

		local var_291_0 = {
			zh = 5.266,
			ja = 6.866
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
				arg_291_0:Play323071073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.65

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(323071072)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 26 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 26)

				if (26 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 26)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071072", "story_v_out_323071.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_323071", "323071072", "story_v_out_323071.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_323071", "323071072", "story_v_out_323071.awb")

						arg_291_1:RecordAudio("323071072", var_294_6)
						arg_291_1:RecordAudio("323071072", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_323071", "323071072", "story_v_out_323071.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_323071", "323071072", "story_v_out_323071.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play323071073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 323071073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play323071074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["10171ui_story"]) and arg_295_1.var_.characterEffect10171ui_story == nil then
				arg_295_1.var_.characterEffect10171ui_story = arg_295_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["10171ui_story"]) then
				if arg_295_1.var_.characterEffect10171ui_story and not isNil(arg_295_1.actors_["10171ui_story"]) then
					arg_295_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_295_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["10171ui_story"]) and arg_295_1.var_.characterEffect10171ui_story then
				arg_295_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_295_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 0.65

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(323071073).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 26 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 26)

				if (26 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 26)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play323071074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 323071074
		arg_299_1.duration_ = 2.3

		local var_299_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play323071075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["10171ui_story"]) and arg_299_1.var_.characterEffect10171ui_story == nil then
				arg_299_1.var_.characterEffect10171ui_story = arg_299_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["10171ui_story"]) then
				if arg_299_1.var_.characterEffect10171ui_story and not isNil(arg_299_1.actors_["10171ui_story"]) then
					arg_299_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["10171ui_story"]) and arg_299_1.var_.characterEffect10171ui_story then
				arg_299_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_302_2 = 0
			local var_302_3 = 0.2

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_4 = arg_299_1:GetWordFromCfg(323071074)
				local var_302_5 = arg_299_1:FormatText(var_302_4.content)

				arg_299_1.text_.text = var_302_5

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_7 = 8 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 8)

				if (8 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 8)) > 0 and var_302_3 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_5
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071074", "story_v_out_323071.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071074", "story_v_out_323071.awb") / 1000

					if var_302_8 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_2
					end

					if var_302_4.prefab_name ~= "" and arg_299_1.actors_[var_302_4.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_4.prefab_name].transform, "story_v_out_323071", "323071074", "story_v_out_323071.awb")

						arg_299_1:RecordAudio("323071074", var_302_9)
						arg_299_1:RecordAudio("323071074", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_323071", "323071074", "story_v_out_323071.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_323071", "323071074", "story_v_out_323071.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_3, arg_299_1.talkMaxDuration)

			if var_302_2 <= arg_299_1.time_ and arg_299_1.time_ < var_302_2 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_2) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_2 + var_302_10 and arg_299_1.time_ < var_302_2 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play323071075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 323071075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play323071076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["10171ui_story"]) and arg_303_1.var_.characterEffect10171ui_story == nil then
				arg_303_1.var_.characterEffect10171ui_story = arg_303_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["10171ui_story"]) then
				if arg_303_1.var_.characterEffect10171ui_story and not isNil(arg_303_1.actors_["10171ui_story"]) then
					arg_303_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_303_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["10171ui_story"]) and arg_303_1.var_.characterEffect10171ui_story then
				arg_303_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_303_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.85

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(323071075).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 34 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 34)

				if (34 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 34)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play323071076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 323071076
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play323071077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.975

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(323071076).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 39 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 39)

				if (39 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 39)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play323071077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 323071077
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play323071078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.5

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(323071077).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 20 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 20)

				if (20 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 20)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play323071078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 323071078
		arg_315_1.duration_ = 4.13

		local var_315_0 = {
			zh = 3.233,
			ja = 4.133
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play323071079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["10171ui_story"]) and arg_315_1.var_.characterEffect10171ui_story == nil then
				arg_315_1.var_.characterEffect10171ui_story = arg_315_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["10171ui_story"]) then
				if arg_315_1.var_.characterEffect10171ui_story and not isNil(arg_315_1.actors_["10171ui_story"]) then
					arg_315_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["10171ui_story"]) and arg_315_1.var_.characterEffect10171ui_story then
				arg_315_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_2")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_318_2 = 0
			local var_318_3 = 0.325

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_2 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_4 = arg_315_1:GetWordFromCfg(323071078)
				local var_318_5 = arg_315_1:FormatText(var_318_4.content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 13 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 13)

				if (13 <= 0 and var_318_3 or var_318_3 * (utf8.len(var_318_5) / 13)) > 0 and var_318_3 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_2
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071078", "story_v_out_323071.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071078", "story_v_out_323071.awb") / 1000

					if var_318_8 + var_318_2 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_2
					end

					if var_318_4.prefab_name ~= "" and arg_315_1.actors_[var_318_4.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_4.prefab_name].transform, "story_v_out_323071", "323071078", "story_v_out_323071.awb")

						arg_315_1:RecordAudio("323071078", var_318_9)
						arg_315_1:RecordAudio("323071078", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_323071", "323071078", "story_v_out_323071.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_323071", "323071078", "story_v_out_323071.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_3, arg_315_1.talkMaxDuration)

			if var_318_2 <= arg_315_1.time_ and arg_315_1.time_ < var_318_2 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_2) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_2 + var_318_10 and arg_315_1.time_ < var_318_2 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play323071079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 323071079
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play323071080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["10171ui_story"]) and arg_319_1.var_.characterEffect10171ui_story == nil then
				arg_319_1.var_.characterEffect10171ui_story = arg_319_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["10171ui_story"]) then
				if arg_319_1.var_.characterEffect10171ui_story and not isNil(arg_319_1.actors_["10171ui_story"]) then
					arg_319_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_319_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["10171ui_story"]) and arg_319_1.var_.characterEffect10171ui_story then
				arg_319_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_319_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 0.9

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(323071079).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 36 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 36)

				if (36 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 36)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play323071080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 323071080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play323071081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.75

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_1 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(323071080).content)

				arg_323_1.text_.text = var_326_1

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_3 = 30 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 30)

				if (30 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 30)) > 0 and var_326_0 < var_326_3 then
					arg_323_1.talkMaxDuration = var_326_3

					if var_326_3 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_3 + 0
					end
				end

				arg_323_1.text_.text = var_326_1
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_4 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_4

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play323071081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 323071081
		arg_327_1.duration_ = 10.4

		local var_327_0 = {
			zh = 8.433,
			ja = 10.4
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play323071082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1070ui_story"]) and arg_327_1.var_.characterEffect1070ui_story == nil then
				arg_327_1.var_.characterEffect1070ui_story = arg_327_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1070ui_story"]) then
				if arg_327_1.var_.characterEffect1070ui_story and not isNil(arg_327_1.actors_["1070ui_story"]) then
					arg_327_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1070ui_story"]) and arg_327_1.var_.characterEffect1070ui_story then
				arg_327_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_330_2 = arg_327_1.actors_["10171ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10171ui_story = var_330_2.localPosition

				local var_330_3 = GameObjectTools.GetOrAddComponent(var_330_2.gameObject, typeof(DynamicBoneHelper))

				if var_330_3 then
					var_330_3:EnableDynamicBone(false)
				end
			end

			local var_330_4 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				var_330_2.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10171ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_327_1.time_ - 0) / var_330_4)
				var_330_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_2.position).x, (manager.ui.mainCamera.transform.position - var_330_2.position).y, (manager.ui.mainCamera.transform.position - var_330_2.position).z)
				var_330_2.localEulerAngles.z = 0
				var_330_2.localEulerAngles.x = 0
				var_330_2.localEulerAngles = var_330_2.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				var_330_2.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_330_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_2.position).x, (manager.ui.mainCamera.transform.position - var_330_2.position).y, (manager.ui.mainCamera.transform.position - var_330_2.position).z)
				var_330_2.localEulerAngles.z = 0
				var_330_2.localEulerAngles.x = 0
				var_330_2.localEulerAngles = var_330_2.localEulerAngles

				local var_330_5 = GameObjectTools.GetOrAddComponent(var_330_2.gameObject, typeof(DynamicBoneHelper))

				if var_330_5 then
					var_330_5:EnableDynamicBone(true)
				end
			end

			local var_330_6 = arg_327_1.actors_["1070ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1070ui_story = var_330_6.localPosition
			end

			local var_330_7 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				var_330_6.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_327_1.time_ - 0) / var_330_7)
				var_330_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_6.position).x, (manager.ui.mainCamera.transform.position - var_330_6.position).y, (manager.ui.mainCamera.transform.position - var_330_6.position).z)
				var_330_6.localEulerAngles.z = 0
				var_330_6.localEulerAngles.x = 0
				var_330_6.localEulerAngles = var_330_6.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				var_330_6.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_330_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_6.position).x, (manager.ui.mainCamera.transform.position - var_330_6.position).y, (manager.ui.mainCamera.transform.position - var_330_6.position).z)
				var_330_6.localEulerAngles.z = 0
				var_330_6.localEulerAngles.x = 0
				var_330_6.localEulerAngles = var_330_6.localEulerAngles
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_330_8 = 0
			local var_330_9 = 1.025

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_10 = arg_327_1:GetWordFromCfg(323071081)
				local var_330_11 = arg_327_1:FormatText(var_330_10.content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 41 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 41)

				if (41 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 41)) > 0 and var_330_9 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071081", "story_v_out_323071.awb") ~= 0 then
					local var_330_14 = manager.audio:GetVoiceLength("story_v_out_323071", "323071081", "story_v_out_323071.awb") / 1000

					if var_330_14 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_8
					end

					if var_330_10.prefab_name ~= "" and arg_327_1.actors_[var_330_10.prefab_name] ~= nil then
						local var_330_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_10.prefab_name].transform, "story_v_out_323071", "323071081", "story_v_out_323071.awb")

						arg_327_1:RecordAudio("323071081", var_330_15)
						arg_327_1:RecordAudio("323071081", var_330_15)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_323071", "323071081", "story_v_out_323071.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_323071", "323071081", "story_v_out_323071.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_16 and arg_327_1.time_ < var_330_8 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play323071082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 323071082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play323071083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1070ui_story"]) and arg_331_1.var_.characterEffect1070ui_story == nil then
				arg_331_1.var_.characterEffect1070ui_story = arg_331_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1070ui_story"]) then
				if arg_331_1.var_.characterEffect1070ui_story and not isNil(arg_331_1.actors_["1070ui_story"]) then
					arg_331_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1070ui_story"]) and arg_331_1.var_.characterEffect1070ui_story then
				arg_331_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 0.225

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(323071082).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 9 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 9)

				if (9 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 9)) > 0 and var_334_2 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_6 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_6 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_6

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_6 and arg_331_1.time_ < var_334_1 + var_334_6 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play323071083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 323071083
		arg_335_1.duration_ = 2

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play323071084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1070ui_story"]) and arg_335_1.var_.characterEffect1070ui_story == nil then
				arg_335_1.var_.characterEffect1070ui_story = arg_335_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1070ui_story"]) then
				if arg_335_1.var_.characterEffect1070ui_story and not isNil(arg_335_1.actors_["1070ui_story"]) then
					arg_335_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1070ui_story"]) and arg_335_1.var_.characterEffect1070ui_story then
				arg_335_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_338_2 = 0
			local var_338_3 = 0.05

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_2 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_4 = arg_335_1:GetWordFromCfg(323071083)
				local var_338_5 = arg_335_1:FormatText(var_338_4.content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 2 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 2)

				if (2 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 2)) > 0 and var_338_3 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_2
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071083", "story_v_out_323071.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071083", "story_v_out_323071.awb") / 1000

					if var_338_8 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_2
					end

					if var_338_4.prefab_name ~= "" and arg_335_1.actors_[var_338_4.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_4.prefab_name].transform, "story_v_out_323071", "323071083", "story_v_out_323071.awb")

						arg_335_1:RecordAudio("323071083", var_338_9)
						arg_335_1:RecordAudio("323071083", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_323071", "323071083", "story_v_out_323071.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_323071", "323071083", "story_v_out_323071.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_3, arg_335_1.talkMaxDuration)

			if var_338_2 <= arg_335_1.time_ and arg_335_1.time_ < var_338_2 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_2) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_2 + var_338_10 and arg_335_1.time_ < var_338_2 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play323071084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 323071084
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play323071085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1070ui_story"]) and arg_339_1.var_.characterEffect1070ui_story == nil then
				arg_339_1.var_.characterEffect1070ui_story = arg_339_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1070ui_story"]) then
				if arg_339_1.var_.characterEffect1070ui_story and not isNil(arg_339_1.actors_["1070ui_story"]) then
					arg_339_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1070ui_story"]) and arg_339_1.var_.characterEffect1070ui_story then
				arg_339_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 0.6

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(323071084).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 24 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 24)

				if (24 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 24)) > 0 and var_342_2 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_6 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_6 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_6

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_6 and arg_339_1.time_ < var_342_1 + var_342_6 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play323071085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 323071085
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play323071086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.8

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(323071085).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 32 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 32)

				if (32 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 32)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play323071086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 323071086
		arg_347_1.duration_ = 3.83

		local var_347_0 = {
			zh = 3.833,
			ja = 2.6
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play323071087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1070ui_story"]) and arg_347_1.var_.characterEffect1070ui_story == nil then
				arg_347_1.var_.characterEffect1070ui_story = arg_347_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1070ui_story"]) then
				if arg_347_1.var_.characterEffect1070ui_story and not isNil(arg_347_1.actors_["1070ui_story"]) then
					arg_347_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1070ui_story"]) and arg_347_1.var_.characterEffect1070ui_story then
				arg_347_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_350_2 = 0
			local var_350_3 = 0.35

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_4 = arg_347_1:GetWordFromCfg(323071086)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_7 = 14 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 14)

				if (14 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 14)) > 0 and var_350_3 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071086", "story_v_out_323071.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071086", "story_v_out_323071.awb") / 1000

					if var_350_8 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_2
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_out_323071", "323071086", "story_v_out_323071.awb")

						arg_347_1:RecordAudio("323071086", var_350_9)
						arg_347_1:RecordAudio("323071086", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_323071", "323071086", "story_v_out_323071.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_323071", "323071086", "story_v_out_323071.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_3, arg_347_1.talkMaxDuration)

			if var_350_2 <= arg_347_1.time_ and arg_347_1.time_ < var_350_2 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_2) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_2 + var_350_10 and arg_347_1.time_ < var_350_2 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play323071087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 323071087
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play323071088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1070ui_story"]) and arg_351_1.var_.characterEffect1070ui_story == nil then
				arg_351_1.var_.characterEffect1070ui_story = arg_351_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1070ui_story"]) then
				if arg_351_1.var_.characterEffect1070ui_story and not isNil(arg_351_1.actors_["1070ui_story"]) then
					arg_351_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1070ui_story"]) and arg_351_1.var_.characterEffect1070ui_story then
				arg_351_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.75

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(323071087).content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 30 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 30)

				if (30 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 30)) > 0 and var_354_2 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_6 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_6 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_6

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_6 and arg_351_1.time_ < var_354_1 + var_354_6 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play323071088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 323071088
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play323071089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.075

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(323071088).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 43 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 43)

				if (43 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 43)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play323071089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 323071089
		arg_359_1.duration_ = 11.07

		local var_359_0 = {
			zh = 9.766,
			ja = 11.066
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play323071090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10171ui_story"]) and arg_359_1.var_.characterEffect10171ui_story == nil then
				arg_359_1.var_.characterEffect10171ui_story = arg_359_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10171ui_story"]) then
				if arg_359_1.var_.characterEffect10171ui_story and not isNil(arg_359_1.actors_["10171ui_story"]) then
					arg_359_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10171ui_story"]) and arg_359_1.var_.characterEffect10171ui_story then
				arg_359_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_362_2 = 0
			local var_362_3 = 1.2

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_4 = arg_359_1:GetWordFromCfg(323071089)
				local var_362_5 = arg_359_1:FormatText(var_362_4.content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 48 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 48)

				if (48 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 48)) > 0 and var_362_3 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_2
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071089", "story_v_out_323071.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071089", "story_v_out_323071.awb") / 1000

					if var_362_8 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_2
					end

					if var_362_4.prefab_name ~= "" and arg_359_1.actors_[var_362_4.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_4.prefab_name].transform, "story_v_out_323071", "323071089", "story_v_out_323071.awb")

						arg_359_1:RecordAudio("323071089", var_362_9)
						arg_359_1:RecordAudio("323071089", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_323071", "323071089", "story_v_out_323071.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_323071", "323071089", "story_v_out_323071.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_3, arg_359_1.talkMaxDuration)

			if var_362_2 <= arg_359_1.time_ and arg_359_1.time_ < var_362_2 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_2) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_2 + var_362_10 and arg_359_1.time_ < var_362_2 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play323071090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 323071090
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play323071091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos10171ui_story = arg_363_1.actors_["10171ui_story"].transform.localPosition

				local var_366_0 = GameObjectTools.GetOrAddComponent(arg_363_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_366_0 then
					var_366_0:EnableDynamicBone(false)
				end
			end

			local var_366_1 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_1 then
				arg_363_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_363_1.time_ - 0) / var_366_1)
				arg_363_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10171ui_story"].transform.position).z)
				arg_363_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["10171ui_story"].transform.localEulerAngles = arg_363_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_1 and arg_363_1.time_ < 0 + var_366_1 + arg_366_0 then
				arg_363_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["10171ui_story"].transform.position).z)
				arg_363_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["10171ui_story"].transform.localEulerAngles = arg_363_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_366_2 = GameObjectTools.GetOrAddComponent(arg_363_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_366_2 then
					var_366_2:EnableDynamicBone(true)
				end
			end

			local var_366_3 = arg_363_1.actors_["1070ui_story"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1070ui_story = var_366_3.localPosition
			end

			local var_366_4 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				var_366_3.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_363_1.time_ - 0) / var_366_4)
				var_366_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_3.position).x, (manager.ui.mainCamera.transform.position - var_366_3.position).y, (manager.ui.mainCamera.transform.position - var_366_3.position).z)
				var_366_3.localEulerAngles.z = 0
				var_366_3.localEulerAngles.x = 0
				var_366_3.localEulerAngles = var_366_3.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				var_366_3.localPosition = Vector3.New(0, 100, 0)
				var_366_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_3.position).x, (manager.ui.mainCamera.transform.position - var_366_3.position).y, (manager.ui.mainCamera.transform.position - var_366_3.position).z)
				var_366_3.localEulerAngles.z = 0
				var_366_3.localEulerAngles.x = 0
				var_366_3.localEulerAngles = var_366_3.localEulerAngles
			end

			local var_366_5 = arg_363_1.actors_["10171ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_5) and arg_363_1.var_.characterEffect10171ui_story == nil then
				arg_363_1.var_.characterEffect10171ui_story = var_366_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_6 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_6 and not isNil(var_366_5) then
				if arg_363_1.var_.characterEffect10171ui_story and not isNil(var_366_5) then
					arg_363_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_363_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_6)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_6 and arg_363_1.time_ < 0 + var_366_6 + arg_366_0 and not isNil(var_366_5) and arg_363_1.var_.characterEffect10171ui_story then
				arg_363_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_363_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0.45 < arg_363_1.time_ and arg_363_1.time_ <= 0.45 + arg_366_0 then
				arg_363_1:AudioAction("play", "effect", "se_story_141", "se_story_141_message", "")
			end

			local var_366_8 = 0
			local var_366_9 = 1.45

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_10 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(323071090).content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_12 = 58 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_10) / 58)

				if (58 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_10) / 58)) > 0 and var_366_9 < var_366_12 then
					arg_363_1.talkMaxDuration = var_366_12

					if var_366_12 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_8
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_13 = math.max(var_366_9, arg_363_1.talkMaxDuration)

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_13 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_8) / var_366_13

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_8 + var_366_13 and arg_363_1.time_ < var_366_8 + var_366_13 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323071091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 323071091
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play323071092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 1.425

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(323071091).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 57 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 57)

				if (57 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 57)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play323071092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 323071092
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play323071093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.65

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
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

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(323071092).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 26 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 26)

				if (26 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 26)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play323071093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 323071093
		arg_375_1.duration_ = 3.63

		local var_375_0 = {
			zh = 2.3,
			ja = 3.633
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
				arg_375_0:Play323071094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1070ui_story = arg_375_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).z)
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles = arg_375_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_375_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).z)
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles = arg_375_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1070ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1070ui_story == nil then
				arg_375_1.var_.characterEffect1070ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1070ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1070ui_story then
				arg_375_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_378_4 = 0
			local var_378_5 = 0.225

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(323071093)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 9 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 9)

				if (9 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 9)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071093", "story_v_out_323071.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_323071", "323071093", "story_v_out_323071.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_323071", "323071093", "story_v_out_323071.awb")

						arg_375_1:RecordAudio("323071093", var_378_11)
						arg_375_1:RecordAudio("323071093", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_323071", "323071093", "story_v_out_323071.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_323071", "323071093", "story_v_out_323071.awb")
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
				actorName = "1070ui_story",
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
	Play323071094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 323071094
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play323071095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1070ui_story"]) and arg_379_1.var_.characterEffect1070ui_story == nil then
				arg_379_1.var_.characterEffect1070ui_story = arg_379_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_0 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1070ui_story"]) then
				if arg_379_1.var_.characterEffect1070ui_story and not isNil(arg_379_1.actors_["1070ui_story"]) then
					arg_379_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_0)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1070ui_story"]) and arg_379_1.var_.characterEffect1070ui_story then
				arg_379_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_382_1 = 0
			local var_382_2 = 0.7

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(323071094).content)

				arg_379_1.text_.text = var_382_3

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 28 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 28)

				if (28 <= 0 and var_382_2 or var_382_2 * (utf8.len(var_382_3) / 28)) > 0 and var_382_2 < var_382_5 then
					arg_379_1.talkMaxDuration = var_382_5

					if var_382_5 + var_382_1 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + var_382_1
					end
				end

				arg_379_1.text_.text = var_382_3
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_6 = math.max(var_382_2, arg_379_1.talkMaxDuration)

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_6 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_1) / var_382_6

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_1 + var_382_6 and arg_379_1.time_ < var_382_1 + var_382_6 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play323071095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 323071095
		arg_383_1.duration_ = 9.5

		local var_383_0 = {
			zh = 6,
			ja = 9.5
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play323071096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1070ui_story"]) and arg_383_1.var_.characterEffect1070ui_story == nil then
				arg_383_1.var_.characterEffect1070ui_story = arg_383_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1070ui_story"]) then
				if arg_383_1.var_.characterEffect1070ui_story and not isNil(arg_383_1.actors_["1070ui_story"]) then
					arg_383_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1070ui_story"]) and arg_383_1.var_.characterEffect1070ui_story then
				arg_383_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_386_2 = 0
			local var_386_3 = 0.675

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_4 = arg_383_1:GetWordFromCfg(323071095)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 27 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 27)

				if (27 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 27)) > 0 and var_386_3 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071095", "story_v_out_323071.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071095", "story_v_out_323071.awb") / 1000

					if var_386_8 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_2
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_out_323071", "323071095", "story_v_out_323071.awb")

						arg_383_1:RecordAudio("323071095", var_386_9)
						arg_383_1:RecordAudio("323071095", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_323071", "323071095", "story_v_out_323071.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_323071", "323071095", "story_v_out_323071.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_3, arg_383_1.talkMaxDuration)

			if var_386_2 <= arg_383_1.time_ and arg_383_1.time_ < var_386_2 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_2) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_2 + var_386_10 and arg_383_1.time_ < var_386_2 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play323071096 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 323071096
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play323071097(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1070ui_story"]) and arg_387_1.var_.characterEffect1070ui_story == nil then
				arg_387_1.var_.characterEffect1070ui_story = arg_387_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1070ui_story"]) then
				if arg_387_1.var_.characterEffect1070ui_story and not isNil(arg_387_1.actors_["1070ui_story"]) then
					arg_387_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_387_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_387_1.time_ - 0) / var_390_0)
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1070ui_story"]) and arg_387_1.var_.characterEffect1070ui_story then
				arg_387_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_387_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_390_1 = 0
			local var_390_2 = 0.55

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(323071096).content)

				arg_387_1.text_.text = var_390_3

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 22 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_3) / 22)

				if (22 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_3) / 22)) > 0 and var_390_2 < var_390_5 then
					arg_387_1.talkMaxDuration = var_390_5

					if var_390_5 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_5 + var_390_1
					end
				end

				arg_387_1.text_.text = var_390_3
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_6 = math.max(var_390_2, arg_387_1.talkMaxDuration)

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_6 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_1) / var_390_6

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_1 + var_390_6 and arg_387_1.time_ < var_390_1 + var_390_6 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play323071097 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 323071097
		arg_391_1.duration_ = 5.37

		local var_391_0 = {
			zh = 3.1,
			ja = 5.366
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
				arg_391_0:Play323071098(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1070ui_story"]) and arg_391_1.var_.characterEffect1070ui_story == nil then
				arg_391_1.var_.characterEffect1070ui_story = arg_391_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1070ui_story"]) then
				if arg_391_1.var_.characterEffect1070ui_story and not isNil(arg_391_1.actors_["1070ui_story"]) then
					arg_391_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1070ui_story"]) and arg_391_1.var_.characterEffect1070ui_story then
				arg_391_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_394_2 = 0
			local var_394_3 = 0.35

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_2 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_4 = arg_391_1:GetWordFromCfg(323071097)
				local var_394_5 = arg_391_1:FormatText(var_394_4.content)

				arg_391_1.text_.text = var_394_5

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_7 = 14 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 14)

				if (14 <= 0 and var_394_3 or var_394_3 * (utf8.len(var_394_5) / 14)) > 0 and var_394_3 < var_394_7 then
					arg_391_1.talkMaxDuration = var_394_7

					if var_394_7 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_7 + var_394_2
					end
				end

				arg_391_1.text_.text = var_394_5
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071097", "story_v_out_323071.awb") ~= 0 then
					local var_394_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071097", "story_v_out_323071.awb") / 1000

					if var_394_8 + var_394_2 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_8 + var_394_2
					end

					if var_394_4.prefab_name ~= "" and arg_391_1.actors_[var_394_4.prefab_name] ~= nil then
						local var_394_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_4.prefab_name].transform, "story_v_out_323071", "323071097", "story_v_out_323071.awb")

						arg_391_1:RecordAudio("323071097", var_394_9)
						arg_391_1:RecordAudio("323071097", var_394_9)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_323071", "323071097", "story_v_out_323071.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_323071", "323071097", "story_v_out_323071.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_10 = math.max(var_394_3, arg_391_1.talkMaxDuration)

			if var_394_2 <= arg_391_1.time_ and arg_391_1.time_ < var_394_2 + var_394_10 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_2) / var_394_10

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_2 + var_394_10 and arg_391_1.time_ < var_394_2 + var_394_10 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play323071098 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 323071098
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play323071099(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1070ui_story"]) and arg_395_1.var_.characterEffect1070ui_story == nil then
				arg_395_1.var_.characterEffect1070ui_story = arg_395_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1070ui_story"]) then
				if arg_395_1.var_.characterEffect1070ui_story and not isNil(arg_395_1.actors_["1070ui_story"]) then
					arg_395_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_0)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1070ui_story"]) and arg_395_1.var_.characterEffect1070ui_story then
				arg_395_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_398_1 = 0
			local var_398_2 = 0.15

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_3 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(323071098).content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 6 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 6)

				if (6 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 6)) > 0 and var_398_2 < var_398_5 then
					arg_395_1.talkMaxDuration = var_398_5

					if var_398_5 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + var_398_1
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_6 = math.max(var_398_2, arg_395_1.talkMaxDuration)

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_6 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_1) / var_398_6

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_1 + var_398_6 and arg_395_1.time_ < var_398_1 + var_398_6 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play323071099 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 323071099
		arg_399_1.duration_ = 1.67

		local var_399_0 = {
			zh = 1.333,
			ja = 1.666
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play323071100(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1070ui_story"]) and arg_399_1.var_.characterEffect1070ui_story == nil then
				arg_399_1.var_.characterEffect1070ui_story = arg_399_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1070ui_story"]) then
				if arg_399_1.var_.characterEffect1070ui_story and not isNil(arg_399_1.actors_["1070ui_story"]) then
					arg_399_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1070ui_story"]) and arg_399_1.var_.characterEffect1070ui_story then
				arg_399_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_402_2 = 0
			local var_402_3 = 0.1

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_2 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_4 = arg_399_1:GetWordFromCfg(323071099)
				local var_402_5 = arg_399_1:FormatText(var_402_4.content)

				arg_399_1.text_.text = var_402_5

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_7 = 4 <= 0 and var_402_3 or var_402_3 * (utf8.len(var_402_5) / 4)

				if (4 <= 0 and var_402_3 or var_402_3 * (utf8.len(var_402_5) / 4)) > 0 and var_402_3 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_2
					end
				end

				arg_399_1.text_.text = var_402_5
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071099", "story_v_out_323071.awb") ~= 0 then
					local var_402_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071099", "story_v_out_323071.awb") / 1000

					if var_402_8 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_2
					end

					if var_402_4.prefab_name ~= "" and arg_399_1.actors_[var_402_4.prefab_name] ~= nil then
						local var_402_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_4.prefab_name].transform, "story_v_out_323071", "323071099", "story_v_out_323071.awb")

						arg_399_1:RecordAudio("323071099", var_402_9)
						arg_399_1:RecordAudio("323071099", var_402_9)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_323071", "323071099", "story_v_out_323071.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_323071", "323071099", "story_v_out_323071.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_10 = math.max(var_402_3, arg_399_1.talkMaxDuration)

			if var_402_2 <= arg_399_1.time_ and arg_399_1.time_ < var_402_2 + var_402_10 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_2) / var_402_10

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_2 + var_402_10 and arg_399_1.time_ < var_402_2 + var_402_10 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play323071100 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 323071100
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play323071101(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1070ui_story = arg_403_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).z)
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles = arg_403_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).z)
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles = arg_403_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1070ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1070ui_story == nil then
				arg_403_1.var_.characterEffect1070ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1070ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_2)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1070ui_story then
				arg_403_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0.7 < arg_403_1.time_ and arg_403_1.time_ <= 0.7 + arg_406_0 then
				arg_403_1:AudioAction("play", "effect", "se_story_141", "se_story_141_xuanji02", "")
			end

			local var_406_4 = 0
			local var_406_5 = 1.375

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(323071100).content)

				arg_403_1.text_.text = var_406_6

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_8 = 55 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_6) / 55)

				if (55 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_6) / 55)) > 0 and var_406_5 < var_406_8 then
					arg_403_1.talkMaxDuration = var_406_8

					if var_406_8 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_6
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_9 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_9 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_9

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_9 and arg_403_1.time_ < var_406_4 + var_406_9 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play323071101 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 323071101
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play323071102(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.15

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_1 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(323071101).content)

				arg_407_1.text_.text = var_410_1

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_3 = 6 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 6)

				if (6 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_1) / 6)) > 0 and var_410_0 < var_410_3 then
					arg_407_1.talkMaxDuration = var_410_3

					if var_410_3 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_3 + 0
					end
				end

				arg_407_1.text_.text = var_410_1
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_4 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_4

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play323071102 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 323071102
		arg_411_1.duration_ = 2.5

		local var_411_0 = {
			zh = 2.233,
			ja = 2.5
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play323071103(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1070ui_story = arg_411_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1070ui_story"].transform.position).z)
				arg_411_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1070ui_story"].transform.localEulerAngles = arg_411_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_411_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1070ui_story"].transform.position).z)
				arg_411_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1070ui_story"].transform.localEulerAngles = arg_411_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1070ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1070ui_story == nil then
				arg_411_1.var_.characterEffect1070ui_story = var_414_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 and not isNil(var_414_1) then
				if arg_411_1.var_.characterEffect1070ui_story and not isNil(var_414_1) then
					arg_411_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1070ui_story then
				arg_411_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_414_4 = 0

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1.allBtn_.enabled = false
			end

			if arg_411_1.time_ >= var_414_4 + 1.125 and arg_411_1.time_ < var_414_4 + 1.125 + arg_414_0 then
				arg_411_1.allBtn_.enabled = true
			end

			if arg_411_1.frameCnt_ <= 1 then
				arg_411_1.dialog_:SetActive(false)
			end

			local var_414_5 = 1
			local var_414_6 = 0.125

			if 1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0

				arg_411_1.dialog_:SetActive(true)

				arg_411_1.dialogCg_.alpha = 0

				local var_414_7 = LeanTween.value(arg_411_1.dialog_, 0, 1, 0.3)

				var_414_7:setOnUpdate(LuaHelper.FloatAction(function(arg_415_0)
					arg_411_1.dialogCg_.alpha = arg_415_0
				end))
				var_414_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_411_1.dialog_)
					var_414_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_411_1.duration_ = arg_411_1.duration_ + 0.3

				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_8 = arg_411_1:GetWordFromCfg(323071102)
				local var_414_9 = arg_411_1:FormatText(var_414_8.content)

				arg_411_1.text_.text = var_414_9

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_11 = 5 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_9) / 5)

				if (5 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_9) / 5)) > 0 and var_414_6 < var_414_11 then
					arg_411_1.talkMaxDuration = var_414_11
					var_414_5 = var_414_5 + 0.3

					if var_414_11 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_11 + var_414_5
					end
				end

				arg_411_1.text_.text = var_414_9
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071102", "story_v_out_323071.awb") ~= 0 then
					local var_414_12 = manager.audio:GetVoiceLength("story_v_out_323071", "323071102", "story_v_out_323071.awb") / 1000

					if var_414_12 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_12 + var_414_5
					end

					if var_414_8.prefab_name ~= "" and arg_411_1.actors_[var_414_8.prefab_name] ~= nil then
						local var_414_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_8.prefab_name].transform, "story_v_out_323071", "323071102", "story_v_out_323071.awb")

						arg_411_1:RecordAudio("323071102", var_414_13)
						arg_411_1:RecordAudio("323071102", var_414_13)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_323071", "323071102", "story_v_out_323071.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_323071", "323071102", "story_v_out_323071.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_14 = var_414_5 + 0.3
			local var_414_15 = math.max(var_414_6, arg_411_1.talkMaxDuration)

			if var_414_5 + 0.3 <= arg_411_1.time_ and arg_411_1.time_ < var_414_14 + var_414_15 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_14) / var_414_15

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_14 + var_414_15 and arg_411_1.time_ < var_414_14 + var_414_15 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play323071103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 323071103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play323071104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1070ui_story"]) and arg_417_1.var_.characterEffect1070ui_story == nil then
				arg_417_1.var_.characterEffect1070ui_story = arg_417_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1070ui_story"]) then
				if arg_417_1.var_.characterEffect1070ui_story and not isNil(arg_417_1.actors_["1070ui_story"]) then
					arg_417_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1070ui_story"]) and arg_417_1.var_.characterEffect1070ui_story then
				arg_417_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.125

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(323071103).content)

				arg_417_1.text_.text = var_420_3

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 5 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 5)

				if (5 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 5)) > 0 and var_420_2 < var_420_5 then
					arg_417_1.talkMaxDuration = var_420_5

					if var_420_5 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_3
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_6 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_6 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_6

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_6 and arg_417_1.time_ < var_420_1 + var_420_6 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play323071104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 323071104
		arg_421_1.duration_ = 4

		local var_421_0 = {
			zh = 3.3,
			ja = 4
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play323071105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1070ui_story"]) and arg_421_1.var_.characterEffect1070ui_story == nil then
				arg_421_1.var_.characterEffect1070ui_story = arg_421_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1070ui_story"]) then
				if arg_421_1.var_.characterEffect1070ui_story and not isNil(arg_421_1.actors_["1070ui_story"]) then
					arg_421_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1070ui_story"]) and arg_421_1.var_.characterEffect1070ui_story then
				arg_421_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_424_2 = 0
			local var_424_3 = 0.35

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_2 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_4 = arg_421_1:GetWordFromCfg(323071104)
				local var_424_5 = arg_421_1:FormatText(var_424_4.content)

				arg_421_1.text_.text = var_424_5

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_7 = 14 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_5) / 14)

				if (14 <= 0 and var_424_3 or var_424_3 * (utf8.len(var_424_5) / 14)) > 0 and var_424_3 < var_424_7 then
					arg_421_1.talkMaxDuration = var_424_7

					if var_424_7 + var_424_2 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_2
					end
				end

				arg_421_1.text_.text = var_424_5
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071104", "story_v_out_323071.awb") ~= 0 then
					local var_424_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071104", "story_v_out_323071.awb") / 1000

					if var_424_8 + var_424_2 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_8 + var_424_2
					end

					if var_424_4.prefab_name ~= "" and arg_421_1.actors_[var_424_4.prefab_name] ~= nil then
						local var_424_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_4.prefab_name].transform, "story_v_out_323071", "323071104", "story_v_out_323071.awb")

						arg_421_1:RecordAudio("323071104", var_424_9)
						arg_421_1:RecordAudio("323071104", var_424_9)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_323071", "323071104", "story_v_out_323071.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_323071", "323071104", "story_v_out_323071.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_10 = math.max(var_424_3, arg_421_1.talkMaxDuration)

			if var_424_2 <= arg_421_1.time_ and arg_421_1.time_ < var_424_2 + var_424_10 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_2) / var_424_10

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_2 + var_424_10 and arg_421_1.time_ < var_424_2 + var_424_10 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play323071105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 323071105
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play323071106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1070ui_story"]) and arg_425_1.var_.characterEffect1070ui_story == nil then
				arg_425_1.var_.characterEffect1070ui_story = arg_425_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1070ui_story"]) then
				if arg_425_1.var_.characterEffect1070ui_story and not isNil(arg_425_1.actors_["1070ui_story"]) then
					arg_425_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_0)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1070ui_story"]) and arg_425_1.var_.characterEffect1070ui_story then
				arg_425_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_428_1 = 0
			local var_428_2 = 0.65

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_3 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(323071105).content)

				arg_425_1.text_.text = var_428_3

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 26 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 26)

				if (26 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 26)) > 0 and var_428_2 < var_428_5 then
					arg_425_1.talkMaxDuration = var_428_5

					if var_428_5 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + var_428_1
					end
				end

				arg_425_1.text_.text = var_428_3
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_6 = math.max(var_428_2, arg_425_1.talkMaxDuration)

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_6 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_1) / var_428_6

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_1 + var_428_6 and arg_425_1.time_ < var_428_1 + var_428_6 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play323071106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 323071106
		arg_429_1.duration_ = 8.7

		local var_429_0 = {
			zh = 8.7,
			ja = 6.966
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
				arg_429_0:Play323071107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1070ui_story"]) and arg_429_1.var_.characterEffect1070ui_story == nil then
				arg_429_1.var_.characterEffect1070ui_story = arg_429_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1070ui_story"]) then
				if arg_429_1.var_.characterEffect1070ui_story and not isNil(arg_429_1.actors_["1070ui_story"]) then
					arg_429_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1070ui_story"]) and arg_429_1.var_.characterEffect1070ui_story then
				arg_429_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva", "EmotionTimelineAnimator")
			end

			local var_432_2 = 0
			local var_432_3 = 0.825

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_4 = arg_429_1:GetWordFromCfg(323071106)
				local var_432_5 = arg_429_1:FormatText(var_432_4.content)

				arg_429_1.text_.text = var_432_5

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_7 = 33 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 33)

				if (33 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 33)) > 0 and var_432_3 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_2
					end
				end

				arg_429_1.text_.text = var_432_5
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071106", "story_v_out_323071.awb") ~= 0 then
					local var_432_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071106", "story_v_out_323071.awb") / 1000

					if var_432_8 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_8 + var_432_2
					end

					if var_432_4.prefab_name ~= "" and arg_429_1.actors_[var_432_4.prefab_name] ~= nil then
						local var_432_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_4.prefab_name].transform, "story_v_out_323071", "323071106", "story_v_out_323071.awb")

						arg_429_1:RecordAudio("323071106", var_432_9)
						arg_429_1:RecordAudio("323071106", var_432_9)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_323071", "323071106", "story_v_out_323071.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_323071", "323071106", "story_v_out_323071.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_10 = math.max(var_432_3, arg_429_1.talkMaxDuration)

			if var_432_2 <= arg_429_1.time_ and arg_429_1.time_ < var_432_2 + var_432_10 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_2) / var_432_10

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_2 + var_432_10 and arg_429_1.time_ < var_432_2 + var_432_10 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play323071107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 323071107
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play323071108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1070ui_story"]) and arg_433_1.var_.characterEffect1070ui_story == nil then
				arg_433_1.var_.characterEffect1070ui_story = arg_433_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1070ui_story"]) then
				if arg_433_1.var_.characterEffect1070ui_story and not isNil(arg_433_1.actors_["1070ui_story"]) then
					arg_433_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_0)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1070ui_story"]) and arg_433_1.var_.characterEffect1070ui_story then
				arg_433_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_436_1 = 0
			local var_436_2 = 0.225

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_3 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(323071107).content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 9 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 9)

				if (9 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 9)) > 0 and var_436_2 < var_436_5 then
					arg_433_1.talkMaxDuration = var_436_5

					if var_436_5 + var_436_1 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + var_436_1
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_6 = math.max(var_436_2, arg_433_1.talkMaxDuration)

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_6 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_1) / var_436_6

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_1 + var_436_6 and arg_433_1.time_ < var_436_1 + var_436_6 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play323071108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 323071108
		arg_437_1.duration_ = 2

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play323071109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1070ui_story"]) and arg_437_1.var_.characterEffect1070ui_story == nil then
				arg_437_1.var_.characterEffect1070ui_story = arg_437_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1070ui_story"]) then
				if arg_437_1.var_.characterEffect1070ui_story and not isNil(arg_437_1.actors_["1070ui_story"]) then
					arg_437_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1070ui_story"]) and arg_437_1.var_.characterEffect1070ui_story then
				arg_437_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_440_2 = 0
			local var_440_3 = 0.15

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_4 = arg_437_1:GetWordFromCfg(323071108)
				local var_440_5 = arg_437_1:FormatText(var_440_4.content)

				arg_437_1.text_.text = var_440_5

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_7 = 6 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 6)

				if (6 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 6)) > 0 and var_440_3 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_2
					end
				end

				arg_437_1.text_.text = var_440_5
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071108", "story_v_out_323071.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071108", "story_v_out_323071.awb") / 1000

					if var_440_8 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_2
					end

					if var_440_4.prefab_name ~= "" and arg_437_1.actors_[var_440_4.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_4.prefab_name].transform, "story_v_out_323071", "323071108", "story_v_out_323071.awb")

						arg_437_1:RecordAudio("323071108", var_440_9)
						arg_437_1:RecordAudio("323071108", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_323071", "323071108", "story_v_out_323071.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_323071", "323071108", "story_v_out_323071.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_3, arg_437_1.talkMaxDuration)

			if var_440_2 <= arg_437_1.time_ and arg_437_1.time_ < var_440_2 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_2) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_2 + var_440_10 and arg_437_1.time_ < var_440_2 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play323071109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 323071109
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play323071110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1070ui_story"]) and arg_441_1.var_.characterEffect1070ui_story == nil then
				arg_441_1.var_.characterEffect1070ui_story = arg_441_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1070ui_story"]) then
				if arg_441_1.var_.characterEffect1070ui_story and not isNil(arg_441_1.actors_["1070ui_story"]) then
					arg_441_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_0)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1070ui_story"]) and arg_441_1.var_.characterEffect1070ui_story then
				arg_441_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_444_1 = 0
			local var_444_2 = 0.45

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
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

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(323071109).content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 18 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 18)

				if (18 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_3) / 18)) > 0 and var_444_2 < var_444_5 then
					arg_441_1.talkMaxDuration = var_444_5

					if var_444_5 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + var_444_1
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_6 = math.max(var_444_2, arg_441_1.talkMaxDuration)

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_6 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_1) / var_444_6

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_1 + var_444_6 and arg_441_1.time_ < var_444_1 + var_444_6 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play323071110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 323071110
		arg_445_1.duration_ = 7.07

		local var_445_0 = {
			zh = 5.433,
			ja = 7.066
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
				arg_445_0:Play323071111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1070ui_story"]) and arg_445_1.var_.characterEffect1070ui_story == nil then
				arg_445_1.var_.characterEffect1070ui_story = arg_445_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1070ui_story"]) then
				if arg_445_1.var_.characterEffect1070ui_story and not isNil(arg_445_1.actors_["1070ui_story"]) then
					arg_445_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1070ui_story"]) and arg_445_1.var_.characterEffect1070ui_story then
				arg_445_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_448_2 = 0
			local var_448_3 = 0.625

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_4 = arg_445_1:GetWordFromCfg(323071110)
				local var_448_5 = arg_445_1:FormatText(var_448_4.content)

				arg_445_1.text_.text = var_448_5

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 25 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 25)

				if (25 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 25)) > 0 and var_448_3 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_2
					end
				end

				arg_445_1.text_.text = var_448_5
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071110", "story_v_out_323071.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071110", "story_v_out_323071.awb") / 1000

					if var_448_8 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_2
					end

					if var_448_4.prefab_name ~= "" and arg_445_1.actors_[var_448_4.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_4.prefab_name].transform, "story_v_out_323071", "323071110", "story_v_out_323071.awb")

						arg_445_1:RecordAudio("323071110", var_448_9)
						arg_445_1:RecordAudio("323071110", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_323071", "323071110", "story_v_out_323071.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_323071", "323071110", "story_v_out_323071.awb")
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
	Play323071111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 323071111
		arg_449_1.duration_ = 2.5

		local var_449_0 = {
			zh = 1.933,
			ja = 2.5
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play323071112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["10171ui_story"]) and arg_449_1.var_.characterEffect10171ui_story == nil then
				arg_449_1.var_.characterEffect10171ui_story = arg_449_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["10171ui_story"]) then
				if arg_449_1.var_.characterEffect10171ui_story and not isNil(arg_449_1.actors_["10171ui_story"]) then
					arg_449_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["10171ui_story"]) and arg_449_1.var_.characterEffect10171ui_story then
				arg_449_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_452_2 = arg_449_1.actors_["1070ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_2) and arg_449_1.var_.characterEffect1070ui_story == nil then
				arg_449_1.var_.characterEffect1070ui_story = var_452_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_3 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_3 and not isNil(var_452_2) then
				if arg_449_1.var_.characterEffect1070ui_story and not isNil(var_452_2) then
					arg_449_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_3)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_3 and arg_449_1.time_ < 0 + var_452_3 + arg_452_0 and not isNil(var_452_2) and arg_449_1.var_.characterEffect1070ui_story then
				arg_449_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_452_4 = 0
			local var_452_5 = 0.225

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_4 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_6 = arg_449_1:GetWordFromCfg(323071111)
				local var_452_7 = arg_449_1:FormatText(var_452_6.content)

				arg_449_1.text_.text = var_452_7

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_9 = 9 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 9)

				if (9 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 9)) > 0 and var_452_5 < var_452_9 then
					arg_449_1.talkMaxDuration = var_452_9

					if var_452_9 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_9 + var_452_4
					end
				end

				arg_449_1.text_.text = var_452_7
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071111", "story_v_out_323071.awb") ~= 0 then
					local var_452_10 = manager.audio:GetVoiceLength("story_v_out_323071", "323071111", "story_v_out_323071.awb") / 1000

					if var_452_10 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_4
					end

					if var_452_6.prefab_name ~= "" and arg_449_1.actors_[var_452_6.prefab_name] ~= nil then
						local var_452_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_6.prefab_name].transform, "story_v_out_323071", "323071111", "story_v_out_323071.awb")

						arg_449_1:RecordAudio("323071111", var_452_11)
						arg_449_1:RecordAudio("323071111", var_452_11)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_323071", "323071111", "story_v_out_323071.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_323071", "323071111", "story_v_out_323071.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_12 = math.max(var_452_5, arg_449_1.talkMaxDuration)

			if var_452_4 <= arg_449_1.time_ and arg_449_1.time_ < var_452_4 + var_452_12 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_4) / var_452_12

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_4 + var_452_12 and arg_449_1.time_ < var_452_4 + var_452_12 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play323071112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 323071112
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play323071113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10171ui_story"]) and arg_453_1.var_.characterEffect10171ui_story == nil then
				arg_453_1.var_.characterEffect10171ui_story = arg_453_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_0 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10171ui_story"]) then
				if arg_453_1.var_.characterEffect10171ui_story and not isNil(arg_453_1.actors_["10171ui_story"]) then
					arg_453_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_453_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_0)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10171ui_story"]) and arg_453_1.var_.characterEffect10171ui_story then
				arg_453_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_453_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_456_1 = 0
			local var_456_2 = 1.075

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_3 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(323071112).content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 43 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 43)

				if (43 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 43)) > 0 and var_456_2 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_6 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_6 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_6

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_6 and arg_453_1.time_ < var_456_1 + var_456_6 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play323071113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 323071113
		arg_457_1.duration_ = 2.6

		local var_457_0 = {
			zh = 2.6,
			ja = 2.466
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play323071114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10171ui_story = arg_457_1.actors_["10171ui_story"].transform.localPosition

				local var_460_0 = GameObjectTools.GetOrAddComponent(arg_457_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_460_0 then
					var_460_0:EnableDynamicBone(false)
				end
			end

			local var_460_1 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_1 then
				arg_457_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_457_1.time_ - 0) / var_460_1)
				arg_457_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10171ui_story"].transform.position).z)
				arg_457_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10171ui_story"].transform.localEulerAngles = arg_457_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_1 and arg_457_1.time_ < 0 + var_460_1 + arg_460_0 then
				arg_457_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_457_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10171ui_story"].transform.position).z)
				arg_457_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10171ui_story"].transform.localEulerAngles = arg_457_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_460_2 = GameObjectTools.GetOrAddComponent(arg_457_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_460_2 then
					var_460_2:EnableDynamicBone(true)
				end
			end

			local var_460_3 = arg_457_1.actors_["10171ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_3) and arg_457_1.var_.characterEffect10171ui_story == nil then
				arg_457_1.var_.characterEffect10171ui_story = var_460_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_4 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 and not isNil(var_460_3) then
				if arg_457_1.var_.characterEffect10171ui_story and not isNil(var_460_3) then
					arg_457_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 and not isNil(var_460_3) and arg_457_1.var_.characterEffect10171ui_story then
				arg_457_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_460_6 = arg_457_1.actors_["1070ui_story"].transform

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1070ui_story = var_460_6.localPosition
			end

			local var_460_7 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				var_460_6.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 0) / var_460_7)
				var_460_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_6.position).x, (manager.ui.mainCamera.transform.position - var_460_6.position).y, (manager.ui.mainCamera.transform.position - var_460_6.position).z)
				var_460_6.localEulerAngles.z = 0
				var_460_6.localEulerAngles.x = 0
				var_460_6.localEulerAngles = var_460_6.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				var_460_6.localPosition = Vector3.New(0, 100, 0)
				var_460_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_6.position).x, (manager.ui.mainCamera.transform.position - var_460_6.position).y, (manager.ui.mainCamera.transform.position - var_460_6.position).z)
				var_460_6.localEulerAngles.z = 0
				var_460_6.localEulerAngles.x = 0
				var_460_6.localEulerAngles = var_460_6.localEulerAngles
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_460_8 = 0
			local var_460_9 = 0.325

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_8 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_10 = arg_457_1:GetWordFromCfg(323071113)
				local var_460_11 = arg_457_1:FormatText(var_460_10.content)

				arg_457_1.text_.text = var_460_11

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_13 = 13 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_11) / 13)

				if (13 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_11) / 13)) > 0 and var_460_9 < var_460_13 then
					arg_457_1.talkMaxDuration = var_460_13

					if var_460_13 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_13 + var_460_8
					end
				end

				arg_457_1.text_.text = var_460_11
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071113", "story_v_out_323071.awb") ~= 0 then
					local var_460_14 = manager.audio:GetVoiceLength("story_v_out_323071", "323071113", "story_v_out_323071.awb") / 1000

					if var_460_14 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_14 + var_460_8
					end

					if var_460_10.prefab_name ~= "" and arg_457_1.actors_[var_460_10.prefab_name] ~= nil then
						local var_460_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_10.prefab_name].transform, "story_v_out_323071", "323071113", "story_v_out_323071.awb")

						arg_457_1:RecordAudio("323071113", var_460_15)
						arg_457_1:RecordAudio("323071113", var_460_15)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_323071", "323071113", "story_v_out_323071.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_323071", "323071113", "story_v_out_323071.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_16 = math.max(var_460_9, arg_457_1.talkMaxDuration)

			if var_460_8 <= arg_457_1.time_ and arg_457_1.time_ < var_460_8 + var_460_16 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_8) / var_460_16

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_8 + var_460_16 and arg_457_1.time_ < var_460_8 + var_460_16 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play323071114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 323071114
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play323071115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10171ui_story"]) and arg_461_1.var_.characterEffect10171ui_story == nil then
				arg_461_1.var_.characterEffect10171ui_story = arg_461_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10171ui_story"]) then
				if arg_461_1.var_.characterEffect10171ui_story and not isNil(arg_461_1.actors_["10171ui_story"]) then
					arg_461_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10171ui_story"]) and arg_461_1.var_.characterEffect10171ui_story then
				arg_461_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 0.175

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(323071114).content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 7 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 7)

				if (7 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 7)) > 0 and var_464_2 < var_464_5 then
					arg_461_1.talkMaxDuration = var_464_5

					if var_464_5 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_6 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_6 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_6

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_6 and arg_461_1.time_ < var_464_1 + var_464_6 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play323071115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 323071115
		arg_465_1.duration_ = 6.57

		local var_465_0 = {
			zh = 5,
			ja = 6.566
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play323071116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["10171ui_story"]) and arg_465_1.var_.characterEffect10171ui_story == nil then
				arg_465_1.var_.characterEffect10171ui_story = arg_465_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["10171ui_story"]) then
				if arg_465_1.var_.characterEffect10171ui_story and not isNil(arg_465_1.actors_["10171ui_story"]) then
					arg_465_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["10171ui_story"]) and arg_465_1.var_.characterEffect10171ui_story then
				arg_465_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_468_2 = 0
			local var_468_3 = 0.7

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_4 = arg_465_1:GetWordFromCfg(323071115)
				local var_468_5 = arg_465_1:FormatText(var_468_4.content)

				arg_465_1.text_.text = var_468_5

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_7 = 28 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 28)

				if (28 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 28)) > 0 and var_468_3 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_5
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071115", "story_v_out_323071.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071115", "story_v_out_323071.awb") / 1000

					if var_468_8 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_2
					end

					if var_468_4.prefab_name ~= "" and arg_465_1.actors_[var_468_4.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_4.prefab_name].transform, "story_v_out_323071", "323071115", "story_v_out_323071.awb")

						arg_465_1:RecordAudio("323071115", var_468_9)
						arg_465_1:RecordAudio("323071115", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_323071", "323071115", "story_v_out_323071.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_323071", "323071115", "story_v_out_323071.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_10 and arg_465_1.time_ < var_468_2 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play323071116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 323071116
		arg_469_1.duration_ = 6.67

		local var_469_0 = {
			zh = 5.066,
			ja = 6.666
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
				arg_469_0:Play323071117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			local var_472_0 = 0
			local var_472_1 = 0.7

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_2 = arg_469_1:GetWordFromCfg(323071116)
				local var_472_3 = arg_469_1:FormatText(var_472_2.content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 28 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_3) / 28)

				if (28 <= 0 and var_472_1 or var_472_1 * (utf8.len(var_472_3) / 28)) > 0 and var_472_1 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_0
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071116", "story_v_out_323071.awb") ~= 0 then
					local var_472_6 = manager.audio:GetVoiceLength("story_v_out_323071", "323071116", "story_v_out_323071.awb") / 1000

					if var_472_6 + var_472_0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_6 + var_472_0
					end

					if var_472_2.prefab_name ~= "" and arg_469_1.actors_[var_472_2.prefab_name] ~= nil then
						local var_472_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_2.prefab_name].transform, "story_v_out_323071", "323071116", "story_v_out_323071.awb")

						arg_469_1:RecordAudio("323071116", var_472_7)
						arg_469_1:RecordAudio("323071116", var_472_7)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_323071", "323071116", "story_v_out_323071.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_323071", "323071116", "story_v_out_323071.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_1, arg_469_1.talkMaxDuration)

			if var_472_0 <= arg_469_1.time_ and arg_469_1.time_ < var_472_0 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_0) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_0 + var_472_8 and arg_469_1.time_ < var_472_0 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play323071117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 323071117
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play323071118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["10171ui_story"]) and arg_473_1.var_.characterEffect10171ui_story == nil then
				arg_473_1.var_.characterEffect10171ui_story = arg_473_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["10171ui_story"]) then
				if arg_473_1.var_.characterEffect10171ui_story and not isNil(arg_473_1.actors_["10171ui_story"]) then
					arg_473_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_473_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_0)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["10171ui_story"]) and arg_473_1.var_.characterEffect10171ui_story then
				arg_473_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_473_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0.166666666666667 < arg_473_1.time_ and arg_473_1.time_ <= 0.166666666666667 + arg_476_0 then
				arg_473_1:AudioAction("play", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_476_2 = 0
			local var_476_3 = 0.2

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
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

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_4 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(323071117).content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_6 = 8 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 8)

				if (8 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_4) / 8)) > 0 and var_476_3 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_7 and arg_473_1.time_ < var_476_2 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play323071118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 323071118
		arg_477_1.duration_ = 3.5

		local var_477_0 = {
			zh = 3.1,
			ja = 3.5
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play323071119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["10171ui_story"]) and arg_477_1.var_.characterEffect10171ui_story == nil then
				arg_477_1.var_.characterEffect10171ui_story = arg_477_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["10171ui_story"]) then
				if arg_477_1.var_.characterEffect10171ui_story and not isNil(arg_477_1.actors_["10171ui_story"]) then
					arg_477_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["10171ui_story"]) and arg_477_1.var_.characterEffect10171ui_story then
				arg_477_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_480_2 = 0
			local var_480_3 = 0.325

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_4 = arg_477_1:GetWordFromCfg(323071118)
				local var_480_5 = arg_477_1:FormatText(var_480_4.content)

				arg_477_1.text_.text = var_480_5

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 13 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 13)

				if (13 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 13)) > 0 and var_480_3 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_2
					end
				end

				arg_477_1.text_.text = var_480_5
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071118", "story_v_out_323071.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071118", "story_v_out_323071.awb") / 1000

					if var_480_8 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_2
					end

					if var_480_4.prefab_name ~= "" and arg_477_1.actors_[var_480_4.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_4.prefab_name].transform, "story_v_out_323071", "323071118", "story_v_out_323071.awb")

						arg_477_1:RecordAudio("323071118", var_480_9)
						arg_477_1:RecordAudio("323071118", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_323071", "323071118", "story_v_out_323071.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_323071", "323071118", "story_v_out_323071.awb")
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
	Play323071119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 323071119
		arg_481_1.duration_ = 6

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play323071120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos10171ui_story = arg_481_1.actors_["10171ui_story"].transform.localPosition

				local var_484_0 = GameObjectTools.GetOrAddComponent(arg_481_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_484_0 then
					var_484_0:EnableDynamicBone(false)
				end
			end

			local var_484_1 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_1 then
				arg_481_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_481_1.time_ - 0) / var_484_1)
				arg_481_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["10171ui_story"].transform.position).z)
				arg_481_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["10171ui_story"].transform.localEulerAngles = arg_481_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_1 and arg_481_1.time_ < 0 + var_484_1 + arg_484_0 then
				arg_481_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_481_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["10171ui_story"].transform.position).z)
				arg_481_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["10171ui_story"].transform.localEulerAngles = arg_481_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_484_2 = GameObjectTools.GetOrAddComponent(arg_481_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_484_2 then
					var_484_2:EnableDynamicBone(true)
				end
			end

			local var_484_3 = arg_481_1.actors_["10171ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_3) and arg_481_1.var_.characterEffect10171ui_story == nil then
				arg_481_1.var_.characterEffect10171ui_story = var_484_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_4 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 and not isNil(var_484_3) then
				if arg_481_1.var_.characterEffect10171ui_story and not isNil(var_484_3) then
					arg_481_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_481_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_4)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 and not isNil(var_484_3) and arg_481_1.var_.characterEffect10171ui_story then
				arg_481_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_481_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_484_5 = 0

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_5 + arg_484_0 then
				arg_481_1.allBtn_.enabled = false
			end

			if arg_481_1.time_ >= var_484_5 + 1.26666666666667 and arg_481_1.time_ < var_484_5 + 1.26666666666667 + arg_484_0 then
				arg_481_1.allBtn_.enabled = true
			end

			if 0.200000002980232 < arg_481_1.time_ and arg_481_1.time_ <= 0.200000002980232 + arg_484_0 then
				arg_481_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_plane01", "")
			end

			if arg_481_1.frameCnt_ <= 1 then
				arg_481_1.dialog_:SetActive(false)
			end

			local var_484_7 = 1
			local var_484_8 = 1.075

			if 1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_7 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0

				arg_481_1.dialog_:SetActive(true)

				arg_481_1.dialogCg_.alpha = 0

				local var_484_9 = LeanTween.value(arg_481_1.dialog_, 0, 1, 0.3)

				var_484_9:setOnUpdate(LuaHelper.FloatAction(function(arg_485_0)
					arg_481_1.dialogCg_.alpha = arg_485_0
				end))
				var_484_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_481_1.dialog_)
					var_484_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_481_1.duration_ = arg_481_1.duration_ + 0.3

				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_10 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(323071119).content)

				arg_481_1.text_.text = var_484_10

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_12 = 43 <= 0 and var_484_8 or var_484_8 * (utf8.len(var_484_10) / 43)

				if (43 <= 0 and var_484_8 or var_484_8 * (utf8.len(var_484_10) / 43)) > 0 and var_484_8 < var_484_12 then
					arg_481_1.talkMaxDuration = var_484_12
					var_484_7 = var_484_7 + 0.3

					if var_484_12 + var_484_7 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_12 + var_484_7
					end
				end

				arg_481_1.text_.text = var_484_10
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_13 = var_484_7 + 0.3
			local var_484_14 = math.max(var_484_8, arg_481_1.talkMaxDuration)

			if var_484_7 + 0.3 <= arg_481_1.time_ and arg_481_1.time_ < var_484_13 + var_484_14 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_13) / var_484_14

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_13 + var_484_14 and arg_481_1.time_ < var_484_13 + var_484_14 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play323071120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 323071120
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play323071121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if arg_487_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_490_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_487_1.stage_.transform)

				var_490_0.name = "1071ui_story"
				var_490_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_487_1.actors_["1071ui_story"] = var_490_0

				local var_490_1 = var_490_0:GetComponentInChildren(typeof(CharacterEffect))

				var_490_1.enabled = true

				local var_490_2 = GameObjectTools.GetOrAddComponent(var_490_0, typeof(DynamicBoneHelper))

				if var_490_2 then
					var_490_2:EnableDynamicBone(false)
				end

				arg_487_1:ShowWeapon(var_490_1.transform, false)

				arg_487_1.var_["1071ui_story" .. "Animator"] = var_490_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_487_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_487_1.var_["1071ui_story" .. "LipSync"] = var_490_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			if 0.166666666666667 < arg_487_1.time_ and arg_487_1.time_ <= 0.166666666666667 + arg_490_0 then
				arg_487_1:AudioAction("play", "effect", "se_story_145", "se_story_145_ui01", "")
			end

			local var_490_4 = 0
			local var_490_5 = 0.325

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_4 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_6 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(323071120).content)

				arg_487_1.text_.text = var_490_6

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_8 = 13 <= 0 and var_490_5 or var_490_5 * (utf8.len(var_490_6) / 13)

				if (13 <= 0 and var_490_5 or var_490_5 * (utf8.len(var_490_6) / 13)) > 0 and var_490_5 < var_490_8 then
					arg_487_1.talkMaxDuration = var_490_8

					if var_490_8 + var_490_4 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_8 + var_490_4
					end
				end

				arg_487_1.text_.text = var_490_6
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_9 = math.max(var_490_5, arg_487_1.talkMaxDuration)

			if var_490_4 <= arg_487_1.time_ and arg_487_1.time_ < var_490_4 + var_490_9 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_4) / var_490_9

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_4 + var_490_9 and arg_487_1.time_ < var_490_4 + var_490_9 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play323071121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 323071121
		arg_491_1.duration_ = 7.43

		local var_491_0 = {
			zh = 5.533,
			ja = 7.433
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play323071122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1071ui_story = arg_491_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_494_0 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 then
				arg_491_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_491_1.time_ - 0) / var_494_0)
				arg_491_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1071ui_story"].transform.position).z)
				arg_491_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1071ui_story"].transform.localEulerAngles = arg_491_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 then
				arg_491_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_491_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_491_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_491_1.actors_["1071ui_story"].transform.position).z)
				arg_491_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_491_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_491_1.actors_["1071ui_story"].transform.localEulerAngles = arg_491_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_494_1 = arg_491_1.actors_["1071ui_story"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1071ui_story == nil then
				arg_491_1.var_.characterEffect1071ui_story = var_494_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_2 and not isNil(var_494_1) then
				if arg_491_1.var_.characterEffect1071ui_story and not isNil(var_494_1) then
					arg_491_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_491_1.time_ >= 0 + var_494_2 and arg_491_1.time_ < 0 + var_494_2 + arg_494_0 and not isNil(var_494_1) and arg_491_1.var_.characterEffect1071ui_story then
				arg_491_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				if arg_491_1.var_.characterEffect1071ui_story == nil then
					arg_491_1.var_.characterEffect1071ui_story = arg_491_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_494_4 = arg_491_1.var_.characterEffect1071ui_story

				arg_491_1.var_.characterEffect1071ui_story.imageEffect:turnOff()

				var_494_4.interferenceEffect.enabled = true
				var_494_4.interferenceEffect.noise = 0.001
				var_494_4.interferenceEffect.simTimeScale = 1
				var_494_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				if arg_491_1.var_.characterEffect1071ui_story == nil then
					arg_491_1.var_.characterEffect1071ui_story = arg_491_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_491_1.var_.characterEffect1071ui_story.imageEffect:turnOn(false)
			end

			local var_494_6 = 0
			local var_494_7 = 0.6

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_6 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_8 = arg_491_1:GetWordFromCfg(323071121)
				local var_494_9 = arg_491_1:FormatText(var_494_8.content)

				arg_491_1.text_.text = var_494_9

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_11 = 24 <= 0 and var_494_7 or var_494_7 * (utf8.len(var_494_9) / 24)

				if (24 <= 0 and var_494_7 or var_494_7 * (utf8.len(var_494_9) / 24)) > 0 and var_494_7 < var_494_11 then
					arg_491_1.talkMaxDuration = var_494_11

					if var_494_11 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_11 + var_494_6
					end
				end

				arg_491_1.text_.text = var_494_9
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071121", "story_v_out_323071.awb") ~= 0 then
					local var_494_12 = manager.audio:GetVoiceLength("story_v_out_323071", "323071121", "story_v_out_323071.awb") / 1000

					if var_494_12 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_12 + var_494_6
					end

					if var_494_8.prefab_name ~= "" and arg_491_1.actors_[var_494_8.prefab_name] ~= nil then
						local var_494_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_8.prefab_name].transform, "story_v_out_323071", "323071121", "story_v_out_323071.awb")

						arg_491_1:RecordAudio("323071121", var_494_13)
						arg_491_1:RecordAudio("323071121", var_494_13)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_323071", "323071121", "story_v_out_323071.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_323071", "323071121", "story_v_out_323071.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_14 = math.max(var_494_7, arg_491_1.talkMaxDuration)

			if var_494_6 <= arg_491_1.time_ and arg_491_1.time_ < var_494_6 + var_494_14 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_6) / var_494_14

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_6 + var_494_14 and arg_491_1.time_ < var_494_6 + var_494_14 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play323071122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 323071122
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play323071123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["1071ui_story"]) and arg_495_1.var_.characterEffect1071ui_story == nil then
				arg_495_1.var_.characterEffect1071ui_story = arg_495_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_0 = 0.200000002980232

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["1071ui_story"]) then
				if arg_495_1.var_.characterEffect1071ui_story and not isNil(arg_495_1.actors_["1071ui_story"]) then
					arg_495_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_495_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_495_1.time_ - 0) / var_498_0)
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["1071ui_story"]) and arg_495_1.var_.characterEffect1071ui_story then
				arg_495_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_495_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_498_1 = 0
			local var_498_2 = 0.25

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_3 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(323071122).content)

				arg_495_1.text_.text = var_498_3

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 10 <= 0 and var_498_2 or var_498_2 * (utf8.len(var_498_3) / 10)

				if (10 <= 0 and var_498_2 or var_498_2 * (utf8.len(var_498_3) / 10)) > 0 and var_498_2 < var_498_5 then
					arg_495_1.talkMaxDuration = var_498_5

					if var_498_5 + var_498_1 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_5 + var_498_1
					end
				end

				arg_495_1.text_.text = var_498_3
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_6 = math.max(var_498_2, arg_495_1.talkMaxDuration)

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_6 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_1) / var_498_6

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_1 + var_498_6 and arg_495_1.time_ < var_498_1 + var_498_6 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play323071123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 323071123
		arg_499_1.duration_ = 2.63

		local var_499_0 = {
			zh = 2.4,
			ja = 2.633
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play323071124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1071ui_story"]) and arg_499_1.var_.characterEffect1071ui_story == nil then
				arg_499_1.var_.characterEffect1071ui_story = arg_499_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_0 = 0.200000002980232

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1071ui_story"]) then
				if arg_499_1.var_.characterEffect1071ui_story and not isNil(arg_499_1.actors_["1071ui_story"]) then
					arg_499_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1071ui_story"]) and arg_499_1.var_.characterEffect1071ui_story then
				arg_499_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_502_2 = 0
			local var_502_3 = 0.15

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_2 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_4 = arg_499_1:GetWordFromCfg(323071123)
				local var_502_5 = arg_499_1:FormatText(var_502_4.content)

				arg_499_1.text_.text = var_502_5

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_7 = 6 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 6)

				if (6 <= 0 and var_502_3 or var_502_3 * (utf8.len(var_502_5) / 6)) > 0 and var_502_3 < var_502_7 then
					arg_499_1.talkMaxDuration = var_502_7

					if var_502_7 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_7 + var_502_2
					end
				end

				arg_499_1.text_.text = var_502_5
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323071", "323071123", "story_v_out_323071.awb") ~= 0 then
					local var_502_8 = manager.audio:GetVoiceLength("story_v_out_323071", "323071123", "story_v_out_323071.awb") / 1000

					if var_502_8 + var_502_2 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_8 + var_502_2
					end

					if var_502_4.prefab_name ~= "" and arg_499_1.actors_[var_502_4.prefab_name] ~= nil then
						local var_502_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_4.prefab_name].transform, "story_v_out_323071", "323071123", "story_v_out_323071.awb")

						arg_499_1:RecordAudio("323071123", var_502_9)
						arg_499_1:RecordAudio("323071123", var_502_9)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_323071", "323071123", "story_v_out_323071.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_323071", "323071123", "story_v_out_323071.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_10 = math.max(var_502_3, arg_499_1.talkMaxDuration)

			if var_502_2 <= arg_499_1.time_ and arg_499_1.time_ < var_502_2 + var_502_10 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_2) / var_502_10

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_2 + var_502_10 and arg_499_1.time_ < var_502_2 + var_502_10 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play323071124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 323071124
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play323071125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1071ui_story"]) and arg_503_1.var_.characterEffect1071ui_story == nil then
				arg_503_1.var_.characterEffect1071ui_story = arg_503_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_0 = 0.200000002980232

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1071ui_story"]) then
				if arg_503_1.var_.characterEffect1071ui_story and not isNil(arg_503_1.actors_["1071ui_story"]) then
					arg_503_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_503_1.time_ - 0) / var_506_0)
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1071ui_story"]) and arg_503_1.var_.characterEffect1071ui_story then
				arg_503_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_506_1 = 0
			local var_506_2 = 0.2

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_3 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(323071124).content)

				arg_503_1.text_.text = var_506_3

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_5 = 8 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 8)

				if (8 <= 0 and var_506_2 or var_506_2 * (utf8.len(var_506_3) / 8)) > 0 and var_506_2 < var_506_5 then
					arg_503_1.talkMaxDuration = var_506_5

					if var_506_5 + var_506_1 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + var_506_1
					end
				end

				arg_503_1.text_.text = var_506_3
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_6 = math.max(var_506_2, arg_503_1.talkMaxDuration)

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_6 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_1) / var_506_6

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_1 + var_506_6 and arg_503_1.time_ < var_506_1 + var_506_6 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play323071125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 323071125
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play323071126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos1071ui_story = arg_507_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_510_0 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 then
				arg_507_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_507_1.time_ - 0) / var_510_0)
				arg_507_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1071ui_story"].transform.position).z)
				arg_507_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1071ui_story"].transform.localEulerAngles = arg_507_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 then
				arg_507_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_507_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_507_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_507_1.actors_["1071ui_story"].transform.position).z)
				arg_507_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_507_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_507_1.actors_["1071ui_story"].transform.localEulerAngles = arg_507_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_510_1 = 0
			local var_510_2 = 1.45

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(323071125).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 58 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 58)

				if (58 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 58)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play323071126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 323071126
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
			arg_511_1.auto_ = false
		end

		function arg_511_1.playNext_(arg_513_0)
			arg_511_1.onStoryFinished_()
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0.8

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_1 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(323071126).content)

				arg_511_1.text_.text = var_514_1

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_3 = 32 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 32)

				if (32 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 32)) > 0 and var_514_0 < var_514_3 then
					arg_511_1.talkMaxDuration = var_514_3

					if var_514_3 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_3 + 0
					end
				end

				arg_511_1.text_.text = var_514_1
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_4 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_4

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J24f"
	},
	voices = {
		"story_v_out_323071.awb"
	}
}
