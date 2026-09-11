return {
	Play102071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play102071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_fight_metal", "")
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

			local var_4_9 = "S0202"

			if arg_1_1.bgs_.S0202 == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.S0202

				arg_1_1.bgs_.S0202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0202" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_14 = manager.ui.mainCamera.transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.shakeOldPosMainCamera = var_4_14.localPosition
			end

			local var_4_15 = 0.600000023841858

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 then
				local var_4_16, var_4_17 = math.modf((arg_1_1.time_ - 1.8) / 0.066)

				var_4_14.localPosition = Vector3.New(var_4_17 * 0.13, var_4_17 * 0.13, var_4_17 * 0.13) + arg_1_1.var_.shakeOldPosMainCamera
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 then
				var_4_14.localPosition = arg_1_1.var_.shakeOldPosMainCamera
			end

			local var_4_18 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_18 + 0.400000023841858 and arg_1_1.time_ < var_4_18 + 0.400000023841858 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102071001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 6 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 6)

				if (6 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 6)) > 0 and var_4_20 < var_4_24 then
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

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play102071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 102071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play102071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_9000

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story", "se_story_fight_metal", "")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				local var_11_1 = arg_8_1.var_.effectMainCamera1048镜头前特效

				if not arg_8_1.var_.effectMainCamera1048镜头前特效 then
					var_11_1 = Object.Instantiate(Asset.Load("Effect/Hero/1048/fx_1048_ui_001"), manager.ui.mainCamera.transform)
					var_11_1.name = "1048镜头前特效"
					arg_8_1.var_.effectMainCamera1048镜头前特效 = var_11_1
				else
					var_11_1.transform:SetParent(var_11_9000)
				end

				var_11_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_11_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_11_3 = 0
			local var_11_4 = 0.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_3 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_5 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(102071002).content)

				arg_8_1.text_.text = var_11_5

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_7 = 8 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 8)

				if (8 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 8)) > 0 and var_11_4 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_3 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_3
					end
				end

				arg_8_1.text_.text = var_11_5
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_4, arg_8_1.talkMaxDuration)

			if var_11_3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_3 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_3) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_3 + var_11_8 and arg_8_1.time_ < var_11_3 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play102071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 102071003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play102071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.625

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(102071003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 25 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 25)

				if (25 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 25)) > 0 and var_15_0 < var_15_3 then
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
	Play102071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102071004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play102071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_19_0 = 0.600000023841858

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				local var_19_1, var_19_2 = math.modf((arg_16_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_19_2 * 0.13, var_19_2 * 0.13, var_19_2 * 0.13) + arg_16_1.var_.shakeOldPosMainCamera
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				manager.ui.mainCamera.transform.localPosition = arg_16_1.var_.shakeOldPosMainCamera
			end

			local var_19_3 = 0
			local var_19_4 = 1.025

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_5 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(102071004).content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 41 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_5) / 41)

				if (41 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_5) / 41)) > 0 and var_19_4 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_3
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_4, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_3) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_8 and arg_16_1.time_ < var_19_3 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play102071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102071005
		arg_20_1.duration_ = 2.63

		local var_20_0 = {
			ja = 2.633,
			ko = 1.733,
			zh = 2.266,
			en = 1.3
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play102071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.15

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(102071005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 6 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 6)

				if (6 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 6)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071005", "story_v_out_102071.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071005", "story_v_out_102071.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_102071", "102071005", "story_v_out_102071.awb")

						arg_20_1:RecordAudio("102071005", var_23_6)
						arg_20_1:RecordAudio("102071005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102071", "102071005", "story_v_out_102071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102071", "102071005", "story_v_out_102071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play102071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102071006
		arg_24_1.duration_ = 2.5

		local var_24_0 = {
			ja = 2.5,
			ko = 1.933,
			zh = 2.166,
			en = 2.3
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play102071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "1084ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1084ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["1084ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["1084ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_27_3 = 0
			local var_27_4 = 0.15

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_3 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_5 = arg_24_1:GetWordFromCfg(102071006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 6 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 6)

				if (6 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 6)) > 0 and var_27_4 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_3
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071006", "story_v_out_102071.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_102071", "102071006", "story_v_out_102071.awb") / 1000

					if var_27_9 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_3
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_102071", "102071006", "story_v_out_102071.awb")

						arg_24_1:RecordAudio("102071006", var_27_10)
						arg_24_1:RecordAudio("102071006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_102071", "102071006", "story_v_out_102071.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_102071", "102071006", "story_v_out_102071.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_4, arg_24_1.talkMaxDuration)

			if var_27_3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_3 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_3) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_3 + var_27_11 and arg_24_1.time_ < var_27_3 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play102071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102071007
		arg_28_1.duration_ = 3.8

		local var_28_0 = {
			ja = 3.4,
			ko = 3.1,
			zh = 3.1,
			en = 3.8
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play102071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1019ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1019ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1019ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1019ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_31_3 = 0
			local var_31_4 = 0.4

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_5 = arg_28_1:GetWordFromCfg(102071007)
				local var_31_6 = arg_28_1:FormatText(var_31_5.content)

				arg_28_1.text_.text = var_31_6

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_8 = 16 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 16)

				if (16 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 16)) > 0 and var_31_4 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8

					if var_31_8 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_6
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071007", "story_v_out_102071.awb") ~= 0 then
					local var_31_9 = manager.audio:GetVoiceLength("story_v_out_102071", "102071007", "story_v_out_102071.awb") / 1000

					if var_31_9 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_3
					end

					if var_31_5.prefab_name ~= "" and arg_28_1.actors_[var_31_5.prefab_name] ~= nil then
						local var_31_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_5.prefab_name].transform, "story_v_out_102071", "102071007", "story_v_out_102071.awb")

						arg_28_1:RecordAudio("102071007", var_31_10)
						arg_28_1:RecordAudio("102071007", var_31_10)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_102071", "102071007", "story_v_out_102071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_102071", "102071007", "story_v_out_102071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_11 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_11 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_3) / var_31_11

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_11 and arg_28_1.time_ < var_31_3 + var_31_11 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play102071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102071008
		arg_32_1.duration_ = 3.9

		local var_32_0 = {
			ja = 3.9,
			ko = 3.7,
			zh = 3.8,
			en = 2.066
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play102071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_35_0 = 0
			local var_35_1 = 0.325

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_2 = arg_32_1:GetWordFromCfg(102071008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 13 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 13)

				if (13 <= 0 and var_35_1 or var_35_1 * (utf8.len(var_35_3) / 13)) > 0 and var_35_1 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071008", "story_v_out_102071.awb") ~= 0 then
					local var_35_6 = manager.audio:GetVoiceLength("story_v_out_102071", "102071008", "story_v_out_102071.awb") / 1000

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end

					if var_35_2.prefab_name ~= "" and arg_32_1.actors_[var_35_2.prefab_name] ~= nil then
						local var_35_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_2.prefab_name].transform, "story_v_out_102071", "102071008", "story_v_out_102071.awb")

						arg_32_1:RecordAudio("102071008", var_35_7)
						arg_32_1:RecordAudio("102071008", var_35_7)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102071", "102071008", "story_v_out_102071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102071", "102071008", "story_v_out_102071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_8 and arg_32_1.time_ < var_35_0 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play102071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102071009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play102071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.4

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(102071009).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 16 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 16)

				if (16 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 16)) > 0 and var_39_0 < var_39_3 then
					arg_36_1.talkMaxDuration = var_39_3

					if var_39_3 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_3 + 0
					end
				end

				arg_36_1.text_.text = var_39_1
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_4 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_4

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play102071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102071010
		arg_40_1.duration_ = 5.13

		local var_40_0 = {
			ja = 5.133,
			ko = 3.466,
			zh = 4.1,
			en = 3.766
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play102071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.3

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(102071010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 12 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 12)

				if (12 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 12)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071010", "story_v_out_102071.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071010", "story_v_out_102071.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_102071", "102071010", "story_v_out_102071.awb")

						arg_40_1:RecordAudio("102071010", var_43_6)
						arg_40_1:RecordAudio("102071010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102071", "102071010", "story_v_out_102071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102071", "102071010", "story_v_out_102071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play102071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102071011
		arg_44_1.duration_ = 9

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play102071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.bgs_.B02a == nil then
				local var_47_0 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B02a")
				var_47_0.name = "B02a"
				var_47_0.transform.parent = arg_44_1.stage_.transform
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_.B02a = var_47_0
			end

			if 2 < arg_44_1.time_ and arg_44_1.time_ <= 2 + arg_47_0 then
				local var_47_1 = arg_44_1.bgs_.B02a

				arg_44_1.bgs_.B02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_2 = var_47_1:GetComponent("SpriteRenderer")

				if var_47_2 and var_47_2.sprite then
					local var_47_3 = 2 * (var_47_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_1.transform.localScale = Vector3.New(var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "B02a" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_4 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_5 = 2

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_5 then
				local var_47_6 = Color.New(0, 0, 0)

				var_47_6.a = Mathf.Lerp(0, 1, (arg_44_1.time_ - var_47_4) / var_47_5)
				arg_44_1.mask_.color = var_47_6
			end

			if arg_44_1.time_ >= var_47_4 + var_47_5 and arg_44_1.time_ < var_47_4 + var_47_5 + arg_47_0 then
				local var_47_7 = Color.New(0, 0, 0)

				var_47_7.a = 1
				arg_44_1.mask_.color = var_47_7
			end

			local var_47_8 = 2

			if 2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_9 = 2

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_9 then
				local var_47_10 = Color.New(0, 0, 0)

				var_47_10.a = Mathf.Lerp(1, 0, (arg_44_1.time_ - var_47_8) / var_47_9)
				arg_44_1.mask_.color = var_47_10
			end

			if arg_44_1.time_ >= var_47_8 + var_47_9 and arg_44_1.time_ < var_47_8 + var_47_9 + arg_47_0 then
				local var_47_11 = Color.New(0, 0, 0)

				arg_44_1.mask_.enabled = false
				var_47_11.a = 0
				arg_44_1.mask_.color = var_47_11
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_12 = 4
			local var_47_13 = 0.95

			if 4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_14 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_14:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(102071011).content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 38 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 38)

				if (38 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 38)) > 0 and var_47_13 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17
					var_47_12 = var_47_12 + 0.3

					if var_47_17 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_18 = var_47_12 + 0.3
			local var_47_19 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 + 0.3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_18 + var_47_19 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_18) / var_47_19

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_18 + var_47_19 and arg_44_1.time_ < var_47_18 + var_47_19 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play102071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 102071012
		arg_50_1.duration_ = 9.57

		local var_50_0 = {
			ja = 9.566,
			ko = 6.5,
			zh = 8.633,
			en = 7.3
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play102071014(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_53_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_50_1.stage_.transform)

				var_53_0.name = "3008ui_story"
				var_53_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.actors_["3008ui_story"] = var_53_0

				local var_53_1 = var_53_0:GetComponentInChildren(typeof(CharacterEffect))

				var_53_1.enabled = true

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_0, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end

				arg_50_1:ShowWeapon(var_53_1.transform, false)

				arg_50_1.var_["3008ui_story" .. "Animator"] = var_53_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_50_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_50_1.var_["3008ui_story" .. "LipSync"] = var_53_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_53_3 = arg_50_1.actors_["3008ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect3008ui_story == nil then
				arg_50_1.var_.characterEffect3008ui_story = var_53_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_4 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 and not isNil(var_53_3) then
				if arg_50_1.var_.characterEffect3008ui_story and not isNil(var_53_3) then
					arg_50_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 and not isNil(var_53_3) and arg_50_1.var_.characterEffect3008ui_story then
				arg_50_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_53_6 = arg_50_1.actors_["3008ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos3008ui_story = var_53_6.localPosition
			end

			local var_53_7 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				var_53_6.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_50_1.time_ - 0) / var_53_7)
				var_53_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_6.position).x, (manager.ui.mainCamera.transform.position - var_53_6.position).y, (manager.ui.mainCamera.transform.position - var_53_6.position).z)
				var_53_6.localEulerAngles.z = 0
				var_53_6.localEulerAngles.x = 0
				var_53_6.localEulerAngles = var_53_6.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				var_53_6.localPosition = Vector3.New(0, -1.51, -4.3)
				var_53_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_6.position).x, (manager.ui.mainCamera.transform.position - var_53_6.position).y, (manager.ui.mainCamera.transform.position - var_53_6.position).z)
				var_53_6.localEulerAngles.z = 0
				var_53_6.localEulerAngles.x = 0
				var_53_6.localEulerAngles = var_53_6.localEulerAngles
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_53_8 = 0
			local var_53_9 = 0.825

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_8 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_10 = arg_50_1:GetWordFromCfg(102071012)
				local var_53_11 = arg_50_1:FormatText(var_53_10.content)

				arg_50_1.text_.text = var_53_11

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_13 = 33 <= 0 and var_53_9 or var_53_9 * (utf8.len(var_53_11) / 33)

				if (33 <= 0 and var_53_9 or var_53_9 * (utf8.len(var_53_11) / 33)) > 0 and var_53_9 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_8
					end
				end

				arg_50_1.text_.text = var_53_11
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071012", "story_v_out_102071.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_102071", "102071012", "story_v_out_102071.awb") / 1000

					if var_53_14 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_8
					end

					if var_53_10.prefab_name ~= "" and arg_50_1.actors_[var_53_10.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_10.prefab_name].transform, "story_v_out_102071", "102071012", "story_v_out_102071.awb")

						arg_50_1:RecordAudio("102071012", var_53_15)
						arg_50_1:RecordAudio("102071012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_102071", "102071012", "story_v_out_102071.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_102071", "102071012", "story_v_out_102071.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_9, arg_50_1.talkMaxDuration)

			if var_53_8 <= arg_50_1.time_ and arg_50_1.time_ < var_53_8 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_8) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_8 + var_53_16 and arg_50_1.time_ < var_53_8 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play102071014 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 102071014
		arg_54_1.duration_ = 7.57

		local var_54_0 = {
			ja = 7.566,
			ko = 4.9,
			zh = 4.8,
			en = 5.366
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
				arg_54_0:Play102071015(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_57_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_54_1.stage_.transform)

				var_57_0.name = "1011ui_story"
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.actors_["1011ui_story"] = var_57_0

				local var_57_1 = var_57_0:GetComponentInChildren(typeof(CharacterEffect))

				var_57_1.enabled = true

				local var_57_2 = GameObjectTools.GetOrAddComponent(var_57_0, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(false)
				end

				arg_54_1:ShowWeapon(var_57_1.transform, false)

				arg_54_1.var_["1011ui_story" .. "Animator"] = var_57_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_54_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_54_1.var_["1011ui_story" .. "LipSync"] = var_57_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_57_3 = arg_54_1.actors_["1011ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_3) and arg_54_1.var_.characterEffect1011ui_story == nil then
				arg_54_1.var_.characterEffect1011ui_story = var_57_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_4 = 0.1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 and not isNil(var_57_3) then
				if arg_54_1.var_.characterEffect1011ui_story and not isNil(var_57_3) then
					arg_54_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 and not isNil(var_57_3) and arg_54_1.var_.characterEffect1011ui_story then
				arg_54_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_57_6 = arg_54_1.actors_["3008ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_6) and arg_54_1.var_.characterEffect3008ui_story == nil then
				arg_54_1.var_.characterEffect3008ui_story = var_57_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_7 = 0.1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 and not isNil(var_57_6) then
				if arg_54_1.var_.characterEffect3008ui_story and not isNil(var_57_6) then
					arg_54_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_54_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_7)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 and not isNil(var_57_6) and arg_54_1.var_.characterEffect3008ui_story then
				arg_54_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_54_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_57_8 = arg_54_1.actors_["3008ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos3008ui_story = var_57_8.localPosition
			end

			local var_57_9 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_9 then
				var_57_8.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_54_1.time_ - 0) / var_57_9)
				var_57_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_8.position).x, (manager.ui.mainCamera.transform.position - var_57_8.position).y, (manager.ui.mainCamera.transform.position - var_57_8.position).z)
				var_57_8.localEulerAngles.z = 0
				var_57_8.localEulerAngles.x = 0
				var_57_8.localEulerAngles = var_57_8.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_9 and arg_54_1.time_ < 0 + var_57_9 + arg_57_0 then
				var_57_8.localPosition = Vector3.New(0, 100, 0)
				var_57_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_8.position).x, (manager.ui.mainCamera.transform.position - var_57_8.position).y, (manager.ui.mainCamera.transform.position - var_57_8.position).z)
				var_57_8.localEulerAngles.z = 0
				var_57_8.localEulerAngles.x = 0
				var_57_8.localEulerAngles = var_57_8.localEulerAngles
			end

			local var_57_10 = arg_54_1.actors_["1011ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1011ui_story = var_57_10.localPosition
			end

			local var_57_11 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_11 then
				var_57_10.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_54_1.time_ - 0) / var_57_11)
				var_57_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_10.position).x, (manager.ui.mainCamera.transform.position - var_57_10.position).y, (manager.ui.mainCamera.transform.position - var_57_10.position).z)
				var_57_10.localEulerAngles.z = 0
				var_57_10.localEulerAngles.x = 0
				var_57_10.localEulerAngles = var_57_10.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_11 and arg_54_1.time_ < 0 + var_57_11 + arg_57_0 then
				var_57_10.localPosition = Vector3.New(0, -0.71, -6)
				var_57_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_10.position).x, (manager.ui.mainCamera.transform.position - var_57_10.position).y, (manager.ui.mainCamera.transform.position - var_57_10.position).z)
				var_57_10.localEulerAngles.z = 0
				var_57_10.localEulerAngles.x = 0
				var_57_10.localEulerAngles = var_57_10.localEulerAngles
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_57_12 = 0
			local var_57_13 = 0.525

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_12 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_14 = arg_54_1:GetWordFromCfg(102071014)
				local var_57_15 = arg_54_1:FormatText(var_57_14.content)

				arg_54_1.text_.text = var_57_15

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_17 = 21 <= 0 and var_57_13 or var_57_13 * (utf8.len(var_57_15) / 21)

				if (21 <= 0 and var_57_13 or var_57_13 * (utf8.len(var_57_15) / 21)) > 0 and var_57_13 < var_57_17 then
					arg_54_1.talkMaxDuration = var_57_17

					if var_57_17 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_17 + var_57_12
					end
				end

				arg_54_1.text_.text = var_57_15
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071014", "story_v_out_102071.awb") ~= 0 then
					local var_57_18 = manager.audio:GetVoiceLength("story_v_out_102071", "102071014", "story_v_out_102071.awb") / 1000

					if var_57_18 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_18 + var_57_12
					end

					if var_57_14.prefab_name ~= "" and arg_54_1.actors_[var_57_14.prefab_name] ~= nil then
						local var_57_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_14.prefab_name].transform, "story_v_out_102071", "102071014", "story_v_out_102071.awb")

						arg_54_1:RecordAudio("102071014", var_57_19)
						arg_54_1:RecordAudio("102071014", var_57_19)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_102071", "102071014", "story_v_out_102071.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_102071", "102071014", "story_v_out_102071.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_20 = math.max(var_57_13, arg_54_1.talkMaxDuration)

			if var_57_12 <= arg_54_1.time_ and arg_54_1.time_ < var_57_12 + var_57_20 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_12) / var_57_20

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_12 + var_57_20 and arg_54_1.time_ < var_57_12 + var_57_20 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play102071015 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 102071015
		arg_58_1.duration_ = 17.1

		local var_58_0 = {
			ja = 17.1,
			ko = 12.733,
			zh = 10.4,
			en = 13.2
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
				arg_58_0:Play102071016(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["3008ui_story"]) and arg_58_1.var_.characterEffect3008ui_story == nil then
				arg_58_1.var_.characterEffect3008ui_story = arg_58_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.1

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["3008ui_story"]) then
				if arg_58_1.var_.characterEffect3008ui_story and not isNil(arg_58_1.actors_["3008ui_story"]) then
					arg_58_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["3008ui_story"]) and arg_58_1.var_.characterEffect3008ui_story then
				arg_58_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_61_2 = arg_58_1.actors_["1011ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1011ui_story == nil then
				arg_58_1.var_.characterEffect1011ui_story = var_61_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_3 = 0.1

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.characterEffect1011ui_story and not isNil(var_61_2) then
					arg_58_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_3)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1011ui_story then
				arg_58_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_61_4 = arg_58_1.actors_["1011ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1011ui_story = var_61_4.localPosition
			end

			local var_61_5 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_5 then
				var_61_4.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_5)
				var_61_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_4.position).x, (manager.ui.mainCamera.transform.position - var_61_4.position).y, (manager.ui.mainCamera.transform.position - var_61_4.position).z)
				var_61_4.localEulerAngles.z = 0
				var_61_4.localEulerAngles.x = 0
				var_61_4.localEulerAngles = var_61_4.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_5 and arg_58_1.time_ < 0 + var_61_5 + arg_61_0 then
				var_61_4.localPosition = Vector3.New(0, 100, 0)
				var_61_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_4.position).x, (manager.ui.mainCamera.transform.position - var_61_4.position).y, (manager.ui.mainCamera.transform.position - var_61_4.position).z)
				var_61_4.localEulerAngles.z = 0
				var_61_4.localEulerAngles.x = 0
				var_61_4.localEulerAngles = var_61_4.localEulerAngles
			end

			local var_61_6 = arg_58_1.actors_["3008ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos3008ui_story = var_61_6.localPosition
			end

			local var_61_7 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				var_61_6.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_58_1.time_ - 0) / var_61_7)
				var_61_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_6.position).x, (manager.ui.mainCamera.transform.position - var_61_6.position).y, (manager.ui.mainCamera.transform.position - var_61_6.position).z)
				var_61_6.localEulerAngles.z = 0
				var_61_6.localEulerAngles.x = 0
				var_61_6.localEulerAngles = var_61_6.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				var_61_6.localPosition = Vector3.New(0, -1.51, -4.3)
				var_61_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_6.position).x, (manager.ui.mainCamera.transform.position - var_61_6.position).y, (manager.ui.mainCamera.transform.position - var_61_6.position).z)
				var_61_6.localEulerAngles.z = 0
				var_61_6.localEulerAngles.x = 0
				var_61_6.localEulerAngles = var_61_6.localEulerAngles
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_61_8 = 0
			local var_61_9 = 1.35

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_8 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_10 = arg_58_1:GetWordFromCfg(102071015)
				local var_61_11 = arg_58_1:FormatText(var_61_10.content)

				arg_58_1.text_.text = var_61_11

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_13 = 54 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 54)

				if (54 <= 0 and var_61_9 or var_61_9 * (utf8.len(var_61_11) / 54)) > 0 and var_61_9 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_8
					end
				end

				arg_58_1.text_.text = var_61_11
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071015", "story_v_out_102071.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_out_102071", "102071015", "story_v_out_102071.awb") / 1000

					if var_61_14 + var_61_8 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_8
					end

					if var_61_10.prefab_name ~= "" and arg_58_1.actors_[var_61_10.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_10.prefab_name].transform, "story_v_out_102071", "102071015", "story_v_out_102071.awb")

						arg_58_1:RecordAudio("102071015", var_61_15)
						arg_58_1:RecordAudio("102071015", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_102071", "102071015", "story_v_out_102071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_102071", "102071015", "story_v_out_102071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_9, arg_58_1.talkMaxDuration)

			if var_61_8 <= arg_58_1.time_ and arg_58_1.time_ < var_61_8 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_8) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_8 + var_61_16 and arg_58_1.time_ < var_61_8 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play102071016 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 102071016
		arg_62_1.duration_ = 6.07

		local var_62_0 = {
			ja = 6.066,
			ko = 2.933,
			zh = 3.266,
			en = 4
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play102071017(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) and arg_62_1.var_.characterEffect1019ui_story == nil then
				arg_62_1.var_.characterEffect1019ui_story = arg_62_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) then
				if arg_62_1.var_.characterEffect1019ui_story and not isNil(arg_62_1.actors_["1019ui_story"]) then
					arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) and arg_62_1.var_.characterEffect1019ui_story then
				arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_65_2 = arg_62_1.actors_["3008ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = var_65_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_3 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.characterEffect3008ui_story and not isNil(var_65_2) then
					arg_62_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_62_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_3)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect3008ui_story then
				arg_62_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_62_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_65_4 = arg_62_1.actors_["3008ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos3008ui_story = var_65_4.localPosition
			end

			local var_65_5 = 0.5

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_5 then
				var_65_4.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos3008ui_story, Vector3.New(0.7, -1.51, -4.3), (arg_62_1.time_ - 0) / var_65_5)
				var_65_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_4.position).x, (manager.ui.mainCamera.transform.position - var_65_4.position).y, (manager.ui.mainCamera.transform.position - var_65_4.position).z)
				var_65_4.localEulerAngles.z = 0
				var_65_4.localEulerAngles.x = 0
				var_65_4.localEulerAngles = var_65_4.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_5 and arg_62_1.time_ < 0 + var_65_5 + arg_65_0 then
				var_65_4.localPosition = Vector3.New(0.7, -1.51, -4.3)
				var_65_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_4.position).x, (manager.ui.mainCamera.transform.position - var_65_4.position).y, (manager.ui.mainCamera.transform.position - var_65_4.position).z)
				var_65_4.localEulerAngles.z = 0
				var_65_4.localEulerAngles.x = 0
				var_65_4.localEulerAngles = var_65_4.localEulerAngles
			end

			local var_65_6 = arg_62_1.actors_["1019ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1019ui_story = var_65_6.localPosition
			end

			local var_65_7 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				var_65_6.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_62_1.time_ - 0) / var_65_7)
				var_65_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_6.position).x, (manager.ui.mainCamera.transform.position - var_65_6.position).y, (manager.ui.mainCamera.transform.position - var_65_6.position).z)
				var_65_6.localEulerAngles.z = 0
				var_65_6.localEulerAngles.x = 0
				var_65_6.localEulerAngles = var_65_6.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				var_65_6.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_65_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_6.position).x, (manager.ui.mainCamera.transform.position - var_65_6.position).y, (manager.ui.mainCamera.transform.position - var_65_6.position).z)
				var_65_6.localEulerAngles.z = 0
				var_65_6.localEulerAngles.x = 0
				var_65_6.localEulerAngles = var_65_6.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_65_8 = 0
			local var_65_9 = 0.425

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(102071016)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 17 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 17)

				if (17 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 17)) > 0 and var_65_9 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071016", "story_v_out_102071.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_102071", "102071016", "story_v_out_102071.awb") / 1000

					if var_65_14 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_8
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_out_102071", "102071016", "story_v_out_102071.awb")

						arg_62_1:RecordAudio("102071016", var_65_15)
						arg_62_1:RecordAudio("102071016", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_102071", "102071016", "story_v_out_102071.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_102071", "102071016", "story_v_out_102071.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_16 and arg_62_1.time_ < var_65_8 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play102071017 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 102071017
		arg_66_1.duration_ = 4.6

		local var_66_0 = {
			ja = 4.6,
			ko = 3.766,
			zh = 3.966,
			en = 4.166
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
				arg_66_0:Play102071018(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = arg_66_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) then
				if arg_66_1.var_.characterEffect3008ui_story and not isNil(arg_66_1.actors_["3008ui_story"]) then
					arg_66_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) and arg_66_1.var_.characterEffect3008ui_story then
				arg_66_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_69_2 = arg_66_1.actors_["1019ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_3 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_2) then
					arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_3)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.characterEffect1019ui_story then
				arg_66_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_69_4 = 0
			local var_69_5 = 0.375

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(102071017)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 15 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 15)

				if (15 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 15)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071017", "story_v_out_102071.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_102071", "102071017", "story_v_out_102071.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_102071", "102071017", "story_v_out_102071.awb")

						arg_66_1:RecordAudio("102071017", var_69_11)
						arg_66_1:RecordAudio("102071017", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_102071", "102071017", "story_v_out_102071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_102071", "102071017", "story_v_out_102071.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play102071018 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 102071018
		arg_70_1.duration_ = 3.67

		local var_70_0 = {
			ja = 2.4,
			ko = 3.666,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_70_0:Play102071019(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = arg_70_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) then
				if arg_70_1.var_.characterEffect1084ui_story and not isNil(arg_70_1.actors_["1084ui_story"]) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["3008ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect3008ui_story == nil then
				arg_70_1.var_.characterEffect3008ui_story = var_73_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_3 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.characterEffect3008ui_story and not isNil(var_73_2) then
					arg_70_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_70_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_3)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect3008ui_story then
				arg_70_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_70_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_73_4 = arg_70_1.actors_["1019ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1019ui_story = var_73_4.localPosition
			end

			local var_73_5 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_5 then
				var_73_4.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_5)
				var_73_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_4.position).x, (manager.ui.mainCamera.transform.position - var_73_4.position).y, (manager.ui.mainCamera.transform.position - var_73_4.position).z)
				var_73_4.localEulerAngles.z = 0
				var_73_4.localEulerAngles.x = 0
				var_73_4.localEulerAngles = var_73_4.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_5 and arg_70_1.time_ < 0 + var_73_5 + arg_73_0 then
				var_73_4.localPosition = Vector3.New(0, 100, 0)
				var_73_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_4.position).x, (manager.ui.mainCamera.transform.position - var_73_4.position).y, (manager.ui.mainCamera.transform.position - var_73_4.position).z)
				var_73_4.localEulerAngles.z = 0
				var_73_4.localEulerAngles.x = 0
				var_73_4.localEulerAngles = var_73_4.localEulerAngles
			end

			local var_73_6 = arg_70_1.actors_["1084ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1084ui_story = var_73_6.localPosition

				arg_70_1:ShowWeapon(arg_70_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_73_7 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				var_73_6.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_70_1.time_ - 0) / var_73_7)
				var_73_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_6.position).x, (manager.ui.mainCamera.transform.position - var_73_6.position).y, (manager.ui.mainCamera.transform.position - var_73_6.position).z)
				var_73_6.localEulerAngles.z = 0
				var_73_6.localEulerAngles.x = 0
				var_73_6.localEulerAngles = var_73_6.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				var_73_6.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_73_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_6.position).x, (manager.ui.mainCamera.transform.position - var_73_6.position).y, (manager.ui.mainCamera.transform.position - var_73_6.position).z)
				var_73_6.localEulerAngles.z = 0
				var_73_6.localEulerAngles.x = 0
				var_73_6.localEulerAngles = var_73_6.localEulerAngles
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_73_8 = 0
			local var_73_9 = 0.15

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_10 = arg_70_1:GetWordFromCfg(102071018)
				local var_73_11 = arg_70_1:FormatText(var_73_10.content)

				arg_70_1.text_.text = var_73_11

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_13 = 6 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_11) / 6)

				if (6 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_11) / 6)) > 0 and var_73_9 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_8
					end
				end

				arg_70_1.text_.text = var_73_11
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071018", "story_v_out_102071.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_102071", "102071018", "story_v_out_102071.awb") / 1000

					if var_73_14 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_8
					end

					if var_73_10.prefab_name ~= "" and arg_70_1.actors_[var_73_10.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_10.prefab_name].transform, "story_v_out_102071", "102071018", "story_v_out_102071.awb")

						arg_70_1:RecordAudio("102071018", var_73_15)
						arg_70_1:RecordAudio("102071018", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_102071", "102071018", "story_v_out_102071.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_102071", "102071018", "story_v_out_102071.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_9, arg_70_1.talkMaxDuration)

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_8) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_8 + var_73_16 and arg_70_1.time_ < var_73_8 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play102071019 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 102071019
		arg_74_1.duration_ = 3.5

		local var_74_0 = {
			ja = 1.999999999999,
			ko = 2.366,
			zh = 3.1,
			en = 3.5
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
				arg_74_0:Play102071020(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["3008ui_story"]) and arg_74_1.var_.characterEffect3008ui_story == nil then
				arg_74_1.var_.characterEffect3008ui_story = arg_74_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["3008ui_story"]) then
				if arg_74_1.var_.characterEffect3008ui_story and not isNil(arg_74_1.actors_["3008ui_story"]) then
					arg_74_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["3008ui_story"]) and arg_74_1.var_.characterEffect3008ui_story then
				arg_74_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_77_2 = arg_74_1.actors_["1084ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1084ui_story == nil then
				arg_74_1.var_.characterEffect1084ui_story = var_77_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_3 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.characterEffect1084ui_story and not isNil(var_77_2) then
					arg_74_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_3)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1084ui_story then
				arg_74_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_77_4 = 0
			local var_77_5 = 0.3

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0

				arg_74_1.dialog_:SetActive(true)

				arg_74_1.dialogCg_.alpha = 0

				local var_77_6 = LeanTween.value(arg_74_1.dialog_, 0, 1, 0.3)

				var_77_6:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_74_1.dialogCg_.alpha = arg_78_0
				end))
				var_77_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_74_1.dialog_)
					var_77_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_74_1.duration_ = arg_74_1.duration_ + 0.3

				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:GetWordFromCfg(102071019)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_10 = 12 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_8) / 12)

				if (12 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_8) / 12)) > 0 and var_77_5 < var_77_10 then
					arg_74_1.talkMaxDuration = var_77_10
					var_77_4 = var_77_4 + 0.3

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071019", "story_v_out_102071.awb") ~= 0 then
					local var_77_11 = manager.audio:GetVoiceLength("story_v_out_102071", "102071019", "story_v_out_102071.awb") / 1000

					if var_77_11 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_4
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_102071", "102071019", "story_v_out_102071.awb")

						arg_74_1:RecordAudio("102071019", var_77_12)
						arg_74_1:RecordAudio("102071019", var_77_12)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_102071", "102071019", "story_v_out_102071.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_102071", "102071019", "story_v_out_102071.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_13 = var_77_4 + 0.3
			local var_77_14 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 + 0.3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_13 + var_77_14 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_13) / var_77_14

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_13 + var_77_14 and arg_74_1.time_ < var_77_13 + var_77_14 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play102071020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102071020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play102071023(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["3008ui_story"]) and arg_80_1.var_.characterEffect3008ui_story == nil then
				arg_80_1.var_.characterEffect3008ui_story = arg_80_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["3008ui_story"]) then
				if arg_80_1.var_.characterEffect3008ui_story and not isNil(arg_80_1.actors_["3008ui_story"]) then
					arg_80_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_80_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["3008ui_story"]) and arg_80_1.var_.characterEffect3008ui_story then
				arg_80_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_80_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_83_1 = arg_80_1.actors_["1084ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_1.localPosition
			end

			local var_83_2 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 then
				var_83_1.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_2)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 then
				var_83_1.localPosition = Vector3.New(0, 100, 0)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			local var_83_3 = arg_80_1.actors_["3008ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos3008ui_story = var_83_3.localPosition
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_4)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(0, 100, 0)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			local var_83_5 = 0
			local var_83_6 = 0.575

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(102071020).content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 23 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_7) / 23)

				if (23 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_7) / 23)) > 0 and var_83_6 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_10 and arg_80_1.time_ < var_83_5 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play102071023 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102071023
		arg_84_1.duration_ = 6.5

		local var_84_0 = {
			ja = 6.5,
			ko = 4.8,
			zh = 4,
			en = 5.2
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play102071024(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_0 = 0.5

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				local var_87_1 = Color.New(1, 1, 1)

				var_87_1.a = Mathf.Lerp(1, 0, (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.mask_.color = var_87_1
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				local var_87_2 = Color.New(1, 1, 1)

				arg_84_1.mask_.enabled = false
				var_87_2.a = 0
				arg_84_1.mask_.color = var_87_2
			end

			local var_87_3 = manager.ui.mainCamera.transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.shakeOldPosMainCamera = var_87_3.localPosition
			end

			local var_87_4 = 0.600000023841858

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				local var_87_5, var_87_6 = math.modf((arg_84_1.time_ - 0) / 0.066)

				var_87_3.localPosition = Vector3.New(var_87_6 * 0.13, var_87_6 * 0.13, var_87_6 * 0.13) + arg_84_1.var_.shakeOldPosMainCamera
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_3.localPosition = arg_84_1.var_.shakeOldPosMainCamera
			end

			local var_87_7 = 0
			local var_87_8 = 0.5

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_7 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_9 = arg_84_1:GetWordFromCfg(102071023)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_12 = 20 <= 0 and var_87_8 or var_87_8 * (utf8.len(var_87_10) / 20)

				if (20 <= 0 and var_87_8 or var_87_8 * (utf8.len(var_87_10) / 20)) > 0 and var_87_8 < var_87_12 then
					arg_84_1.talkMaxDuration = var_87_12

					if var_87_12 + var_87_7 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_7
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071023", "story_v_out_102071.awb") ~= 0 then
					local var_87_13 = manager.audio:GetVoiceLength("story_v_out_102071", "102071023", "story_v_out_102071.awb") / 1000

					if var_87_13 + var_87_7 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_7
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_102071", "102071023", "story_v_out_102071.awb")

						arg_84_1:RecordAudio("102071023", var_87_14)
						arg_84_1:RecordAudio("102071023", var_87_14)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_102071", "102071023", "story_v_out_102071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_102071", "102071023", "story_v_out_102071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_15 = math.max(var_87_8, arg_84_1.talkMaxDuration)

			if var_87_7 <= arg_84_1.time_ and arg_84_1.time_ < var_87_7 + var_87_15 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_7) / var_87_15

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_7 + var_87_15 and arg_84_1.time_ < var_87_7 + var_87_15 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play102071024 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 102071024
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play102071025(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:AudioAction("play", "effect", "se_story_2", "se_story_2_stun", "")
			end

			local var_91_1 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = false

				arg_88_1:SetGaussion(false)
			end

			local var_91_2 = 1.5

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = Color.New(1, 1, 1)

				var_91_3.a = Mathf.Lerp(0, 1, (arg_88_1.time_ - var_91_1) / var_91_2)
				arg_88_1.mask_.color = var_91_3
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				local var_91_4 = Color.New(1, 1, 1)

				var_91_4.a = 1
				arg_88_1.mask_.color = var_91_4
			end

			local var_91_5 = "S0203"

			if arg_88_1.bgs_.S0203 == nil then
				local var_91_6 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_5)
				var_91_6.name = var_91_5
				var_91_6.transform.parent = arg_88_1.stage_.transform
				var_91_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_5] = var_91_6
			end

			local var_91_7 = arg_88_1.bgs_.S0203.transform

			if 1.5 < arg_88_1.time_ and arg_88_1.time_ <= 1.5 + arg_91_0 then
				arg_88_1.var_.moveOldPosS0203 = var_91_7.localPosition
			end

			local var_91_8 = 0.001

			if 1.5 <= arg_88_1.time_ and arg_88_1.time_ < 1.5 + var_91_8 then
				var_91_7.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPosS0203, Vector3.New(0, -100, 10), (arg_88_1.time_ - 1.5) / var_91_8)
			end

			if arg_88_1.time_ >= 1.5 + var_91_8 and arg_88_1.time_ < 1.5 + var_91_8 + arg_91_0 then
				var_91_7.localPosition = Vector3.New(0, -100, 10)
			end

			local var_91_9 = 1.5

			if 1.5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = false

				arg_88_1:SetGaussion(false)
			end

			local var_91_10 = 1.5

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 then
				local var_91_11 = Color.New(1, 1, 1)

				var_91_11.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_9) / var_91_10)
				arg_88_1.mask_.color = var_91_11
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 then
				local var_91_12 = Color.New(1, 1, 1)

				arg_88_1.mask_.enabled = false
				var_91_12.a = 0
				arg_88_1.mask_.color = var_91_12
			end

			local var_91_13 = "STwhite"

			if arg_88_1.bgs_.STwhite == nil then
				local var_91_14 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_13)
				var_91_14.name = var_91_13
				var_91_14.transform.parent = arg_88_1.stage_.transform
				var_91_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_13] = var_91_14
			end

			local var_91_15 = arg_88_1.bgs_.STwhite.transform

			if 1.5 < arg_88_1.time_ and arg_88_1.time_ <= 1.5 + arg_91_0 then
				arg_88_1.var_.moveOldPosSTwhite = var_91_15.localPosition
				var_91_15.localScale = Vector3.New(20, 20, 20)
			end

			local var_91_16 = 0.001

			if 1.5 <= arg_88_1.time_ and arg_88_1.time_ < 1.5 + var_91_16 then
				var_91_15.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_88_1.time_ - 1.5) / var_91_16)
			end

			if arg_88_1.time_ >= 1.5 + var_91_16 and arg_88_1.time_ < 1.5 + var_91_16 + arg_91_0 then
				var_91_15.localPosition = Vector3.New(0, 0, 0)
			end

			local var_91_17 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_17 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			if arg_88_1.time_ >= var_91_17 + 1.534 and arg_88_1.time_ < var_91_17 + 1.534 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_18 = 0
			local var_91_19 = 0.125

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_18 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_20 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(102071024).content)

				arg_88_1.text_.text = var_91_20

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_22 = 5 <= 0 and var_91_19 or var_91_19 * (utf8.len(var_91_20) / 5)

				if (5 <= 0 and var_91_19 or var_91_19 * (utf8.len(var_91_20) / 5)) > 0 and var_91_19 < var_91_22 then
					arg_88_1.talkMaxDuration = var_91_22

					if var_91_22 + var_91_18 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_22 + var_91_18
					end
				end

				arg_88_1.text_.text = var_91_20
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_23 = math.max(var_91_19, arg_88_1.talkMaxDuration)

			if var_91_18 <= arg_88_1.time_ and arg_88_1.time_ < var_91_18 + var_91_23 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_18) / var_91_23

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_18 + var_91_23 and arg_88_1.time_ < var_91_18 + var_91_23 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0203",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play102071025 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 102071025
		arg_92_1.duration_ = 4.1

		local var_92_0 = {
			ja = 2.933,
			ko = 4.1,
			zh = 3.366,
			en = 3.466
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play102071026(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.325

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(102071025)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 13 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 13)

				if (13 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 13)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071025", "story_v_out_102071.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071025", "story_v_out_102071.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_102071", "102071025", "story_v_out_102071.awb")

						arg_92_1:RecordAudio("102071025", var_95_6)
						arg_92_1:RecordAudio("102071025", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_102071", "102071025", "story_v_out_102071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_102071", "102071025", "story_v_out_102071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play102071026 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 102071026
		arg_96_1.duration_ = 2.8

		local var_96_0 = {
			ja = 2.8,
			ko = 2.666,
			zh = 2.366,
			en = 2.633
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play102071027(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.275

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:GetWordFromCfg(102071026)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 11 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 11)

				if (11 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 11)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071026", "story_v_out_102071.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071026", "story_v_out_102071.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_102071", "102071026", "story_v_out_102071.awb")

						arg_96_1:RecordAudio("102071026", var_99_6)
						arg_96_1:RecordAudio("102071026", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102071", "102071026", "story_v_out_102071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102071", "102071026", "story_v_out_102071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play102071027 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 102071027
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play102071028(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.425

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(102071027).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 17 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 17)

				if (17 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 17)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play102071028 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 102071028
		arg_104_1.duration_ = 6.8

		local var_104_0 = {
			ja = 6.8,
			ko = 3.466,
			zh = 3.033,
			en = 4.3
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play102071029(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.475

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:GetWordFromCfg(102071028)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 15 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 15)

				if (15 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 15)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071028", "story_v_out_102071.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071028", "story_v_out_102071.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_102071", "102071028", "story_v_out_102071.awb")

						arg_104_1:RecordAudio("102071028", var_107_6)
						arg_104_1:RecordAudio("102071028", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_102071", "102071028", "story_v_out_102071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_102071", "102071028", "story_v_out_102071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play102071029 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 102071029
		arg_108_1.duration_ = 7.53

		local var_108_0 = {
			ja = 6.2,
			ko = 7.533,
			zh = 5.7,
			en = 6.033
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play102071030(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPosSTwhite = arg_108_1.bgs_.STwhite.transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.bgs_.STwhite.transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPosSTwhite, Vector3.New(0, -100, 10), (arg_108_1.time_ - 0) / var_111_0)
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_111_1 = 0

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_2 = 1.5

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = Color.New(1, 1, 1)

				var_111_3.a = Mathf.Lerp(1, 0, (arg_108_1.time_ - var_111_1) / var_111_2)
				arg_108_1.mask_.color = var_111_3
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				local var_111_4 = Color.New(1, 1, 1)

				arg_108_1.mask_.enabled = false
				var_111_4.a = 0
				arg_108_1.mask_.color = var_111_4
			end

			if 1.5 < arg_108_1.time_ and arg_108_1.time_ <= 1.5 + arg_111_0 then
				local var_111_5 = arg_108_1.bgs_.B02a

				arg_108_1.bgs_.B02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_111_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_111_6 = var_111_5:GetComponent("SpriteRenderer")

				if var_111_6 and var_111_6.sprite then
					local var_111_7 = 2 * (var_111_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_111_5.transform.localScale = Vector3.New(var_111_7 / var_111_6.sprite.bounds.size.y < var_111_7 * manager.ui.mainCameraCom_.aspect / var_111_6.sprite.bounds.size.x and var_111_7 * manager.ui.mainCameraCom_.aspect / var_111_6.sprite.bounds.size.x or var_111_7 / var_111_6.sprite.bounds.size.y, var_111_7 / var_111_6.sprite.bounds.size.y < var_111_7 * manager.ui.mainCameraCom_.aspect / var_111_6.sprite.bounds.size.x and var_111_7 * manager.ui.mainCameraCom_.aspect / var_111_6.sprite.bounds.size.x or var_111_7 / var_111_6.sprite.bounds.size.y, 0)
				end

				for iter_111_0, iter_111_1 in pairs(arg_108_1.bgs_) do
					if iter_111_0 ~= "B02a" then
						iter_111_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_111_8 = 0

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			if arg_108_1.time_ >= var_111_8 + 2 and arg_108_1.time_ < var_111_8 + 2 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			local var_111_9 = 2
			local var_111_10 = 0.45

			if 2 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_11 = arg_108_1:GetWordFromCfg(102071029)
				local var_111_12 = arg_108_1:FormatText(var_111_11.content)

				arg_108_1.text_.text = var_111_12

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_14 = 18 <= 0 and var_111_10 or var_111_10 * (utf8.len(var_111_12) / 18)

				if (18 <= 0 and var_111_10 or var_111_10 * (utf8.len(var_111_12) / 18)) > 0 and var_111_10 < var_111_14 then
					arg_108_1.talkMaxDuration = var_111_14

					if var_111_14 + var_111_9 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_9
					end
				end

				arg_108_1.text_.text = var_111_12
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071029", "story_v_out_102071.awb") ~= 0 then
					local var_111_15 = manager.audio:GetVoiceLength("story_v_out_102071", "102071029", "story_v_out_102071.awb") / 1000

					if var_111_15 + var_111_9 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_9
					end

					if var_111_11.prefab_name ~= "" and arg_108_1.actors_[var_111_11.prefab_name] ~= nil then
						local var_111_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_11.prefab_name].transform, "story_v_out_102071", "102071029", "story_v_out_102071.awb")

						arg_108_1:RecordAudio("102071029", var_111_16)
						arg_108_1:RecordAudio("102071029", var_111_16)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_102071", "102071029", "story_v_out_102071.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_102071", "102071029", "story_v_out_102071.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_17 = math.max(var_111_10, arg_108_1.talkMaxDuration)

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_17 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_9) / var_111_17

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_9 + var_111_17 and arg_108_1.time_ < var_111_9 + var_111_17 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play102071030 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 102071030
		arg_112_1.duration_ = 3.07

		local var_112_0 = {
			ja = 2.5,
			ko = 2.3,
			zh = 3.066,
			en = 2.5
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play102071031(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.375

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:GetWordFromCfg(102071030)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 15 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 15)

				if (15 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 15)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071030", "story_v_out_102071.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071030", "story_v_out_102071.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_102071", "102071030", "story_v_out_102071.awb")

						arg_112_1:RecordAudio("102071030", var_115_6)
						arg_112_1:RecordAudio("102071030", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_102071", "102071030", "story_v_out_102071.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_102071", "102071030", "story_v_out_102071.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play102071031 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 102071031
		arg_116_1.duration_ = 2.43

		local var_116_0 = {
			ja = 2,
			ko = 2.366,
			zh = 2.133,
			en = 2.433
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play102071032(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.2

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:GetWordFromCfg(102071031)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 8 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 8)

				if (8 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 8)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071031", "story_v_out_102071.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071031", "story_v_out_102071.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_102071", "102071031", "story_v_out_102071.awb")

						arg_116_1:RecordAudio("102071031", var_119_6)
						arg_116_1:RecordAudio("102071031", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_102071", "102071031", "story_v_out_102071.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_102071", "102071031", "story_v_out_102071.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play102071032 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 102071032
		arg_120_1.duration_ = 4.8

		local var_120_0 = {
			ja = 4.8,
			ko = 3.533,
			zh = 4.033,
			en = 4.633
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play102071033(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.425

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:GetWordFromCfg(102071032)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 17 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 17)

				if (17 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 17)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071032", "story_v_out_102071.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071032", "story_v_out_102071.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_102071", "102071032", "story_v_out_102071.awb")

						arg_120_1:RecordAudio("102071032", var_123_6)
						arg_120_1:RecordAudio("102071032", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_102071", "102071032", "story_v_out_102071.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_102071", "102071032", "story_v_out_102071.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play102071033 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 102071033
		arg_124_1.duration_ = 4.63

		local var_124_0 = {
			ja = 4.433,
			ko = 3.733,
			zh = 3.133,
			en = 4.633
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play102071034(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.375

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(102071033)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 15 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 15)

				if (15 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 15)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071033", "story_v_out_102071.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071033", "story_v_out_102071.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_102071", "102071033", "story_v_out_102071.awb")

						arg_124_1:RecordAudio("102071033", var_127_6)
						arg_124_1:RecordAudio("102071033", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_102071", "102071033", "story_v_out_102071.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_102071", "102071033", "story_v_out_102071.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play102071034 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 102071034
		arg_128_1.duration_ = 2.9

		local var_128_0 = {
			ja = 1.633,
			ko = 2.9,
			zh = 2.433,
			en = 1.966
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play102071035(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.3

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_1 = arg_128_1:GetWordFromCfg(102071034)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 11 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 11)

				if (11 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 11)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071034", "story_v_out_102071.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071034", "story_v_out_102071.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_102071", "102071034", "story_v_out_102071.awb")

						arg_128_1:RecordAudio("102071034", var_131_6)
						arg_128_1:RecordAudio("102071034", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_102071", "102071034", "story_v_out_102071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_102071", "102071034", "story_v_out_102071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play102071035 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 102071035
		arg_132_1.duration_ = 6.7

		local var_132_0 = {
			ja = 4.733,
			ko = 5.033,
			zh = 6.666,
			en = 6.7
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play102071036(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:AudioAction("play", "effect", "se_story", "se_story_loop_stop", "")
			end

			local var_135_1 = 0
			local var_135_2 = 0.5

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(102071035)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 20 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 20)

				if (20 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 20)) > 0 and var_135_2 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071035", "story_v_out_102071.awb") ~= 0 then
					local var_135_7 = manager.audio:GetVoiceLength("story_v_out_102071", "102071035", "story_v_out_102071.awb") / 1000

					if var_135_7 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_1
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_102071", "102071035", "story_v_out_102071.awb")

						arg_132_1:RecordAudio("102071035", var_135_8)
						arg_132_1:RecordAudio("102071035", var_135_8)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_102071", "102071035", "story_v_out_102071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_102071", "102071035", "story_v_out_102071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_9 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_9 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_9

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_9 and arg_132_1.time_ < var_135_1 + var_135_9 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play102071036 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 102071036
		arg_136_1.duration_ = 3.57

		local var_136_0 = {
			ja = 3.566,
			ko = 2.966,
			zh = 2.366,
			en = 2.766
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play102071037(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.275

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:GetWordFromCfg(102071036)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 11 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 11)

				if (11 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 11)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071036", "story_v_out_102071.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_102071", "102071036", "story_v_out_102071.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_102071", "102071036", "story_v_out_102071.awb")

						arg_136_1:RecordAudio("102071036", var_139_6)
						arg_136_1:RecordAudio("102071036", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_102071", "102071036", "story_v_out_102071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_102071", "102071036", "story_v_out_102071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play102071037 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 102071037
		arg_140_1.duration_ = 5.9

		local var_140_0 = {
			ja = 5.9,
			ko = 3.233,
			zh = 4.166,
			en = 3.8
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play102071038(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_143_1 = "2022_tpose"

			if arg_140_1.actors_["2022_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2022_tpose"))) then
				local var_143_2 = Object.Instantiate(Asset.Load("Char/" .. "2022_tpose"), arg_140_1.stage_.transform)

				var_143_2.name = var_143_1
				var_143_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_[var_143_1] = var_143_2

				local var_143_3 = var_143_2:GetComponentInChildren(typeof(CharacterEffect))

				var_143_3.enabled = true

				local var_143_4 = GameObjectTools.GetOrAddComponent(var_143_2, typeof(DynamicBoneHelper))

				if var_143_4 then
					var_143_4:EnableDynamicBone(false)
				end

				arg_140_1:ShowWeapon(var_143_3.transform, false)

				arg_140_1.var_[var_143_1 .. "Animator"] = var_143_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_140_1.var_[var_143_1 .. "Animator"].applyRootMotion = true
				arg_140_1.var_[var_143_1 .. "LipSync"] = var_143_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_143_5 = arg_140_1.actors_["2022_tpose"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_5) and arg_140_1.var_.characterEffect2022_tpose == nil then
				arg_140_1.var_.characterEffect2022_tpose = var_143_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_6 and not isNil(var_143_5) then
				if arg_140_1.var_.characterEffect2022_tpose and not isNil(var_143_5) then
					arg_140_1.var_.characterEffect2022_tpose.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_6 and arg_140_1.time_ < 0 + var_143_6 + arg_143_0 and not isNil(var_143_5) and arg_140_1.var_.characterEffect2022_tpose then
				arg_140_1.var_.characterEffect2022_tpose.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("2022_tpose", "StoryTimeline/CharAction/story2022/story2022action/2022action1_1")
			end

			local var_143_8 = arg_140_1.actors_["2022_tpose"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos2022_tpose = var_143_8.localPosition

				local var_143_9 = GameObjectTools.GetOrAddComponent(var_143_8.gameObject, typeof(DynamicBoneHelper))

				if var_143_9 then
					var_143_9:EnableDynamicBone(false)
				end
			end

			local var_143_10 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_10 then
				var_143_8.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos2022_tpose, Vector3.New(-0.7, -0.55, -0.3), (arg_140_1.time_ - 0) / var_143_10)
				var_143_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_8.position).x, (manager.ui.mainCamera.transform.position - var_143_8.position).y, (manager.ui.mainCamera.transform.position - var_143_8.position).z)
				var_143_8.localEulerAngles.z = 0
				var_143_8.localEulerAngles.x = 0
				var_143_8.localEulerAngles = var_143_8.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_10 and arg_140_1.time_ < 0 + var_143_10 + arg_143_0 then
				var_143_8.localPosition = Vector3.New(-0.7, -0.55, -0.3)
				var_143_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_8.position).x, (manager.ui.mainCamera.transform.position - var_143_8.position).y, (manager.ui.mainCamera.transform.position - var_143_8.position).z)
				var_143_8.localEulerAngles.z = 0
				var_143_8.localEulerAngles.x = 0
				var_143_8.localEulerAngles = var_143_8.localEulerAngles

				local var_143_11 = GameObjectTools.GetOrAddComponent(var_143_8.gameObject, typeof(DynamicBoneHelper))

				if var_143_11 then
					var_143_11:EnableDynamicBone(true)
				end
			end

			local var_143_12 = 0
			local var_143_13 = 0.4

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[46].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_14 = arg_140_1:GetWordFromCfg(102071037)
				local var_143_15 = arg_140_1:FormatText(var_143_14.content)

				arg_140_1.text_.text = var_143_15

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 15 <= 0 and var_143_13 or var_143_13 * (utf8.len(var_143_15) / 15)

				if (15 <= 0 and var_143_13 or var_143_13 * (utf8.len(var_143_15) / 15)) > 0 and var_143_13 < var_143_17 then
					arg_140_1.talkMaxDuration = var_143_17

					if var_143_17 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_17 + var_143_12
					end
				end

				arg_140_1.text_.text = var_143_15
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071037", "story_v_out_102071.awb") ~= 0 then
					local var_143_18 = manager.audio:GetVoiceLength("story_v_out_102071", "102071037", "story_v_out_102071.awb") / 1000

					if var_143_18 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_18 + var_143_12
					end

					if var_143_14.prefab_name ~= "" and arg_140_1.actors_[var_143_14.prefab_name] ~= nil then
						local var_143_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_14.prefab_name].transform, "story_v_out_102071", "102071037", "story_v_out_102071.awb")

						arg_140_1:RecordAudio("102071037", var_143_19)
						arg_140_1:RecordAudio("102071037", var_143_19)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_102071", "102071037", "story_v_out_102071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_102071", "102071037", "story_v_out_102071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_20 = math.max(var_143_13, arg_140_1.talkMaxDuration)

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_20 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_12) / var_143_20

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_12 + var_143_20 and arg_140_1.time_ < var_143_12 + var_143_20 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2022_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play102071038 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 102071038
		arg_144_1.duration_ = 5.67

		local var_144_0 = {
			ja = 5.666,
			ko = 3.3,
			zh = 4.3,
			en = 4.4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play102071039(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_147_1 = "2021_tpose"

			if arg_144_1.actors_["2021_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2021_tpose"))) then
				local var_147_2 = Object.Instantiate(Asset.Load("Char/" .. "2021_tpose"), arg_144_1.stage_.transform)

				var_147_2.name = var_147_1
				var_147_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_[var_147_1] = var_147_2

				local var_147_3 = var_147_2:GetComponentInChildren(typeof(CharacterEffect))

				var_147_3.enabled = true

				local var_147_4 = GameObjectTools.GetOrAddComponent(var_147_2, typeof(DynamicBoneHelper))

				if var_147_4 then
					var_147_4:EnableDynamicBone(false)
				end

				arg_144_1:ShowWeapon(var_147_3.transform, false)

				arg_144_1.var_[var_147_1 .. "Animator"] = var_147_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_144_1.var_[var_147_1 .. "Animator"].applyRootMotion = true
				arg_144_1.var_[var_147_1 .. "LipSync"] = var_147_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_147_5 = arg_144_1.actors_["2021_tpose"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect2021_tpose == nil then
				arg_144_1.var_.characterEffect2021_tpose = var_147_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_6 and not isNil(var_147_5) then
				if arg_144_1.var_.characterEffect2021_tpose and not isNil(var_147_5) then
					arg_144_1.var_.characterEffect2021_tpose.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_6 and arg_144_1.time_ < 0 + var_147_6 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect2021_tpose then
				arg_144_1.var_.characterEffect2021_tpose.fillFlat = false
			end

			local var_147_8 = arg_144_1.actors_["2021_tpose"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos2021_tpose = var_147_8.localPosition

				local var_147_9 = GameObjectTools.GetOrAddComponent(var_147_8.gameObject, typeof(DynamicBoneHelper))

				if var_147_9 then
					var_147_9:EnableDynamicBone(false)
				end
			end

			local var_147_10 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_10 then
				var_147_8.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos2021_tpose, Vector3.New(1.92, -0.6, 0.2), (arg_144_1.time_ - 0) / var_147_10)
				var_147_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_8.position).x, (manager.ui.mainCamera.transform.position - var_147_8.position).y, (manager.ui.mainCamera.transform.position - var_147_8.position).z)
				var_147_8.localEulerAngles.z = 0
				var_147_8.localEulerAngles.x = 0
				var_147_8.localEulerAngles = var_147_8.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_10 and arg_144_1.time_ < 0 + var_147_10 + arg_147_0 then
				var_147_8.localPosition = Vector3.New(1.92, -0.6, 0.2)
				var_147_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_8.position).x, (manager.ui.mainCamera.transform.position - var_147_8.position).y, (manager.ui.mainCamera.transform.position - var_147_8.position).z)
				var_147_8.localEulerAngles.z = 0
				var_147_8.localEulerAngles.x = 0
				var_147_8.localEulerAngles = var_147_8.localEulerAngles

				local var_147_11 = GameObjectTools.GetOrAddComponent(var_147_8.gameObject, typeof(DynamicBoneHelper))

				if var_147_11 then
					var_147_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("2021_tpose", "StoryTimeline/CharAction/story2021/story2021action/2021action1_1")
			end

			local var_147_12 = 0
			local var_147_13 = 0.4

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_12 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[46].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_14 = arg_144_1:GetWordFromCfg(102071038)
				local var_147_15 = arg_144_1:FormatText(var_147_14.content)

				arg_144_1.text_.text = var_147_15

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_17 = 15 <= 0 and var_147_13 or var_147_13 * (utf8.len(var_147_15) / 15)

				if (15 <= 0 and var_147_13 or var_147_13 * (utf8.len(var_147_15) / 15)) > 0 and var_147_13 < var_147_17 then
					arg_144_1.talkMaxDuration = var_147_17

					if var_147_17 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_17 + var_147_12
					end
				end

				arg_144_1.text_.text = var_147_15
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071038", "story_v_out_102071.awb") ~= 0 then
					local var_147_18 = manager.audio:GetVoiceLength("story_v_out_102071", "102071038", "story_v_out_102071.awb") / 1000

					if var_147_18 + var_147_12 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_18 + var_147_12
					end

					if var_147_14.prefab_name ~= "" and arg_144_1.actors_[var_147_14.prefab_name] ~= nil then
						local var_147_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_14.prefab_name].transform, "story_v_out_102071", "102071038", "story_v_out_102071.awb")

						arg_144_1:RecordAudio("102071038", var_147_19)
						arg_144_1:RecordAudio("102071038", var_147_19)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_102071", "102071038", "story_v_out_102071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_102071", "102071038", "story_v_out_102071.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_20 = math.max(var_147_13, arg_144_1.talkMaxDuration)

			if var_147_12 <= arg_144_1.time_ and arg_144_1.time_ < var_147_12 + var_147_20 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_12) / var_147_20

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_12 + var_147_20 and arg_144_1.time_ < var_147_12 + var_147_20 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2021_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play102071039 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 102071039
		arg_148_1.duration_ = 3.4

		local var_148_0 = {
			ja = 3.4,
			ko = 2.233,
			zh = 3.1,
			en = 2.1
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
			arg_148_1.auto_ = false
		end

		function arg_148_1.playNext_(arg_150_0)
			arg_148_1.onStoryFinished_()
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["2022_tpose"]) and arg_148_1.var_.characterEffect2022_tpose == nil then
				arg_148_1.var_.characterEffect2022_tpose = arg_148_1.actors_["2022_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.1

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["2022_tpose"]) then
				if arg_148_1.var_.characterEffect2022_tpose and not isNil(arg_148_1.actors_["2022_tpose"]) then
					arg_148_1.var_.characterEffect2022_tpose.fillFlat = true
					arg_148_1.var_.characterEffect2022_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_0)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["2022_tpose"]) and arg_148_1.var_.characterEffect2022_tpose then
				arg_148_1.var_.characterEffect2022_tpose.fillFlat = true
				arg_148_1.var_.characterEffect2022_tpose.fillRatio = 0.5
			end

			local var_151_1 = arg_148_1.actors_["2021_tpose"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect2021_tpose == nil then
				arg_148_1.var_.characterEffect2021_tpose = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.1

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect2021_tpose and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect2021_tpose.fillFlat = true
					arg_148_1.var_.characterEffect2021_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_2)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect2021_tpose then
				arg_148_1.var_.characterEffect2021_tpose.fillFlat = true
				arg_148_1.var_.characterEffect2021_tpose.fillRatio = 0.5
			end

			local var_151_3 = 0
			local var_151_4 = 0.325

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[47].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_5 = arg_148_1:GetWordFromCfg(102071039)
				local var_151_6 = arg_148_1:FormatText(var_151_5.content)

				arg_148_1.text_.text = var_151_6

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_8 = 12 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_6) / 12)

				if (12 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_6) / 12)) > 0 and var_151_4 < var_151_8 then
					arg_148_1.talkMaxDuration = var_151_8

					if var_151_8 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_3
					end
				end

				arg_148_1.text_.text = var_151_6
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102071", "102071039", "story_v_out_102071.awb") ~= 0 then
					local var_151_9 = manager.audio:GetVoiceLength("story_v_out_102071", "102071039", "story_v_out_102071.awb") / 1000

					if var_151_9 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_3
					end

					if var_151_5.prefab_name ~= "" and arg_148_1.actors_[var_151_5.prefab_name] ~= nil then
						local var_151_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_5.prefab_name].transform, "story_v_out_102071", "102071039", "story_v_out_102071.awb")

						arg_148_1:RecordAudio("102071039", var_151_10)
						arg_148_1:RecordAudio("102071039", var_151_10)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_102071", "102071039", "story_v_out_102071.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_102071", "102071039", "story_v_out_102071.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_11 = math.max(var_151_4, arg_148_1.talkMaxDuration)

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_11 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_3) / var_151_11

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_3 + var_151_11 and arg_148_1.time_ < var_151_3 + var_151_11 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0202",
		"TextureConfig/Background/B02a"
	},
	voices = {
		"story_v_out_102071.awb"
	}
}
