return {
	Play426091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play426091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2012 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2012")
				var_4_0.name = "ST2012"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2012 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2012

				arg_1_1.bgs_.ST2012.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2012" then
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(426091001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 4 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 4)

				if (4 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 4)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play426091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 426091002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play426091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.125

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(426091002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 45 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 45)

				if (45 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 45)) > 0 and var_11_0 < var_11_3 then
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
	Play426091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 426091003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play426091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.175

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

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(426091003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 7 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 7)

				if (7 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 7)) > 0 and var_15_0 < var_15_3 then
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
	Play426091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 426091004
		arg_16_1.duration_ = 6.4

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play426091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_9000

			if arg_16_1.bgs_.ST2007 == nil then
				local var_19_0 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007")
				var_19_0.name = "ST2007"
				var_19_0.transform.parent = arg_16_1.stage_.transform
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_.ST2007 = var_19_0
			end

			if 0.9 < arg_16_1.time_ and arg_16_1.time_ <= 0.9 + arg_19_0 then
				local var_19_1 = arg_16_1.bgs_.ST2007

				arg_16_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_2 = var_19_1:GetComponent("SpriteRenderer")

				if var_19_2 and var_19_2.sprite then
					local var_19_3 = 2 * (var_19_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_1.transform.localScale = Vector3.New(var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, var_19_3 / var_19_2.sprite.bounds.size.y < var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x and var_19_3 * manager.ui.mainCameraCom_.aspect / var_19_2.sprite.bounds.size.x or var_19_3 / var_19_2.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "ST2007" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_4 = 1.4

			if 1.4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_4 + 0.3 and arg_16_1.time_ < var_19_4 + 0.3 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				local var_19_5 = arg_16_1.var_.effectqiulingongzhuanchang1

				if not arg_16_1.var_.effectqiulingongzhuanchang1 then
					var_19_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_19_5.name = "qiulingongzhuanchang1"
					arg_16_1.var_.effectqiulingongzhuanchang1 = var_19_5
				else
					var_19_5.transform:SetParent(var_19_9000)
				end

				var_19_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_19_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_19_5.transform.localScale = Vector3.New(var_19_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_19_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_19_5.transform.localScale.z)
			end

			if 2.3 < arg_16_1.time_ and arg_16_1.time_ <= 2.3 + arg_19_0 then
				if arg_16_1.var_.effectqiulingongzhuanchang1 then
					Object.Destroy(arg_16_1.var_.effectqiulingongzhuanchang1)

					arg_16_1.var_.effectqiulingongzhuanchang1 = nil
				end
			end

			if 0.6 < arg_16_1.time_ and arg_16_1.time_ <= 0.6 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_19_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_10 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_10

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_10
						arg_16_1.bgmTxt2_.text = var_19_10
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.03333333333333 < arg_16_1.time_ and arg_16_1.time_ <= 1.03333333333333 + arg_19_0 then
				arg_16_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_19_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_16_1.bgmTxt_.text ~= var_19_13 and arg_16_1.bgmTxt_.text ~= "" then
						if arg_16_1.bgmTxt2_.text ~= "" then
							arg_16_1.bgmTxt_.text = arg_16_1.bgmTxt2_.text
						end

						arg_16_1.bgmTxt2_.text = var_19_13

						arg_16_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_16_1.bgmTxt_.text = var_19_13
						arg_16_1.bgmTxt2_.text = var_19_13
					end

					if arg_16_1.bgmTimer then
						arg_16_1.bgmTimer:Stop()

						arg_16_1.bgmTimer = nil
					end

					if arg_16_1.settingData.show_music_name == 1 then
						arg_16_1.musicController:SetSelectedState("show")
						arg_16_1.musicAnimator_:Play("open", 0, 0)

						if arg_16_1.settingData.music_time ~= 0 then
							arg_16_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_16_1.settingData.music_time), function()
								if arg_16_1 == nil or isNil(arg_16_1.bgmTxt_) then
									return
								end

								arg_16_1.musicController:SetSelectedState("hide")
								arg_16_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_19_14 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			if arg_16_1.time_ >= var_19_14 + 2.4 and arg_16_1.time_ < var_19_14 + 2.4 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_15 = 1.4
			local var_19_16 = 1

			if 1.4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_17 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_17:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_16_1.dialogCg_.alpha = arg_22_0
				end))
				var_19_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(426091004).content)

				arg_16_1.text_.text = var_19_18

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_20 = 40 <= 0 and var_19_16 or var_19_16 * (utf8.len(var_19_18) / 40)

				if (40 <= 0 and var_19_16 or var_19_16 * (utf8.len(var_19_18) / 40)) > 0 and var_19_16 < var_19_20 then
					arg_16_1.talkMaxDuration = var_19_20
					var_19_15 = var_19_15 + 0.3

					if var_19_20 + var_19_15 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_15
					end
				end

				arg_16_1.text_.text = var_19_18
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_21 = var_19_15 + 0.3
			local var_19_22 = math.max(var_19_16, arg_16_1.talkMaxDuration)

			if var_19_15 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_21 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_21) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_21 + var_19_22 and arg_16_1.time_ < var_19_21 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play426091005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 426091005
		arg_24_1.duration_ = 7.07

		local var_24_0 = {
			zh = 4.3,
			ja = 7.066
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
				arg_24_0:Play426091006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "6148ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["6148ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["6148ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["6148ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["6148ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos6148ui_story = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_24_1.time_ - 0) / var_27_5)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0, -0.985, -6)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(true)
				end
			end

			local var_27_7 = arg_24_1.actors_["6148ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect6148ui_story == nil then
				arg_24_1.var_.characterEffect6148ui_story = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect6148ui_story and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect6148ui_story then
				arg_24_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_27_10 = 0
			local var_27_11 = 0.375

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:GetWordFromCfg(426091005)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 15 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 15)

				if (15 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 15)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091005", "story_v_out_426091.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_426091", "426091005", "story_v_out_426091.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_426091", "426091005", "story_v_out_426091.awb")

						arg_24_1:RecordAudio("426091005", var_27_17)
						arg_24_1:RecordAudio("426091005", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_426091", "426091005", "story_v_out_426091.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_426091", "426091005", "story_v_out_426091.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_18 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_18 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_18

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_18 and arg_24_1.time_ < var_27_10 + var_27_18 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play426091006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 426091006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play426091007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) and arg_28_1.var_.characterEffect6148ui_story == nil then
				arg_28_1.var_.characterEffect6148ui_story = arg_28_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) then
				if arg_28_1.var_.characterEffect6148ui_story and not isNil(arg_28_1.actors_["6148ui_story"]) then
					arg_28_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_28_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["6148ui_story"]) and arg_28_1.var_.characterEffect6148ui_story then
				arg_28_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_28_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.2

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(426091006).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 8 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 8)

				if (8 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 8)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play426091007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 426091007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play426091008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos6148ui_story = arg_32_1.actors_["6148ui_story"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).z)
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles = arg_32_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).z)
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles = arg_32_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = 0
			local var_35_4 = 0.575

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(426091007).content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 23 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_5) / 23)

				if (23 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_5) / 23)) > 0 and var_35_4 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_8 and arg_32_1.time_ < var_35_3 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play426091008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 426091008
		arg_36_1.duration_ = 5.2

		local var_36_0 = {
			zh = 4.366,
			ja = 5.2
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play426091009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos6148ui_story = arg_36_1.actors_["6148ui_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["6148ui_story"].transform.position).z)
				arg_36_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["6148ui_story"].transform.localEulerAngles = arg_36_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_36_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["6148ui_story"].transform.position).z)
				arg_36_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["6148ui_story"].transform.localEulerAngles = arg_36_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = arg_36_1.actors_["6148ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect6148ui_story == nil then
				arg_36_1.var_.characterEffect6148ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect6148ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect6148ui_story then
				arg_36_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_39_6 = 0
			local var_39_7 = 0.375

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(426091008)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 15 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 15)

				if (15 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 15)) > 0 and var_39_7 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091008", "story_v_out_426091.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091008", "story_v_out_426091.awb") / 1000

					if var_39_12 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_6
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_426091", "426091008", "story_v_out_426091.awb")

						arg_36_1:RecordAudio("426091008", var_39_13)
						arg_36_1:RecordAudio("426091008", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_426091", "426091008", "story_v_out_426091.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_426091", "426091008", "story_v_out_426091.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play426091009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 426091009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play426091010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["6148ui_story"]) and arg_40_1.var_.characterEffect6148ui_story == nil then
				arg_40_1.var_.characterEffect6148ui_story = arg_40_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["6148ui_story"]) then
				if arg_40_1.var_.characterEffect6148ui_story and not isNil(arg_40_1.actors_["6148ui_story"]) then
					arg_40_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_40_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["6148ui_story"]) and arg_40_1.var_.characterEffect6148ui_story then
				arg_40_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_40_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.4

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(426091009).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 16 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 16)

				if (16 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 16)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play426091010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 426091010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play426091011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.5

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(426091010).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 20 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 20)

				if (20 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 20)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play426091011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 426091011
		arg_48_1.duration_ = 15.03

		local var_48_0 = {
			zh = 8.2,
			ja = 15.033
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play426091012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos6148ui_story = arg_48_1.actors_["6148ui_story"].transform.localPosition

				local var_51_0 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_0 then
					var_51_0:EnableDynamicBone(false)
				end
			end

			local var_51_1 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_1 then
				arg_48_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_48_1.time_ - 0) / var_51_1)
				arg_48_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).z)
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles = arg_48_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_1 and arg_48_1.time_ < 0 + var_51_1 + arg_51_0 then
				arg_48_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_48_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["6148ui_story"].transform.position).z)
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["6148ui_story"].transform.localEulerAngles = arg_48_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_51_2 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(true)
				end
			end

			local var_51_3 = arg_48_1.actors_["6148ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect6148ui_story == nil then
				arg_48_1.var_.characterEffect6148ui_story = var_51_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_4 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 and not isNil(var_51_3) then
				if arg_48_1.var_.characterEffect6148ui_story and not isNil(var_51_3) then
					arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 and not isNil(var_51_3) and arg_48_1.var_.characterEffect6148ui_story then
				arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_51_6 = 0
			local var_51_7 = 0.875

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(426091011)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 35 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 35)

				if (35 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 35)) > 0 and var_51_7 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091011", "story_v_out_426091.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091011", "story_v_out_426091.awb") / 1000

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_426091", "426091011", "story_v_out_426091.awb")

						arg_48_1:RecordAudio("426091011", var_51_13)
						arg_48_1:RecordAudio("426091011", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_426091", "426091011", "story_v_out_426091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_426091", "426091011", "story_v_out_426091.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play426091012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 426091012
		arg_52_1.duration_ = 11.57

		local var_52_0 = {
			zh = 7.1,
			ja = 11.566
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play426091013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_55_0 = 0
			local var_55_1 = 0.675

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(426091012)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 27 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 27)

				if (27 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 27)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091012", "story_v_out_426091.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_426091", "426091012", "story_v_out_426091.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_426091", "426091012", "story_v_out_426091.awb")

						arg_52_1:RecordAudio("426091012", var_55_7)
						arg_52_1:RecordAudio("426091012", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_426091", "426091012", "story_v_out_426091.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_426091", "426091012", "story_v_out_426091.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play426091013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 426091013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play426091014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["6148ui_story"]) and arg_56_1.var_.characterEffect6148ui_story == nil then
				arg_56_1.var_.characterEffect6148ui_story = arg_56_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["6148ui_story"]) then
				if arg_56_1.var_.characterEffect6148ui_story and not isNil(arg_56_1.actors_["6148ui_story"]) then
					arg_56_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_56_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["6148ui_story"]) and arg_56_1.var_.characterEffect6148ui_story then
				arg_56_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_56_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.75

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(426091013).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 30 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 30)

				if (30 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 30)) > 0 and var_59_2 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_6 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_6 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_6

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_6 and arg_56_1.time_ < var_59_1 + var_59_6 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play426091014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 426091014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play426091015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.8

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(426091014).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 32 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 32)

				if (32 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 32)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play426091015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 426091015
		arg_64_1.duration_ = 8.3

		local var_64_0 = {
			zh = 7.4,
			ja = 8.3
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play426091016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos6148ui_story = arg_64_1.actors_["6148ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).z)
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles = arg_64_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_64_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["6148ui_story"].transform.position).z)
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["6148ui_story"].transform.localEulerAngles = arg_64_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = arg_64_1.actors_["6148ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect6148ui_story == nil then
				arg_64_1.var_.characterEffect6148ui_story = var_67_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_4 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 and not isNil(var_67_3) then
				if arg_64_1.var_.characterEffect6148ui_story and not isNil(var_67_3) then
					arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect6148ui_story then
				arg_64_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action442")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_67_6 = 0
			local var_67_7 = 0.55

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_8 = arg_64_1:GetWordFromCfg(426091015)
				local var_67_9 = arg_64_1:FormatText(var_67_8.content)

				arg_64_1.text_.text = var_67_9

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 22 <= 0 and var_67_7 or var_67_7 * (utf8.len(var_67_9) / 22)

				if (22 <= 0 and var_67_7 or var_67_7 * (utf8.len(var_67_9) / 22)) > 0 and var_67_7 < var_67_11 then
					arg_64_1.talkMaxDuration = var_67_11

					if var_67_11 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_9
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091015", "story_v_out_426091.awb") ~= 0 then
					local var_67_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091015", "story_v_out_426091.awb") / 1000

					if var_67_12 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_6
					end

					if var_67_8.prefab_name ~= "" and arg_64_1.actors_[var_67_8.prefab_name] ~= nil then
						local var_67_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_8.prefab_name].transform, "story_v_out_426091", "426091015", "story_v_out_426091.awb")

						arg_64_1:RecordAudio("426091015", var_67_13)
						arg_64_1:RecordAudio("426091015", var_67_13)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_426091", "426091015", "story_v_out_426091.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_426091", "426091015", "story_v_out_426091.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_14 and arg_64_1.time_ < var_67_6 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play426091016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 426091016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play426091017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["6148ui_story"]) and arg_68_1.var_.characterEffect6148ui_story == nil then
				arg_68_1.var_.characterEffect6148ui_story = arg_68_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["6148ui_story"]) then
				if arg_68_1.var_.characterEffect6148ui_story and not isNil(arg_68_1.actors_["6148ui_story"]) then
					arg_68_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_68_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["6148ui_story"]) and arg_68_1.var_.characterEffect6148ui_story then
				arg_68_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_68_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.1

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(426091016).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 4 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 4)

				if (4 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 4)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play426091017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 426091017
		arg_72_1.duration_ = 12.1

		local var_72_0 = {
			zh = 8.3,
			ja = 12.1
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play426091018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos6148ui_story = arg_72_1.actors_["6148ui_story"].transform.localPosition

				local var_75_0 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_0 then
					var_75_0:EnableDynamicBone(false)
				end
			end

			local var_75_1 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				arg_72_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_72_1.time_ - 0) / var_75_1)
				arg_72_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["6148ui_story"].transform.position).z)
				arg_72_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["6148ui_story"].transform.localEulerAngles = arg_72_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 then
				arg_72_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_72_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["6148ui_story"].transform.position).z)
				arg_72_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["6148ui_story"].transform.localEulerAngles = arg_72_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_75_2 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(true)
				end
			end

			local var_75_3 = arg_72_1.actors_["6148ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect6148ui_story == nil then
				arg_72_1.var_.characterEffect6148ui_story = var_75_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_4 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 and not isNil(var_75_3) then
				if arg_72_1.var_.characterEffect6148ui_story and not isNil(var_75_3) then
					arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect6148ui_story then
				arg_72_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action424")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_75_6 = 0
			local var_75_7 = 0.8

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(426091017)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 32 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 32)

				if (32 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 32)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091017", "story_v_out_426091.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091017", "story_v_out_426091.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_426091", "426091017", "story_v_out_426091.awb")

						arg_72_1:RecordAudio("426091017", var_75_13)
						arg_72_1:RecordAudio("426091017", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_426091", "426091017", "story_v_out_426091.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_426091", "426091017", "story_v_out_426091.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play426091018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 426091018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play426091019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["6148ui_story"]) and arg_76_1.var_.characterEffect6148ui_story == nil then
				arg_76_1.var_.characterEffect6148ui_story = arg_76_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["6148ui_story"]) then
				if arg_76_1.var_.characterEffect6148ui_story and not isNil(arg_76_1.actors_["6148ui_story"]) then
					arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_76_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["6148ui_story"]) and arg_76_1.var_.characterEffect6148ui_story then
				arg_76_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_76_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.85

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(426091018).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 34 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 34)

				if (34 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 34)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_6 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_6 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_6

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_6 and arg_76_1.time_ < var_79_1 + var_79_6 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play426091019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 426091019
		arg_80_1.duration_ = 9

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play426091020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 2 < arg_80_1.time_ and arg_80_1.time_ <= 2 + arg_83_0 then
				local var_83_0 = arg_80_1.bgs_.ST2012

				arg_80_1.bgs_.ST2012.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_83_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_1 = var_83_0:GetComponent("SpriteRenderer")

				if var_83_1 and var_83_1.sprite then
					local var_83_2 = 2 * (var_83_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_83_0.transform.localScale = Vector3.New(var_83_2 / var_83_1.sprite.bounds.size.y < var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x and var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x or var_83_2 / var_83_1.sprite.bounds.size.y, var_83_2 / var_83_1.sprite.bounds.size.y < var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x and var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x or var_83_2 / var_83_1.sprite.bounds.size.y, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "ST2012" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_3 = 3.999999999999

			if 3.999999999999 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			if arg_80_1.time_ >= var_83_3 + 0.3 and arg_80_1.time_ < var_83_3 + 0.3 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			local var_83_4 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_5 = 2

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_5 then
				local var_83_6 = Color.New(0, 0, 0)

				var_83_6.a = Mathf.Lerp(0, 1, (arg_80_1.time_ - var_83_4) / var_83_5)
				arg_80_1.mask_.color = var_83_6
			end

			if arg_80_1.time_ >= var_83_4 + var_83_5 and arg_80_1.time_ < var_83_4 + var_83_5 + arg_83_0 then
				local var_83_7 = Color.New(0, 0, 0)

				var_83_7.a = 1
				arg_80_1.mask_.color = var_83_7
			end

			local var_83_8 = 2

			if 2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_9 = 2

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_9 then
				local var_83_10 = Color.New(0, 0, 0)

				var_83_10.a = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_8) / var_83_9)
				arg_80_1.mask_.color = var_83_10
			end

			if arg_80_1.time_ >= var_83_8 + var_83_9 and arg_80_1.time_ < var_83_8 + var_83_9 + arg_83_0 then
				local var_83_11 = Color.New(0, 0, 0)

				arg_80_1.mask_.enabled = false
				var_83_11.a = 0
				arg_80_1.mask_.color = var_83_11
			end

			local var_83_12 = arg_80_1.actors_["6148ui_story"].transform

			if 1.96599999815226 < arg_80_1.time_ and arg_80_1.time_ <= 1.96599999815226 + arg_83_0 then
				arg_80_1.var_.moveOldPos6148ui_story = var_83_12.localPosition

				local var_83_13 = GameObjectTools.GetOrAddComponent(var_83_12.gameObject, typeof(DynamicBoneHelper))

				if var_83_13 then
					var_83_13:EnableDynamicBone(false)
				end
			end

			local var_83_14 = 0.001

			if 1.96599999815226 <= arg_80_1.time_ and arg_80_1.time_ < 1.96599999815226 + var_83_14 then
				var_83_12.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 1.96599999815226) / var_83_14)
				var_83_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_12.position).x, (manager.ui.mainCamera.transform.position - var_83_12.position).y, (manager.ui.mainCamera.transform.position - var_83_12.position).z)
				var_83_12.localEulerAngles.z = 0
				var_83_12.localEulerAngles.x = 0
				var_83_12.localEulerAngles = var_83_12.localEulerAngles
			end

			if arg_80_1.time_ >= 1.96599999815226 + var_83_14 and arg_80_1.time_ < 1.96599999815226 + var_83_14 + arg_83_0 then
				var_83_12.localPosition = Vector3.New(0, 100, 0)
				var_83_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_12.position).x, (manager.ui.mainCamera.transform.position - var_83_12.position).y, (manager.ui.mainCamera.transform.position - var_83_12.position).z)
				var_83_12.localEulerAngles.z = 0
				var_83_12.localEulerAngles.x = 0
				var_83_12.localEulerAngles = var_83_12.localEulerAngles

				local var_83_15 = GameObjectTools.GetOrAddComponent(var_83_12.gameObject, typeof(DynamicBoneHelper))

				if var_83_15 then
					var_83_15:EnableDynamicBone(true)
				end
			end

			if 2.63333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 2.63333333333333 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_10", "se_story_10_fall", "")
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_17 = 3.999999999999
			local var_83_18 = 0.925

			if 3.999999999999 < arg_80_1.time_ and arg_80_1.time_ <= var_83_17 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_19 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_19:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_20 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(426091019).content)

				arg_80_1.text_.text = var_83_20

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_22 = 37 <= 0 and var_83_18 or var_83_18 * (utf8.len(var_83_20) / 37)

				if (37 <= 0 and var_83_18 or var_83_18 * (utf8.len(var_83_20) / 37)) > 0 and var_83_18 < var_83_22 then
					arg_80_1.talkMaxDuration = var_83_22
					var_83_17 = var_83_17 + 0.3

					if var_83_22 + var_83_17 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_22 + var_83_17
					end
				end

				arg_80_1.text_.text = var_83_20
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_23 = var_83_17 + 0.3
			local var_83_24 = math.max(var_83_18, arg_80_1.talkMaxDuration)

			if var_83_17 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_24 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_23) / var_83_24

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_23 + var_83_24 and arg_80_1.time_ < var_83_23 + var_83_24 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play426091020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 426091020
		arg_86_1.duration_ = 2

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play426091021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos6148ui_story = arg_86_1.actors_["6148ui_story"].transform.localPosition

				local var_89_0 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_0 then
					var_89_0:EnableDynamicBone(false)
				end
			end

			local var_89_1 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_1 then
				arg_86_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_86_1.time_ - 0) / var_89_1)
				arg_86_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["6148ui_story"].transform.position).z)
				arg_86_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["6148ui_story"].transform.localEulerAngles = arg_86_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_1 and arg_86_1.time_ < 0 + var_89_1 + arg_89_0 then
				arg_86_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_86_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["6148ui_story"].transform.position).z)
				arg_86_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["6148ui_story"].transform.localEulerAngles = arg_86_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_89_2 = GameObjectTools.GetOrAddComponent(arg_86_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(true)
				end
			end

			local var_89_3 = arg_86_1.actors_["6148ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect6148ui_story == nil then
				arg_86_1.var_.characterEffect6148ui_story = var_89_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_4 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 and not isNil(var_89_3) then
				if arg_86_1.var_.characterEffect6148ui_story and not isNil(var_89_3) then
					arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect6148ui_story then
				arg_86_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_89_6 = 0
			local var_89_7 = 0.075

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_8 = arg_86_1:GetWordFromCfg(426091020)
				local var_89_9 = arg_86_1:FormatText(var_89_8.content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 3 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_9) / 3)

				if (3 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_9) / 3)) > 0 and var_89_7 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091020", "story_v_out_426091.awb") ~= 0 then
					local var_89_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091020", "story_v_out_426091.awb") / 1000

					if var_89_12 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_6
					end

					if var_89_8.prefab_name ~= "" and arg_86_1.actors_[var_89_8.prefab_name] ~= nil then
						local var_89_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_8.prefab_name].transform, "story_v_out_426091", "426091020", "story_v_out_426091.awb")

						arg_86_1:RecordAudio("426091020", var_89_13)
						arg_86_1:RecordAudio("426091020", var_89_13)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_426091", "426091020", "story_v_out_426091.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_426091", "426091020", "story_v_out_426091.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play426091021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 426091021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play426091022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["6148ui_story"]) and arg_90_1.var_.characterEffect6148ui_story == nil then
				arg_90_1.var_.characterEffect6148ui_story = arg_90_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["6148ui_story"]) then
				if arg_90_1.var_.characterEffect6148ui_story and not isNil(arg_90_1.actors_["6148ui_story"]) then
					arg_90_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_90_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["6148ui_story"]) and arg_90_1.var_.characterEffect6148ui_story then
				arg_90_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_90_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.225

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(426091021).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 9 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 9)

				if (9 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 9)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play426091022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 426091022
		arg_94_1.duration_ = 6.8

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play426091023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_9000

			if 0.8 < arg_94_1.time_ and arg_94_1.time_ <= 0.8 + arg_97_0 then
				local var_97_0 = arg_94_1.bgs_.ST2012

				arg_94_1.bgs_.ST2012.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_1 = var_97_0:GetComponent("SpriteRenderer")

				if var_97_1 and var_97_1.sprite then
					local var_97_2 = 2 * (var_97_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_0.transform.localScale = Vector3.New(var_97_2 / var_97_1.sprite.bounds.size.y < var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x and var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x or var_97_2 / var_97_1.sprite.bounds.size.y, var_97_2 / var_97_1.sprite.bounds.size.y < var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x and var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x or var_97_2 / var_97_1.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "ST2012" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_3 = 1.5

			if 1.5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			if arg_94_1.time_ >= var_97_3 + 0.3 and arg_94_1.time_ < var_97_3 + 0.3 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				local var_97_4 = arg_94_1.var_.effecttaoli1123123

				if not arg_94_1.var_.effecttaoli1123123 then
					var_97_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_97_4.name = "taoli1123123"
					arg_94_1.var_.effecttaoli1123123 = var_97_4
				else
					var_97_4.transform:SetParent(var_97_9000)
				end

				var_97_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_97_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_97_4.transform.localScale = Vector3.New(var_97_4.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_97_4.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_97_4.transform.localScale.z)
			end

			if 1.5 < arg_94_1.time_ and arg_94_1.time_ <= 1.5 + arg_97_0 then
				if arg_94_1.var_.effecttaoli1123123 then
					Object.Destroy(arg_94_1.var_.effecttaoli1123123)

					arg_94_1.var_.effecttaoli1123123 = nil
				end
			end

			local var_97_7 = arg_94_1.actors_["6148ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos6148ui_story = var_97_7.localPosition

				local var_97_8 = GameObjectTools.GetOrAddComponent(var_97_7.gameObject, typeof(DynamicBoneHelper))

				if var_97_8 then
					var_97_8:EnableDynamicBone(false)
				end
			end

			local var_97_9 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_9 then
				var_97_7.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_9)
				var_97_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_7.position).x, (manager.ui.mainCamera.transform.position - var_97_7.position).y, (manager.ui.mainCamera.transform.position - var_97_7.position).z)
				var_97_7.localEulerAngles.z = 0
				var_97_7.localEulerAngles.x = 0
				var_97_7.localEulerAngles = var_97_7.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_9 and arg_94_1.time_ < 0 + var_97_9 + arg_97_0 then
				var_97_7.localPosition = Vector3.New(0, 100, 0)
				var_97_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_7.position).x, (manager.ui.mainCamera.transform.position - var_97_7.position).y, (manager.ui.mainCamera.transform.position - var_97_7.position).z)
				var_97_7.localEulerAngles.z = 0
				var_97_7.localEulerAngles.x = 0
				var_97_7.localEulerAngles = var_97_7.localEulerAngles

				local var_97_10 = GameObjectTools.GetOrAddComponent(var_97_7.gameObject, typeof(DynamicBoneHelper))

				if var_97_10 then
					var_97_10:EnableDynamicBone(true)
				end
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_11 = 1.8
			local var_97_12 = 1.175

			if 1.8 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_13 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_13:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_14 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(426091022).content)

				arg_94_1.text_.text = var_97_14

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_16 = 47 <= 0 and var_97_12 or var_97_12 * (utf8.len(var_97_14) / 47)

				if (47 <= 0 and var_97_12 or var_97_12 * (utf8.len(var_97_14) / 47)) > 0 and var_97_12 < var_97_16 then
					arg_94_1.talkMaxDuration = var_97_16
					var_97_11 = var_97_11 + 0.3

					if var_97_16 + var_97_11 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_16 + var_97_11
					end
				end

				arg_94_1.text_.text = var_97_14
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_17 = var_97_11 + 0.3
			local var_97_18 = math.max(var_97_12, arg_94_1.talkMaxDuration)

			if var_97_11 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_17 + var_97_18 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_17) / var_97_18

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_17 + var_97_18 and arg_94_1.time_ < var_97_17 + var_97_18 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play426091023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 426091023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play426091024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.175

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

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(426091023).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 7 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 7)

				if (7 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 7)) > 0 and var_103_0 < var_103_3 then
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
	Play426091024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 426091024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play426091025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.825

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(426091024).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 33 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 33)

				if (33 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 33)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play426091025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 426091025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play426091026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.125

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(426091025).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 5 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 5)

				if (5 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 5)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play426091026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 426091026
		arg_112_1.duration_ = 3.5

		local var_112_0 = {
			zh = 3.5,
			ja = 1.999999999999
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
				arg_112_0:Play426091027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if arg_112_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_115_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_112_1.stage_.transform)

				var_115_0.name = "1054ui_story"
				var_115_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["1054ui_story"] = var_115_0

				local var_115_1 = var_115_0:GetComponentInChildren(typeof(CharacterEffect))

				var_115_1.enabled = true

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_0, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end

				arg_112_1:ShowWeapon(var_115_1.transform, false)

				arg_112_1.var_["1054ui_story" .. "Animator"] = var_115_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_112_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_112_1.var_["1054ui_story" .. "LipSync"] = var_115_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_115_3 = arg_112_1.actors_["1054ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1054ui_story = var_115_3.localPosition

				local var_115_4 = GameObjectTools.GetOrAddComponent(var_115_3.gameObject, typeof(DynamicBoneHelper))

				if var_115_4 then
					var_115_4:EnableDynamicBone(false)
				end
			end

			local var_115_5 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_5 then
				var_115_3.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_112_1.time_ - 0) / var_115_5)
				var_115_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_3.position).x, (manager.ui.mainCamera.transform.position - var_115_3.position).y, (manager.ui.mainCamera.transform.position - var_115_3.position).z)
				var_115_3.localEulerAngles.z = 0
				var_115_3.localEulerAngles.x = 0
				var_115_3.localEulerAngles = var_115_3.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_5 and arg_112_1.time_ < 0 + var_115_5 + arg_115_0 then
				var_115_3.localPosition = Vector3.New(0, -0.985, -6)
				var_115_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_3.position).x, (manager.ui.mainCamera.transform.position - var_115_3.position).y, (manager.ui.mainCamera.transform.position - var_115_3.position).z)
				var_115_3.localEulerAngles.z = 0
				var_115_3.localEulerAngles.x = 0
				var_115_3.localEulerAngles = var_115_3.localEulerAngles

				local var_115_6 = GameObjectTools.GetOrAddComponent(var_115_3.gameObject, typeof(DynamicBoneHelper))

				if var_115_6 then
					var_115_6:EnableDynamicBone(true)
				end
			end

			local var_115_7 = arg_112_1.actors_["1054ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_7) and arg_112_1.var_.characterEffect1054ui_story == nil then
				arg_112_1.var_.characterEffect1054ui_story = var_115_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_8 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_8 and not isNil(var_115_7) then
				if arg_112_1.var_.characterEffect1054ui_story and not isNil(var_115_7) then
					arg_112_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_8 and arg_112_1.time_ < 0 + var_115_8 + arg_115_0 and not isNil(var_115_7) and arg_112_1.var_.characterEffect1054ui_story then
				arg_112_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_115_10 = 0
			local var_115_11 = 0.175

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_12 = arg_112_1:GetWordFromCfg(426091026)
				local var_115_13 = arg_112_1:FormatText(var_115_12.content)

				arg_112_1.text_.text = var_115_13

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_15 = 7 <= 0 and var_115_11 or var_115_11 * (utf8.len(var_115_13) / 7)

				if (7 <= 0 and var_115_11 or var_115_11 * (utf8.len(var_115_13) / 7)) > 0 and var_115_11 < var_115_15 then
					arg_112_1.talkMaxDuration = var_115_15

					if var_115_15 + var_115_10 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_15 + var_115_10
					end
				end

				arg_112_1.text_.text = var_115_13
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091026", "story_v_out_426091.awb") ~= 0 then
					local var_115_16 = manager.audio:GetVoiceLength("story_v_out_426091", "426091026", "story_v_out_426091.awb") / 1000

					if var_115_16 + var_115_10 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_16 + var_115_10
					end

					if var_115_12.prefab_name ~= "" and arg_112_1.actors_[var_115_12.prefab_name] ~= nil then
						local var_115_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_12.prefab_name].transform, "story_v_out_426091", "426091026", "story_v_out_426091.awb")

						arg_112_1:RecordAudio("426091026", var_115_17)
						arg_112_1:RecordAudio("426091026", var_115_17)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_426091", "426091026", "story_v_out_426091.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_426091", "426091026", "story_v_out_426091.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_18 = math.max(var_115_11, arg_112_1.talkMaxDuration)

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_18 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_10) / var_115_18

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_10 + var_115_18 and arg_112_1.time_ < var_115_10 + var_115_18 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play426091027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 426091027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play426091028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1054ui_story = arg_116_1.actors_["1054ui_story"].transform.localPosition

				local var_119_0 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_0 then
					var_119_0:EnableDynamicBone(false)
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_1)
				arg_116_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).z)
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles = arg_116_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).z)
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles = arg_116_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_119_2 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(true)
				end
			end

			local var_119_3 = arg_116_1.actors_["1054ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect1054ui_story == nil then
				arg_116_1.var_.characterEffect1054ui_story = var_119_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 and not isNil(var_119_3) then
				if arg_116_1.var_.characterEffect1054ui_story and not isNil(var_119_3) then
					arg_116_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_4)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect1054ui_story then
				arg_116_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_116_1.time_ and arg_116_1.time_ <= 0.200000002980232 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "se_story_141", "se_story_141_xuanji03", "")
			end

			local var_119_6 = manager.ui.mainCamera.transform

			if 0.200000002980232 < arg_116_1.time_ and arg_116_1.time_ <= 0.200000002980232 + arg_119_0 then
				arg_116_1.var_.shakeOldPos = var_119_6.localPosition
			end

			local var_119_7 = 0.3

			if 0.200000002980232 <= arg_116_1.time_ and arg_116_1.time_ < 0.200000002980232 + var_119_7 then
				local var_119_8, var_119_9 = math.modf((arg_116_1.time_ - 0.200000002980232) / 0.066)

				var_119_6.localPosition = Vector3.New(var_119_9 * 0.13, var_119_9 * 0.13, var_119_9 * 0.13) + arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.time_ >= 0.200000002980232 + var_119_7 and arg_116_1.time_ < 0.200000002980232 + var_119_7 + arg_119_0 then
				var_119_6.localPosition = arg_116_1.var_.shakeOldPos
			end

			local var_119_10 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= var_119_10 + 0.500000002980232 and arg_116_1.time_ < var_119_10 + 0.500000002980232 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			local var_119_11 = 0
			local var_119_12 = 0.775

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_11 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_13 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(426091027).content)

				arg_116_1.text_.text = var_119_13

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_15 = 31 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_13) / 31)

				if (31 <= 0 and var_119_12 or var_119_12 * (utf8.len(var_119_13) / 31)) > 0 and var_119_12 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_11 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_11
					end
				end

				arg_116_1.text_.text = var_119_13
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_12, arg_116_1.talkMaxDuration)

			if var_119_11 <= arg_116_1.time_ and arg_116_1.time_ < var_119_11 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_11) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_11 + var_119_16 and arg_116_1.time_ < var_119_11 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play426091028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 426091028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play426091029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.85

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(426091028).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 34 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 34)

				if (34 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 34)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play426091029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 426091029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play426091030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.625

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(426091029).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 25 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 25)

				if (25 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 25)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play426091030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 426091030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play426091031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_131_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_128_1.bgmTxt_.text ~= var_131_2 and arg_128_1.bgmTxt_.text ~= "" then
						if arg_128_1.bgmTxt2_.text ~= "" then
							arg_128_1.bgmTxt_.text = arg_128_1.bgmTxt2_.text
						end

						arg_128_1.bgmTxt2_.text = var_131_2

						arg_128_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_128_1.bgmTxt_.text = var_131_2
						arg_128_1.bgmTxt2_.text = var_131_2
					end

					if arg_128_1.bgmTimer then
						arg_128_1.bgmTimer:Stop()

						arg_128_1.bgmTimer = nil
					end

					if arg_128_1.settingData.show_music_name == 1 then
						arg_128_1.musicController:SetSelectedState("show")
						arg_128_1.musicAnimator_:Play("open", 0, 0)

						if arg_128_1.settingData.music_time ~= 0 then
							arg_128_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_128_1.settingData.music_time), function()
								if arg_128_1 == nil or isNil(arg_128_1.bgmTxt_) then
									return
								end

								arg_128_1.musicController:SetSelectedState("hide")
								arg_128_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_131_3 = 0
			local var_131_4 = 0.875

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_3 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_5 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(426091030).content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 35 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_5) / 35)

				if (35 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_5) / 35)) > 0 and var_131_4 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_3 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_3
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_4, arg_128_1.talkMaxDuration)

			if var_131_3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_3 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_3) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_3 + var_131_8 and arg_128_1.time_ < var_131_3 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play426091031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 426091031
		arg_133_1.duration_ = 2.13

		local var_133_0 = {
			zh = 2.133,
			ja = 1.999999999999
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
				arg_133_0:Play426091032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1054ui_story = arg_133_1.actors_["1054ui_story"].transform.localPosition

				local var_136_0 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_0 then
					var_136_0:EnableDynamicBone(false)
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_133_1.time_ - 0) / var_136_1)
				arg_133_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).z)
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles = arg_133_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_133_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).z)
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles = arg_133_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_136_2 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(true)
				end
			end

			local var_136_3 = arg_133_1.actors_["1054ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1054ui_story == nil then
				arg_133_1.var_.characterEffect1054ui_story = var_136_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_4 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 and not isNil(var_136_3) then
				if arg_133_1.var_.characterEffect1054ui_story and not isNil(var_136_3) then
					arg_133_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1054ui_story then
				arg_133_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_136_6 = 0
			local var_136_7 = 0.1

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(426091031)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 4 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 4)

				if (4 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 4)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091031", "story_v_out_426091.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091031", "story_v_out_426091.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_426091", "426091031", "story_v_out_426091.awb")

						arg_133_1:RecordAudio("426091031", var_136_13)
						arg_133_1:RecordAudio("426091031", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_426091", "426091031", "story_v_out_426091.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_426091", "426091031", "story_v_out_426091.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 426091032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play426091033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1054ui_story"]) and arg_137_1.var_.characterEffect1054ui_story == nil then
				arg_137_1.var_.characterEffect1054ui_story = arg_137_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1054ui_story"]) then
				if arg_137_1.var_.characterEffect1054ui_story and not isNil(arg_137_1.actors_["1054ui_story"]) then
					arg_137_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1054ui_story"]) and arg_137_1.var_.characterEffect1054ui_story then
				arg_137_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_140_1 = 0
			local var_140_2 = 0.15

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(426091032).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 6 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 6)

				if (6 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 6)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play426091033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 426091033
		arg_141_1.duration_ = 1.87

		local var_141_0 = {
			zh = 1.866,
			ja = 1.666
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
				arg_141_0:Play426091034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0.1 < arg_141_1.time_ and arg_141_1.time_ <= 0.1 + arg_144_0 then
				arg_141_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_144_0 = 0.6

			if 0.1 <= arg_141_1.time_ and arg_141_1.time_ < 0.1 + var_144_0 then
				local var_144_1, var_144_2 = math.modf((arg_141_1.time_ - 0.1) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_144_2 * 0.13, var_144_2 * 0.13, var_144_2 * 0.13) + arg_141_1.var_.shakeOldPos
			end

			if arg_141_1.time_ >= 0.1 + var_144_0 and arg_141_1.time_ < 0.1 + var_144_0 + arg_144_0 then
				manager.ui.mainCamera.transform.localPosition = arg_141_1.var_.shakeOldPos
			end

			local var_144_3 = 0

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			if arg_141_1.time_ >= var_144_3 + 0.7 and arg_141_1.time_ < var_144_3 + 0.7 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_4 = arg_141_1.actors_["1054ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1054ui_story = var_144_4.localPosition

				local var_144_5 = GameObjectTools.GetOrAddComponent(var_144_4.gameObject, typeof(DynamicBoneHelper))

				if var_144_5 then
					var_144_5:EnableDynamicBone(false)
				end
			end

			local var_144_6 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 then
				var_144_4.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_6)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 then
				var_144_4.localPosition = Vector3.New(0, 100, 0)
				var_144_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_4.position).x, (manager.ui.mainCamera.transform.position - var_144_4.position).y, (manager.ui.mainCamera.transform.position - var_144_4.position).z)
				var_144_4.localEulerAngles.z = 0
				var_144_4.localEulerAngles.x = 0
				var_144_4.localEulerAngles = var_144_4.localEulerAngles

				local var_144_7 = GameObjectTools.GetOrAddComponent(var_144_4.gameObject, typeof(DynamicBoneHelper))

				if var_144_7 then
					var_144_7:EnableDynamicBone(true)
				end
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_8 = 0.1
			local var_144_9 = 0.075

			if 0.1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_10 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_10:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_11 = arg_141_1:GetWordFromCfg(426091033)
				local var_144_12 = arg_141_1:FormatText(var_144_11.content)

				arg_141_1.text_.text = var_144_12

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_14 = 3 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_12) / 3)

				if (3 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_12) / 3)) > 0 and var_144_9 < var_144_14 then
					arg_141_1.talkMaxDuration = var_144_14
					var_144_8 = var_144_8 + 0.3

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_12
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091033", "story_v_out_426091.awb") ~= 0 then
					local var_144_15 = manager.audio:GetVoiceLength("story_v_out_426091", "426091033", "story_v_out_426091.awb") / 1000

					if var_144_15 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_8
					end

					if var_144_11.prefab_name ~= "" and arg_141_1.actors_[var_144_11.prefab_name] ~= nil then
						local var_144_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_11.prefab_name].transform, "story_v_out_426091", "426091033", "story_v_out_426091.awb")

						arg_141_1:RecordAudio("426091033", var_144_16)
						arg_141_1:RecordAudio("426091033", var_144_16)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_426091", "426091033", "story_v_out_426091.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_426091", "426091033", "story_v_out_426091.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_17 = var_144_8 + 0.3
			local var_144_18 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_17 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_17) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_17 + var_144_18 and arg_141_1.time_ < var_144_17 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 426091034
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play426091035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1054ui_story"]) and arg_147_1.var_.characterEffect1054ui_story == nil then
				arg_147_1.var_.characterEffect1054ui_story = arg_147_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1054ui_story"]) then
				if arg_147_1.var_.characterEffect1054ui_story and not isNil(arg_147_1.actors_["1054ui_story"]) then
					arg_147_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1054ui_story"]) and arg_147_1.var_.characterEffect1054ui_story then
				arg_147_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.075

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
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

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(426091034).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 3 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 3)

				if (3 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 3)) > 0 and var_150_2 < var_150_5 then
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
	Play426091035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426091035
		arg_151_1.duration_ = 6

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426091036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_9001
			local var_154_9000

			if arg_151_1.bgs_.J27g == nil then
				local var_154_0 = Object.Instantiate(arg_151_1.paintGo_)

				var_154_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27g")
				var_154_0.name = "J27g"
				var_154_0.transform.parent = arg_151_1.stage_.transform
				var_154_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.bgs_.J27g = var_154_0
			end

			if 0.3 < arg_151_1.time_ and arg_151_1.time_ <= 0.3 + arg_154_0 then
				local var_154_1 = arg_151_1.bgs_.J27g

				arg_151_1.bgs_.J27g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_154_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_2 = var_154_1:GetComponent("SpriteRenderer")

				if var_154_2 and var_154_2.sprite then
					local var_154_3 = 2 * (var_154_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_154_1.transform.localScale = Vector3.New(var_154_3 / var_154_2.sprite.bounds.size.y < var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x and var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x or var_154_3 / var_154_2.sprite.bounds.size.y, var_154_3 / var_154_2.sprite.bounds.size.y < var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x and var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x or var_154_3 / var_154_2.sprite.bounds.size.y, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "J27g" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_4 = 1

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_4 + 0.3 and arg_151_1.time_ < var_154_4 + 0.3 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_154_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_7 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_7

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_7
						arg_151_1.bgmTxt2_.text = var_154_7
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 0.433333333333333 + arg_154_0 then
				arg_151_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_154_10 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_10 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_10

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_10
						arg_151_1.bgmTxt2_.text = var_154_10
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 0.133333333333333 + arg_154_0 then
				arg_151_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0.433333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 0.433333333333333 + arg_154_0 then
				arg_151_1:AudioAction("stop", "effect", "se_story_150", "se_story_150_flower_field", "")
			end

			if 0.7 < arg_151_1.time_ and arg_151_1.time_ <= 0.7 + arg_154_0 then
				arg_151_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_door_huge_break", "")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				local var_154_14 = arg_151_1.var_.effectbaozhashinei1

				if not arg_151_1.var_.effectbaozhashinei1 then
					var_154_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_154_14.name = "baozhashinei1"
					arg_151_1.var_.effectbaozhashinei1 = var_154_14
				else
					var_154_14.transform:SetParent(var_154_9001)
				end

				var_154_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_154_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.7 < arg_151_1.time_ and arg_151_1.time_ <= 1.7 + arg_154_0 then
				if arg_151_1.var_.effectbaozhashinei1 then
					Object.Destroy(arg_151_1.var_.effectbaozhashinei1)

					arg_151_1.var_.effectbaozhashinei1 = nil
				end
			end

			local var_154_17 = arg_151_1.bgs_.J27g.transform

			if 0.3 < arg_151_1.time_ and arg_151_1.time_ <= 0.3 + arg_154_0 then
				arg_151_1.var_.moveOldPosJ27g = var_154_17.localPosition
			end

			local var_154_18 = 1.43333333333333

			if 0.3 <= arg_151_1.time_ and arg_151_1.time_ < 0.3 + var_154_18 then
				var_154_17.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPosJ27g, Vector3.New(0, 1, 9.5), (arg_151_1.time_ - 0.3) / var_154_18)
			end

			if arg_151_1.time_ >= 0.3 + var_154_18 and arg_151_1.time_ < 0.3 + var_154_18 + arg_154_0 then
				var_154_17.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0.833333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 0.833333333333333 + arg_154_0 then
				local var_154_19 = arg_151_1.var_.effectdachumenwai1

				if not arg_151_1.var_.effectdachumenwai1 then
					var_154_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_154_19.name = "dachumenwai1"
					arg_151_1.var_.effectdachumenwai1 = var_154_19
				else
					var_154_19.transform:SetParent(var_154_9000)
				end

				var_154_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_154_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.2 < arg_151_1.time_ and arg_151_1.time_ <= 3.2 + arg_154_0 then
				if arg_151_1.var_.effectdachumenwai1 then
					Object.Destroy(arg_151_1.var_.effectdachumenwai1)

					arg_151_1.var_.effectdachumenwai1 = nil
				end
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_22 = 1
			local var_154_23 = 1

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_22 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_24 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_24:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_151_1.dialogCg_.alpha = arg_157_0
				end))
				var_154_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_25 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(426091035).content)

				arg_151_1.text_.text = var_154_25

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_27 = 40 <= 0 and var_154_23 or var_154_23 * (utf8.len(var_154_25) / 40)

				if (40 <= 0 and var_154_23 or var_154_23 * (utf8.len(var_154_25) / 40)) > 0 and var_154_23 < var_154_27 then
					arg_151_1.talkMaxDuration = var_154_27
					var_154_22 = var_154_22 + 0.3

					if var_154_27 + var_154_22 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_27 + var_154_22
					end
				end

				arg_151_1.text_.text = var_154_25
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_28 = var_154_22 + 0.3
			local var_154_29 = math.max(var_154_23, arg_151_1.talkMaxDuration)

			if var_154_22 + 0.3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_28 + var_154_29 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_28) / var_154_29

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_28 + var_154_29 and arg_151_1.time_ < var_154_28 + var_154_29 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "J27g",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.43333333333333,
				startTime = 0.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play426091036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426091036
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426091037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.175

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

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(426091036).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 47 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 47)

				if (47 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 47)) > 0 and var_162_0 < var_162_3 then
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
	Play426091037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426091037
		arg_163_1.duration_ = 2.7

		local var_163_0 = {
			zh = 2.7,
			ja = 1.999999999999
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
				arg_163_0:Play426091038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1054ui_story = arg_163_1.actors_["1054ui_story"].transform.localPosition

				local var_166_0 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_166_0 then
					var_166_0:EnableDynamicBone(false)
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_163_1.time_ - 0) / var_166_1)
				arg_163_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1054ui_story"].transform.position).z)
				arg_163_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1054ui_story"].transform.localEulerAngles = arg_163_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_163_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1054ui_story"].transform.position).z)
				arg_163_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1054ui_story"].transform.localEulerAngles = arg_163_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_166_2 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(true)
				end
			end

			local var_166_3 = arg_163_1.actors_["1054ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect1054ui_story == nil then
				arg_163_1.var_.characterEffect1054ui_story = var_166_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_4 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 and not isNil(var_166_3) then
				if arg_163_1.var_.characterEffect1054ui_story and not isNil(var_166_3) then
					arg_163_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect1054ui_story then
				arg_163_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_166_6 = 0
			local var_166_7 = 0.125

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(426091037)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 5 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 5)

				if (5 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 5)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091037", "story_v_out_426091.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091037", "story_v_out_426091.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_426091", "426091037", "story_v_out_426091.awb")

						arg_163_1:RecordAudio("426091037", var_166_13)
						arg_163_1:RecordAudio("426091037", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_426091", "426091037", "story_v_out_426091.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_426091", "426091037", "story_v_out_426091.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426091038
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play426091039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1054ui_story"]) and arg_167_1.var_.characterEffect1054ui_story == nil then
				arg_167_1.var_.characterEffect1054ui_story = arg_167_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1054ui_story"]) then
				if arg_167_1.var_.characterEffect1054ui_story and not isNil(arg_167_1.actors_["1054ui_story"]) then
					arg_167_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1054ui_story"]) and arg_167_1.var_.characterEffect1054ui_story then
				arg_167_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.35

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(426091038).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 14 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 14)

				if (14 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 14)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play426091039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426091039
		arg_171_1.duration_ = 5.13

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play426091040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1054ui_story = arg_171_1.actors_["1054ui_story"].transform.localPosition

				local var_174_0 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_0 then
					var_174_0:EnableDynamicBone(false)
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_1)
				arg_171_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).z)
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles = arg_171_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).z)
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles = arg_171_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_174_2 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(true)
				end
			end

			if 0.133333333333333 < arg_171_1.time_ and arg_171_1.time_ <= 0.133333333333333 + arg_174_0 then
				arg_171_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rush", "")
			end

			local var_174_4 = manager.ui.mainCamera.transform

			if 0.133333333333333 < arg_171_1.time_ and arg_171_1.time_ <= 0.133333333333333 + arg_174_0 then
				arg_171_1.var_.shakeOldPos = var_174_4.localPosition
			end

			local var_174_5 = 0.591666666666667

			if 0.133333333333333 <= arg_171_1.time_ and arg_171_1.time_ < 0.133333333333333 + var_174_5 then
				local var_174_6, var_174_7 = math.modf((arg_171_1.time_ - 0.133333333333333) / 0.066)

				var_174_4.localPosition = Vector3.New(var_174_7 * 0.13, var_174_7 * 0.13, var_174_7 * 0.13) + arg_171_1.var_.shakeOldPos
			end

			if arg_171_1.time_ >= 0.133333333333333 + var_174_5 and arg_171_1.time_ < 0.133333333333333 + var_174_5 + arg_174_0 then
				var_174_4.localPosition = arg_171_1.var_.shakeOldPos
			end

			local var_174_8 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_8 + 0.433333333333333 and arg_171_1.time_ < var_174_8 + 0.433333333333333 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_9 = 0.133333333333333
			local var_174_10 = 0.725

			if 0.133333333333333 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_11 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_11:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_12 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(426091039).content)

				arg_171_1.text_.text = var_174_12

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_14 = 29 <= 0 and var_174_10 or var_174_10 * (utf8.len(var_174_12) / 29)

				if (29 <= 0 and var_174_10 or var_174_10 * (utf8.len(var_174_12) / 29)) > 0 and var_174_10 < var_174_14 then
					arg_171_1.talkMaxDuration = var_174_14
					var_174_9 = var_174_9 + 0.3

					if var_174_14 + var_174_9 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_9
					end
				end

				arg_171_1.text_.text = var_174_12
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_15 = var_174_9 + 0.3
			local var_174_16 = math.max(var_174_10, arg_171_1.talkMaxDuration)

			if var_174_9 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_15) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_15 + var_174_16 and arg_171_1.time_ < var_174_15 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play426091040 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 426091040
		arg_177_1.duration_ = 2.17

		local var_177_0 = {
			zh = 2.166,
			ja = 1.999999999999
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
				arg_177_0:Play426091041(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1054ui_story = arg_177_1.actors_["1054ui_story"].transform.localPosition

				local var_180_0 = GameObjectTools.GetOrAddComponent(arg_177_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_180_0 then
					var_180_0:EnableDynamicBone(false)
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_177_1.time_ - 0) / var_180_1)
				arg_177_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1054ui_story"].transform.position).z)
				arg_177_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1054ui_story"].transform.localEulerAngles = arg_177_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_177_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1054ui_story"].transform.position).z)
				arg_177_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1054ui_story"].transform.localEulerAngles = arg_177_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_180_2 = GameObjectTools.GetOrAddComponent(arg_177_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_180_2 then
					var_180_2:EnableDynamicBone(true)
				end
			end

			local var_180_3 = arg_177_1.actors_["1054ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect1054ui_story == nil then
				arg_177_1.var_.characterEffect1054ui_story = var_180_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_4 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 and not isNil(var_180_3) then
				if arg_177_1.var_.characterEffect1054ui_story and not isNil(var_180_3) then
					arg_177_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect1054ui_story then
				arg_177_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_180_6 = 0
			local var_180_7 = 0.125

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_8 = arg_177_1:GetWordFromCfg(426091040)
				local var_180_9 = arg_177_1:FormatText(var_180_8.content)

				arg_177_1.text_.text = var_180_9

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 5 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 5)

				if (5 <= 0 and var_180_7 or var_180_7 * (utf8.len(var_180_9) / 5)) > 0 and var_180_7 < var_180_11 then
					arg_177_1.talkMaxDuration = var_180_11

					if var_180_11 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_11 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_9
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091040", "story_v_out_426091.awb") ~= 0 then
					local var_180_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091040", "story_v_out_426091.awb") / 1000

					if var_180_12 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_6
					end

					if var_180_8.prefab_name ~= "" and arg_177_1.actors_[var_180_8.prefab_name] ~= nil then
						local var_180_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_8.prefab_name].transform, "story_v_out_426091", "426091040", "story_v_out_426091.awb")

						arg_177_1:RecordAudio("426091040", var_180_13)
						arg_177_1:RecordAudio("426091040", var_180_13)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_426091", "426091040", "story_v_out_426091.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_426091", "426091040", "story_v_out_426091.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play426091041 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 426091041
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play426091042(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1054ui_story"]) and arg_181_1.var_.characterEffect1054ui_story == nil then
				arg_181_1.var_.characterEffect1054ui_story = arg_181_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1054ui_story"]) then
				if arg_181_1.var_.characterEffect1054ui_story and not isNil(arg_181_1.actors_["1054ui_story"]) then
					arg_181_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1054ui_story"]) and arg_181_1.var_.characterEffect1054ui_story then
				arg_181_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.65

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
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

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(426091041).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 26 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 26)

				if (26 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 26)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play426091042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 426091042
		arg_185_1.duration_ = 1.73

		local var_185_0 = {
			zh = 1.4,
			ja = 1.733
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
				arg_185_0:Play426091043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1054ui_story = arg_185_1.actors_["1054ui_story"].transform.localPosition

				local var_188_0 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_0 then
					var_188_0:EnableDynamicBone(false)
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_1)
				arg_185_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1054ui_story"].transform.position).z)
				arg_185_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1054ui_story"].transform.localEulerAngles = arg_185_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1054ui_story"].transform.position).z)
				arg_185_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1054ui_story"].transform.localEulerAngles = arg_185_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_188_2 = GameObjectTools.GetOrAddComponent(arg_185_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_188_2 then
					var_188_2:EnableDynamicBone(true)
				end
			end

			local var_188_3 = 0
			local var_188_4 = 0.1

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_5 = arg_185_1:GetWordFromCfg(426091042)
				local var_188_6 = arg_185_1:FormatText(var_188_5.content)

				arg_185_1.text_.text = var_188_6

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_8 = 4 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_6) / 4)

				if (4 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_6) / 4)) > 0 and var_188_4 < var_188_8 then
					arg_185_1.talkMaxDuration = var_188_8

					if var_188_8 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_3
					end
				end

				arg_185_1.text_.text = var_188_6
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091042", "story_v_out_426091.awb") ~= 0 then
					local var_188_9 = manager.audio:GetVoiceLength("story_v_out_426091", "426091042", "story_v_out_426091.awb") / 1000

					if var_188_9 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_3
					end

					if var_188_5.prefab_name ~= "" and arg_185_1.actors_[var_188_5.prefab_name] ~= nil then
						local var_188_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_5.prefab_name].transform, "story_v_out_426091", "426091042", "story_v_out_426091.awb")

						arg_185_1:RecordAudio("426091042", var_188_10)
						arg_185_1:RecordAudio("426091042", var_188_10)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_426091", "426091042", "story_v_out_426091.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_426091", "426091042", "story_v_out_426091.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_11 = math.max(var_188_4, arg_185_1.talkMaxDuration)

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_11 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_3) / var_188_11

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_3 + var_188_11 and arg_185_1.time_ < var_188_3 + var_188_11 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play426091043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 426091043
		arg_189_1.duration_ = 6.67

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play426091044(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_9001
			local var_192_9000

			if arg_189_1.bgs_.SS2602 == nil then
				local var_192_0 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2602")
				var_192_0.name = "SS2602"
				var_192_0.transform.parent = arg_189_1.stage_.transform
				var_192_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_.SS2602 = var_192_0
			end

			if 0.883333333333333 < arg_189_1.time_ and arg_189_1.time_ <= 0.883333333333333 + arg_192_0 then
				local var_192_1 = arg_189_1.bgs_.SS2602

				arg_189_1.bgs_.SS2602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_2 = var_192_1:GetComponent("SpriteRenderer")

				if var_192_2 and var_192_2.sprite then
					local var_192_3 = 2 * (var_192_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_1.transform.localScale = Vector3.New(var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "SS2602" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_4 = 2.06666666368643

			if 2.06666666368643 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			if arg_189_1.time_ >= var_192_4 + 0.3 and arg_189_1.time_ < var_192_4 + 0.3 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_5 = arg_189_1.actors_["1054ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1054ui_story = var_192_5.localPosition

				local var_192_6 = GameObjectTools.GetOrAddComponent(var_192_5.gameObject, typeof(DynamicBoneHelper))

				if var_192_6 then
					var_192_6:EnableDynamicBone(false)
				end
			end

			local var_192_7 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				var_192_5.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_7)
				var_192_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_5.position).x, (manager.ui.mainCamera.transform.position - var_192_5.position).y, (manager.ui.mainCamera.transform.position - var_192_5.position).z)
				var_192_5.localEulerAngles.z = 0
				var_192_5.localEulerAngles.x = 0
				var_192_5.localEulerAngles = var_192_5.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				var_192_5.localPosition = Vector3.New(0, 100, 0)
				var_192_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_5.position).x, (manager.ui.mainCamera.transform.position - var_192_5.position).y, (manager.ui.mainCamera.transform.position - var_192_5.position).z)
				var_192_5.localEulerAngles.z = 0
				var_192_5.localEulerAngles.x = 0
				var_192_5.localEulerAngles = var_192_5.localEulerAngles

				local var_192_8 = GameObjectTools.GetOrAddComponent(var_192_5.gameObject, typeof(DynamicBoneHelper))

				if var_192_8 then
					var_192_8:EnableDynamicBone(true)
				end
			end

			local var_192_9 = arg_189_1.actors_["6148ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect6148ui_story == nil then
				arg_189_1.var_.characterEffect6148ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_10 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_10 and not isNil(var_192_9) then
				if arg_189_1.var_.characterEffect6148ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_189_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_10)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_10 and arg_189_1.time_ < 0 + var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect6148ui_story then
				arg_189_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_189_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0.133333333333333 < arg_189_1.time_ and arg_189_1.time_ <= 0.133333333333333 + arg_192_0 then
				arg_189_1:AudioAction("play", "effect", "se_story_side_1011", "se_story_side_1011_metalhit", "")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_12 = arg_189_1.var_.effecthuangyuanjiaozhan1

				if not arg_189_1.var_.effecthuangyuanjiaozhan1 then
					var_192_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_in_keep"), manager.ui.mainCamera.transform)
					var_192_12.name = "huangyuanjiaozhan1"
					arg_189_1.var_.effecthuangyuanjiaozhan1 = var_192_12
				else
					var_192_12.transform:SetParent(var_192_9001)
				end

				var_192_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_192_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.26666666666667 < arg_189_1.time_ and arg_189_1.time_ <= 1.26666666666667 + arg_192_0 then
				if arg_189_1.var_.effecthuangyuanjiaozhan1 then
					Object.Destroy(arg_189_1.var_.effecthuangyuanjiaozhan1)

					arg_189_1.var_.effecthuangyuanjiaozhan1 = nil
				end
			end

			if 1.26666666666667 < arg_189_1.time_ and arg_189_1.time_ <= 1.26666666666667 + arg_192_0 then
				local var_192_15 = arg_189_1.var_.effecthuangyuanjiaozhan2

				if not arg_189_1.var_.effecthuangyuanjiaozhan2 then
					var_192_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_out"), manager.ui.mainCamera.transform)
					var_192_15.name = "huangyuanjiaozhan2"
					arg_189_1.var_.effecthuangyuanjiaozhan2 = var_192_15
				else
					var_192_15.transform:SetParent(var_192_9000)
				end

				var_192_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_192_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.06666666666667 < arg_189_1.time_ and arg_189_1.time_ <= 2.06666666666667 + arg_192_0 then
				if arg_189_1.var_.effecthuangyuanjiaozhan2 then
					Object.Destroy(arg_189_1.var_.effecthuangyuanjiaozhan2)

					arg_189_1.var_.effecthuangyuanjiaozhan2 = nil
				end
			end

			local var_192_18 = arg_189_1.bgs_.SS2602.transform

			if 0.883333333333333 < arg_189_1.time_ and arg_189_1.time_ <= 0.883333333333333 + arg_192_0 then
				arg_189_1.var_.moveOldPosSS2602 = var_192_18.localPosition
			end

			local var_192_19 = 0.001

			if 0.883333333333333 <= arg_189_1.time_ and arg_189_1.time_ < 0.883333333333333 + var_192_19 then
				var_192_18.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPosSS2602, Vector3.New(0, 1, 1), (arg_189_1.time_ - 0.883333333333333) / var_192_19)
			end

			if arg_189_1.time_ >= 0.883333333333333 + var_192_19 and arg_189_1.time_ < 0.883333333333333 + var_192_19 + arg_192_0 then
				var_192_18.localPosition = Vector3.New(0, 1, 1)
			end

			local var_192_20 = arg_189_1.bgs_.SS2602.transform

			if 0.9 < arg_189_1.time_ and arg_189_1.time_ <= 0.9 + arg_192_0 then
				arg_189_1.var_.moveOldPosSS2602 = var_192_20.localPosition
			end

			local var_192_21 = 0.966666666666666

			if 0.9 <= arg_189_1.time_ and arg_189_1.time_ < 0.9 + var_192_21 then
				var_192_20.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPosSS2602, Vector3.New(0, 1, 10), (arg_189_1.time_ - 0.9) / var_192_21)
			end

			if arg_189_1.time_ >= 0.9 + var_192_21 and arg_189_1.time_ < 0.9 + var_192_21 + arg_192_0 then
				var_192_20.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_22 = 1.66666666368643
			local var_192_23 = 0.95

			if 1.66666666368643 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_24 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_24:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_25 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(426091043).content)

				arg_189_1.text_.text = var_192_25

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_27 = 38 <= 0 and var_192_23 or var_192_23 * (utf8.len(var_192_25) / 38)

				if (38 <= 0 and var_192_23 or var_192_23 * (utf8.len(var_192_25) / 38)) > 0 and var_192_23 < var_192_27 then
					arg_189_1.talkMaxDuration = var_192_27
					var_192_22 = var_192_22 + 0.3

					if var_192_27 + var_192_22 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_27 + var_192_22
					end
				end

				arg_189_1.text_.text = var_192_25
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_28 = var_192_22 + 0.3
			local var_192_29 = math.max(var_192_23, arg_189_1.talkMaxDuration)

			if var_192_22 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_28 + var_192_29 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_28) / var_192_29

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_28 + var_192_29 and arg_189_1.time_ < var_192_28 + var_192_29 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.0166666666666667,
				startTime = 0.883333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 1),
					endPos = Vector3.New(0, 1, 1),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.966666666666666,
				startTime = 0.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 1),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play426091044 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 426091044
		arg_195_1.duration_ = 5.17

		local var_195_0 = {
			zh = 5.166,
			ja = 4.133
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play426091045(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.45

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(426091044)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 18 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 18)

				if (18 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 18)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091044", "story_v_out_426091.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091044", "story_v_out_426091.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_426091", "426091044", "story_v_out_426091.awb")

						arg_195_1:RecordAudio("426091044", var_198_6)
						arg_195_1:RecordAudio("426091044", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_426091", "426091044", "story_v_out_426091.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_426091", "426091044", "story_v_out_426091.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play426091045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 426091045
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play426091046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.225

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

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(426091045).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 9 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 9)

				if (9 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 9)) > 0 and var_202_0 < var_202_3 then
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
	Play426091046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 426091046
		arg_203_1.duration_ = 7.2

		local var_203_0 = {
			zh = 5.233,
			ja = 7.2
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
				arg_203_0:Play426091047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.55

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(426091046)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 22 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 22)

				if (22 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 22)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091046", "story_v_out_426091.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091046", "story_v_out_426091.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_426091", "426091046", "story_v_out_426091.awb")

						arg_203_1:RecordAudio("426091046", var_206_6)
						arg_203_1:RecordAudio("426091046", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_426091", "426091046", "story_v_out_426091.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_426091", "426091046", "story_v_out_426091.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play426091047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 426091047
		arg_207_1.duration_ = 6.67

		local var_207_0 = {
			zh = 6.1,
			ja = 6.666
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
				arg_207_0:Play426091048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.775

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:GetWordFromCfg(426091047)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 31 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 31)

				if (31 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 31)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091047", "story_v_out_426091.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091047", "story_v_out_426091.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_426091", "426091047", "story_v_out_426091.awb")

						arg_207_1:RecordAudio("426091047", var_210_6)
						arg_207_1:RecordAudio("426091047", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_426091", "426091047", "story_v_out_426091.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_426091", "426091047", "story_v_out_426091.awb")
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
	Play426091048 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 426091048
		arg_211_1.duration_ = 3.97

		local var_211_0 = {
			zh = 2.466,
			ja = 3.966
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play426091049(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.175

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(426091048)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 7 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 7)

				if (7 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 7)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091048", "story_v_out_426091.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091048", "story_v_out_426091.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_426091", "426091048", "story_v_out_426091.awb")

						arg_211_1:RecordAudio("426091048", var_214_6)
						arg_211_1:RecordAudio("426091048", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_426091", "426091048", "story_v_out_426091.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_426091", "426091048", "story_v_out_426091.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play426091049 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 426091049
		arg_215_1.duration_ = 1.47

		local var_215_0 = {
			zh = 1.4,
			ja = 1.466
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
				arg_215_0:Play426091050(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.075

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(426091049)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 3 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 3)

				if (3 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 3)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091049", "story_v_out_426091.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091049", "story_v_out_426091.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_426091", "426091049", "story_v_out_426091.awb")

						arg_215_1:RecordAudio("426091049", var_218_6)
						arg_215_1:RecordAudio("426091049", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_426091", "426091049", "story_v_out_426091.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_426091", "426091049", "story_v_out_426091.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play426091050 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 426091050
		arg_219_1.duration_ = 5.33

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play426091051(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_9000

			if 0.333333333333333 < arg_219_1.time_ and arg_219_1.time_ <= 0.333333333333333 + arg_222_0 then
				arg_219_1:AudioAction("play", "effect", "se_story_144", "se_story_144_smoke02", "")
			end

			local var_222_1 = manager.ui.mainCamera.transform

			if 0.333333333333333 < arg_219_1.time_ and arg_219_1.time_ <= 0.333333333333333 + arg_222_0 then
				arg_219_1.var_.shakeOldPos = var_222_1.localPosition
			end

			local var_222_2 = 0.3

			if 0.333333333333333 <= arg_219_1.time_ and arg_219_1.time_ < 0.333333333333333 + var_222_2 then
				local var_222_3, var_222_4 = math.modf((arg_219_1.time_ - 0.333333333333333) / 0.066)

				var_222_1.localPosition = Vector3.New(var_222_4 * 0.13, var_222_4 * 0.13, var_222_4 * 0.13) + arg_219_1.var_.shakeOldPos
			end

			if arg_219_1.time_ >= 0.333333333333333 + var_222_2 and arg_219_1.time_ < 0.333333333333333 + var_222_2 + arg_222_0 then
				var_222_1.localPosition = arg_219_1.var_.shakeOldPos
			end

			if 0.333333333333333 < arg_219_1.time_ and arg_219_1.time_ <= 0.333333333333333 + arg_222_0 then
				local var_222_5 = arg_219_1.var_.effectwuchangdajia1

				if not arg_219_1.var_.effectwuchangdajia1 then
					var_222_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_222_5.name = "wuchangdajia1"
					arg_219_1.var_.effectwuchangdajia1 = var_222_5
				else
					var_222_5.transform:SetParent(var_222_9000)
				end

				var_222_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_222_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.33333333333333 < arg_219_1.time_ and arg_219_1.time_ <= 2.33333333333333 + arg_222_0 then
				if arg_219_1.var_.effectwuchangdajia1 then
					Object.Destroy(arg_219_1.var_.effectwuchangdajia1)

					arg_219_1.var_.effectwuchangdajia1 = nil
				end
			end

			local var_222_8 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			if arg_219_1.time_ >= var_222_8 + 2.46666666666667 and arg_219_1.time_ < var_222_8 + 2.46666666666667 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_9 = 0.333333333333333
			local var_222_10 = 0.85

			if 0.333333333333333 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_11 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_11:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_12 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(426091050).content)

				arg_219_1.text_.text = var_222_12

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_14 = 34 <= 0 and var_222_10 or var_222_10 * (utf8.len(var_222_12) / 34)

				if (34 <= 0 and var_222_10 or var_222_10 * (utf8.len(var_222_12) / 34)) > 0 and var_222_10 < var_222_14 then
					arg_219_1.talkMaxDuration = var_222_14
					var_222_9 = var_222_9 + 0.3

					if var_222_14 + var_222_9 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_9
					end
				end

				arg_219_1.text_.text = var_222_12
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_15 = var_222_9 + 0.3
			local var_222_16 = math.max(var_222_10, arg_219_1.talkMaxDuration)

			if var_222_9 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_16 and arg_219_1.time_ < var_222_15 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play426091051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 426091051
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play426091052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.875

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(426091051).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 35 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 35)

				if (35 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 35)) > 0 and var_228_0 < var_228_3 then
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
	Play426091052 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 426091052
		arg_229_1.duration_ = 10.13

		local var_229_0 = {
			zh = 10.133,
			ja = 9.533
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
				arg_229_0:Play426091053(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.75

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:GetWordFromCfg(426091052)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 30 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 30)

				if (30 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 30)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091052", "story_v_out_426091.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091052", "story_v_out_426091.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_426091", "426091052", "story_v_out_426091.awb")

						arg_229_1:RecordAudio("426091052", var_232_6)
						arg_229_1:RecordAudio("426091052", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_426091", "426091052", "story_v_out_426091.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_426091", "426091052", "story_v_out_426091.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play426091053 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 426091053
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play426091054(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.775

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(426091053).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 31 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 31)

				if (31 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 31)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play426091054 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 426091054
		arg_237_1.duration_ = 2.03

		local var_237_0 = {
			zh = 2.033,
			ja = 1.966
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
				arg_237_0:Play426091055(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:GetWordFromCfg(426091054)
				local var_240_2 = arg_237_1:FormatText(var_240_1.content)

				arg_237_1.text_.text = var_240_2

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_4 = 5 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 5)

				if (5 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_2) / 5)) > 0 and var_240_0 < var_240_4 then
					arg_237_1.talkMaxDuration = var_240_4

					if var_240_4 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_4 + 0
					end
				end

				arg_237_1.text_.text = var_240_2
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091054", "story_v_out_426091.awb") ~= 0 then
					local var_240_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091054", "story_v_out_426091.awb") / 1000

					if var_240_5 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + 0
					end

					if var_240_1.prefab_name ~= "" and arg_237_1.actors_[var_240_1.prefab_name] ~= nil then
						local var_240_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_1.prefab_name].transform, "story_v_out_426091", "426091054", "story_v_out_426091.awb")

						arg_237_1:RecordAudio("426091054", var_240_6)
						arg_237_1:RecordAudio("426091054", var_240_6)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_426091", "426091054", "story_v_out_426091.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_426091", "426091054", "story_v_out_426091.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play426091055 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 426091055
		arg_241_1.duration_ = 6.73

		local var_241_0 = {
			zh = 6.733,
			ja = 6.6
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
				arg_241_0:Play426091056(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.675

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(426091055)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 26 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 26)

				if (26 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 26)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091055", "story_v_out_426091.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091055", "story_v_out_426091.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_426091", "426091055", "story_v_out_426091.awb")

						arg_241_1:RecordAudio("426091055", var_244_6)
						arg_241_1:RecordAudio("426091055", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_426091", "426091055", "story_v_out_426091.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_426091", "426091055", "story_v_out_426091.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play426091056 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 426091056
		arg_245_1.duration_ = 6.13

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play426091057(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_9000

			if 0.133333333333333 < arg_245_1.time_ and arg_245_1.time_ <= 0.133333333333333 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_139", "se_story_139_metalhit01", "")
			end

			local var_248_1 = arg_245_1.bgs_.SS2602.transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPosSS2602 = var_248_1.localPosition
			end

			local var_248_2 = 2.03333333333333

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 then
				var_248_1.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPosSS2602, Vector3.New(0, 1, 9.5), (arg_245_1.time_ - 0) / var_248_2)
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 then
				var_248_1.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0.133333333333333 < arg_245_1.time_ and arg_245_1.time_ <= 0.133333333333333 + arg_248_0 then
				local var_248_3 = arg_245_1.var_.effectwuchangdadouqiliu

				if not arg_245_1.var_.effectwuchangdadouqiliu then
					var_248_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu2"), manager.ui.mainCamera.transform)
					var_248_3.name = "wuchangdadouqiliu"
					arg_245_1.var_.effectwuchangdadouqiliu = var_248_3
				else
					var_248_3.transform:SetParent(var_248_9000)
				end

				var_248_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_5 = 1.13333333333333
			local var_248_6 = 0.975

			if 1.13333333333333 < arg_245_1.time_ and arg_245_1.time_ <= var_248_5 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_7 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_7:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_8 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(426091056).content)

				arg_245_1.text_.text = var_248_8

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_10 = 39 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_8) / 39)

				if (39 <= 0 and var_248_6 or var_248_6 * (utf8.len(var_248_8) / 39)) > 0 and var_248_6 < var_248_10 then
					arg_245_1.talkMaxDuration = var_248_10
					var_248_5 = var_248_5 + 0.3

					if var_248_10 + var_248_5 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_5
					end
				end

				arg_245_1.text_.text = var_248_8
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_11 = var_248_5 + 0.3
			local var_248_12 = math.max(var_248_6, arg_245_1.talkMaxDuration)

			if var_248_5 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_11 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_11) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_11 + var_248_12 and arg_245_1.time_ < var_248_11 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.03333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play426091057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 426091057
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play426091058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.9

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(426091057).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 36 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 36)

				if (36 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 36)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play426091058 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 426091058
		arg_255_1.duration_ = 7.03

		local var_255_0 = {
			zh = 6.166,
			ja = 7.033
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
				arg_255_0:Play426091059(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.55

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(426091058)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 23 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 23)

				if (23 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 23)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091058", "story_v_out_426091.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091058", "story_v_out_426091.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_426091", "426091058", "story_v_out_426091.awb")

						arg_255_1:RecordAudio("426091058", var_258_6)
						arg_255_1:RecordAudio("426091058", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_426091", "426091058", "story_v_out_426091.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_426091", "426091058", "story_v_out_426091.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play426091059 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 426091059
		arg_259_1.duration_ = 3.57

		local var_259_0 = {
			zh = 3.3,
			ja = 3.566
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
				arg_259_0:Play426091060(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.2

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(426091059)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 8 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 8)

				if (8 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 8)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091059", "story_v_out_426091.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091059", "story_v_out_426091.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_426091", "426091059", "story_v_out_426091.awb")

						arg_259_1:RecordAudio("426091059", var_262_6)
						arg_259_1:RecordAudio("426091059", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_426091", "426091059", "story_v_out_426091.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_426091", "426091059", "story_v_out_426091.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play426091060 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 426091060
		arg_263_1.duration_ = 5.03

		local var_263_0 = {
			zh = 5.033,
			ja = 3.6
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play426091061(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0.133333333333333 < arg_263_1.time_ and arg_263_1.time_ <= 0.133333333333333 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "ui_skip", "ui_bgm_66", "")
			end

			local var_266_1 = 0
			local var_266_2 = 0.3

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:GetWordFromCfg(426091060)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_6 = 13 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_4) / 13)

				if (13 <= 0 and var_266_2 or var_266_2 * (utf8.len(var_266_4) / 13)) > 0 and var_266_2 < var_266_6 then
					arg_263_1.talkMaxDuration = var_266_6

					if var_266_6 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_1
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091060", "story_v_out_426091.awb") ~= 0 then
					local var_266_7 = manager.audio:GetVoiceLength("story_v_out_426091", "426091060", "story_v_out_426091.awb") / 1000

					if var_266_7 + var_266_1 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_1
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_426091", "426091060", "story_v_out_426091.awb")

						arg_263_1:RecordAudio("426091060", var_266_8)
						arg_263_1:RecordAudio("426091060", var_266_8)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_426091", "426091060", "story_v_out_426091.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_426091", "426091060", "story_v_out_426091.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_9 = math.max(var_266_2, arg_263_1.talkMaxDuration)

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_9 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_1) / var_266_9

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_1 + var_266_9 and arg_263_1.time_ < var_266_1 + var_266_9 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play426091061 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 426091061
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play426091062(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0.133333333333333 < arg_267_1.time_ and arg_267_1.time_ <= 0.133333333333333 + arg_270_0 then
				arg_267_1:AudioAction("play", "effect", "se_story_150", "se_story_150_metalhit", "")
			end

			local var_270_1 = arg_267_1.bgs_.SS2602.transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPosSS2602 = var_270_1.localPosition
			end

			local var_270_2 = 2.03333333333333

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 then
				var_270_1.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPosSS2602, Vector3.New(0.97, 1, 8), (arg_267_1.time_ - 0) / var_270_2)
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 then
				var_270_1.localPosition = Vector3.New(0.97, 1, 8)
			end

			local var_270_3 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_3 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= var_270_3 + 2.03333333333333 and arg_267_1.time_ < var_270_3 + 2.03333333333333 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_4 = 0
			local var_270_5 = 1.4

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_6 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_6:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(426091061).content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 56 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 56)

				if (56 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 56)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9
					var_270_4 = var_270_4 + 0.3

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = var_270_4 + 0.3
			local var_270_11 = math.max(var_270_5, arg_267_1.talkMaxDuration)

			if var_270_4 + 0.3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_11 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_10) / var_270_11

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_10 + var_270_11 and arg_267_1.time_ < var_270_10 + var_270_11 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.03333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0.97, 1, 8),
					easeType = LeanTweenType.easeInOutCirc
				}
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play426091062 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 426091062
		arg_273_1.duration_ = 2.13

		local var_273_0 = {
			zh = 2.133,
			ja = 1.333
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play426091063(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.175

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:GetWordFromCfg(426091062)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 7 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 7)

				if (7 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 7)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091062", "story_v_out_426091.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091062", "story_v_out_426091.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_426091", "426091062", "story_v_out_426091.awb")

						arg_273_1:RecordAudio("426091062", var_276_6)
						arg_273_1:RecordAudio("426091062", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_426091", "426091062", "story_v_out_426091.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_426091", "426091062", "story_v_out_426091.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play426091063 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 426091063
		arg_277_1.duration_ = 8.5

		local var_277_0 = {
			zh = 8.5,
			ja = 6.033
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play426091064(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.825

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(426091063)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 33 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 33)

				if (33 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 33)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091063", "story_v_out_426091.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091063", "story_v_out_426091.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_426091", "426091063", "story_v_out_426091.awb")

						arg_277_1:RecordAudio("426091063", var_280_6)
						arg_277_1:RecordAudio("426091063", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_426091", "426091063", "story_v_out_426091.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_426091", "426091063", "story_v_out_426091.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play426091064 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 426091064
		arg_281_1.duration_ = 6.63

		local var_281_0 = {
			zh = 6.033,
			ja = 6.633
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
				arg_281_0:Play426091065(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.35

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(426091064)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 14 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 14)

				if (14 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 14)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091064", "story_v_out_426091.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091064", "story_v_out_426091.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_426091", "426091064", "story_v_out_426091.awb")

						arg_281_1:RecordAudio("426091064", var_284_6)
						arg_281_1:RecordAudio("426091064", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_426091", "426091064", "story_v_out_426091.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_426091", "426091064", "story_v_out_426091.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play426091065 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 426091065
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play426091066(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_288_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_285_1.bgmTxt_.text ~= var_288_2 and arg_285_1.bgmTxt_.text ~= "" then
						if arg_285_1.bgmTxt2_.text ~= "" then
							arg_285_1.bgmTxt_.text = arg_285_1.bgmTxt2_.text
						end

						arg_285_1.bgmTxt2_.text = var_288_2

						arg_285_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_285_1.bgmTxt_.text = var_288_2
						arg_285_1.bgmTxt2_.text = var_288_2
					end

					if arg_285_1.bgmTimer then
						arg_285_1.bgmTimer:Stop()

						arg_285_1.bgmTimer = nil
					end

					if arg_285_1.settingData.show_music_name == 1 then
						arg_285_1.musicController:SetSelectedState("show")
						arg_285_1.musicAnimator_:Play("open", 0, 0)

						if arg_285_1.settingData.music_time ~= 0 then
							arg_285_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_285_1.settingData.music_time), function()
								if arg_285_1 == nil or isNil(arg_285_1.bgmTxt_) then
									return
								end

								arg_285_1.musicController:SetSelectedState("hide")
								arg_285_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_288_3 = 0
			local var_288_4 = 0.1

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_3 + arg_288_0 then
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

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_5 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(426091065).content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 4 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_5) / 4)

				if (4 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_5) / 4)) > 0 and var_288_4 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_3 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_3
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_4, arg_285_1.talkMaxDuration)

			if var_288_3 <= arg_285_1.time_ and arg_285_1.time_ < var_288_3 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_3) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_3 + var_288_8 and arg_285_1.time_ < var_288_3 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play426091066 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 426091066
		arg_290_1.duration_ = 9

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play426091067(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if arg_290_1.bgs_.J27h == nil then
				local var_293_0 = Object.Instantiate(arg_290_1.paintGo_)

				var_293_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27h")
				var_293_0.name = "J27h"
				var_293_0.transform.parent = arg_290_1.stage_.transform
				var_293_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_290_1.bgs_.J27h = var_293_0
			end

			if 2 < arg_290_1.time_ and arg_290_1.time_ <= 2 + arg_293_0 then
				local var_293_1 = arg_290_1.bgs_.J27h

				arg_290_1.bgs_.J27h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_293_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_2 = var_293_1:GetComponent("SpriteRenderer")

				if var_293_2 and var_293_2.sprite then
					local var_293_3 = 2 * (var_293_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_293_1.transform.localScale = Vector3.New(var_293_3 / var_293_2.sprite.bounds.size.y < var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x and var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x or var_293_3 / var_293_2.sprite.bounds.size.y, var_293_3 / var_293_2.sprite.bounds.size.y < var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x and var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x or var_293_3 / var_293_2.sprite.bounds.size.y, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "J27h" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_4 = 4

			if 4 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
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

				var_293_7.a = Mathf.Lerp(0, 1, (arg_290_1.time_ - var_293_5) / var_293_6)
				arg_290_1.mask_.color = var_293_7
			end

			if arg_290_1.time_ >= var_293_5 + var_293_6 and arg_290_1.time_ < var_293_5 + var_293_6 + arg_293_0 then
				local var_293_8 = Color.New(0, 0, 0)

				var_293_8.a = 1
				arg_290_1.mask_.color = var_293_8
			end

			local var_293_9 = 2

			if 2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_10 = 2

			if var_293_9 <= arg_290_1.time_ and arg_290_1.time_ < var_293_9 + var_293_10 then
				local var_293_11 = Color.New(0, 0, 0)

				var_293_11.a = Mathf.Lerp(1, 0, (arg_290_1.time_ - var_293_9) / var_293_10)
				arg_290_1.mask_.color = var_293_11
			end

			if arg_290_1.time_ >= var_293_9 + var_293_10 and arg_290_1.time_ < var_293_9 + var_293_10 + arg_293_0 then
				local var_293_12 = Color.New(0, 0, 0)

				arg_290_1.mask_.enabled = false
				var_293_12.a = 0
				arg_290_1.mask_.color = var_293_12
			end

			if 2 < arg_290_1.time_ and arg_290_1.time_ <= 2 + arg_293_0 then
				arg_290_1:AudioAction("stop", "effect", "se_story_150", "se_story_150_flower_field", "")
			end

			if 2.3 < arg_290_1.time_ and arg_290_1.time_ <= 2.3 + arg_293_0 then
				arg_290_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if 1.8 < arg_290_1.time_ and arg_290_1.time_ <= 1.8 + arg_293_0 then
				if arg_290_1.var_.effectwuchangdadouqiliu then
					Object.Destroy(arg_290_1.var_.effectwuchangdadouqiliu)

					arg_290_1.var_.effectwuchangdadouqiliu = nil
				end
			end

			local var_293_16 = 2

			arg_290_1.isInRecall_ = true

			if var_293_16 < arg_290_1.time_ and arg_290_1.time_ <= var_293_16 + arg_293_0 then
				arg_290_1.screenFilterGo_:SetActive(true)

				arg_290_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_290_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_290_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_293_2, iter_293_3 in pairs(arg_290_1.actors_) do
					for iter_293_4, iter_293_5 in ipairs((iter_293_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_293_5.color = iter_293_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_293_17 = 0.299999999999999

			if var_293_16 <= arg_290_1.time_ and arg_290_1.time_ < var_293_16 + var_293_17 then
				arg_290_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_290_1.time_ - var_293_16) / var_293_17)
			end

			if arg_290_1.time_ >= var_293_16 + var_293_17 and arg_290_1.time_ < var_293_16 + var_293_17 + arg_293_0 then
				arg_290_1.screenFilterEffect_.weight = 1
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_18 = 4
			local var_293_19 = 0.95

			if 4 < arg_290_1.time_ and arg_290_1.time_ <= var_293_18 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_20 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_20:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_21 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(426091066).content)

				arg_290_1.text_.text = var_293_21

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_23 = 38 <= 0 and var_293_19 or var_293_19 * (utf8.len(var_293_21) / 38)

				if (38 <= 0 and var_293_19 or var_293_19 * (utf8.len(var_293_21) / 38)) > 0 and var_293_19 < var_293_23 then
					arg_290_1.talkMaxDuration = var_293_23
					var_293_18 = var_293_18 + 0.3

					if var_293_23 + var_293_18 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_23 + var_293_18
					end
				end

				arg_290_1.text_.text = var_293_21
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_24 = var_293_18 + 0.3
			local var_293_25 = math.max(var_293_19, arg_290_1.talkMaxDuration)

			if var_293_18 + 0.3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_24 + var_293_25 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_24) / var_293_25

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_24 + var_293_25 and arg_290_1.time_ < var_293_24 + var_293_25 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play426091067 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 426091067
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play426091068(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_299_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_296_1.bgmTxt_.text ~= var_299_2 and arg_296_1.bgmTxt_.text ~= "" then
						if arg_296_1.bgmTxt2_.text ~= "" then
							arg_296_1.bgmTxt_.text = arg_296_1.bgmTxt2_.text
						end

						arg_296_1.bgmTxt2_.text = var_299_2

						arg_296_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_296_1.bgmTxt_.text = var_299_2
						arg_296_1.bgmTxt2_.text = var_299_2
					end

					if arg_296_1.bgmTimer then
						arg_296_1.bgmTimer:Stop()

						arg_296_1.bgmTimer = nil
					end

					if arg_296_1.settingData.show_music_name == 1 then
						arg_296_1.musicController:SetSelectedState("show")
						arg_296_1.musicAnimator_:Play("open", 0, 0)

						if arg_296_1.settingData.music_time ~= 0 then
							arg_296_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_296_1.settingData.music_time), function()
								if arg_296_1 == nil or isNil(arg_296_1.bgmTxt_) then
									return
								end

								arg_296_1.musicController:SetSelectedState("hide")
								arg_296_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_296_1.time_ and arg_296_1.time_ <= 0.433333333333333 + arg_299_0 then
				arg_296_1:AudioAction("play", "music", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_299_5 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

				if "" ~= "" then
					if arg_296_1.bgmTxt_.text ~= var_299_5 and arg_296_1.bgmTxt_.text ~= "" then
						if arg_296_1.bgmTxt2_.text ~= "" then
							arg_296_1.bgmTxt_.text = arg_296_1.bgmTxt2_.text
						end

						arg_296_1.bgmTxt2_.text = var_299_5

						arg_296_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_296_1.bgmTxt_.text = var_299_5
						arg_296_1.bgmTxt2_.text = var_299_5
					end

					if arg_296_1.bgmTimer then
						arg_296_1.bgmTimer:Stop()

						arg_296_1.bgmTimer = nil
					end

					if arg_296_1.settingData.show_music_name == 1 then
						arg_296_1.musicController:SetSelectedState("show")
						arg_296_1.musicAnimator_:Play("open", 0, 0)

						if arg_296_1.settingData.music_time ~= 0 then
							arg_296_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_296_1.settingData.music_time), function()
								if arg_296_1 == nil or isNil(arg_296_1.bgmTxt_) then
									return
								end

								arg_296_1.musicController:SetSelectedState("hide")
								arg_296_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_299_6 = 0
			local var_299_7 = 0.2

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_296_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_299_8 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(426091067).content)

				arg_296_1.text_.text = var_299_8

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_10 = 8 <= 0 and var_299_7 or var_299_7 * (utf8.len(var_299_8) / 8)

				if (8 <= 0 and var_299_7 or var_299_7 * (utf8.len(var_299_8) / 8)) > 0 and var_299_7 < var_299_10 then
					arg_296_1.talkMaxDuration = var_299_10

					if var_299_10 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_8
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_11 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_11 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_11

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_11 and arg_296_1.time_ < var_299_6 + var_299_11 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play426091068 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 426091068
		arg_302_1.duration_ = 12.9

		local var_302_0 = {
			zh = 9.566,
			ja = 12.9
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play426091069(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1054ui_story = arg_302_1.actors_["1054ui_story"].transform.localPosition

				local var_305_0 = GameObjectTools.GetOrAddComponent(arg_302_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_305_0 then
					var_305_0:EnableDynamicBone(false)
				end
			end

			local var_305_1 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_1 then
				arg_302_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_302_1.time_ - 0) / var_305_1)
				arg_302_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1054ui_story"].transform.position).z)
				arg_302_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1054ui_story"].transform.localEulerAngles = arg_302_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_1 and arg_302_1.time_ < 0 + var_305_1 + arg_305_0 then
				arg_302_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_302_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1054ui_story"].transform.position).z)
				arg_302_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1054ui_story"].transform.localEulerAngles = arg_302_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_305_2 = GameObjectTools.GetOrAddComponent(arg_302_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_305_2 then
					var_305_2:EnableDynamicBone(true)
				end
			end

			local var_305_3 = arg_302_1.actors_["1054ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_3) and arg_302_1.var_.characterEffect1054ui_story == nil then
				arg_302_1.var_.characterEffect1054ui_story = var_305_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_4 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 and not isNil(var_305_3) then
				if arg_302_1.var_.characterEffect1054ui_story and not isNil(var_305_3) then
					arg_302_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 and not isNil(var_305_3) and arg_302_1.var_.characterEffect1054ui_story then
				arg_302_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_305_6 = 0
			local var_305_7 = 0.775

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_8 = arg_302_1:GetWordFromCfg(426091068)
				local var_305_9 = arg_302_1:FormatText(var_305_8.content)

				arg_302_1.text_.text = var_305_9

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 31 <= 0 and var_305_7 or var_305_7 * (utf8.len(var_305_9) / 31)

				if (31 <= 0 and var_305_7 or var_305_7 * (utf8.len(var_305_9) / 31)) > 0 and var_305_7 < var_305_11 then
					arg_302_1.talkMaxDuration = var_305_11

					if var_305_11 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_9
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091068", "story_v_out_426091.awb") ~= 0 then
					local var_305_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091068", "story_v_out_426091.awb") / 1000

					if var_305_12 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_6
					end

					if var_305_8.prefab_name ~= "" and arg_302_1.actors_[var_305_8.prefab_name] ~= nil then
						local var_305_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_8.prefab_name].transform, "story_v_out_426091", "426091068", "story_v_out_426091.awb")

						arg_302_1:RecordAudio("426091068", var_305_13)
						arg_302_1:RecordAudio("426091068", var_305_13)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_426091", "426091068", "story_v_out_426091.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_426091", "426091068", "story_v_out_426091.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_14 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_14 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_14

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_14 and arg_302_1.time_ < var_305_6 + var_305_14 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play426091069 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 426091069
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play426091070(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1054ui_story"]) and arg_306_1.var_.characterEffect1054ui_story == nil then
				arg_306_1.var_.characterEffect1054ui_story = arg_306_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1054ui_story"]) then
				if arg_306_1.var_.characterEffect1054ui_story and not isNil(arg_306_1.actors_["1054ui_story"]) then
					arg_306_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1054ui_story"]) and arg_306_1.var_.characterEffect1054ui_story then
				arg_306_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.475

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_306_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(426091069).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 19 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 19)

				if (19 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 19)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play426091070 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 426091070
		arg_310_1.duration_ = 6.57

		local var_310_0 = {
			zh = 6.133,
			ja = 6.566
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play426091071(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1054ui_story"]) and arg_310_1.var_.characterEffect1054ui_story == nil then
				arg_310_1.var_.characterEffect1054ui_story = arg_310_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1054ui_story"]) then
				if arg_310_1.var_.characterEffect1054ui_story and not isNil(arg_310_1.actors_["1054ui_story"]) then
					arg_310_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1054ui_story"]) and arg_310_1.var_.characterEffect1054ui_story then
				arg_310_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_313_2 = 0
			local var_313_3 = 0.45

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_4 = arg_310_1:GetWordFromCfg(426091070)
				local var_313_5 = arg_310_1:FormatText(var_313_4.content)

				arg_310_1.text_.text = var_313_5

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_7 = 18 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 18)

				if (18 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 18)) > 0 and var_313_3 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_5
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091070", "story_v_out_426091.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091070", "story_v_out_426091.awb") / 1000

					if var_313_8 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_2
					end

					if var_313_4.prefab_name ~= "" and arg_310_1.actors_[var_313_4.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_4.prefab_name].transform, "story_v_out_426091", "426091070", "story_v_out_426091.awb")

						arg_310_1:RecordAudio("426091070", var_313_9)
						arg_310_1:RecordAudio("426091070", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_426091", "426091070", "story_v_out_426091.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_426091", "426091070", "story_v_out_426091.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_10 and arg_310_1.time_ < var_313_2 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play426091071 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 426091071
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play426091072(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1054ui_story"]) and arg_314_1.var_.characterEffect1054ui_story == nil then
				arg_314_1.var_.characterEffect1054ui_story = arg_314_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1054ui_story"]) then
				if arg_314_1.var_.characterEffect1054ui_story and not isNil(arg_314_1.actors_["1054ui_story"]) then
					arg_314_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_0)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1054ui_story"]) and arg_314_1.var_.characterEffect1054ui_story then
				arg_314_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_317_1 = 0
			local var_317_2 = 0.925

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_314_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_317_3 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(426091071).content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 37 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 37)

				if (37 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 37)) > 0 and var_317_2 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_1 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_1
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_6 = math.max(var_317_2, arg_314_1.talkMaxDuration)

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_6 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_1) / var_317_6

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_1 + var_317_6 and arg_314_1.time_ < var_317_1 + var_317_6 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play426091072 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 426091072
		arg_318_1.duration_ = 3.87

		local var_318_0 = {
			zh = 2.533,
			ja = 3.866
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
				arg_318_0:Play426091073(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1054ui_story = arg_318_1.actors_["1054ui_story"].transform.localPosition

				local var_321_0 = GameObjectTools.GetOrAddComponent(arg_318_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_321_0 then
					var_321_0:EnableDynamicBone(false)
				end
			end

			local var_321_1 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_1 then
				arg_318_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_318_1.time_ - 0) / var_321_1)
				arg_318_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1054ui_story"].transform.position).z)
				arg_318_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1054ui_story"].transform.localEulerAngles = arg_318_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_1 and arg_318_1.time_ < 0 + var_321_1 + arg_321_0 then
				arg_318_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_318_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1054ui_story"].transform.position).z)
				arg_318_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1054ui_story"].transform.localEulerAngles = arg_318_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_321_2 = GameObjectTools.GetOrAddComponent(arg_318_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_321_2 then
					var_321_2:EnableDynamicBone(true)
				end
			end

			local var_321_3 = arg_318_1.actors_["1054ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_3) and arg_318_1.var_.characterEffect1054ui_story == nil then
				arg_318_1.var_.characterEffect1054ui_story = var_321_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_4 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 and not isNil(var_321_3) then
				if arg_318_1.var_.characterEffect1054ui_story and not isNil(var_321_3) then
					arg_318_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 and not isNil(var_321_3) and arg_318_1.var_.characterEffect1054ui_story then
				arg_318_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_321_6 = 0
			local var_321_7 = 0.15

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_6 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_8 = arg_318_1:GetWordFromCfg(426091072)
				local var_321_9 = arg_318_1:FormatText(var_321_8.content)

				arg_318_1.text_.text = var_321_9

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_11 = 6 <= 0 and var_321_7 or var_321_7 * (utf8.len(var_321_9) / 6)

				if (6 <= 0 and var_321_7 or var_321_7 * (utf8.len(var_321_9) / 6)) > 0 and var_321_7 < var_321_11 then
					arg_318_1.talkMaxDuration = var_321_11

					if var_321_11 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_11 + var_321_6
					end
				end

				arg_318_1.text_.text = var_321_9
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091072", "story_v_out_426091.awb") ~= 0 then
					local var_321_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091072", "story_v_out_426091.awb") / 1000

					if var_321_12 + var_321_6 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_12 + var_321_6
					end

					if var_321_8.prefab_name ~= "" and arg_318_1.actors_[var_321_8.prefab_name] ~= nil then
						local var_321_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_8.prefab_name].transform, "story_v_out_426091", "426091072", "story_v_out_426091.awb")

						arg_318_1:RecordAudio("426091072", var_321_13)
						arg_318_1:RecordAudio("426091072", var_321_13)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_426091", "426091072", "story_v_out_426091.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_426091", "426091072", "story_v_out_426091.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_14 = math.max(var_321_7, arg_318_1.talkMaxDuration)

			if var_321_6 <= arg_318_1.time_ and arg_318_1.time_ < var_321_6 + var_321_14 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_6) / var_321_14

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_6 + var_321_14 and arg_318_1.time_ < var_321_6 + var_321_14 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091073 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 426091073
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play426091074(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos1054ui_story = arg_322_1.actors_["1054ui_story"].transform.localPosition

				local var_325_0 = GameObjectTools.GetOrAddComponent(arg_322_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_325_0 then
					var_325_0:EnableDynamicBone(false)
				end
			end

			local var_325_1 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_1 then
				arg_322_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_322_1.time_ - 0) / var_325_1)
				arg_322_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1054ui_story"].transform.position).z)
				arg_322_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["1054ui_story"].transform.localEulerAngles = arg_322_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_322_1.time_ >= 0 + var_325_1 and arg_322_1.time_ < 0 + var_325_1 + arg_325_0 then
				arg_322_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_322_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_322_1.actors_["1054ui_story"].transform.position).z)
				arg_322_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_322_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_322_1.actors_["1054ui_story"].transform.localEulerAngles = arg_322_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_325_2 = GameObjectTools.GetOrAddComponent(arg_322_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_325_2 then
					var_325_2:EnableDynamicBone(true)
				end
			end

			local var_325_3 = arg_322_1.actors_["1054ui_story"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_3) and arg_322_1.var_.characterEffect1054ui_story == nil then
				arg_322_1.var_.characterEffect1054ui_story = var_325_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_4 = 0.200000002980232

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 and not isNil(var_325_3) then
				if arg_322_1.var_.characterEffect1054ui_story and not isNil(var_325_3) then
					arg_322_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_322_1.time_ - 0) / var_325_4)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 and not isNil(var_325_3) and arg_322_1.var_.characterEffect1054ui_story then
				arg_322_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_325_5 = 0
			local var_325_6 = 0.575

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_7 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(426091073).content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 23 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_7) / 23)

				if (23 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_7) / 23)) > 0 and var_325_6 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_5
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_6, arg_322_1.talkMaxDuration)

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_5) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_5 + var_325_10 and arg_322_1.time_ < var_325_5 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play426091074 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 426091074
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play426091075(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 1

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(426091074).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 40 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 40)

				if (40 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 40)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play426091075 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 426091075
		arg_330_1.duration_ = 9.97

		local var_330_0 = {
			zh = 8.033,
			ja = 9.966
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play426091076(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1054ui_story = arg_330_1.actors_["1054ui_story"].transform.localPosition

				local var_333_0 = GameObjectTools.GetOrAddComponent(arg_330_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_333_0 then
					var_333_0:EnableDynamicBone(false)
				end
			end

			local var_333_1 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_1 then
				arg_330_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_330_1.time_ - 0) / var_333_1)
				arg_330_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1054ui_story"].transform.position).z)
				arg_330_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1054ui_story"].transform.localEulerAngles = arg_330_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_1 and arg_330_1.time_ < 0 + var_333_1 + arg_333_0 then
				arg_330_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_330_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1054ui_story"].transform.position).z)
				arg_330_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1054ui_story"].transform.localEulerAngles = arg_330_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_333_2 = GameObjectTools.GetOrAddComponent(arg_330_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_333_2 then
					var_333_2:EnableDynamicBone(true)
				end
			end

			local var_333_3 = arg_330_1.actors_["1054ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_3) and arg_330_1.var_.characterEffect1054ui_story == nil then
				arg_330_1.var_.characterEffect1054ui_story = var_333_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_4 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 and not isNil(var_333_3) then
				if arg_330_1.var_.characterEffect1054ui_story and not isNil(var_333_3) then
					arg_330_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 and not isNil(var_333_3) and arg_330_1.var_.characterEffect1054ui_story then
				arg_330_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_333_6 = 0
			local var_333_7 = 0.65

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_8 = arg_330_1:GetWordFromCfg(426091075)
				local var_333_9 = arg_330_1:FormatText(var_333_8.content)

				arg_330_1.text_.text = var_333_9

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_11 = 26 <= 0 and var_333_7 or var_333_7 * (utf8.len(var_333_9) / 26)

				if (26 <= 0 and var_333_7 or var_333_7 * (utf8.len(var_333_9) / 26)) > 0 and var_333_7 < var_333_11 then
					arg_330_1.talkMaxDuration = var_333_11

					if var_333_11 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_11 + var_333_6
					end
				end

				arg_330_1.text_.text = var_333_9
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091075", "story_v_out_426091.awb") ~= 0 then
					local var_333_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091075", "story_v_out_426091.awb") / 1000

					if var_333_12 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_12 + var_333_6
					end

					if var_333_8.prefab_name ~= "" and arg_330_1.actors_[var_333_8.prefab_name] ~= nil then
						local var_333_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_8.prefab_name].transform, "story_v_out_426091", "426091075", "story_v_out_426091.awb")

						arg_330_1:RecordAudio("426091075", var_333_13)
						arg_330_1:RecordAudio("426091075", var_333_13)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_426091", "426091075", "story_v_out_426091.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_426091", "426091075", "story_v_out_426091.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_14 = math.max(var_333_7, arg_330_1.talkMaxDuration)

			if var_333_6 <= arg_330_1.time_ and arg_330_1.time_ < var_333_6 + var_333_14 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_6) / var_333_14

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_6 + var_333_14 and arg_330_1.time_ < var_333_6 + var_333_14 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play426091076 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 426091076
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play426091077(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1054ui_story"]) and arg_334_1.var_.characterEffect1054ui_story == nil then
				arg_334_1.var_.characterEffect1054ui_story = arg_334_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1054ui_story"]) then
				if arg_334_1.var_.characterEffect1054ui_story and not isNil(arg_334_1.actors_["1054ui_story"]) then
					arg_334_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_0)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1054ui_story"]) and arg_334_1.var_.characterEffect1054ui_story then
				arg_334_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_337_1 = 0
			local var_337_2 = 0.625

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_334_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_337_3 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(426091076).content)

				arg_334_1.text_.text = var_337_3

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_5 = 25 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 25)

				if (25 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_3) / 25)) > 0 and var_337_2 < var_337_5 then
					arg_334_1.talkMaxDuration = var_337_5

					if var_337_5 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_3
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_6 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_6 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_6

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_6 and arg_334_1.time_ < var_337_1 + var_337_6 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play426091077 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 426091077
		arg_338_1.duration_ = 6.1

		local var_338_0 = {
			zh = 5.8,
			ja = 6.1
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play426091078(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1054ui_story = arg_338_1.actors_["1054ui_story"].transform.localPosition

				local var_341_0 = GameObjectTools.GetOrAddComponent(arg_338_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_341_0 then
					var_341_0:EnableDynamicBone(false)
				end
			end

			local var_341_1 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_1 then
				arg_338_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_338_1.time_ - 0) / var_341_1)
				arg_338_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1054ui_story"].transform.position).z)
				arg_338_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["1054ui_story"].transform.localEulerAngles = arg_338_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_1 and arg_338_1.time_ < 0 + var_341_1 + arg_341_0 then
				arg_338_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_338_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1054ui_story"].transform.position).z)
				arg_338_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["1054ui_story"].transform.localEulerAngles = arg_338_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_341_2 = GameObjectTools.GetOrAddComponent(arg_338_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_341_2 then
					var_341_2:EnableDynamicBone(true)
				end
			end

			local var_341_3 = arg_338_1.actors_["1054ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_3) and arg_338_1.var_.characterEffect1054ui_story == nil then
				arg_338_1.var_.characterEffect1054ui_story = var_341_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_4 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 and not isNil(var_341_3) then
				if arg_338_1.var_.characterEffect1054ui_story and not isNil(var_341_3) then
					arg_338_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 and not isNil(var_341_3) and arg_338_1.var_.characterEffect1054ui_story then
				arg_338_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_341_6 = 0
			local var_341_7 = 0.45

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_8 = arg_338_1:GetWordFromCfg(426091077)
				local var_341_9 = arg_338_1:FormatText(var_341_8.content)

				arg_338_1.text_.text = var_341_9

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_11 = 18 <= 0 and var_341_7 or var_341_7 * (utf8.len(var_341_9) / 18)

				if (18 <= 0 and var_341_7 or var_341_7 * (utf8.len(var_341_9) / 18)) > 0 and var_341_7 < var_341_11 then
					arg_338_1.talkMaxDuration = var_341_11

					if var_341_11 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_6
					end
				end

				arg_338_1.text_.text = var_341_9
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091077", "story_v_out_426091.awb") ~= 0 then
					local var_341_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091077", "story_v_out_426091.awb") / 1000

					if var_341_12 + var_341_6 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_12 + var_341_6
					end

					if var_341_8.prefab_name ~= "" and arg_338_1.actors_[var_341_8.prefab_name] ~= nil then
						local var_341_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_8.prefab_name].transform, "story_v_out_426091", "426091077", "story_v_out_426091.awb")

						arg_338_1:RecordAudio("426091077", var_341_13)
						arg_338_1:RecordAudio("426091077", var_341_13)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_426091", "426091077", "story_v_out_426091.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_426091", "426091077", "story_v_out_426091.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_7, arg_338_1.talkMaxDuration)

			if var_341_6 <= arg_338_1.time_ and arg_338_1.time_ < var_341_6 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_6) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_6 + var_341_14 and arg_338_1.time_ < var_341_6 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play426091078 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 426091078
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play426091079(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1054ui_story"]) and arg_342_1.var_.characterEffect1054ui_story == nil then
				arg_342_1.var_.characterEffect1054ui_story = arg_342_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1054ui_story"]) then
				if arg_342_1.var_.characterEffect1054ui_story and not isNil(arg_342_1.actors_["1054ui_story"]) then
					arg_342_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_0)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1054ui_story"]) and arg_342_1.var_.characterEffect1054ui_story then
				arg_342_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_345_1 = 0
			local var_345_2 = 0.675

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_342_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_345_3 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(426091078).content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 27 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_3) / 27)

				if (27 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_3) / 27)) > 0 and var_345_2 < var_345_5 then
					arg_342_1.talkMaxDuration = var_345_5

					if var_345_5 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + var_345_1
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_6 = math.max(var_345_2, arg_342_1.talkMaxDuration)

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_6 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_1) / var_345_6

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_1 + var_345_6 and arg_342_1.time_ < var_345_1 + var_345_6 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play426091079 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 426091079
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play426091080(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0.825

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_346_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_349_1 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(426091079).content)

				arg_346_1.text_.text = var_349_1

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_3 = 33 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 33)

				if (33 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 33)) > 0 and var_349_0 < var_349_3 then
					arg_346_1.talkMaxDuration = var_349_3

					if var_349_3 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_3 + 0
					end
				end

				arg_346_1.text_.text = var_349_1
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_4 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_4

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play426091080 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 426091080
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play426091081(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.425

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_350_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(426091080).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 17 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 17)

				if (17 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 17)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play426091081 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 426091081
		arg_354_1.duration_ = 7.27

		local var_354_0 = {
			zh = 5.3,
			ja = 7.266
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play426091082(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1054ui_story = arg_354_1.actors_["1054ui_story"].transform.localPosition

				local var_357_0 = GameObjectTools.GetOrAddComponent(arg_354_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_357_0 then
					var_357_0:EnableDynamicBone(false)
				end
			end

			local var_357_1 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_1 then
				arg_354_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_354_1.time_ - 0) / var_357_1)
				arg_354_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1054ui_story"].transform.position).z)
				arg_354_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1054ui_story"].transform.localEulerAngles = arg_354_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_1 and arg_354_1.time_ < 0 + var_357_1 + arg_357_0 then
				arg_354_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_354_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1054ui_story"].transform.position).z)
				arg_354_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1054ui_story"].transform.localEulerAngles = arg_354_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_357_2 = GameObjectTools.GetOrAddComponent(arg_354_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_357_2 then
					var_357_2:EnableDynamicBone(true)
				end
			end

			local var_357_3 = arg_354_1.actors_["1054ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_3) and arg_354_1.var_.characterEffect1054ui_story == nil then
				arg_354_1.var_.characterEffect1054ui_story = var_357_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_4 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 and not isNil(var_357_3) then
				if arg_354_1.var_.characterEffect1054ui_story and not isNil(var_357_3) then
					arg_354_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 and not isNil(var_357_3) and arg_354_1.var_.characterEffect1054ui_story then
				arg_354_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_357_6 = 0
			local var_357_7 = 0.25

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_8 = arg_354_1:GetWordFromCfg(426091081)
				local var_357_9 = arg_354_1:FormatText(var_357_8.content)

				arg_354_1.text_.text = var_357_9

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_11 = 10 <= 0 and var_357_7 or var_357_7 * (utf8.len(var_357_9) / 10)

				if (10 <= 0 and var_357_7 or var_357_7 * (utf8.len(var_357_9) / 10)) > 0 and var_357_7 < var_357_11 then
					arg_354_1.talkMaxDuration = var_357_11

					if var_357_11 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_11 + var_357_6
					end
				end

				arg_354_1.text_.text = var_357_9
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091081", "story_v_out_426091.awb") ~= 0 then
					local var_357_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091081", "story_v_out_426091.awb") / 1000

					if var_357_12 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_12 + var_357_6
					end

					if var_357_8.prefab_name ~= "" and arg_354_1.actors_[var_357_8.prefab_name] ~= nil then
						local var_357_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_8.prefab_name].transform, "story_v_out_426091", "426091081", "story_v_out_426091.awb")

						arg_354_1:RecordAudio("426091081", var_357_13)
						arg_354_1:RecordAudio("426091081", var_357_13)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_426091", "426091081", "story_v_out_426091.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_426091", "426091081", "story_v_out_426091.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_14 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_14 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_14

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_14 and arg_354_1.time_ < var_357_6 + var_357_14 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play426091082 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 426091082
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play426091083(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1054ui_story = arg_358_1.actors_["1054ui_story"].transform.localPosition

				local var_361_0 = GameObjectTools.GetOrAddComponent(arg_358_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_361_0 then
					var_361_0:EnableDynamicBone(false)
				end
			end

			local var_361_1 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_1 then
				arg_358_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_358_1.time_ - 0) / var_361_1)
				arg_358_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1054ui_story"].transform.position).z)
				arg_358_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1054ui_story"].transform.localEulerAngles = arg_358_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_358_1.time_ >= 0 + var_361_1 and arg_358_1.time_ < 0 + var_361_1 + arg_361_0 then
				arg_358_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_358_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_358_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_358_1.actors_["1054ui_story"].transform.position).z)
				arg_358_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_358_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_358_1.actors_["1054ui_story"].transform.localEulerAngles = arg_358_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_361_2 = GameObjectTools.GetOrAddComponent(arg_358_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_361_2 then
					var_361_2:EnableDynamicBone(true)
				end
			end

			local var_361_3 = arg_358_1.actors_["1054ui_story"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_3) and arg_358_1.var_.characterEffect1054ui_story == nil then
				arg_358_1.var_.characterEffect1054ui_story = var_361_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_4 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 and not isNil(var_361_3) then
				if arg_358_1.var_.characterEffect1054ui_story and not isNil(var_361_3) then
					arg_358_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_4)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 and not isNil(var_361_3) and arg_358_1.var_.characterEffect1054ui_story then
				arg_358_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_361_5 = 0
			local var_361_6 = 1.05

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_5 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_7 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(426091082).content)

				arg_358_1.text_.text = var_361_7

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_9 = 42 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_7) / 42)

				if (42 <= 0 and var_361_6 or var_361_6 * (utf8.len(var_361_7) / 42)) > 0 and var_361_6 < var_361_9 then
					arg_358_1.talkMaxDuration = var_361_9

					if var_361_9 + var_361_5 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_9 + var_361_5
					end
				end

				arg_358_1.text_.text = var_361_7
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_10 = math.max(var_361_6, arg_358_1.talkMaxDuration)

			if var_361_5 <= arg_358_1.time_ and arg_358_1.time_ < var_361_5 + var_361_10 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_5) / var_361_10

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_5 + var_361_10 and arg_358_1.time_ < var_361_5 + var_361_10 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play426091083 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 426091083
		arg_362_1.duration_ = 8.4

		local var_362_0 = {
			zh = 8.4,
			ja = 6.633
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play426091084(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 2 < arg_362_1.time_ and arg_362_1.time_ <= 2 + arg_365_0 then
				local var_365_0 = arg_362_1.bgs_.J27h

				arg_362_1.bgs_.J27h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_365_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_1 = var_365_0:GetComponent("SpriteRenderer")

				if var_365_1 and var_365_1.sprite then
					local var_365_2 = 2 * (var_365_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_365_0.transform.localScale = Vector3.New(var_365_2 / var_365_1.sprite.bounds.size.y < var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x and var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x or var_365_2 / var_365_1.sprite.bounds.size.y, var_365_2 / var_365_1.sprite.bounds.size.y < var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x and var_365_2 * manager.ui.mainCameraCom_.aspect / var_365_1.sprite.bounds.size.x or var_365_2 / var_365_1.sprite.bounds.size.y, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "J27h" then
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

			local var_365_12 = arg_362_1.actors_["1054ui_story"].transform

			if 3.8 < arg_362_1.time_ and arg_362_1.time_ <= 3.8 + arg_365_0 then
				arg_362_1.var_.moveOldPos1054ui_story = var_365_12.localPosition

				local var_365_13 = GameObjectTools.GetOrAddComponent(var_365_12.gameObject, typeof(DynamicBoneHelper))

				if var_365_13 then
					var_365_13:EnableDynamicBone(false)
				end
			end

			local var_365_14 = 0.001

			if 3.8 <= arg_362_1.time_ and arg_362_1.time_ < 3.8 + var_365_14 then
				var_365_12.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_362_1.time_ - 3.8) / var_365_14)
				var_365_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_12.position).x, (manager.ui.mainCamera.transform.position - var_365_12.position).y, (manager.ui.mainCamera.transform.position - var_365_12.position).z)
				var_365_12.localEulerAngles.z = 0
				var_365_12.localEulerAngles.x = 0
				var_365_12.localEulerAngles = var_365_12.localEulerAngles
			end

			if arg_362_1.time_ >= 3.8 + var_365_14 and arg_362_1.time_ < 3.8 + var_365_14 + arg_365_0 then
				var_365_12.localPosition = Vector3.New(0, -0.985, -6)
				var_365_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_365_12.position).x, (manager.ui.mainCamera.transform.position - var_365_12.position).y, (manager.ui.mainCamera.transform.position - var_365_12.position).z)
				var_365_12.localEulerAngles.z = 0
				var_365_12.localEulerAngles.x = 0
				var_365_12.localEulerAngles = var_365_12.localEulerAngles

				local var_365_15 = GameObjectTools.GetOrAddComponent(var_365_12.gameObject, typeof(DynamicBoneHelper))

				if var_365_15 then
					var_365_15:EnableDynamicBone(true)
				end
			end

			local var_365_16 = arg_362_1.actors_["1054ui_story"]

			if 3.8 < arg_362_1.time_ and arg_362_1.time_ <= 3.8 + arg_365_0 and not isNil(var_365_16) and arg_362_1.var_.characterEffect1054ui_story == nil then
				arg_362_1.var_.characterEffect1054ui_story = var_365_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_17 = 0.200000002980232

			if 3.8 <= arg_362_1.time_ and arg_362_1.time_ < 3.8 + var_365_17 and not isNil(var_365_16) then
				if arg_362_1.var_.characterEffect1054ui_story and not isNil(var_365_16) then
					arg_362_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 3.8 + var_365_17 and arg_362_1.time_ < 3.8 + var_365_17 + arg_365_0 and not isNil(var_365_16) and arg_362_1.var_.characterEffect1054ui_story then
				arg_362_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 3.8 < arg_362_1.time_ and arg_362_1.time_ <= 3.8 + arg_365_0 then
				arg_362_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action9_2")
			end

			if 3.8 < arg_362_1.time_ and arg_362_1.time_ <= 3.8 + arg_365_0 then
				arg_362_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if arg_362_1.frameCnt_ <= 1 then
				arg_362_1.dialog_:SetActive(false)
			end

			local var_365_19 = 4
			local var_365_20 = 0.225

			if 4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_19 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				arg_362_1.dialog_:SetActive(true)

				arg_362_1.dialogCg_.alpha = 0

				local var_365_21 = LeanTween.value(arg_362_1.dialog_, 0, 1, 0.3)

				var_365_21:setOnUpdate(LuaHelper.FloatAction(function(arg_366_0)
					arg_362_1.dialogCg_.alpha = arg_366_0
				end))
				var_365_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_362_1.dialog_)
					var_365_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_362_1.duration_ = arg_362_1.duration_ + 0.3

				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_22 = arg_362_1:GetWordFromCfg(426091083)
				local var_365_23 = arg_362_1:FormatText(var_365_22.content)

				arg_362_1.text_.text = var_365_23

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_25 = 9 <= 0 and var_365_20 or var_365_20 * (utf8.len(var_365_23) / 9)

				if (9 <= 0 and var_365_20 or var_365_20 * (utf8.len(var_365_23) / 9)) > 0 and var_365_20 < var_365_25 then
					arg_362_1.talkMaxDuration = var_365_25
					var_365_19 = var_365_19 + 0.3

					if var_365_25 + var_365_19 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_25 + var_365_19
					end
				end

				arg_362_1.text_.text = var_365_23
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091083", "story_v_out_426091.awb") ~= 0 then
					local var_365_26 = manager.audio:GetVoiceLength("story_v_out_426091", "426091083", "story_v_out_426091.awb") / 1000

					if var_365_26 + var_365_19 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_26 + var_365_19
					end

					if var_365_22.prefab_name ~= "" and arg_362_1.actors_[var_365_22.prefab_name] ~= nil then
						local var_365_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_22.prefab_name].transform, "story_v_out_426091", "426091083", "story_v_out_426091.awb")

						arg_362_1:RecordAudio("426091083", var_365_27)
						arg_362_1:RecordAudio("426091083", var_365_27)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_426091", "426091083", "story_v_out_426091.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_426091", "426091083", "story_v_out_426091.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_28 = var_365_19 + 0.3
			local var_365_29 = math.max(var_365_20, arg_362_1.talkMaxDuration)

			if var_365_19 + 0.3 <= arg_362_1.time_ and arg_362_1.time_ < var_365_28 + var_365_29 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_28) / var_365_29

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_28 + var_365_29 and arg_362_1.time_ < var_365_28 + var_365_29 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play426091084 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 426091084
		arg_368_1.duration_ = 6.47

		local var_368_0 = {
			zh = 6.466,
			ja = 5.966
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
				arg_368_0:Play426091085(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.3

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_1 = arg_368_1:GetWordFromCfg(426091084)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 12 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 12)

				if (12 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 12)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091084", "story_v_out_426091.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091084", "story_v_out_426091.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_426091", "426091084", "story_v_out_426091.awb")

						arg_368_1:RecordAudio("426091084", var_371_6)
						arg_368_1:RecordAudio("426091084", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_426091", "426091084", "story_v_out_426091.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_426091", "426091084", "story_v_out_426091.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play426091085 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 426091085
		arg_372_1.duration_ = 4.5

		local var_372_0 = {
			zh = 4.5,
			ja = 1.5
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play426091086(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.05

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:GetWordFromCfg(426091085)
				local var_375_2 = arg_372_1:FormatText(var_375_1.content)

				arg_372_1.text_.text = var_375_2

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 2 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 2)

				if (2 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 2)) > 0 and var_375_0 < var_375_4 then
					arg_372_1.talkMaxDuration = var_375_4

					if var_375_4 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_4 + 0
					end
				end

				arg_372_1.text_.text = var_375_2
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091085", "story_v_out_426091.awb") ~= 0 then
					local var_375_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091085", "story_v_out_426091.awb") / 1000

					if var_375_5 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + 0
					end

					if var_375_1.prefab_name ~= "" and arg_372_1.actors_[var_375_1.prefab_name] ~= nil then
						local var_375_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_1.prefab_name].transform, "story_v_out_426091", "426091085", "story_v_out_426091.awb")

						arg_372_1:RecordAudio("426091085", var_375_6)
						arg_372_1:RecordAudio("426091085", var_375_6)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_426091", "426091085", "story_v_out_426091.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_426091", "426091085", "story_v_out_426091.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_7 and arg_372_1.time_ < 0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play426091086 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 426091086
		arg_376_1.duration_ = 4.1

		local var_376_0 = {
			zh = 4.1,
			ja = 1.4
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
				arg_376_0:Play426091087(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.15

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:GetWordFromCfg(426091086)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 6 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 6)

				if (6 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 6)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091086", "story_v_out_426091.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091086", "story_v_out_426091.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_out_426091", "426091086", "story_v_out_426091.awb")

						arg_376_1:RecordAudio("426091086", var_379_6)
						arg_376_1:RecordAudio("426091086", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_426091", "426091086", "story_v_out_426091.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_426091", "426091086", "story_v_out_426091.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play426091087 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 426091087
		arg_380_1.duration_ = 9

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play426091088(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 2 < arg_380_1.time_ and arg_380_1.time_ <= 2 + arg_383_0 then
				local var_383_0 = arg_380_1.bgs_.SS2602

				arg_380_1.bgs_.SS2602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_383_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_383_1 = var_383_0:GetComponent("SpriteRenderer")

				if var_383_1 and var_383_1.sprite then
					local var_383_2 = 2 * (var_383_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_383_0.transform.localScale = Vector3.New(var_383_2 / var_383_1.sprite.bounds.size.y < var_383_2 * manager.ui.mainCameraCom_.aspect / var_383_1.sprite.bounds.size.x and var_383_2 * manager.ui.mainCameraCom_.aspect / var_383_1.sprite.bounds.size.x or var_383_2 / var_383_1.sprite.bounds.size.y, var_383_2 / var_383_1.sprite.bounds.size.y < var_383_2 * manager.ui.mainCameraCom_.aspect / var_383_1.sprite.bounds.size.x and var_383_2 * manager.ui.mainCameraCom_.aspect / var_383_1.sprite.bounds.size.x or var_383_2 / var_383_1.sprite.bounds.size.y, 0)
				end

				for iter_383_0, iter_383_1 in pairs(arg_380_1.bgs_) do
					if iter_383_0 ~= "SS2602" then
						iter_383_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_383_3 = 4

			if 4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_3 + arg_383_0 then
				arg_380_1.allBtn_.enabled = false
			end

			if arg_380_1.time_ >= var_383_3 + 0.3 and arg_380_1.time_ < var_383_3 + 0.3 + arg_383_0 then
				arg_380_1.allBtn_.enabled = true
			end

			local var_383_4 = 0

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_5 = 2

			if var_383_4 <= arg_380_1.time_ and arg_380_1.time_ < var_383_4 + var_383_5 then
				local var_383_6 = Color.New(0, 0, 0)

				var_383_6.a = Mathf.Lerp(0, 1, (arg_380_1.time_ - var_383_4) / var_383_5)
				arg_380_1.mask_.color = var_383_6
			end

			if arg_380_1.time_ >= var_383_4 + var_383_5 and arg_380_1.time_ < var_383_4 + var_383_5 + arg_383_0 then
				local var_383_7 = Color.New(0, 0, 0)

				var_383_7.a = 1
				arg_380_1.mask_.color = var_383_7
			end

			local var_383_8 = 2

			if 2 < arg_380_1.time_ and arg_380_1.time_ <= var_383_8 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_9 = 2

			if var_383_8 <= arg_380_1.time_ and arg_380_1.time_ < var_383_8 + var_383_9 then
				local var_383_10 = Color.New(0, 0, 0)

				var_383_10.a = Mathf.Lerp(1, 0, (arg_380_1.time_ - var_383_8) / var_383_9)
				arg_380_1.mask_.color = var_383_10
			end

			if arg_380_1.time_ >= var_383_8 + var_383_9 and arg_380_1.time_ < var_383_8 + var_383_9 + arg_383_0 then
				local var_383_11 = Color.New(0, 0, 0)

				arg_380_1.mask_.enabled = false
				var_383_11.a = 0
				arg_380_1.mask_.color = var_383_11
			end

			local var_383_12 = arg_380_1.actors_["1054ui_story"].transform

			if 1.96599999815226 < arg_380_1.time_ and arg_380_1.time_ <= 1.96599999815226 + arg_383_0 then
				arg_380_1.var_.moveOldPos1054ui_story = var_383_12.localPosition

				local var_383_13 = GameObjectTools.GetOrAddComponent(var_383_12.gameObject, typeof(DynamicBoneHelper))

				if var_383_13 then
					var_383_13:EnableDynamicBone(false)
				end
			end

			local var_383_14 = 0.001

			if 1.96599999815226 <= arg_380_1.time_ and arg_380_1.time_ < 1.96599999815226 + var_383_14 then
				var_383_12.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_380_1.time_ - 1.96599999815226) / var_383_14)
				var_383_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_12.position).x, (manager.ui.mainCamera.transform.position - var_383_12.position).y, (manager.ui.mainCamera.transform.position - var_383_12.position).z)
				var_383_12.localEulerAngles.z = 0
				var_383_12.localEulerAngles.x = 0
				var_383_12.localEulerAngles = var_383_12.localEulerAngles
			end

			if arg_380_1.time_ >= 1.96599999815226 + var_383_14 and arg_380_1.time_ < 1.96599999815226 + var_383_14 + arg_383_0 then
				var_383_12.localPosition = Vector3.New(0, 100, 0)
				var_383_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_383_12.position).x, (manager.ui.mainCamera.transform.position - var_383_12.position).y, (manager.ui.mainCamera.transform.position - var_383_12.position).z)
				var_383_12.localEulerAngles.z = 0
				var_383_12.localEulerAngles.x = 0
				var_383_12.localEulerAngles = var_383_12.localEulerAngles

				local var_383_15 = GameObjectTools.GetOrAddComponent(var_383_12.gameObject, typeof(DynamicBoneHelper))

				if var_383_15 then
					var_383_15:EnableDynamicBone(true)
				end
			end

			local var_383_16 = arg_380_1.actors_["1054ui_story"]

			if 1.96599999815226 < arg_380_1.time_ and arg_380_1.time_ <= 1.96599999815226 + arg_383_0 and not isNil(var_383_16) and arg_380_1.var_.characterEffect1054ui_story == nil then
				arg_380_1.var_.characterEffect1054ui_story = var_383_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_17 = 0.034000001847744

			if 1.96599999815226 <= arg_380_1.time_ and arg_380_1.time_ < 1.96599999815226 + var_383_17 and not isNil(var_383_16) then
				if arg_380_1.var_.characterEffect1054ui_story and not isNil(var_383_16) then
					arg_380_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_380_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 1.96599999815226) / var_383_17)
				end
			end

			if arg_380_1.time_ >= 1.96599999815226 + var_383_17 and arg_380_1.time_ < 1.96599999815226 + var_383_17 + arg_383_0 and not isNil(var_383_16) and arg_380_1.var_.characterEffect1054ui_story then
				arg_380_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_380_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_383_18 = 1.96599999815226

			arg_380_1.isInRecall_ = false

			if var_383_18 < arg_380_1.time_ and arg_380_1.time_ <= var_383_18 + arg_383_0 then
				arg_380_1.screenFilterGo_:SetActive(false)

				for iter_383_2, iter_383_3 in pairs(arg_380_1.actors_) do
					for iter_383_4, iter_383_5 in ipairs((iter_383_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_383_5.color = iter_383_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_383_19 = 0.299999999999999

			if var_383_18 <= arg_380_1.time_ and arg_380_1.time_ < var_383_18 + var_383_19 then
				arg_380_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_380_1.time_ - var_383_18) / var_383_19)
			end

			if arg_380_1.time_ >= var_383_18 + var_383_19 and arg_380_1.time_ < var_383_18 + var_383_19 + arg_383_0 then
				arg_380_1.screenFilterEffect_.weight = 0
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_20 = 4
			local var_383_21 = 0.425

			if 4 < arg_380_1.time_ and arg_380_1.time_ <= var_383_20 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_22 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_22:setOnUpdate(LuaHelper.FloatAction(function(arg_384_0)
					arg_380_1.dialogCg_.alpha = arg_384_0
				end))
				var_383_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_23 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(426091087).content)

				arg_380_1.text_.text = var_383_23

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_25 = 17 <= 0 and var_383_21 or var_383_21 * (utf8.len(var_383_23) / 17)

				if (17 <= 0 and var_383_21 or var_383_21 * (utf8.len(var_383_23) / 17)) > 0 and var_383_21 < var_383_25 then
					arg_380_1.talkMaxDuration = var_383_25
					var_383_20 = var_383_20 + 0.3

					if var_383_25 + var_383_20 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_25 + var_383_20
					end
				end

				arg_380_1.text_.text = var_383_23
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_26 = var_383_20 + 0.3
			local var_383_27 = math.max(var_383_21, arg_380_1.talkMaxDuration)

			if var_383_20 + 0.3 <= arg_380_1.time_ and arg_380_1.time_ < var_383_26 + var_383_27 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_26) / var_383_27

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_26 + var_383_27 and arg_380_1.time_ < var_383_26 + var_383_27 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play426091088 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 426091088
		arg_386_1.duration_ = 6.7

		local var_386_0 = {
			zh = 6.7,
			ja = 4.566
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play426091089(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.525

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_1 = arg_386_1:GetWordFromCfg(426091088)
				local var_389_2 = arg_386_1:FormatText(var_389_1.content)

				arg_386_1.text_.text = var_389_2

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 21 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 21)

				if (21 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 21)) > 0 and var_389_0 < var_389_4 then
					arg_386_1.talkMaxDuration = var_389_4

					if var_389_4 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_4 + 0
					end
				end

				arg_386_1.text_.text = var_389_2
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091088", "story_v_out_426091.awb") ~= 0 then
					local var_389_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091088", "story_v_out_426091.awb") / 1000

					if var_389_5 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + 0
					end

					if var_389_1.prefab_name ~= "" and arg_386_1.actors_[var_389_1.prefab_name] ~= nil then
						local var_389_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_1.prefab_name].transform, "story_v_out_426091", "426091088", "story_v_out_426091.awb")

						arg_386_1:RecordAudio("426091088", var_389_6)
						arg_386_1:RecordAudio("426091088", var_389_6)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_426091", "426091088", "story_v_out_426091.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_426091", "426091088", "story_v_out_426091.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_7 and arg_386_1.time_ < 0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play426091089 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 426091089
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play426091090(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.075

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(426091089).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 3 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 3)

				if (3 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 3)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play426091090 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 426091090
		arg_394_1.duration_ = 5.63

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play426091091(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_9000

			if 0.633333333333333 < arg_394_1.time_ and arg_394_1.time_ <= 0.633333333333333 + arg_397_0 then
				arg_394_1:AudioAction("play", "effect", "se_story_150", "se_story_150_stab", "")
			end

			local var_397_1 = 0

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_2 = 0.633333333333333

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 then
				local var_397_3 = Color.New(1, 1, 1)

				var_397_3.a = Mathf.Lerp(1, 0, (arg_394_1.time_ - var_397_1) / var_397_2)
				arg_394_1.mask_.color = var_397_3
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 then
				local var_397_4 = Color.New(1, 1, 1)

				arg_394_1.mask_.enabled = false
				var_397_4.a = 0
				arg_394_1.mask_.color = var_397_4
			end

			if 0.4 < arg_394_1.time_ and arg_394_1.time_ <= 0.4 + arg_397_0 then
				local var_397_5 = arg_394_1.var_.effectsuduxianwuchang1

				if not arg_394_1.var_.effectsuduxianwuchang1 then
					var_397_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_397_5.name = "suduxianwuchang1"
					arg_394_1.var_.effectsuduxianwuchang1 = var_397_5
				else
					var_397_5.transform:SetParent(var_397_9000)
				end

				var_397_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_397_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_397_7 = arg_394_1.bgs_.SS2602.transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPosSS2602 = var_397_7.localPosition
			end

			local var_397_8 = 1.13333333333333

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_8 then
				var_397_7.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPosSS2602, Vector3.New(0, 1, 9), (arg_394_1.time_ - 0) / var_397_8)
			end

			if arg_394_1.time_ >= 0 + var_397_8 and arg_394_1.time_ < 0 + var_397_8 + arg_397_0 then
				var_397_7.localPosition = Vector3.New(0, 1, 9)
			end

			local var_397_9 = 0

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_9 + arg_397_0 then
				arg_394_1.allBtn_.enabled = false
			end

			if arg_394_1.time_ >= var_397_9 + 2.03333333333333 and arg_394_1.time_ < var_397_9 + 2.03333333333333 + arg_397_0 then
				arg_394_1.allBtn_.enabled = true
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_10 = 0.633333333333333
			local var_397_11 = 0.9

			if 0.633333333333333 < arg_394_1.time_ and arg_394_1.time_ <= var_397_10 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_12 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_12:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_13 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(426091090).content)

				arg_394_1.text_.text = var_397_13

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_15 = 36 <= 0 and var_397_11 or var_397_11 * (utf8.len(var_397_13) / 36)

				if (36 <= 0 and var_397_11 or var_397_11 * (utf8.len(var_397_13) / 36)) > 0 and var_397_11 < var_397_15 then
					arg_394_1.talkMaxDuration = var_397_15
					var_397_10 = var_397_10 + 0.3

					if var_397_15 + var_397_10 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_15 + var_397_10
					end
				end

				arg_394_1.text_.text = var_397_13
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_16 = var_397_10 + 0.3
			local var_397_17 = math.max(var_397_11, arg_394_1.talkMaxDuration)

			if var_397_10 + 0.3 <= arg_394_1.time_ and arg_394_1.time_ < var_397_16 + var_397_17 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_16) / var_397_17

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_16 + var_397_17 and arg_394_1.time_ < var_397_16 + var_397_17 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2602",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.13333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play426091091 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 426091091
		arg_400_1.duration_ = 2.4

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"

			SetActive(arg_400_1.choicesGo_, true)

			for iter_401_0, iter_401_1 in ipairs(arg_400_1.choices_) do
				SetActive(iter_401_1.go, iter_401_0 <= 1)
			end

			arg_400_1.choices_[1].txt.text = arg_400_1:FormatText(StoryChoiceCfg[1609].name)
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play426091092(arg_400_1)
			end

			arg_400_1:RecordChoiceLog(426091091, 1609)
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_9000

			if arg_400_1.bgs_.STblack == nil then
				local var_403_0 = Object.Instantiate(arg_400_1.paintGo_)

				var_403_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_403_0.name = "STblack"
				var_403_0.transform.parent = arg_400_1.stage_.transform
				var_403_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.bgs_.STblack = var_403_0
			end

			if 0.4 < arg_400_1.time_ and arg_400_1.time_ <= 0.4 + arg_403_0 then
				local var_403_1 = arg_400_1.bgs_.STblack

				arg_400_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_403_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_403_2 = var_403_1:GetComponent("SpriteRenderer")

				if var_403_2 and var_403_2.sprite then
					local var_403_3 = 2 * (var_403_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_403_1.transform.localScale = Vector3.New(var_403_3 / var_403_2.sprite.bounds.size.y < var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x and var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x or var_403_3 / var_403_2.sprite.bounds.size.y, var_403_3 / var_403_2.sprite.bounds.size.y < var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x and var_403_3 * manager.ui.mainCameraCom_.aspect / var_403_2.sprite.bounds.size.x or var_403_3 / var_403_2.sprite.bounds.size.y, 0)
				end

				for iter_403_0, iter_403_1 in pairs(arg_400_1.bgs_) do
					if iter_403_0 ~= "STblack" then
						iter_403_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_403_4 = 2

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= var_403_4 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			if arg_400_1.time_ >= var_403_4 + 0.3 and arg_400_1.time_ < var_403_4 + 0.3 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_5 = 0

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_6 = 2

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_6 then
				local var_403_7 = Color.New(0, 0, 0)

				var_403_7.a = Mathf.Lerp(1, 0, (arg_400_1.time_ - var_403_5) / var_403_6)
				arg_400_1.mask_.color = var_403_7
			end

			if arg_400_1.time_ >= var_403_5 + var_403_6 and arg_400_1.time_ < var_403_5 + var_403_6 + arg_403_0 then
				local var_403_8 = Color.New(0, 0, 0)

				arg_400_1.mask_.enabled = false
				var_403_8.a = 0
				arg_400_1.mask_.color = var_403_8
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				local var_403_9 = arg_400_1.var_.effectbushinidecuo1

				if not arg_400_1.var_.effectbushinidecuo1 then
					var_403_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_403_9.name = "bushinidecuo1"
					arg_400_1.var_.effectbushinidecuo1 = var_403_9
				else
					var_403_9.transform:SetParent(var_403_9000)
				end

				var_403_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_403_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= 2 + arg_403_0 then
				if arg_400_1.var_.effectbushinidecuo1 then
					Object.Destroy(arg_400_1.var_.effectbushinidecuo1)

					arg_400_1.var_.effectbushinidecuo1 = nil
				end
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play426091092 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 426091092
		arg_404_1.duration_ = 7

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play426091093(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				local var_407_0 = arg_404_1.bgs_.J27g

				arg_404_1.bgs_.J27g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_407_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_407_1 = var_407_0:GetComponent("SpriteRenderer")

				if var_407_1 and var_407_1.sprite then
					local var_407_2 = 2 * (var_407_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_407_0.transform.localScale = Vector3.New(var_407_2 / var_407_1.sprite.bounds.size.y < var_407_2 * manager.ui.mainCameraCom_.aspect / var_407_1.sprite.bounds.size.x and var_407_2 * manager.ui.mainCameraCom_.aspect / var_407_1.sprite.bounds.size.x or var_407_2 / var_407_1.sprite.bounds.size.y, var_407_2 / var_407_1.sprite.bounds.size.y < var_407_2 * manager.ui.mainCameraCom_.aspect / var_407_1.sprite.bounds.size.x and var_407_2 * manager.ui.mainCameraCom_.aspect / var_407_1.sprite.bounds.size.x or var_407_2 / var_407_1.sprite.bounds.size.y, 0)
				end

				for iter_407_0, iter_407_1 in pairs(arg_404_1.bgs_) do
					if iter_407_0 ~= "J27g" then
						iter_407_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_407_3 = 2

			if 2 < arg_404_1.time_ and arg_404_1.time_ <= var_407_3 + arg_407_0 then
				arg_404_1.allBtn_.enabled = false
			end

			if arg_404_1.time_ >= var_407_3 + 0.3 and arg_404_1.time_ < var_407_3 + 0.3 + arg_407_0 then
				arg_404_1.allBtn_.enabled = true
			end

			local var_407_4 = 0

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.mask_.enabled = true
				arg_404_1.mask_.raycastTarget = true

				arg_404_1:SetGaussion(false)
			end

			local var_407_5 = 2

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_5 then
				local var_407_6 = Color.New(0, 0, 0)

				var_407_6.a = Mathf.Lerp(1, 0, (arg_404_1.time_ - var_407_4) / var_407_5)
				arg_404_1.mask_.color = var_407_6
			end

			if arg_404_1.time_ >= var_407_4 + var_407_5 and arg_404_1.time_ < var_407_4 + var_407_5 + arg_407_0 then
				local var_407_7 = Color.New(0, 0, 0)

				arg_404_1.mask_.enabled = false
				var_407_7.a = 0
				arg_404_1.mask_.color = var_407_7
			end

			if 0.1 < arg_404_1.time_ and arg_404_1.time_ <= 0.1 + arg_407_0 then
				arg_404_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_amb_forest_night_nowater", "")
			end

			if 0.466666666666667 < arg_404_1.time_ and arg_404_1.time_ <= 0.466666666666667 + arg_407_0 then
				arg_404_1:AudioAction("play", "effect", "se_story_150", "se_story_150_flower_field", "")
			end

			if arg_404_1.frameCnt_ <= 1 then
				arg_404_1.dialog_:SetActive(false)
			end

			local var_407_10 = 2
			local var_407_11 = 0.65

			if 2 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0

				arg_404_1.dialog_:SetActive(true)

				arg_404_1.dialogCg_.alpha = 0

				local var_407_12 = LeanTween.value(arg_404_1.dialog_, 0, 1, 0.3)

				var_407_12:setOnUpdate(LuaHelper.FloatAction(function(arg_408_0)
					arg_404_1.dialogCg_.alpha = arg_408_0
				end))
				var_407_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_404_1.dialog_)
					var_407_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_404_1.duration_ = arg_404_1.duration_ + 0.3

				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_13 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(426091092).content)

				arg_404_1.text_.text = var_407_13

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_15 = 26 <= 0 and var_407_11 or var_407_11 * (utf8.len(var_407_13) / 26)

				if (26 <= 0 and var_407_11 or var_407_11 * (utf8.len(var_407_13) / 26)) > 0 and var_407_11 < var_407_15 then
					arg_404_1.talkMaxDuration = var_407_15
					var_407_10 = var_407_10 + 0.3

					if var_407_15 + var_407_10 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_15 + var_407_10
					end
				end

				arg_404_1.text_.text = var_407_13
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_16 = var_407_10 + 0.3
			local var_407_17 = math.max(var_407_11, arg_404_1.talkMaxDuration)

			if var_407_10 + 0.3 <= arg_404_1.time_ and arg_404_1.time_ < var_407_16 + var_407_17 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_16) / var_407_17

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_16 + var_407_17 and arg_404_1.time_ < var_407_16 + var_407_17 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play426091093 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 426091093
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play426091094(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 1.375

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_1 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(426091093).content)

				arg_410_1.text_.text = var_413_1

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_3 = 55 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 55)

				if (55 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 55)) > 0 and var_413_0 < var_413_3 then
					arg_410_1.talkMaxDuration = var_413_3

					if var_413_3 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_3 + 0
					end
				end

				arg_410_1.text_.text = var_413_1
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_4 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_4 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_4

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_4 and arg_410_1.time_ < 0 + var_413_4 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play426091094 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 426091094
		arg_414_1.duration_ = 5

		local var_414_0 = {
			zh = 5,
			ja = 3.5
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play426091095(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos6148ui_story = arg_414_1.actors_["6148ui_story"].transform.localPosition

				local var_417_0 = GameObjectTools.GetOrAddComponent(arg_414_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_417_0 then
					var_417_0:EnableDynamicBone(false)
				end
			end

			local var_417_1 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_1 then
				arg_414_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_414_1.time_ - 0) / var_417_1)
				arg_414_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["6148ui_story"].transform.position).z)
				arg_414_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["6148ui_story"].transform.localEulerAngles = arg_414_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_1 and arg_414_1.time_ < 0 + var_417_1 + arg_417_0 then
				arg_414_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_414_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["6148ui_story"].transform.position).z)
				arg_414_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["6148ui_story"].transform.localEulerAngles = arg_414_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_417_2 = GameObjectTools.GetOrAddComponent(arg_414_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_417_2 then
					var_417_2:EnableDynamicBone(true)
				end
			end

			local var_417_3 = arg_414_1.actors_["6148ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_3) and arg_414_1.var_.characterEffect6148ui_story == nil then
				arg_414_1.var_.characterEffect6148ui_story = var_417_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_4 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 and not isNil(var_417_3) then
				if arg_414_1.var_.characterEffect6148ui_story and not isNil(var_417_3) then
					arg_414_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 and not isNil(var_417_3) and arg_414_1.var_.characterEffect6148ui_story then
				arg_414_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_417_6 = 0
			local var_417_7 = 0.175

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_6 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_8 = arg_414_1:GetWordFromCfg(426091094)
				local var_417_9 = arg_414_1:FormatText(var_417_8.content)

				arg_414_1.text_.text = var_417_9

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_11 = 7 <= 0 and var_417_7 or var_417_7 * (utf8.len(var_417_9) / 7)

				if (7 <= 0 and var_417_7 or var_417_7 * (utf8.len(var_417_9) / 7)) > 0 and var_417_7 < var_417_11 then
					arg_414_1.talkMaxDuration = var_417_11

					if var_417_11 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_11 + var_417_6
					end
				end

				arg_414_1.text_.text = var_417_9
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091094", "story_v_out_426091.awb") ~= 0 then
					local var_417_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091094", "story_v_out_426091.awb") / 1000

					if var_417_12 + var_417_6 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_12 + var_417_6
					end

					if var_417_8.prefab_name ~= "" and arg_414_1.actors_[var_417_8.prefab_name] ~= nil then
						local var_417_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_8.prefab_name].transform, "story_v_out_426091", "426091094", "story_v_out_426091.awb")

						arg_414_1:RecordAudio("426091094", var_417_13)
						arg_414_1:RecordAudio("426091094", var_417_13)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_426091", "426091094", "story_v_out_426091.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_426091", "426091094", "story_v_out_426091.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_14 = math.max(var_417_7, arg_414_1.talkMaxDuration)

			if var_417_6 <= arg_414_1.time_ and arg_414_1.time_ < var_417_6 + var_417_14 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_6) / var_417_14

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_6 + var_417_14 and arg_414_1.time_ < var_417_6 + var_417_14 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play426091095 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 426091095
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play426091096(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["6148ui_story"]) and arg_418_1.var_.characterEffect6148ui_story == nil then
				arg_418_1.var_.characterEffect6148ui_story = arg_418_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["6148ui_story"]) then
				if arg_418_1.var_.characterEffect6148ui_story and not isNil(arg_418_1.actors_["6148ui_story"]) then
					arg_418_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_418_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_0)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["6148ui_story"]) and arg_418_1.var_.characterEffect6148ui_story then
				arg_418_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_418_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_421_1 = 0
			local var_421_2 = 0.55

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_3 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(426091095).content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 22 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 22)

				if (22 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 22)) > 0 and var_421_2 < var_421_5 then
					arg_418_1.talkMaxDuration = var_421_5

					if var_421_5 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + var_421_1
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_6 = math.max(var_421_2, arg_418_1.talkMaxDuration)

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_6 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_1) / var_421_6

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_1 + var_421_6 and arg_418_1.time_ < var_421_1 + var_421_6 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play426091096 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 426091096
		arg_422_1.duration_ = 9

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play426091097(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 2 < arg_422_1.time_ and arg_422_1.time_ <= 2 + arg_425_0 then
				local var_425_0 = arg_422_1.bgs_.ST2012

				arg_422_1.bgs_.ST2012.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_425_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_425_1 = var_425_0:GetComponent("SpriteRenderer")

				if var_425_1 and var_425_1.sprite then
					local var_425_2 = 2 * (var_425_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_425_0.transform.localScale = Vector3.New(var_425_2 / var_425_1.sprite.bounds.size.y < var_425_2 * manager.ui.mainCameraCom_.aspect / var_425_1.sprite.bounds.size.x and var_425_2 * manager.ui.mainCameraCom_.aspect / var_425_1.sprite.bounds.size.x or var_425_2 / var_425_1.sprite.bounds.size.y, var_425_2 / var_425_1.sprite.bounds.size.y < var_425_2 * manager.ui.mainCameraCom_.aspect / var_425_1.sprite.bounds.size.x and var_425_2 * manager.ui.mainCameraCom_.aspect / var_425_1.sprite.bounds.size.x or var_425_2 / var_425_1.sprite.bounds.size.y, 0)
				end

				for iter_425_0, iter_425_1 in pairs(arg_422_1.bgs_) do
					if iter_425_0 ~= "ST2012" then
						iter_425_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_425_3 = 4

			if 4 < arg_422_1.time_ and arg_422_1.time_ <= var_425_3 + arg_425_0 then
				arg_422_1.allBtn_.enabled = false
			end

			if arg_422_1.time_ >= var_425_3 + 0.3 and arg_422_1.time_ < var_425_3 + 0.3 + arg_425_0 then
				arg_422_1.allBtn_.enabled = true
			end

			local var_425_4 = 0

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_4 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = true

				arg_422_1:SetGaussion(false)
			end

			local var_425_5 = 2

			if var_425_4 <= arg_422_1.time_ and arg_422_1.time_ < var_425_4 + var_425_5 then
				local var_425_6 = Color.New(0, 0, 0)

				var_425_6.a = Mathf.Lerp(0, 1, (arg_422_1.time_ - var_425_4) / var_425_5)
				arg_422_1.mask_.color = var_425_6
			end

			if arg_422_1.time_ >= var_425_4 + var_425_5 and arg_422_1.time_ < var_425_4 + var_425_5 + arg_425_0 then
				local var_425_7 = Color.New(0, 0, 0)

				var_425_7.a = 1
				arg_422_1.mask_.color = var_425_7
			end

			local var_425_8 = 2

			if 2 < arg_422_1.time_ and arg_422_1.time_ <= var_425_8 + arg_425_0 then
				arg_422_1.mask_.enabled = true
				arg_422_1.mask_.raycastTarget = true

				arg_422_1:SetGaussion(false)
			end

			local var_425_9 = 2

			if var_425_8 <= arg_422_1.time_ and arg_422_1.time_ < var_425_8 + var_425_9 then
				local var_425_10 = Color.New(0, 0, 0)

				var_425_10.a = Mathf.Lerp(1, 0, (arg_422_1.time_ - var_425_8) / var_425_9)
				arg_422_1.mask_.color = var_425_10
			end

			if arg_422_1.time_ >= var_425_8 + var_425_9 and arg_422_1.time_ < var_425_8 + var_425_9 + arg_425_0 then
				local var_425_11 = Color.New(0, 0, 0)

				arg_422_1.mask_.enabled = false
				var_425_11.a = 0
				arg_422_1.mask_.color = var_425_11
			end

			local var_425_12 = arg_422_1.actors_["6148ui_story"].transform

			if 2 < arg_422_1.time_ and arg_422_1.time_ <= 2 + arg_425_0 then
				arg_422_1.var_.moveOldPos6148ui_story = var_425_12.localPosition

				local var_425_13 = GameObjectTools.GetOrAddComponent(var_425_12.gameObject, typeof(DynamicBoneHelper))

				if var_425_13 then
					var_425_13:EnableDynamicBone(false)
				end
			end

			local var_425_14 = 0.001

			if 2 <= arg_422_1.time_ and arg_422_1.time_ < 2 + var_425_14 then
				var_425_12.localPosition = Vector3.Lerp(arg_422_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_422_1.time_ - 2) / var_425_14)
				var_425_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_425_12.position).x, (manager.ui.mainCamera.transform.position - var_425_12.position).y, (manager.ui.mainCamera.transform.position - var_425_12.position).z)
				var_425_12.localEulerAngles.z = 0
				var_425_12.localEulerAngles.x = 0
				var_425_12.localEulerAngles = var_425_12.localEulerAngles
			end

			if arg_422_1.time_ >= 2 + var_425_14 and arg_422_1.time_ < 2 + var_425_14 + arg_425_0 then
				var_425_12.localPosition = Vector3.New(0, 100, 0)
				var_425_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_425_12.position).x, (manager.ui.mainCamera.transform.position - var_425_12.position).y, (manager.ui.mainCamera.transform.position - var_425_12.position).z)
				var_425_12.localEulerAngles.z = 0
				var_425_12.localEulerAngles.x = 0
				var_425_12.localEulerAngles = var_425_12.localEulerAngles

				local var_425_15 = GameObjectTools.GetOrAddComponent(var_425_12.gameObject, typeof(DynamicBoneHelper))

				if var_425_15 then
					var_425_15:EnableDynamicBone(true)
				end
			end

			if 2.13333333333333 < arg_422_1.time_ and arg_422_1.time_ <= 2.13333333333333 + arg_425_0 then
				arg_422_1:AudioAction("stop", "effect", "se_story_150", "se_story_150_flower_field", "")
			end

			if 2.5 < arg_422_1.time_ and arg_422_1.time_ <= 2.5 + arg_425_0 then
				arg_422_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_422_1.frameCnt_ <= 1 then
				arg_422_1.dialog_:SetActive(false)
			end

			local var_425_18 = 4
			local var_425_19 = 0.5

			if 4 < arg_422_1.time_ and arg_422_1.time_ <= var_425_18 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0

				arg_422_1.dialog_:SetActive(true)

				arg_422_1.dialogCg_.alpha = 0

				local var_425_20 = LeanTween.value(arg_422_1.dialog_, 0, 1, 0.3)

				var_425_20:setOnUpdate(LuaHelper.FloatAction(function(arg_426_0)
					arg_422_1.dialogCg_.alpha = arg_426_0
				end))
				var_425_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_422_1.dialog_)
					var_425_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_422_1.duration_ = arg_422_1.duration_ + 0.3

				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_21 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(426091096).content)

				arg_422_1.text_.text = var_425_21

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_23 = 20 <= 0 and var_425_19 or var_425_19 * (utf8.len(var_425_21) / 20)

				if (20 <= 0 and var_425_19 or var_425_19 * (utf8.len(var_425_21) / 20)) > 0 and var_425_19 < var_425_23 then
					arg_422_1.talkMaxDuration = var_425_23
					var_425_18 = var_425_18 + 0.3

					if var_425_23 + var_425_18 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_23 + var_425_18
					end
				end

				arg_422_1.text_.text = var_425_21
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_24 = var_425_18 + 0.3
			local var_425_25 = math.max(var_425_19, arg_422_1.talkMaxDuration)

			if var_425_18 + 0.3 <= arg_422_1.time_ and arg_422_1.time_ < var_425_24 + var_425_25 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_24) / var_425_25

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_24 + var_425_25 and arg_422_1.time_ < var_425_24 + var_425_25 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_422_1:InitPlayNodeList()
	end,
	Play426091097 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 426091097
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play426091098(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.4

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_1 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(426091097).content)

				arg_428_1.text_.text = var_431_1

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_3 = 16 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 16)

				if (16 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 16)) > 0 and var_431_0 < var_431_3 then
					arg_428_1.talkMaxDuration = var_431_3

					if var_431_3 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_3 + 0
					end
				end

				arg_428_1.text_.text = var_431_1
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_4 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_4 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_4

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_4 and arg_428_1.time_ < 0 + var_431_4 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play426091098 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 426091098
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play426091099(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0.925

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_1 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(426091098).content)

				arg_432_1.text_.text = var_435_1

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_3 = 37 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 37)

				if (37 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 37)) > 0 and var_435_0 < var_435_3 then
					arg_432_1.talkMaxDuration = var_435_3

					if var_435_3 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_3 + 0
					end
				end

				arg_432_1.text_.text = var_435_1
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_4 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_4

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play426091099 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 426091099
		arg_436_1.duration_ = 7

		local var_436_0 = {
			zh = 7,
			ja = 6.366
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play426091100(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos6148ui_story = arg_436_1.actors_["6148ui_story"].transform.localPosition

				local var_439_0 = GameObjectTools.GetOrAddComponent(arg_436_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_439_0 then
					var_439_0:EnableDynamicBone(false)
				end
			end

			local var_439_1 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_1 then
				arg_436_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_436_1.time_ - 0) / var_439_1)
				arg_436_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["6148ui_story"].transform.position).z)
				arg_436_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["6148ui_story"].transform.localEulerAngles = arg_436_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_1 and arg_436_1.time_ < 0 + var_439_1 + arg_439_0 then
				arg_436_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_436_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["6148ui_story"].transform.position).z)
				arg_436_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["6148ui_story"].transform.localEulerAngles = arg_436_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_439_2 = GameObjectTools.GetOrAddComponent(arg_436_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_439_2 then
					var_439_2:EnableDynamicBone(true)
				end
			end

			local var_439_3 = arg_436_1.actors_["6148ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_3) and arg_436_1.var_.characterEffect6148ui_story == nil then
				arg_436_1.var_.characterEffect6148ui_story = var_439_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_4 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 and not isNil(var_439_3) then
				if arg_436_1.var_.characterEffect6148ui_story and not isNil(var_439_3) then
					arg_436_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 and not isNil(var_439_3) and arg_436_1.var_.characterEffect6148ui_story then
				arg_436_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_439_6 = 0
			local var_439_7 = 0.625

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_8 = arg_436_1:GetWordFromCfg(426091099)
				local var_439_9 = arg_436_1:FormatText(var_439_8.content)

				arg_436_1.text_.text = var_439_9

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_11 = 25 <= 0 and var_439_7 or var_439_7 * (utf8.len(var_439_9) / 25)

				if (25 <= 0 and var_439_7 or var_439_7 * (utf8.len(var_439_9) / 25)) > 0 and var_439_7 < var_439_11 then
					arg_436_1.talkMaxDuration = var_439_11

					if var_439_11 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_11 + var_439_6
					end
				end

				arg_436_1.text_.text = var_439_9
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091099", "story_v_out_426091.awb") ~= 0 then
					local var_439_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091099", "story_v_out_426091.awb") / 1000

					if var_439_12 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_12 + var_439_6
					end

					if var_439_8.prefab_name ~= "" and arg_436_1.actors_[var_439_8.prefab_name] ~= nil then
						local var_439_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_8.prefab_name].transform, "story_v_out_426091", "426091099", "story_v_out_426091.awb")

						arg_436_1:RecordAudio("426091099", var_439_13)
						arg_436_1:RecordAudio("426091099", var_439_13)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_426091", "426091099", "story_v_out_426091.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_426091", "426091099", "story_v_out_426091.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_14 = math.max(var_439_7, arg_436_1.talkMaxDuration)

			if var_439_6 <= arg_436_1.time_ and arg_436_1.time_ < var_439_6 + var_439_14 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_6) / var_439_14

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_6 + var_439_14 and arg_436_1.time_ < var_439_6 + var_439_14 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091100 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 426091100
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play426091101(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["6148ui_story"]) and arg_440_1.var_.characterEffect6148ui_story == nil then
				arg_440_1.var_.characterEffect6148ui_story = arg_440_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_0 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["6148ui_story"]) then
				if arg_440_1.var_.characterEffect6148ui_story and not isNil(arg_440_1.actors_["6148ui_story"]) then
					arg_440_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_440_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_0)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["6148ui_story"]) and arg_440_1.var_.characterEffect6148ui_story then
				arg_440_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_440_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_443_1 = 0
			local var_443_2 = 0.2

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_3 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(426091100).content)

				arg_440_1.text_.text = var_443_3

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 8 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 8)

				if (8 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 8)) > 0 and var_443_2 < var_443_5 then
					arg_440_1.talkMaxDuration = var_443_5

					if var_443_5 + var_443_1 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + var_443_1
					end
				end

				arg_440_1.text_.text = var_443_3
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_6 = math.max(var_443_2, arg_440_1.talkMaxDuration)

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_6 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_1) / var_443_6

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_1 + var_443_6 and arg_440_1.time_ < var_443_1 + var_443_6 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play426091101 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 426091101
		arg_444_1.duration_ = 5.23

		local var_444_0 = {
			zh = 5.233,
			ja = 3.766
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play426091102(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos6148ui_story = arg_444_1.actors_["6148ui_story"].transform.localPosition

				local var_447_0 = GameObjectTools.GetOrAddComponent(arg_444_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_447_0 then
					var_447_0:EnableDynamicBone(false)
				end
			end

			local var_447_1 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_1 then
				arg_444_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_444_1.time_ - 0) / var_447_1)
				arg_444_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["6148ui_story"].transform.position).z)
				arg_444_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["6148ui_story"].transform.localEulerAngles = arg_444_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_444_1.time_ >= 0 + var_447_1 and arg_444_1.time_ < 0 + var_447_1 + arg_447_0 then
				arg_444_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_444_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_444_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_444_1.actors_["6148ui_story"].transform.position).z)
				arg_444_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_444_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_444_1.actors_["6148ui_story"].transform.localEulerAngles = arg_444_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_447_2 = GameObjectTools.GetOrAddComponent(arg_444_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_447_2 then
					var_447_2:EnableDynamicBone(true)
				end
			end

			local var_447_3 = arg_444_1.actors_["6148ui_story"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_3) and arg_444_1.var_.characterEffect6148ui_story == nil then
				arg_444_1.var_.characterEffect6148ui_story = var_447_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_4 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 and not isNil(var_447_3) then
				if arg_444_1.var_.characterEffect6148ui_story and not isNil(var_447_3) then
					arg_444_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 and not isNil(var_447_3) and arg_444_1.var_.characterEffect6148ui_story then
				arg_444_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_447_6 = 0
			local var_447_7 = 0.4

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_8 = arg_444_1:GetWordFromCfg(426091101)
				local var_447_9 = arg_444_1:FormatText(var_447_8.content)

				arg_444_1.text_.text = var_447_9

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_11 = 16 <= 0 and var_447_7 or var_447_7 * (utf8.len(var_447_9) / 16)

				if (16 <= 0 and var_447_7 or var_447_7 * (utf8.len(var_447_9) / 16)) > 0 and var_447_7 < var_447_11 then
					arg_444_1.talkMaxDuration = var_447_11

					if var_447_11 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_11 + var_447_6
					end
				end

				arg_444_1.text_.text = var_447_9
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091101", "story_v_out_426091.awb") ~= 0 then
					local var_447_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091101", "story_v_out_426091.awb") / 1000

					if var_447_12 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_12 + var_447_6
					end

					if var_447_8.prefab_name ~= "" and arg_444_1.actors_[var_447_8.prefab_name] ~= nil then
						local var_447_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_8.prefab_name].transform, "story_v_out_426091", "426091101", "story_v_out_426091.awb")

						arg_444_1:RecordAudio("426091101", var_447_13)
						arg_444_1:RecordAudio("426091101", var_447_13)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_426091", "426091101", "story_v_out_426091.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_426091", "426091101", "story_v_out_426091.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_14 = math.max(var_447_7, arg_444_1.talkMaxDuration)

			if var_447_6 <= arg_444_1.time_ and arg_444_1.time_ < var_447_6 + var_447_14 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_6) / var_447_14

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_6 + var_447_14 and arg_444_1.time_ < var_447_6 + var_447_14 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play426091102 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 426091102
		arg_448_1.duration_ = 9.77

		local var_448_0 = {
			zh = 8.2,
			ja = 9.766
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
				arg_448_0:Play426091103(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0.875

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_1 = arg_448_1:GetWordFromCfg(426091102)
				local var_451_2 = arg_448_1:FormatText(var_451_1.content)

				arg_448_1.text_.text = var_451_2

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 35 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 35)

				if (35 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 35)) > 0 and var_451_0 < var_451_4 then
					arg_448_1.talkMaxDuration = var_451_4

					if var_451_4 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_4 + 0
					end
				end

				arg_448_1.text_.text = var_451_2
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091102", "story_v_out_426091.awb") ~= 0 then
					local var_451_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091102", "story_v_out_426091.awb") / 1000

					if var_451_5 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + 0
					end

					if var_451_1.prefab_name ~= "" and arg_448_1.actors_[var_451_1.prefab_name] ~= nil then
						local var_451_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_1.prefab_name].transform, "story_v_out_426091", "426091102", "story_v_out_426091.awb")

						arg_448_1:RecordAudio("426091102", var_451_6)
						arg_448_1:RecordAudio("426091102", var_451_6)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_426091", "426091102", "story_v_out_426091.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_426091", "426091102", "story_v_out_426091.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_7 and arg_448_1.time_ < 0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play426091103 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 426091103
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play426091104(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos6148ui_story = arg_452_1.actors_["6148ui_story"].transform.localPosition

				local var_455_0 = GameObjectTools.GetOrAddComponent(arg_452_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_455_0 then
					var_455_0:EnableDynamicBone(false)
				end
			end

			local var_455_1 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_1 then
				arg_452_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_452_1.time_ - 0) / var_455_1)
				arg_452_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["6148ui_story"].transform.position).z)
				arg_452_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["6148ui_story"].transform.localEulerAngles = arg_452_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_1 and arg_452_1.time_ < 0 + var_455_1 + arg_455_0 then
				arg_452_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_452_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["6148ui_story"].transform.position).z)
				arg_452_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["6148ui_story"].transform.localEulerAngles = arg_452_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_455_2 = GameObjectTools.GetOrAddComponent(arg_452_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_455_2 then
					var_455_2:EnableDynamicBone(true)
				end
			end

			local var_455_3 = arg_452_1.actors_["6148ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_3) and arg_452_1.var_.characterEffect6148ui_story == nil then
				arg_452_1.var_.characterEffect6148ui_story = var_455_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_4 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_4 and not isNil(var_455_3) then
				if arg_452_1.var_.characterEffect6148ui_story and not isNil(var_455_3) then
					arg_452_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_452_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_4)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_4 and arg_452_1.time_ < 0 + var_455_4 + arg_455_0 and not isNil(var_455_3) and arg_452_1.var_.characterEffect6148ui_story then
				arg_452_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_452_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_455_5 = 0
			local var_455_6 = 0.9

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_5 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_7 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(426091103).content)

				arg_452_1.text_.text = var_455_7

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_9 = 36 <= 0 and var_455_6 or var_455_6 * (utf8.len(var_455_7) / 36)

				if (36 <= 0 and var_455_6 or var_455_6 * (utf8.len(var_455_7) / 36)) > 0 and var_455_6 < var_455_9 then
					arg_452_1.talkMaxDuration = var_455_9

					if var_455_9 + var_455_5 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_9 + var_455_5
					end
				end

				arg_452_1.text_.text = var_455_7
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_10 = math.max(var_455_6, arg_452_1.talkMaxDuration)

			if var_455_5 <= arg_452_1.time_ and arg_452_1.time_ < var_455_5 + var_455_10 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_5) / var_455_10

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_5 + var_455_10 and arg_452_1.time_ < var_455_5 + var_455_10 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play426091104 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 426091104
		arg_456_1.duration_ = 4.53

		local var_456_0 = {
			zh = 4.533,
			ja = 4.133
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play426091105(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos6148ui_story = arg_456_1.actors_["6148ui_story"].transform.localPosition

				local var_459_0 = GameObjectTools.GetOrAddComponent(arg_456_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_459_0 then
					var_459_0:EnableDynamicBone(false)
				end
			end

			local var_459_1 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_1 then
				arg_456_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_456_1.time_ - 0) / var_459_1)
				arg_456_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["6148ui_story"].transform.position).z)
				arg_456_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["6148ui_story"].transform.localEulerAngles = arg_456_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_456_1.time_ >= 0 + var_459_1 and arg_456_1.time_ < 0 + var_459_1 + arg_459_0 then
				arg_456_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_456_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_456_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_456_1.actors_["6148ui_story"].transform.position).z)
				arg_456_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_456_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_456_1.actors_["6148ui_story"].transform.localEulerAngles = arg_456_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_459_2 = GameObjectTools.GetOrAddComponent(arg_456_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_459_2 then
					var_459_2:EnableDynamicBone(true)
				end
			end

			local var_459_3 = arg_456_1.actors_["6148ui_story"]

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(var_459_3) and arg_456_1.var_.characterEffect6148ui_story == nil then
				arg_456_1.var_.characterEffect6148ui_story = var_459_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_4 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 and not isNil(var_459_3) then
				if arg_456_1.var_.characterEffect6148ui_story and not isNil(var_459_3) then
					arg_456_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 and not isNil(var_459_3) and arg_456_1.var_.characterEffect6148ui_story then
				arg_456_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action446")
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_459_6 = 0
			local var_459_7 = 0.425

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_6 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_8 = arg_456_1:GetWordFromCfg(426091104)
				local var_459_9 = arg_456_1:FormatText(var_459_8.content)

				arg_456_1.text_.text = var_459_9

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_11 = 17 <= 0 and var_459_7 or var_459_7 * (utf8.len(var_459_9) / 17)

				if (17 <= 0 and var_459_7 or var_459_7 * (utf8.len(var_459_9) / 17)) > 0 and var_459_7 < var_459_11 then
					arg_456_1.talkMaxDuration = var_459_11

					if var_459_11 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_11 + var_459_6
					end
				end

				arg_456_1.text_.text = var_459_9
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091104", "story_v_out_426091.awb") ~= 0 then
					local var_459_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091104", "story_v_out_426091.awb") / 1000

					if var_459_12 + var_459_6 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_12 + var_459_6
					end

					if var_459_8.prefab_name ~= "" and arg_456_1.actors_[var_459_8.prefab_name] ~= nil then
						local var_459_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_8.prefab_name].transform, "story_v_out_426091", "426091104", "story_v_out_426091.awb")

						arg_456_1:RecordAudio("426091104", var_459_13)
						arg_456_1:RecordAudio("426091104", var_459_13)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_426091", "426091104", "story_v_out_426091.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_426091", "426091104", "story_v_out_426091.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_14 = math.max(var_459_7, arg_456_1.talkMaxDuration)

			if var_459_6 <= arg_456_1.time_ and arg_456_1.time_ < var_459_6 + var_459_14 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_6) / var_459_14

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_6 + var_459_14 and arg_456_1.time_ < var_459_6 + var_459_14 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play426091105 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 426091105
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play426091106(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(arg_460_1.actors_["6148ui_story"]) and arg_460_1.var_.characterEffect6148ui_story == nil then
				arg_460_1.var_.characterEffect6148ui_story = arg_460_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_0 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 and not isNil(arg_460_1.actors_["6148ui_story"]) then
				if arg_460_1.var_.characterEffect6148ui_story and not isNil(arg_460_1.actors_["6148ui_story"]) then
					arg_460_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_460_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_460_1.time_ - 0) / var_463_0)
				end
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 and not isNil(arg_460_1.actors_["6148ui_story"]) and arg_460_1.var_.characterEffect6148ui_story then
				arg_460_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_460_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_463_1 = 0
			local var_463_2 = 0.45

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_3 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(426091105).content)

				arg_460_1.text_.text = var_463_3

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 18 <= 0 and var_463_2 or var_463_2 * (utf8.len(var_463_3) / 18)

				if (18 <= 0 and var_463_2 or var_463_2 * (utf8.len(var_463_3) / 18)) > 0 and var_463_2 < var_463_5 then
					arg_460_1.talkMaxDuration = var_463_5

					if var_463_5 + var_463_1 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_5 + var_463_1
					end
				end

				arg_460_1.text_.text = var_463_3
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_6 = math.max(var_463_2, arg_460_1.talkMaxDuration)

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_6 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_1) / var_463_6

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_1 + var_463_6 and arg_460_1.time_ < var_463_1 + var_463_6 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play426091106 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 426091106
		arg_464_1.duration_ = 9.83

		local var_464_0 = {
			zh = 9.833,
			ja = 6.666
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play426091107(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["6148ui_story"]) and arg_464_1.var_.characterEffect6148ui_story == nil then
				arg_464_1.var_.characterEffect6148ui_story = arg_464_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["6148ui_story"]) then
				if arg_464_1.var_.characterEffect6148ui_story and not isNil(arg_464_1.actors_["6148ui_story"]) then
					arg_464_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["6148ui_story"]) and arg_464_1.var_.characterEffect6148ui_story then
				arg_464_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action464")
			end

			local var_467_2 = 0
			local var_467_3 = 0.625

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_2 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_4 = arg_464_1:GetWordFromCfg(426091106)
				local var_467_5 = arg_464_1:FormatText(var_467_4.content)

				arg_464_1.text_.text = var_467_5

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_7 = 25 <= 0 and var_467_3 or var_467_3 * (utf8.len(var_467_5) / 25)

				if (25 <= 0 and var_467_3 or var_467_3 * (utf8.len(var_467_5) / 25)) > 0 and var_467_3 < var_467_7 then
					arg_464_1.talkMaxDuration = var_467_7

					if var_467_7 + var_467_2 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_2
					end
				end

				arg_464_1.text_.text = var_467_5
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091106", "story_v_out_426091.awb") ~= 0 then
					local var_467_8 = manager.audio:GetVoiceLength("story_v_out_426091", "426091106", "story_v_out_426091.awb") / 1000

					if var_467_8 + var_467_2 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_8 + var_467_2
					end

					if var_467_4.prefab_name ~= "" and arg_464_1.actors_[var_467_4.prefab_name] ~= nil then
						local var_467_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_4.prefab_name].transform, "story_v_out_426091", "426091106", "story_v_out_426091.awb")

						arg_464_1:RecordAudio("426091106", var_467_9)
						arg_464_1:RecordAudio("426091106", var_467_9)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_426091", "426091106", "story_v_out_426091.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_426091", "426091106", "story_v_out_426091.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_10 = math.max(var_467_3, arg_464_1.talkMaxDuration)

			if var_467_2 <= arg_464_1.time_ and arg_464_1.time_ < var_467_2 + var_467_10 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_2) / var_467_10

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_2 + var_467_10 and arg_464_1.time_ < var_467_2 + var_467_10 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play426091107 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 426091107
		arg_468_1.duration_ = 8.4

		local var_468_0 = {
			zh = 8.133,
			ja = 8.4
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
				arg_468_0:Play426091108(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.75

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:GetWordFromCfg(426091107)
				local var_471_2 = arg_468_1:FormatText(var_471_1.content)

				arg_468_1.text_.text = var_471_2

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 30 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_2) / 30)

				if (30 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_2) / 30)) > 0 and var_471_0 < var_471_4 then
					arg_468_1.talkMaxDuration = var_471_4

					if var_471_4 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_4 + 0
					end
				end

				arg_468_1.text_.text = var_471_2
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091107", "story_v_out_426091.awb") ~= 0 then
					local var_471_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091107", "story_v_out_426091.awb") / 1000

					if var_471_5 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_5 + 0
					end

					if var_471_1.prefab_name ~= "" and arg_468_1.actors_[var_471_1.prefab_name] ~= nil then
						local var_471_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_1.prefab_name].transform, "story_v_out_426091", "426091107", "story_v_out_426091.awb")

						arg_468_1:RecordAudio("426091107", var_471_6)
						arg_468_1:RecordAudio("426091107", var_471_6)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_426091", "426091107", "story_v_out_426091.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_426091", "426091107", "story_v_out_426091.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_7 and arg_468_1.time_ < 0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play426091108 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 426091108
		arg_472_1.duration_ = 5

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play426091109(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos6148ui_story = arg_472_1.actors_["6148ui_story"].transform.localPosition

				local var_475_0 = GameObjectTools.GetOrAddComponent(arg_472_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_475_0 then
					var_475_0:EnableDynamicBone(false)
				end
			end

			local var_475_1 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_1 then
				arg_472_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_472_1.time_ - 0) / var_475_1)
				arg_472_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["6148ui_story"].transform.position).z)
				arg_472_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["6148ui_story"].transform.localEulerAngles = arg_472_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_472_1.time_ >= 0 + var_475_1 and arg_472_1.time_ < 0 + var_475_1 + arg_475_0 then
				arg_472_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_472_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["6148ui_story"].transform.position).z)
				arg_472_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["6148ui_story"].transform.localEulerAngles = arg_472_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_475_2 = GameObjectTools.GetOrAddComponent(arg_472_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_475_2 then
					var_475_2:EnableDynamicBone(true)
				end
			end

			local var_475_3 = arg_472_1.actors_["6148ui_story"]

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(var_475_3) and arg_472_1.var_.characterEffect6148ui_story == nil then
				arg_472_1.var_.characterEffect6148ui_story = var_475_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_4 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_4 and not isNil(var_475_3) then
				if arg_472_1.var_.characterEffect6148ui_story and not isNil(var_475_3) then
					arg_472_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_472_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_472_1.time_ - 0) / var_475_4)
				end
			end

			if arg_472_1.time_ >= 0 + var_475_4 and arg_472_1.time_ < 0 + var_475_4 + arg_475_0 and not isNil(var_475_3) and arg_472_1.var_.characterEffect6148ui_story then
				arg_472_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_472_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_475_5 = 0
			local var_475_6 = 0.675

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_5 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, false)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_7 = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(426091108).content)

				arg_472_1.text_.text = var_475_7

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_9 = 27 <= 0 and var_475_6 or var_475_6 * (utf8.len(var_475_7) / 27)

				if (27 <= 0 and var_475_6 or var_475_6 * (utf8.len(var_475_7) / 27)) > 0 and var_475_6 < var_475_9 then
					arg_472_1.talkMaxDuration = var_475_9

					if var_475_9 + var_475_5 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_9 + var_475_5
					end
				end

				arg_472_1.text_.text = var_475_7
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)
				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_6, arg_472_1.talkMaxDuration)

			if var_475_5 <= arg_472_1.time_ and arg_472_1.time_ < var_475_5 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_5) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_5 + var_475_10 and arg_472_1.time_ < var_475_5 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play426091109 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 426091109
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play426091110(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.7

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_1 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(426091109).content)

				arg_476_1.text_.text = var_479_1

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_3 = 28 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 28)

				if (28 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 28)) > 0 and var_479_0 < var_479_3 then
					arg_476_1.talkMaxDuration = var_479_3

					if var_479_3 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_3 + 0
					end
				end

				arg_476_1.text_.text = var_479_1
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_4 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_4 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_4

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_4 and arg_476_1.time_ < 0 + var_479_4 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play426091110 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 426091110
		arg_480_1.duration_ = 4.97

		local var_480_0 = {
			zh = 4.966,
			ja = 4.366
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
				arg_480_0:Play426091111(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos6148ui_story = arg_480_1.actors_["6148ui_story"].transform.localPosition

				local var_483_0 = GameObjectTools.GetOrAddComponent(arg_480_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_483_0 then
					var_483_0:EnableDynamicBone(false)
				end
			end

			local var_483_1 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_1 then
				arg_480_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_480_1.time_ - 0) / var_483_1)
				arg_480_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["6148ui_story"].transform.position).z)
				arg_480_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["6148ui_story"].transform.localEulerAngles = arg_480_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_1 and arg_480_1.time_ < 0 + var_483_1 + arg_483_0 then
				arg_480_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_480_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["6148ui_story"].transform.position).z)
				arg_480_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["6148ui_story"].transform.localEulerAngles = arg_480_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_483_2 = GameObjectTools.GetOrAddComponent(arg_480_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_483_2 then
					var_483_2:EnableDynamicBone(true)
				end
			end

			local var_483_3 = arg_480_1.actors_["6148ui_story"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_3) and arg_480_1.var_.characterEffect6148ui_story == nil then
				arg_480_1.var_.characterEffect6148ui_story = var_483_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_4 = 0.200000002980232

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_4 and not isNil(var_483_3) then
				if arg_480_1.var_.characterEffect6148ui_story and not isNil(var_483_3) then
					arg_480_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= 0 + var_483_4 and arg_480_1.time_ < 0 + var_483_4 + arg_483_0 and not isNil(var_483_3) and arg_480_1.var_.characterEffect6148ui_story then
				arg_480_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_483_6 = 0
			local var_483_7 = 0.35

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_6 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_8 = arg_480_1:GetWordFromCfg(426091110)
				local var_483_9 = arg_480_1:FormatText(var_483_8.content)

				arg_480_1.text_.text = var_483_9

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_11 = 14 <= 0 and var_483_7 or var_483_7 * (utf8.len(var_483_9) / 14)

				if (14 <= 0 and var_483_7 or var_483_7 * (utf8.len(var_483_9) / 14)) > 0 and var_483_7 < var_483_11 then
					arg_480_1.talkMaxDuration = var_483_11

					if var_483_11 + var_483_6 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_11 + var_483_6
					end
				end

				arg_480_1.text_.text = var_483_9
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091110", "story_v_out_426091.awb") ~= 0 then
					local var_483_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091110", "story_v_out_426091.awb") / 1000

					if var_483_12 + var_483_6 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_12 + var_483_6
					end

					if var_483_8.prefab_name ~= "" and arg_480_1.actors_[var_483_8.prefab_name] ~= nil then
						local var_483_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_8.prefab_name].transform, "story_v_out_426091", "426091110", "story_v_out_426091.awb")

						arg_480_1:RecordAudio("426091110", var_483_13)
						arg_480_1:RecordAudio("426091110", var_483_13)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_426091", "426091110", "story_v_out_426091.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_426091", "426091110", "story_v_out_426091.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_14 = math.max(var_483_7, arg_480_1.talkMaxDuration)

			if var_483_6 <= arg_480_1.time_ and arg_480_1.time_ < var_483_6 + var_483_14 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_6) / var_483_14

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_6 + var_483_14 and arg_480_1.time_ < var_483_6 + var_483_14 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091111 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 426091111
		arg_484_1.duration_ = 9.47

		local var_484_0 = {
			zh = 9.066,
			ja = 9.466
		}
		local var_484_1 = manager.audio:GetLocalizationFlag()

		if var_484_0[var_484_1] ~= nil then
			arg_484_1.duration_ = var_484_0[var_484_1]
		end

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play426091112(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 1.025

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_1 = arg_484_1:GetWordFromCfg(426091111)
				local var_487_2 = arg_484_1:FormatText(var_487_1.content)

				arg_484_1.text_.text = var_487_2

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_4 = 41 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_2) / 41)

				if (41 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_2) / 41)) > 0 and var_487_0 < var_487_4 then
					arg_484_1.talkMaxDuration = var_487_4

					if var_487_4 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_4 + 0
					end
				end

				arg_484_1.text_.text = var_487_2
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091111", "story_v_out_426091.awb") ~= 0 then
					local var_487_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091111", "story_v_out_426091.awb") / 1000

					if var_487_5 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + 0
					end

					if var_487_1.prefab_name ~= "" and arg_484_1.actors_[var_487_1.prefab_name] ~= nil then
						local var_487_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_1.prefab_name].transform, "story_v_out_426091", "426091111", "story_v_out_426091.awb")

						arg_484_1:RecordAudio("426091111", var_487_6)
						arg_484_1:RecordAudio("426091111", var_487_6)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_426091", "426091111", "story_v_out_426091.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_426091", "426091111", "story_v_out_426091.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_7 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_7 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_7

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_7 and arg_484_1.time_ < 0 + var_487_7 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play426091112 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 426091112
		arg_488_1.duration_ = 6.9

		local var_488_0 = {
			zh = 6.9,
			ja = 5.266
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
				arg_488_0:Play426091113(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0.7

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_1 = arg_488_1:GetWordFromCfg(426091112)
				local var_491_2 = arg_488_1:FormatText(var_491_1.content)

				arg_488_1.text_.text = var_491_2

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_4 = 28 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 28)

				if (28 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 28)) > 0 and var_491_0 < var_491_4 then
					arg_488_1.talkMaxDuration = var_491_4

					if var_491_4 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_4 + 0
					end
				end

				arg_488_1.text_.text = var_491_2
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091112", "story_v_out_426091.awb") ~= 0 then
					local var_491_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091112", "story_v_out_426091.awb") / 1000

					if var_491_5 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_5 + 0
					end

					if var_491_1.prefab_name ~= "" and arg_488_1.actors_[var_491_1.prefab_name] ~= nil then
						local var_491_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_1.prefab_name].transform, "story_v_out_426091", "426091112", "story_v_out_426091.awb")

						arg_488_1:RecordAudio("426091112", var_491_6)
						arg_488_1:RecordAudio("426091112", var_491_6)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_426091", "426091112", "story_v_out_426091.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_426091", "426091112", "story_v_out_426091.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_7 = math.max(var_491_0, arg_488_1.talkMaxDuration)

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_7 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - 0) / var_491_7

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= 0 + var_491_7 and arg_488_1.time_ < 0 + var_491_7 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play426091113 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 426091113
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play426091114(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(arg_492_1.actors_["6148ui_story"]) and arg_492_1.var_.characterEffect6148ui_story == nil then
				arg_492_1.var_.characterEffect6148ui_story = arg_492_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_0 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 and not isNil(arg_492_1.actors_["6148ui_story"]) then
				if arg_492_1.var_.characterEffect6148ui_story and not isNil(arg_492_1.actors_["6148ui_story"]) then
					arg_492_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_492_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_492_1.time_ - 0) / var_495_0)
				end
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 and not isNil(arg_492_1.actors_["6148ui_story"]) and arg_492_1.var_.characterEffect6148ui_story then
				arg_492_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_492_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_495_1 = 0
			local var_495_2 = 0.675

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

				arg_492_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_492_1.callingController_:SetSelectedState("normal")

				arg_492_1.keyicon_.color = Color.New(1, 1, 1)
				arg_492_1.icon_.color = Color.New(1, 1, 1)

				local var_495_3 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(426091113).content)

				arg_492_1.text_.text = var_495_3

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_5 = 27 <= 0 and var_495_2 or var_495_2 * (utf8.len(var_495_3) / 27)

				if (27 <= 0 and var_495_2 or var_495_2 * (utf8.len(var_495_3) / 27)) > 0 and var_495_2 < var_495_5 then
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
	Play426091114 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 426091114
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play426091115(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0.825

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_1 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(426091114).content)

				arg_496_1.text_.text = var_499_1

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_3 = 33 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_1) / 33)

				if (33 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_1) / 33)) > 0 and var_499_0 < var_499_3 then
					arg_496_1.talkMaxDuration = var_499_3

					if var_499_3 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_3 + 0
					end
				end

				arg_496_1.text_.text = var_499_1
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_4 = math.max(var_499_0, arg_496_1.talkMaxDuration)

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_4 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - 0) / var_499_4

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= 0 + var_499_4 and arg_496_1.time_ < 0 + var_499_4 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play426091115 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 426091115
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play426091116(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0.6

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_1 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(426091115).content)

				arg_500_1.text_.text = var_503_1

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_3 = 24 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 24)

				if (24 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 24)) > 0 and var_503_0 < var_503_3 then
					arg_500_1.talkMaxDuration = var_503_3

					if var_503_3 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_3 + 0
					end
				end

				arg_500_1.text_.text = var_503_1
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_4 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_4

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play426091116 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 426091116
		arg_504_1.duration_ = 2

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play426091117(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.var_.moveOldPos6148ui_story = arg_504_1.actors_["6148ui_story"].transform.localPosition

				local var_507_0 = GameObjectTools.GetOrAddComponent(arg_504_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_507_0 then
					var_507_0:EnableDynamicBone(false)
				end
			end

			local var_507_1 = 0.001

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_1 then
				arg_504_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_504_1.time_ - 0) / var_507_1)
				arg_504_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_504_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["6148ui_story"].transform.position).z)
				arg_504_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_504_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_504_1.actors_["6148ui_story"].transform.localEulerAngles = arg_504_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_504_1.time_ >= 0 + var_507_1 and arg_504_1.time_ < 0 + var_507_1 + arg_507_0 then
				arg_504_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_504_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_504_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["6148ui_story"].transform.position).z)
				arg_504_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_504_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_504_1.actors_["6148ui_story"].transform.localEulerAngles = arg_504_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_507_2 = GameObjectTools.GetOrAddComponent(arg_504_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_507_2 then
					var_507_2:EnableDynamicBone(true)
				end
			end

			local var_507_3 = arg_504_1.actors_["6148ui_story"]

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(var_507_3) and arg_504_1.var_.characterEffect6148ui_story == nil then
				arg_504_1.var_.characterEffect6148ui_story = var_507_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_4 = 0.200000002980232

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 and not isNil(var_507_3) then
				if arg_504_1.var_.characterEffect6148ui_story and not isNil(var_507_3) then
					arg_504_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 and not isNil(var_507_3) and arg_504_1.var_.characterEffect6148ui_story then
				arg_504_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_507_6 = 0
			local var_507_7 = 0.075

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_6 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_8 = arg_504_1:GetWordFromCfg(426091116)
				local var_507_9 = arg_504_1:FormatText(var_507_8.content)

				arg_504_1.text_.text = var_507_9

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_11 = 3 <= 0 and var_507_7 or var_507_7 * (utf8.len(var_507_9) / 3)

				if (3 <= 0 and var_507_7 or var_507_7 * (utf8.len(var_507_9) / 3)) > 0 and var_507_7 < var_507_11 then
					arg_504_1.talkMaxDuration = var_507_11

					if var_507_11 + var_507_6 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_11 + var_507_6
					end
				end

				arg_504_1.text_.text = var_507_9
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091116", "story_v_out_426091.awb") ~= 0 then
					local var_507_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091116", "story_v_out_426091.awb") / 1000

					if var_507_12 + var_507_6 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_12 + var_507_6
					end

					if var_507_8.prefab_name ~= "" and arg_504_1.actors_[var_507_8.prefab_name] ~= nil then
						local var_507_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_8.prefab_name].transform, "story_v_out_426091", "426091116", "story_v_out_426091.awb")

						arg_504_1:RecordAudio("426091116", var_507_13)
						arg_504_1:RecordAudio("426091116", var_507_13)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_426091", "426091116", "story_v_out_426091.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_426091", "426091116", "story_v_out_426091.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_14 = math.max(var_507_7, arg_504_1.talkMaxDuration)

			if var_507_6 <= arg_504_1.time_ and arg_504_1.time_ < var_507_6 + var_507_14 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_6) / var_507_14

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_6 + var_507_14 and arg_504_1.time_ < var_507_6 + var_507_14 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_504_1:InitPlayNodeList()
	end,
	Play426091117 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 426091117
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play426091118(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(arg_508_1.actors_["6148ui_story"]) and arg_508_1.var_.characterEffect6148ui_story == nil then
				arg_508_1.var_.characterEffect6148ui_story = arg_508_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_0 = 0.200000002980232

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 and not isNil(arg_508_1.actors_["6148ui_story"]) then
				if arg_508_1.var_.characterEffect6148ui_story and not isNil(arg_508_1.actors_["6148ui_story"]) then
					arg_508_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_508_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_508_1.time_ - 0) / var_511_0)
				end
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 and not isNil(arg_508_1.actors_["6148ui_story"]) and arg_508_1.var_.characterEffect6148ui_story then
				arg_508_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_508_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_511_1 = 0
			local var_511_2 = 0.55

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_3 = arg_508_1:FormatText(arg_508_1:GetWordFromCfg(426091117).content)

				arg_508_1.text_.text = var_511_3

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 22 <= 0 and var_511_2 or var_511_2 * (utf8.len(var_511_3) / 22)

				if (22 <= 0 and var_511_2 or var_511_2 * (utf8.len(var_511_3) / 22)) > 0 and var_511_2 < var_511_5 then
					arg_508_1.talkMaxDuration = var_511_5

					if var_511_5 + var_511_1 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_5 + var_511_1
					end
				end

				arg_508_1.text_.text = var_511_3
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_6 = math.max(var_511_2, arg_508_1.talkMaxDuration)

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_6 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_1) / var_511_6

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_1 + var_511_6 and arg_508_1.time_ < var_511_1 + var_511_6 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play426091118 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 426091118
		arg_512_1.duration_ = 8

		local var_512_0 = {
			zh = 8,
			ja = 6.766
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play426091119(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos6148ui_story = arg_512_1.actors_["6148ui_story"].transform.localPosition

				local var_515_0 = GameObjectTools.GetOrAddComponent(arg_512_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_515_0 then
					var_515_0:EnableDynamicBone(false)
				end
			end

			local var_515_1 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_1 then
				arg_512_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_512_1.time_ - 0) / var_515_1)
				arg_512_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_512_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["6148ui_story"].transform.position).z)
				arg_512_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_512_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_512_1.actors_["6148ui_story"].transform.localEulerAngles = arg_512_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_512_1.time_ >= 0 + var_515_1 and arg_512_1.time_ < 0 + var_515_1 + arg_515_0 then
				arg_512_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_512_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_512_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["6148ui_story"].transform.position).z)
				arg_512_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_512_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_512_1.actors_["6148ui_story"].transform.localEulerAngles = arg_512_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_515_2 = GameObjectTools.GetOrAddComponent(arg_512_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_515_2 then
					var_515_2:EnableDynamicBone(true)
				end
			end

			local var_515_3 = arg_512_1.actors_["6148ui_story"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_3) and arg_512_1.var_.characterEffect6148ui_story == nil then
				arg_512_1.var_.characterEffect6148ui_story = var_515_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_4 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_4 and not isNil(var_515_3) then
				if arg_512_1.var_.characterEffect6148ui_story and not isNil(var_515_3) then
					arg_512_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_512_1.time_ >= 0 + var_515_4 and arg_512_1.time_ < 0 + var_515_4 + arg_515_0 and not isNil(var_515_3) and arg_512_1.var_.characterEffect6148ui_story then
				arg_512_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action464")
			end

			local var_515_6 = 0
			local var_515_7 = 0.925

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_6 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_8 = arg_512_1:GetWordFromCfg(426091118)
				local var_515_9 = arg_512_1:FormatText(var_515_8.content)

				arg_512_1.text_.text = var_515_9

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_11 = 37 <= 0 and var_515_7 or var_515_7 * (utf8.len(var_515_9) / 37)

				if (37 <= 0 and var_515_7 or var_515_7 * (utf8.len(var_515_9) / 37)) > 0 and var_515_7 < var_515_11 then
					arg_512_1.talkMaxDuration = var_515_11

					if var_515_11 + var_515_6 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_11 + var_515_6
					end
				end

				arg_512_1.text_.text = var_515_9
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091118", "story_v_out_426091.awb") ~= 0 then
					local var_515_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091118", "story_v_out_426091.awb") / 1000

					if var_515_12 + var_515_6 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_12 + var_515_6
					end

					if var_515_8.prefab_name ~= "" and arg_512_1.actors_[var_515_8.prefab_name] ~= nil then
						local var_515_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_8.prefab_name].transform, "story_v_out_426091", "426091118", "story_v_out_426091.awb")

						arg_512_1:RecordAudio("426091118", var_515_13)
						arg_512_1:RecordAudio("426091118", var_515_13)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_426091", "426091118", "story_v_out_426091.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_426091", "426091118", "story_v_out_426091.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_14 = math.max(var_515_7, arg_512_1.talkMaxDuration)

			if var_515_6 <= arg_512_1.time_ and arg_512_1.time_ < var_515_6 + var_515_14 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_6) / var_515_14

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_6 + var_515_14 and arg_512_1.time_ < var_515_6 + var_515_14 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091119 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 426091119
		arg_516_1.duration_ = 8.73

		local var_516_0 = {
			zh = 5.133,
			ja = 8.733
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play426091120(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0.525

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_1 = arg_516_1:GetWordFromCfg(426091119)
				local var_519_2 = arg_516_1:FormatText(var_519_1.content)

				arg_516_1.text_.text = var_519_2

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_4 = 21 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_2) / 21)

				if (21 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_2) / 21)) > 0 and var_519_0 < var_519_4 then
					arg_516_1.talkMaxDuration = var_519_4

					if var_519_4 + 0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_4 + 0
					end
				end

				arg_516_1.text_.text = var_519_2
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091119", "story_v_out_426091.awb") ~= 0 then
					local var_519_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091119", "story_v_out_426091.awb") / 1000

					if var_519_5 + 0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_5 + 0
					end

					if var_519_1.prefab_name ~= "" and arg_516_1.actors_[var_519_1.prefab_name] ~= nil then
						local var_519_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_1.prefab_name].transform, "story_v_out_426091", "426091119", "story_v_out_426091.awb")

						arg_516_1:RecordAudio("426091119", var_519_6)
						arg_516_1:RecordAudio("426091119", var_519_6)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_426091", "426091119", "story_v_out_426091.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_426091", "426091119", "story_v_out_426091.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_7 = math.max(var_519_0, arg_516_1.talkMaxDuration)

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_7 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - 0) / var_519_7

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= 0 + var_519_7 and arg_516_1.time_ < 0 + var_519_7 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play426091120 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 426091120
		arg_520_1.duration_ = 18.93

		local var_520_0 = {
			zh = 16.266,
			ja = 18.933
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play426091121(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 1.25

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_1 = arg_520_1:GetWordFromCfg(426091120)
				local var_523_2 = arg_520_1:FormatText(var_523_1.content)

				arg_520_1.text_.text = var_523_2

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_4 = 50 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 50)

				if (50 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 50)) > 0 and var_523_0 < var_523_4 then
					arg_520_1.talkMaxDuration = var_523_4

					if var_523_4 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_4 + 0
					end
				end

				arg_520_1.text_.text = var_523_2
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091120", "story_v_out_426091.awb") ~= 0 then
					local var_523_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091120", "story_v_out_426091.awb") / 1000

					if var_523_5 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_5 + 0
					end

					if var_523_1.prefab_name ~= "" and arg_520_1.actors_[var_523_1.prefab_name] ~= nil then
						local var_523_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_1.prefab_name].transform, "story_v_out_426091", "426091120", "story_v_out_426091.awb")

						arg_520_1:RecordAudio("426091120", var_523_6)
						arg_520_1:RecordAudio("426091120", var_523_6)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_426091", "426091120", "story_v_out_426091.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_426091", "426091120", "story_v_out_426091.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_7 = math.max(var_523_0, arg_520_1.talkMaxDuration)

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_7 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - 0) / var_523_7

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= 0 + var_523_7 and arg_520_1.time_ < 0 + var_523_7 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play426091121 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 426091121
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play426091122(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(arg_524_1.actors_["6148ui_story"]) and arg_524_1.var_.characterEffect6148ui_story == nil then
				arg_524_1.var_.characterEffect6148ui_story = arg_524_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_0 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 and not isNil(arg_524_1.actors_["6148ui_story"]) then
				if arg_524_1.var_.characterEffect6148ui_story and not isNil(arg_524_1.actors_["6148ui_story"]) then
					arg_524_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_524_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_524_1.time_ - 0) / var_527_0)
				end
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 and not isNil(arg_524_1.actors_["6148ui_story"]) and arg_524_1.var_.characterEffect6148ui_story then
				arg_524_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_524_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_527_1 = 0
			local var_527_2 = 0.45

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
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

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_3 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(426091121).content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 18 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 18)

				if (18 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 18)) > 0 and var_527_2 < var_527_5 then
					arg_524_1.talkMaxDuration = var_527_5

					if var_527_5 + var_527_1 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_5 + var_527_1
					end
				end

				arg_524_1.text_.text = var_527_3
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_6 = math.max(var_527_2, arg_524_1.talkMaxDuration)

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_6 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_1) / var_527_6

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_1 + var_527_6 and arg_524_1.time_ < var_527_1 + var_527_6 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play426091122 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 426091122
		arg_528_1.duration_ = 12.3

		local var_528_0 = {
			zh = 12.3,
			ja = 9.466
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
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play426091123(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.var_.moveOldPos6148ui_story = arg_528_1.actors_["6148ui_story"].transform.localPosition

				local var_531_0 = GameObjectTools.GetOrAddComponent(arg_528_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_531_0 then
					var_531_0:EnableDynamicBone(false)
				end
			end

			local var_531_1 = 0.001

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_1 then
				arg_528_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_528_1.time_ - 0) / var_531_1)
				arg_528_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_528_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["6148ui_story"].transform.position).z)
				arg_528_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_528_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_528_1.actors_["6148ui_story"].transform.localEulerAngles = arg_528_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_528_1.time_ >= 0 + var_531_1 and arg_528_1.time_ < 0 + var_531_1 + arg_531_0 then
				arg_528_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_528_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_528_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["6148ui_story"].transform.position).z)
				arg_528_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_528_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_528_1.actors_["6148ui_story"].transform.localEulerAngles = arg_528_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_531_2 = GameObjectTools.GetOrAddComponent(arg_528_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_531_2 then
					var_531_2:EnableDynamicBone(true)
				end
			end

			local var_531_3 = arg_528_1.actors_["6148ui_story"]

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(var_531_3) and arg_528_1.var_.characterEffect6148ui_story == nil then
				arg_528_1.var_.characterEffect6148ui_story = var_531_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_4 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 and not isNil(var_531_3) then
				if arg_528_1.var_.characterEffect6148ui_story and not isNil(var_531_3) then
					arg_528_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 and not isNil(var_531_3) and arg_528_1.var_.characterEffect6148ui_story then
				arg_528_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_531_6 = 0
			local var_531_7 = 0.925

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_6 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_8 = arg_528_1:GetWordFromCfg(426091122)
				local var_531_9 = arg_528_1:FormatText(var_531_8.content)

				arg_528_1.text_.text = var_531_9

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_11 = 37 <= 0 and var_531_7 or var_531_7 * (utf8.len(var_531_9) / 37)

				if (37 <= 0 and var_531_7 or var_531_7 * (utf8.len(var_531_9) / 37)) > 0 and var_531_7 < var_531_11 then
					arg_528_1.talkMaxDuration = var_531_11

					if var_531_11 + var_531_6 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_11 + var_531_6
					end
				end

				arg_528_1.text_.text = var_531_9
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091122", "story_v_out_426091.awb") ~= 0 then
					local var_531_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091122", "story_v_out_426091.awb") / 1000

					if var_531_12 + var_531_6 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_12 + var_531_6
					end

					if var_531_8.prefab_name ~= "" and arg_528_1.actors_[var_531_8.prefab_name] ~= nil then
						local var_531_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_8.prefab_name].transform, "story_v_out_426091", "426091122", "story_v_out_426091.awb")

						arg_528_1:RecordAudio("426091122", var_531_13)
						arg_528_1:RecordAudio("426091122", var_531_13)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_426091", "426091122", "story_v_out_426091.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_426091", "426091122", "story_v_out_426091.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_14 = math.max(var_531_7, arg_528_1.talkMaxDuration)

			if var_531_6 <= arg_528_1.time_ and arg_528_1.time_ < var_531_6 + var_531_14 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_6) / var_531_14

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_6 + var_531_14 and arg_528_1.time_ < var_531_6 + var_531_14 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play426091123 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 426091123
		arg_532_1.duration_ = 18.43

		local var_532_0 = {
			zh = 14.766,
			ja = 18.433
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play426091124(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 1.175

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_1 = arg_532_1:GetWordFromCfg(426091123)
				local var_535_2 = arg_532_1:FormatText(var_535_1.content)

				arg_532_1.text_.text = var_535_2

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 47 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 47)

				if (47 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 47)) > 0 and var_535_0 < var_535_4 then
					arg_532_1.talkMaxDuration = var_535_4

					if var_535_4 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_4 + 0
					end
				end

				arg_532_1.text_.text = var_535_2
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091123", "story_v_out_426091.awb") ~= 0 then
					local var_535_5 = manager.audio:GetVoiceLength("story_v_out_426091", "426091123", "story_v_out_426091.awb") / 1000

					if var_535_5 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + 0
					end

					if var_535_1.prefab_name ~= "" and arg_532_1.actors_[var_535_1.prefab_name] ~= nil then
						local var_535_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_1.prefab_name].transform, "story_v_out_426091", "426091123", "story_v_out_426091.awb")

						arg_532_1:RecordAudio("426091123", var_535_6)
						arg_532_1:RecordAudio("426091123", var_535_6)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_426091", "426091123", "story_v_out_426091.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_426091", "426091123", "story_v_out_426091.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_7 and arg_532_1.time_ < 0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play426091124 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 426091124
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play426091125(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(arg_536_1.actors_["6148ui_story"]) and arg_536_1.var_.characterEffect6148ui_story == nil then
				arg_536_1.var_.characterEffect6148ui_story = arg_536_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_0 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 and not isNil(arg_536_1.actors_["6148ui_story"]) then
				if arg_536_1.var_.characterEffect6148ui_story and not isNil(arg_536_1.actors_["6148ui_story"]) then
					arg_536_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_536_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_536_1.time_ - 0) / var_539_0)
				end
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 and not isNil(arg_536_1.actors_["6148ui_story"]) and arg_536_1.var_.characterEffect6148ui_story then
				arg_536_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_536_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_539_1 = 0
			local var_539_2 = 0.525

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_3 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(426091124).content)

				arg_536_1.text_.text = var_539_3

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_5 = 21 <= 0 and var_539_2 or var_539_2 * (utf8.len(var_539_3) / 21)

				if (21 <= 0 and var_539_2 or var_539_2 * (utf8.len(var_539_3) / 21)) > 0 and var_539_2 < var_539_5 then
					arg_536_1.talkMaxDuration = var_539_5

					if var_539_5 + var_539_1 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_5 + var_539_1
					end
				end

				arg_536_1.text_.text = var_539_3
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_6 = math.max(var_539_2, arg_536_1.talkMaxDuration)

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_6 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_1) / var_539_6

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_1 + var_539_6 and arg_536_1.time_ < var_539_1 + var_539_6 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play426091125 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 426091125
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play426091126(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.var_.moveOldPos6148ui_story = arg_540_1.actors_["6148ui_story"].transform.localPosition

				local var_543_0 = GameObjectTools.GetOrAddComponent(arg_540_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_543_0 then
					var_543_0:EnableDynamicBone(false)
				end
			end

			local var_543_1 = 0.001

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_1 then
				arg_540_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_540_1.time_ - 0) / var_543_1)
				arg_540_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_540_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["6148ui_story"].transform.position).z)
				arg_540_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_540_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_540_1.actors_["6148ui_story"].transform.localEulerAngles = arg_540_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_540_1.time_ >= 0 + var_543_1 and arg_540_1.time_ < 0 + var_543_1 + arg_543_0 then
				arg_540_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_540_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_540_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_540_1.actors_["6148ui_story"].transform.position).z)
				arg_540_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_540_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_540_1.actors_["6148ui_story"].transform.localEulerAngles = arg_540_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_543_2 = GameObjectTools.GetOrAddComponent(arg_540_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_543_2 then
					var_543_2:EnableDynamicBone(true)
				end
			end

			local var_543_3 = 0
			local var_543_4 = 0.7

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= var_543_3 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, false)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_5 = arg_540_1:FormatText(arg_540_1:GetWordFromCfg(426091125).content)

				arg_540_1.text_.text = var_543_5

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_7 = 28 <= 0 and var_543_4 or var_543_4 * (utf8.len(var_543_5) / 28)

				if (28 <= 0 and var_543_4 or var_543_4 * (utf8.len(var_543_5) / 28)) > 0 and var_543_4 < var_543_7 then
					arg_540_1.talkMaxDuration = var_543_7

					if var_543_7 + var_543_3 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_7 + var_543_3
					end
				end

				arg_540_1.text_.text = var_543_5
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_8 = math.max(var_543_4, arg_540_1.talkMaxDuration)

			if var_543_3 <= arg_540_1.time_ and arg_540_1.time_ < var_543_3 + var_543_8 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_3) / var_543_8

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_3 + var_543_8 and arg_540_1.time_ < var_543_3 + var_543_8 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_540_1:InitPlayNodeList()
	end,
	Play426091126 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 426091126
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play426091127(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0.475

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_1 = arg_544_1:FormatText(arg_544_1:GetWordFromCfg(426091126).content)

				arg_544_1.text_.text = var_547_1

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_3 = 19 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_1) / 19)

				if (19 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_1) / 19)) > 0 and var_547_0 < var_547_3 then
					arg_544_1.talkMaxDuration = var_547_3

					if var_547_3 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_3 + 0
					end
				end

				arg_544_1.text_.text = var_547_1
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_4 = math.max(var_547_0, arg_544_1.talkMaxDuration)

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_4 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - 0) / var_547_4

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= 0 + var_547_4 and arg_544_1.time_ < 0 + var_547_4 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play426091127 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 426091127
		arg_548_1.duration_ = 8.33

		local var_548_0 = {
			zh = 7.166,
			ja = 8.333
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play426091128(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.var_.moveOldPos6148ui_story = arg_548_1.actors_["6148ui_story"].transform.localPosition

				local var_551_0 = GameObjectTools.GetOrAddComponent(arg_548_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_551_0 then
					var_551_0:EnableDynamicBone(false)
				end
			end

			local var_551_1 = 0.001

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_1 then
				arg_548_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_548_1.time_ - 0) / var_551_1)
				arg_548_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_548_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["6148ui_story"].transform.position).z)
				arg_548_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_548_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_548_1.actors_["6148ui_story"].transform.localEulerAngles = arg_548_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_548_1.time_ >= 0 + var_551_1 and arg_548_1.time_ < 0 + var_551_1 + arg_551_0 then
				arg_548_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_548_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_548_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["6148ui_story"].transform.position).z)
				arg_548_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_548_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_548_1.actors_["6148ui_story"].transform.localEulerAngles = arg_548_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_551_2 = GameObjectTools.GetOrAddComponent(arg_548_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_551_2 then
					var_551_2:EnableDynamicBone(true)
				end
			end

			local var_551_3 = arg_548_1.actors_["6148ui_story"]

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 and not isNil(var_551_3) and arg_548_1.var_.characterEffect6148ui_story == nil then
				arg_548_1.var_.characterEffect6148ui_story = var_551_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_4 = 0.200000002980232

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_4 and not isNil(var_551_3) then
				if arg_548_1.var_.characterEffect6148ui_story and not isNil(var_551_3) then
					arg_548_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_548_1.time_ >= 0 + var_551_4 and arg_548_1.time_ < 0 + var_551_4 + arg_551_0 and not isNil(var_551_3) and arg_548_1.var_.characterEffect6148ui_story then
				arg_548_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_551_6 = 0
			local var_551_7 = 0.625

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_6 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_8 = arg_548_1:GetWordFromCfg(426091127)
				local var_551_9 = arg_548_1:FormatText(var_551_8.content)

				arg_548_1.text_.text = var_551_9

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_11 = 25 <= 0 and var_551_7 or var_551_7 * (utf8.len(var_551_9) / 25)

				if (25 <= 0 and var_551_7 or var_551_7 * (utf8.len(var_551_9) / 25)) > 0 and var_551_7 < var_551_11 then
					arg_548_1.talkMaxDuration = var_551_11

					if var_551_11 + var_551_6 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_11 + var_551_6
					end
				end

				arg_548_1.text_.text = var_551_9
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426091", "426091127", "story_v_out_426091.awb") ~= 0 then
					local var_551_12 = manager.audio:GetVoiceLength("story_v_out_426091", "426091127", "story_v_out_426091.awb") / 1000

					if var_551_12 + var_551_6 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_12 + var_551_6
					end

					if var_551_8.prefab_name ~= "" and arg_548_1.actors_[var_551_8.prefab_name] ~= nil then
						local var_551_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_8.prefab_name].transform, "story_v_out_426091", "426091127", "story_v_out_426091.awb")

						arg_548_1:RecordAudio("426091127", var_551_13)
						arg_548_1:RecordAudio("426091127", var_551_13)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_426091", "426091127", "story_v_out_426091.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_426091", "426091127", "story_v_out_426091.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_14 = math.max(var_551_7, arg_548_1.talkMaxDuration)

			if var_551_6 <= arg_548_1.time_ and arg_548_1.time_ < var_551_6 + var_551_14 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_6) / var_551_14

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_6 + var_551_14 and arg_548_1.time_ < var_551_6 + var_551_14 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_548_1:InitPlayNodeList()
	end,
	Play426091128 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 426091128
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
			arg_552_1.auto_ = false
		end

		function arg_552_1.playNext_(arg_554_0)
			arg_552_1.onStoryFinished_()
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 and not isNil(arg_552_1.actors_["6148ui_story"]) and arg_552_1.var_.characterEffect6148ui_story == nil then
				arg_552_1.var_.characterEffect6148ui_story = arg_552_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_555_0 = 0.200000002980232

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_0 and not isNil(arg_552_1.actors_["6148ui_story"]) then
				if arg_552_1.var_.characterEffect6148ui_story and not isNil(arg_552_1.actors_["6148ui_story"]) then
					arg_552_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_552_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_552_1.time_ - 0) / var_555_0)
				end
			end

			if arg_552_1.time_ >= 0 + var_555_0 and arg_552_1.time_ < 0 + var_555_0 + arg_555_0 and not isNil(arg_552_1.actors_["6148ui_story"]) and arg_552_1.var_.characterEffect6148ui_story then
				arg_552_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_552_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_555_1 = 0
			local var_555_2 = 0.55

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_1 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(426091128).content)

				arg_552_1.text_.text = var_555_3

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 22 <= 0 and var_555_2 or var_555_2 * (utf8.len(var_555_3) / 22)

				if (22 <= 0 and var_555_2 or var_555_2 * (utf8.len(var_555_3) / 22)) > 0 and var_555_2 < var_555_5 then
					arg_552_1.talkMaxDuration = var_555_5

					if var_555_5 + var_555_1 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + var_555_1
					end
				end

				arg_552_1.text_.text = var_555_3
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_6 = math.max(var_555_2, arg_552_1.talkMaxDuration)

			if var_555_1 <= arg_552_1.time_ and arg_552_1.time_ < var_555_1 + var_555_6 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_1) / var_555_6

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_1 + var_555_6 and arg_552_1.time_ < var_555_1 + var_555_6 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2012",
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/SS2602",
		"TextureConfig/Background/J27h",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_426091.awb"
	}
}
